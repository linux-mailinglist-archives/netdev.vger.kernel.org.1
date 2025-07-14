Return-Path: <netdev+bounces-206483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E0B03447
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAE18997B5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCB1C6FE9;
	Mon, 14 Jul 2025 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJgJtZQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51812FF6F;
	Mon, 14 Jul 2025 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458256; cv=none; b=p+p9eHVG2z8rw2ET+N0JY/NL9/CG1LvU2iiQKe8j1FYzQZoImOSslIsF1ICSQDBTzpn9y7hT2HE4hBxAhAMSdhNAUyhNvEzVVz8rQ19+cSw3q/WjGmv//ddRRA9u/1pB44+LK6gDnwfUeVnoBd2Q+JMFcQwDyyjLQq7+X4P5+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458256; c=relaxed/simple;
	bh=Ml6dracZlciGK5OWxXhyxUD5G+vURe2PpzJsaKSDLKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjRK1dD65E9mgQDzApLB5YR1NO6Sdd/zmlgbUHRqFrExWIhhryHv6Mbd1wl7EDQpNyw6drHkFIqLeSLYjq4fM54X/dzc3EVd9GzpbltlknzJA2XIU0duVA9WGky+3xAfx1sN16bWAqHxipdfqYKpeXD6KVp7za6iwOE3x3ee45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJgJtZQt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adfb562266cso657019866b.0;
        Sun, 13 Jul 2025 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752458253; x=1753063053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18fNXUOoTp1B5DuMo79HunXMqPXIfJMdw0LfIba3R6M=;
        b=UJgJtZQtPJFP0kHYUwPxvvoz0U+LCEKKZ60AxRiOZoEoxPFf141vwKOKqMOm0PegId
         4PfUZ+yTbLpyQkMJ4qS8bOsGNNb3KlQWAkpG2tsHlFUmxGIi7oE23c7TKqWSxlRVEUZB
         ZPWWQah/4YJlC4de+XpxiElMGcZPHf5blJsajNDGjKjSVHNe0VZQcorLtPwFjpgcKMqe
         oj8rggZxMgFsyyZ21CROl1lsjp/cDK+q1tC7PbfkhhuLSX59UaNAoHMKvn3xCq4B3l+7
         gL/uvp6a4sV7FX5PWQCZBzPbjTNCV5hZ2rEpe//lWkvDtS/cSX/KoDCJ35KBSC8s9wRR
         TagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752458253; x=1753063053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18fNXUOoTp1B5DuMo79HunXMqPXIfJMdw0LfIba3R6M=;
        b=QzYndsqdEsxLP3yZJywg7Bh6vMQRyRn7nIttjGzE9PMDItHpmvr1xIvbheKCO9eKR2
         lH+E1Hv+r4FfBUfvakwqiycsGXQk4MIzK57NYZ9hgSXNnqJYFL7kihcAS6U3ZOfo2O7f
         dUHTObapGCewMUuYn59DzENolkJKsv883WBiVWeGctcM/K3tp0eWxk5t+7PkCcsNu5l8
         WNfVrz6a33VAddeivb3YDALu43f3b1Z1IO6KyJVlykQm0mJqkiuPGh4CLqVhYO+PwnWD
         EBHfTJVCP/ruWPzoAVpje1FU5tWSCCmZ0ZEek6HpwKjpyW94zaWwH9EwFDOkgOKWS1+v
         IUyA==
X-Forwarded-Encrypted: i=1; AJvYcCUtKj8hvEYlibnthd+0nM6DUx2dGY2Cq0fp/VK41kxd7xtwhZgonLTzDOhUG3ZSHXC/4SRDzWboxIw=@vger.kernel.org, AJvYcCVfmzQ5lM9NQXj1waxXmyc5+b/KiUsdjF5KKLsJXgDP/RN8b8RkvTavjKM23sLZ0PTdujbHssxh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyej02Er4r5G57eEF83wyErlIW245U1NLjlvqUvgk2LaSWBilhT
	3q3fHWEX8bof6S30gyRGVtOPLbj+yphejB4eXCtrLlkhzWXs3nv2Ys1W
X-Gm-Gg: ASbGncvASnwbc9IciRb1wVgrKlolFzZ6ziRk+apdHcqjxoUHWNpLdlEV7tVoODeIiAH
	PYYeF8818No+pbYKLkp5f1q930iuWi65UbWt7D1KubgIddK/Y7KPBumqxZBj6xoVnFHP7JfZE77
	bekaG1x0ssHd9XCXwNz7okb5LbZ2P3RxhrBMtG9tGQCL0KXiHiu3O+mh7YVoWDnxyF8Cm4Ochxq
	xI7HDm8g9bmpbtApzKVBhhMJ4Y4/N98VbaIb1wujh41129CWgqPdNQMsmSxUHxlXiTSxJY+3deK
	I8d2AF9W7gh8cJe294XZsKOI0jpTMjGE9k3sRoQHxFHiyvTcIcEAa8dawXCByyzJvUbQpYfD3zZ
	PiG4Goo7ZvUWjsyhpBesSsw==
X-Google-Smtp-Source: AGHT+IGLxHNZYsNpZfVYl26BiBae3FGliB1xn3y4/hXDGM/4prDAdt7ZERtTvLadQOB6QRcChXSdBA==
X-Received: by 2002:a17:907:3dab:b0:ad8:9a3b:b26e with SMTP id a640c23a62f3a-ae6fc161916mr1243488566b.56.1752458252583;
        Sun, 13 Jul 2025 18:57:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee459asm751575266b.52.2025.07.13.18.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 18:57:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 69382420A818; Mon, 14 Jul 2025 08:57:26 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>
Subject: [PATCH v2 1/3] Documentation: ioctl-number: Fix linuxppc-dev mailto link
Date: Mon, 14 Jul 2025 08:57:08 +0700
Message-ID: <20250714015711.14525-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714015711.14525-1-bagasdotme@gmail.com>
References: <20250714015711.14525-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=bagasdotme@gmail.com; h=from:subject; bh=Ml6dracZlciGK5OWxXhyxUD5G+vURe2PpzJsaKSDLKU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBklSTk1gkfN02L3flzOYZo/nTGBeVH5j30iEtl7SrVmX WI2XdjWUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgInkdjMydCxZnB2ifaNd/rzU K93Paa52Rn/lv76puf7AsOzmneuesYwMb78VVjjGb3gQt2Ghkdnroz9M/kkbZq37aOPxc4KJfUs KLwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Spell out full Linux PPC mailing list address like other subsystem
mailing lists listed in the table.

Fixes: 43d869ac25f1 ("powerpc/pseries: Define papr_indices_io_block for papr-indices ioctls")
Fixes: 8aa9efc0be66 ("powerpc/pseries: Add papr-platform-dump character driver for dump retrieval")
Fixes: 86900ab620a4 ("powerpc/pseries: Add a char driver for physical-attestation RTAS")
Fixes: 514f6ff4369a ("powerpc/pseries: Add papr-vpd character driver for VPD retrieval")
Fixes: 905b9e48786e ("powerpc/pseries/papr-sysparm: Expose character device to user space")
Reviewed-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index bc91756bde733b..a4782e566392c7 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -362,15 +362,15 @@ Code  Seq#    Include File                                           Comments
 0xB1  00-1F                                                          PPPoX
                                                                      <mailto:mostrows@styx.uwaterloo.ca>
 0xB2  00     arch/powerpc/include/uapi/asm/papr-vpd.h                powerpc/pseries VPD API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  01-02  arch/powerpc/include/uapi/asm/papr-sysparm.h            powerpc/pseries system parameter API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  03-05  arch/powerpc/include/uapi/asm/papr-indices.h            powerpc/pseries indices API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  06-07  arch/powerpc/include/uapi/asm/papr-platform-dump.h      powerpc/pseries Platform Dump API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  08     powerpc/include/uapi/asm/papr-physical-attestation.h    powerpc/pseries Physical Attestation API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB3  00     linux/mmc/ioctl.h
 0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
-- 
An old man doll... just what I always wanted! - Clara


