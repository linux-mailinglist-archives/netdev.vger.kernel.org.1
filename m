Return-Path: <netdev+bounces-289486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOeHJ1F3DGqihwUAu9opvQ
	(envelope-from <netdev+bounces-289486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:44:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2405580C21
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57D843009B23
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA74DBD64;
	Tue, 19 May 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYHtko8E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5584175A69
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201566; cv=none; b=CKU6HafAvZu+6lAps3kz0BLuId7L5Uey+LJNjXPvEfQtvJ97yqRrSbhe5kVB9ArQH84CLpHjPBFRnMXS9dmaRP0oK5Opi+VNsg1c1jJDLMwsJZHN583mzDMAzZtkoOvVizrM8vJiV2yp3MALtJ/cJdFBuAQ+Kg3URuPMosE5Hnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201566; c=relaxed/simple;
	bh=d1DIoaTEuZ8M2p/xgHLQOKHjVrht1lr0pEoPccd289w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrtGkuwkOZn7DrsTO2BYF93Y8pesEAeMr3yJO1ffmcqWMV730X9iT2h+9HYylbucl8eivs38I3aP/8F4RdJ+mDT56g5/To/jt6untanB/8Fe0j0Lb77zazMiGBjNhwxJ7C2cOC9b8rPWnTv2W5vtSPxSRXBfacBT9l0IGggaWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYHtko8E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso37377885e9.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201563; x=1779806363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaQ1LANqYeDKrBgD/EetKoYn1SmTm1mbAj7cklY2NLs=;
        b=lYHtko8Ej60SF/cJ7xCQk9o8eRMSqN9MjI7xbbActTQhgQGFpu4QjzCQ1zTP/wKe1H
         NEO9/W34ScoIMctkPm0hn3rYxHV2Bm8zwWy4grJHGKNZWR0XDdyEa6GnImT8l3oqhg0T
         wPTSux9FVcMDme++wkbsbE/mXSIu6wvHWuKYdDExLJ3o8D2N7IRZ7m7f3cniWPYXCMCv
         MfubyGrMrEbG0VQAeBiqdppWJ9eSe60EMolIhudnxYzYWcZyRSyZrz7a+Nm79W5DmcWJ
         7O71MkOc8w8mAZLcqMRSYCyZCT9CemLOr7j5J9XoPZYKOyH4f9Qa5DxJrJmwzPXah//y
         hSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201563; x=1779806363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaQ1LANqYeDKrBgD/EetKoYn1SmTm1mbAj7cklY2NLs=;
        b=g7O7aIJpffJMecgdl4eJtsIEQJOY8Htb6ESoxzJ8lpwZYUoGR293c5Zmtfo7SPtR+1
         M/2ayzhh1nuj5GkOZYfdzbdUj7PhOU0hzwBkV/nsHxZDPWTW4tbyG6XwSsQE8EaqzuAM
         vPovDbmGZgieV7E0VfKJnw4lImCcNOnw/g/aIqgaPNoTQopAuWJkly6as2WiEQyi9dj0
         rOfDTSJQYJKod9ylTZz8irtSWz55xUpgO/1FnPj++/nx0KKefJn7R4DY9s8gBIGEc3HD
         R9CK0w4BCvKnnWcUOaWY8JtHI9WfxQb/Huzb4TkOWekLLkxK7ZFsuAA0sTxTSnTKzTvo
         4nZA==
X-Forwarded-Encrypted: i=1; AFNElJ8QqU0WX2TtJ5byLhCVjL+OidbnqpxBee18ycU8qyoaG8cagRC1HUTDuttv+Jx/2sHtyCGRsvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBIDilGgAYtPLzt4PxWgPCofREUnI0f6YiaS8viHjW2n/QXRA
	DinK6iSht+BpfFoY3FeNUTJWG99gNUaKYtHbRlmsoVbxzXl+iS5+H2Zp
X-Gm-Gg: Acq92OF0dE7GqmBjBGJUAPGY+fuilF/bE3H1FNxtdBQSLULizbuuKFippA12ULRmzVn
	oehV7x9NBvWVIqFRLErV07pjiVPDAmf+bre4alpgM/bgAxkiXNoXfY551aHaZAbEVHAJ/NIZ8C1
	8W9pa0Hli4UlrfGYYd3GVqymiB2XMDuBmTh2OL6RlovUp4awDPalQt+W3aM/jAavvKciPF2qniX
	VK8/fsIMLf8lf4feXxRcjh8O8GbguxQC9s2gXJ5U4hpXjxl1gyU0K4q3b6lYVDDvIar5jgsPGT9
	6PrSWcrm1bZZZNHKJ3D8AFqNZKVHHKN5fuVN8ORS3wFnq1CQlfAx1MLtCVrrOOufwePubCQKOkr
	S8vuCyI0cLVeVmWK57G1mrmTMbOkFXcPMYwKYR+bMJEIbHY+jVOPaxZdvw4OnKnBPzDe6BS1Od1
	FYDNq5dKCYfGCrVF2FN+gOM7FC2eyo4JxVLOsseMLXAKSlHuzbwqT0r3CQdmBoTVTyw6tg5GtLu
	GP/66+BnAgHY6ZVBi1n/UALMwY+BsdjzIt61hyBqvdTYxb87g4ee2a3zUWSBivm84Z9ciKnKaey
	7g==
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48fe5388407mr288409105e9.12.1779201562537;
        Tue, 19 May 2026 07:39:22 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm559719625e9.1.2026.05.19.07.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:39:21 -0700 (PDT)
Message-ID: <743e314d-abfd-4a03-a74e-33a57c0bf6b8@gmail.com>
Date: Tue, 19 May 2026 15:39:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: gro: don't copy frags between mixed zcopy skbs
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Huzaifa Sidhpurwala <huzaifas@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
References: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289486-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Queue-Id: F2405580C21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 13:40, Sabrina Dubroca wrote:
> skb_gro_receive() can currently copy frags between the source and GRO
> skb, without checking the zerocopy status, and in particular the
> SKBFL_MANAGED_FRAG_REFS flag.
> 
> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> on the pages in shinfo->frags. Appending those frags to another skb's
> frags without fixing up the page refcount can lead to UAF.
> 
> When either the last skb in the GRO chain (the one we would append
> frags to) or the source skb is zerocopy, skip the frags copy, and just
> append the new skb to the frag_list.

Was it reproduced? Sounds like we're missing skb_orphan_frags_rx()
as skbs looping into rx should be orphaned.

+cc Willem

> This is probably a bit less efficient than calling
> skb_zcopy_downgrade_managed(), but then we'd also have to handle the
> rest of the zerocopy flags/machinery. This can be improved in
> net-next.
> 
> Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
> Assisted-by: Claude:claude-mythos-preview
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>   net/core/gro.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> Huzaifa has found this to be exploitable to overwrite the page cache
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a..cae0a0dbfa69 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -123,6 +123,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	lp = NAPI_GRO_CB(p)->last;
>   	pinfo = skb_shinfo(lp);
>   
> +	if (skb_zcopy(skb) || skb_zcopy(lp))
> +		goto merge;
> +
>   	if (headlen <= offset) {
>   		skb_frag_t *frag;
>   		skb_frag_t *frag2;

-- 
Pavel Begunkov


