Return-Path: <netdev+bounces-254981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJdPIA4YfGk/KgIAu9opvQ
	(envelope-from <netdev+bounces-254981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:31:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40EFB676A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0E5630166C5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7B2F5A01;
	Fri, 30 Jan 2026 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5dOwUDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DA7E0E8
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740297; cv=none; b=mWNm1kXARsmvsmqr4LZcb33RApx7Xxv4h1H3szM+04ed/nL1ZCGF1MC9bBEgJ7lMAGWUiVdGy0PvBit79J96R1urK9nRLnHQmLfeEu2N7JpIwHKzqLzHxfocBlTH1q3o0/iela5Uv4mJUfWcbIGRBmnrLq/36Oh9/ejNveKc9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740297; c=relaxed/simple;
	bh=L5n7c+mYs2Jmw3DmLv+whK9T9EUa0DU9JyUfUNg/Y0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhq5cPuD7StAdjxaz1tNOzwUZPV2TraoKNT2g4Fi3ze4nQmSnSEhG2GDVQL2qbnxj4omEluZbZAUT8j/oYkIkQRTKrryYixZkPN28XoE1F6wpkxf9RBomOhlwh7r1H8CsPQfrRjIw+lHJfTKdDXJjMl7WUAly322iAhiJQ+NL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5dOwUDK; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a2ad13c24so15207206d6.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769740295; x=1770345095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5n7c+mYs2Jmw3DmLv+whK9T9EUa0DU9JyUfUNg/Y0o=;
        b=G5dOwUDKhE9mlBiUamQY3E4J5sp7x93ctIUFyTNf3+Kx6+hcg4VPVrC1BHB2XA80i/
         eTpwjXorA3cPU4bZSEHcQDyjrkhnP8EUe5kTyULTreUIj7JaKVatcj6cjoQJNPdK5JaE
         pZfmTlXb6Phe1LHKASCUkQfX73ZO89TRrgizyMYGHiujKEjtTautGa9SgrO4webjIozQ
         jHRxMe0EM7lPD1ivQ0V7lkeDOvY+W3zGAuvxx8eEmYLfuncbNc9Pu12aQc6r0EvXt2NV
         3AY2a2sZ8kfm1qnXF5+19IaBH2GJeughcfBA+JooCpvZFHqz9Av5CiC+m2UH1AiSxV8B
         ESVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740295; x=1770345095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5n7c+mYs2Jmw3DmLv+whK9T9EUa0DU9JyUfUNg/Y0o=;
        b=OEYDjL3ysmmZ8+UtyTrfITY/ExL/YpGE+oiRLZbKB83I1hOVpcDHAQFOoOR1tCa6oy
         WpSm3VFTKQ2OoQDsGN2SQIYTJj0ud0psyvPabp1CY7TY4xwter5p0h1gxaU27gVF/7Yd
         ShKr9z4Eys3TazdV2157ZOqwMkHUyxu1xUslZGNPeqNwa7QhNAqc3mTPZKgNIRwCUqZ/
         Ktb28ZKTj9T2iNVWqpF2nWvgWV9+HEMBYZaQS8RcyEpgVczkvuIPaYCNnmuQ5MIK98sl
         oPMpcbj2u2VfwzxxclrVsu4sjKAHHVezqDU3sPIUOMQeY0SJF2oeK2hPOOPxhln8+ibk
         Nr7Q==
X-Gm-Message-State: AOJu0YydkMqQbUhAclWnakq3rYhcGZbOzfLJNV9f3FxSUcQ7Ey868CmJ
	bVl5z1vdGSMqXPN/d/ow4F4itBhPVchbITPe2eSnULGREjqVHlBQpTFl
X-Gm-Gg: AZuq6aLqYz6YEdQQjy5drtoyrVGIH9BMxU9VU0llW92TdyRu37AeaSz4CsMGDi05SJB
	4Zdurg4nqKwIVloLQPU4Fsi7tmDB9FEofLYgwkSet3NyK/Jo43et11nfTzT3/ePFRJ96jBKwTGs
	ll1/3bOw2R/XAFuqcqaGEURGzwF1oWH2VmZ8YdobttuQxh729QMwSYK8SJlBnaYng8xTy+RREeV
	L8zFtfvRIllvcN3/SKJyOsh/s1HkoN7mPLNpmIMh9z74TBtUt88/DVUnPz41T0zpONQSKLBMxar
	xRi8sz6ts44qpS5EDRHAMpFSpiW8E3XrnDb80QKILYotj4F17mkslufqHeez2sR86MtBaQbxMS/
	cZ0nYsJwxjSoFt78xAKIdDZrvMGukxRf6e87TIPfaXT9T1KFdVdjrK2I+74QDjIb3X0Jw8Xf75W
	jogTFqa06ffDwsQT0taA==
X-Received: by 2002:a05:6214:2685:b0:87c:2938:c358 with SMTP id 6a1803df08f44-894ea0b06damr22269726d6.67.1769740294473;
        Thu, 29 Jan 2026 18:31:34 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376ee0csm49294766d6.57.2026.01.29.18.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:31:34 -0800 (PST)
Date: Fri, 30 Jan 2026 10:31:26 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net v3] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <aXwX_rv-3f-VP6_e@pek-khao-d3>
References: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
 <20260127190836.6a420768@kernel.org>
 <aXr_DNapxeHpuWt1@pek-khao-d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RwL+6DsukXCr0kwj"
Content-Disposition: inline
In-Reply-To: <aXr_DNapxeHpuWt1@pek-khao-d3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E40EFB676A
X-Rspamd-Action: no action


--RwL+6DsukXCr0kwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 02:32:44PM +0800, Kevin Hao wrote:
> On Tue, Jan 27, 2026 at 07:08:36PM -0800, Jakub Kicinski wrote:
> > On Tue, 27 Jan 2026 16:02:07 +0800 Kevin Hao wrote:
> > > To resolve this issue, we opt to execute the actual processing within
> > > a work queue, following the approach used by the icssg-prueth driver.
> >=20
> > Code looks good now, but why are you creating a workqueue for this one
> > work? Can't you use the system wq and just cancel it sync where you had
> > the wq destroy?
>=20
> This implementation was adapted from the icssg-prueth driver. After revie=
wing
> the git history, I found no explicit rationale for using a dedicated work=
queue.
> In my opinion, if we were to use the system wq and rely on cancel_work_sy=
nc()
> before unregister_netdev(), a race condition could arise between these tw=
o calls.
> Specifically, cpsw_ndo_set_rx_mode_work() might be scheduled during this =
interval
> and run after the net device is unregistered, leading to a use-after-free=
 bug.

We can use disable_work_sync() instead of cancel_work_sync() to avoid poten=
tial
use-after-free issues. I will send a v4 patch to remove this dedicated work=
queue.

Thanks,
Kevin

--RwL+6DsukXCr0kwj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml8F/4ACgkQk1jtMN6u
sXFCeQgAiJrV8DTfvK4MCejRqM3F9oMUJ+HTMV7UVyM7Vgj5KQwgbkWh2Gxvz89z
A5CB7TrArTN275UpCQ/e2sSmoA5vCyTGlbnV946DXt5RFvL99B4fVC4qVXEao3aR
ipfvGy/CYJ7I5EsEaSRBMq358p6bvnlyrhYAwltx1L0DH7Pd4qo03uC98y9WrlCK
SvmC6JQKlU9xx5kG/1/DmwvEcnI2vHY///yxGzEPo4TTq1C6N9jvyjW2aQksgZ8U
TNI5AKaJXpooCZx8sQ3asOwjyZMuCT/300+8s2hhld12RanlEWlfEFZBs2FqXwlt
RdztUPqQyDiCEKNtMhuJAbgcjpjTtw==
=nmyO
-----END PGP SIGNATURE-----

--RwL+6DsukXCr0kwj--

