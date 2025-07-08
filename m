Return-Path: <netdev+bounces-204748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4EBAFBF57
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B099426E08
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA241E47BA;
	Tue,  8 Jul 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoREUBop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787B1DFE22;
	Tue,  8 Jul 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935423; cv=none; b=XhKAqG84CjoulJ1H5bE6UAOcgQ8v7bNsK6lApGdgXNRBo1hJDWJDw2K4GZXsRzz5NC8jz43FUsFjb4NkES1j/5nPNbh8hjAaCJvXmOMCU8k5ed59by4ostpLfvt5n5kT1G5DzAR72B8Hvel9uvSnmbL0ujs7T2HC8b1MOQXgT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935423; c=relaxed/simple;
	bh=zNTKRq7aNErhkH8U18q1BjbgmqsaSp0PtB0iNkd7AU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3QOiSjoPoI5onuEHARQW0JLpmYxMYsiYE3A0dTcsxwM4WTZ1eietNU/PzbfMc5JMMdlVeAMlN815odhHZJSBZjgdGerxMsMIRmNXjwZeOQ3p5XGjmyLcg2Tb6EhC5E+vw2006hxZfpwat1ocuHxcSdk5Tcpkwf4bXElfam4Dxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoREUBop; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c8f179e1bso32522695ad.1;
        Mon, 07 Jul 2025 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935421; x=1752540221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSX7rXG/Cb7Iv2C93GcbdXPfzK1jTKmoYKGXzw019z4=;
        b=CoREUBopuU0k0XLyh1NYKmooO8tWe9jM+Svqlt8TMHM2Sw979T0QlTioYnF5gPh5Li
         7GsYNJQ5piPCN0y5zARFh+7IHlR0o5JKp8hWoUecDRFUNJQgsWEAzmFBT1dRjLKDh0sa
         sWXKJBygMRhV+9Q/gWhT6ODJIp5AQDkLjtUmxGq6xACUuDJWAE5kHjI1efKDmPfWO8Hx
         ZZ0mK37A0QpbeVEAKluKghnEY7FPR835id6tGSp3BBX4GEMdH71LBI0WhH1Oin3xmb4Q
         Mk2rK4lmtVf+4gdVNv8TGUV0lKldaAynlZOy8CnA+YMMUDHGG3Dm6QG4kjWhiD3Tts+V
         zvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935421; x=1752540221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSX7rXG/Cb7Iv2C93GcbdXPfzK1jTKmoYKGXzw019z4=;
        b=JmbBNx5aDWYyuPeil12I7Gf/rLZm1rhYzk0aoW0LjjfB6Ce1YV1umtFxFCi1kslA8O
         PM6C3mL8W06K1Mc7RPk0mqfVaU3mTaAk7nRkY6S8PaVRzqoVXImXs3YX2iWebMpV7Kyp
         VZ8nZUOXyM5uIvMKgcmFP2KzuFRKeMx/NFL37DocB9CaMaEQ6AKZnYXXQ/FpKLaAB0do
         drZHUvfAjrUJxugMNTaefiFZrKmuYoC34YKpuTAUNJx2J5EDUQu8a51iOwu1PwhSTqF/
         mj1MrHMpvnF4ndOlqP29bLgdPYyDiq7gXxsASuCQu+6k7TFVqfDTJkpRX+y7oZlz9Rtp
         3WNA==
X-Forwarded-Encrypted: i=1; AJvYcCWvFNHzKAGEQMgwpgsAvDnSXMTIAxtY94w1MKvV+rh4HDSXv8GD+sBbV5hqNagksVBH4m8waZHL@vger.kernel.org, AJvYcCXXFEJNt2koFDQjWVSdOeHay9OYsqxu+Sy95kJypoCT4JHeaQHsZC9epQTJQwQinatkInEJNUaJpBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bMugubprjBxtKZ4lq+QXh7rnMRb6WnVdhfTIJrh7QjSO2eyK
	7JAfGRzxThfivksVVYlS2PKAzNt2bStvDXCVxs716hrG+POGSPVkJo8r
X-Gm-Gg: ASbGncvps7YvriMjiyYtJjMFWB9GhcZxXUXDzB0P9RfSMGI07u8VcZv0q/wXRLsoI8J
	YFJTTPaLBl94DWoVwDdZZg1oiaZ/6cPHNmnkHBNVBdvadJYWeYadyX3T6keXckVmnfO7IMlDCtw
	6izxq+MjlxX9bOr7w4MONIoBKFlCLYPhRT/33my79+Smif8SX2udlZHS9gqZF4vXFmPqmIX1aFW
	1KDyiMXUYGo05CnkWGeTBZ5f/j5OlFHiYktiEYUyinr4dFbCAvc7gAHvbpWADSVIa2z3dDq84v1
	y4xIhyAWAnAPZ6synZM3UNVGYcA4MshrlQqDgmC9Xsr7CNPYqFq48vsfiQ2Ztw==
X-Google-Smtp-Source: AGHT+IEAuHP6Svd8Lb4XpqwNEFCuT7DD/C+PIpC3nxFrsbTlP9Co8Vp8AGmR2u2x8S8eo9w2aPZQTQ==
X-Received: by 2002:a17:903:2d2:b0:235:f078:4746 with SMTP id d9443c01a7336-23c875ac041mr222094905ad.42.1751935421299;
        Mon, 07 Jul 2025 17:43:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bd292sm94309265ad.236.2025.07.07.17.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:43:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id ADB97410194E; Tue, 08 Jul 2025 07:43:37 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH RESEND 3/3] Documentation: ioctl-number: Correct full path to papr-physical-attestation.h
Date: Tue,  8 Jul 2025 07:43:33 +0700
Message-ID: <20250708004334.15861-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708004334.15861-1-bagasdotme@gmail.com>
References: <20250708004334.15861-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=bagasdotme@gmail.com; h=from:subject; bh=zNTKRq7aNErhkH8U18q1BjbgmqsaSp0PtB0iNkd7AU0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk5mbpnc/aLfFntdWb+ksXqk7k3b/g3t2Pf+8kl71fJd urti6q431HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ2K1k+M3adUbuXhb7ds6/ rid/fNNL/ne+srxT6a1017R/89+ufSnD8N+FRzxG+9zjCasarx7YvWuDkPKi/kcmDBzHPRJCH4e Kz+UBAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 03c9d1a5a30d93 ("Documentation: Fix description format for
powerpc RTAS ioctls") fixes Sphinx warning by chopping arch/ path
component of papr-physical-attestation.h to fit existing "Include File"
column. Now that the column has been widened just enough for that
header file, add back its arch/ path component.

Fixes: 03c9d1a5a30d ("Documentation: Fix description format for powerpc RTAS ioctls")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index b45f5d857a00b6..5aa09865b3aa0f 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -369,7 +369,7 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  06-07  arch/powerpc/include/uapi/asm/papr-platform-dump.h        powerpc/pseries Platform Dump API
                                                                        <mailto:linuxppc-dev@lists.ozlabs.org>
-0xB2  08     powerpc/include/uapi/asm/papr-physical-attestation.h      powerpc/pseries Physical Attestation API
+0xB2  08     arch/powerpc/include/uapi/asm/papr-physical-attestation.h powerpc/pseries Physical Attestation API
                                                                        <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB3  00     linux/mmc/ioctl.h
 0xB4  00-0F  linux/gpio.h                                              <mailto:linux-gpio@vger.kernel.org>
-- 
An old man doll... just what I always wanted! - Clara


