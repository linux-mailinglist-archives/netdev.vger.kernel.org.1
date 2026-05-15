Return-Path: <netdev+bounces-288424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OldHY9qB2oJ2QIAu9opvQ
	(envelope-from <netdev+bounces-288424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 184545567F1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FAD63053EB8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC64F7994;
	Fri, 15 May 2026 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLQ9yJNB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSG+50wy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED83F6C47
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870767; cv=none; b=KlzlfZU26ypsq1myhN4mjkqWAYAGIFNodHLY7eY0GIcjzy9F6jqSLdRwf7DZ78VdSP5Ock1QgoFwnX7DYBaY1TUQn+BVvXLuFwZcw0wbLoS+NMiiUHPz0G6OP7KOWnqKr9W7poC+8pjS+YK+V5UcgJbJbLGR7ibCJ1SUeP1/0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870767; c=relaxed/simple;
	bh=8Fico6GxGLx0BFWtWqZ5m7ahdl/3AhNeMXDzjZrDjXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oskler6glK9nnmCGr/eb4EvtJl0OeHQs9AleiyVSZZpdZPmqzDTmN8Cul7ZFfFEQu8dmC0dtBTnNLEMcjhS+Zdgyq/LAEoWSUZqc/Zi3YdkFGO5lFhWtZggJu8mekGU3gj3+0EbGjV9Mq7zA/ET4fgjdduPv+KGuCVSSsQWOljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLQ9yJNB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSG+50wy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778870758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tnGQlXm7u5Sp1TJeQ4tRREW84oeSFGKNmP1Xyq1kCQo=;
	b=QLQ9yJNBedLy6t5tMVMOtl8f0GdmiSCfBEnT9ebEMNnwLqdKVcCs7OaNwToDbUtT0ImFMG
	GvYyT+an3S5gmu5B4FeYqey3ga2ESy03FsNQAvU7vR310pOPWcyC5B0of2+3ucK3hZFWRp
	7rV/Y2auUPPPG1FGvZKqDvIdRzN/TgY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-lW_zfHZGOEKqaZBBqOypag-1; Fri, 15 May 2026 14:45:57 -0400
X-MC-Unique: lW_zfHZGOEKqaZBBqOypag-1
X-Mimecast-MFC-AGG-ID: lW_zfHZGOEKqaZBBqOypag_1778870756
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so70070f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778870756; x=1779475556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnGQlXm7u5Sp1TJeQ4tRREW84oeSFGKNmP1Xyq1kCQo=;
        b=hSG+50wy1LveZQiQofGOaReceGRQhAsmZswKZjgjw5MycG/awgzqlBi/Qm24CLleoo
         sWpVGQkwGyvZwMLDoC2btKo2FGgBH/4hZVzzdiooqN6foxGVjhG2J/ojhfajdEX52NrN
         UDlV2mjffSA69JgGELdj5rR7fjk5JXtXGdAWrVImSYLBlGLsXfbBBKkLZTH4Nq7BFo9B
         LUfEjMMW8oJJr3sQoNjPqrKhAPo7L9YgzGU1/S4vqlpOHYA6FyqTzbtAi6LbkOc3H42m
         +FHAspwVXWjWLmlBLv9hFN9f385EuJscjJUhtggwYPCClZ9ge/4IQK33kY57P1zDuMcD
         ZpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778870756; x=1779475556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnGQlXm7u5Sp1TJeQ4tRREW84oeSFGKNmP1Xyq1kCQo=;
        b=WG5Vnsp2858kYYXEMKUlVaOfv/lcrptcnL/m668NX3xZNw1P2lT9wvnHokD+41daq0
         mHNM/wFKxHOC/iRc7bjSogLAl7fZcY7m7lIW8UnC7k5Npi05pffmsqXLyYrM9mLt/yLQ
         Cc4yC+bZWym//nNX81CJe269XrdIo/bLwotITg2lH/vE3CU6QhiQDIuRMKfAhKrnTCDY
         ttDwKcSQ12O2qPiJFQD+sNtjuZl3+01dP7iMrYxSXIMzavXwkN6c3+LWVHgPRiRMn6oS
         e5p8IWTkUjh/I1RuJHg2XWYkDFTZPGula6JTkkypF/Old+tw4LPNWy2jfUYFW6hXCcAP
         B8xw==
X-Gm-Message-State: AOJu0YxGjMvYEqUldJqss3VoBCTERjWLRwwSEaM93b6sXqD3sABjEHdr
	mRQ8oYIvn22pBJBj2pY6AeXLe0q1pHzzmbInSg1xLoX/MqG7SK5dVYBMl7xNrS5huduobJNPHYW
	a0WWUNDmFjdA/7LXcpjYylr7kVLMc75v/yzf07LQ7zM4ubFsrkaetUE8oaw==
X-Gm-Gg: Acq92OGPbehcrJmqDK7PWdOiXeoVqztQytpztKPqpMOyoDbRcuIY4Zfc4O/QkS08dLB
	agTAY8tohjUklRGRMD1F7vJsfK8XQcOgixCsUKRHtWUZjd2TR7bQiBshRuzmxR8OgPqSeS856g0
	jj9F61+sTbNs7JjDXdCa69RpjD/onnEpsLGKFJvcUcdwmS+8d9nx1+o5PPeizNzbmuq/YGK0iGr
	cOh17+omgVywhUgZfWQAevLJHleIQZ8FytVPgaEVoqezmhVfW1wFR64GdzpcADI5xHXKxuuW3Nt
	oMVaUMtbkh7DTXB6cbYWC8XOc1f6WGLe3oo+p72p3yJX12I5ra6fe1SD4A+ICrPm+EJtu2W5FdV
	S43eupdM2esi2VFKdk6rQLqDS6P02a5je6MM=
X-Received: by 2002:a05:600d:10:b0:48f:cfae:b654 with SMTP id 5b1f17b1804b1-48fe60e5537mr63150725e9.1.1778870755796;
        Fri, 15 May 2026 11:45:55 -0700 (PDT)
X-Received: by 2002:a05:600d:10:b0:48f:cfae:b654 with SMTP id 5b1f17b1804b1-48fe60e5537mr63150515e9.1.1778870755390;
        Fri, 15 May 2026 11:45:55 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm75284865e9.12.2026.05.15.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:45:54 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] include: Remove unused ks8851_mll.h
Date: Fri, 15 May 2026 21:45:25 +0300
Message-ID: <20260515184531.1515418-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 184545567F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288424-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[costa.shul@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The last user was removed in commit 72628da6d634 ("net: ks8851:
Remove ks8851_mll.c") which consolidated the driver into a
common implementation. No file includes this header.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/ks8851_mll.h | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 include/linux/ks8851_mll.h

diff --git a/include/linux/ks8851_mll.h b/include/linux/ks8851_mll.h
deleted file mode 100644
index 57c0a39ed796..000000000000
--- a/include/linux/ks8851_mll.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * ks8861_mll platform data struct definition
- * Copyright (c) 2012 BTicino S.p.A.
- */
-
-#ifndef _LINUX_KS8851_MLL_H
-#define _LINUX_KS8851_MLL_H
-
-#include <linux/if_ether.h>
-
-/**
- * struct ks8851_mll_platform_data - Platform data of the KS8851_MLL network driver
- * @macaddr:	The MAC address of the device, set to all 0:s to use the on in
- *		the chip.
- */
-struct ks8851_mll_platform_data {
-	u8 mac_addr[ETH_ALEN];
-};
-
-#endif
-- 
2.53.0


