Return-Path: <netdev+bounces-264912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMhrFEI/q2lnbgEAu9opvQ
	(envelope-from <netdev+bounces-264912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6763A227A72
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75322300AD45
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD4B48165A;
	Fri,  6 Mar 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5QTdr4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A700481648
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830525; cv=none; b=ulzyPGsFcIo8gAgJY2RsNLH0uy67t4xijf2IVDWRipbuIsPQ4f7PUuVFzvUe34Pl7R9NNWRLqx8CHbuObphTzgllFrjTCzFpjxnE790+C7/1NLVRPAwQBeD+8ML6hcGk1lXwGnOVz/gRddYYOgcGpfZO+Vn/PZ5jJ+1EoiMuoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830525; c=relaxed/simple;
	bh=EjG4nUEhXL1jSybyufCOlqIght7phwehmkoJaEBmiUo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gZSvZ1HBw3F+b9pT/pZ3ukPdYTgLDlOT9Js8B5XONdsMlpFvEdgXY98dRUgnbtMbdRhafYSSF+mF66STrcKVs0a/HK/6i+Hm7WatKPG5AjgqGfyfA6T1A1apG+i7zr0vL53bmZJ0kEkcXGaA5js40aEnPEqJF04+aDMLB+fj6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5QTdr4A; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7984d31b895so96616677b3.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772830523; x=1773435323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgxV3tPz+s1vWn/RMpiaVurXVOCcy2plTz1QywzqQc8=;
        b=j5QTdr4AonoxTbNWHfYZQmolaltznEQTiypiiTK4a3odrMKCTyAglrrxDH23Uc0afm
         4PR40jUTUCqJXlWvJOefv4GDWZUe8+7CK9Pl26n1kGv0wuZOdjyW9oC4Uc2PRYzKq3oh
         2lQvwW4oplLb5IxH8R32QNl6XxxzOO+cZDB79BE3IgvbJyoBlaC8+RbliZOgyDxtt0uW
         YwFMZ08k3jXyH3DklkikmBiY7kpZEdYh/tqbZdGWRevVDixVQZVL4r/OHAezqaedpIM7
         HaIncYzqdA846xP5AZ5YfhvhQlR7/3/ptLNvN2+vdw+qoyNcrIo8aZjLOl47bW79MTw8
         BmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830523; x=1773435323;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgxV3tPz+s1vWn/RMpiaVurXVOCcy2plTz1QywzqQc8=;
        b=sNV13jHA+n1XgmK8fjstpgf5Caj52se637ttD5bxgc70uxvJge+5lg6+3tauPePRLa
         z9nSe9eRfAOrOJyVrwyPoG1mZhM59OaolDtqg4uBQx1giu1T9760lx9kV7af5UBLyXQW
         kwCQVg7/CC9AVjOaVrg0VdPijvYKCZNgwcrVdgOklvqB+3rIMWwJo0+44oXbH9FakByF
         ozUYesLRyS37436msAyLLF7D639N2UgrNVxAZnQFcZ9v4c6WAXCciuSB6mcWs7YLa6vK
         YGDL0h+2SLHvt+7F+pQs4VIgqDHJnVw8Ve9rh7doYtawP8iIyCZ9CXicA8i2mTl8KHuF
         w7jg==
X-Forwarded-Encrypted: i=1; AJvYcCX+R8fICgaxX7lrt54M49QVGrxcEA/rc2s526lmylOG9EXEqYmPBMeVdh84z6VzLuCfKcLhkzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVpBoq+MGa8jQeIkytv2ZJkLo2vhzxljKwh7uEciilHzlw3n9
	Mn38hT3xJRsq8kA8WGIkjkjpeUcb2AnTu/LoCOqTW4x7f81cdveJzFFj
X-Gm-Gg: ATEYQzw/F8sDTshVwb530cm689f5g70Kxi+GV9l2nYoBSydhMmUiZ4AW9pUcJNEkmX6
	ItAPl4QVzUaQAGU6vWnSULsS8y3tcwh0PBL+k6eQZElWfUT+4VyWNCfFbA8GJ3+R+cjzFVIhgjy
	Z5RA1lXIrcIr8MRS6imBBE1owuLeYVrMbxDyxYJRYgFWrBebDha4K2aABdO/VAJ+nGQ9ZYdE8e+
	Ei7e96Y3C5+RoTs8Dj6zpS9zL6LMR8SW+fmfSL/YN0+zj69ddN23xPQlF2ekaZFWGWO834nuxEZ
	CsozvUbWmFZFrTxrND/Tl/JxN5L3utmsP0pybhJHKe3z22jNtx5VrGlNxKMsqjwhVXOQbaD9OTY
	lJLnMh6wXapqnbP7MhuNzR2Z7b1gEPONODNJqNFpG4+UQc8Jn025DK/ABXsknxABD2+BvtoI/NZ
	i2d9DyblWIrH2xtxw8PHG9KIypkN/OS3wB0/4HcAV0wb2XRl5sybCuo9nFH+4ytJqkcpDF/NQ=
X-Received: by 2002:a05:690c:c50e:b0:798:c633:d135 with SMTP id 00721157ae682-798dd6d3590mr36298617b3.27.1772830523059;
        Fri, 06 Mar 2026 12:55:23 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-798dee4a70bsm11301077b3.32.2026.03.06.12.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:55:22 -0800 (PST)
Date: Fri, 06 Mar 2026 15:55:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>, 
 Gal Pressman <gal@nvidia.com>
Message-ID: <willemdebruijn.kernel.346c48b49836b@gmail.com>
In-Reply-To: <20260226201600.222044-3-alice.kernel@fastmail.im>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-3-alice.kernel@fastmail.im>
Subject: Re: [PATCH net-next v2 02/12] udp: gso: Simplify handling length in
 GSO_PARTIAL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6763A227A72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264912-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
> MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
> and fix the checksum (apparently ignored by hardware anyway).
> 
> The mentioned commit started using msslen for uh->len, but still uses
> newlen to adjust uh->check. If the formula for check is fixed, newlen is
> assigned but never used before the loop, and newlen is overwritten after
> the loop. This makes msslen not really necessary, as we can reuse
> newlen, if we don't adjust mss before. 

That's a big if. Why is the udp length now set to the segment length,
and not to the GSO packet length, as before?

> The adjustment of mss can be
> simply dropped, because mss is not used anywhere else below.
> 
> This brings us back to one variable, drops an unneeded arithmetic for
> mss, and fixes the UDP checksum.
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Cc: Gal Pressman <gal@nvidia.com>
> ---
>  net/ipv4/udp_offload.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 6b1654c1ad4a..e831234326c4 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  	struct sock *sk = gso_skb->sk;
>  	unsigned int sum_truesize = 0;
>  	struct sk_buff *segs, *seg;
> -	__be16 newlen, msslen;
>  	struct udphdr *uh;
>  	unsigned int mss;
>  	bool copy_dtor;
>  	__sum16 check;
> +	__be16 newlen;
>  	int ret = 0;
>  
>  	mss = skb_shinfo(gso_skb)->gso_size;
> @@ -556,15 +556,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		return segs;
>  	}
>  
> -	msslen = htons(sizeof(*uh) + mss);
> -
> -	/* GSO partial and frag_list segmentation only requires splitting
> -	 * the frame into an MSS multiple and possibly a remainder, both
> -	 * cases return a GSO skb. So update the mss now.
> -	 */
> -	if (skb_is_gso(segs))
> -		mss *= skb_shinfo(segs)->gso_segs;
> -
>  	seg = segs;
>  	uh = udp_hdr(seg);
>  
> @@ -587,7 +578,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		if (!seg->next)
>  			break;
>  
> -		uh->len = msslen;
> +		uh->len = newlen;
>  		uh->check = check;
>  
>  		if (seg->ip_summed == CHECKSUM_PARTIAL)
> -- 
> 2.52.0
> 



