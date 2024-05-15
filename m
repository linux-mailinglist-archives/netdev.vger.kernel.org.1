Return-Path: <netdev+bounces-96536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353798C6561
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8844B21035
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C7664C6;
	Wed, 15 May 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUBaprDa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADB58AC3;
	Wed, 15 May 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771789; cv=none; b=myiuu3JWcPnFOpCuML72UpVGtbhUoV8q6gQcFTCNiG025IbkTFcXneSLcBNrsoyxEyKi3NBmhhzm9vBDQpHxbBsYk81Jo7oQZz/QN86diprmgOM5xZ0Kyc9V4gGZ9QiX71vGWv6zq5d3wQWTiDW24Ko+tIjoFOuigLRs/r+6WDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771789; c=relaxed/simple;
	bh=La7shS+zS3wTP17U3gfvOwPX7PwmzI+3Y3Ke6tCzPrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1foD8RaqEemO+VjJ3BGNuyismovPdv3JlboynJJESbN0prmbmcfjBmHQgE3tCgxjRrqauFoIE+v+LmeluveOJwbju6pWmFFqJE1G0CzY6UGnjy6IXKrk3doFcEw1s4isHWzIahdrvIxTh69Pgti2kVo/SPoO0cRKSRNONpOJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUBaprDa; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f0f87f9545so2308215a34.2;
        Wed, 15 May 2024 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715771787; x=1716376587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=La7shS+zS3wTP17U3gfvOwPX7PwmzI+3Y3Ke6tCzPrM=;
        b=WUBaprDaanCCsJL5MQRF4aFxJBWIjQ6Lp/KOs/w7api8H8OIqQxmzH96319ELH3VBs
         nHQ4AilUHjkdX44iLlQwLTKW9guB8sYR0dywAlGr2yYAhaiUsvwplBrp3yAnp5loG5ky
         EaVebwmcj4vVXIWpc8L+pLmy/UMLxXxq5astYMyvEk3PwSVHzp7Y9X9D3KtgF4hH2+vn
         ATVpKd9Ww2n7kdLah7h6pPkDEZM+r2A4LanmZ6OuomI/dASiqNapbOqYU6RuITptc0gb
         PkMP1za4vAgaKk0GSPhtGGU+yV89OdMiC7bqKJGgktNtkIpxa2AvYPGZinn2qRymUdRh
         OiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715771787; x=1716376587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La7shS+zS3wTP17U3gfvOwPX7PwmzI+3Y3Ke6tCzPrM=;
        b=mlQ6Ar9W/YLx2Frgx3hsXgnsoNqTFyhPQezCkTBgwhwQrSAX7QKwNIqVcNochtdcCI
         iDNxEyR1A40OnW8ge12/ekaj9fHWEuUDWUktycnJzx3qBuKNMPJK31uftmqZtZZTMPsz
         AmUPqwiFuey8UfrCfB8Yf1RQZbV/a4KowDeQLCAQj27XoudOYjXH+ErDq4D8XbBqIqfa
         puFClgtmJThCzy14Z3PY34hMLfVpnFzZY4NBQB8B4a1bVhX9mH8yelHeVH0e60gGCc29
         ma6w5FzXfENA7TewhgoHl7wv9hFIufUhofy7CUrPDbpnKFdA7XpIUpRCN6xXalTBf9RV
         zbpw==
X-Forwarded-Encrypted: i=1; AJvYcCUdrdczBU6228GrLaH5KmZ1yASpyOrVQJp4iBI7nnbEtggV87m7oe7JGvCIX/g2KgmDdntTXPf4pN3ebKG/JMD/n9ciZh2qbIFNcoFgT5zokegmfLOXvfWT7I3W+5zhvXOwKr/8vfqK3Rt+XUuDPM1hNSspAsjigoqAfSyNRkDfBTGGiMbrAqSKGBNT3EfE2ZqdHLgGurIKyX7KFfw=
X-Gm-Message-State: AOJu0Yyb/k4GjBZouKvr/tz6ik2cuY5KI2Rs/LTap4Csxcv7WFxSi0Ll
	VpMDx3udl+nA+KcBbx1NjImjjaG8FUCTzNUxmFqffpGVVwTbOiQQ
X-Google-Smtp-Source: AGHT+IEko0JSqQuagK5nJLQhpzLNI4UBWf1hkGCMsz0mbLd4XAPdp/+V3f92NeCVpS+QrlY3oDwjRw==
X-Received: by 2002:a05:6871:813:b0:23c:9f74:f6d4 with SMTP id 586e51a60fabf-24172f617ccmr18241288fac.52.1715771786922;
        Wed, 15 May 2024 04:16:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b060f9sm10807819b3a.182.2024.05.15.04.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 04:16:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E407019B4FD45; Wed, 15 May 2024 18:16:21 +0700 (WIB)
Date: Wed, 15 May 2024 18:16:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
	giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com, christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com, davem@davemloft.net,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v8 11/12] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <ZkSZhVz6vyyUt3ot@archie.me>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-12-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xeKKm072pVbJUx/X"
Content-Disposition: inline
In-Reply-To: <20240513103813.5666-12-lakshmi.sowjanya.d@intel.com>


--xeKKm072pVbJUx/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 04:08:12PM +0530, lakshmi.sowjanya.d@intel.com wrot=
e:
> +Timed I/O and system time are both driven by same hardware clock. The si=
gnal
> +is generated with a precision of ~20 nanoseconds. The generated PPS sign=
al
> +is used to synchronize an external device with system clock. For example,
> +share your clock with a device that receives PPS signal, generated by
"... it can be used to share your clock ..."
> +Timed I/O device. There are dedicated Timed I/O pins to deliver the PPS =
signal
> +to an external device.
> +

That's it.

--=20
An old man doll... just what I always wanted! - Clara

--xeKKm072pVbJUx/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkSZgAAKCRD2uYlJVVFO
o/6oAP9w3HhiHmrFlOlNQ8EunlgWag4y2WHPIAlhy2UNCHLgUgEAmmZbh7KrfLCK
neKfTlKuPupWFFMWIJvouCJXmLae8wI=
=GWg5
-----END PGP SIGNATURE-----

--xeKKm072pVbJUx/X--

