Return-Path: <netdev+bounces-155242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7FA017ED
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 04:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D6E162DA1
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 03:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0081B2BAF4;
	Sun,  5 Jan 2025 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="1zt+pIGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AE79C4
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736046722; cv=none; b=S0tBxcd7ET9hnMBmVuRfDw3ZyUGgXvX1tK6S2RnqOIypQ5WcY+8yQboOER3pmX32Ism0WFDN+axmxR5079LYClzegBts6fnIJuWWAGNsof7yejbQ7fNCj/3rm5dOqfwE0XocnIGqlszYulUGkKsptjg9UpOJa8bD946OsgBMuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736046722; c=relaxed/simple;
	bh=M3afHnIhzsUhE8ReudXne5D0ZCeB+7ZH4XgZGQ+Usyk=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI9SXMQwoFNlC0BHlubDz5diB3LzfMMFIdKZpUl1UfXcewIxIWTRiB1gGSQ7SGzS4f1mWT6B+S0Gp2+/OeIgIZIgOaQ++H5gMQSFRQ2/a+Lke4Uexc9SPNSRJ6i8FsoLaK9SV+pewMQEtAPwGFyaruHREg+up2fkBVEPgmnoyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=1zt+pIGg; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21636268e43so199215ad.2
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 19:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1736046720; x=1736651520; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDR3T6pH6nRTD/JerXo9CJlXcHOXM/PRMjal/6KsAz4=;
        b=1zt+pIGgSZPyuAYEhb87NsD4svGxRrDegWxc6ophFf6v2E9/Tsi/N+Jwvn7BQ9Jtvq
         o5ALB2bssTsd/ZZM+X/In4OwHPER78KmuY12vyJ+WdBXBDBgzsvbmzi9Q0Ot+V/J3h7c
         VnBcO5T5V1MhTupqcLnmQF8d+iWd33EbdGgLAQF/NHntoRlaX9z0Vds0C70yrGLhPACh
         WsUZ5xybto1XZ15suuwOengmXA3cbtFUdz90B/54mVV7FxxOkQH21kZ83Nutzeqw5Fp8
         w4/ncgkVXzewBQTlQiFLWQTUDEuzAA9Bt4fcE//QTKdUf3Smwpv4q9GCHzqt3aD4X73G
         dRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736046720; x=1736651520;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDR3T6pH6nRTD/JerXo9CJlXcHOXM/PRMjal/6KsAz4=;
        b=vmgs4YHtPT9ye8ByHv2ExASqqeHnH3r+/RsbzD+P7FfCtcgvj2MWSygRONt+I8a5hg
         5VLvi98FMIshuQDAeJEMFK8SL4qAHjLriTzYVae4ZsnZPhQbNxO5LgSnB6rhLum7rSc+
         LTfaOIiRS3HhX8uHOOAqVWvlN2PgRmtGbYbNIeCsV310qB/9xnj6KEBcA0YaXc6pMNLI
         y95DpypZP5yIF+TT9VOp1MqICdQb0ezlDFy8V0pyqrSwMsjqto1ECLraCqWXRVok88tZ
         j1lyB4CP1YO5O2pSsFTuQxZT+czj7BfnXfsDhxcmwzHtMxDRYIrzrcwJF73C9xH22x07
         SM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRJ9FzqrAMNM7izeZrt0WAvKjOnrcWFBiB8Jdx2g9viD98jukaBHnRU7F/cd9JIyq2Ni0OLOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNhDf8jdPWhWEp6v9wpI/oQShfDx8WCHUYqW9qBN2mlMrYQOO
	ahS23dUs6LJPWGzvefHB9a5vt5sDFq5hgM4wev6WInCXAgcuk7Lkpr8w5iJeLMY=
X-Gm-Gg: ASbGncvcb+yVA7kQS8DZKwmiAjjeYCUpeJQn8IrbsPng3i0qtbJIvmiWxKyZz58/ZB7
	+zVn3x4uzYixXyCWkPTR9Hz/vi/a+05Y65LPOg+M9ObLN0LRpNTKXNP+1JrS+LeWCqrczcjsl4G
	rnM0Prz1SMLEScpr4GFZtQB26NOhNgBY8dVIyWXo1djLybfbHHf1L6aASRZDIUwjQHNcfCG0NGG
	2CGJZlUIcDXp8co+RqGcrfoQYbMDPlH4Oeu9R+l92pg4G66XoF2VmemBhzAj509ujCDzA==
X-Google-Smtp-Source: AGHT+IFVOq+5ZpJK8KCyjSLukqdk4uPWLm20OWriSYxw1WaFF6Ex6pHYezqhg7QlXtseajdHi+Oo0g==
X-Received: by 2002:a05:6a21:158c:b0:1e1:faa:d8cf with SMTP id adf61e73a8af0-1e5e0845137mr88336792637.40.1736046719754;
        Sat, 04 Jan 2025 19:11:59 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:e251:cb33:f243:5e25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbaa6sm28703502b3a.91.2025.01.04.19.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 19:11:59 -0800 (PST)
Date: Sun, 05 Jan 2025 11:11:48 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [PATCH net-next v3] dev: Add NMEA port for MHI WWAN device.
 (mhi0_NMEA)
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
	<johannes@sipsolutions.net>, Loic Poulain <loic.poulain@linaro.org>,
	netdev@vger.kernel.org
Message-Id: <O7ILPS.XTBPHMHF1UMO@unrealasia.net>
In-Reply-To: <c8817188-00d0-410b-bfc0-c89fb4784b84@lunn.ch>
References: <PVOKPS.9BTDD92U5KK72@unrealasia.net>
	<c8817188-00d0-410b-bfc0-c89fb4784b84@lunn.ch>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Andrew,

Yes, i was using geary client to send out the patch. Will send out 
using git send-email

On Sat, Jan 4 2025 at 06:35:06 PM +0100, Andrew Lunn <andrew@lunn.ch> 
wrote:
> On Sun, Jan 05, 2025 at 12:38:13AM +0800, Muhammad Nuzaihan wrote:
>>  Based on the earlier v2 and v1 patches. This patch is a cleanup 
>> from v2.
>> 
>>  Removed unnecessary code added to "iosm" and "AT IOCTL" which is not
>>  relevant.
>> 
>>  Tested this change on a new kernel and module built and now device 
>> NMEA
>>  (mhi0_NMEA) statements are available through /dev/wwan0nmea0 port 
>> on bootup.
>> 
>>  Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
>> <zaihan@unrealasia.net>
>>  ---
>>  v3:
>>  - Rebased to net-next main branch
>>  - Removed earlier patches that added unnecessary iosm (unrelated) 
>> and AT
>>  IOCTL code.
>>  v2: 
>> https://lore.kernel.org/netdev/5LHFPS.G3DNPFBCDKCL2@unrealasia.net/
>>  v1: 
>> https://lore.kernel.org/netdev/R8AFPS.THYVK2DKSEE83@unrealasia.net/
>>  ---
>> 
>>  drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
>>  drivers/net/wwan/wwan_core.c | 4 ++++
>>  include/linux/wwan.h | 2 ++
>>  3 files changed, 7 insertions(+)
>> 
>>  diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c
>>  b/drivers/net/wwan/mhi_wwan_ctrl.c
>>  index e9f979d2d851..e13c0b078175 100644
>>  --- a/drivers/net/wwan/mhi_wwan_ctrl.c
>>  +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
>>  @@ -263,6 +263,7 @@ static const struct mhi_device_id
>>  mhi_wwan_ctrl_match_table[] = {
>>         { .chan = "QMI", .driver_data = WWAN_PORT_QMI },
>>         { .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
>>         { .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
>>  +	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
> 
> The indentation is all messed up in this patch. It looks like a tab to
> space conversion has happened somewhere?
> 
> Did you use git send-email?
> 
>     Andrew
> 
> ---
> pw-bot: cr



