Return-Path: <netdev+bounces-61073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B517822603
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195351C21BC8
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E3ED5;
	Wed,  3 Jan 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="blq72EDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952B657
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdfed46372so6036786a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242172; x=1704846972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/BS9I1G25iZlaKnjcUNfLqctGtiSHWfr43vpJ46xOc=;
        b=blq72EDGdbQOXNL+P8KhmAMQE6sASM2fKDCj9QgQyC9nZ7VZbvFWwlz1Pde7ETbp/u
         Zvgbg5Xlsps0qvL9/F2cW0XXBNaLI+ZHZdhP2G4ee4wZi3dogInsHprjFVcpSvcmwfCG
         1qK1bxPAQmgxBhm6fKwQsuuW5jJgWebE7XvjrFtDkkei9fmwpdeB9iyBjfb08x/olFrh
         bNSMPP8dhWkz75FgnNgt66lNvFjyXZvAxbGjjrcINLrqKje000ufA5aY/lufbRg0Z3GH
         AJqKqbnPNS1oCF52JxFAUrWzALnetbBJmhajrnHu1qqdYEMiGnJ0WyOOOlrDJZmkK9Io
         3vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242172; x=1704846972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/BS9I1G25iZlaKnjcUNfLqctGtiSHWfr43vpJ46xOc=;
        b=ezWFB1rxNl75P57lDXNmWPTjUKIC4bsri3Pk37JMF0h7mRWjYTW3ydyssdFX3myWrR
         f4Q9BDCyBUn6qxEacBs+77z4AfUhISVD+3gcnMt8L/pwmFXQgmfo/ttOGsFzE6GLqOLO
         zOxObEWBoxqOBwpV7gjUVhsxCjaD7HVrFQBDLL4LriwN6qFylChmymOLp5GZPQEL9Rve
         4xNE/bxklSWMzW7x99Uocs8N5RZQioKkheDJ9xz5ruXVEV/4JGC9kStZmhR/Gqq0H/yI
         f1NEsS0rExR+Cg8dyGPJzk6nlTRqNRsIbW6AU+lCPuCdYUw/EfvQTSGY08rpeqz90EH3
         xWUA==
X-Gm-Message-State: AOJu0YwSpQHjrq4wryl/CZjCryatEN3OFw261YCEhMOK997Ydkktsvy2
	YsoIq3YkUuomHNqKL1kV74vflBzTfMiYMQ==
X-Google-Smtp-Source: AGHT+IFjqIiEeh9Kogv9fa3yCDvszG3hFCuGHmO12V01W1c3FGULl0DD8mQcWAoSHRR+mpLNMG2mrA==
X-Received: by 2002:a05:6a20:8e04:b0:196:34fb:89db with SMTP id y4-20020a056a208e0400b0019634fb89dbmr12905934pzj.52.1704242171804;
        Tue, 02 Jan 2024 16:36:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 4/8] rdma: make supress_errors a bit
Date: Tue,  2 Jan 2024 16:34:29 -0800
Message-ID: <20240103003558.20615-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other command line flags supress_errors can be a bit.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rdma/rdma.h b/rdma/rdma.h
index f9308dbcfafd..65e3557d4036 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -61,6 +61,7 @@ struct rd {
 	uint8_t show_details:1;
 	uint8_t show_driver_details:1;
 	uint8_t show_raw:1;
+	uint8_t suppress_errors:1;
 	struct list_head dev_map_list;
 	uint32_t dev_idx;
 	uint32_t port_idx;
@@ -68,7 +69,6 @@ struct rd {
 	struct nlmsghdr *nlh;
 	char *buff;
 	json_writer_t *jw;
-	bool suppress_errors;
 	struct list_head filter_list;
 	char *link_name;
 	char *link_type;
-- 
2.43.0


