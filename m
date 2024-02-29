Return-Path: <netdev+bounces-75961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC486BC7E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DC7287F1B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E0620;
	Thu, 29 Feb 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ej2Br3md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05E7E5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165052; cv=none; b=bwoOpW9fb9U056A/WxegKQpUUUmWQuuM5/TqigKz56GWm8NG6CBhrk9JUYcdu4+AumzRwI1DJsdDuVY1j1RkEzr95Fy1O+zriKE5yf7MAmf94K7Mpx22MT3yV+noOjZwHukreOqo4WUPOWKlj+Ag9O3LizL0v+c+EP+xPHxMEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165052; c=relaxed/simple;
	bh=BlRDOZg+zYl2/c2qiWKrfWwMo03Qg8kTaZE9gXkvdu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqHYvj8/YiMo8j730+byEEya/vz62c709jPgvxn9gBh9zBM51cEFEbNKaEspqJRwBsLy+uVr+JL3u2bgZONzg4js8lMwc10W+WspfVSqEJXy/UCedryzTFCRwGzTkXaBpR4Q20qPGIzZbTWplCjgeqvy5VLFuWY4An4i19ndSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ej2Br3md; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-365be6563cbso1377605ab.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709165050; x=1709769850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUj5hY7aGRQbXDULaVrC9+/HHDaRLDH5uHjbAmT9VvE=;
        b=ej2Br3mdLKng8neAkFwC+buS+Nrzprbo7zYRo6DIoo1kCwIFKUscjKNY5E47CkeSNz
         JWoiR4JVpeIpqIeL7S/PiaAyvNQmAFAFFHHg1lNwtnYkKR5JTyIVExnEUxkU/t6pnt13
         dqUG7x1jK3hr33pDMSJFbgexd4EGt8In09WqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165050; x=1709769850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUj5hY7aGRQbXDULaVrC9+/HHDaRLDH5uHjbAmT9VvE=;
        b=JdVKm+aVUyroKMOeZUzwOnWk35dfsf1C04FXpvIXLHGURzLNasSoso4uaPFR/jGcXx
         Y81vSr8kbkak/ujMmdaezgjmiQrjwu5pe2IYkS/SUpYGNcB6JdXojMoUv+4ivasrOpGl
         8AOND4IvOlZRIq+9cnT+scr2ZB+VPYOJzyXd/W9NZfOFVrk9hFBHJril9mgALqd1N26G
         SzLUz9TlRo28YEEAU7jURS4bqRpUai+yVoSrTFim8tSitVsIUE754Apv/oA5aBe1V8TK
         /fz1Ps4phnhm4hR8FXccgNkx5s9d6/LP0YZBL6rlvUclGPhnrcYcEQFLu56kINo5997v
         DPnw==
X-Forwarded-Encrypted: i=1; AJvYcCVXKIFfxaY1p2aDhmxKSpnMnNe/GGst1pkg7xxONj+E28rddfI2M1yo81SdimGhcuznEC5veP5HJhQJY0GUmqNgoSr7i0jc
X-Gm-Message-State: AOJu0YwxHFKl91KXynUsxXhfd+2G+bSf+ZGWUzYGxJLacFMLIFIsElXP
	qSwNe5XTveXiCfMu71F8NmMWVI1ba6qOpfiicjuMK7x+1taLC6VkzMOugZO/nQ==
X-Google-Smtp-Source: AGHT+IHMceGOR/TqQRDwpXXUp9zn3ZRfO8HssBUzlpIFHIoDWaL+0rfSEW9cDWBqvWkjRiWTEC2RaQ==
X-Received: by 2002:a92:d312:0:b0:365:1a59:dd6f with SMTP id x18-20020a92d312000000b003651a59dd6fmr846556ila.21.1709165049874;
        Wed, 28 Feb 2024 16:04:09 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00199000b006e56b4e10bcsm34291pfl.53.2024.02.28.16.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:04:09 -0800 (PST)
Date: Wed, 28 Feb 2024 16:04:08 -0800
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
Subject: Re: [PATCH v2 3/7] scsi: qedf: replace deprecated strncpy with
 strscpy
Message-ID: <202402281604.C50A4D9@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
 <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-3-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-3-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:03PM +0000, Justin Stitt wrote:
> We expect slowpath_params.name to be NUL-terminated based on its future
> usage with other string APIs:
> 
> |	static int qed_slowpath_start(struct qed_dev *cdev,
> |				      struct qed_slowpath_params *params)
> ...
> |	strscpy(drv_version.name, params->name,
> |		MCP_DRV_VER_STR_SIZE - 4);
> 
> Moreover, NUL-padding is not necessary as the only use for this slowpath
> name parameter is to copy into the drv_version.name field.
> 
> Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
> instances (one of which is outside of the scsi system but it is trivial
> and related to this patch).
> 
> We can see the drv_version.name size here:
> |	struct qed_mcp_drv_version {
> |		u32	version;
> |		u8	name[MCP_DRV_VER_STR_SIZE - 4];
> |	};
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

