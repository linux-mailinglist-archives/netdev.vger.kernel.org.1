Return-Path: <netdev+bounces-51726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660717FBDF2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88A1B214D5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B25D485;
	Tue, 28 Nov 2023 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tqfZlBqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC32D49
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:19:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332f4ad27d4so2330525f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701184759; x=1701789559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekXB6fJ0HtvhubYib7Kr0GLfu3mm/dUxcSqnpbxwVZ0=;
        b=tqfZlBqclhasg14eoAUdZZevVGl3ni3/bUXcjKNXqE4179RUMFnLiGV4MUkBcOgcQO
         MfhCgQrwk6WfLb+1YkWLuYEfMWGBcjrehLlXA8Yx2O0IxCDqWD4L9LQH7B4l8IA6h0RY
         IuFwknpU/u0TDLlQ8jDh1FWL2tuYPDKxRyb+rLNnTVMH/YM7mnA1pMUfeqdjavp+GQyM
         S7K87Q+G1DHNZL2gD0Kr0fbQOzCG6wFh0tIW7gcK1x1MCeRAKaIaSItAZG42VL4vHUMa
         ZPs0jlgYK+ElSZfZZkMyu1bIrtYYEFnNjP2C8yuyLL7QLF+zM4fdo5eaw8JGX3POnvXU
         DB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184759; x=1701789559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekXB6fJ0HtvhubYib7Kr0GLfu3mm/dUxcSqnpbxwVZ0=;
        b=ogs8kqbMAZnKV9NeuLsPxFMc4c2jLumqVGNPUgankAqqLMp3bk74j7Lq0OUVQdQn0I
         8EUveZQN8ZadYryNstWRP+ShnWaVzCOCUCu14qykquiK8JnGjQZsG48Djake3r97dona
         5otO7HIqB3XZUSJLy3y/zKb2LnEQTiLQ23Z2CnNfUnkjncuOMm7KZNqprSFfJjN5NwpE
         uPMn7EExqquPh1gRjRlH5XT37wWb6TMK004xn1PW95uIzU7yfrlTtj1uY+dMyjHXgyED
         qMwFIrMOvycSI7oYQaIbSHvhhwERhfPpSkRD4P9BTrbNS4zeN5J45DmVYl6ppgVSAViR
         SKHg==
X-Gm-Message-State: AOJu0YycsVZ99gVfu6vU8aT51lPEYP/bKfmELuoZonoMrUa6mHSn9Cr7
	y5Qo60dshFJADaTDCtY50tkfyAHh8u9NuQ4kSfc=
X-Google-Smtp-Source: AGHT+IFO3p6ORZhJ+eNkpC4U+MihOJiFcDhjrgmlqA/ZtHKVVE8yoUd3DG5xAN7w1NXIU6tLT2Xqdg==
X-Received: by 2002:a5d:644b:0:b0:333:f81:fc41 with SMTP id d11-20020a5d644b000000b003330f81fc41mr1450671wrw.22.1701184758698;
        Tue, 28 Nov 2023 07:19:18 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b00332fbc183ebsm7754098wrt.76.2023.11.28.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:19:18 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	corbet@lwn.net
Subject: [patch net-next] docs: netlink: add NLMSG_DONE message format for doit actions
Date: Tue, 28 Nov 2023 16:19:16 +0100
Message-ID: <20231128151916.780588-1-jiri@resnulli.us>
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
 Documentation/userspace-api/netlink/intro.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentation/userspace-api/netlink/intro.rst
index 7b1d401210ef..92e19bf49e9d 100644
--- a/Documentation/userspace-api/netlink/intro.rst
+++ b/Documentation/userspace-api/netlink/intro.rst
@@ -234,6 +234,13 @@ ACK attributes may be present::
   | ** optionally extended ACK                 |
   ----------------------------------------------
 
+If ``NLMSG_DONE`` is sent as a reply to ``do`` action request, the error
+and extended ACK may be omitted::
+
+  ----------------------------------------------
+  | struct nlmsghdr - response header          |
+  ----------------------------------------------
+
 .. _res_fam:
 
 Resolving the Family ID
-- 
2.41.0


