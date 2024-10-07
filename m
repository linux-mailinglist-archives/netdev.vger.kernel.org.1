Return-Path: <netdev+bounces-132799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A7993393
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6271F246B2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBB31DC18E;
	Mon,  7 Oct 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xOvQElHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408531DB93A
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319027; cv=none; b=qIm+hbBXnnEYrQF0xXqnTlkDtt9bKCafBvWWzI7IDQG2zAWsO4wCraTEh5IWKZQRfa1w9u5WVOcd9HmGfC7HkFxqOM3Ghyuve9giZX82vCfXWznGmzErL1ZBlE1lBeS/UVYn+LhY/2myrt13Jmbq3FL8mbeAByJGaWqDjd2mT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319027; c=relaxed/simple;
	bh=05R7gm7Id9euVyPJEyg5tVsltyNkAPmC+Vt/PWC+bA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ii0IabOiBpapT4xyctbhWwrsDCD2/vEVo4KqVlChCOgdxmi8kAijQs0WndqrUxwceOnOiA3YeADhsBjXW2dwU+OrDAss5IGsRBHFV6nJBm9YOZD1IlFFeiiZs2iAA3VbZ83pn2nBLjKk2O7whupAPomnIouwB28fWU406xQPCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xOvQElHT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e06ba441cso718468b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1728319024; x=1728923824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoCHd+4d/pyn51Cd83AkOUJFWHKkqyQwz+K7l3/LVi8=;
        b=xOvQElHTEv1sma1KXLeliCAVOYiPmJkhguykf8uPoF/pbf9XL/r0Ao3T/DMtwgMm3m
         OKhNP5RXUni7FCXPA8IsvckF+XTYvKa0oxVfYECGmG5ouIfV3XODbBsEBCy8OriDFJ4b
         Gk2n69VvtEWnOxsCVQQqPZPwwaRtyeUrP1rUxFGsRXLoyMIFibFDeGs8n1AIvVQAYxTQ
         NK981Y6kGPcdwkoC5LDtL6DbVHxHLRa2EBmnd9DgXDbbqjF/X1XpMStloIYBnLZfAXpv
         Q5pkPEDCgW0mOc7bObcKh8Ni/5p2gxOuVZrZmNYBv+DYsVMKYo97ONuK8VKd2/Cnctm0
         k0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319024; x=1728923824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoCHd+4d/pyn51Cd83AkOUJFWHKkqyQwz+K7l3/LVi8=;
        b=E6iX3IM8kxWrGJ/A9nglk29qN4JdBQfX+YDmIEAaFj7Et26n2eVwg8pVNWrJXYMdgr
         xCRCbseXIZCR1mNj6BkRbqN8VnsQdm069OgqvK9EhZ0WLJJ0SWntYM0SNuc/Ja4m5xwj
         De+MjAI44zGaDVRY6UV5vRSXhz5siYMLWi/Jd1bLeUwTCp+txIRjNtOF8RdJf4gbrCht
         9BoaT3UNkyNwguOg1cQ07Xq8QjUogi/tekYCbK5dXShExLc5B0mvBST9QlFBWkukI67Z
         dsVUduKtvfKYmW+grsVo8k4SMdMUjW3oI+TjK1NKBqABu3yzYJczXMofULuGbEk9Catl
         CARA==
X-Gm-Message-State: AOJu0YxeARJb0gFEMpGQZNxt+rBioI5GU0wEAiv6PBxK/jg70EgQMtby
	JqrnkvqxvBGUgQ/Mhc8jvHR0pWHZelKpOTpyul4AYC1B0eYhge6gYm5Yx992mNnDPibx4nhQmqZ
	E
X-Google-Smtp-Source: AGHT+IFvnzAKnpDGDGbRNQgRyIBEtWxEj/Zfvd2FEmjSir/Ilw5JHmd8+kPtoBU+ib2qgWKE/4RTxg==
X-Received: by 2002:a05:6a00:2e09:b0:71e:f7d:5c64 with SMTP id d2e1a72fcca58-71e0f7d5ebdmr970673b3a.6.1728319024376;
        Mon, 07 Oct 2024 09:37:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dfea52097sm2782010b3a.103.2024.10.07.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:37:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] bridge: catch invalid stp state
Date: Mon,  7 Oct 2024 09:35:43 -0700
Message-ID: <20241007163654.499827-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The stp state parsing was putting result in an __u8 which
would mean that check for invalid string was never happening.

Caught by enabling -Wextra:
    CC       mst.o
mst.c: In function ‘mst_set’:
mst.c:217:27: warning: comparison is always false due to limited range of data type [-Wtype-limits]
  217 |                 if (state == -1) {

Fixes: dae3e5de6eac ("bridge: mst: Add get/set support for MST states")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

---
 bridge/mst.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/bridge/mst.c b/bridge/mst.c
index fccb7fd6..32f64aba 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -176,7 +176,7 @@ static int mst_set(int argc, char **argv)
 	char *d = NULL, *m = NULL, *s = NULL, *endptr;
 	struct rtattr *af_spec, *mst, *entry;
 	__u16 msti;
-	__u8 state;
+	int state;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -212,13 +212,12 @@ static int mst_set(int argc, char **argv)
 	}
 
 	state = strtol(s, &endptr, 10);
-	if (!(*s != '\0' && *endptr == '\0')) {
+	if (!(*s != '\0' && *endptr == '\0'))
 		state = parse_stp_state(s);
-		if (state == -1) {
-			fprintf(stderr,
-				"Error: invalid STP port state\n");
-			return -1;
-		}
+	
+	if (state < 0 || state > UINT8_MAX) {
+		fprintf(stderr, "Error: invalid STP port state\n");
+		return -1;
 	}
 
 	af_spec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
-- 
2.45.2


