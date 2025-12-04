Return-Path: <netdev+bounces-243567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA5CA3D32
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 205E930093B5
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F93446C8;
	Thu,  4 Dec 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMDtLmeH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk6XS2vq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875C34404D
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854563; cv=none; b=nM7c7TwjF9wDlTQ9zcW0cRZD7TUnTF+txdWr2MB50I/BuWzVeGjvcFA7OR2DPIxTS6H4zgW2gmuui3zURNqex9KmD5qXqS5wJmW6R5Jw53XQOiag75g7dUF1adAZTxSjp8l1/ZPGNwmbb3eRen8p15etRYzXCRwiM6cOiJ1Y/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854563; c=relaxed/simple;
	bh=p6/+ApJnwfba4k1TrRRW/+uqq9V/rWBlQi5mReLfscE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNjOz4zOM8V1JFf/jGMdY4dz/+hv1rxavCSTjpALC7qPLlNhT0rPlnJKW0LTnDl+bCl6qrqoaHmnrdHD1OY6Vmww43Pl4+R7TTtm55F/susEUV58Crn/Q0il0StQeDJqZJVXopI39hlku0TUiZ41PHIeOfGEtJYt0DvWCYq6BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMDtLmeH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bk6XS2vq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764854557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1HpQTqBCEM9Jo/PILkAjOlzSNTxFGaZGaXuMT2tMYU=;
	b=VMDtLmeHdyV0ogOrHmbSpqTH2Z5KKOwF0N2UDuyDWdZETHHZ6RP4HfXYuEMz+Jye6Cm4bh
	JCQY+nh15rjCAfJwkRSlSfr3jI3chg8Y9LpySzuNPFxnGPUujaJU+hS1gyyrDXAc8esHj4
	bpCBjrKd+vosZ3wyyljJXRqXlDe126Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-RY_2qCqkNCyYWIPnmHInrw-1; Thu, 04 Dec 2025 08:22:36 -0500
X-MC-Unique: RY_2qCqkNCyYWIPnmHInrw-1
X-Mimecast-MFC-AGG-ID: RY_2qCqkNCyYWIPnmHInrw_1764854555
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b763acb793fso115501066b.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 05:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764854555; x=1765459355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1HpQTqBCEM9Jo/PILkAjOlzSNTxFGaZGaXuMT2tMYU=;
        b=bk6XS2vqc2cUVkSOUmuSrlJCS1teAGYs8enWDvvcE9EtINscM434mf+IjvH+YfdYFL
         64T8OrNJyx+TiDT0XoxwC1Ng2tkSM6lfVlX5OXT2TUK1Uc4HPSbTakEL+B+RBnpkljxX
         1P4tK5rpKyRNyU9xgPhvBh7Pc3c5pa3BfMxJv6s/DhN7tXKZB9vVQhHi4gFn5ye/YQnv
         eQmWuE4rosCLyPzDdPBIfJ4R9aRv29MYw7eXTL2PtTh3TXa0XEfrGbJ+skfw2fBZ9mgd
         pky87MttkIuNKIGmekoNGexFa29HYjuTIUylCSHVgMCLDDEqUzhGfU3m1SmBhOYgn381
         MWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764854555; x=1765459355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1HpQTqBCEM9Jo/PILkAjOlzSNTxFGaZGaXuMT2tMYU=;
        b=NfQ3hBOHMp/xbzgFxyuuWvb83NKTd3vRJSTfxB1t7zVTVyVQOTwvOwLbkwfVAsU0WL
         2AVmiG2UjwP4Y2ifa0JYpOf+Cg4EIcEJdE90451PzyHeRdOuLjIl+4+FchIf7raglFI9
         B0jigQfs4XYuDVW7aydhhe6t4mYiCI1+d/pTCmXZar0ZVf+qufvs2TBUyrElTMz0XvBc
         LeA3AnlTnKBzPjaP2FPnPAmbfhb2qyFGclNRPsIL8BnivD0it6pW12jmU7OyodvqEfeB
         MVwJUihcjUT6cPOupih6ScgLRem0Q7n/CrH+qJnihlbDcIbIwGeBNuQVAB5uhsYjTZo/
         ZvLg==
X-Gm-Message-State: AOJu0YxKI+zrW0VrlDkgNBgzkPsrYqmAu4L8h8noIH4QJlRxGDy4KhJf
	y3lMQNMsDllrBxMZ7eCkTnjZZGfH2OfescjMZELsNJAJGBfgp7B0ImpSB7MjYgqdjM7f16NKMPu
	iDzxUYuaiRx8gUq5MdFlRVlDbA91nn/tVuA68AU+pxj6iPw3uXIsNKU8BXw==
X-Gm-Gg: ASbGncvnJAK+hkZcwH/YnMfS2OSuQroUdR8R6+MRi45lnwHvYdS6tw2IFqOxFadlyFj
	1VZTv/TpGdp4GRaJZhevbwiygqJ8f/bJeSbn9okWRhkwEpOqcgp1jE9F1bkar+8LlIEJPCwcX4l
	MJ+ZrSKkoxVcrjYUF7QyG0OuVfaYYw3Pk77aUPMqgM91Tds9p8t5n2BNqbGlF3PSkjoTNt+o8bn
	yWcxPd6t8saXSs8PCT7ap2btOfvdDmm8W3/ygKfaQsX10zI0bTzNsJqGjQ0Oytu8EQ5A091tRMt
	Xw7wO99Y0AnfCKKiLqzOBt+0ITT40B4+onLEVRYiOZ6CJ6jFgIGwH1mJlRiM35fY2253ADPnMU1
	jHIZDzCLqipvxgMTBxcx7epBqcXnMacWRvt2quuvzgx5kZzXQFFj2pHXRXWU=
X-Received: by 2002:a17:907:980a:b0:b72:a899:169f with SMTP id a640c23a62f3a-b79ec3f06c7mr319664566b.4.1764854554671;
        Thu, 04 Dec 2025 05:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+ImO+K7sztGH+TVT/gx/PiT6xPbzhNycSMjxDIO4bDauutpP38fU2RSjpHlfgtpOdhtGt8A==
X-Received: by 2002:a17:907:980a:b0:b72:a899:169f with SMTP id a640c23a62f3a-b79ec3f06c7mr319659966b.4.1764854554117;
        Thu, 04 Dec 2025 05:22:34 -0800 (PST)
Received: from [10.44.34.159] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4975b94sm132458566b.40.2025.12.04.05.22.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Dec 2025 05:22:33 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 Aaron Conole <aconole@redhat.com>, Willy Tarreau <w@1wt.eu>,
 LePremierHomme <kwqcheii@proton.me>, Junvy Yang <zhuque@tencent.com>
Subject: Re: [PATCH net] net: openvswitch: fix middle attribute validation in
 push_nsh() action
Date: Thu, 04 Dec 2025 14:22:32 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <65A94C49-E5B2-46FC-92CC-7BAA4F0B3E7E@redhat.com>
In-Reply-To: <eac68895-5450-41ca-a30e-2273b9787e86@ovn.org>
References: <20251204105334.900379-1-i.maximets@ovn.org>
 <9A785713-3692-43A7-BD08-652DC1248955@redhat.com>
 <eac68895-5450-41ca-a30e-2273b9787e86@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 4 Dec 2025, at 12:36, Ilya Maximets wrote:

> On 12/4/25 12:03 PM, Eelco Chaudron wrote:
>>
>>
>> On 4 Dec 2025, at 11:53, Ilya Maximets wrote:
>>
>>> The push_nsh() action structure looks like this:
>>>
>>>  OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...)=
)
>>>
>>> The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
>>> nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost=

>>> OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
>>> inside nsh_key_put_from_nlattr().  But nothing checks if the attribut=
e
>>> in the middle is OK.  We don't even check that this attribute is the
>>> OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data=
()
>>> calls - first time directly while calling validate_push_nsh() and the=

>>> second time as part of the nla_for_each_nested() macro, which isn't
>>> safe, potentially causing invalid memory access if the size of this
>>> attribute is incorrect.  The failure may not be noticed during
>>> validation due to larger netlink buffer, but cause trouble later duri=
ng
>>> action execution where the buffer is allocated exactly to the size:
>>>
>>>  BUG: KASAN: slab-out-of-bounds in nsh_hdr_from_nlattr+0x1dd/0x6a0 [o=
penvswitch]
>>>  Read of size 184 at addr ffff88816459a634 by task a.out/22624
>>>
>>>  CPU: 8 UID: 0 PID: 22624 6.18.0-rc7+ #115 PREEMPT(voluntary)
>>>  Call Trace:
>>>   <TASK>
>>>   dump_stack_lvl+0x51/0x70
>>>   print_address_description.constprop.0+0x2c/0x390
>>>   kasan_report+0xdd/0x110
>>>   kasan_check_range+0x35/0x1b0
>>>   __asan_memcpy+0x20/0x60
>>>   nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
>>>   push_nsh+0x82/0x120 [openvswitch]
>>>   do_execute_actions+0x1405/0x2840 [openvswitch]
>>>   ovs_execute_actions+0xd5/0x3b0 [openvswitch]
>>>   ovs_packet_cmd_execute+0x949/0xdb0 [openvswitch]
>>>   genl_family_rcv_msg_doit+0x1d6/0x2b0
>>>   genl_family_rcv_msg+0x336/0x580
>>>   genl_rcv_msg+0x9f/0x130
>>>   netlink_rcv_skb+0x11f/0x370
>>>   genl_rcv+0x24/0x40
>>>   netlink_unicast+0x73e/0xaa0
>>>   netlink_sendmsg+0x744/0xbf0
>>>   __sys_sendto+0x3d6/0x450
>>>   do_syscall_64+0x79/0x2c0
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   </TASK>
>>>
>>> Let's add some checks that the attribute is properly sized and it's
>>> the only one attribute inside the action.  Technically, there is no
>>> real reason for OVS_KEY_ATTR_NSH to be there, as we know that we're
>>> pushing an NSH header already, it just creates extra nesting, but
>>> that's how uAPI works today.  So, keeping as it is.
>>>
>>> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
>>> Reported-by: Junvy Yang <zhuque@tencent.com>
>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>
>> Thanks, Ilya, for fixing this. One small nit about logging, but overal=
l it looks good to me.
>>
>> Acked-by: Eelco Chaudron echaudro@redhat.com
>>
>>> ---
>>>  net/openvswitch/flow_netlink.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_ne=
tlink.c
>>> index 1cb4f97335d8..2d536901309e 100644
>>> --- a/net/openvswitch/flow_netlink.c
>>> +++ b/net/openvswitch/flow_netlink.c
>>> @@ -2802,13 +2802,20 @@ static int validate_and_copy_set_tun(const st=
ruct nlattr *attr,
>>>  	return err;
>>>  }
>>>
>>> -static bool validate_push_nsh(const struct nlattr *attr, bool log)
>>> +static bool validate_push_nsh(const struct nlattr *a, bool log)
>>>  {
>>> +	struct nlattr *nsh_key =3D nla_data(a);
>>>  	struct sw_flow_match match;
>>>  	struct sw_flow_key key;
>>>
>>> +	/* There must be one and only one NSH header. */
>>> +	if (!nla_ok(nsh_key, nla_len(a)) ||
>>> +	    nla_total_size(nla_len(nsh_key)) !=3D nla_len(a) ||
>>> +	    nla_type(nsh_key) !=3D OVS_KEY_ATTR_NSH)
>>
>> Should we consider adding some logging based on the log flag here? Not=
 a blocker,
>> just noticed that nsh_key_put_from_nlattr() logs similar validation ca=
ses and
>> wondered if we want the same consistency.
>
> Our logging is not really consistent, we do not log in the same case fo=
r the
> validate_set(), for example.  And I'm not sure if the log here would be=
 useful
> as it is very unlikely we can hit this condition without manually craft=
ing the
> attribute to be wrong.  We'll have a log later about garbage trailing d=
ata,
> which should prompt a user to look at what they are sending down.
>
> In general, we should convert all the logging here into extack, as logs=
 are
> very inconvenient and not specific enough in most cases.
>
> But I can add something like this, if needed:
>
>   OVS_NLERR(log, "push_nsh: Expected a single NSH header");
>
> What do you think?

Reading your feedback, I=E2=80=99m fine with leaving it as is.

//Eelco


