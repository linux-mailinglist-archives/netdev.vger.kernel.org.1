Return-Path: <netdev+bounces-95035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96818C147B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DD6B215FB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CED79DC5;
	Thu,  9 May 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xydpmjmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979827441A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277996; cv=none; b=qpZ19SjmBBpT4vLI2uif7vSH9592eTMRUUSAqZFguoiOAnOB0dzpUDiJXptxkTcAJugAM54fodIojxfACmFCF+FRRObyriag3wT312r7/YJo60ROrj2pPHKztf1WDdoA+uMVaa1qW7VuSpiGRn9V8Ujh0RdOxI58glbU8Rac6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277996; c=relaxed/simple;
	bh=vPmIWHubhu7Zl0d01VwRt7I+baEGbnPcd0yn2/Lwkk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGn9Lo1ceNr+wlQKuefxuSw86QeSblReoNUqL8z8nugJKr+3zqLxa/rf5xw6D877ki1Y/6ws47LFE/SIQ7U8CwXmYN1pSM+mb/CN0nnsYG1rutCj1IBTtvh150cwjpzs6FuYNGOErBVnlUqOCfL2xWcVB5WQkMF0sD23cfRo2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xydpmjmj; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7dec804bd19so3915739f.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715277993; x=1715882793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woL79JgKr8Y9h00YCvcVbTNbbJLO4CTevYvzKXjXf/4=;
        b=xydpmjmjO7jcwlN1Bky83EuM+NLjFVRxHg17DTzeLpEvKevgMGi8pjaSMH55dAAFeV
         AT42FSV4vj3CrzA/j2x3Zqlz+Ye1bAU9YtmdbuN7nQdRKJJm1pvoSl2ls84hmDxn7jFL
         USer8jM/g+os1B1jIIsXvlC9zQ6paTd4euY+NroljpLR0Ii23usbC/kP66xMrQTTsBKB
         MoyxcgI5n1oNmlqZv+zxsjVAkk69WdPyBYe9CM+RqF0ZcLSp/phtniOP2bcq+ESv0kdi
         5f2qVlTqlWjSpQ4IYQBz1BQs2Iz/rGORG6WE/P61T30u1SIuJhjbWzLigspUiUxt08LM
         6xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277993; x=1715882793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woL79JgKr8Y9h00YCvcVbTNbbJLO4CTevYvzKXjXf/4=;
        b=xHmk4+cnM5acZGc/NDQwlEAOp7lURsBWm7SG3th3RssbXnOnSQMf5hBkbt88C7YMgk
         Rj3w15LD5J/xbHXX/DZbgGQR/xfjO//yTQykws5f8gCOTodSdWBIr8sgpKR8p81baN9O
         XWsE6ecZl2J5e7yqPzjMESefiZzlJaAjbVkUkY2UwVNN4SYgYIFCq/eLrRy//6dUVej7
         r+3IGCEBUB6VufnMDPfGL18ob3q+YPqQKz+VK13DoXt+efnravUQYMfHOM/W/xaxRVRO
         sHetqtMGNdmXAO0dW8AZhxMAGmJpBTKIUuze9XcvHULRWtyB62m9juxbl6e7Q2kRGHhH
         98ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX7axaz/k4+zSBPfBR/g2oeTM8XQTedAvWfpdPRnTQgfC/UggPiAYVb/UmZh22Un7NQjowcCfkd3ZUuumLL4eEalL5ZmJiS
X-Gm-Message-State: AOJu0Yzkk/rymXJmGYi8Ok3XEC+R3ebJdui5DeGvqZmnkRIBhP9/TM6J
	F5GHG3ZtcV1BBP3SMTQ/CANWK7P7H3uCQilsOPGSIxcyy0t8JsN+mKOElUkvK4/FwYaN50Xaqj+
	p
X-Google-Smtp-Source: AGHT+IHHk9CMFgrN7YmHE1Q93UOE+0GqmqHF82gJ3R5zu9Sf64SNoxrovkAd+Giu2qp+US10oNOy2A==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr62466739f.0.1715277993703;
        Thu, 09 May 2024 11:06:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1b23ab4f6sm19468739f.50.2024.05.09.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:06:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] net: pass back whether socket was empty post accept
Date: Thu,  9 May 2024 12:00:28 -0600
Message-ID: <20240509180627.204155-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509180627.204155-1-axboe@kernel.dk>
References: <20240509180627.204155-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds an 'is_empty' argument to struct proto_accept_arg, which can
be used to pass back information on whether or not the given socket has
more connections to accept post the one just accepted.

To utilize this information, the caller should initialize the 'is_empty'
field to, eg, -1 and then check for 0/1 after the accept. If the field
has been set, the caller knows whether there are more pending connections
or not. If the field remains -1 after the accept call, the protocol
doesn't support passing back this information.

This patch wires it up for ipv4/6 TCP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/net/sock.h              | 1 +
 net/ipv4/inet_connection_sock.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 217079b3e3e8..5f4d0629348f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1197,6 +1197,7 @@ static inline void sk_prot_clear_nulls(struct sock *sk, int size)
 struct proto_accept_arg {
 	int flags;
 	int err;
+	int is_empty;
 	bool kern;
 };
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7734d189c66b..d81f74ce0f02 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -692,6 +692,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 			goto out_err;
 	}
 	req = reqsk_queue_remove(queue, sk);
+	arg->is_empty = reqsk_queue_empty(queue);
 	newsk = req->sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP &&
-- 
2.43.0


