Return-Path: <netdev+bounces-73748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF285E203
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3ED1C244F7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5D680C04;
	Wed, 21 Feb 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="U2ydPz8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DA81730
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530869; cv=none; b=Fgt/Sooi/qo6QAUaabn8XvJaaJH6ko1WJKFduQIhV9ZAuLlypQORvQpnB1KwQCePrF8lhtKjz8kjB53d+4CMCjA1seHWtEll1KkWRObQpvnWrWk3sdMhNxZlisIS2PFV63ZWCL/e4gH80/DrcdLxAESRXn1EuAJuUmrC0d8FdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530869; c=relaxed/simple;
	bh=z4dV5sMV14/n4ROoaWN7EHCC9FKFvm0O8lvWXYfFGC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGL9dXh0FLoaLAt2BvWs/vW8vH+p+fg9PV8HwANuS4eM6BsQZeuqnOB043Cr1ozkZ+mLenToKVV2z/Pgs0MBH4qiIx8t/EFD3IOdU5EdcXYqVX+nFuN4Q5j0tfrffPNeplGCj/7EMTliwlGg8Yd/hV2CmnA06SSKKicqOMsZacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=U2ydPz8f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412698ac6f9so17916135e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708530861; x=1709135661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igz3Pm9IcLbKinmSkAsWb32QhBDY2If+O3AZdxzSZ90=;
        b=U2ydPz8fYPNXqddctig4pg7nAo3DncZwszFrSldFzWD2dLBbkvgv5DVklC+mR2I18k
         NhGcdfcQNfkhc83jeY5lngQkvdp26Jq1Gyiy3hkjh4RtaYsSEa5/Yx6hTI0hX/eO8WHc
         inb4s+6U7ZXZ/Q6ATxN+EnjLpR3BcvU9IlFb1q04nJZLPlBk6O/AR5cXMMLbgXgaGD5E
         cE5r6rKH2gB3FENKWPb4vM8kxxrfNGi6Um1mR+Bo7aYqnn7xczEPAWPY1aTWT+jez5Bo
         d7s09AxXlVAnRpRbzo5Vosqufzw1tKedzAXSxN3s/Ymr+9WZhudkMKQfg114sUJ6SK2D
         5qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530861; x=1709135661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igz3Pm9IcLbKinmSkAsWb32QhBDY2If+O3AZdxzSZ90=;
        b=iktpxLdedF79MeT3Mu224i9NnqI0q1hRei2hUlyVxEHYkiF68zX2JGfiZExhuiSgA2
         x3K5VD0N/s2nOFbd+RsZ2K+QfwrUVU828d7IUj6eosKB8yD3TMPnAXUu9Y0MkfcgoHir
         0I/eC+chGNlzj5m7XkXmF5Na6fa6HmnJWfp/+CgBMBXoCirPikIuzux923WmwQLoGNC+
         8zmqodpXZPalB2Xs89u5VgeSIyYlPM9bdM1ijXMOwh86ONe83y1+Tj1RD78bQgJonaLf
         c3QPnBDk2Pj7y5X4ng8xtiue7R/8xG7CP/6ewh+6N5lDBd7Vlz4GbD9pg1I1rmepb66u
         XGHQ==
X-Gm-Message-State: AOJu0YxilaB88D0VIRS2nQxc19A4WQdZc2Z8hp3FOqtKjk0M3j5j8v4o
	OJcKzck37j5+jaVlcuUz6Sfo7CPcJTQNAzPGw7pb5aRxBIPNAggV854WwMS31RNUxWns2jzSFTq
	k
X-Google-Smtp-Source: AGHT+IFs1lOHVLamzh8hZ6S0WRRREXlRQPIE5BYgc2No7bVlk1H3WMeJqMe9Gr+mGn9iCCbbdqjbrg==
X-Received: by 2002:a05:600c:444a:b0:412:73f5:3aa5 with SMTP id v10-20020a05600c444a00b0041273f53aa5mr2623606wmn.16.1708530861707;
        Wed, 21 Feb 2024 07:54:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b00411c3c2fc55sm18115234wmi.45.2024.02.21.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:54:21 -0800 (PST)
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
Subject: [patch net-next v2 1/3] tools: ynl: allow user to specify flag attr with bool values
Date: Wed, 21 Feb 2024 16:54:13 +0100
Message-ID: <20240221155415.158174-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221155415.158174-1-jiri@resnulli.us>
References: <20240221155415.158174-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The flag attr presence in Netlink message indicates value "true",
if it is missing in the message it means "false".

Allow user to specify attrname with value "true"/"false"
in json for flag attrs, treat "false" value properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- accept other values than "False"
---
 tools/net/ynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f45ee5f29bed..4a44840bab68 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -459,6 +459,8 @@ class YnlFamily(SpecFamily):
                 attr_payload += self._add_attr(attr['nested-attributes'],
                                                subname, subvalue, sub_attrs)
         elif attr["type"] == 'flag':
+            if not value:
+                return b''
             attr_payload = b''
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
-- 
2.43.2


