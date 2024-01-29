Return-Path: <netdev+bounces-66886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7668415B1
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6111C2251F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229551C36;
	Mon, 29 Jan 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbbJWj00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602494F88E;
	Mon, 29 Jan 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567728; cv=none; b=jWkAjX/lwLUbJPHSrdpTC1qxEgWD4lzKRMtYpYj5qwM8OXzds0wylSo2VvVpitdeAyKUHSKbnBmTwvvZUhxxFu3uEViqri9tRQx23WtM3/alkvA8fm+3Y92OePC1NoZmvH5Uc6QRwSw+BeQWvJUZTjaXTJsShCOvTTmU52jqPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567728; c=relaxed/simple;
	bh=XUCRM/KfecuYYb42+fz4AbPXcbIlUDFTDJChPwbbgtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7MtSPBDdOBekieGRQ9ZRDIQtPpWDAkyrmj+1t/MtUGY7x7qWQfi8aBEaouMDL7OfNQp4rGj4PvB6k20G50lZZ/d+7oJGifRTQTSikxOjffqYUewX8PTihEEXwkHk2JVZ+/L6NnJSS2xbmcDH5PdEEcVNZV+sU8blF7ROd/18ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbbJWj00; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso51908825e9.0;
        Mon, 29 Jan 2024 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567724; x=1707172524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOw08TVc7E3Usuj6AiFlUBllrHJ+QmGBs3FGjEsWVTg=;
        b=HbbJWj00cRQFpCKO+0CI5N0T81YDa5dABDr0nNShZa5Ak6P3Uv9v8ZK1EptUb7l8hW
         RekvnZ8nu46DnJTLi4oPGN4OlJBb6Hsht4h9+QhHVdSLsF+6ZmkIO/hiUDzvJtckwvSf
         c+Rc7GnUgv5gPX/EL6WH2OWVsROpWJAF/wG7cuM2tmxQ1FdjfRAeUQHIPT0HY+gKjdKX
         asbvvHnF9ohyRezjNBl6AKH9rM/Z46u+xvOKYeaV5s1Jz/h+ZHNgdic94mxGNtmSF0kN
         tto6siNf4pmLcWO/QChpQyG0cVVutkHLPFL7eY3XeWdriV8jLREdlcZPxY22cbeQnO/u
         GZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567724; x=1707172524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOw08TVc7E3Usuj6AiFlUBllrHJ+QmGBs3FGjEsWVTg=;
        b=uWQIJV+T1+4rBjPSBz0hxE6eg+KFUsXJqIfHI51OoJJFI+9Ne6cdbfsrvlwIeX0ZjX
         QXXLOQ1fGnuvevjqiz/GEc/YMeN+9i+AHhXb1PCVHTT6G85uos9syXLMrMv+MuhpF/iy
         a8nxCsYeExtRiKmUqTE4r5nPEzvXIcfjdx6vUHEoITa0ejt6kCiXQOMCoqRnfBh7U4qb
         27KRVNawOffDFJYBQavvLb3IqMiKWS+f0RY1/TXkQHSh60cT9NQ3rX4InOZh4ylXE6eG
         nn8VoaWIYYs4GnLFByUFsfk8uZBR8tIvmLl+oE7ZKhLtB4ZowbFNx8v93kmuyUdGWF3i
         +a0Q==
X-Gm-Message-State: AOJu0YywzSx1/vp4v7GzLmSg1OmzKm8bo9rKb8d8fuapkJFKol6EZEjW
	fXKFq4h9x2Aoz2LgzPjwO9OAIxIRM9e1PXPXmILDaw59uZfN818AxMIyjiqpRBA=
X-Google-Smtp-Source: AGHT+IGn0PFd3TkURgIXPxOZab05f4xIpSi0HQK0t/KV2YlwzUrlEbLjNNrIZiItDVTRDNzxxMc3tQ==
X-Received: by 2002:a5d:4e89:0:b0:337:c58c:95f1 with SMTP id e9-20020a5d4e89000000b00337c58c95f1mr5049860wru.53.1706567724048;
        Mon, 29 Jan 2024 14:35:24 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:23 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 03/13] doc/netlink: Describe sub-message selector resolution
Date: Mon, 29 Jan 2024 22:34:48 +0000
Message-ID: <20240129223458.52046-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the netlink-raw docs to add a description of sub-message selector
resolution to explain that selector resolution is constrained by the
spec.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/userspace-api/netlink/netlink-raw.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/netlink/netlink-raw.rst b/Documentation/userspace-api/netlink/netlink-raw.rst
index 1e14f5f22b8e..32197f3cb40e 100644
--- a/Documentation/userspace-api/netlink/netlink-raw.rst
+++ b/Documentation/userspace-api/netlink/netlink-raw.rst
@@ -150,3 +150,11 @@ attributes from an ``attribute-set``. For example the following
 
 Note that a selector attribute must appear in a netlink message before any
 sub-message attributes that depend on it.
+
+If an attribute such as ``kind`` is defined at more than one nest level, then a
+sub-message selector will be resolved using the value 'closest' to the selector.
+For example, if the same attribute name is defined in a nested ``attribute-set``
+alongside a sub-message selector and also in a top level ``attribute-set``, then
+the selector will be resolved using the value 'closest' to the selector. If the
+value is not present in the message at the same level as defined in the spec
+then this is an error.
-- 
2.42.0


