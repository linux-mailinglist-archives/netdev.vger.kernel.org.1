Return-Path: <netdev+bounces-82240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC64888CDFF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E361C669A9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0713D29C;
	Tue, 26 Mar 2024 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJzS2Ost"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4213D250
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484011; cv=none; b=Wrfxv4dT+JIGsUDjRv9boVvvNKxyZ/N9gn0QfCHwaN6k51ZIWYj/XpwDEsqExYzlD/+Gc1Jy2cIj2Zyn1F3feSb3UqBd16c+FeSPxPpIw5mgp4Ev0xLgnqnPyF8Evcxiq4PLwpSCJD1zB+17zg54OGYZAtX8uHBWHgYOURNQleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484011; c=relaxed/simple;
	bh=36DNbh/kfAn6b3MfvHY33HjJmW9ycA4p0ul2DzTkJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsek418es2fd0P2AZzsyZuMlKGkugRWPpaIm0z11Msqdga6lYzNG65A3XyJC59bpC7wlsG+glo0m/plgP/xG+MnRR0dVSqHMuCQlBrOeldKjlhpbA/JEbp/+f+aZBuvZqXzAPfhqtXuCEHfSt8mjVABISxkCWnV+uCbopIfslWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJzS2Ost; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4514417a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484009; x=1712088809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm1DYDSBYz6zfveSKCwWN3sRscitSluKpMrKm2X1Ous=;
        b=PJzS2Ost/8hM8B3s/ryHMAITELEZr7Ihqyqrp0dYbEojvOVm4LBEyTXfuqQ+7V1/0f
         oMPXR71W8sX+OUnWOrRsQ1X2WoCWqsgu/ZHH2L/4Xc5FS8L6K6sodWxMNABjmPYCY5s+
         GdTZTM9FZv3qtGRP7zMXNZ+hT8FLx16Iv+2xokyfpS/acwsvBJjnz8IdTTL8Qgjzx/yC
         OVG12miRb0CiOjacqpGg4hSAF3OHO9RSZ99uJynZbBEcxiZPnrB0y3eM/QbOpNpz0igf
         xh7D+lXuP09nMFnFb/EP23+scXxQzUkwDsVxeG+HYp7wldj4UQ2JTSxOLZiEjBIepGIo
         jsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484009; x=1712088809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm1DYDSBYz6zfveSKCwWN3sRscitSluKpMrKm2X1Ous=;
        b=NA0DLiqZPRpX4nVKTVQ0Pcpy0VrT7NASy9nFFIbTS2jRXTtFjChM0LJJCwKh4aAjSh
         jCv5BE9VGBOGJxbjR7/9JV9A9ZR5zPVgeOt1OSfTfuBWAoy9V7+qeaDyL7ARTj7P5Zs7
         frtWaL81Rhi5h6UT7a5EfzbcigXy6L3vCppZiidEuyn1AQEKsrSoSiXOmcZvq9mfnOFX
         Z2Brig29KUNlu7GZ8AhNxC0NUD8PN7P8c79H9BAFO6+rPGInQAppKNZl6PzvVL3I2us5
         2k71ZAjxBFUH8upFHE+MOI/6e0Rflyjc1jdL2QcSA8C7IH9hi2OWcmc1ldpqItdHDirX
         HE5Q==
X-Gm-Message-State: AOJu0Yzrkrm8PJZmZuz4HMk8VU7wevnX1WJS36B+pqxP6U+eNM48Ixpi
	1J+jwXYMYtGBzOrRMcKWFruq1gOIs2PJ9d59FnJlVhemfF2LF1mr2rOVq200wMg=
X-Google-Smtp-Source: AGHT+IGaQDoA4rliOtsubxQ7jaDItuXYSxgnJP1dikLhnkgD6LfMjCGIHLYhGo6nKkjO27daff6oYg==
X-Received: by 2002:a05:6a20:d49a:b0:1a3:1972:450e with SMTP id im26-20020a056a20d49a00b001a31972450emr2705022pzb.50.1711484008888;
        Tue, 26 Mar 2024 13:13:28 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006e647716b6esm6648939pfd.149.2024.03.26.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:13:28 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/3] doc: netlink: Change generated docs to limit TOC to depth 3
Date: Tue, 26 Mar 2024 20:13:09 +0000
Message-ID: <20240326201311.13089-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326201311.13089-1-donald.hunter@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tables of contents in the generated Netlink docs include individual
attribute definitions. This can make the contents exceedingly long and
repeats a lot of what is on the rest of the pages. See for example:

https://docs.kernel.org/networking/netlink_spec/tc.html

Add a depth limit to the contents directive in generated .rst files to
limit the contents depth to 3 levels. This reduces the contents to:

 - Family
   - Summary
   - Operations
     - op-one
     - op-two
     - ...
   - Definitions
     - struct-one
     - struct-two
     - enum-one
     - ...
   - Attribute sets
     - attrs-one
     - attrs-two
     - ...

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 927407b3efb3..5825a8b3bfb4 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -291,7 +291,7 @@ def parse_yaml(obj: Dict[str, Any]) -> str:
 
     title = f"Family ``{obj['name']}`` netlink specification"
     lines.append(rst_title(title))
-    lines.append(rst_paragraph(".. contents::\n"))
+    lines.append(rst_paragraph(".. contents:: :depth: 3\n"))
 
     if "doc" in obj:
         lines.append(rst_subtitle("Summary"))
-- 
2.44.0


