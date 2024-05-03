Return-Path: <netdev+bounces-93305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6B8BB129
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16E3B22BD9
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB76156988;
	Fri,  3 May 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGddsnKS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E6156987
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754592; cv=none; b=gnDQLVQU1wHGqQrb5ljwCh+WyAM47Knj+MguEFB8TyCzCvPH0Z11EeRz/SsrHtq7s4KvexdmtOVhgLtG47dY25y0SIVnOgIqq/b7cGIiexHi3peIOCn6LaZuH9LDv67+gnahb4FmwpPp1y+ucpvzIhhVn1zqc89Jmq43zH+aQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754592; c=relaxed/simple;
	bh=wiHal5kcMk/L6h38VUpag//KSK79m9BU5ipBtsZNvtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NW19xhwlAuqOH41S3duj/WrD2WEQl3BfhC+o4fEoALaTFPZk+/dnAFl/dO6vGXkmYqJo79/UTef7js4GBA7ZCXee8OljIBjGsmGsPt4NpXO9ZsS0bbjDzalGTxtqfmqGAXqGBVxpOWxc9SpwtqtMYJRNSGYb3thgpNpdoTPVBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGddsnKS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b5dd5af48so66856755e9.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714754589; x=1715359389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHUxvOc0fmAPHFAittk4nPeoAI/Y9nfGQhiQ1Qa4fC8=;
        b=aGddsnKSzFd07ByA5eeRVxAVechgGR7omKvkRQzijyh5g0gREfnz7mDaWdeOeqNftB
         +qm/LNT8W3a5e5GpK0OsGr34Us0EmqOeqRWBe1k2NSIIIvfhQVgN9qLE5GEELNo1mIwF
         Qy6MWZ9S8VV3N6VtIIPDqneXPZtRd5IJgfdJjk8NVLluWNppnZx731VpwNqFvmojZWE/
         KfeftQDnKqn4RN59Dsds8iZVnXgu1gL6ESqrkd0Q0hIPtkXPnQHhzFophaIzrFl0dgbC
         T9O6MNK0XIohFy3Q5xjqpYM30MAPkgQ+hmGqc6uCR5xYSgvpUvoTOtjkS3OCV7d1NCPh
         WlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714754589; x=1715359389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHUxvOc0fmAPHFAittk4nPeoAI/Y9nfGQhiQ1Qa4fC8=;
        b=uILS5glCcQGhWQcnrxFyAVxCFF8ChVicNaC43FZBkdevlUOvb8T4SHbQ3FS4FogbQt
         5Kt1AAszKi9rrPkNT3QQBuyUwZn5CwfppzJI5LWMxlvVCrVOQ1y6Npu3aXHU85By8MRW
         yXdC8O7UDI70E+CXdGAQPJlVkuhzLW7NkHUcF5CUBhWlEkAzAUkaxFgTrSyPwbNVBplE
         T0HdocGph29nf23tnairrju9BOJ+psRKR9JwwfjijTfBhjXe8pkREhCvazl+SXdcktwq
         e6hCzSaN7x4IAkO+T8JCOma3qj2i1eT/G6cWR+t9b48rRsPbHXA7gWreSOBpjZBV9yTL
         RZ0w==
X-Gm-Message-State: AOJu0YxUzTkyjRrinwk0R5w1YFr7bjJKpmeJAhvmenMTd440E8Xix+kq
	5zgDzqC/A77RaHGiyNf6Pf5t9SHWJ6lGCoSTnc9gx4pgcIOfKi/wewMHxmgw
X-Google-Smtp-Source: AGHT+IGvqFlQl4pU/OL4RkjIczzEbZISOD5XONvM6jbS+lVJ3J16ubriMU/JUHPousDj/+D2/A0fXQ==
X-Received: by 2002:adf:b1d2:0:b0:34d:a60d:551e with SMTP id r18-20020adfb1d2000000b0034da60d551emr2201517wra.18.1714754588627;
        Fri, 03 May 2024 09:43:08 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:341c:5222:7a07:6c58])
        by smtp.gmail.com with ESMTPSA id h11-20020adfe98b000000b00343d1d09550sm4141312wrm.60.2024.05.03.09.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:43:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net v1] netlink: specs: Add missing bridge linkinfo attrs
Date: Fri,  3 May 2024 17:43:04 +0100
Message-ID: <20240503164304.87427-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attributes for FDB learned entries were added to the if_link netlink api
for bridge linkinfo but are missing from the rt_link.yaml spec. Add the
missing attributes to the spec.

Fixes: ddd1ad68826d ("net: bridge: Add netlink knobs for number / max learned FDB entries")
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8e4d19adee8c..4e702ac8bf66 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1144,6 +1144,12 @@ attribute-sets:
       -
         name: mcast-querier-state
         type: binary
+      -
+        name: fdb-n-learned
+        type: u32
+      -
+        name: fdb-max-learned
+        type: u32
   -
     name: linkinfo-brport-attrs
     name-prefix: ifla-brport-
-- 
2.44.0


