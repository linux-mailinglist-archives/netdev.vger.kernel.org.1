Return-Path: <netdev+bounces-282762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKgkAw4w82m0yAEAu9opvQ
	(envelope-from <netdev+bounces-282762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:33:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DE4A0E0A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F7523019F16
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED4337FF5B;
	Thu, 30 Apr 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z888PKGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560A3822A4
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545145; cv=none; b=lHgkvrfyIs0DSlOfCDNv2ZiQFc9HQIQvt6uEAYnMXw9qtuLnqeWwq05eiSTYnKowiMVvO+DCGD6df09ZHfaNyy+DVZ1vYTXqB7IoymsKjmkMveD5kRtXdscfgaJCcx8vM63dWREef0w5BsNpfKV6elr6QRfK9aUw56+UFWdYg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545145; c=relaxed/simple;
	bh=7GIoZQpII0CyFeLA/DgpC+EXxwGcnlMsXtlB+pHIe4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUGkPuhZbMY2+s+e5CQ6Yk8wPr/Z13IToGvJmoBig3JCK3nQtuueLOdEjEWsc3Bbms/9J+k/fIM6Us/MU/k66rQHom9AfZkfo/WqzBzp61Pjkdl2m9DotiN0prb1Z+HuWwhpSoXERzirlRiTsD1+F1dL3wMiTYtNYRG8KIbnHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z888PKGK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso92946d6.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777545142; x=1778149942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riHCeEKv9JBqgVZavmNjnLcf0Ylg7fMRVgWiYHUs0oE=;
        b=Z888PKGKodCwuVCaPXL9Z0UvbQF3kUYKBo0Xvlu0y2nPBdH3YTUMuEzTUy4Lhre7Ef
         V6fafZsAosIYkSCXpoXx3CDdePyUny/swyZw4g4B1c3m0fz2XVtulOYGvteE8vYldTm+
         X01iyNo8ykR0/H6yx8OXDlFjOyBku0YROeGZk9v37ZsXehLYyUFw/By4hA0JDkjtA+Q+
         B2eqH6IKDveBTICMYWtsX1PqHRq6lVCwDkBexAdZas0l94X/rJYVSmPe53UKGTzG0uvI
         9tmd7wuIeTqgiJJ7ljzH/UgWEBiA5WaFt6yygvhKn82B8eAjO9PzTsU5zioPdCXhWM1M
         RwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545142; x=1778149942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riHCeEKv9JBqgVZavmNjnLcf0Ylg7fMRVgWiYHUs0oE=;
        b=g69BOfEproDvbHq0uFphkkxjGNcZrcWXYQvkgPK28Jp0dhkM8cNnMe1EWrHbSiguaf
         F1akJntmYrdVpVUU0YaKSpq/T4N6AGTFNk3dE7HC6EGPgr11Y3bQBt4ghred1JkSEX1e
         aUwyzqdPhoYCrLxz4bhGk4exqrIIG3fdcGLFdDIZNlwdmaFYN6vP8WFNdgDjTrSwXFic
         trghV9TR5Gk51aX3wEb2mZ47uM2IEafm0Ruvti6HETS2/GoN3+VGdow6RWOJCC5nmgHN
         +AQqbukkvvmTtq9nFFVW0jUERWp6KOfp4TF6Lc8TYMYrN0TzcOFA0xrntV3N6e0dZ1ZC
         kiPw==
X-Forwarded-Encrypted: i=1; AFNElJ+QNgyq+ygrEMKWWDJnwwKZuZbVEltGCqGjrijL/0/X1PE/J8YFPuaH8Dey1PiLnqjcUEcMSxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1+EdwMkcTilXDoGa9Tv6VRsXSmYMcdWhj9ykmqcL8p3GSOt6
	6kOnqtb3Y5RgfSJoEbBa27wX90X/UfFO6Pzdv40yjM3dzT5PB2Lm5t2P
X-Gm-Gg: AeBDieuIDTBWjOES4cKgoDf7NvDi71+Ldaik50MjjYMfQLarcI2/AIJuzejfhXhsQDG
	HL0G+ybZTUyHnQGio3xFRGz7b1U1M4FoUXoRnkNWxAgT+qLhadcFQ7e4hI4Zl1SOFvag2WxNl8M
	1yidXuas5o7b/DmjIIRlnjOrqliNhrfcZCu9Z5X4WFUFDLpF1UiJO0h0Qcv72Rt/4YruoHb/Mcz
	8WPPtnyD8AFahIpM0lvi9e1gRH7dvHqkksGT0UEPyQKquCv88I0kK2anHEI26U8LV28zBNgDOcT
	Yh6z8BBc99TMF6iFov7RR2q3HmKomDkbiGN8gqNzaGKdj2Qj5Sv6lYN4gzQIESwofsO1mUFdjG1
	SYWH5rI4NvkFbx229HUxpN5X9stHGJgXBttnDGorz4RxEdavVGzzAw/HYKi13xTHMUyvL7EvPHY
	5rsXeW5MijRlp3VsH/KcUrDChrxiPpJplQgan1Ngdon842GI6c5Aj6ohThn/8f1ElBQuPtnB9eU
	W/FZCFmDQB0yx17NksKVCNPo/j5ysmO/MLceGqpDf/qzyct
X-Received: by 2002:a05:6214:f66:b0:8ac:800f:10da with SMTP id 6a1803df08f44-8b3fe70fef3mr36555836d6.4.1777545142241;
        Thu, 30 Apr 2026 03:32:22 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff321bf9sm14521296d6.13.2026.04.30.03.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 03:32:21 -0700 (PDT)
Message-ID: <700329b9-e4b5-434e-9678-5a7f067a535a@gmail.com>
Date: Thu, 30 Apr 2026 06:32:20 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] psp: reject packets carrying unsupported PSP optional
 fields
To: David Carlier <devnexen@gmail.com>, kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, raeds@nvidia.com,
 kees@kernel.org, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260430062033.20428-1-devnexen@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260430062033.20428-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA5DE4A0E0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 4/30/26 2:20 AM, David Carlier wrote:
> psp_dev_rcv() documents that it does not support optional PSP fields
> but never enforces it. The helper unconditionally strips a fixed
> PSP_ENCAP_HLEN, so a frame whose PSP header carries options is
> silently mis-decapsulated: option bytes spill into the inner packet
> head and parsing fails downstream on a corrupted skb instead of being
> rejected early.
>
> Validate hdrlen, crypt_offset and PSPHDR_VERFL_VIRT, and hoist the
> psph read above skb_ext_add() so rejected packets do not pick up an
> SKB_EXT_PSP extension only to drop it. Both in-tree callers gate on
> hardware-validated, opt-less PSP, so this is hardening rather than a
> reachable corruption path.
>
> Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   net/psp/psp_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 524978dfb8fd..53d7e14c054a 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -321,12 +321,20 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
>   		return -EINVAL;
>   
> +	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
> +				 sizeof(struct udphdr));
> +
> +	/* Fixed-length decap; reject optional fields rather than mis-decapsulate. */
> +
> +	if (unlikely(psph->hdrlen != PSP_HDRLEN_NOOPT ||
> +		     psph->crypt_offset ||
> +		     (psph->verfl & PSPHDR_VERFL_VIRT)))
> +		return -EINVAL;
> +
>   	pse = skb_ext_add(skb, SKB_EXT_PSP);
>   	if (!pse)
>   		return -EINVAL;
>   
> -	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
> -				 sizeof(struct udphdr));
>   	pse->spi = psph->spi;
>   	pse->dev_id = dev_id;
>   	pse->generation = generation;


Thanks. There is a bit of a gray area in regards to how much we need to 
validate here, because callers ought to use this only downstream of a 
real PSP device, and only when that device has emitted some metadata 
that the skb was at least parsed as PSP and decrypted correctly. That 
being said, the handling of psp hdrlen is definitely a bug, because even 
valid values can cause corruption during decap as you noted. I think we 
should fix it by validating that it is less than the remaining bytes 
after the psp-udp header, and then stripping the correct header length 
accordingly.


For the other two, I'm not sure they are really necessary. Mandating 
that crypt off is 0 is too restrictive as this function should work just 
fine with non-zero values. We could validate that it isn't too long or 
misaligned with the payload, but it may be better to have callers know 
their NICs PSP implementation and decide if that is necessary. Similar 
story with the VC present bit.


In any case, I think this function will also need a comment update 
giving some more context for caller, and we can mention that the whole 
psp header will be stripped away according the psp hdrlen, and that any 
vc or options will be ignored and discarded.


For a fix, you'll need to target the net tree with this patch, (i.e. 
"PATCH net").


