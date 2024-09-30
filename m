Return-Path: <netdev+bounces-130378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14598A472
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D9C1F237E8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93F1922F2;
	Mon, 30 Sep 2024 13:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37551922F6;
	Mon, 30 Sep 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701952; cv=none; b=O6Zl5QkcKGNcAfuUMm2nzZwCX+ct4KL0f5RQnjpjnythT8iiYaP5nCIKinGXJpECRzL5ceHiFLCQZPEd+Ggm7rJEMKaTKBKveJvbLpzqrvNNiH/QeakFKqTZIu33SZzm28j1DCBSQ38qVzN9N1Kkh++MUtr7ulrq1ewhiicBnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701952; c=relaxed/simple;
	bh=tEvqjLyOELmf3FPDSTwodtrmDPjSk4Ucls88y+kFrgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ujgg9PIGxG1RzXjFWPDRnUH0+hXPH6SVFzmCqNlseh/tkICxI5f3lV5FEXojPXw/Kj68uXh+IX0TbOEcshHSXJItn8sV7QrnWyB9TgHKFJiiE9NwlYpoxrQYMG5l4LiQV6EmDv6Z9FvBNKAmS0rKbHWq1AOyKwzKGTAdlKDBaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so1788183a12.2;
        Mon, 30 Sep 2024 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701948; x=1728306748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2f7bj5YU9jZj+tChoovOkdp6lmafyVJGyWlFQy5iXQ=;
        b=XG5LCuysSu4FQnxaJML7WujwwC5z5dBtENO5zJfYnCO1QzrHJ2SgSNGgTnXJTuPZvR
         XQdBSdRo8ptfUWvjlMtXd4CGWtHg2qLT6fWwAFL9jbpkDWGyy9tgFESNICeUm0ttP7Mo
         QtfkMfPBVDilndtDAo/b1UG2nP3mAHJQ16+pXeXsaVmIzyPM3/mi3BY3scPng+zkjb2M
         nspoaHtqwVDJnOHe3zgxxJBaP4LhVQAcaQ7KKLcyNcJ6ibwdLiZjX0GQufR5QKKNlSYr
         64yJGVDNxZUHuOVAptAwlTFhYJJg9r9/CI82PqDQamJ1Xzlxg80mZ/J6kkuwuAuj0VJ1
         Xy+g==
X-Forwarded-Encrypted: i=1; AJvYcCUdnZBCBjvUhGlvi8SiB4vjYZHeIT6u4JG8PVegLwrFy1br+khYaa08b8ey8WRiQPtd9EJPuYEF3yvTAj0=@vger.kernel.org, AJvYcCX+DA0Nr7NqbgNHhRAFnihakv80kVGc9Tf9nqBQwwfAr8kU2XzUiNtWtrlAp4jgXhzx42oxOtdV@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUFMQTP/YKaXR/rm3wkn/kp106SoeZxEizOVyOCLJnZH0UhU0
	htr+lWAkdykcoQPZJPEDWMsbNj1Jnq3s5Eo7sQH2b3q0Sb8EJAak
X-Google-Smtp-Source: AGHT+IE2rcZvxSQ2QILa2kKXR59QbIvqI4wUeqQTjzbK2aadc21CEy4WreDv36ZHr1mVW1BbMKoAOw==
X-Received: by 2002:a17:907:1b13:b0:a86:c1ff:c973 with SMTP id a640c23a62f3a-a93c4a4e10fmr1277202466b.47.1727701947944;
        Mon, 30 Sep 2024 06:12:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5aadsm529721366b.79.2024.09.30.06.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	max@kutsevol.com
Subject: [PATCH net-next v4 05/10] net: netconsole: introduce variable to track body length
Date: Mon, 30 Sep 2024 06:12:04 -0700
Message-ID: <20240930131214.3771313-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new variable tracks the total length of the data to be sent,
encompassing both the message body (msgbody) and userdata, which is
collectively called body.

By explicitly defining body_len, the code becomes clearer and easier to
reason about, simplifying offset calculations and improving overall
readability of the function.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index da42dffa6296..eacb1bdb0c30 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1090,10 +1090,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 				int msg_len,
 				int release_len)
 {
+	int header_len, msgbody_len, body_len;
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
-	int header_len, msgbody_len;
 	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
@@ -1124,10 +1124,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
+	body_len = msgbody_len + userdata_len;
 	/* for now on, the header will be persisted, and the msgbody
 	 * will be replaced
 	 */
-	while (offset < msgbody_len + userdata_len) {
+	while (offset < body_len) {
 		int this_header = header_len;
 		int this_offset = 0;
 		int this_chunk = 0;
@@ -1135,7 +1136,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
 					 ",ncfrag=%d/%d;", offset,
-					 msgbody_len + userdata_len);
+					 body_len);
 
 		/* Not all msgbody data has been written yet */
 		if (offset < msgbody_len) {
@@ -1151,7 +1152,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		 * write, append userdata in this chunk
 		 */
 		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < userdata_len + msgbody_len) {
+		    offset + this_offset < body_len) {
 			int sent_userdata = (offset + this_offset) - msgbody_len;
 			int preceding_bytes = this_chunk + this_header;
 
-- 
2.43.5


