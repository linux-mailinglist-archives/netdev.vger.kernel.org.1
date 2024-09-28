Return-Path: <netdev+bounces-130181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCC4988EC9
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D7B282490
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6719D8B8;
	Sat, 28 Sep 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DHaI4RJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569574BED
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515450; cv=none; b=lECDhmtlTus8OnNPIrwUs04kiNPBLJi6L+lC3J3ArffFwmfaoPOo8Bqw7eKb3c3yDZjhmF1BUYkbCXK6XMWldYS7EhhvfEZFvRXOvJm8l8/BsU//0XzvfEQzS1/KwjYOUZc0LXuZXZFNfKoCImxbqcPh6H2JyEXvEur2cGqJ6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515450; c=relaxed/simple;
	bh=pknTOLQO4Kr1/oCTM+kmD+VH5GuQxaXGOBItD+9UL3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/mB4RWZ9JX2E7rnFit/qefobHJbNtlvrOX2x7CyItwK2odef3CKC8T6V7s5u3qzeV3jZXlA+zETbiw6vQJ7LAZURvdBbHAJoWdjuhhS1GdWlrS4Bdfi1/R6h8GD66doR8ZyhaS8xUvoyTmN1mNP3NHWhcbhyoDFzErzGQY+lYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=DHaI4RJB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a93a1cda54dso382655666b.2
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727515447; x=1728120247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pN05rJxi9x5uAQd3SKaJJht/p4GtRgscSDxujywkLE0=;
        b=DHaI4RJBZYOXfIvhY7YfjQElhjv8RXSxK9yhlc7qzNocRu4f4rhHzLYKXwX1T3TPNk
         DQ8dqPfDLIExyaqOo8kus2aZAxcTuZalCxZNKSVAkmYU7WCmKXMXcfnKLlfGw86wbnp1
         sq27qmMbugQk4+5oCo3yPpp2wRimfDPdzuYT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727515447; x=1728120247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pN05rJxi9x5uAQd3SKaJJht/p4GtRgscSDxujywkLE0=;
        b=PhSeqGiJwBEA2HtWtVoLPyMtGfjXNpBgcRJ8x3Bsm6xOGZLziEq6fJZpsmG+2u0eR9
         0zlXz9c62S+OMD4elau1UaIIFJkl1GfEC+RGzt1IMrobVcSwYXkomvDoiB/QYpEhM7R+
         S+HYWiPk2LC30+vQyIE3qJPSZvUpy8hrDCPoiUtq77pTyK0Q2oKDsBu4LyCDkeDiAbbt
         e/J/F4sMvEuFqt9l9BMDXvhD+Iv9vqIvNe0ZvEAgjy8pgE7zHMYboJxNS2yczDEh8Imb
         1vUx/iJoW8RmY9Xrb05G7FJiXVwya72XfN8i9Nwh+SEhro1Z80emtBSCAEsTb45cAiLM
         db3g==
X-Gm-Message-State: AOJu0Yy2BUT0Ghx2NgLHWFjFLYNnHuzTTq6IpGidUe2a1pNC/YWB5xUU
	EoP9UFHlXNOa9tiFnazVkBhaej3e4uKWdpj97eh3ZyCaW1NU90rf96ktk3ONzQ+4KA0H3Bm1BuU
	37JM=
X-Google-Smtp-Source: AGHT+IHZBiBKf77/YLMPmt2+sYw7/FTrVme4uuhHfw6zEcdnAVtMVgS93tdxA1puddbRQDlPk4lTSA==
X-Received: by 2002:a17:907:6ea1:b0:a86:8f8f:4761 with SMTP id a640c23a62f3a-a93c491ae88mr496682266b.25.1727515447207;
        Sat, 28 Sep 2024 02:24:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248c672sm2104213a12.60.2024.09.28.02.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 02:24:06 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [iproute2, PATCH v2 1/2] arpd: use designated initializers for msghdr structure
Date: Sat, 28 Sep 2024 11:03:11 +0200
Message-ID: <20240928090312.1079952-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following error:

arpd.c:442:17: error: initialization of 'int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
  442 |                 NULL,   0,

raised by Buildroot autobuilder [1].

In the case in question, the analysis of socket.h [2] containing the
msghdr structure shows that it has been modified with the addition of
padding fields, which cause the compilation error. The use of designated
initializers allows the issue to be fixed.

struct msghdr {
	void *msg_name;
	socklen_t msg_namelen;
	struct iovec *msg_iov;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
	int __pad1;
#endif
	int msg_iovlen;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
	int __pad1;
#endif
	void *msg_control;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
	int __pad2;
#endif
	socklen_t msg_controllen;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
	int __pad2;
#endif
	int msg_flags;
};

[1] http://autobuild.buildroot.org/results/e4cdfa38ae9578992f1c0ff5c4edae3cc0836e3c/
[2] iproute2/host/mips64-buildroot-linux-musl/sysroot/usr/include/sys/socket.h

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
Changes v1 -> v2:
 - Put one field per line.
 - Drop (void *) cast for msg_control field.

 misc/arpd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index e77ef53928a2..91f0006a60aa 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -437,10 +437,13 @@ static void get_kern_msg(void)
 	struct iovec iov;
 	char   buf[8192];
 	struct msghdr msg = {
-		(void *)&nladdr, sizeof(nladdr),
-		&iov,	1,
-		NULL,	0,
-		0
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.43.0


