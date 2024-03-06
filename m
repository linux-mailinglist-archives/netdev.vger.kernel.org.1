Return-Path: <netdev+bounces-78163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C58743C0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137A01F28AE0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B21C2A1;
	Wed,  6 Mar 2024 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw/qd/Of"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBDE1C68D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767087; cv=none; b=dgflhmOdYaw7CnAr+ZPtKJ3pJLh1XD4xIr1fOnSUaVbusToO89TpEmyEbv7geneJmuVYj1EGkWBJO31/WOmQp39598m1q2kabQKwz+8GiEjdPq3P/1SxOCWeg9b1UiagXNDDBUcTXmP3jXlqmhzf+VRT9vwiewBhVXLS1GkUEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767087; c=relaxed/simple;
	bh=Q3dWPd+qYT+wCw3qr5TqnMmEjBc23easzx/r/ncvw/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUhq5uCAoc6rfARN7DNik+yM4tbZOJPH9AvBFKPQ5nOy2XqV+SsDt4/0Z8kJOvHAKRH8uWpsaYAzbCS3xLzrgVTrP6HbNlNZsot18EB9++BzXgD8qoHrJFVrH6fRA4xHkRO6MmS3Kq5eQkNnm1Wz71QFlrdt/EpBJHCXhZ21ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw/qd/Of; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso188156a12.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709767085; x=1710371885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKbFcYRbMoX3sj1Us04QcfL64qivVrZNJBgnL0LAltc=;
        b=mw/qd/Of7hILIFipbAUJeQLBOKDIUf6qsK91Y926UmTGwjd/guveeiSGE6WPJAFIKR
         uywws+oExv1SYyMdcmLVOx3v5Xb0sLaGOlJT+9D/8rmZBLdrGT56OcwVLvxVWQ2lyU7J
         z6wlMTTL42kSz8qHDLUBazqtboFaRTUZmDDNblc++7QEgZf1QsGhwbVOFy65hM+Wy31k
         JEXUInm5c5UFzuBJ4cqp9psIQ5lh/PxVL4JKzogRtMz8vRfBEGz9ML9yiJVX8mUPfUV2
         x8aOIE2rMk/aJZ6Fv5mDnEZNNDimVu9rk+IEQLjUQeIIIs6L6id+2J+WQV0Qg5d71Zx9
         YSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767085; x=1710371885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKbFcYRbMoX3sj1Us04QcfL64qivVrZNJBgnL0LAltc=;
        b=wZaBw3k3wlXxtDJibJeABut0zGAzYnTPeJDhU+FLKlgx5Zc6bgmPJenOtC54Vitqas
         OqDOV8TbGCdLUhKJzgHYbsGLmB7CChRQ4FB3Y1hEGMXBV5wNxVYy1IZ/YEw3kAK1kD89
         d+ssu8cc+9KmK+IM3secQQiDrUL70hDhXwv5KdxJGjbIkbZRbQ2aZpDKNvmo0zDQdR5k
         +OJlUGGeXl/j4sMtuCSxPiBYz6O9Lo8DbI7/CL1SZsmyLJVpudvKUtbd7yf3NFTaHP2t
         301zbpChZtqJ3ZHqEXnXeZonvS7/ngpJ6nvn4yEXiu37nnYN9zI4yxVYMBuTllNYcJii
         xHcg==
X-Forwarded-Encrypted: i=1; AJvYcCXQunVEYHoGA4WY5L4zsv0sEQLyHYPRQ9/4K2Y9dFlPYu1rhPFs2yPpoi5AdfsJT+x9qbX9Se2SSxkbQVUTcQY52cE3GoBD
X-Gm-Message-State: AOJu0YyxCp5AnZ7Sad/Hqbu/T20QHJejRZbuHOby+GUiFPCGXTLamWKg
	dKxFgHkzH6bLzz7z3g2Fzi1xPG1EcbVBrX0LALdxf+rIeaqYTN18zyVDq05D9zE=
X-Google-Smtp-Source: AGHT+IFovH2td0ffrTTbX6DJnSvR191yPw22kblpV4FSrKhzgZi4YXQ1YxYcV/CU6QVZWSwOkaz+bQ==
X-Received: by 2002:a17:90b:3595:b0:29a:67fa:7bbf with SMTP id mm21-20020a17090b359500b0029a67fa7bbfmr12883880pjb.43.1709767085006;
        Wed, 06 Mar 2024 15:18:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gd10-20020a17090b0fca00b0029b22d8f5b4sm267293pjb.15.2024.03.06.15.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:18:04 -0800 (PST)
Message-ID: <eead7c7e-aa5e-48f3-a9c5-be7e91ae9e62@gmail.com>
Date: Wed, 6 Mar 2024 15:18:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: update 88e6185 PCS driver
 to use neg_mode
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 02:51, Russell King (Oracle) wrote:
> Update the Marvell 88e6185 PCS driver to use neg_mode rather than the
> mode argument to match the other updated PCS drivers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


