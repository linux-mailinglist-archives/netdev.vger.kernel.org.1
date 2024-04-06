Return-Path: <netdev+bounces-85465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E889ACD5
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6CD1F21901
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF39487A5;
	Sat,  6 Apr 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4OZusQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E918C1F
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434508; cv=none; b=QaDR0gRiwD41By9l7T2SowBXsgu0RWLKmTb1ivrLCyJGevSTj4gBa8aKvFFwyXmBvSQhd27j7r2mT9LQPBufEMPXl7hXoNDQ2TwiKi2f2Z8ryin8V2WA6fBXgYuvqxGzq96m0PsvWhNoNK4AmWgwGs261vAmreazmYn1Z9lZMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434508; c=relaxed/simple;
	bh=dsZw2JudTZgLn49oR0YEfknMULbqgQuNo9mIWl0r2hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tG1BWqxiNDfuxJvaoSu0M62Xf8agt/VwTHnh2uJ9r9TYeBjp0Sq7TrFXQZmsyFeKQQ8AbRzVGKjPu6peT8gP3f/sskujzztt5wO5rVENE3z31QDA56Cv2NBTC5HlezqvXZ+wNpxsmBE5vP/YJO9dW4iVX9H7IsqQW6b1IAup3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4OZusQ5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41550858cabso21023265e9.2
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712434505; x=1713039305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VSLHNQwaEU2eYbq3iq99aVvVXWmv+vz/6yQBBbLy7Kg=;
        b=I4OZusQ57yRMtymMU4DrNhIgHUQdpNAyjAgEPWPkMtnOUz6bUe8cKdOzb/U2wHG36C
         Ku2lilKTLfyqnty9XXHxJHb1VcKLzp1QWYbD+GSU+0iUZi14NcJu06c6iNTtq8yuyE3g
         rQliRsesPHvQ/Asy4CtpCj86Mppcu1N9EKaSy3ymqT26A1E0V5MKBzXyKZSG6siH/DVd
         Elo0jRoM8iauVCggV1roR95vqRqPfp56SwSIyuG34m+rxeZkmtxu1KFmqY5iKigme+8k
         WEwwOZmyLONSz7HbbU+48S5Zg8/QJtLR0l1clm1ey1bsbGnkEHPF+08yYHIJRpRWJfb7
         U7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712434505; x=1713039305;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSLHNQwaEU2eYbq3iq99aVvVXWmv+vz/6yQBBbLy7Kg=;
        b=l5R4XpvOssm9FiBRb4A/6zjJ/rFrLmebnn1SWQOB5YhwoYnu4a/hdZVlmm8Cpfkeu2
         Hv+SPLR+e/De31KjvOkGN4l/A8/ciQPAuniGVl+UegJEzLnW9u37b351K39EE+xjELEe
         d2jlm4gTqMyjgYzj3sFg9sO2Oy9X3UYikU7jpdmHG8uUguKcsFdrTphq3B818kT5stj9
         2PfpzAa1MFWIhQe9ntClYG1GFAy2Fp9L3xUKDqm135LXytpDglTPW871mzh86M3uFqp6
         9T9lGhqHNsgWODTTHMgqh/jeJ/uTCkAMZ8ed9E8/HlVLv8HApuEoSshRGkz52sgcAl/3
         kxIA==
X-Gm-Message-State: AOJu0YzF3pXkKMmXw51PS6vkaF7CXUM6E+GvleH9pyJC6A4h6M8jm6jJ
	VvsV0eyHyAuU79Hg1p6yDeE/pamxfF41+oNwE4Fb5yY//wH9n4bpDTXrsTSE
X-Google-Smtp-Source: AGHT+IHvbFatmNJn3R6J6I8KGvr1fZMzKmOi2XU52xSO14TiDj1pxewZ1lJ+qId/QQn0cVDC55Dntw==
X-Received: by 2002:a05:600c:a007:b0:414:93df:bef1 with SMTP id jg7-20020a05600ca00700b0041493dfbef1mr3654119wmb.39.1712434504403;
        Sat, 06 Apr 2024 13:15:04 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9072:5c00:7038:9efc:32f0:4d2d? (dynamic-2a02-3100-9072-5c00-7038-9efc-32f0-4d2d.310.pool.telefonica.de. [2a02:3100:9072:5c00:7038:9efc:32f0:4d2d])
        by smtp.googlemail.com with ESMTPSA id v19-20020a05600c471300b004157ff88ad7sm7677072wmo.7.2024.04.06.13.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 13:15:04 -0700 (PDT)
Message-ID: <8bacfc9f-7194-4376-acf7-38a935d735be@gmail.com>
Date: Sat, 6 Apr 2024 22:15:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: unknown chip XID 6c0
To: =?UTF-8?B?0JXQstCz0LXQvdC40Lk=?= <octobergun@gmail.com>
References: <CAF0rF3oUX0rb8eKTc94D-fF5EWM7nVAAFJM_VbH_wte8FGcJQg@mail.gmail.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAF0rF3oUX0rb8eKTc94D-fF5EWM7nVAAFJM_VbH_wte8FGcJQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06.04.2024 12:15, Евгений wrote:
> Hello.
> 
> lspci -v
> 2:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 2b)
> Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
> Flags: fast devsel, IRQ 17
> I/O ports at 3000 [size=256]
> Memory at 80804000 (64-bit, non-prefetchable) [size=4K]
> Memory at 80800000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [40] Power Management version 3
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> Capabilities: [70] Express Endpoint, IntMsgNum 1
> Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
> Capabilities: [100] Advanced Error Reporting
> Capabilities: [140] Virtual Channel
> Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
> Capabilities: [170] Latency Tolerance Reporting
> Capabilities: [178] L1 PM Substates
> Kernel modules: r8169
> 
> dmesg | grep r8169
> [1.773646] r8169 0000:02:00.0: error -ENODEV: unknown chip XID 6c0, contact r8169 maintainers (see MAINTAINERS file)

Thanks for the report. Realtek calls this chip version RTL8168M,
but handling seems to be identical to RTL8168H. Could you please
test whether ethernet on your system works with the following patch?


diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fc8e6771e..2c91ce847 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2227,6 +2227,8 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		 * the wild. Let's disable detection.
 		 * { 0x7cf, 0x540,	RTL_GIGA_MAC_VER_45 },
 		 */
+		/* Realtek calls it RTL8168M, but it's handled like RTL8168H */
+		{ 0x7cf, 0x6c0,	RTL_GIGA_MAC_VER_46 },
 
 		/* 8168G family. */
 		{ 0x7cf, 0x5c8,	RTL_GIGA_MAC_VER_44 },
-- 
2.44.0



