Return-Path: <netdev+bounces-77910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA2873720
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A111C2121F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B44E130E41;
	Wed,  6 Mar 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRQeQF2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033B130AEB
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729833; cv=none; b=C7jgqPHJ9hzvK9x8D/a+bAiLUUXyw01LeYFZnUJXqE1cwm8Ri/d1TYC/tjPwTfvXJMZatkaXTT74/wiR+H8gzEedBcFG7ZYMfEFBRO7+iSWM7zzBbbDT4MvfuN2Ca/ZonDTs95Z1mOaA8fBIKAK7q3HF1Y/9xz0aHOap+vMHuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729833; c=relaxed/simple;
	bh=dPoLKWVS4dABvAcIwjgCoLL1hJojn22hz99RFo/YbFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thXSD33hkerhJQb796ZZwWTp30rK7ojNFFhWy2FmnvDb/2FMqdFOdJjbnum2M+dPdRJ0YyimvaaRjk5ZOJ3SJKVg0EIwh2ORE5EG68dEknjhwpNwYZbsVQguqjQ848hVz6lpXlAF+xA9Z+RZst0lI7D7Iiuej/05yQauSUkR9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRQeQF2Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412eced6d1aso13892445e9.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709729829; x=1710334629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzuU4+6cXvMlJeXmYFWKyXaVUJ9CABu9KBmAr9ervN0=;
        b=KRQeQF2YbwXI7C0UX4XJ+tvC+NTWLAs5Dz5Gl2OS2Qzx00qLJEujj3evD0kBoC2Zhv
         7tb4uWVsrlyf1mpeyjvRM1ZHBtKPJXsamaKzR2xfZ+j5Abp7xQgrttEUrN9wzkUUmId4
         AqmtXCUIkAQFMfaElZRQFd66NJ+khbhioKwDK/HulP8Qz7Wl/nUrh36FeK6kBpBwOBoB
         MewHPKz7ylgXrWrjPF3ILUOs5ajuEjBBX1k99heWg0Duf6foaYKiLye4AqHYlVPzyfuu
         4hqMvOFV/4aPOXq5cN4qutkUeqwnYsB2IB1ZqShK2IJPhKOCy0hIRTehYcHSpAIsJ043
         gtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729829; x=1710334629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzuU4+6cXvMlJeXmYFWKyXaVUJ9CABu9KBmAr9ervN0=;
        b=WyD+y6lBR5ORAJV7T6MWPNiEMGpuEnmQ3m5x+lOPx6sl+UyH+0WTO/TIhZdvXgHYPH
         j9ZvdZdSskhjgwcnxvUtgySz6IC1DqTS6UMiXnWeB0N28CS0BD56rolPKg9REsdTwt8u
         4P1ibEWSx3EVoPbGCIFgqmIYNaUpBhduXIDq8EP/0izysysHNsRfDKQANZvEt4yZfEKl
         Cwu7U5f1hh0NGEcnCr+Sg62VmBBVlENPjKIZxWQBP6Z5cc9W3N8C3ye/20oxdib1eskH
         GbbZAzDZUia7I8DiyvwkeU17f6Hl0ucRvxn944lBX9VC6Tn+Szt+VIMVQyCT8WAjO497
         bHxg==
X-Gm-Message-State: AOJu0YzyeQJJdzW2KouCH/+aGmqsDt9V0x1+RkOjJtmA5B52z748yXRB
	ZdyZ9qgrByFAljmXElSiAEqVDl0N0YwRSly/OkH8B9/pbYb8Z+s7hqrpPxVbaVU=
X-Google-Smtp-Source: AGHT+IEFjZDOj5pcYYckR0TM1mO5SbDCcD44vUvc6RXz8jGUBYriII7JWeidBMrmigUiWmE0fjadIQ==
X-Received: by 2002:a05:600c:4e90:b0:411:c9c0:eddf with SMTP id f16-20020a05600c4e9000b00411c9c0eddfmr12126146wmq.36.1709729829117;
        Wed, 06 Mar 2024 04:57:09 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:503c:e93d:cfcc:281b])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm11857279wmq.8.2024.03.06.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:57:08 -0800 (PST)
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
Subject: [PATCH net-next v2 1/5] tools/net/ynl: Fix extack decoding for netlink-raw
Date: Wed,  6 Mar 2024 12:57:00 +0000
Message-ID: <20240306125704.63934-2-donald.hunter@gmail.com>
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

Extack decoding was using a hard-coded msg header size of 20 but
netlink-raw has a header size of 16.

Use a protocol specific msghdr_size() when decoding the attr offssets.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
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


