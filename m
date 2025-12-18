Return-Path: <netdev+bounces-245371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94834CCC608
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAA8308B5A4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934612C21F9;
	Thu, 18 Dec 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g3SnUHkD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1802D0C7B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070092; cv=none; b=VSeRZBDJMy69xEj+bnTB1HKBKZIuMbW38vHTBieJV1NdkuAESt85f9qvkUV3HyWxZmEadj94w9A35HPmd6zomDnKCiu/ZnyzUL8b4COe7NEXTa1aGxIk5H2MNIPFEE0H5x/yLpzoAMNFhK1BsJ6GhMtyAAaky39Hl6EJ1vyFBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070092; c=relaxed/simple;
	bh=xuxYpHZyXgdRB12usLdOT6BuulW7JinEFCOoVCvBrAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grADvQKt1BxIqecJWjTmbJjqNpoh5PArCdDWsNrvQlp2AzIC/rgfwaR6GCLxHNsAi+n8VuFDVWaijVcXNptQQU835JqNDZDu7nvGIDS6x+4665c/iqd5SCJi3EBLHXRoP6RSVKraLu/mAW5iIuWzicvBsz0be2/gIJbGYWy23do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g3SnUHkD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-450823a7776so463416b6e.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 07:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766070089; x=1766674889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkCfuBffdvy1ahpgO4ryU5C0fH+X3z2hQTwZhDTxw+o=;
        b=g3SnUHkDciTxN12qlWxzvZUkmedWYbBO69JzHDDwudvobB1qIx72cgggsuycg8yu98
         PabIvLqOgca+y+McDIMCelU4Uh3cr3gH0tOsxFhy01WUQrK8OelEnAjfLNaI27ee6myc
         fyDZz5ASJpBkAfT7tdDlDW2IzVNFk1X11UaV332+G8kRsQwtKkuaxn57ZC+W/WP5ek9+
         s6nbbxMjVBnqV0VBwNm2ab1bDxwaHh/lvSOzhTIfVafRZTq6uFANDuGq/bGx+7MiiXiQ
         w3sd/XQ89aihs1AdBKDbbhwT1SQ3EMKCvx53s9W6wfZ4p3DGzO6vEh87cUO1XEEcc8oq
         qVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070089; x=1766674889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fkCfuBffdvy1ahpgO4ryU5C0fH+X3z2hQTwZhDTxw+o=;
        b=Y5D8WG7EqnKBv51wpfi5vEsFgB0ZvL+0nrHWCoTOG4CHetnygHP19aKWBAQ9ntUZpg
         ThLPM5EH01zQ9fRh/76VpjN5zh37eiquCkkeNqKXzDjhsOn3XZVEQJwJlyWm47j26ejC
         CK4VUQcFU4BPsp2wTRMo7D2qohv/eiNAEvZuYPYFWWfVoL0+eIztQAM62UviCpi0bWfN
         d6gSNSoPdWyEPvWoXqaahwAYY+xHwrYisV9kS5kRbJJCfQWGXHeTA/VL/dx6hRLEq1Nf
         HaScuDrfQjIP2CemFvIM9cBXT18lFusYTq3IQ+NpvDpGSeOFhwnugIOdn6aLH6izO/WY
         Parg==
X-Gm-Message-State: AOJu0YzkiSD1p80UkFQ6FlzKpTdiOw7mQLDvig0Z0X/5VMDnwolU/Sbq
	UvfSQ2wZc5AaI0qUgd4laE136JPiyrrBheFF9p/7fnFk/YP3imtY2wGtqXRDINRIzkkFeuG4m4f
	caga4Cmk=
X-Gm-Gg: AY/fxX46XLaGEBpCi/v+t88fBYXCd8MvAxcQmdRfqOQtJ2u+6sOioUPlJ9eenqx5z7M
	s8TsVRgASAVQ61+++flAPIpljPqAfOzxeU5+o9zgkuif0VF1IDMiDCPAJca9obfYymROtKO9IpO
	9IvYQ6UtzvOmyCOfHRBxkXYbf0C7de/ItxNaWyIZGGaNN0iDGDz620HBUsPyKNIekXRP2R60eQY
	yMXrZi21M4kWUBpWCqevXlxD5d9O4hUyybprZ313WYPmEa8eKEKKfcT6FCEEW/QsCLRVTrX8lbL
	cweQxny2DTmxFcESemWI/DMkqCcGFFC7C7P1xil+Y4tO6ofV6qIupILaLMuD9/SCGc1hujEQgTl
	n4QIH/HNwPbcJO6msVJWCk2jw71BcbVSGacIFvSt+KP+4JoF/LGs4Yw0WIN5GYZpR1BGApw==
X-Google-Smtp-Source: AGHT+IHNqQEyO2+zm0WZX6kMf8tMyinPk4DY7+372q7upiugrQB8KXle70xpWHUfWtjzKhWHklipKw==
X-Received: by 2002:a05:6808:c291:b0:453:746a:c61c with SMTP id 5614622812f47-455aca2f25amr9904875b6e.66.1766070088843;
        Thu, 18 Dec 2025 07:01:28 -0800 (PST)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a42fe963sm1327816b6e.1.2025.12.18.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:01:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>
Subject: [PATCH 2/2] af_unix: only post SO_INQ cmsg for non-error case
Date: Thu, 18 Dec 2025 07:59:14 -0700
Message-ID: <20251218150114.250048-3-axboe@kernel.dk>
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

As is done for TCP sockets, don't post an SCM_INQ cmsg for an error
case. Only post them for the non-error case, which is when
unix_stream_read_generic will return >= 0.

Cc: stable@vger.kernel.org
Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
Reported-by: Julian Orth <ju.orth@gmail.com>
Link: https://github.com/axboe/liburing/issues/1509
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 110d716087b5..72dc5d5bcac8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3091,7 +3091,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		scm_recv_unix(sock, msg, &scm, flags);
 
 		do_cmsg = READ_ONCE(u->recvmsg_inq);
-		if (do_cmsg || msg->msg_get_inq) {
+		if ((do_cmsg || msg->msg_get_inq) && (copied ?: err) >= 0) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
 			if (do_cmsg)
 				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-- 
2.51.0


