Return-Path: <netdev+bounces-159243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F4A14E5F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C034188928D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157B1FDE2F;
	Fri, 17 Jan 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExQKsqiv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABB1FBEBF
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113019; cv=none; b=dFh87ODQtz0yTYyxRtcBLDGIPjOOGovGg1VTa3PUMGf2qfl601+j/9KPBIbWUkscrnvBifi3rbJ0PkHw4MajNhvOQvub6VSSpVH0gbV73z/iQTym2IzLvgM0mSlp+S/riRLop62OQUzncJMVCcD+Co2pV8gOVa2R8lWJtI/2OpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113019; c=relaxed/simple;
	bh=Lc/DBLsmKjKxJi0Us1fPEs4RuMjgS97sI4NkIOufgp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvRjHrjbPPgCYQ5EmSuFQC4V0lWX9TxbX1otB5/PBl4OUE1YwZBOdVH4yCPDyGrIpTlQS1QA9Lwcuw101SzGm5C1hIcQL/Rqo53Bh/hTXFRsBQgBLgSGYbebsA0qQX4ieOPm3UtygwEYrz4+1/9RxoUStss1UoLjywBp/Z5haW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExQKsqiv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737113015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GO6Rmx9rpV9dJJuoB+K/TsjkwRWDw+YjqfuQknfHVy8=;
	b=ExQKsqivxjBDlfJKqsLl5Y89U9gJ/ZYeYZXCPTj4Ih+pkJ6N135SXMlwh5gu+lQoyyfaZa
	OuPENxWCtw73Kjqzio/oLTlbOoreZhcOHqK1zHvjhFMAYnRJgVVpfxVTc85PqKM4vB/q2W
	jrFYQz50JgX8GGoJxzKNVf1lzAfWhTg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-4FS49HPTP0iV_ctwXV5WZw-1; Fri, 17 Jan 2025 06:23:33 -0500
X-MC-Unique: 4FS49HPTP0iV_ctwXV5WZw-1
X-Mimecast-MFC-AGG-ID: 4FS49HPTP0iV_ctwXV5WZw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862e986d17so849031f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 03:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737113012; x=1737717812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GO6Rmx9rpV9dJJuoB+K/TsjkwRWDw+YjqfuQknfHVy8=;
        b=ucfyLs6/e+xdZXc2oHCLPgWma/MTHUpG7JVVxPWFTFkvYF18RXMfWSlXLWM4FIVuBe
         DyA82+xU18evl6LCP0P+r8oKUkWog6Ve/NAsOhO6Zkmwz0iy6IhMiIuwyrT2XZKWaY9F
         ZIcmzF0VAPC5Ea6jEX8PO5UmqnA1xyWtW2pi8SlDTC3vg0iHgk96hGsM+0X/E4Pi+6lh
         99UQdzAmk3/Y3kqpNJi8hrhzGnTNJOGcUgRvPcyZ7KYmsD4KQKLxTjq8syrXsPuBubbq
         XdwoyL3Z/TJrP3/74sa4QVjq4oVIUIRfzZtoLqtQbhpNkB3vZuOgKyBG99XpssAv7Lmr
         03BQ==
X-Gm-Message-State: AOJu0Yz32nsc/VPj3BVRm1C4BRNKRVbBJIhHsnZvCsHdlYBMgeACeA7Q
	PZ8ERptYYbp8JwRaqCtcwZaL4NbQqmu5OxIpNSpUMMtPRCPIn1jPO/xUORzW40k0qx6NnNQCadx
	pD8kewMIMc+NOPwJPhAsq4UtdK7kbMYdBNPzzDnAcXz0YWuDpPrQpkrlrbjT+8S5L3n9Efwu/Jp
	JJbjn0LCFY6D/WIcSKZpQsuPiXRr6T8pOctbP9tw==
X-Gm-Gg: ASbGnctMyeG10DLKcm5XUCXQy/wWvSOdj0Ksuov8dqTPqTHe76wrTr8snjgRLwrkbaS
	GMl8YiNCPr0+gwndsX75NDXL5afopXgeQ//8pBlCsOo21m3/9Ru/Mr4EFrHwLXNNE4Pgq91U7TN
	zHfN5Icyag8Lvs91m3+bRSlnlwSQSr+h/tHN9yhkBYSXRQHbepLKyyEKR3pm31O7BfGmiijzxt1
	OXZjrWnRefx7EPdStcaQWwmrZhzVMzZNE3vjVeHFvJ04OF/zYrgSbc2Oh5GJI6mJKmvT/6PoA==
X-Received: by 2002:a05:6000:4021:b0:388:c790:1dff with SMTP id ffacd0b85a97d-38bf57b6416mr2248247f8f.47.1737113012125;
        Fri, 17 Jan 2025 03:23:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE72elmRuQ3IimqzSUu6QU6G0gK2QuPb6GPLI5H3llmxGpJFepSeTiKxaA9sP+NqMgVGbAVQw==
X-Received: by 2002:a05:6000:4021:b0:388:c790:1dff with SMTP id ffacd0b85a97d-38bf57b6416mr2248207f8f.47.1737113011593;
        Fri, 17 Jan 2025 03:23:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:a105:b900:7e63:fa61:98e3:21ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408523sm30021135e9.8.2025.01.17.03.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:23:31 -0800 (PST)
From: Ales Nezbeda <anezbeda@redhat.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	mayflowerera@gmail.com,
	Ales Nezbeda <anezbeda@redhat.com>
Subject: [PATCH net-next] net: macsec: Add endianness annotations in salt struct
Date: Fri, 17 Jan 2025 12:22:28 +0100
Message-ID: <20250117112228.90948-1-anezbeda@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change resolves warning produced by sparse tool as currently
there is a mismatch between normal generic type in salt and endian
annotated type in macsec driver code. Endian annotated types should
be used here.

Sparse output:
warning: restricted ssci_t degrades to integer
warning: incorrect type in assignment (different base types)
    expected restricted ssci_t [usertype] ssci
    got unsigned int
warning: restricted __be64 degrades to integer
warning: incorrect type in assignment (different base types)
    expected restricted __be64 [usertype] pn
    got unsigned long long

Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
---
 include/net/macsec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index de216cbc6b05..bc7de5b53e54 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -38,8 +38,8 @@ struct metadata_dst;
 
 typedef union salt {
 	struct {
-		u32 ssci;
-		u64 pn;
+		ssci_t ssci;
+		__be64 pn;
 	} __packed;
 	u8 bytes[MACSEC_SALT_LEN];
 } __packed salt_t;
-- 
2.47.1


