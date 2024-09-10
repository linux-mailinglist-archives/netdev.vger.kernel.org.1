Return-Path: <netdev+bounces-126928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D732B973116
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C987B242A1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DA19049E;
	Tue, 10 Sep 2024 10:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B1195FD5;
	Tue, 10 Sep 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962675; cv=none; b=t9WgxLybwUdbLT97EZsiibYLMnLsoro1x6dNsFpb+Jbkd2ygxAfCuTFpA/RtVNk0NCUNMuNQwUkr2P8vLUY5vlopElXplQ4NMI2fg+UN2UJuRY8sVzx1gULJQJLpG51Suz0PP1dP+c5cbTkGTh1qExqoiJwhelgVDNguHSYh20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962675; c=relaxed/simple;
	bh=WxE+MqO9IF59LOFvBydiSddCHhj3Ff9s7KKnZYlLVPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXYuQJQ79bSPUy1l45WoM/45U+VURqmxotbGXhpf/07LIoXLydqByhm7k6FRkkrsnJaF+opeXHAQu04qNQsCqJxjEAlo/tVQyRni8fF/91O1IAhJ5CEiJVg3a6RG8ThZzdx49PhPBjCfJzxsk2LwZRR1NxfJ5FZKWw+gECAseJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d446adf6eso313765466b.2;
        Tue, 10 Sep 2024 03:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962671; x=1726567471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvXlMaYZ+vgHCaRdCb9MNmEXaTSsT8fjgwwnA5+yiDE=;
        b=WEwlgriJPmpbvfwjI+nhEsybCm9gHG8nJyZU172QkmxPefAGdUZwTM1qkDphwApm6I
         g2Y5kFfQpe+lMpGY5BGmVtxe3tYfnRKOK7Z5U76KJ24VzEEoFYxrv0lApuv8U/vW1tV6
         58IA+PUoIi2g3uTWe4w8SWm5g7DBx7k1AwMkpj+WVoXluzpWXFP8475dkwUhopKWpjdS
         VwP7tBctWGIkGP86mM3dm6PsXUzAr70Fo7crfoLpiSrv66wxDxJBBkbvBBbjIds00ksZ
         PqpYRORjpNLaAHhoKt4FSybAAS2oedGF6BO0Gs13IiD3yhnvmvtHIBnSWyyDI2STsXkH
         leYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO7MM6FDhxTjBISXAVlWpAJ1OuOyXKEBkx8DAMfuKVEOrr3VONgCOHTXAe7Tcds9mVo8Hxs1QOa6lPKd8=@vger.kernel.org, AJvYcCUVENSDHJaAOku4QSMB5dHwRxoRPCcQDwiQI7qhFhVvyEPj7uTwa+ZWReEf9UkCpEh2OE2aoaeh@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9+WCLdccacT9uEMPKSjLk+LN1rBmdBY/GpVpHgjz0RduFcPX
	oqSwXPGhq1EJt9YApt/W5FkfcdE8fNKYOff9ZxbJ1GYL34iI09Jn
X-Google-Smtp-Source: AGHT+IFz5DIbnAPoUkyVreJwGeNYfbkEbZyM01gzEal9JX0fmkZhFpsG7vu2JqcW8m4INu8uxQProQ==
X-Received: by 2002:a17:907:72d6:b0:a8a:83cb:ad13 with SMTP id a640c23a62f3a-a8ffad97d48mr18966366b.49.1725962669831;
        Tue, 10 Sep 2024 03:04:29 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5da53sm456591566b.209.2024.09.10.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:29 -0700 (PDT)
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
	max@kutsevol.com
Subject: [PATCH net-next v3 05/10] net: netconsole: introduce variable to track body length
Date: Tue, 10 Sep 2024 03:04:00 -0700
Message-ID: <20240910100410.2690012-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
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
index ca56c0ff57d0..ddf38141d30b 100644
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
 
 	if (userdata)
@@ -1122,10 +1122,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1133,7 +1134,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
 					 ",ncfrag=%d/%d;", offset,
-					 msgbody_len + userdata_len);
+					 body_len);
 
 		/* Not all msgbody data has been written yet */
 		if (offset < msgbody_len) {
@@ -1149,7 +1150,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		 * write, append userdata in this chunk
 		 */
 		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < userdata_len + msgbody_len) {
+		    offset + this_offset < body_len) {
 			int sent_userdata = (offset + this_offset) - msgbody_len;
 			int preceding_bytes = this_chunk + this_header;
 
-- 
2.43.5


