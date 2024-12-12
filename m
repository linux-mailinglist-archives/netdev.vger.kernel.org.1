Return-Path: <netdev+bounces-151540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35AE9EFF43
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EC9288C20
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA61DE4E6;
	Thu, 12 Dec 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2Ffbyh76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A521DE3BB
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042362; cv=none; b=VgL3WXjQE/RtKPvumCo7Zz0NjkcLXKRdyQi7gOJJhk2RYvnhipcPDZbVnrAHzwew94qZZieFLlcfJxTpa159c5bqt+OqmnVlL3XVkrZ3SiNPaOoqQWE5ocT1hvuYBQqGnoSxxUkwCI3nLIMX2ZhR6se7lIOpsAsdLirt4PglvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042362; c=relaxed/simple;
	bh=/fAya+9A4bhFtyBHllrRNOCRupcLEp/GX4R4N5VBE9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmMy1RJoZqqPO8P237lEUsy0hkkndiT2TfFkaMURGVk6uj4StZdbmiW7WjIefjniNHNV4OR758FJ4XSeFKk++g+geHO+UAxhn7oNFZdnZNHAvKhpGd6nmE3pjLAI+vMxd2oi+AThSJiR+RXCn/nRqOj4nFoJxHIM3HMjqYV4RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2Ffbyh76; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd4c0220bbso1118225a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042360; x=1734647160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWH9r5/Sv7p3uIF7b2F6sFHv67FgQsEau01gE/tDQ7A=;
        b=2Ffbyh76aNx7OipD0twiluOIvY+qlbemEaMEuiGrbTp1JwrywjA18747jIGmYFFJJK
         iufp/erTlMuErEON4hPpMrEA3wZPp2TXjhcGE/htwwkP8n+CpXbCV61uBP5luQtpxvXm
         OpWYsqq/5Nwv3IdsC0Kz3ZNebL3WwLqX54h71SZTIOg1oLEPyAwP7LqdAXQ7XrZcUDtz
         d5kEweRJjYNdYkV+GpEBoXrXuGo/7yEahFCEumW3hMxpFucDIb81djcjgqJx4/4Tv9ze
         c0ALgnbWj93htPTYFtcTBPSMbQs/MA4szks3nt4B9/bHl7zSH45fuR5BJB01/8eVIMT7
         kPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042360; x=1734647160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWH9r5/Sv7p3uIF7b2F6sFHv67FgQsEau01gE/tDQ7A=;
        b=Lo7MG++edFx82ox+Qtcv69o9TmStuTnMpgpaA5AAnDyv8G2+UkvVc1ovg5A9KM1Dz/
         PgPC9KDV5G02u3xjf3z31lv9hqZfqPFuMouM1n/aGde4KSqlZbWdOBqG4T/sGV7MeFnO
         WdZumm1paw4yiIqX0/uU2YfBngwaCguSqTMIWDlyq1oX1X8xSXNopivVjx3MkxM7hpDm
         YxhUzv5V7yHhHYHR97jZLHaK0pmFFDcxXFyOusOYJkGA2PgJFaOul0tWG6wyPVoFskSA
         B9rodR50tm4ohlTUiFsgWbZPAghjnhXlI2hc0dxNQxol0NH/Uhm79AV5L1dXh1QYCvtG
         A1Uw==
X-Gm-Message-State: AOJu0Ywi5KsQwMRfd1xKVGEXLuxhKcYIKFXsBvPKB8tgZeY14DhX7XZb
	7gY7Y/jJi4qnIg6NPIUJxGzre//e0NHTYPYqGKFYH+tUcmpi9WVTWR4Aw6DlqnCvgpfgHbYN4ve
	W
X-Gm-Gg: ASbGnct8O2wIFrShIBRNzf+e8csXS9g05RFo9Fy25+sp4gJMM5F7/SKTqsrdcgnAhKq
	EHFon8wHbOucaQHPqZVeq/k8VztGmeqB33/hLfiOeWoc6tv+xUKnfg5WvKZon+IvRCTRZRc7jjK
	WNawqHJiDJyCEtiwiJNv4l+cnBkWo+kcZ1w8bQSoC9WQEwm0mAc2ePWB6zs0aggUraMguOIdKTK
	mLG6tt4rGRLNqXnT0FDxcAv69OGgTLg5+F10VHy7PZNRM4nbc3DLT3ql4vcJKsjl18583mY0zzN
	cdZfZPlbv3IrJrbQWdZFxxRvNa8TQw/2gA==
X-Google-Smtp-Source: AGHT+IHU8RqhRO/ufSZa2oSwyxuHRpieaDet72TiluhgixOJM5CJ9Yp76e0vkcqL9VnyuISi7sIYgQ==
X-Received: by 2002:a17:90a:df8d:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2f2901b3a34mr636163a91.35.1734042359907;
        Thu, 12 Dec 2024 14:25:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:25:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/6] libnetlink: add missing endian.h
Date: Thu, 12 Dec 2024 14:24:26 -0800
Message-ID: <20241212222549.43749-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212222549.43749-1-stephen@networkplumber.org>
References: <20241212222549.43749-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need endian.h to get htobe64 with musl.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..7074e913 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <endian.h>
 #include <asm/types.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
-- 
2.45.2


