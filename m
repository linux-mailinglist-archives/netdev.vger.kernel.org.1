Return-Path: <netdev+bounces-227462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197ABB003A
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84075189247B
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A82BFC8F;
	Wed,  1 Oct 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN4oECF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E12BEC53
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314606; cv=none; b=mRmGhVhX5yC35B5WQFd2zt/+zdUPr19ece2ZOw8YQ2IhfDXWhBR9fcrqn81IXXsdZYAB2FN5g+TqCOBgi0SfF5GsvWXZS4r7F2Ifj1lKq3oE8RuphdtW325RRLyYevSJFVUgGxRP5Eue3b2sTGFMSUeGxDqtGiPTTW9LzxIrl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314606; c=relaxed/simple;
	bh=lpcbaTnRUfRuUjlxvKbi7MippNxGb5EWhV7oCbjdFdE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=famzGoyBI3q4CeDfpiNasJfLzyEXKBG1OFBJKhOfl2RoRnBAs7CSehrlYoYJGyzQ/k9Y22HudbYoJbbS/VpLyW1UZLj0QcR+dkIQSE+sEmsKRdBkAJVyL3wItPTf+Sno0MxkRbQscdtE1t6hXhIEeCAWOaKUPgHvt5T5p0Be0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN4oECF6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781010ff051so4884253b3a.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759314604; x=1759919404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fvvc2wJV4y/adOnS6TVe7Zorj1unil+xBTIrzA8bkw=;
        b=LN4oECF6HYqrTDe+J/1iFgvvBgpF+ylX/BvnGJ2gzWGqCOLBwZWzVdVZe4YDBcofmA
         WRGYXuZgjyGX4wJyaCo5qH9daAPc+L9Z+dZ0coRPFX88n5596085TpgMmfcSrQ1pr3Rs
         qG07v2FlTmy/4HxWEeme1eptGO9PgQ8Nay2iwYnvZkCGT3tkx3q09RPAibF/iUnJDh/f
         HrnFByyQmiinRkIQTG/Fdk2pxRRbHCBd1HnnJ5w6llR8z+uBoaMMa9xPQ3mpcXhdMtDx
         t9EWKjOEyjBE1uwIVJ3ayJz4Wy4TzVgev76WVQNCUfKGxwCRmivNXvrpXEVfypdWca1/
         9EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314604; x=1759919404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fvvc2wJV4y/adOnS6TVe7Zorj1unil+xBTIrzA8bkw=;
        b=QZpBlmyDQ0jY3UGkILBTSJ3c039ykqN+liHdEyBvPKliQdD2LnXbD6bmKfRt4002Ie
         OveB6tkp3t342ILSFSqud2KhMJ+fNU4ucsnayatHYwN+VU4qeoWO4yBI+dhTwMMi3SuB
         4lmtmq6p3RIq37ARLNvXi6lJA4nXMDCyotvS2e36LsDQWEsvQ1kgO/rQgdatjvZf43sN
         s4n66wEkDInFJeixbPfYYXFi04qP8EYWBQOwFzxuuu9ok6Ajr8XJs0/Nbn5TYX3kUJxb
         LDme5gHxQoheVu0JHxmJidFehyI5Gh/Rd5R8eEAx8RZzTVIBj8iKY4nF3vN+JYR9Lnam
         /a3g==
X-Forwarded-Encrypted: i=1; AJvYcCWjyVqxJ5t492H88WgX387l+NnweU5rjRgcvdQd1u5pdRR6qlysqpIj8OV+JdYd/zX64nQIebQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsixyBArUbrd3ur0dXIRYl31RrYST4QMcG1BBAAzpudJebRWH/
	Se9NO2kLeMTNdpq5+Uvk7jsBbMRtYHQ0c8fq69/yezx1Dqoo4SjiCCXg
X-Gm-Gg: ASbGncsPCGYD5mMRsH23MrW7pb9V2FF2IFtLeBtjSWrOJcpl5TduCkvOZFalCycP0aH
	+eV8xRJHMVcK1KcuRe2EKXaYQwa1WYFx7KDTA/xtnZwQ8mXVVljRoRkrcc1Sog99AOKQedZ+qtS
	Hvgi6cVtlRPK7XdHzQ4gPopXJnXUcghd2F9mqg98fJ1O53yofdPycvxSlARINmSQ4WHX62u9KmB
	utw2GHKMTBOc7/ITrLNUdTrLXxPZeDOcaGEbqPjUjf8Z9SYlTw45sXcwY3oVShJ6EOUrqV14uhE
	fvov6y4LChq9Eo7jLWZXpt6uujweBDOZYkZR3iGAnQblpKqRB+dkQBfLlqQ1/Ix2PssBBRdvuYt
	YFFSku87n0x5CgOeEAFqzvik9ljhSPbHLbujeyvAEMvlvyp+zhQ==
X-Google-Smtp-Source: AGHT+IGlOP08FechFri9XhBd09rOWOVrXywqRW8pZP7UrkJv21iqrkorW0M3GD4lm+V6u0a1W3KkFQ==
X-Received: by 2002:a17:90b:4d06:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-339a6ea3208mr2952898a91.9.1759314603841;
        Wed, 01 Oct 2025 03:30:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b608f0fe65esm643463a12.0.2025.10.01.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:30:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E93B544507EC; Wed, 01 Oct 2025 17:29:59 +0700 (WIB)
Date: Wed, 1 Oct 2025 17:29:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <aN0Cpw7mTtLdnBMZ@archie.me>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XTnKR8OXozLogMib"
Content-Disposition: inline
In-Reply-To: <20250929000001.1752206-2-pasic@linux.ibm.com>


--XTnKR8OXozLogMib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 02:00:00AM +0200, Halil Pasic wrote:
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/netw=
orking/smc-sysctl.rst
> index a874d007f2db..5de4893ef3e7 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
>  	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> =20
>  	Default: 255
> +
> +smcr_max_send_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
        So-called
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can be a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the send path used to be hard coded to 16. With this contr=
ol
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physical=
ly
> +	continuous array in which each element is a single buffer and has the s=
ize
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 16
> +
> +smcr_max_recv_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
Ditto.
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can be a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the receive path used to be hard coded to 16. With this co=
ntrol
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physical=
ly
> +	continuous array in which each element is a single buffer and has the s=
ize
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 48

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--XTnKR8OXozLogMib
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaN0CowAKCRD2uYlJVVFO
o0wMAQC5im7T2Vp9QlkibFW/54g3imCkfNlm7IUNsqBjTp2m9AEA1GNBLgxsziTy
v2vNJmcJSA7s6ugOR+dFS8j67OYO3Qs=
=jHsY
-----END PGP SIGNATURE-----

--XTnKR8OXozLogMib--

