Return-Path: <netdev+bounces-77913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2A873724
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553B0B2268B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCE131734;
	Wed,  6 Mar 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og+ZDqCw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969FB5D726
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729837; cv=none; b=J4RzAfnwqtlKQ8jPKTw1eAGYYUZeMRXZNI2O63FvswurM5riQMQDGoaiXjExEPrvATuC4e8ZoEaGB4tvVBC3SvuE+5eHcsKX3EGJVHInKUFAkihahf9OZY3jZkW1pTPuFw/LBAsHkwe1Tfh8h7aUTdVIl+bIn1DcfoCwev9dXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729837; c=relaxed/simple;
	bh=5edzrjx4uNp5QEAJW2CNjX/cJtWwOK4axA9UXwPxAuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEd2P6XpboiNjKDs9NypLG30D25FcJYhy8dbtmHu4RezIOz+sxkhrOPaHHTk1khdQAEKinXCXwO4jHEkbxXtsPvZ5XN3B1vYwfhf7tRx0bgbpdQXgTsWkRwhHQu7RIauaP++4I/U41YdqyxfpZmd10ZP5NWFohq+XWpcUlua+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og+ZDqCw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51320ca689aso8260644e87.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709729833; x=1710334633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx3djLYpAVy9FECdw453JIST0YBWxKr7tniWxul4drI=;
        b=Og+ZDqCwYpClz54xjB1SisEubBs4+Lk1IOFYsOyUU5AOkF/FUQ0XcIUjpM3M2m+LAq
         RV3Ggnn1R3hHt9qE8GybXA69cz6QqcFm2rIqU9QB+RUO38RnEo9RzNsaZYPCCRjqM/UU
         l7H2nAr8DeYqI9XLoddRjPZTyIesM61uEfGKJrEGbTPrKDuj5Vh3NwFQfbWaexhF/sKQ
         7iuFeKF1HLwGXVQ9Z1d+iox5i0M/jq1Z/1GhiI1O9L4N+WT0ip1kMp9i8ncGLwtPbUFl
         rCUsPy2A2pgvnNjCcduGvyr46VatR3IqBFstmg6DWWbUejz7q+U2vLj7CXTrJQkuyPQd
         EPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729833; x=1710334633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx3djLYpAVy9FECdw453JIST0YBWxKr7tniWxul4drI=;
        b=G8YU71u0TJwLVYrk1ABoixyc9JBHX17XtFN7fmF3xKkGqHA+OsbB/mgfqCq0Ey6kLK
         y98bfDbcg47BDIRpwjfev5etGJcx3SsXtP8fHWeRylrffDkFNtLzLiVYr5kPx5TY2SkL
         FrmaUo5uRI1lTp5k7VEyydLwqwzkPkZKp3IkoE3jXSaEBkclSS0vvahYu0eqtbQcy+bY
         HpQsQxNN3ogctdfVrWKk+EMBzvitqN3AjJhbs3LgOpePxOm4vqN0oSOta5Q9FlIwT24u
         7gM28MYMzSOywRItWyTwIVhn2U5tAVplUWkWE5/8tuwTJaphV5EuHpFi7IpH8VlIVvAO
         PvHw==
X-Gm-Message-State: AOJu0YzXmL1niqVjEmboTU+bZCd4Dkv1fnNF53q53hRCLya55KbQ9krg
	BVVf3dlMO1HxbeFN9dMIAjtrvgjG4PoXeVaNNgy5GhGyvNI1OYcpDm+FS2zXQTU=
X-Google-Smtp-Source: AGHT+IHCP7G/ptSSFpfTZT5FEDiMpeDGj3HwtZcQxhRYSOB9Dv7WvNmrRFu1wtKtUqeG2wfV/lKM8A==
X-Received: by 2002:ac2:442d:0:b0:513:685a:8696 with SMTP id w13-20020ac2442d000000b00513685a8696mr544777lfl.10.1709729833077;
        Wed, 06 Mar 2024 04:57:13 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:503c:e93d:cfcc:281b])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm11857279wmq.8.2024.03.06.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:57:12 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] tools/net/ynl: Add nest-type-value decoding
Date: Wed,  6 Mar 2024 12:57:03 +0000
Message-ID: <20240306125704.63934-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306125704.63934-1-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nlctrl genetlink-legacy family uses nest-type-value encoding as
described in Documentation/userspace-api/netlink/genetlink-legacy.rst

Add nest-type-value decoding to ynl.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index b810a478a304..2d7fdd903d9e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -595,6 +595,16 @@ class YnlFamily(SpecFamily):
             decoded.append({ item.type: subattrs })
         return decoded
 
+    def _decode_nest_type_value(self, attr, attr_spec):
+        decoded = {}
+        value = attr
+        for name in attr_spec['type-value']:
+            value = NlAttr(value.raw, 0)
+            decoded[name] = value.type
+        subattrs = self._decode(NlAttrs(value.raw), attr_spec['nested-attributes'])
+        decoded.update(subattrs)
+        return decoded
+
     def _decode_unknown(self, attr):
         if attr.is_nest:
             return self._decode(NlAttrs(attr.raw), None)
@@ -686,6 +696,8 @@ class YnlFamily(SpecFamily):
                 decoded = {"value": value, "selector": selector}
             elif attr_spec["type"] == 'sub-message':
                 decoded = self._decode_sub_msg(attr, attr_spec, search_attrs)
+            elif attr_spec["type"] == 'nest-type-value':
+                decoded = self._decode_nest_type_value(attr, attr_spec)
             else:
                 if not self.process_unknown:
                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
-- 
2.42.0


