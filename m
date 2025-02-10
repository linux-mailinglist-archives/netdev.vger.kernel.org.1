Return-Path: <netdev+bounces-164743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EDA2EEDB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0212F1883BC0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B895E22FE13;
	Mon, 10 Feb 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eNttC2T8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D7221DA9
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195534; cv=none; b=FNDCtg2J8d2tQVaG2I6vMCItZQTk7BCqfZ77Iqg89oiPSU5GwcoATWD0BYXJEFkmbnjjqcaKibdOioAuMWnf4RoSJvLeEAG8bMwxJOPIHgRINmnlYQqtrwxpYhRgipJcbFusl8M3rzIUFPMzIITf2gPg4I6gTAbiufekuDStGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195534; c=relaxed/simple;
	bh=agN+p1qDjVD/YbUOhNOZQdzS2At2JV87lJYkBMe++Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDa2x/lKekHFWAH4aL2/FJ528WyBrIvexWt38rH6h7L4cT1XH+WZ6rVsWU36IpcaKcXvGRgd34kNDkozSSyPOC23q/KOW4eRYZgr8bCqlMWZcHEqaL+QuK943xixMX/0AU8Guul2xdGiB9VlyoaFyvdPB7g3mL5V1UBAwg+AEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eNttC2T8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so7088925a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739195530; x=1739800330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZQNEHEQAe659xIoT4PLJLc9ZVxizRkVD7tjKwywtPo=;
        b=eNttC2T8j3c/tcEPlb51opH4A9CHGC9ugAsJkrXG7G/YolCP4jgI2EkgN2LJE2se4A
         Ib2xfc59Nmg7TvvDbKGzl5AmwfpPPxpIOic7OZegeZVzArShVbvlXaKqqlSTkOkcR1bt
         n6t7UegrnDeYa3sgGN/GV4DDJxgDMAKJi+BirIWMW0riW8QpQ7zf4+vBOYJVGPDoiUSe
         1pJM1XoIE3/V/beeyg8IVBaNE8IVuXjhcOqnBkNOulgE+sY9j4eypdGRNOEVnbpI8bSI
         SiBs5nwABevh3wLH7m/yifeYorQR/Tl7cYHqBLBLw3hdicYzTnBfolOB5TQ56dJzC25o
         rQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739195530; x=1739800330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZQNEHEQAe659xIoT4PLJLc9ZVxizRkVD7tjKwywtPo=;
        b=eHOioBFo/xQL6eeHyWCYrRBnoRvItdPo6KUg1L52IUOgalXQyFMWXLNAEI8IdTEh5L
         2zjKB2qyNEuAr85Wft+5KbFdlK9wvn4jr7wCoVNb4WQAtcRnCtYhinWeCFtzZxclbpyO
         h3kFRPmixDwOh1Oww4NECtdVpsEn/MJH8OiNR9a0pYdtXgj2d/Gs4WQHBWnWsWvlCIGQ
         oUnbb54Vhf+eAjTBIplf6IlCoinnPnRvA2HjyYbJYKnR93nYnxUKDkRduqaDeGF9CvCp
         1WKqDei0RpW0pXNauCkMnyemzHKZaxsZhFbJKCVa9UABlzHOQ6Qt+0BxZjmhWVUPS5hg
         IKpg==
X-Forwarded-Encrypted: i=1; AJvYcCXQJeqS9KTh4MswI3NDd87UeS9WLh8pe78h42JNYWUfwESo6xIDvPZRCztu7AAzvTr+8Kc7QEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEjgHIC9Cz7oatHsxf7/UosYhlMDZRJ+MhhVOQ/rLxRoAgLse
	74tfj4xZY2kJvws4QE7IGZEXNcWAS9mNGICCgGSywr8o6/VnWQiTt7MDUfXDUDQ=
X-Gm-Gg: ASbGncs0H5VIdBmPsRe3pwlufru1hQtTqPBxuIdD1oppZQcbmRmU+GAsafZOrf+HBYa
	jtZQRzc3CijIr/vkQNPNfERB+U7OfiBkrmOjWiFwb74akKPNr6mHKr8/CrvyO9elMzmSpiXzwYL
	nPVfn0amJj+R+hrKAzVKGG2N3CIBCa7+nnNhb3FjvGFITGMWIJLs1dasBZ8KVTEoK768BWLQjhV
	pLrjTuGEMfsycYJVkJsr6Nfw8CMnfhuFil9uo/0/guhzvD3zLu89az2Yj9dDNu59ecj3vdnOFrd
	Z2WDD9peI4n2uDTmAfxt0LQ=
X-Google-Smtp-Source: AGHT+IEo+Lt+h+TivO7ynglQRKJ9MQHRtOnQvg4NqgdxaL8qUNSXUWAT4vclDvQ4z7hcmV33adyksw==
X-Received: by 2002:a05:6402:4606:b0:5d9:ae5:8318 with SMTP id 4fb4d7f45d1cf-5de450706dbmr32938734a12.20.1739195530328;
        Mon, 10 Feb 2025 05:52:10 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7985f9786sm596196666b.20.2025.02.10.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:52:09 -0800 (PST)
Date: Mon, 10 Feb 2025 14:51:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	Edward Cree <ecree.xilinx@gmail.com>, habetsm.xilinx@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 4/4] sfc: document devlink flash support
Message-ID: <p527x74v7gycii3qfgcqn46j2dixpa62tguri6k2dzymohkeyw@rqqmgs5tbobj>
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
 <3476b0ef04a0944f03e0b771ec8ed1a9c70db4dc.1739186253.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3476b0ef04a0944f03e0b771ec8ed1a9c70db4dc.1739186253.git.ecree.xilinx@gmail.com>

Mon, Feb 10, 2025 at 12:25:45PM +0100, edward.cree@amd.com wrote:
>From: Edward Cree <ecree.xilinx@gmail.com>
>
>Update the information in sfc's devlink documentation including
> support for firmware update with devlink flash.
>Also update the help text for CONFIG_SFC_MTD, as it is no longer
> strictly required for firmware updates.
>
>Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
>---
> Documentation/networking/devlink/sfc.rst | 16 +++++++++++++++-
> drivers/net/ethernet/sfc/Kconfig         |  5 +++--
> 2 files changed, 18 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/networking/devlink/sfc.rst b/Documentation/networking/devlink/sfc.rst
>index db64a1bd9733..0398d59ea184 100644
>--- a/Documentation/networking/devlink/sfc.rst
>+++ b/Documentation/networking/devlink/sfc.rst
>@@ -5,7 +5,7 @@ sfc devlink support
> ===================
> 
> This document describes the devlink features implemented by the ``sfc``
>-device driver for the ef100 device.
>+device driver for the ef10 and ef100 devices.
> 
> Info versions
> =============
>@@ -18,6 +18,10 @@ The ``sfc`` driver reports the following versions
>    * - Name
>      - Type
>      - Description
>+   * - ``fw.bundle_id``

Why "id"? It is the bundle version, isn't it. In that case just "bundle"
would be fine I guess...


>+     - stored
>+     - Version of the firmware "bundle" image that was last used to update
>+       multiple components.
>    * - ``fw.mgmt.suc``
>      - running
>      - For boards where the management function is split between multiple
>@@ -55,3 +59,13 @@ The ``sfc`` driver reports the following versions
>    * - ``fw.uefi``
>      - running
>      - UEFI driver version (No UNDI support).
>+
>+Flash Update
>+============
>+
>+The ``sfc`` driver implements support for flash update using the
>+``devlink-flash`` interface. It supports updating the device flash using a
>+combined flash image ("bundle") that contains multiple components (on ef10,
>+typically ``fw.mgmt``, ``fw.app``, ``fw.exprom`` and ``fw.uefi``).
>+
>+The driver does not support any overwrite mask flags.
>diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>index 3eb55dcfa8a6..c4c43434f314 100644
>--- a/drivers/net/ethernet/sfc/Kconfig
>+++ b/drivers/net/ethernet/sfc/Kconfig
>@@ -38,8 +38,9 @@ config SFC_MTD
> 	default y
> 	help
> 	  This exposes the on-board flash and/or EEPROM as MTD devices
>-	  (e.g. /dev/mtd1).  This is required to update the firmware or
>-	  the boot configuration under Linux.
>+	  (e.g. /dev/mtd1).  This is required to update the boot
>+	  configuration under Linux, or use some older userland tools to
>+	  update the firmware.
> config SFC_MCDI_MON
> 	bool "Solarflare SFC9100-family hwmon support"
> 	depends on SFC && HWMON && !(SFC=y && HWMON=m)

