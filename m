Return-Path: <netdev+bounces-177671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A264A71161
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919D57A3256
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5219CCF5;
	Wed, 26 Mar 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WshePpSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069B2E3361;
	Wed, 26 Mar 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974086; cv=none; b=SixV7pLYYjMP2P/0/mz3fHfja82/2k8VOg9xaEOSsHhzdtVSlsv1Am80TbvAk7N4j4AsOHGVz8PmMvnYLpnPG9WtqlD63KgHzM3IMQJRlA+8JB+2IM0BEX/pepAX9aDZfBalgY8wahpFJjos2BTjeB+j920DksMCVKwqnx76DPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974086; c=relaxed/simple;
	bh=aPW0GUwtHAHqTGWzRGIHGwWVtaZM9Mu8IlujSEY05Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rg0kS5MizMfRRY9DmGF8qSxGmr/B0nQQuQ8TYehbPYvH4uHVPE4jGIU1FPfphf+t/jXTDzKUmPNmGuu20S0WZHJPrduHl7XAXLVFZm7LD+U6WIZ4xwKV37bdEHO8UdpIdq7bIKX4gTH2TrHNMOXaTXf6Do1X2k2nFzpf733muIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WshePpSH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22580c9ee0aso133147365ad.2;
        Wed, 26 Mar 2025 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742974084; x=1743578884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdDnbn2+KtSc2nhI5d1qMfthKuy6nyBz/SqQxJ+aBks=;
        b=WshePpSHvG1FaI/QW2NAMIcABKGtrh3UxP8NuiGdCfAZMIpzrGjHH1OuKjTyrqPmX5
         IKdBZD9piMyvjsp+5u7G9898ws//guuYgn6SjGcgFNTX3PPdYTSOL4QPB3oaEhK2dJi6
         reOFuBDM4hAQpVR172iRyNLdbqb/MK5ToPWOaZZzMX73KY8LEWCYqGa5aNfnfRiw7ug1
         ge6IujIip9l3qw/995YNvw9Am7Ia2rMQ4l0fRJ9+X3fwzi4Rx67QlfT65DA587PgPLBM
         EsJQ8ZiSn8kfTC9jDDa3u4nMRho3vvH/EaF8xuJzPAKUPtozGcgxJ5UKolofJ7J7SIEt
         IP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742974084; x=1743578884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdDnbn2+KtSc2nhI5d1qMfthKuy6nyBz/SqQxJ+aBks=;
        b=fHtINNMkxQjXQb9kzPciPULtNPvheRldem0YOaJmO6I3kJMUulWMKZBYXS6dqnj357
         pxLbOrkhpum0Xt+TdJPxB+ut0TkhD34Vf5WCnV+FUuRfpnQkk2C+kfr1h+G0pqwpIZsy
         T/fIXXuz7oR9bStZFFaL4joBGvOSpCM9KJ1HHQb3Ej7unz6tZhZ5e3Q9agKhhef/eHE3
         caGZJ76nIn33g5cS5mizCbkUvQlmovTXMSJIHl4zhGpvOmsy6NvvF7sU/tv7GdQetCXV
         1DInwoLO1Kgu/GBBLpwudvKMxQJvMrKEaVAkCNY4tXAXg1zd6IeudVVv6dV7DMbifzj8
         ixxA==
X-Forwarded-Encrypted: i=1; AJvYcCUsph5YLfTcgmittHD2pV+/H0r3vN0dlDyl/z6pvYCUhpTYNimj1rDqONmx8/q9rLnN4Sh3fV8mKrq7TCc=@vger.kernel.org, AJvYcCWPoqzNMLKKLMj9yqPhUmNZ8iiiQ3/tYoimCe7qrBz7h+51QjG0a+naKZeoyFaSx+w9LxeDy078@vger.kernel.org, AJvYcCXQzp2o6zOPfMlw2+WOiCIjx1iG8h1JLi8vKURqq6EY95f29Rw423oLQwi0Ypf0GytKndTkasi0rROt@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKLwRKuaYqkbz8Kaj/660A/SqjG7n+GJlKDhn5PF7IjamfG2f
	X8huKk4/uS+Ji/xptEbz40CIvPGG2a9e437oZYv9vmi69MmBwZepSLHYju+a
X-Gm-Gg: ASbGncvekMeKDOAw9fqR+ro9DzMuBSbCyyIlK7GIYo2WrTMk6rYbDMnkY6ZYDGf10XJ
	LG/VHmOVnvlRboi2GhcxoAnLezptLSBVkbRMdPkwwdHUKSVnqn8aOGnDnUEzHun5l6JIjFC2QTZ
	UACyL35+4xfH83fEcwDIlw2brnv4X2Ymk+FI3XZvHHWveh9RmOrmlHpW3nl4fvswX8lbzNNndmJ
	6WwXRkTQ/PvIV9ABcw86SrRR5GbUI0kn5BhPbl3uvtWUVZ1RuVm2WtYADbm5vBfBG3qgTRknJMt
	nvJePshj2sJ621zGZhDaF3NC3wEstRDBC5crQSgL/mfHrDPWwbSNAg==
X-Google-Smtp-Source: AGHT+IEbccQevATakYXmF/em9yr1xZmBWnF2yrU5sfCt9t5AK+bUGy4mWOKCvKVhScUNHbobz1pxGA==
X-Received: by 2002:a05:6a00:1954:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7390597f851mr29617761b3a.6.1742974084320;
        Wed, 26 Mar 2025 00:28:04 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d3c0sm11431655b3a.89.2025.03.26.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:28:04 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: asmadeus@codewreck.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dominique.martinet@atmark-techno.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	pabeni@redhat.com,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local mac addresses
Date: Wed, 26 Mar 2025 11:27:26 +0400
Message-Id: <20250326072726.1138-1-naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203130457.904325-1-asmadeus@codewreck.org>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,  

I have tested this patch and can confirm that it works as expected with at least three models
of Quectel LTE modems.  


Tested-by: Ahmed Naseef <naseefkm@gmail.com> 

This issue affects many users of OpenWrt, where USB LTE modems are widely used. The device
name change has caused significant inconvenience, and as a result, this patch has already been
accepted in OpenWrt:

https://github.com/openwrt/openwrt/commit/ecd609f509f29ed1f75db5c7a623f359c64efb72  

Restoring the previous naming convention at the kernel level would greatly help in maintaining 
consistency and avoiding unnecessary workarounds in userspace which is not straightforward in openwrt.  

I hope this feedback helps in reconsidering the patch for mainline inclusion.  

Best regards,  
Ahmed Naseef  

