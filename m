Return-Path: <netdev+bounces-74651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B710786212F
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D901F21CDF
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8471ED9;
	Sat, 24 Feb 2024 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehFNujYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57820ECE
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734470; cv=none; b=uNvf6D6SHceo8GKtrWnQ/IDKKOzFZZi2uLcg1GrEuJB1x6JyNBa/dP6RmN6ib4xwBM7mZETVugkbd1/BQiYTm+yN6JYSifddD7tCqFLr6WsPpKeTvhp4w9gzeYELaaNgMieXgLpajEbhansbYJ7vqH3Yl2kENg0vweEMyoRXGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734470; c=relaxed/simple;
	bh=rgLsaSsKqhDN11XXsl7SBz4QYb2l1KqGudDgv2mpG/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otPeFsNHsNUIu+xs2/NIhFMY+/B+THMwbmyvb0J74iMFXh4ZFzjV8dtHSSfiTTa54c2bq6ypRahfBFy+38n49pDlSyglKCPC2J7xgB4uzevj+Jf5CnufAoaKFegRlG2sl44tafi+9NRu+ENxdZ0tgGibwuHOPp1Xi2YaiY7+yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ehFNujYN; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1097810a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708734468; x=1709339268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jX3JXs6F7q/8BnIOexrzyzqfCwNhMyVCMGgfEA4FEVs=;
        b=ehFNujYNUw3vhiNrJtlQMyBFPNIHICaRgZdOV1wntnBywWgca0H/TZouUgBS3ckXpq
         Sj1HGsAQ1PdUgzyzgsZ+mCWP52fSxnjYDAQQf2a0/F1XRd7J64HdLFetNXg63fK0PXQt
         m8FrqMWptR0pAN/sn0PURDEYG7BuC0snf7Cqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708734468; x=1709339268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX3JXs6F7q/8BnIOexrzyzqfCwNhMyVCMGgfEA4FEVs=;
        b=UZFtLcUx+v0zGQepZ5l+IKzv3bIT+32tQ8TqsI/48wVgJV6KXUtM6J/VLheWjW2cc/
         uvArN1ipxm1dQ1X3109rx/wOgVscjD0f2sXQgoFdgC7qkNCnZ1RVd98P2Pi0V6pIwMYY
         z5v4azdwKWPlNB7fb+8BjCoWCLoV3bxeBGlNuUjMOas4TsY87DU8JSFHR14ilZaIKD8h
         3znIIJxTGW/j4yIjzwhnYFzEWHYQdGbP68nxM/2rrQkbXImlyDJrZVj5NTi+T27zXoFs
         0V7v0dXF1E14tTKfnTligHtprvATFDRFyX9aFxVmE/ihJmk66mtibEQRwog5NA3smA5h
         L5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUH2Tpr6vdoIz2l3LDGSpQdGBiBt/MHUHF8asQybxFZy8lM9F+y5S9mdrZh752E0hDfBvZoJa392dFu6w+h3mGOMoxKPkfU
X-Gm-Message-State: AOJu0YwT3sT02j3aPVuImp6VJ9waMGT8v71wsn2KHG+PdNnCAp+3/RTZ
	ytGHZygEa0FBXv1WYuplXAnr4wGo+zApWxhICUBJ4ZsBdNINpnA0vKOsH9sUOw==
X-Google-Smtp-Source: AGHT+IETT3HwnaAs3jTQFeXYPTU7J+2asNMwkklPlBU3DazlDcRsrwOBcFqTj0a/gtB9u0fJzAsU6A==
X-Received: by 2002:a05:6a20:8f95:b0:1a0:566a:5974 with SMTP id k21-20020a056a208f9500b001a0566a5974mr1427284pzj.61.1708734468509;
        Fri, 23 Feb 2024 16:27:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lp16-20020a056a003d5000b006e4c7aa0ba4sm58482pfb.182.2024.02.23.16.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:27:48 -0800 (PST)
Date: Fri, 23 Feb 2024 16:27:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH 6/7] scsi: smartpqi: replace deprecated strncpy with
 strscpy
Message-ID: <202402231627.13E27D4@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-6-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-6-9cd3882f0700@google.com>

On Fri, Feb 23, 2024 at 10:23:11PM +0000, Justin Stitt wrote:
> buffer->driver_version is sized 32:
> |	struct bmic_host_wellness_driver_version {
> |	...
> |		char	driver_version[32];
> ... the source string "Linux " + DRIVER_VERISON is sized at 16. There's
> really no bug in the existing code since the buffers are sized
> appropriately with great care taken to manually NUL-terminate the
> destination buffer. Nonetheless, let's make the swap over to strscpy()
> for robustness' (and readability's) sake.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, good cleanup.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

