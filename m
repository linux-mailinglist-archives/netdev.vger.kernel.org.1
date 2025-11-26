Return-Path: <netdev+bounces-241717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53222C8796E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5D724E1505
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435B1F3D56;
	Wed, 26 Nov 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwamRu5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230075809
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764117007; cv=none; b=R2Lblyrj3VodooExjmBUuQ38V2wBc63MfPUt2641fgfsHF9fImIR1NrIJ3I2ZZfBEUOdDX0JdOP7LIAzN9VehYtyXaX/kRidm/7dEAFph5NmvA1GxfqJFf2VC/tTENX1v4FKSGOoGtEYmmTAk9kDPWNzy9sikBnuepFU9f7veBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764117007; c=relaxed/simple;
	bh=+7pgfRjo/daR/nWjZbzX/uZO08iJE3h0AwCxM47eCS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJxs3mYwkYH15gQp/ATOd+L88yysd8MtL3G4NdxlcGzqT1h2sAYxzGH22ymqUdkug2M+q5bfNMJDEx35/sLOX5q1ezp3GtEZOgU7K/dUZZcn96NY9t3karyM3U1bFZavFP1Oq3sw3A6Nbgj+3c2HdRbx40sHwYqLO6AYJEbcFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwamRu5s; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aab7623f42so6411374b3a.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764117005; x=1764721805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQMjuKPHzUNhfDB/BTLq+fTDXNip/wwiVzkgCrUswNY=;
        b=VwamRu5scCwBUWz9WyCwemooMsOX3LyoCXEk4k4S4cQz6czo6mlzblsCC5ke5LkVQz
         9nhWPgF9YTBR93kBUD8/wKHuVC4YYrXrMRfmuGJQE+UAmwffula7JAChCIWYlMJKaAMK
         8IpXLpqBZATHqs7NvhN6hzM9OId92KG66j+Veofvn0GWjLB+Ir034DvR7WDtZ2Fdua7E
         P/VKd6VCJucQM76vaFNghQkgcmEzFjqUjYS++WtcX+I4XRGU4RDbJCAbmMQyTsci1QO8
         qYAVb7l43B7vaFhr0WlI/GIcLiQSDkh7FH6AeAagpRf91xYM1dV04CLKximUj3EgbsGU
         IHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764117005; x=1764721805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQMjuKPHzUNhfDB/BTLq+fTDXNip/wwiVzkgCrUswNY=;
        b=Lm4xPkebwK0iqaxpQXpczFeTwDQ7bSSAfnptMXdPJrv6qQV6MzylTEBPgYBhHIMmXt
         JxyWyPAdsS9wl/YQXbDk0kENj5Y8Mvo5Nxk7++8FgMrwpkiQffxteFm2qmx6Nit4l3Z7
         0Ds/5/G49EIMI6YjkI25Cz9DMl5ZpXvpapjq0OfOWWKa+xHdhDmzt6LdPoizBf48CrPe
         V2ULBH4rcq42rmA7Ze7B8fRyikdUSuMX4skaed/j4PN6Sw4f1Tktc/gw566CRr9Z+nhr
         rC/Yw++V4CwewZxqHW2KGD0Es6NZ/tq4UZr1bnfOGVCwg3gObaIs+YNYncUWBr2PvpZz
         UeMA==
X-Forwarded-Encrypted: i=1; AJvYcCWEDaBwz2mUoFeP2oXQ68gPjXjUQyFlaA41DIpNTSgIp/zVR5P04ZIYrnOFpC6ycGZyyo3ZiN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5Bvme8s9ZMu7jnFm+i8wlvxj14jGXxThOduvxJGPU7YODTEW
	chGagkJ8CLa2RGGBkX95y5TSI4BrqEemm3+Jx6JDlrP+cogUnF+TOZq4
X-Gm-Gg: ASbGnctgUP5h1UGtiBRETl6P3FWHtvGVVIX7pK9T395EkIRy7ZgERVVWUyUrZZBes1b
	uMZSmzAkwAnEGyHIyqnPTbHo86reqbP83aIV6uQFeuH915eeJb+XRcnN5xC3/dypBtTG3uGaAqo
	zwplivgIOOY2VditPKpiDrnkpKVODqdUtNo33yMOzLCdERU/nHZ0S6xJB1h6KCvEtv5m620qLIX
	indsIyiuVa+pZaBX/ly+vqpH1fk7XsRCnJdxlGFlHAt7vO/xyFJYEFc++R16BdPkRqgmMkUN4p3
	NlAHlzWg5XCqqTLdCfh95UfZWjIcKw3JySaiTrLNI77YAsvm8Jg0lQsZBSwDqVr3iDM2uBbo/PX
	GpHK/IoYR6afntIpqV2rQsFbIiu72qvCCsOqJs2GTIT1mKXFmxwllwjs9HmEEP1I9gnj7Z1CVeU
	33UFx1JgIEqKnya/4OhZ4DRQ==
X-Google-Smtp-Source: AGHT+IFlzBzMU6uRJEoPA/DtA6ralWIDq9xCWcLTBXEwpgMrSQIUxDFPucCWFcH95f/neuSSWsnHWg==
X-Received: by 2002:a05:6a00:1490:b0:7a2:7f1e:f2dd with SMTP id d2e1a72fcca58-7c58c7a69a5mr14956775b3a.11.1764117004888;
        Tue, 25 Nov 2025 16:30:04 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d55b71sm19503922b3a.55.2025.11.25.16.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 16:30:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DAF2F420A78D; Wed, 26 Nov 2025 07:30:01 +0700 (WIB)
Date: Wed, 26 Nov 2025 07:30:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Cc: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next] docs: tls: Enhance TLS resync async process
 documentation
Message-ID: <aSZKCZkUnllzyydN@archie.me>
References: <1764054037-1307522-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uhx3q5Xis8IAS4gY"
Content-Disposition: inline
In-Reply-To: <1764054037-1307522-1-git-send-email-tariqt@nvidia.com>


--Uhx3q5Xis8IAS4gY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 09:00:37AM +0200, Tariq Toukan wrote:
> +When the kernel processes an RX segment that begins a new TLS record, it
> +examines the current status of the asynchronous resynchronization reques=
t.
> +- If the device is still waiting to provide its guessed TCP sequence num=
ber
> +  (the async state), the kernel records the sequence number of this segm=
ent
> +  so that it can later be compared once the device's guess becomes avail=
able.
> +- If the device has already submitted its guessed sequence number (the n=
on-async
> +  state), the kernel now tries to match that guess against the sequence =
numbers
> +  of all TLS record headers that have been logged since the resync reque=
st
> +  started.
> +

You need to separate the status list:

---- >8 ----
diff --git a/Documentation/networking/tls-offload.rst b/Documentation/netwo=
rking/tls-offload.rst
index 6d276931669979..a41d02d72e1ee6 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -338,6 +338,7 @@ Cancels any in-progress resync attempt, clearing the re=
quest state.
=20
 When the kernel processes an RX segment that begins a new TLS record, it
 examines the current status of the asynchronous resynchronization request.
+
 - If the device is still waiting to provide its guessed TCP sequence number
   (the async state), the kernel records the sequence number of this segment
   so that it can later be compared once the device's guess becomes availab=
le.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Uhx3q5Xis8IAS4gY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaSZKBQAKCRD2uYlJVVFO
oyacAP0fN/NP544JfEy704TIpMviAVm7qketzfORZ/nMxtq97wEAjUGwXZm8f2Hk
f0XnH1RkaVFGzFchC4P1xk7c1Dv7qQ4=
=xNTM
-----END PGP SIGNATURE-----

--Uhx3q5Xis8IAS4gY--

