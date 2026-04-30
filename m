Return-Path: <netdev+bounces-282678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKIrHt8C82lswgEAu9opvQ
	(envelope-from <netdev+bounces-282678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D531649E8F0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1768303E2E6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99AA39E6E4;
	Thu, 30 Apr 2026 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI3CIeXF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AB39EF10
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533381; cv=none; b=mMPXJo+Oe+OCRX5WlGn/jwZQufmqx5yALzjEcYcQcB4qM1w0i6vnZNrzGunZjCN7jzei1PQcgMwGY8KT8y2o+R+4H1ZCrgBSKsqlEBRhp/ASxD6XsSAiYUd0m5loSDNbQMPgNnBQ9Az6T+sQfkThNH04k+GEOY2ODqBnUpMzCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533381; c=relaxed/simple;
	bh=g099dLdjyRhmrxecWGAVmHcsSqfPyYdB7TQu+yaVEyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbrEawtgKjJ5WieNRh5vnawYJXQbHbq+WXLmnr3+2QfA2Oin8xfNRhgJ2P1XIxux+smTizA18holAM76Afy0SGh5SLQWQIcbSqR+jfcRwbPXwdou2zuvOT/uosBqmEj7mPDvOyxZVaz0CpY8dLE9RVt5ksbz/O4laUlTSp1Pi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI3CIeXF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8892d4d6so277555b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777533380; x=1778138180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdME8RIbkjektnVQG1CaOvBK5+Ca3v4sNxeone+8L1Y=;
        b=NI3CIeXFFJdWblZtK8FYKJVC4YBaG6g1MlbyrTNIiQY0Jnk6d9lQEeya/NOtzTzY5v
         TeT2ChqQaS1J16Lizf9H85yxyUnW48HsNIBKaYlZxUiWH8xPvHLIZBh7m5svN5ZTiF22
         NKcP9bZ+aObBnZJPrcsXNWEcgyGuIHd8dLWhpEZeCexjKV7HlZsKky5WryHHcH8AZUIg
         hVZ8Xl4+mgjSDrr1FfOdJG72iHTJzqOVg2XhR4mJjK6bXyOGUvAmM/9wemeZYwLcptmR
         sMISYlxchqpDX4BfAzAZygpId5FQA1639HRhu6YLOaFP5lgsaxoH9twqLOkI04FJlZtS
         k0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533380; x=1778138180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdME8RIbkjektnVQG1CaOvBK5+Ca3v4sNxeone+8L1Y=;
        b=j8yKS8nId9bSYb+3SFrSqdNNI6xQutMYZA1r9bTaYyin6SPf4yEEdfgCbMsI55NLT6
         I0xDlcH/jGtC2rVwwA3IF1tRIGS8hhFSF2cbnHO8hm9nVFbhJeO5FIhrLDgHBEtgkk1t
         Av+BzmEdcnfcCE54xyZLg/Dxvc6AoBa6nH3oA/MS0Vceg4BLZaYyQftB7N+lZ5Nlf1Yn
         bKXygtxHlUWv9jt9LAI2/NzFdAcZafTbJDosR3550zFzsm6yFiQqt7W/Fmelbjz48Cfq
         c0eniZUUgEOHhyIvwgD0HY7V17ohuObXmXiX5zofL2ICFImHUTaz58+X/2KHI3u1N3bZ
         pJKw==
X-Forwarded-Encrypted: i=1; AFNElJ+leM5mUK4oGDMhKBL2Cz8UK/mWBcuNWcG+5Eye+mGJHlSNQvq8OQkP4GHlf08HnhqggWb7jrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SUx5rBMLI+kv75kr9+6+P7CVKW5mXPDq0nV6IyhvyOEHcN22
	ndc9Nkyqh1ijLD5/yrIGl16/E32VpFRPwoxeamZkcwS+ZD38qEzp1h+O
X-Gm-Gg: AeBDiety+UTggnR0pnmbka5BPoX7VX3H31EAUZ0lrLcfQwhwFV74d+whR2J36MzaWw3
	oLAPadDKwTZJHDXButtySnEBiOmKOVn9E02CzN+/KUW62vF5o65Z4mI6DIlgBIAkVKemkumBCZb
	PXcXKmu7TnhI3GXZFtZ8YfCRuKGnqKp7IVbefLYWXD1t2EZ5qYJZsUTZwdAJIire08uyY9pyAVs
	2lHBlnlK2K+wBkA33G2CGfzDd9IxaVLL5SnmDfLX4yFPHFBHueBOpIFLDzh+oIz61FbWvp5q/bS
	W8i+hpH7K1oyHS+kH+y1VGcrHX5HI4pisroXFNw4EVLeLQC9rY9Cvd2uu/D9Daoip/Z1HT25mYm
	KOP2yUcN2cMUMGfqWOZPvW0lnwmpZuGYIuvHIGaLBx3qxHXEaShmZqRbmw3QvWqWJgdpHbQvCN4
	UoWjXNkRDU24bZiTvIB5SxN5FsHgm7KBvfO7o5CmIbGo/XO1/ent9Yud4h/NPI5bnQ
X-Received: by 2002:a05:6a00:3cce:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-834fdb5ff74mr2040979b3a.15.1777533379766;
        Thu, 30 Apr 2026 00:16:19 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7eb783sm4233150b3a.42.2026.04.30.00.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:16:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 16:16:15 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: steffen.klassert@secunet.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ilant@mellanox.com, sowmini.varadhan@oracle.com,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH ipsec] esp: Force skb_cow_data() on RX when the skb is
 non-linear
Message-ID: <afMBv4M-iyd8Z-g2@v4bel>
References: <afLDKSvAvMwGh7Fy@v4bel>
 <afLZ6Fl6b2ChTnus@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afLZ6Fl6b2ChTnus@gondor.apana.org.au>
X-Rspamd-Queue-Id: D531649E8F0
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282678-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,davemloft.net,kernel.org,google.com,redhat.com,mellanox.com,oracle.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]

On Thu, Apr 30, 2026 at 12:26:16PM +0800, Herbert Xu wrote:
> On Thu, Apr 30, 2026 at 11:49:13AM +0900, Hyunwoo Kim wrote:
> > esp_input() and esp6_input() skip skb_cow_data() on uncloned skbs
> > through two arms: one for fully linear skbs (nfrags = 1) and one for
> > skbs carrying paged fragments without a frag_list, which sets
> > nfrags = skb_shinfo(skb)->nr_frags + 1.  In both arms the skb is mapped
> > into a scatterlist via skb_to_sgvec() and passed as both src and dst of
> > aead_request_set_crypt(), so the AEAD operates in place over the
> > existing frag pages.
> > 
> > Drop the paged-fragment arm so any non-linear inbound skb falls through
> > to skb_cow_data().  The fully linear fast path is unchanged and the
> > existing skb_cow_data() error handling that follows the gate is reused.
> > 
> > Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> > Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/esp4.c | 13 +++----------
> >  net/ipv6/esp6.c | 13 +++----------
> >  2 files changed, 6 insertions(+), 20 deletions(-)
> 
> Good catch!
> 
> When a packet comes from a device driver, it's usually safe to
> write to the fragments since they would have been allocated by
> the driver.
> 
> But when a packet originates from our own stack, then it's not
> safe to write to the fragments.
> 
> Unfortunately the two paths cross with the loopback driver (and
> probably other means of creating loopback).
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thank you for the review.

If it's not too much trouble, I would be grateful if you could also 
take a look at this rxrpc patch, which addresses a similar bug: 
https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/


Best regards,
Hyunwoo Kim

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

