Return-Path: <netdev+bounces-136502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3869A1F07
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D0DB26BCC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691101DCB06;
	Thu, 17 Oct 2024 09:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14561DD556;
	Thu, 17 Oct 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158665; cv=none; b=uw5XMZZBppvpPFm8btv58tL9QYb2Qirov2R+Xt+7VKsiRhfdV1pYm2ol5J4YHw4bHzrjAZlA4ArMQZkVXg8tyqJDLgInjfHP24Mu19rsfSAI9sz/yN7NLK/yGx7mh4DdfrU86fwVoYx+LBW/Ix506u9uUX9VDs6MlXxcdDaGRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158665; c=relaxed/simple;
	bh=n/vjjkCbkFWQWl9HAYwVUViUNHDXTzrYAj4MUYQhlp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtdoKAplDKYoDAr42KS6pwi4kF8aEo4o0NXJsqLR7Y2RwhgVlzWrAWWqj7cpenMPffWHhRPSQSUKEu2876Co0M1cR2pc997iYulRBCijFtgaEN9LY9tvDuVV9fvcOLTPYpXjd7aEyDB/lXT5Nz4xGZIJS14Dygz2ZZvHis/JDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99ea294480so46075466b.2;
        Thu, 17 Oct 2024 02:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158662; x=1729763462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjpe0l3bZlOokvZFmHO4Q8i0x69QhLwteNPZIJVaTNA=;
        b=SG3HdkvA8OlWeDVcD55DqhkHXpzqPmqGK6KOwoibUXe+cLrCQuS9YIryzIHh1HXzx1
         cZVE9syOnPbhQLew6eBm+Wb8hdZZW1WYI0CTgtoLM4IZ4EaQtX1s9b6Av/WXZeRICb4T
         MjUw9H67/PrWf87T20zs/BWAca4vtrDtf00zELL3bMdZTNxhkyLo7GR7vIf9craFVXRl
         Z9aTdLi46zDjCoIZfM4D1uecc18uISAi5XTBdTSaPPCm/msxbhf76FzEC2k3Hzp0YnFY
         Ozfz49orJXuWX5PgILK5F0Xcj6v6xip6zYWrj01g7Fpk/a1RMcdFjnvxKqEx4XLfbe4G
         oJhA==
X-Forwarded-Encrypted: i=1; AJvYcCWXKoVaIQp3fnPYDJEOssTZ2hNQQzc6eCrqV2YdCXfklrHf10IDBCvf8/Lrnr5FYxfiO1VusGIk@vger.kernel.org, AJvYcCXYv0urBPxfiJVjVahO/8JSb1lyBBWY/t6kHrRxsGt6F/mD5/XF3nPSGHKU7YlrN+EmMOoVBC8drNNrxjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoqeDYQoyo6pbgtrXc5EWFXUYfm6UvV+0m9gulHTyxOKhx1MH
	R9TB8AZ3yaoz5PFxS9r0A3BP3vRayNJtSCNXTHlAh1kJIfP68f+O
X-Google-Smtp-Source: AGHT+IHPNT63pIiuPQp/GQpvdv5R++QjmXNxV01vuUJwVMGSC7UFId+a9gsOcviSMqQ4q4OXskdMCA==
X-Received: by 2002:a05:6402:370a:b0:5c9:44bc:f9b3 with SMTP id 4fb4d7f45d1cf-5c95ac15792mr20538206a12.11.1729158661786;
        Thu, 17 Oct 2024 02:51:01 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f8b92sm2563706a12.27.2024.10.17.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:51:00 -0700 (PDT)
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
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 6/9] net: netconsole: track explicitly if msgbody was written to buffer
Date: Thu, 17 Oct 2024 02:50:21 -0700
Message-ID: <20241017095028.3131508-7-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
References: <20241017095028.3131508-1-leitao@debian.org>
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
index 6a6806eeb0c6..9a5cca4ee8b8 100644
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


