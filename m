Return-Path: <netdev+bounces-130676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC198B1C5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E392831D7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D766CC153;
	Tue,  1 Oct 2024 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELnyau95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA2A5F;
	Tue,  1 Oct 2024 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727746175; cv=none; b=m4uwz5IVs1ko6B8ikQ5kHD65iSgoae0YvNkp/mhhOzLWov+nEmgCxUoVr29Evfhp3KUmStqrvrUWoFV2yqesoHTwQnWyLp9C+SF7EKL/ww7gXjaiyYA5CVG4suul9KWaOqzAL+pisFodt9lWBQdf7cMcJR6ExZExiaQooaQScmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727746175; c=relaxed/simple;
	bh=zMwPUsIL0TiW7zy2ACQDdavwR9Lo0Lxf1HR6upSbTzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fd9S7ERRi45mts4DVIhHWIu51Pl2hZmCIhEejEBiOkW1tzTlHZo6b6qEiVQmEFI4CPOQRvWavSUCfZ5gorCEPKfGWKY4i6fsbuVfs+uZUbvkHOtTW1FM4YUc767cfyRVrKtjVQcBmOx6wHwArKjCML3ozMrV5ysKJiZpiZHUPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELnyau95; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b8bdea19aso13673495ad.0;
        Mon, 30 Sep 2024 18:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727746174; x=1728350974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XbHwflXP9ogfiGstFpWLBFBcDSFbSH2PyE4lpdpg34=;
        b=ELnyau95Tjo7yJ7P5AHjQgB4DcIiSh73WQ9bRIS2enN7+pdTp+R7DRUbKS6H7H2UBj
         XmmXmLALWFtSeNKUiGz3pKFEwcTN3KLoC5Kne+AjjphoAFgHZKYxKBjxXILM+NzUjIJN
         e+lkfBi4WNEki4B4POR0LBNtWAjih2tSJovs4a4QBI1oKopPMOYR338GTl8t0TgMoaiJ
         FpzEm2VxE2/wGJxesqjtH7e2SzV7z0k6yRn2vxqZY98N9PzsBqwjFEe45RxuRTowadxh
         QMuvONvfbNoH4SxLEGYPHJODISrXJ75rTsDm3Im3/UXwkP37KC/vKdfL/4JoqPdRO8X5
         wOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727746174; x=1728350974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XbHwflXP9ogfiGstFpWLBFBcDSFbSH2PyE4lpdpg34=;
        b=w9MvGW7Y524bzQrgbcD+zcMEe05WysU4BwNiiVzg9yAvyViHlyfv8FLV8Y91DstRns
         Os4bnaXsSg7+c3TZ5wWufEGi/UYMlkfDDGCbzosBWdP5aWn8HyguPZg51cLR73mjoq6M
         Vkml/O2d7L4nWZKXnPW77C/KH8jioLlsl7Krsz8MEDO4H0dVPOq/yeV4BojF3pqegDBW
         80uv/u3T0Fd/AGkYw+/JG+gWrFT8B5UWkpjNk/YCntYNUjFfWXKK6Gq1yxCVcx0srQut
         RAlndxuXi2sQzQQGoq/HZTKNxxwRVSbxmSgHPZXmGBiJ9UfW/EfZFtDG2nmMeeNMGdn/
         ffPg==
X-Forwarded-Encrypted: i=1; AJvYcCV/ssaGL9+NTaDWqSIYlQR6j4WKKNb/u3I1NKDWCAL4YYRVcL1DbmMO5NbU7MpkLUMwdczhI3w/@vger.kernel.org, AJvYcCV7RidB8GlBkBWN7rwRYzxNtbt3SmY5hiANjMsyWRtVB9lIC8ZLh7SZfIHktl5YRcwejMuNlQLyymIlupe9@vger.kernel.org, AJvYcCXHhSwO9P7g7j4eMXIS2h/Qw+VLcQLbeOLi4sLBBeCXQTS69fn9AckXV1ZVRSPhyeLQgdbFTXS+H9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4JHK1Ij6cG05S9sfodq1kfuPIBSLXMT1ZyLA4+7na8smOQ1gy
	mC65JvqhC46BYq2ZkBHiNaqPDbkTBdvVNMe5YDozqsQXQG88Ujnr
X-Google-Smtp-Source: AGHT+IFKGQOzFoEbWgMhiuiE6AlEp0ALx4lbSjx0QpHP3YevkROJQAlRmfZJFsEt0jCbJ8OcM77Cmg==
X-Received: by 2002:a17:902:c94c:b0:20b:49c3:7856 with SMTP id d9443c01a7336-20b49c37c7fmr158768035ad.17.1727746173575;
        Mon, 30 Sep 2024 18:29:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0fa94sm60067175ad.135.2024.09.30.18.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:29:33 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A9B48451B098; Tue, 01 Oct 2024 08:29:25 +0700 (WIB)
Date: Tue, 1 Oct 2024 08:29:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Brett Creeley <bcreeley@amd.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [PATCH net] doc: net: napi: Update documentation for
 napi_schedule_irqoff
Message-ID: <ZvtQdSkTGHTBU1qv@archie.me>
References: <20240930153955.971657-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmG6sy5wsz/ww8I9"
Content-Disposition: inline
In-Reply-To: <20240930153955.971657-1-sean.anderson@linux.dev>


--gmG6sy5wsz/ww8I9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:39:54AM -0400, Sean Anderson wrote:
>  napi_schedule_irqoff() is a variant of napi_schedule() which takes advan=
tage
>  of guarantees given by being invoked in IRQ context (no need to
> -mask interrupts). Note that PREEMPT_RT forces all interrupts
> -to be threaded so the interrupt may need to be marked ``IRQF_NO_THREAD``
> -to avoid issues on real-time kernel configurations.
> +mask interrupts). napi_schedule_irqoff() will fall back to napi_schedule=
() if
> +IRQs are threaded (such as if ``PREEMPT_RT`` is enabled).

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--gmG6sy5wsz/ww8I9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZvtQcQAKCRD2uYlJVVFO
o3XPAQCFU4Z2VLqBxugMMCr1t9jNP3MNMRln/KSl6faJ80P55gEAhinWX9FcNnr9
v4agg+hZBEKwRjr7mDjc2At3ONv9SgM=
=nbxR
-----END PGP SIGNATURE-----

--gmG6sy5wsz/ww8I9--

