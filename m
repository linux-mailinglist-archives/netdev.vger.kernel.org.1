Return-Path: <netdev+bounces-78150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1D87437E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B082835ED
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5471CA9A;
	Wed,  6 Mar 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcn0Cqmq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9A1C6A6
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766655; cv=none; b=rTD5bIWhu86vP/AX81xLWAui7nPa6G+9TmdhxVe84/s8Aq1eI2uTwiSbpTrlUHLcL9HCTrEK4gCv7N3N3kXuf4y5q1Hm2ivrBm3rloBTS9s1BHo6/XLOGYK6U60UmrXGucUPza5PxolVb7WN6vPqRLHMbCwD9PK2QjUUGRJJIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766655; c=relaxed/simple;
	bh=8WwVJgNy4P3Z/Ag/ZMIerfYfV5j6fPZzDtDP5EQy7q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJKRX1ruNHn9tY4dmyWTTWMsMc0TH3ihVEKunM7VMMgwoLLyn9xXfiyCxr0WjczqVXLpjPgf8LPWyUZXVxhXfILdEv+HoS5rNG7UlU+Va0B4tRPfUHDrFpD4NohekaRi9Ko/2CBEkATajsJJ2yAG34ZcYzDAWWh9Oz7UIaX5L7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcn0Cqmq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d28468666so81831f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766651; x=1710371451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaDnKoyJyMtHsYHBBHKzbFqgHt1VU3dMIO0PPWYYXBk=;
        b=Rcn0Cqmqr5QFBhRXBbjhNc7/rk0iWHGCbLgTvXLy/YVx2v3IWSCYTdjGZc78+BvCf9
         DhGcyTGWd+Up1yzLfuzUFlChFUcaOueZ2NtCkLyAxj7VbKMucAv9aaEbfYWsKJ8triZH
         8Y0SIiN6zibmUf8xICG5H5W7I2tA1PKlj1+QIilDFCy9bew62M9VktPd3+HhtipQ0WxF
         3iQhmPBDtgO0yv7NCNIbb3hngbKQY+1qVhvrpDGjH8GiChn8icGZ2TG95AYfIbSTLxDM
         xAsBhyW96ZcdVF8scAX8AKktsYvuPNVijFIEoK71F7tbT/VM+zyvRJg+opDAzc23cqzX
         HfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766651; x=1710371451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaDnKoyJyMtHsYHBBHKzbFqgHt1VU3dMIO0PPWYYXBk=;
        b=g14vOzOq66T/GOXW4Iy9xqZA49mGa7VdA3vDAWSE0fbixPmZVJ26xlFkYmu2NIAFNC
         12n1E9T0EJfvZJxB8geztX/vyHKw+WUYf3P/oWv4u3Ejr1d0tqddyUxZwpYkrjRhvTc4
         L6Pr6fWKpkxXiHw3GLSMGIsf9x8ddotazcBPVaqH537XxMdPCYtCpGNUl+aM8+ibJ9TI
         stDndu7StJL2kneDgAq2MEN3/jLfmsxbuWWeNLtjiqZXDq5v7Y3Fh20dsslBm/dfwBTS
         CIpw/sXIDQp3Na38GYTKUBVY5qESH7d5c571ohStkbm7uOoF6xkgDa0MvIl15hRgEXar
         MHqA==
X-Gm-Message-State: AOJu0YyJb+EcAavjNA5JyHgF/9jNhtxD3+5X/7lPHVoEVSrqaLi9XBKx
	UbDNBp97BBbAxxW/+o422tvJqZEOBJGFKx4vWokrlYXyCIu11qS5/MfM3Kzvm0o=
X-Google-Smtp-Source: AGHT+IGURrvaQFObhcs3qR6s8nMReGcXp1y334pNtkx+HuHPHTw6a8QS4qPguc5YX5RArFj/ZFlWmA==
X-Received: by 2002:adf:efd0:0:b0:33e:206b:8119 with SMTP id i16-20020adfefd0000000b0033e206b8119mr11625728wrp.24.1709766651327;
        Wed, 06 Mar 2024 15:10:51 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:50 -0800 (PST)
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
Subject: [PATCH net-next v3 1/6] tools/net/ynl: Fix extack decoding for netlink-raw
Date: Wed,  6 Mar 2024 23:10:41 +0000
Message-ID: <20240306231046.97158-2-donald.hunter@gmail.com>
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

Extack decoding was using a hard-coded msg header size of 20 but
netlink-raw has a header size of 16.

Use a protocol specific msghdr_size() when decoding the attr offssets.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 239e22b7a85f..b810a478a304 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -353,6 +353,9 @@ class NetlinkProtocol:
             raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
         return mcast_groups[mcast_name].value
 
+    def msghdr_size(self):
+        return 16
+
 
 class GenlProtocol(NetlinkProtocol):
     def __init__(self, family_name):
@@ -378,6 +381,8 @@ class GenlProtocol(NetlinkProtocol):
             raise Exception(f'Multicast group "{mcast_name}" not present in the family')
         return self.genl_family['mcast'][mcast_name]
 
+    def msghdr_size(self):
+        return super().msghdr_size() + 4
 
 
 class SpaceAttrs:
@@ -721,7 +726,7 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
-        offset = 20 + self._struct_size(op.fixed_header)
+        offset = self.nlproto.msghdr_size() + self._struct_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
-- 
2.42.0


