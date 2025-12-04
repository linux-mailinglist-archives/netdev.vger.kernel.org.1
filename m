Return-Path: <netdev+bounces-243546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56CCA35EB
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B788C302DF03
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306133ADB0;
	Thu,  4 Dec 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8lt5wH8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="anF5jsqo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3ED33ADB3
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846195; cv=none; b=WfZyTo2wEuugAV1i9vTZDod506TchCS2D4z2uZ/OWK6BmobCVFQE+RgqFOD5ONT+0QboLZj7nNvRubIPIevySwaAPDn813x1jUvJ/YzbJurORjsM4T6H+ut+kk7/idq0p2ZoaTGewOwdmts+y5fL4nrTe6dnRaMiizxzn7xrE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846195; c=relaxed/simple;
	bh=cOXtAWclGwX/6Sj4XQucMOTvC+r//kQ9ROAgC62k/aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fx6ntJJ60rWZCFe6DltsYzd3yYmzvy6Fv3nTV5AjIx52mAIWMbsGZyBbIYf/vO77qTpr7n64wXqlkQWUUpto/S7nJqAnWSl1ZFmWYpQAmdHZmhR7G2fW1GW+nqo9gpoXT1dbSqD/FJWTczI5FxZododcZW4keGnaZqMXDngHIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8lt5wH8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=anF5jsqo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764846192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70j8pvuMZEZeUo7KtAVjd5X5QakgOe4UFDMzeKIMIv0=;
	b=U8lt5wH8dIlOpf2N8+8/aNZADde22sU7YxG2mvElQwRH8jY8QRO0aEtTbW2+mXaZUE2Bkn
	//FF4tzITmy41uaVozQ4KdWrJXxspWghfMFzDpejPMGYv9kssDUVoJkC54hTtRdlmrfU6N
	dElnq3vKO48/Y/uX00lSIWZ1L1Ffq6I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-lDPiISdzP8-wiq7xzDWYcg-1; Thu, 04 Dec 2025 06:03:11 -0500
X-MC-Unique: lDPiISdzP8-wiq7xzDWYcg-1
X-Mimecast-MFC-AGG-ID: lDPiISdzP8-wiq7xzDWYcg_1764846190
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70b2a89c22so92776966b.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764846190; x=1765450990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70j8pvuMZEZeUo7KtAVjd5X5QakgOe4UFDMzeKIMIv0=;
        b=anF5jsqoQcCGdWApto5n6JiKrZXKFUNYq23aXaoGljRmHknEbq+V1cClU/etMZS9BF
         b2RAnnSV5Qot07tSkfCehDzji1yAn8DIetVUGDdRvj+JTPsanVa7ADDKMEhNBwvTA89Q
         ySQ6/Ex7ALKvoEZhsRMEJey8LggSB8vOEln6Bae+62EFox99zdNYD7Qq8lnkaSmMbGhx
         CXALpr6V9HU2AOwFTTtz3ZfDkB9/P9nYpn932NZHWseQB4pv5DBS0s/+dH7bwC/IYa2E
         2KAplw0EncMy/pmK5k69H58hJ3JMNPPDngAuU5emoWOHr2fYorqDxOX2uAVV8CJbng3F
         zZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764846190; x=1765450990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70j8pvuMZEZeUo7KtAVjd5X5QakgOe4UFDMzeKIMIv0=;
        b=Sj+RbqPoCcDIxor060mi0x8yfcAWeyfnnwsyAILHlWHwXsf+cE0eqv0J2WHGSfzZ1I
         jfYoFUj5IWXhaRXaesQar/7qisJhV/2MXRFdtg71a11OAvy0lmFVMHqvvyqr8c/YLStM
         FIRnJNf/2UkgdqA/IG/Ky2Q6odiAGMfTZA2CDUxqD/oDypcX1Hx4zic8vJWn0bPPACH5
         2+LS/KRz1oX9r+ak9dH9UwZeN4HGaNnqVgMGwTlWwpHj0GMohxadY7GBhdjn/DRopTpl
         KGP705g49qGd1Z6QsTxRQJbXRCQVzAJ6ZrFlKckO57+NnNOBI+ERIj5lnvbvsahkCcna
         l62w==
X-Gm-Message-State: AOJu0YwqC7JbFdBd4Tm39xcVraoD8Ty7UyGxjMJKyKRyy92YXbEkkSSA
	GRb1eeWe7++JHzCaiZ94wXha7AcD4ug3qhKe5QpcDwtXy2h7Kt+8EhEpGziZTcvf4vm8Z/UKKtb
	KJH6bSGLOwU8PfzOODYp9ozzdIyDE9HCRXP+7fWBCrf1xYbLTRxZdQNazVw==
X-Gm-Gg: ASbGncu1JGbwALAhCkjHJXBkHGExTBP9EI0GSncpHv+AUJLewBQebT16TzsAhG6p/EM
	vLWqF4rpSiWuDhKlfThWuVCJDQGwhrjFXPn9fom9cxR69RkIbUwlLJAmB3UGaOQBP+coiSsTaiL
	6KAaXgp4Sq05gHOTWmlW/XD1XMv2044SLe32itPuiTApxQU2g8Hnugoth6jY/m8CBJyo/i3melU
	Os0YTmfsRSehoMdd0B1PYNqjzwWdq7/dmHkXyZ87w3uYNYwZntufNGuO1j4Zz7Ar7ejogxkT4oE
	dB+F8X+TU+nuXxD6VwtEBa4W86CsIcGTlVLecouG1eGTc7b9WlHs+MZhIQ/8K+aicGy3n/k8n1a
	tjxVDJV9SWeubf200QiEBHLfjcbxrsagiAfQC3uLeZ50H3ptdv7Wfj/2ylkI=
X-Received: by 2002:a17:907:3cca:b0:b76:3d56:f666 with SMTP id a640c23a62f3a-b79eb664b23mr270832366b.26.1764846189921;
        Thu, 04 Dec 2025 03:03:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPaODfsk49NyfVOUiYd/9voef05FvotBGpp+As78DcKPlz7kAIGtOqXOSFQPF9UJHC+jWmyQ==
X-Received: by 2002:a17:907:3cca:b0:b76:3d56:f666 with SMTP id a640c23a62f3a-b79eb664b23mr270828466b.26.1764846189471;
        Thu, 04 Dec 2025 03:03:09 -0800 (PST)
Received: from [10.44.34.159] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f449d181sm109384466b.26.2025.12.04.03.03.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Dec 2025 03:03:08 -0800 (PST)
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
Date: Thu, 04 Dec 2025 12:03:07 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <9A785713-3692-43A7-BD08-652DC1248955@redhat.com>
In-Reply-To: <20251204105334.900379-1-i.maximets@ovn.org>
References: <20251204105334.900379-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 4 Dec 2025, at 11:53, Ilya Maximets wrote:

> The push_nsh() action structure looks like this:
>
>  OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...))
>
> The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
> nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost
> OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
> inside nsh_key_put_from_nlattr().  But nothing checks if the attribute
> in the middle is OK.  We don't even check that this attribute is the
> OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data()=

> calls - first time directly while calling validate_push_nsh() and the
> second time as part of the nla_for_each_nested() macro, which isn't
> safe, potentially causing invalid memory access if the size of this
> attribute is incorrect.  The failure may not be noticed during
> validation due to larger netlink buffer, but cause trouble later during=

> action execution where the buffer is allocated exactly to the size:
>
>  BUG: KASAN: slab-out-of-bounds in nsh_hdr_from_nlattr+0x1dd/0x6a0 [ope=
nvswitch]
>  Read of size 184 at addr ffff88816459a634 by task a.out/22624
>
>  CPU: 8 UID: 0 PID: 22624 6.18.0-rc7+ #115 PREEMPT(voluntary)
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x51/0x70
>   print_address_description.constprop.0+0x2c/0x390
>   kasan_report+0xdd/0x110
>   kasan_check_range+0x35/0x1b0
>   __asan_memcpy+0x20/0x60
>   nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
>   push_nsh+0x82/0x120 [openvswitch]
>   do_execute_actions+0x1405/0x2840 [openvswitch]
>   ovs_execute_actions+0xd5/0x3b0 [openvswitch]
>   ovs_packet_cmd_execute+0x949/0xdb0 [openvswitch]
>   genl_family_rcv_msg_doit+0x1d6/0x2b0
>   genl_family_rcv_msg+0x336/0x580
>   genl_rcv_msg+0x9f/0x130
>   netlink_rcv_skb+0x11f/0x370
>   genl_rcv+0x24/0x40
>   netlink_unicast+0x73e/0xaa0
>   netlink_sendmsg+0x744/0xbf0
>   __sys_sendto+0x3d6/0x450
>   do_syscall_64+0x79/0x2c0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>
> Let's add some checks that the attribute is properly sized and it's
> the only one attribute inside the action.  Technically, there is no
> real reason for OVS_KEY_ATTR_NSH to be there, as we know that we're
> pushing an NSH header already, it just creates extra nesting, but
> that's how uAPI works today.  So, keeping as it is.
>
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Reported-by: Junvy Yang <zhuque@tencent.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks, Ilya, for fixing this. One small nit about logging, but overall i=
t looks good to me.

Acked-by: Eelco Chaudron echaudro@redhat.com

> ---
>  net/openvswitch/flow_netlink.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netl=
ink.c
> index 1cb4f97335d8..2d536901309e 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2802,13 +2802,20 @@ static int validate_and_copy_set_tun(const stru=
ct nlattr *attr,
>  	return err;
>  }
>
> -static bool validate_push_nsh(const struct nlattr *attr, bool log)
> +static bool validate_push_nsh(const struct nlattr *a, bool log)
>  {
> +	struct nlattr *nsh_key =3D nla_data(a);
>  	struct sw_flow_match match;
>  	struct sw_flow_key key;
>
> +	/* There must be one and only one NSH header. */
> +	if (!nla_ok(nsh_key, nla_len(a)) ||
> +	    nla_total_size(nla_len(nsh_key)) !=3D nla_len(a) ||
> +	    nla_type(nsh_key) !=3D OVS_KEY_ATTR_NSH)

Should we consider adding some logging based on the log flag here? Not a =
blocker, just noticed that nsh_key_put_from_nlattr() logs similar validat=
ion cases and wondered if we want the same consistency.

> +		return false;
> +
>  	ovs_match_init(&match, &key, true, NULL);
> -	return !nsh_key_put_from_nlattr(attr, &match, false, true, log);
> +	return !nsh_key_put_from_nlattr(nsh_key, &match, false, true, log);
>  }
>
>  /* Return false if there are any non-masked bits set.
> @@ -3389,7 +3396,7 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
>  					return -EINVAL;
>  			}
>  			mac_proto =3D MAC_PROTO_NONE;
> -			if (!validate_push_nsh(nla_data(a), log))
> +			if (!validate_push_nsh(a, log))
>  				return -EINVAL;
>  			break;
>
> -- =

> 2.51.1


