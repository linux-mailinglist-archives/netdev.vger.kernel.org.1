Return-Path: <netdev+bounces-245370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD8CCC5F1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FB1F3026F22
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1682BE031;
	Thu, 18 Dec 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BoULUcEc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DC2BEC4E
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070090; cv=none; b=hMhS+Not1B9S0YC3XlnITujThIvEQs6lrFjOftC5PdD4dN6CYSwo1rx/wY8bLPCw8JzP+oggzRmt2Gay6BjqeGRS5Iegco/MWBDwlYAqeHoEarY/Rf5e4tdDRy871OL4f8og+t2APcA5MFcCcuhC6aUhggflNq8C/7R9CLSRURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070090; c=relaxed/simple;
	bh=hiSbs61OIjTcRTzp9UQFIu9CG9N66NuLp5WpyamzTtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVulvfqOD442Lb1K50k2MzYHdpaWMe6kRqtddA3WfqqWQlVOU5bwzf7+ViLSe2lCoufFG0BDmHWIwzuzcTTQJ4JlSpFZXRjb/fE6MrhksIHbpt4F97yvgUCEOrxa35AJRK2TGCK5smBCtSGlUB2Ns3N1gEOPhOqU/Yz1+5ynCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BoULUcEc; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-455bef556a8so460900b6e.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766070086; x=1766674886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/jNunAP/XexBrNihPEinGvq4upYrJbCX1IEM6GCAi8=;
        b=BoULUcEcY1hlHfjNWj9E+jZx4G6OWpdlh+u0ibYsRc/y6SqR8nVfY4KzcNHyAra0vz
         6x6z/exP8t632xqNr6tHU535vqOTVvy9ghHyNbH0qGHquS00/2NvSaF0a7vR0y7LbYbB
         eqBCQvIsOIernzfSPplr0QsoGY6tnMn13SG6rCksASYbRbiMUzp4XXLKnRGiiykpGewg
         1XPlH+w8W6hbAjvbNN/r6/35Xq1AFwYnBigPLZGuaDs6QEdPJVEBKsse11eWd2COt5+A
         DxFk6yuedV7IlQiECQ6v9jBpclV/aPnOJGm4nFVC0muH5I56wH4O3TY93phVFWt44F9Z
         nb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070086; x=1766674886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/jNunAP/XexBrNihPEinGvq4upYrJbCX1IEM6GCAi8=;
        b=HmmDU4qJVTSVdPzTR0S2yWfTOxXynigSE3Xf+H3IuX3MuJTerYxd4lO/Nw1pxiJ2Ud
         ERlKcOBiGop2wDvpZG+Sj/K/55oQM9KnzVlwt3bOut7khz7Eb2ysi4pin8h/amsyN1Hx
         GCiskLa8WuhewvjMpuOVPNJaJlCw0ohz45oudRNjzq2fb/ItqCGNAe2kMVqMl50gcuuN
         6UKUZatDNrO9U7mdZykq1C8zt9pOzKQg6ga8p908Jb1y56OdtPNP+zK7HvNF7tkQWq9i
         YViNGIK4vjuiE4moAvAEOiYLUxGG7aPYd7eyXsGgz/YVmvTMuo2Nv6AuItHoB5XkqGjh
         Qi4Q==
X-Gm-Message-State: AOJu0YwUK9fzhzdLNKT2acI/L6S/i9GtsNl42if/uw8o321q76FZu3m1
	cOAPUAVBV0+VJVMoYda81W00Y3yipPaj+lJBKiXESoYwbzkV7W8fPx+GcbV8rkI2/4CHndeow1T
	cvUa5p1P52g==
X-Gm-Gg: AY/fxX7+i5E6JJxW/ntg4vP7ihlOkCM0YS0sTuAQCdRpLG69MIu94WGrLv2hRP/Gd8a
	+a1tXT0nTt66RSrgpcs94bxaQPLfGGQrg443nuaJlRsUpbaPl9YRu8aRwR086RsczQ7+0SL7BQW
	PgWitmbSovcm3HFQXt3ri6wBVHaxFSA9YlIIC6yR8tSA0ZIqiPuyCOA5lfOX8WLNCYGCXgMx2I8
	wtaRtbGOnlefMw9mMNvTy60+w9SpruevybCmBbiRRIn4Ze3sFa1kSh8r04Mg5v9ZOSxnlEPp60P
	wEjv3yv5Kj1NdBsiF3alcDcAp6KkuLCdy/v065SYZ3Wmkz7A7t0PIQldvpT2BFHs6P3ul+YcqY3
	z4ajCLPE5uRik7XPsuhfSgW3R6SifQ6kInp65kTiMNKZEsUX0qygyN/KbU57BMp24vrzVPQ==
X-Google-Smtp-Source: AGHT+IHcYe7sSib0lg91kOUIhVupSIaIoKNxM+L1A4aHwxSYJL3cMcboQJuv15Y2yYh1pKS9l6Hcgw==
X-Received: by 2002:a05:6808:a5cf:10b0:450:b64e:9c14 with SMTP id 5614622812f47-455ac7efc63mr8110183b6e.5.1766070086090;
        Thu, 18 Dec 2025 07:01:26 -0800 (PST)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a42fe963sm1327816b6e.1.2025.12.18.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:01:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>
Subject: [PATCH 1/2] af_unix: don't post cmsg for SO_INQ unless explicitly asked for
Date: Thu, 18 Dec 2025 07:59:13 -0700
Message-ID: <20251218150114.250048-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218150114.250048-1-axboe@kernel.dk>
References: <20251218150114.250048-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but
it posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
incorrect, as ->msg_get_inq is just the caller asking for the remainder
to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
original commit states that this is done to make sockets
io_uring-friendly", but it's actually incorrect as io_uring doesn't
use cmsg headers internally at all, and it's actively wrong as this
means that cmsg's are always posted if someone does recvmsg via
io_uring.

Fix that up by only posting cmsg if u->recvmsg_inq is set.

Cc: stable@vger.kernel.org
Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
Reported-by: Julian Orth <ju.orth@gmail.com>
Link: https://github.com/axboe/liburing/issues/1509
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 net/unix/af_unix.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..110d716087b5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3086,12 +3086,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (msg) {
+		bool do_cmsg;
+
 		scm_recv_unix(sock, msg, &scm, flags);
 
-		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
+		do_cmsg = READ_ONCE(u->recvmsg_inq);
+		if (do_cmsg || msg->msg_get_inq) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
-			put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-				 sizeof(msg->msg_inq), &msg->msg_inq);
+			if (do_cmsg)
+				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
+					 sizeof(msg->msg_inq), &msg->msg_inq);
 		}
 	} else {
 		scm_destroy(&scm);
-- 
2.51.0


