Return-Path: <netdev+bounces-237826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD5C50A73
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812FD4E19AC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A762D0C7D;
	Wed, 12 Nov 2025 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE7Nb+g1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB729BD82
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927101; cv=none; b=L8w8Qoi4ZAhyLZeknV1eb34HIXn/mpoP0ALg7IHJ8a2U4cxTRn4eBZpm/zyNk/ZPBphdZJE0vU6mLGoOmRduMcIedFcO/kRwEVQCDza0sNRfz/jjjBa5YvRLvoJR0cgmCziOL7042BHt4zysRSnhhFFxIWuZQZsNPSANnDaCrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927101; c=relaxed/simple;
	bh=KMVPQU6AS/v7oNHJYF9l/1cd4YGs3GSrORGFBhYfvSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKzp5azAVfxDiXo59WewQsmE8DkV7xboZlaS/v41Ydd7a3esnngn0iJoy5awDY7Cn7a/6vJZfEpXGwzFzEwuP6MhxYpkD2NOZEEh08ANK9WdSJd1Aua9f0iSz+C7LnVC30WmZbaPdmqEfYfyVnII+Uh3hqa/o+4T/N2N68LJH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE7Nb+g1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo402273b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762927100; x=1763531900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKHdK8U3MCmMakl9CmRgXs3sD+ncRr9aTOUvShNhzd8=;
        b=YE7Nb+g1bQhSbfivBe8Yi8itWsgxsYIQkrC0V8Ek2jPsMbjkto41eF4DvKmHWuNIjI
         wznTvi8X0qB+Gc/xmTGSffGKf1neMAenEOwWxwDx9WvH/flLcYxcf2KPrcGTJwjefuww
         QiCqmDPseWjVar7DxbM+D3E6HvS5fL1gwGbf22GBrYDICS0ISLg22ugam/Y2OugZ3LGW
         uDCWqArkBV+aBmK7EpHXwY/CnrBBqT2aD6gwosxAiskpdIWYSfKEcHhIDCL5RbowVcCE
         7sGdqAhSY5LB8+lTeG10b1Ndmn+Wr9FvTf733B2q6L1rgbxXpmKn5uT8/7v9zomUWJ5a
         xz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762927100; x=1763531900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKHdK8U3MCmMakl9CmRgXs3sD+ncRr9aTOUvShNhzd8=;
        b=Iqmp+cXllXZNh+p03pO1M+QK7/phgA8yagVE35sdimuHfHCIiDpjMEHZOn0WLzKaBO
         qqj3oayqjdSRxbqANUh+naWMrTRoBXI2UwMOhyhLqn+auIKG0zm3j/yvEQR7eZJAC+yR
         xuekdM9XfPI9PNCOKiSwMkhAg+FDVhURlDGzLjNote7/A+Fae1O/zwOw3tiYkoeTwY5p
         qXvyrQupVFUt8fW4HZ08kJcVOSDwEzqsy38vXh4RRz7ki298RGPTfl5uq4H64vqTAcvw
         aL0trKczepRYuj5oHQrY3/TO3Pl7FWkHxMUlnJK8YSl/Ogu26PdJDKDzriNjV5BM7Q+s
         zlog==
X-Gm-Message-State: AOJu0YwP8Az1IMDLLcO+OiJsrkyjEAWkVT1VUaRIpWxrUAHXT+KhoPpj
	Dk1927YzrW+Eh1YDElIV0CS7x0iKoQrSJQNs6o/8ZjxSBmIvP5XTEh0+
X-Gm-Gg: ASbGnctSLGGbTI7M57ePqci5rDOkuieid5Lgy79ILLfGc+qdNusBzVo3YJxg4qjcDWk
	f5xf9PCtVTr/kyWi2ncO1nV2Zk+sY/c2ldmGKd1n3Y+qRBA5rJuasncKx7kkOIfhW9+3jRnLHyv
	Vs0uer0muxREpwAaJ/m6O0imXyXD0IRgXnwQrk25U/jYTEWS8cJ4vf3AHMZxZj9p9CjLubIxEEm
	P2wWhWk7w+2ti4BqhUF81dRFKgnMAizr/EaljRajldCyKzIERMqSvuzusDscTup8y+hWbg0XrKk
	CPSNHLzo6gwDMrgCBv7sEsO9kg36cOKTrECHIwtqdA+JcLUZFqoxhVIOIJtT963DvS0tCcp7aJJ
	h7Re+ILFaUwUjNcBMwltNBSlcr7lFrzn9zQWRMhsXQkCT3o5i/yUVCK2Pc3LUbneFEqg9RxvYjZ
	oXCG7cLOE19xRK8/v+
X-Google-Smtp-Source: AGHT+IE3/tV0L6LmzB1TOOszkqRLe67V6aPM21N3b8BA8c6diEO/NirFT8DNeyb7sUBcqf1qNtSnQA==
X-Received: by 2002:a05:6a20:7f9c:b0:352:eede:89cd with SMTP id adf61e73a8af0-359099863f0mr2318490637.17.1762927099543;
        Tue, 11 Nov 2025 21:58:19 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b140210c75sm16395549b3a.11.2025.11.11.21.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 21:58:19 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH v2] dpll: zl3073x: fix kernel-doc name and missing parameter in fw.c
Date: Wed, 12 Nov 2025 05:56:42 +0000
Message-Id: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
  Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
  Warning: drivers/dpll/zl3073x/fw.c:365 No description found for return value of 'zl3073x_fw_component_flash'

The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
This patch updates the comment to correctly document the
`zl3073x_fw_component_flash()` function and its arguments.

Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v2:
 - Added colon to fix kernel-doc warning for `Return:` line.

v1: https://lore.kernel.org/all/20251110195030.2248235-1-kriish.sharma2006@gmail.com

 drivers/dpll/zl3073x/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
index def37fe8d9b0..55b638247f4b 100644
--- a/drivers/dpll/zl3073x/fw.c
+++ b/drivers/dpll/zl3073x/fw.c
@@ -352,12 +352,12 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
 }
 
 /**
- * zl3073x_flash_bundle_flash - Flash all components
+ * zl3073x_fw_component_flash - Flash all components
  * @zldev: zl3073x device structure
- * @components: pointer to components array
+ * @comp: pointer to components array
  * @extack: netlink extack pointer to report errors
  *
- * Returns 0 in case of success or negative number otherwise.
+ * Return: 0 in case of success or negative number otherwise.
  */
 static int
 zl3073x_fw_component_flash(struct zl3073x_dev *zldev,
-- 
2.34.1


