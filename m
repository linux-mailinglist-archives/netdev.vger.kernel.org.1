Return-Path: <netdev+bounces-75695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7086AEEC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23F11F242CB
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253A36139;
	Wed, 28 Feb 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bAaMqTcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D91F608
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122571; cv=none; b=qHx2JKPC1sTomAGzlmuTtkwylMX21f0z1Cvp3jvdzKYSSMHMxLMd/Q3lDWyy94bY5f3DE2l9AZcSgs9OfezccCsOVeGyCHq1pPErl8bulPsi9fxCDQHm+Oe2SFUMA82iRxRVv+NVSHv+InPOGTjmgKlnyCxYbFY/EjSnQMWwDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122571; c=relaxed/simple;
	bh=p/F1zp09ShV+zNO8eCuuUf8jlkU6Npcey1XTysGtC4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liX1C2LcYTNT0b2aGbD/V/tcm4JO9Jj8+ZNdEa0Qsu1+81O/nfa7/5BH1uw8VpeOMeGBe+Yg9Gbb/9B8lzlfjTK6puEANEIV+hEzTIMxWIVL7vdALu1aS/9J4f77HEmyJfIhvFQoxHLhhcNcyu5oj2IjSUpkaX/XPo7bPQ7rkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bAaMqTcP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so7430479a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709122568; x=1709727368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrLAHlmTxPLc26B8OhByezM02k78+T+AA9Yb2WW7rD8=;
        b=bAaMqTcPAP8bquY993JvHoUhQ6tNhjXJ2JTK++IJ/2SibzzCPJZ/S51iB9DOY67i/1
         dVMRHoqBL8cr3WRh1F3UFMWWpDUfVqZUCTFBD7w+gnE6oxeViijBJdTKhuQzer8/GPJL
         +VMgpHfRKdThXGQjRcqeg1bU1OoNOj6/hhObGR/rBS4b9qpQj/BdcmrnlpgisiI6Z2m4
         Wifr0SpYUZFYIxvyXELh21zO5303qH8RFfL3koPh9VaA8ACnW23kjRbmPONNnNN7bWRP
         uLISAll5A3q6qMmuOrUXm1wy/atNrtFVOhHHTz8cZccrTH2R3K4u61BsLJwchMuJD8sk
         zEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122568; x=1709727368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrLAHlmTxPLc26B8OhByezM02k78+T+AA9Yb2WW7rD8=;
        b=DKmYtfmHShIw6fO09JH1OBsbrYn2HIjf/rSyulXZDn9qorIrdjLKuXGojO+O2MwCPb
         Vu0jYTraS7aCzWAFF7Yi4UBXI9hColK5eUM96dRRgvHy6LpoexMqiQ+UgH9JEyTmPsKJ
         CJd17icGDC5CA5fZGJhAuonoN1n/Rr32mWIaVMGVA0Kc16wUfZO1xpr2vd3gQsFzMMSW
         IBkBk6HQgzUpUIHD3N22iDpWvTuI5IcjEC5SFSDdhAwwvNPveMTIfIS93rwxUPzZRlRr
         4Ea/JkBIcM+8955bcDtKL6G9gXKabMRqyrjZOCdfpF9RvC+BKO2xY0WIZi1UQx8xSgnk
         h8lg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Kv5y6BnJTfu8EMgPSU037Khv8DB7bWVD1y539rk+XUjTe1BgRuBqmSb57kTHcAF8SxdwHD4dAF8f523E0o/dyfccGM+W
X-Gm-Message-State: AOJu0Yx4FX+Njzi+3myHr2AX+yhNq4jPJvH0+GMh3R7YaCFc1m2KVgnf
	YdRCwtHhoyFYtpardCkXZPlTUu4nN9t7v101GiM/uacF4+N6ml/K9mJDO0x5Rss=
X-Google-Smtp-Source: AGHT+IGuRXqWYl7PZQl7MaEOFjQ2toWdm1ZLLzWKUcqJ16rJE/M219GG6wJcDFtX5g2A7EUmaqW3Ig==
X-Received: by 2002:a05:6402:1ca4:b0:565:a5bb:cc4c with SMTP id cz4-20020a0564021ca400b00565a5bbcc4cmr7458162edb.42.1709122568225;
        Wed, 28 Feb 2024 04:16:08 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cx6-20020a05640222a600b005653fe3f180sm1718428edb.70.2024.02.28.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:16:07 -0800 (PST)
Date: Wed, 28 Feb 2024 13:16:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 2/4] nfp: update devlink device info output
Message-ID: <Zd8kBY-pUjKWBGFv@nanopsycho>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228075140.12085-3-louis.peens@corigine.com>

Wed, Feb 28, 2024 at 08:51:38AM CET, louis.peens@corigine.com wrote:
>From: Fei Qin <fei.qin@corigine.com>
>
>Newer NIC will introduce a new part number, now add it
>into devlink device info.
>
>Signed-off-by: Fei Qin <fei.qin@corigine.com>
>Signed-off-by: Louis Peens <louis.peens@corigine.com>
>---
> Documentation/networking/devlink/nfp.rst         | 3 +++
> drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 3 ++-
> 2 files changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/networking/devlink/nfp.rst b/Documentation/networking/devlink/nfp.rst
>index a1717db0dfcc..f79d46472012 100644
>--- a/Documentation/networking/devlink/nfp.rst
>+++ b/Documentation/networking/devlink/nfp.rst
>@@ -42,6 +42,9 @@ The ``nfp`` driver reports the following versions
>    * - ``board.model``
>      - fixed
>      - Model name of the board design
>+   * - ``part_number``
>+     - fixed
>+     - Part number of the entire product
>    * - ``fw.bundle_id``
>      - stored, running
>      - Firmware bundle id
>diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
>index 635d33c0d6d3..5b41338d55c4 100644
>--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
>+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
>@@ -159,7 +159,8 @@ static const struct nfp_devlink_versions_simple {
> 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,	"assembly.partno", },
> 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
> 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
>-	{ "board.model", /* code name */		"assembly.model", },
>+	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL,	"assembly.model", },
>+	{ DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER,     "pn", },

Could this be 2 patches? One logical change per patch please.


> };
> 
> static int
>-- 
>2.34.1
>
>

