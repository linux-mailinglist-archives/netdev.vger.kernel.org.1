Return-Path: <netdev+bounces-73015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629DE85A9E5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CB1B2622D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1D47F53;
	Mon, 19 Feb 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X+kWIDsS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA445949
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363559; cv=none; b=gD2EvYqqFcOqBizegiUqsS7Q+Tn8QFXDh/lsiMhUYAzqJNTdEPQ66jn8d9ER+C+9ktbp2mpAbDqM37BnDYNez8/wPDsShECthoM0olpLhwTGKxZyq3rdQuRKRmgOXYIQSf3OWB4+hSa4OGDZgVO+udlY4YY4v68n906TLctzyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363559; c=relaxed/simple;
	bh=BLq8wOiYXgw7Y4k8JludUzRIxFjVuD2WHVqu+wyJiPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Egdh3YCaVJKZwNeoUJ/TAb65gQ8GGtnnnifpxBhDge1ogzZkWTyfsj6zHdtkcrBOcv9zIAAR+gnYTp/jWLKOgOjnH4iyX1wUENz11mOzKQ10jddT6ihsKDzYzT+tytpWSyBX9/ZMLsQxqQ75rRt+dRj97StCpwXoUDNxVSoOHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X+kWIDsS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d23d301452so13743471fa.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363556; x=1708968356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rtar3L9lnS2gnPoYg+aSyBoSu9laTfbnubInsfKdzJ0=;
        b=X+kWIDsS7dvQMgmklMgWqmL00omiTVwHVnJ7rMaGRQDkmIf2tW8OE4o6pv3VWaKQ/9
         QyE5YYO0BmNOiG9F2cUeZrxtFkEHDHOseqLQk3WxMUbN+T7enyw7lJKPsNTRvooEVOv/
         jk0hxUV5PadDQZwVdGH0K3fKLPXZriHN0/gTMJ5aBiSTR/hN/6onhh7V3rwotvea4/bt
         oZelPJF8V31TNj4zdReH18geYwlVKLzkrEklthecVGfWDky0DcnHleJHJJerHWIIQw92
         +hFhB8wIrBzrOBMoJf7bItz4EQ7YY2P6CYhVTTXmq0ZR9WAYdGrxUDX4xXcC7Gnxe/YW
         lg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363556; x=1708968356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtar3L9lnS2gnPoYg+aSyBoSu9laTfbnubInsfKdzJ0=;
        b=pd/ZkGllc7EeljR/ruL7s1/XrlAqf4u2NI8RIl/Bq4IXZBI5SHoFO6XGmp/QXzzx3w
         xu/mEOC/Ab3sADm26Ue1uyWeWOhZwrTyo7oDHOpkCjvNUJ7ue29pLnQ9M5gpXUregPEc
         xzsdcRDwRD06fZmpxcBKM6O0LtEV4clybDmnbihF/cjqztrnZgX7qRLTICH1/pTcGWwN
         QCIHHMkoHTXwTwo6Qxmv9F703ChCZaAITx+VBXQTYof99LusBXNEsH62IrWnRxQzG2MX
         voeX13XN0aSRZGGD/Nk5E34S1gU1xqlkEjXKF/PuUH9+303hQ9jM5yVDrWw9QdhI9nQi
         mU5g==
X-Gm-Message-State: AOJu0Yw+moWYV/sBG4Gly8HSi4jQA3IJpbd2Dt5Hf51PPWCGZO4gCAeu
	XuaexNxqIYc6K8nY+/ZrvGlKzmQ4KpG+wVhso+drnYbZadtddzu3Kv2d0x57Sb5umQi1BKNV+zB
	m
X-Google-Smtp-Source: AGHT+IGr2hvzJR2lsk7bPNlr13fSnpv+bkLH/es6i94rLYQ6lPyQkUyTBs9tK6mC/nUviLdiUZWy8g==
X-Received: by 2002:a2e:b1c9:0:b0:2d2:3f13:52e7 with SMTP id e9-20020a2eb1c9000000b002d23f1352e7mr1456333lja.12.1708363556019;
        Mon, 19 Feb 2024 09:25:56 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q17-20020a7bce91000000b00412656ba919sm4185147wmj.20.2024.02.19.09.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:55 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 08/13] netlink: specs: devlink: add enum for param-type attribute values
Date: Mon, 19 Feb 2024 18:25:24 +0100
Message-ID: <20240219172525.71406-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

For devlink param values, devlink relies on NLA_* values what are used
internally in kernel to indicate which type the attribute is.
This is not exposed over UAPI. Add devlink-param-type enum that defines
these values as part of devlink yaml spec.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index cf6eaa0da821..88abe137c8ef 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -164,6 +164,22 @@ definitions:
         value: 1
       -
         name: fw-activate
+  -
+    type: enum
+    name: param-type
+    entries:
+      -
+        name: u8
+        value: 1
+      -
+        name: u16
+      -
+        name: u32
+      -
+        name: string
+        value: 5
+      -
+        name: flag
   -
     type: enum
     name: param-cmode
@@ -498,6 +514,7 @@ attribute-sets:
       -
         name: param-type
         type: u8
+        enum: param-type
 
       # TODO: fill in the attributes in between
 
-- 
2.43.2


