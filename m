Return-Path: <netdev+bounces-157184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25301A093B4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24F1164CE5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE767211293;
	Fri, 10 Jan 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJRuVwto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C721127F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520122; cv=none; b=ufjuhyMPPfz+HLVIafSHIHBTHU57KNmCHHwXnfp83ZyR33Lbz6ld9ILWC0UknrNxv+7ahDxF4R0/dBT3RPdRkmBLpfAJUQVoamKQRErTKI1a/CkwfTWWmAGICQjZBDzBi5CP3Vk6zL+ORAopvP6bIxjtTIfAH+3xbPmbF8FONEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520122; c=relaxed/simple;
	bh=sBUCvhDfhrw8D3bEqNDdxu2VuupWxghXF65GZxTinZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6129NnnfD7Cwp0rvP4N6xOOzAioyMCsG4MKwLUwuJ8Y4NeYVRailq0niftr1mLGgsIBuZHE4F78JTWABul1Rjo1aXv2fUX1+JT28F8bVbuYCWihRSdbSGUUvj5jTfuH//PwBp3n0VyKUlNZclHEaMEmL/H6iyy1wjftFHPfmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJRuVwto; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385dece873cso1164748f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736520119; x=1737124919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX0cuC55nMb1CMHc6sO3sV4Q2DEkliR+IZN+rzwC9EA=;
        b=fJRuVwtof/epztPa6XJ3+Lmx1inkjAcCOXfhW2PTqjWY2XkoHTO/XO49WdRJpUm/9M
         mySezMHA5LjCuRs7oMgWx08V4TJr71k9vUGGOAAxr/lyXAaSOBr5Qz6cW3WgukRkHiis
         O57bBsZK7b0yKCWpF1nWGYjD9tDSqGlB55FqwdBkRrB3GNcRQSU3ePLdAsURL/PQHIFe
         wotaxvbhyEodPxINJZSpVgoXBVau1TC6OGnkXHVE/TE2S6dMhghQ/jhlu9B2ydLrjd5d
         BrQISBGA6qnGo8y4WOW1xCYzj7iQMtQ2H0s6aifgm59KqFrL9ZkKlZ/NwIVg5R5gbD6G
         c+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520119; x=1737124919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX0cuC55nMb1CMHc6sO3sV4Q2DEkliR+IZN+rzwC9EA=;
        b=DzjV6fBTbFAvB0TG+VC1En4+Mhp9aeaWkc2bQgThin4c2CfT+obBAw3dVxEGtya802
         sYv3ivTfEDwzzp97Ih9CIVbx7QGVsCpL0p+KvgTk2HAdSh974ppe/M2gUKSgouPQYoKN
         XlrNh+WpMcojgej1IIu+S3xKbJ1fFpRjbATFdDuRko69zUUajFPgVCu7dggf/BjouUlO
         qMQbQL6g1duG1kiwjJiDZQ/UgLlKmpelPAuyIFPBRbqGFwfwW2717dmdwCq+GLr7eBYr
         8kQwnLSX0YwcXkQ3M+bw8BZNVQbuweCr3L95MP6NVdIPj3IXaE0NAt5iz8X6F8yVbqUX
         UPEg==
X-Gm-Message-State: AOJu0YzEidJWK+oFxU9f2isg+GtkLfDG/d6Hz/ZUYn1tT09mBMtqCPTS
	8K2H5q8oh1KymjAS1OYzMSrwFIHLIsXbfGB2SVzK4c70abGOAlag41QqLw==
X-Gm-Gg: ASbGncvu8MgjHdrqrr4vbw6bm4G1ex8U6tWeVUcabpz60Y+CdAnktgVgTSNJB/9f4AH
	HlfeUWzEThxK9okNyytj8Coyvs8EIr8egs2hrOldEtKCc0e0o8JZeLF3jkiL/5BlQYatQsjK5mq
	Gi2zjBuagQ8TBhL7J+Ii7EDFllEpmHevSPj7lT/Ybms7Fsf1FA94we6QgNrDMo+6kdcmG/mHDzy
	ZecMrPDSA/kmCqyZVysy44h4rzq09WaCxLXOvFmN9J2ZnJPfC1Y6lboKYFMRcX/v37WOPcU7pE=
X-Google-Smtp-Source: AGHT+IE0JUAQICiBhzXBB8gI9NVMRuFUtw/QPRFOFMUu37ENX4llCA9q+DNN8kNc1/11BFYSPFp1kQ==
X-Received: by 2002:a05:6000:144a:b0:385:fc70:832 with SMTP id ffacd0b85a97d-38a87303cacmr10507892f8f.16.1736520118976;
        Fri, 10 Jan 2025 06:41:58 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:a9f1:3595:7617:6954])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddca2dsm88602265e9.21.2025.01.10.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:41:58 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/2] tools/net/ynl: ethtool: support spec load from install location
Date: Fri, 10 Jan 2025 14:41:45 +0000
Message-ID: <20250110144145.3493-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110144145.3493-1-donald.hunter@gmail.com>
References: <20250110144145.3493-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hard-coded paths for spec and schema with lookup functions so
that ethtool.py will work in-tree or when installed.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ethtool.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index ebb0a11f67bf..af7fddd7b085 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -11,6 +11,7 @@ import os
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily
+from cli import schema_dir, spec_dir
 
 def args_to_req(ynl, op_name, args, req):
     """
@@ -156,10 +157,8 @@ def main():
     args = parser.parse_args()
 
     script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
-    spec = os.path.join(script_abs_dir,
-                        '../../../Documentation/netlink/specs/ethtool.yaml')
-    schema = os.path.join(script_abs_dir,
-                          '../../../Documentation/netlink/genetlink-legacy.yaml')
+    spec = os.path.join(spec_dir(), 'ethtool.yaml')
+    schema = os.path.join(schema_dir(), 'genetlink-legacy.yaml')
 
     ynl = YnlFamily(spec, schema)
 
-- 
2.47.1


