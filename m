Return-Path: <netdev+bounces-78153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30523874381
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6210B1C21059
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79BC1CD29;
	Wed,  6 Mar 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeKdB5t6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DFE1CAB8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766658; cv=none; b=j5M7bvVAn/SwL0mJ+YjnFNAWPYUJ+prFJ8C3tcyvCjXf0N8IWYc20qPSwPS8ZGGl4BYrS/DDuEEEBt0ACrxVcjGYRTASV8Mzz0+cRKu2YLruZ7CySgTzQOTvruzkmbP8nYksiGHvx5wkE+n3PcIXLszKy2+XQYjbqFWwv/SyMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766658; c=relaxed/simple;
	bh=CQzOdH5LGQzzZKXJvu0BEDJL1D56vPaWCxc02lFMW4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aREgEAWJu9aRr3N97t9dBxl9Cna+ick2Ok/e+e5AdbdSF6sMaJDylDgAUqsp+mJ5ZyOIOXDpR8tmR+8gVMwzSlBqYxr/vA6P4K6iNv4zJbgZufBdoZ8CxJewpb5U7Z/pbpAdb8t/XzSPSXl3N1W/L81JNoaFo0iLUw0E5INr1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeKdB5t6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412f1961101so3232365e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766655; x=1710371455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dYKe4wgfR1A7xFuxidWludRAQ/v6RU7P/FuweFX8oE=;
        b=FeKdB5t6TRZSv0QNmvQ/OLwcHoyWfmKTkdAx84IT1qthTz1HnqzcTyzJ4SGekxrdUs
         o/RgTjK++FhUZiF0z6dZn9lxFLpVv3SeIrJaDIZcOE4ni5PnEQk65DVpogwdmPWv6wDo
         F/9ZEo66D31a0fR/pLSZLCdfoWx1J/lswdh6Z8SLsna/kYnnDf+uLTKzHIjjK+yKTiye
         6fIGTdu1XI1OfYhEFYKouHstDDjku5Qa9sonTIE3Z3OBaDu9DNsiMh+23XXP2fjTkcdc
         vKWDooZ7iG9DaE85GKvRExFcL+gfido0RCUF5CgR2foOhGa0j9rfx5wMEM7hdgc5DKG6
         sFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766655; x=1710371455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dYKe4wgfR1A7xFuxidWludRAQ/v6RU7P/FuweFX8oE=;
        b=NzHHeFcnssMBWri6mKrt1RXwLgikMp3hV6tPJ5NDDM26Jb9FUlsMYSn/99jKU9Ub3f
         iBpaJFN96rRsXq5h81erqoo9B2VgwkRMeey44m5x9R7KXeWyJX0aecT1QBcLn1/Zf0s8
         uRcHg6sNTMoQ+gN2PH10afZ5qxQzHp15dX5wPyw8uyN7+DJBsmnu/Tj1P7Z327jqvjJg
         YQnHNgqBJqDE/O7HSe5MGHhXN3XZJqUm+erswcjKsZt1LIemLUz4ryI3VO/QzRgrvsoN
         bm5X8HDsh7IfSEHcoUil5b8a9wKF41+WluSjYz+wJXVwS0z6WpULyafXLJeaLFhGzvDe
         dCvQ==
X-Gm-Message-State: AOJu0YysG+abm0WQXsUqH4xj1RlwZXiEyXQychaojfj1bw1rTndpPXmD
	MWicnwRH5eGWeHocSDCnhf/sPmgl8zMYo/m5NTeFaLZ3SSHMnQ/wPSFM4vrBQN4=
X-Google-Smtp-Source: AGHT+IE+vuEZ8XFhDcWXlc7va2loFCw/Ce/ImirO5MQcOAt8ujV4Rm+pVRa314soNDLzXjSx/3hZhA==
X-Received: by 2002:a05:6000:1751:b0:33e:3462:f6d6 with SMTP id m17-20020a056000175100b0033e3462f6d6mr7241346wrf.64.1709766654945;
        Wed, 06 Mar 2024 15:10:54 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:54 -0800 (PST)
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
Subject: [PATCH net-next v3 4/6] tools/net/ynl: Add nest-type-value decoding
Date: Wed,  6 Mar 2024 23:10:44 +0000
Message-ID: <20240306231046.97158-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306231046.97158-1-donald.hunter@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


