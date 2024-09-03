Return-Path: <netdev+bounces-124567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00174969FE8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBE8283B6A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0080613D89D;
	Tue,  3 Sep 2024 14:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774C13AA5D;
	Tue,  3 Sep 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372497; cv=none; b=e+AGNbvG4uDeEGUYfZBLyDkM9bcJwj2aQrEFkuVeB3ZNIzD4+fCUAW7/sfJlPpL7TBuWhxHGcygOP38AJC93gwS/5sRGlwDxgYs15WDVE5lMYGjT9rsp/eLaFQx/C3jMwiCtaYG7gpaUpXvb9520hbP6TzsRnRVCeJAgkNNn7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372497; c=relaxed/simple;
	bh=RT+ZtNbVz+k4YKtOmnAxrSyApMOA6CWuXom1rHUUaoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2gu02lfcgWaB9ye5yzzVqFyP8kCczB7s+d9zPMpwuhWcawReFTL5N7XKui8MsrvfU80h70nKZ42EHzYNY16pMUSP1x6mFogNk32jnRaExXFs/cmKMdMJ9Nqt7vsWSErztPSOVMpwOyjyj0uu86X9TILJjXoFx0vl8amXZEJWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5343eeb4973so8331984e87.2;
        Tue, 03 Sep 2024 07:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372494; x=1725977294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a3bvnFGteZy01tz5eBRywVwtJeJzGi3ecq0wcAC/lc=;
        b=SQzA7wgLRgvmpyJp/+q1TermaQ5QwwIdaexJhncYQfDz1a9jIppR/napyNuoCRX81i
         DLltrRWnkKIp39816TpQ4OyyhRr1KVUKMCYz/Sg/NeNluE/xydBMSblJJoTXkSPtogAx
         K47cf9Sr1FCNL9HKi4KlHz4DPdBR2+zhE8KUFFWymBDUdis/WPuc3tXsMQJiLO4I35Np
         rBHMxNSUkDUmCuypcwPaBLlvBxU6BZ1DPfsONNdtmXepKhgpZM84HukranVk97HzeQWA
         ugW6duDagtptYKIuK2PYT7kvrWVoEyrcqXaOl+sZQ310I3ShvwST9M72B8rMxP+8cy/q
         UZJw==
X-Forwarded-Encrypted: i=1; AJvYcCVEbuKPIbu8RP9xKWEim97kSZABzQCtJoO9+9Fj2nqpzUQAfzF3Uf1tCERkL3Va6Dv8KttXZHtQxMoKc7k=@vger.kernel.org, AJvYcCWyufy4LfKrZ8fSK2mfQJGHAdVt7Y095rMCClweZXG7xW4tQiH40JgKiKzKRzUcHjjAzIwquXeG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0DoeBz1Mtk9gw8AJcr8wf/VmQIiN1Ih1caU/lBArrySTWEOU
	VeVdFDd8dgAQ7ZPdkfU7WSW/YKFkzMF5+QMVjSpwXQdKSS4laTpt
X-Google-Smtp-Source: AGHT+IGDXmunrNnDp6tRowAWA27oZs93mImUdcRx6iZveB30iM8VRckYTkknizgNfIvYEwCr3bdj5A==
X-Received: by 2002:a05:6512:3b14:b0:52e:9cc7:4462 with SMTP id 2adb3069b0e04-53546b1dea6mr13086642e87.11.1725372493755;
        Tue, 03 Sep 2024 07:08:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb61fsm700575566b.10.2024.09.03.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:13 -0700 (PDT)
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
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 5/9] net: netconsole: introduce variable to track body length
Date: Tue,  3 Sep 2024 07:07:48 -0700
Message-ID: <20240903140757.2802765-6-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
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
---
 drivers/net/netconsole.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0d924fba5814..22ccd9aa016a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1064,10 +1064,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1096,10 +1096,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1107,7 +1108,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
 					 ",ncfrag=%d/%d;", offset,
-					 msgbody_len + userdata_len);
+					 body_len);
 
 		/* Not all msgbody data has been written yet */
 		if (offset < msgbody_len) {
@@ -1122,7 +1123,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		 * append userdata in this chunk
 		 */
 		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < userdata_len + msgbody_len) {
+		    offset + this_offset < body_len) {
 			int sent_userdata = (offset + this_offset) - msgbody_len;
 			int preceding_bytes = this_chunk + this_header;
 
-- 
2.43.5


