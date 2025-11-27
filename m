Return-Path: <netdev+bounces-242369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3EC8FD31
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 18:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113613AD150
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679FD2F6909;
	Thu, 27 Nov 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO6Uiu/m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rcquEUCf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F82F60CA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266309; cv=none; b=kLYTQEoYOq5KGypKNqKs3wjdTLJTXrS3ivd2OitgQoO4oSQEEPlEvSeRFRNeiJJrWYL1+Q9mb/zPn/3WOfBEqlhnoPqTgau2SqyFkJflxZefHGY0TJcJ8e5F5v6hEtf9Vh0BgqKFu9ehnKHBnuDIysmMzrx3ZSbebWeYO8am9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266309; c=relaxed/simple;
	bh=TPEliOZDbEMTucSchU26H1mgBRnCr+iif0iy/Krl6TE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=jFiPk34iLFGaRvu5PjFvpji9tBjDu4e2FOZ5RgxMSOXbfFgTBmLS1jOgL6nG0rr16Na2daLDmupjQaA5PLPDT+l8gRP1RDLwzjHBHMWmmDfSiLnTm1rIFoiAn+/PWXLOeLO8jTeiCv8KJcbIYFycjlrLxvkcj0gDE2d0syUWkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SO6Uiu/m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rcquEUCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764266306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DY2OZoOg2Jn10jb874/Zht9ZmafIol/m0aMFjx0QUms=;
	b=SO6Uiu/mJ+V8yxYH4ytu6endZgpCSVIzBV2Yqsiedu5MDNsNvx1foLso/PdcnLgUaueWfS
	D0k2/k6XIWFS9vKu7Oss1noZ4yANucyo4WoUqnfr02RMvG/s9UY77/NYRH+uJztoAfH8jX
	wwWhvw6Tu9aAC/LxYeBsjA1Bu9DcxLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-VCUkL7RgP1a1Q5Gtvmvd-w-1; Thu, 27 Nov 2025 12:58:23 -0500
X-MC-Unique: VCUkL7RgP1a1Q5Gtvmvd-w-1
X-Mimecast-MFC-AGG-ID: VCUkL7RgP1a1Q5Gtvmvd-w_1764266302
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso681465f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764266302; x=1764871102; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY2OZoOg2Jn10jb874/Zht9ZmafIol/m0aMFjx0QUms=;
        b=rcquEUCfROmwhFDdhqn8XS+VDCZkL0P9VH9X2ss4CYngPcPIJiAISEDh52TBDCY4B8
         NV/leAJDoAjgQJd+dRpu7SeYt19H2nyVF8pTb/x07Jp/ZcDLeLcgIeUggRFbDea50N/U
         PavDwtYrtOCc/yyRbyE4qCkZMnao1YSfd2mJkyfo5JSIuW9J+FgpJAnNumB10aIeIIsT
         p01fyiLQb19SaO5PjVUIelU0UCUkgQtqklILyUxTp28k9v26tUdY6UiWh6QdcczCM2i9
         ERsK98vJRzUZ99Et834S/SxXnNvHJw3GejURDZwxebka7/2nyW82Yzd2lLNubzAM5/iK
         TSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764266302; x=1764871102;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DY2OZoOg2Jn10jb874/Zht9ZmafIol/m0aMFjx0QUms=;
        b=H9nvSJXuKOUfLNRnk8vZwM80ParVMXB9NB0ViOBWTuTyu833u0mLpLSZMzsehHKH+h
         lwA5anmf8oHPH9kkuB9pBGWhUslkBScIdUkMHdBkuulhsimCyDunMV8MN8mjBeailzHB
         Y3NuGaPX6Hf7d6tyOz+uxzs+ZomM8osC1ejxN5UJMuZGR30L/Gj21m4XnbskGlHRuFfT
         /3g3wNOYN/XlxwueS/DlfPq+SDRZ9+LGT5VSaKeMyIxKKGWDlGj1m/apd9dOcFe7hufV
         MhCHZlAKtBHFbYCS1TglASopYNcOXPKPDI95z6v6AVzXbwRXo+0cWWeJ0wbW7idq48xi
         SLRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWBtRSwtGcyUiE5BVW2vEFsJjxOU47wzQMUqj9KElKDP5ra1hwxh6gAnBlgGf2/w/izdyy1wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//8g2l6ezcNY0vWSZ/uGi03Bu8/+yOWjbFuPmdhEbLaYRxoOj
	dZj9J1YLZcEm3kbzfBC961sycm/NA/CjOgAT7Vrd36mpoq1JW66HP6ofphL9ZVeBfZJ+pd6fVwu
	LsmnBUiyJStEIMyArvMUbYTIxBPGClcXY8FwVLhbc72l7e+lgKgXQbY/Mmg==
X-Gm-Gg: ASbGncuDvNG/NPVKCcNPKhlkhj1HXClcpPL9FcWey37ogOrCMXG4uOMRfXDhVYCCohU
	vghweHT5g9Ce1VBeqHtKzGjMctpx8MgB/AKd5Jmp9d7SkgBC7W0zKTEQv5uooDbmHQ/+j4sgx6c
	UNK03qYnrKx+XBjU+ksue+umbzL8N2Sc5ndAIKa+LkWynZo7XBeIGZJG6kGyamrdTe1fvjARl0l
	ZkHS0Wij33GAArKgHCqa33htwJs5j1Rnevj7OL22Xa3tNNc7C7lMbRQ+eKCe75JjLN5KH1jQYvL
	ukxbI6thf+b2t63uh3eHKg+UoubT0RKgtcH6g5AGgJVu2idSqeICZ/T5HD7nzpanD3e7IfDPFkW
	4PyVXLG1TbdrmUw==
X-Received: by 2002:a05:6000:2506:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42e0f213901mr12126302f8f.17.1764266301753;
        Thu, 27 Nov 2025 09:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLRSA4nZtw3RbOLioK1qcRhOZy0uuInbULKsyGs0r8xbhY31cwWTMcCnjCEwBSM0N/0WJA6A==
X-Received: by 2002:a05:6000:2506:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42e0f213901mr12126275f8f.17.1764266301322;
        Thu, 27 Nov 2025 09:58:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caa767dsm4882115f8f.38.2025.11.27.09.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 09:58:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------YlcUvmJr0yf8fUFaZ0Spby8F"
Message-ID: <f8d6dbe0-b213-4990-a8af-2f95d25d21be@redhat.com>
Date: Thu, 27 Nov 2025 18:58:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125115754.46793-1-kerneljasonxing@gmail.com>
 <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com>
 <CAL+tcoDdntkJ8SFaqjPvkJoCDwiitqsCNeFUq7CYa_fajPQL4A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoDdntkJ8SFaqjPvkJoCDwiitqsCNeFUq7CYa_fajPQL4A@mail.gmail.com>

This is a multi-part message in MIME format.
--------------YlcUvmJr0yf8fUFaZ0Spby8F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/27/25 1:49 PM, Jason Xing wrote:
> On Thu, Nov 27, 2025 at 8:02 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/25/25 12:57 PM, Jason Xing wrote:
>>> This patch also removes total ~4% consumption which can be observed
>>> by perf:
>>> |--2.97%--validate_xmit_skb
>>> |          |
>>> |           --1.76%--netif_skb_features
>>> |                     |
>>> |                      --0.65%--skb_network_protocol
>>> |
>>> |--1.06%--validate_xmit_xfrm
>>>
>>> The above result has been verfied on different NICs, like I40E. I
>>> managed to see the number is going up by 4%.
>>
>> I must admit this delta is surprising, and does not fit my experience in
>> slightly different scenarios with the plain UDP TX path.
> 
> My take is that when the path is extremely hot, even the mathematics
> calculation could cause unexpected overhead. You can see the pps is
> now over 2,000,000. The reason why I say this is because I've done a
> few similar tests to verify this thought.

Uhm... 2M is not that huge. Prior to the H/W vulnerability fallout
(spectre and friends) reasonable good H/W (2016 old) could do ~2Mpps
with a single plain UDP socket.

Also validate_xmit_xfrm() should be basically a no-op, possibly some bad
luck with icache?

Could you please try the attached patch instead?

Should not be as good as skipping the whole validation but should give
some measurable gain.
>>> [1] - analysis of the validate_xmit_skb()
>>> 1. validate_xmit_unreadable_skb()
>>>    xsk doesn't initialize skb->unreadable, so the function will not free
>>>    the skb.
>>> 2. validate_xmit_vlan()
>>>    xsk also doesn't initialize skb->vlan_all.
>>> 3. sk_validate_xmit_skb()
>>>    skb from xsk_build_skb() doesn't have either sk_validate_xmit_skb or
>>>    sk_state, so the skb will not be validated.
>>> 4. netif_needs_gso()
>>>    af_xdp doesn't support gso/tso.
>>> 5. skb_needs_linearize() && __skb_linearize()
>>>    skb doesn't have frag_list as always, so skb_has_frag_list() returns
>>>    false. In copy mode, skb can put more data in the frags[] that can be
>>>    found in xsk_build_skb_zerocopy().
>>
>> I'm not sure  parse this last sentence correctly, could you please
>> re-phrase?
>>
>> I read it as as the xsk xmit path could build skb with nr_frags > 0.
>> That in turn will need validation from
>> validate_xmit_skb()/skb_needs_linearize() depending on the egress device
>> (lack of NETIF_F_SG), regardless of any other offload required.
> 
> There are two paths where the allocation of frags happen:
> 1) xsk_build_skb() -> xsk_build_skb_zerocopy() -> skb_fill_page_desc()
> -> shinfo->frags[i]
> 2) xsk_build_skb() -> skb_add_rx_frag() -> ... -> shinfo->frags[i]
> 
> Neither of them touch skb->frag_list, which means frag_list is NULL.
> IIUC, there is no place where frag_list is used (which actually I
> tested). we can see skb_needs_linearize() needs to check
> skb_has_frag_list() first, so it will not proceed after seeing it
> return false.
https://elixir.bootlin.com/linux/v6.18-rc7/source/include/linux/skbuff.h#L4322

return skb_is_nonlinear(skb) &&
	       ((skb_has_frag_list(skb) && !(features & NETIF_F_FRAGLIST)) ||
		(skb_shinfo(skb)->nr_frags && !(features & NETIF_F_SG)));

can return true even if `!skb_has_frag_list(skb)`.

I think you still need to call validate_xmit_skb()

/P


--------------YlcUvmJr0yf8fUFaZ0Spby8F
Content-Type: text/x-patch; charset=UTF-8; name="sec_path.patch"
Content-Disposition: attachment; filename="sec_path.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMKaW5kZXggOTA5
NGMwZmI4YzY4Li4zOTUxNmE1NzY2ZTUgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL2Rldi5jCisr
KyBiL25ldC9jb3JlL2Rldi5jCkBAIC00MDMwLDcgKzQwMzAsOCBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnZhbGlkYXRlX3htaXRfc2tiKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVj
dCBuZXRfZGV2aWNlCiAJCX0KIAl9CiAKLQlza2IgPSB2YWxpZGF0ZV94bWl0X3hmcm0oc2ti
LCBmZWF0dXJlcywgYWdhaW4pOworCWlmIChza2Jfc2VjX3BhdGgoc2tiKQorCQlza2IgPSB2
YWxpZGF0ZV94bWl0X3hmcm0oc2tiLCBmZWF0dXJlcywgYWdhaW4pOwogCiAJcmV0dXJuIHNr
YjsKIAo=

--------------YlcUvmJr0yf8fUFaZ0Spby8F--


