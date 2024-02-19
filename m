Return-Path: <netdev+bounces-73008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87985A9DE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D721C22998
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFA147F75;
	Mon, 19 Feb 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w6JTHxvE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C304594E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363535; cv=none; b=ewEscbHVHfo5CJpBPdOSnFEV3xUE6Q/xDNNMTlo676WqFaUxXMktJo7kJUQIcjhb9wchU4mFBValK1wEwChwtGOrLtKAzJ9jgP1Vg5jLKE2qMXu2G0Vw120wCzgnI43wVjUDcspn0GXhn5nfRWp42Y+Wll4eXwyR2d6eWKHFGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363535; c=relaxed/simple;
	bh=j8oL6u7LIz1kVWmjKRw4xt8aa5zLt1brU8S6+j9SIOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQA8bqIE2LhO8U3nyp8PslRRsMkjca7g1do+CvVPkGIwYhWcfD1CcUIounywlCrNL3YgRZD5OaSZCx2eGqYCoiBKM17UooTo/jfnVsgTH8G+tkt1jKJLYfMP3FVGqpluoUC5eu963lgkKXTQzCRSLh8fOGnDlXtgwGSw9A645l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w6JTHxvE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41242d2f73cso23136795e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363532; x=1708968332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/QhDRwym0LVRokbBfusx2gFhFFv/dhMOJxMFuna4ss=;
        b=w6JTHxvE30nvvyY2JzJ4Y+f75cWHdGjlDTGENIsD/Aj0CJU17hZhjgPDxFQOiBDhUQ
         JnhvsqXtnIldO+U0LTRJGM9CQ8OFufZnkd1SzPcEeG0zqm6BFeCMLnPfE12f42N6IAAJ
         eLFcADeWkVJvkHn2zgx/huU2fToF0qEq0g4d6Ndx0mGTcrXnz/aBepAAU1QQW+QSxhW/
         +2rTH9yrAZfdLfsJgEo5vMYhfku1bTwD9eIkilTA8TQNsan9HYvz6gPrpLI589wfsXYw
         j9h+HUKo3uIkKHue0siqdreNxu18M6B3hR9knkuJL0ugN4Gzq83paXwEVc3Succje87j
         40uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363532; x=1708968332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/QhDRwym0LVRokbBfusx2gFhFFv/dhMOJxMFuna4ss=;
        b=t81HT0i/KgfXdNuAR2joPFe98Zp1uI4as+/wMD4tkU0AfURCwX+zfbsaW2sxm7OVg+
         +ZOfxftOlrJ9OCCIu6SjOwC39pr7e54vyadYT1OeC7HK9qoBJhrUWC3c5D7U3aTXJRqR
         kPOMKyFftrxkAzJV/U/p56NqCX4GYTm4LhhAdIarAmwIsNTZdGITHwBrV3wpGhTd2MOY
         /qVoPQ3LF0eneLBZ90dxq3Mf/2f+6W1zwHDs9gXlgE99+NFgiC/OrrRiAZ6x8JjzLCmf
         lX5XvdqJ7Ib4UrGeFY8TnjBHF6KSBbtZJmTMS724j9AbexJwgBNoZ6A0ZtKNNpvd6D4A
         r36w==
X-Gm-Message-State: AOJu0Yzvo2CLfbIru7h1ovun1BOLBVw3mYgWRkd4DBBDfyg/mRgt4Y5V
	wvHmq7oRLGCYWolja6vyyj4HctJE6JhwbfCo+L9D+BwqCTWeshuQzDALhP9gmKkkJBhS/A/vTqK
	A
X-Google-Smtp-Source: AGHT+IEKv4LObKlbx5807pgp95FujRxBeTiB9RE4GBrfd0kzVS05TgRINYh4QMMmeFPhxRnRv604Dw==
X-Received: by 2002:a05:600c:1d04:b0:412:56ab:5bf6 with SMTP id l4-20020a05600c1d0400b0041256ab5bf6mr5233876wms.10.1708363531762;
        Mon, 19 Feb 2024 09:25:31 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b00411e1574f7fsm11825041wmk.44.2024.02.19.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:31 -0800 (PST)
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
Subject: [patch net-next 01/13] tools: ynl: allow user to specify flag attr with bool values
Date: Mon, 19 Feb 2024 18:25:17 +0100
Message-ID: <20240219172525.71406-2-jiri@resnulli.us>
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

The flag attr presence in Netlink message indicates value "true",
if it is missing in the message it means "false".

Allow user to specify attrname with value "true"/"false"
in json for flag attrs, treat "false" value properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f45ee5f29bed..108fe7eadd93 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -459,6 +459,8 @@ class YnlFamily(SpecFamily):
                 attr_payload += self._add_attr(attr['nested-attributes'],
                                                subname, subvalue, sub_attrs)
         elif attr["type"] == 'flag':
+            if value == False:
+                return b''
             attr_payload = b''
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
-- 
2.43.2


