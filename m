Return-Path: <netdev+bounces-76645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023986E6F7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FDC288B1E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45B8495;
	Fri,  1 Mar 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dou2G2BU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7076FC3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313282; cv=none; b=m8TKXtwJEFv4zkN0mlggS1HJ/rYGWOCU/OZoQt6pd312ukEGJsGbhe73Vy/Ldjvfc8LdzOjjvHfyihx+DAn62kLp+UGppYJKSyMHsfJx8f0W/+cRjSG97e1SgrpETYxFwlVWTU+FdKN4Ehth/gkdTabtPF3DkKMe6w/ZLjL8pgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313282; c=relaxed/simple;
	bh=F4RtRqtOfdgQkd+TLMRi9j4zqLakjNTuH0jkqMlfDtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzdzoh2yehC+66Hn+BPdv0tTDdpPylPIS6Y8VubcEPGHHVk2qWsFgtA+7VNGgLhUXY4RNZIZg6HXsdouPb7NSsPuPMkaLIh2nqtqxaFBEGw5ayXkNUAexp/Ms0DSA9wwBxdxGjuVozD61lVLAkNBv2t1bnWD7jr3psPenfoyoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dou2G2BU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412ca466e9eso4742545e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313279; x=1709918079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Bq87Z/SPPzCEo5Q0qhbmStS7HXGoeDTWiPK6HT4cN0=;
        b=Dou2G2BUpWBM298xUjDxN/STxP5ySF3r6+KoCsaA/IHn3WAHIQDqpZqfh7mVtcjCpN
         7D103WsuCk8Fhjr8qX5bY2rknxgzICxM3KxXDAcNcXrK3XQbor91kSqcZdrG0HLEBHZz
         dKHobHaPWO1y9B1/TUrPXbTXSkjuee3TchsM43As9yzxUKCxRhMgIsgEq+ZschcQHuo1
         3Sn0YQ+S5e2U4hLNec7asdcAQ5qloteL73RNyj6/0Nlq1tDZ3BclATzziY1RbLr0h8Tu
         08IIz0Pc1W1IIq8C0Zhdff+TtXehuyqm9VW2/Aun8knpaapdXHXkdCunCibvgzcAdgv8
         lKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313279; x=1709918079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Bq87Z/SPPzCEo5Q0qhbmStS7HXGoeDTWiPK6HT4cN0=;
        b=BNyhPozElhUWmD6lQZyB2gqqzdkV+Ovgx42jJk7d47ATA1Ayb0emwyVt9UAPVO/iRV
         N274tlhSDQj9j1iFcvnwLVZKi5mV9Ip2uHj7coHxd/lr5ojBykh+SUo5YMX+Y+/KXnjE
         1aEER2vVylGhQcqkkyYT9MMcwe0lb04JArt5l7LQXyH4eTRTIjz5iQ1EJEm4W2Rqktph
         vRuvbQTR4/iFTnBAIShZIX2rTsiXh6rCHWLeofGFjo1zcJNXP7wBukFrDhDAGOOPY398
         W3aKfO/2J/iPlf6pSQ+J3/MjerSZZrLTk5b9JjEXphq0LTOMQo8tIpX8BnV/5Gy+WkUG
         LT+A==
X-Gm-Message-State: AOJu0YwlJEyniOyLKV6XpnnSQ1D7PDFAcQWWVoTgPP15b1gBWjRyEtgl
	/6/cEVWrQ0DhnfaFM5CgHN3xcDmsVj35zvTB93ecorGCT+UG9icbwVKumzy6AOg=
X-Google-Smtp-Source: AGHT+IHVn7HiqdB2AFTmOso+sTjUZLXtOWIDL+HXSdcRC227fBjAeEyqsXjy+QyMW25NRqYJR2AcZw==
X-Received: by 2002:a5d:438c:0:b0:33e:22f8:57 with SMTP id i12-20020a5d438c000000b0033e22f80057mr1211896wrq.49.1709313278941;
        Fri, 01 Mar 2024 09:14:38 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c06e:e547:41d1:e2b2])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0033e17ff60e4sm3387556wrg.7.2024.03.01.09.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:14:38 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/4] tools/net/ynl: Fix extack decoding for netlink-raw
Date: Fri,  1 Mar 2024 17:14:28 +0000
Message-ID: <20240301171431.65892-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301171431.65892-1-donald.hunter@gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extack decoding was using a hard-coded msg header size of 20 but
netlink-raw has a header size of 16.

Use a protocol specific msghdr_size() when decoding the attr offssets.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index ac55aa5a3083..29262505a3f2 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -348,6 +348,9 @@ class NetlinkProtocol:
             raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
         return mcast_groups[mcast_name].value
 
+    def msghdr_size(self):
+        return 16
+
 
 class GenlProtocol(NetlinkProtocol):
     def __init__(self, family_name):
@@ -373,6 +376,8 @@ class GenlProtocol(NetlinkProtocol):
             raise Exception(f'Multicast group "{mcast_name}" not present in the family')
         return self.genl_family['mcast'][mcast_name]
 
+    def msghdr_size(self):
+        return super().msghdr_size() + 4
 
 
 class SpaceAttrs:
@@ -693,7 +698,7 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
-        offset = 20 + self._struct_size(op.fixed_header)
+        offset = self.nlproto.msghdr_size() + self._struct_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
-- 
2.42.0


