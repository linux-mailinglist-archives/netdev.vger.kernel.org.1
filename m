Return-Path: <netdev+bounces-130379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A652D98A474
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A091F21945
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63415192B68;
	Mon, 30 Sep 2024 13:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14C19258C;
	Mon, 30 Sep 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701953; cv=none; b=l4YBctaz5n6oz34rW2SJEof7/sdwIw3lM4+NRmPkYdxZgZCCU651aLJYDs5VrbGYVJbp9Y9GT8dIGkjiNbfDLOJ/56a/0sY5MDOane3sfBI7dQR2OiUL18C2R32fZYlCTRzP6SRqvgs5/6/wyZaZlBHzh7qCTdibRZ7XWyEPEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701953; c=relaxed/simple;
	bh=H7eqZp65Jgpb1u/+psH07NpvdOXjVU2jFsr1nTVJCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUR+mgrA5WupkrBv+bxTQA/YIGrDLwobXQ7byXmLsjb+ZRBmQf7PNMzvynTzlZfKeUn00QLkJBy6eKlugK3z6vOkVt5vL8u9kHK7tWM6CLrze9IHZQZ3zAj33jwr7URO59r+yf8PhuNd9AOxEWQqMlUwXsgIjlZe1TI+c1sHe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso2784189a12.3;
        Mon, 30 Sep 2024 06:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701950; x=1728306750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacXoX8k0E+HQ0hDaxFmO6ely6HyqGS2IJ10GYKgLHQ=;
        b=fPXchF2BPw3xTcaOSof3nHx23pTTRBzRRcgc+vj8FOCPXV52CTzKnmy2YtQtzm1oH1
         vL1ZYmrGzQcMFkkIxbM/4Ycu8hcvIPtV+QqaiChANEVVFWvkZ6jkeanEMJnViN4Yl3ll
         IfdqzAhQK4dKYAFlkyFnZYLiFQk6hJzbsvEvg4I792jlWNyRVdeXevKYart6u4vzo7BA
         JR+FeojK0OQukkgleFeFsK+AtU61bMs8bAE6gmDayUfKh0SZrDM8pClnmLuMu62Vtwrq
         DY2T9R6S7zYo6ZeKvzOkBuDt27P7WrllWfC5ZGD4kFs7YaGDytJvB50oaZyvcw2jdbJr
         gz+A==
X-Forwarded-Encrypted: i=1; AJvYcCU4P4v8oOha+vq65zoU5IlcZIPVkVxfJTaqFiQC0dGUr+SDEv5Qhqq4+Xnfc9abTMXdW06bVd9Z2m4ROzA=@vger.kernel.org, AJvYcCViwswUp5ttd7ehHcJ6ZnBphFgUSb+BOLjPogIoi2MgEgJo7O9LMO9xZRR7x+ohZ+UAVFDV5Fbz@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIg9QgbNCcrP6pALW8IaYN8eKTYFzUCTkC9O0OP+F4FQkJso0
	pgtjsZeXOwHm9dE7iFTeiCZ/eRw4LasWkB1YZf+8SxPg7iH+5sTi
X-Google-Smtp-Source: AGHT+IG1n7ePZLLJIcgnuKWMRUpH9K5dXbGlKEUjNSp0Twi4qY6bElBn8yo045enRhqyQn9yPoIjdQ==
X-Received: by 2002:a17:906:6a12:b0:a8d:6910:d0dc with SMTP id a640c23a62f3a-a93c4aebc3fmr1393888666b.53.1727701949753;
        Mon, 30 Sep 2024 06:12:29 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5977sm529291866b.55.2024.09.30.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:29 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/10] net: netconsole: track explicitly if msgbody was written to buffer
Date: Mon, 30 Sep 2024 06:12:05 -0700
Message-ID: <20240930131214.3771313-7-leitao@debian.org>
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

The current check to determine if the message body was fully sent is
difficult to follow. To improve clarity, introduce a variable that
explicitly tracks whether the message body (msgbody) has been completely
sent, indicating when it's time to begin sending userdata.

Additionally, add comments to make the code more understandable for
others who may work with it.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index eacb1bdb0c30..4e3b68a2c7c6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1130,6 +1130,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
+		bool msgbody_written = false;
 		int this_offset = 0;
 		int this_chunk = 0;
 
@@ -1148,12 +1149,21 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 			this_offset += this_chunk;
 		}
 
+		/* msgbody was finally written, either in the previous
+		 * messages and/or in the current buf. Time to write
+		 * the userdata.
+		 */
+		msgbody_written |= offset + this_offset >= msgbody_len;
+
 		/* Msg body is fully written and there is pending userdata to
 		 * write, append userdata in this chunk
 		 */
-		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < body_len) {
+		if (msgbody_written && offset + this_offset < body_len) {
+			/* Track how much user data was already sent. First
+			 * time here, sent_userdata is zero
+			 */
 			int sent_userdata = (offset + this_offset) - msgbody_len;
+			/* offset of bytes used in current buf */
 			int preceding_bytes = this_chunk + this_header;
 
 			if (WARN_ON_ONCE(sent_userdata < 0))
-- 
2.43.5


