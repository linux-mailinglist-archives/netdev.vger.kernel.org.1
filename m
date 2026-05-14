Return-Path: <netdev+bounces-288085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPsBBTRFBmqAhgIAu9opvQ
	(envelope-from <netdev+bounces-288085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:57:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B45473E4
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6C2303FFA7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 21:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BD3D1AB1;
	Thu, 14 May 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx11IEuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD23D1CAF
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795539; cv=none; b=Up5e+2Lpp4tsSyyFeN2JV52vOHV/ZWU9xRchY8EflhgBXKnGH6Gm4DgFNeTBaC68Lifah6Sx9AKFFq7gXYDK1yjMLfLgqvAGxPmF7gRrBvbtgBiTnc31PJ5tMDFgGJG2VRnsFINQJiNftlqFdZM1aiLfAkG/ziJsaKgzx6BdCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795539; c=relaxed/simple;
	bh=tSiLvPSEsXkMXXwxZsxqtDF/spinGn8+ZL5/TT1mXgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2fLzQdZKXpFHLNJQRxEPB58BOSXko7eDLdK8E68L6dd4IvyL+kREmOoYtpb7+SjbxX2TkprRZXMLkklthcj50ufhZWe71gtZvbw2MNFYiRWe7mMvJjFrZBoF6pB5T4NTVzPVrBDUqaAKxhDl58Ci/IfzPfsYDJ6L1S4YkfGtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx11IEuX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-369002b26f4so1548459a91.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778795536; x=1779400336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5GMG7yqxFlWKKbJOnpHzuTHyp5R5BwNKepla0Okl+I=;
        b=kx11IEuX7RClwKauTq5TYBPnrTAVRozMmhO1jfiCVNkyCu2Vqq/9qhXh9PFxq4YWJl
         LrqNVPjqyyvjx3y4wW9jIK8zqhG5EoyIFpIxc20TPom25w+E1E35T9qMClqxU7xB8D8R
         BIxJCE7ALpUZNHzujuOXCSfH1fiFlCD4dICgEQnw8EsG3Ts6u4klTUBZW8bSkZE9OG6g
         mH09bFeW5dfE3cOmOOPNxoG8VCcLbNa2aREoHn3yubPahqYeVRppTgu4WLtTSG3L6pQx
         l13WxFzUqf1YAl1pG6S2/WYxx4po1YSUfJOzE7IW6xjUilfPVDPjOeG9xPmp0Ly3bAZq
         BkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795536; x=1779400336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5GMG7yqxFlWKKbJOnpHzuTHyp5R5BwNKepla0Okl+I=;
        b=YQbAULxqNo/cmKtk+tG74hVOAcrx+dZlM+6d4CeGiCoLV+YsWPf/XD8BkO3jDpxnPM
         jszSNX1o10k2fnsH/a3EW1VggluuYLObOmoBis7sKCtDwvs4k+M+fQhDq1QXVlFhOif9
         14VUiNcULTyVKvrLmqQtiHCwBP3XQLUNd33VuBYsB6NTVhuWg0pOOzqXOcq5MGBCixWR
         b+53QpmmsVuSsNusBwVFU4nx7ZdCEW4pq53xz5XIwrHmLENDlhozCERd1m5/94sjoriK
         nB3u4KCcT55n7f1N9eFjbI71stPJzmjXYsEEDl0CEQXmf0vOoNTXbL8F3iCt9DXOsqWY
         QgVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CtxFM4s+ovz2Rh82XN1uAWE+ehh0Nc8LWxrOah5WFu4vbvrOInNjnsz0BWznk2MPUdf9awRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzImRsxlGR8Dld6v1kjDBjKhPgfU3UeuIHSoDrSXbKR/19VXx
	k35KrL/ntlSAa0ze00h0CxEOWfF44INua6Ho+ixfF14F5UIUMYix9sfv
X-Gm-Gg: Acq92OF1YzQUL/yw/pKMLfU8cC/t2Ek7KTVbel1ENTnMyabK1TSADr/t3MHmC8zi6Em
	L5NLEuWC4Has/gx+AFg5W4Yd85ilwK7MK9OtzV8AHcjiwyLg85nt6AHX8X399X1lXGov9cCcGWm
	DxWLb49vQGlj8uXwvF2uVcPR2u8bShhSsdKJXfif6cNWw/JFWOUP/nNt6xB0HfDoXKPNeql6kE1
	FBwl3eSpGFsDXQ9NjHfMGA64YiG+DICOGgtK4K5tZFm8E5cr1drXKCUJ8nQzVIgn/UNJdPu9g2R
	52deo4vgP1osUuNPZVwMGhsyI3RMpGQ6Ws1onMbmCTHr6xOpn4iFCDnFxmbd6rdbZOhEmSpZx49
	2ZnyvxoNF+m3rgIQ8rPMPvCy7S3zTr/5yV1D5I5R65ZQdXoPj+WAntlIx7B+1DxcEOYxEwuN5tf
	J3XS6lCQFb1hsdDEfaObfj32HJJ1LlPUmpYEcTDtsS4rk=
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id 98e67ed59e1d1-369519c513bmr962379a91.8.1778795536139;
        Thu, 14 May 2026 14:52:16 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm649171a91.2.2026.05.14.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:52:15 -0700 (PDT)
Date: Fri, 15 May 2026 06:52:11 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, vakzz@zellic.io, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agZEC3YDCAhkrcvr@v4bel>
References: <agW4vC0r8QOUKtRT@v4bel>
 <agYZTjQSunDj6rOD@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agYZTjQSunDj6rOD@krikkit>
X-Rspamd-Queue-Id: 692B45473E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288085-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 08:49:50PM +0200, Sabrina Dubroca wrote:
> 2026-05-14, 20:57:48 +0900, Hyunwoo Kim wrote:
> > Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
> > and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
> > skb_shinfo()->flags when moving frags from source to destination.
> > __pskb_copy_fclone() defers the rest of the shinfo metadata to
> > skb_copy_header() after copying frag descriptors, but that helper
> > only carries over gso_{size,segs,type} and never touches
> > skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
> > descriptors directly and leave flags untouched.  As a result, the
> > destination skb keeps a reference to the same externally-owned or
> > page-cache-backed pages while reporting skb_has_shared_frag() as
> > false.
> > 
> > The mismatch is harmful in any in-place writer that uses
> > skb_has_shared_frag() to decide whether shared pages must be detoured
> > through skb_cow_data().  ESP input is one such writer (esp4.c,
> > esp6.c), and a single nft 'dup to <local>' rule -- or any other
> > nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> > skb in esp_input() with the marker stripped, letting an unprivileged
> > user write into the page cache of a root-owned read-only file via
> > authencesn-ESN stray writes.
> > 
> > Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> > were actually moved from the source.  skb_copy() and skb_copy_expand()
> > share skb_copy_header() too but linearize all paged data into freshly
> > allocated head storage and emerge with nr_frags == 0, so
> > skb_has_shared_frag() returns false on its own; they need no change.
> > 
> > The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> > The former moves the incoming skb's frag descriptors into the
> > accumulator's last sub-skb via two paths (a direct frag-move loop and
> > the head_frag + memcpy path); the latter chains the incoming skb whole
> > onto p's frag_list.  Downstream skb_segment() reads only
> > skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> > shinfo as the nskb -- both p and lp must carry the marker.
> > 
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> > Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> > Reported-by: William Bowling <vakzz@zellic.io>
> > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> > Changes in v3:
> > - Include the skb_gro_receive() audit patch suggested by Sultan
> > - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> > Changes in v2:
> > - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> > - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> > ---
> >  net/core/gro.c    | 4 ++++
> >  net/core/skbuff.c | 5 +++++
> >  2 files changed, 9 insertions(+)
> 
> I think we should also be propagating SKBFL_SHARED_FRAG in
> tcp_clone_payload(). It's copying frags from skbs in sk_write_queue to
> a new skb in the same way as those functions you're fixing here.

Agreed. tcp_clone_payload() is the same pattern and the propagation is 
missing.

On current mainline with v3 applied I couldn't find an obvious way to 
drive this into a user-page write on its own, since the TX-side write 
paths I checked all stage their writes through the linear region first 
(via skb_ensure_writable / skb_cow_data).

That said, a future TX consumer that depends on the flag would regress 
immediately, so the fix is right. 

I'll wait for a bit more review on the current patch and then fold this 
change into v4. Thank you.


Best regards,
Hyunwoo Kim

> 
> -------- 8< --------
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f9d8755705f7..6e4bb411dc04 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
>  			todo = min_t(int, skb_frag_size(fragfrom),
>  				     probe_size - len);
>  			len += todo;
> +			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>  			if (lastfrag &&
>  			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
>  			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
> 
> -- 
> Sabrina

