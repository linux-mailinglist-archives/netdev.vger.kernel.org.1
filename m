Return-Path: <netdev+bounces-126514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2048971A67
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B8E1F24262
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525791BAED8;
	Mon,  9 Sep 2024 13:08:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BC1B86E4;
	Mon,  9 Sep 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887301; cv=none; b=K4pWlMezreFGgQGvXO2WnbM8icqRe5G8xyMU3MpW60DBeZbGJOu6KzA857RL5Q6xAWD1NZ0cnOCZN+HQoOjW2bql0QQ6aQOIxVWETL7uOjzqoEiWU2vFD+kTvS3W4/tDiGhDWS2/4wDE3VLoTkQvJRNMgKdoVIv7X1g3Yq1dfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887301; c=relaxed/simple;
	bh=wz4RNDumEdEfzGuNdo2cdE+72FVQyN7S964XuEih65M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9hgXudsxuh4aSR2tcFlskBIImkUuJ8dT2K6INu6HzxfYVukVkx9sDiv+yaMRyt8RxAcwjVgklyJ5mxB6uLvkeP9xY+Rwzea7bXw0RGn/1H9qn1BF85wic6sNpwk+SCZd9EtaEf9bKSsjrTzQBbaWgCfWH064jz1CWm2Jgm2Aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d404c7634so175325966b.3;
        Mon, 09 Sep 2024 06:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887298; x=1726492098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6K3mbQ5LyA763gr290EAxVIUfbF8tkfg7wJo8NwS6Y=;
        b=FluLleJJDDljlakXTHEZEWiWAPY2gve5I0tA1ghR48zvGlv4jz/u+EiVIEDZVXXdUP
         xKR14GC/CVFTmJdJxHkcBr54yC7uqFKZLRI+p1hJiVhNDuU9d55G5M8OsRG3gG9gy12h
         ++9bML9PQ5axO6iMElNcGRdhb5U0L4wSC6LuOOBlaICCzSlFym/VXo5e8ZKkJTNB3SxK
         83Z143Ne/kyzRnQRcemXCa3u27z5D9brDeg4vvrptMXlwG0/y0W3Sz7upqvXajSw74sk
         1eHUqQmbh1mMyB8AGFjvFuim/5p+wc2yafsxu+Jk6j3LujSHQht43qjnmg64YRBJ9xBG
         NwUw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9bGJq7aIXHvPyQF2u3V6r7w7VHcVGnQPl/uT24h5VeCk8uIOFZfeS1rI8n/iq6yPXBiUqp+u6QGQujQ=@vger.kernel.org, AJvYcCXyibRlLruke2A/lBkaBtYNYTzPqRSCLImbN+ypLAA9ouAqUWtcVS/u/JLly+WScgxTxDCg0YQ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzpu2rmm6J/je/3C+/JdL267jFm21EB8NzRDoVRaGOVxRhSXML
	rtbXXxBxqq4xWp6P/vDSPqEl3nZgvLBVopD0zoQE1/pP716uPDg2
X-Google-Smtp-Source: AGHT+IGcvu3+ye3I/1xYbHB1igh7Iv8h7ANc2ue2phfDnYCC8xdrsIkPIRBTANr3F41wl0BjrxprNg==
X-Received: by 2002:a17:907:60cb:b0:a8d:3998:2de with SMTP id a640c23a62f3a-a8d39982a9emr449204366b.12.1725887297917;
        Mon, 09 Sep 2024 06:08:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2598b85bsm339183666b.77.2024.09.09.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:17 -0700 (PDT)
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
Subject: [PATCH net-next v2 06/10] net: netconsole: track explicitly if msgbody was written to buffer
Date: Mon,  9 Sep 2024 06:07:47 -0700
Message-ID: <20240909130756.2722126-7-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
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
 drivers/net/netconsole.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3350016db0d..1366b948bcbf 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1128,6 +1128,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
+		bool msgbody_written = false;
 		int this_offset = 0;
 		int this_chunk = 0;
 
@@ -1156,9 +1157,12 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


