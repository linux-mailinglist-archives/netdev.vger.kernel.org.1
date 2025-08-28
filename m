Return-Path: <netdev+bounces-217840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75082B39F67
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAF5188C304
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528301F5433;
	Thu, 28 Aug 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bztP+PlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560291AF0C8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389212; cv=none; b=Rz8qF6DTHyiIzNXNfhPNWksTxXwunsdfRKr44cSG5x+BZFMlFbGd8g2F20ZdRgKb3GSKBI39ITBDvalsziFARFqjGCRwFbeTaBIMcwVmiZ3UWQzTVeCIlK4kYy4eanX64TyT+zGG8dh0VGGiQrJuchk388hhFKvdjmrjc3zKgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389212; c=relaxed/simple;
	bh=lGhLLyZtsCMzsu1Qq8Jb2fnMFaqIFwyho0PDH4uIsSs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dcykRbV1Jk6dPvf5ybgGadzmObXoMHyQHvRUx3wsxvPYqEM9GVGpAzkjkVBqjT9L2VLf38C+OTx0wYwcldzeHCUEEHeaZtLcapCfy1Dp1IqZRgmhcTCT6zP9nq6+OrwKaAwKVu/Y/KSwqJS367joVEfn06ivXcipv7hCgQ7liBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bztP+PlZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso935995e9.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756389209; x=1756994009; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n+63KcQD6FRBuDootetJfqfZ5jLeKBL3zFlMVXx4oA=;
        b=bztP+PlZGnXTYNX+dflJIGEME0I95bIORyRTI0AWPa91ZRtqDQJmNFBiPV9ADWnx1n
         D/OJz4anxI/bco68miVMRLmG+TyOYmBXPcE3LAIblqSMVd/wGFdWCeZb1CiMF+8PvwCz
         KQg+HYnU/vxzSZOuZ5VXIpbx4yMAdgoBa7sbHSs7GwUebKThrmoJ9w+HImxs5iaw8m7D
         LL0vpb8lSqqqBaKEog2sOiBDga5FOIFK5d0c6WqJaXQs+0lyLbvYDELsN4efWm2temBO
         E/AVZP7wSEUnf82Ftr7tlMRzm+rnBBsrryiEKFElwhWYQU6oD318ahY+78xbCJZhBx/o
         wesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756389209; x=1756994009;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0n+63KcQD6FRBuDootetJfqfZ5jLeKBL3zFlMVXx4oA=;
        b=adkxj6mnon2jSIT2XtZySopxbofo8vr+zvcyrFAleMP67FJYN4V0bQML+IlxsBjq/d
         fmUWPn4gvtPTp8IsROlLlAPF2nB1a72gsgdm0Vvnx1EwE/GzMCFAGaq5uHP65/BnsqcY
         RENweDJc2gp6zWE2ugTivFO7t0Drt0X+sIQ3JHD3icwIkfvtlE1MDSp6cR95JeXuHOvd
         CQTVxQw7J4VWPEegqCrD6K6z/ejkGy2M8zgHFwMsGJMveHwPkXznEibhrX4HYatwEou+
         GspxvzIsMzzxkFxro8Bbje6MqE7EC9o6WhpphBJNk7F0rtAgftMkfH3SgkoY2Pwpdd8w
         2TZA==
X-Gm-Message-State: AOJu0YzKNg5Ngf2iqVmkAHbrulW7F5bOYfoxhdIip46hJaZ7YgAa3JmK
	TsKohLuxeM/vtm7NbcMVqYRbrVIsjWSTWEkT939SNp9bKTct7M17sjJq7QB9RkqWpGY3meYUlvH
	letII
X-Gm-Gg: ASbGncsyqP0q55Fv9R/bgbF6xx9FJzXIOoCYaOFPh7zEZH+OLKf6colbiVXPAVdwq7O
	4r9mUq37euHZ5Pxcftamc3rJNl/0f7Iw6Y/pMBrQOvq8t38qjG+O3A3P5AjtzXgfBJiyJRvo+2I
	U8A9AyqoTRV1b3FTFIQUrkH2lSdTTo/3393hguL7/p2yOXM/uj0clvCfsCJ2qZ+QyR91Z0ZraWO
	y0G4f9iWhw4YBtvH6xBRcpoWis5uOZqBFZzlwuX5rlUJy/f+KQZ1Gd5Hg0BAmoZgl10zbKE0eKs
	zZuBd+xn/HE5g9VAuxZgiyiS9kAv1FJsPvPxPf2Ff0ObMkFV0NLOxBHFZzZWaV7HlYESh46lqHc
	XaTeuGaZ0RhltuYWxawLLeWvcLR3zh1gkadJyG63uBbaqZZo4Cg14EglNQmJVoHwdpFQDe5zMTA
	Y=
X-Google-Smtp-Source: AGHT+IGxsFe7uunyLZD7EgxOzsZkfPuY3RQNyOeNK4qkwcbIkq5Ft0w85K3csil0tzdXCS9kGTKJAQ==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr288637315e9.16.1756389208572;
        Thu, 28 Aug 2025 06:53:28 -0700 (PDT)
Received: from ?IPV6:2a02:3033:262:f8de:50f3:be08:1bba:104? ([2a02:3033:262:f8de:50f3:be08:1bba:104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm9110345e9.9.2025.08.28.06.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:53:28 -0700 (PDT)
Message-ID: <18f621e2-93dd-4153-8c37-f219deb4206d@suse.com>
Date: Thu, 28 Aug 2025 15:53:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Alan Stern <stern@rowland.harvard.edu>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: when to cancel kevents in usbnet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am looking at how kevents are handled. However, recent fiascos
I am reluctant to touch this area. Nevertheless, right now we are
cancelling all deferred kevents upon stop() being called.
It seems to me that that is correct with one exception.
If the deferred kevent is the need to clear a halt, we cannot
just drop that. The only reason we should do so is disconnect().
What do you think? Does this need to be split?

	Regards
		Oliver


