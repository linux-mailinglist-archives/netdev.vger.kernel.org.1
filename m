Return-Path: <netdev+bounces-52957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE78800EA5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439A1B20E61
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946544AF6D;
	Fri,  1 Dec 2023 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LIOsmNKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E91A6
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:34:17 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bbb4de875so3138355e87.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701444855; x=1702049655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvLpBGHa6W+Urg25gaGMLooCmYTl1gE/usTbcRx9X48=;
        b=LIOsmNKUzs2s+vm8amYBuF257u+toCpcAO+EpA7X85ptPeDxUMaevVkeYg8NA76pJG
         oSNhTZEUv746/ruLiRWmCJgJgnb8l0ptOav5c2S61qkTKpWM+8IKd5q7BK/hszYjd5Cd
         bC5WQ7SEAYtH6SJGNaJ0opMHwldg+GVDQOPQhPVLGOC0GyOIsqM9xV3W6aaAYtUJ9bST
         1RYR5s4RKSNzUDdvFj+JH7MbrqrV7pEMDt22640UngrkTJEEaFFTh9Zj75k/1qGVoKnA
         oE9Ua/ULg+uT+Rf3iaJXKgCvURwji+f6VCCQZ+A/S+BT5E/2CPjYnXNF6T6RnEcKlQ1K
         mVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444855; x=1702049655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvLpBGHa6W+Urg25gaGMLooCmYTl1gE/usTbcRx9X48=;
        b=Bp0VQ1xqiMf73H0iqFLTZKmWEFVp5rr5xXOhhLiXvojmW1eG+sBHNP3J2Ei5eUELfC
         a784mV5QZBNAKL9VtOKQUud4WKbFyZQ1NvOI2dIjcV6WQRjBpj7tmi96fAPt1xGZco19
         jlrPYE08NWd7d7zbEBFY2IYpUWpjIHJz3QIKBMm4+84u8aAK7EzPIDaWGw+9AQA6b79v
         GnG+m8zKkkx76gcvPcMN1eLBaEpoHKHnbECVkfSQRQzFyIHyrZrCT7psHJ3m6+B9Igv5
         wPYmLDNmlEhZgKAaZnXFPuibHVFSPh2A0mAwiumtU7m7ogKbarqOwFnmze1Chth34M4n
         YZQQ==
X-Gm-Message-State: AOJu0Yw1HzfszbpHayRu2awzDJWHWkWt95W3JLO27TqW4ARzl4GOBH9p
	6JRnORlaIgSHTrBnK0KiAxa/8RZPc11gcDspoIiEdw==
X-Google-Smtp-Source: AGHT+IG7q7QEZFRoydXNrQ+qCdLflKFv+eTopgjG+vu1v3OSzCZpN1a6KQtZPSZsFVSJ+uNtKNMfyw==
X-Received: by 2002:a05:6512:3b83:b0:50b:d764:64b0 with SMTP id g3-20020a0565123b8300b0050bd76464b0mr1276219lfv.101.1701444855021;
        Fri, 01 Dec 2023 07:34:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040b4b2a15ebsm5692477wmq.28.2023.12.01.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:34:13 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	corbet@lwn.net
Subject: [patch net-next v2] docs: netlink: add NLMSG_DONE message format for doit actions
Date: Fri,  1 Dec 2023 16:34:09 +0100
Message-ID: <20231201153409.862397-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case NLMSG_DONE message is sent as a reply to doit action, multiple
kernel implementation do not send anything else than struct nlmsghdr.
Add this note to the Netlink intro documentation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- Changed the note completely
---
 Documentation/userspace-api/netlink/intro.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentation/userspace-api/netlink/intro.rst
index 7b1d401210ef..e0efa75db94b 100644
--- a/Documentation/userspace-api/netlink/intro.rst
+++ b/Documentation/userspace-api/netlink/intro.rst
@@ -234,6 +234,10 @@ ACK attributes may be present::
   | ** optionally extended ACK                 |
   ----------------------------------------------
 
+Note that some implementations may issue custom ``NLMSG_DONE`` messages
+in reply to ``do`` action requests. In that case the payload is
+implementation-specific and may also be avoided.
+
 .. _res_fam:
 
 Resolving the Family ID
-- 
2.41.0


