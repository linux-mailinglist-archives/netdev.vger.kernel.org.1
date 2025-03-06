Return-Path: <netdev+bounces-172492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31CA55045
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10F47A3973
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDED212B15;
	Thu,  6 Mar 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/ljyBnw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D4145A0B
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277436; cv=none; b=YsfAuYrkY9fkxtvUZZgIboLb8oKMC7X756OTDRV9v8KE+rkbaMMJl71pfHWPevhtCrn+wK2DJYsDeGNE89bYO92liM0KWWNhNyWsf7lfUnmlqVS8vXeH3t+Kyt1jFQ1YEfL1BfPQ1sqCTXWXjBrm5HN8YFoEiBOinfHWpKzK7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277436; c=relaxed/simple;
	bh=Pt96Uovd1mpbJtnbuJAU2P1Aa68DKtd8BuptUSAoifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tif6031AwSdq0D1jrrv0wAGmIeoBldoLxJylO39b+O7TanZK2aT4DjBddHwSWdGSfYIH+sR1tj/C/JVfFS3uvFg8AIYB2ifnXxY96wYQwLvTjB8a7OXgSgF5kNj5yIjkt3yzNyKHKUrxmX8DjndMyAJ0FXT6v8kXEIiZdW8LTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/ljyBnw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFLrlOS+5ld0nvFR1DksJ9cDKB3+2CeK8laqLKQbEAA=;
	b=P/ljyBnwzsHe2HQK0JpR0604Rh6hsm9QSaCJekTpzaCTy/9EJt7OPogiWNMRvrqaX3TBC3
	p00VStz/Yr2nEHAgCINh+PJoEN7bia2Hybv2aefp8VVKHexu2VZ1wuizqGNYdGB4sNt/y+
	GswEIdPC3yWn6yTpvVB+qjsdSwt1D0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-t0ACNPD8M2Sn6e-DdCNxrA-1; Thu, 06 Mar 2025 11:10:32 -0500
X-MC-Unique: t0ACNPD8M2Sn6e-DdCNxrA-1
X-Mimecast-MFC-AGG-ID: t0ACNPD8M2Sn6e-DdCNxrA_1741277431
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912d9848a7so386072f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 08:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277431; x=1741882231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFLrlOS+5ld0nvFR1DksJ9cDKB3+2CeK8laqLKQbEAA=;
        b=sAZZA9AZ4GMOLjopUOzlnAyR/+kq+9kctmn9zezDzn0+YaHxDbJ3FPYK5zuVDk+L/4
         CcW7BRrf14RcLU2rFvL41W7MInoNOIWOAXQeZ9KHP7X6rc2CkJj2+fO11Fb5p6T1LaUd
         8u+nCltJOl2RuNNUKToBzHh2WJ+tLph0qd4s2hSpEN3w6CR1bJUk4M3HUlUIX20xyxE1
         SDzPtxwjs7D16x6wZ6EeyJEoI05mnP6yIJx4+7EfxBY+lMB2b6cTVHBcPc6q7CTrvJA+
         8UHC/pYyMsadIELlYMzXcAvlGV052WefeSlclU1F/Fn4S52AR22t1n4+f4C+ttKSFSSd
         H35g==
X-Forwarded-Encrypted: i=1; AJvYcCUA2AwCfVT6T9qwMuaA7zaCY5qZrHS7lZQVrMUY2eMQaKjMqJQsNPJpY3AodubZH5DsZtoVUWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdvqhfpJ/TL/ULDolPLlxZktoiTN2pZNAT8NOg2f3czcqtPQ8
	65Z6io2iNGOuI5MKGYxg2mbMpJS2ahin320kBRHfSW8APtuBCGEYfF8txtJJnL22fpXMnvYtQ8N
	2H3+ns0UaZNassOYzTKaGKmlaQuuy2XNRvRQGQDww+XnPhE/69gA4Pw==
X-Gm-Gg: ASbGncsIg9p9hv76NG4HcqDRhDybsLZd6jO7v5aw9fIwWQTLBra6QeftFRaWGUWczD1
	h1yB/EDHiHClOQz76Fx0BDJaaii87uNDnPRjAN7QNVJeGHUbhj8SARvk1ye4MToBclSHlZ//f9V
	YO4WcWsqF+QqDafO4TsjxvPpqv7WbzLsoQ3g8ffoT8ArQf1PqMWJOSdFK3IjbX6Cg54LDE8Ydu+
	rtio3LKSuL6XU6kpSaGBlWyAoD8y5nxemL0mK6WPqEawXv7R1ZHZF1OjfYSl57W8Isfu0CR0Y/Q
	YMBQsU4UG48ysH38KbT/fTR79baKzETo6Gx6eNjujBAh
X-Received: by 2002:a05:6000:1842:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-391320a39c5mr75406f8f.15.1741277431045;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdg1mu+YRP1IQFJUy+MGaPyfw9bRzO4/4jxtF7UGS83/MvazwuQz4R3F7VzC0vThUykW3fnQ==
X-Received: by 2002:a05:6000:1842:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-391320a39c5mr75368f8f.15.1741277430721;
        Thu, 06 Mar 2025 08:10:30 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:30 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 06 Mar 2025 17:09:32 +0100
Subject: [PATCH net-next 1/2] vsock/test: Add new function to check for
 timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-test_vsock-v1-1-0320b5accf92@redhat.com>
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
In-Reply-To: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Add `timeout_check_expired` function that returns true if the timeout
counter has expired.

This is useful in situations where a timeout does not necessarily mean a
failure.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/timeout.c | 7 ++++++-
 tools/testing/vsock/timeout.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vsock/timeout.c b/tools/testing/vsock/timeout.c
index 44aee49b6cee07deb9443e3c2595ef680b726053..d6c69b14a0385befa6204a311c0a7f0c148ab021 100644
--- a/tools/testing/vsock/timeout.c
+++ b/tools/testing/vsock/timeout.c
@@ -18,7 +18,6 @@
  */
 
 #include <stdlib.h>
-#include <stdbool.h>
 #include <unistd.h>
 #include <stdio.h>
 #include "timeout.h"
@@ -43,6 +42,12 @@ void timeout_begin(unsigned int seconds)
 	alarm(seconds);
 }
 
+/* Check if timer has expired */
+bool timeout_check_expired(void)
+{
+	return timeout;
+}
+
 /* Exit with an error message if the timeout has expired */
 void timeout_check(const char *operation)
 {
diff --git a/tools/testing/vsock/timeout.h b/tools/testing/vsock/timeout.h
index ecb7c840e65ae5d40419bf5f9ca57fdf4051aa41..cbb183e3a73784b82b2139fbf7a00fd62521ad77 100644
--- a/tools/testing/vsock/timeout.h
+++ b/tools/testing/vsock/timeout.h
@@ -2,6 +2,8 @@
 #ifndef TIMEOUT_H
 #define TIMEOUT_H
 
+#include <stdbool.h>
+
 enum {
 	/* Default timeout */
 	TIMEOUT = 10 /* seconds */
@@ -10,6 +12,7 @@ enum {
 void sigalrm(int signo);
 void timeout_begin(unsigned int seconds);
 void timeout_check(const char *operation);
+bool timeout_check_expired(void);
 void timeout_end(void);
 
 #endif /* TIMEOUT_H */

-- 
2.48.1


