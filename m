Return-Path: <netdev+bounces-81207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B508868D4
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CF9B213A6
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E217998;
	Fri, 22 Mar 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dw1XY4uw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC51B27A
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098430; cv=none; b=mC30UNFw0imB0AAKoz/J2a2YTyBuXaNBMoFcU2dVrCK77WBlekPuywpW/M1y/CUaiskbjr+Nky6E1gXlsp/naI1H23BqwH65BOT9DlURVeC9oMJAAP/mGpzjqFiEOLhlre5MAYzK1jbnt66vRpyUIGUS3WpUyvsoVwTFfP/DrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098430; c=relaxed/simple;
	bh=ckM1yjsNdnAhI9KHitrTScCo5NMHoXqPrvYCFgLR55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxjA9M3E11mVTJ3DAxlkHQABmzt7jZ9WElm2ewNW0Dil343xm4b/AZ0jj3S/qbf5IU70ZtHGcKd8qZaMrCvOVva4k/AxYbg8QJKCkXxGnsw3oRIpHm9iShAnX2oPfk4B3+8qG8oX2Gzvsl6EXUElwOgY1CwFq5OT4b4+EaOTGNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dw1XY4uw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so2139277a12.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711098427; x=1711703227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WASuD8b7YYuT0WbneHXQ0rduLZmU9Or7PnSuu/PV2KE=;
        b=dw1XY4uwYq714QMiIqx35lxEgTEBshorM65mSgKiSWcSc17963w0DgWiHXguBCzOma
         NWgfNWlx6O8K0akl7Eiso6TBIhHurUQLEzMIz7hHfpgh9Yl/3zcKSiD2N9d36dPnevxT
         W5kKJmxiLkjZ3ywzAL4x6g/HQlZJlskG/91mTRVsI2PbvrsTTAy/E2XJscGBIvEX7Len
         9SnUHk1KWIqOpQ3BqaQFRuxkC0nHaQSrPSa8ULOVp6rc1C+TZpy+yGLfDaGG7Svbh+d2
         8h8Uf9HnjTUVgPAHYQoxKCD4yHQYVy+mQ/hKIpm5X6irxx4xQehZBpLvBZEnHY00KQcM
         YQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711098427; x=1711703227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WASuD8b7YYuT0WbneHXQ0rduLZmU9Or7PnSuu/PV2KE=;
        b=rCcjN+wLky/lnijoSo/SB9DmeHWilWf3vWzgP3PEBRZiehav/QY6vXBTkFyn7EU7en
         A714eQQngUujiN+i/TT8gXxUcn0BKoK5xXSJk/S0kQc7C2BzkAPvvpG+Kn2QNFdBf0DC
         YOOgTSO1lU6RfvNa1rV5AvReYFRT96T7Jx3l0uZzKgtNZ/VBOcFWOFX9/3i8rmknkIN4
         /PoltudKLN54Imt5NgllptYt8T1/lMw8I/YNjxoBKGtGnrF14NYci9DJag4Bto9r1xX5
         PxRRLLxQajw0UKcAbORhOn0y55OVqPwqHBwcEU2kfBq7IaBIowRNAOfqzYgAetcs9ye5
         VmAw==
X-Forwarded-Encrypted: i=1; AJvYcCU/b5hU3uN2EIRHBCbFe8mkmKWIamhnCivUkYY3GinXzYx0KGHfakhuK6H7fwApwJq1Erl+la1qWaD908xznzb7gkQxjUp5
X-Gm-Message-State: AOJu0Yw94ujbGtdGRUUMXlj5gTYa2iaPVrz9X91VAEAREm8Y2Oi+1z9i
	HfPRA65laPotcufSI052hMGnVsGbJbDUnzL3zacKHmRZ04MBTJjCsNrgC+mZuvQ=
X-Google-Smtp-Source: AGHT+IHTkTRV2dOZZM/bXoOkJ/vuu0Naz73NiBrGLHNu0wLJfsEGN0u1dfmKEakFdvspolttjTnGXw==
X-Received: by 2002:a17:906:a2d0:b0:a46:ed50:5059 with SMTP id by16-20020a170906a2d000b00a46ed505059mr1224446ejb.28.1711098426772;
        Fri, 22 Mar 2024 02:07:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906c28200b00a46d049ff63sm795511ejz.21.2024.03.22.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:07:06 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:07:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: pseudoc <atlas.yu@canonical.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	hau@realtek.com, kuba@kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, pabeni@redhat.com
Subject: Re: [PATCH v2] r8169: skip DASH fw status checks when DASH is
 disabled
Message-ID: <Zf1KN_YYg-LrCQLh@nanopsycho>
References: <Zf0-cXhouMkgebDR@nanopsycho>
 <20240322082628.46272-1-atlas.yu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322082628.46272-1-atlas.yu@canonical.com>

Fri, Mar 22, 2024 at 09:26:28AM CET, atlas.yu@canonical.com wrote:
>On devices that support DASH, the current code in the "rtl_loop_wait" function
>raises false alarms when DASH is disabled. This occurs because the function
>attempts to wait for the DASH firmware to be ready, even though it's not
>relevant in this case.
>
>r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
>r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
>r8169 0000:0c:00.0 eth0: DASH disabled
>...
>r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
>
>This patch modifies the driver start/stop functions to skip checking the DASH
>firmware status when DASH is explicitly disabled. This prevents unnecessary
>delays and false alarms.
>
>The patch has been tested on several ThinkStation P8/PX workstations.
>
>Fixes: 0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")
>Signed-off-by: pseudoc <atlas.yu@canonical.com>

Please use proper name here and in the "From:" email header. "pseudoc"
certainly is not one.

Also, when you submit a patch, please to that in new thread, never reply
the old one.

Also, please honour the 24h timeout before you send next patch version.

Also, indicate the target tree in the [patch] brackets.

Could you please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

Thanks!


>---
> drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>index 5c879a5c86d7..a39520a3f41d 100644
>--- a/drivers/net/ethernet/realtek/r8169_main.c
>+++ b/drivers/net/ethernet/realtek/r8169_main.c
>@@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
> static void rtl8168dp_driver_start(struct rtl8169_private *tp)
> {
> 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
>+	if (!tp->dash_enabled)
>+		return;
> 	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
> }
> 
>@@ -1324,6 +1326,8 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
> {
> 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
> 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
>+	if (!tp->dash_enabled)
>+		return;
> 	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
> }
> 
>@@ -1338,6 +1342,8 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
> static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
> {
> 	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
>+	if (!tp->dash_enabled)
>+		return;
> 	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
> }
> 
>@@ -1346,6 +1352,8 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
> 	rtl8168ep_stop_cmac(tp);
> 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
> 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
>+	if (!tp->dash_enabled)
>+		return;
> 	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
> }
> 
>-- 
>2.40.1
>
>

