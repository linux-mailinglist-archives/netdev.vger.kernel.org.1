Return-Path: <netdev+bounces-81916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988488BA8A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A851C31D75
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682180056;
	Tue, 26 Mar 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmf955Fu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3019130485
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435067; cv=none; b=j7kwVBbNqV2+J3tQJAUalUOHJfw7051kVag2X+JjEqAoBZIyjjDcuFQdwKuyRRvLgtdO1/vQtR6axY76naHAz5nafB/HO21L+qmn9DMLdcz127ls4UlPpEvkEbcqyAXAJt9ig0R4PePkPYaL2cRQqq1hI80K8LB25h4SqXeGIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435067; c=relaxed/simple;
	bh=dmYJH4Q73mqnOGNqfSCxezKed8pa7DM8IuuzTHxkd04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZMkec0a8xVnC6y7TRU7NyZXP+VPVkeyPKZJgDOPdQJQ9COvuwoHBOu2ka81SIE1a1BLUReK/nzmmkk/kwpX4peEanzm6AXJlEpHqkhnIXDzWlS1fgM9kT13olR8uOiQHPGbORhBqa2uFzGxF49eLy6DMLxgwgObod9HAjOHpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmf955Fu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dee5daa236so38262705ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711435065; x=1712039865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Efw5vH2tEnRxkuA6dtl7lSue4PAqzpNd7FOiUIX57M=;
        b=Hmf955FuxjQNta0QAGvqTrKLSLylT2ETKMdAOSIOiQli1vxo0uUwoVJzF4tYIsIEO1
         dUJO/QxEFNX+2a3FH2hkycmKVZJzt4w+A0JAgCZgOJL5RAjkbbnhu7xZi8V7jpjvdXcx
         dBgwPDentR3W9UIfmoFp2ZmK9X9loykM0V5c/undwRz+lXZBVIBjpZ6L/vDaXLAcFwTF
         Oxyg2Rc+mrLxSu+wmd8gUFFFxuokuG+4YnMckyPt4ydzJbRGbdc2f2607vDm0Ie0Mgeo
         4NBtKsWsr8Rr+MnwyDg/vC1Zr5wy1uIyrnmEjbcCELzGErp/NRBeT51ItxVYZZ8QGbbH
         jt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435065; x=1712039865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Efw5vH2tEnRxkuA6dtl7lSue4PAqzpNd7FOiUIX57M=;
        b=GzVh4l+uNZONoTc2b3j16XP1Fhl5D7rFHnBWVNRUinG8THpeEz+crom8b4P0hywnbR
         uoex8GDCa6wm4j6VCmvUkXStQLQkEE7wjmzyViTUpHEkrHA3JAlYegLkHmMhtOsMnK6R
         bV9hJoDdOzvjnetxMhmSgG+BuWohigW6lB+sWRAyDC5UzglWT0fYOhWZ6j/j1MCMr+4N
         e4lUaQ6/9o79gqitPydry3DxZq3FrPpYIiUMIeG4zxr//GM9o/mWHukLBxt7alZGO5i4
         f0kjYnQ+mut24zB/mjuwVCU72hnSEXWbokz4EApRiCR65n0gj0ejPGHqklkXG388MGxZ
         Ox6g==
X-Gm-Message-State: AOJu0YxpFbNTMKW/rkOF0tWUeOsHhGcbPogi+6+o/KQw5gK8YEV5T3it
	Gvg6fVA2cck3sMUvBPxg5Co9PoUZGAxMujSmkhIOYa/CuVJHAlFSvXfUHTUiQUIBy3LA
X-Google-Smtp-Source: AGHT+IFxrE/UbF09SUGAfdNszB8ylUt+lA0PkDkDFzBCbRJ3RyxKpUGbihEOPkJiz8u6KzUYIv6uYQ==
X-Received: by 2002:a17:903:13c8:b0:1e0:bc33:d with SMTP id kd8-20020a17090313c800b001e0bc33000dmr6964749plb.31.1711435064871;
        Mon, 25 Mar 2024 23:37:44 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5893458plf.76.2024.03.25.23.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 23:37:44 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/2] ynl: support un-nest sub-type for indexed-array
Date: Tue, 26 Mar 2024 14:37:28 +0800
Message-ID: <20240326063728.2369353-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326063728.2369353-1-liuhangbin@gmail.com>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support un-nest sub-type for indexed-array. Since all the attr types are
same for un-nest sub-ype, the index number is used as attr name.
The result would look like:

 # ip link add bond0 type bond mode 1 \
   arp_ip_target 192.168.1.1,192.168.1.2 ns_ip6_target 2001::1,2001::2
 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'

    "arp-ip-target": [
      {
        "1": "192.168.1.1"
      },
      {
        "2": "192.168.1.2"
      }
    ],

    [...]

    "ns-ip6-target": [
      {
        "1": "2001::1"
      },
      {
        "2": "2001::2"
      }
    ],

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 7239e673a28a..58a602ff9544 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -595,6 +595,21 @@ class YnlFamily(SpecFamily):
             decoded.append({ item.type: subattrs })
         return decoded
 
+    def _decode_index_array(self, attr, attr_spec):
+        decoded = []
+        offset = 0
+        index = 0
+        while offset < len(attr.raw):
+            index = index + 1
+            item = NlAttr(attr.raw, offset)
+            offset += item.full_len
+
+            subattrs = item.as_bin()
+            if attr_spec.display_hint:
+                subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+            decoded.append({ index: subattrs })
+        return decoded
+
     def _decode_nest_type_value(self, attr, attr_spec):
         decoded = {}
         value = attr
@@ -689,6 +704,8 @@ class YnlFamily(SpecFamily):
             elif attr_spec["type"] == 'indexed-array' and 'sub-type' in attr_spec:
                 if attr_spec["sub-type"] == 'nest':
                     decoded = self._decode_array_nest(attr, attr_spec)
+                else:
+                    decoded = self._decode_index_array(attr, attr_spec)
             elif attr_spec["type"] == 'bitfield32':
                 value, selector = struct.unpack("II", attr.raw)
                 if 'enum' in attr_spec:
-- 
2.43.0


