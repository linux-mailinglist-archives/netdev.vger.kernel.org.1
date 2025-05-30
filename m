Return-Path: <netdev+bounces-194295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A3CAC863C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 04:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0974F1BC258B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B61519BA;
	Fri, 30 May 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXcs2ox/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE71D554
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748571794; cv=none; b=arjSdm5JTAtDeqtYU0xLDrKQ6vTKIBnPU34UyfWQPIpP/z+CA5iynScSVzqNRi0IAtbHrS4Ga43GbOeLNH7vIXtC1CQyMpj+6BMM123iq55+V60MI36BS5ESBwsBseLXQWe9KBF7UZSrISdcKxCPHqvmXlx8ZurSd8Jj9NLintE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748571794; c=relaxed/simple;
	bh=lMt7jaCJ/51s2Sr4vLNC+dqD/u0JUZSzzWHmINW4s/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZG4Kih2pvMO9TQ9uE8YAz9lN9e1720D8qb7C7YK6QTc/vw/FFNAK/K6OAhfPHmifbRgmYwbTYuBOVy36gGjQouXOHA/fsGQWDBBOcU1GBNTL54OPEkjSvbdvNxIWYX2yyqlM8+fUBMGJDwMWvxvqie155SjSc5yRlACY8G4zvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXcs2ox/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso1593571b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 19:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748571792; x=1749176592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAl7qIBoj+j5A+aHWFBY+3TAAA6XYFo/PG1KLmBiuk8=;
        b=NXcs2ox/b+/CzbClmFOm6subMVJJPmxPs9w0+Kcgo6KoH8Yt1HDcPMQmae+CGfNHf9
         qLyTn4qTzLm9653JUEM9dHpGjV1RsRNHji8C2o2AwBPwqr4rmXDzAIv1ttGP3DGFBXr6
         Qk4HTZ6XJ7riJdPVYmijEJJ4K3RcxXKUp3rm/5/ge8Jsa7dTs4xJ0bLr4+bKit3+aM0A
         xvGfYgBCH1IK9L4uvNs3NHofROINJ4cv86zaZiAYgyUSHxALuYFGF8eWXoPU9pzczM+6
         V/ctGAuB3KTIAcgtYENd+oXVR9v8EFDDNYxmhZohKTP9OXiAG4rwjvurtlS0cD+Lmq+f
         KPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748571792; x=1749176592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAl7qIBoj+j5A+aHWFBY+3TAAA6XYFo/PG1KLmBiuk8=;
        b=klqGME1btADe/nQUfbjKhM9Eg7bdYN9nABszOaXUXEIPcdTCu3aSSuOG0rvP9Y36Tl
         p3p6m+moWUXp7zTbmsaqI5t5g00b2Q6RylULuoIKajsw2SYUKipzp54UamEvklhCOR1m
         a1efkUNX37DdvVEDsT1FRXPWoTuo4Osx9QAyMpPB1RtG/aLCrhoYx5ZNCTTUZ8zO7Ow9
         4b3TxgdcwkiBr71Mjec1TE3cYKxt5EE62zdLoQENhVErSCqPO+TQq7rST+FB4UCkOOUN
         1yF6BRTAz8WFS92Qd2/YFcbasA6hSrkAkjgcZDmuJfWgcheYAkcSXhw+76pU2rRxnfkY
         EaDg==
X-Forwarded-Encrypted: i=1; AJvYcCUBX7s96lIG4HdX4XpxWBKUP2mCFgjRoEaSDwBpc9jhybJWfEqFf4WR23SgKzDpfLmt6lde/2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7o0fjHKfyV/LTWBZytnROaSD6JIegLFFLI9AXsUuHx/jpKh9
	BX5SbMs5Dr0mwSR97CPoYJmnROO2rV0e5nEFmiJketZmDkBdsYZxfbg=
X-Gm-Gg: ASbGncsH5iOiH2xWWL+xzN6tcB9ZasFp5PrpefuoE6Q3xE5zKt2cnz5IFa/oJec3E8B
	ffZzqbMZg4YaCgpssVbtp+VWBHX6/r6bvgIR0Y/OvH8oHu8XQllg+7QNAbIEK0wRCN2/f5Xnb72
	N3K7kj/WFE0ODLeOHaOLnJXXw3/tiU/hSLMcX65ei0HspoOCy3tAS6AVHkMir4h2w3ALyB13+Pw
	GZuZwdWmY048oHCMGxxAbjCw9EN/SiNmpla/HnkfThWCG+dA8WfjdbtC4wSn2/X5bgHdLCXdPpv
	f5wN26j1nkKTvEP4xfM8hs1aNi/b
X-Google-Smtp-Source: AGHT+IHCVse2YuDKpaB2AjhrKmna+kLiSxGax0FrVLALuv/ep+ONe6GiKeH71N6FT9fge/XYtEP69A==
X-Received: by 2002:a05:6a21:68f:b0:206:a9bd:a186 with SMTP id adf61e73a8af0-21ad94f8c68mr2572218637.3.1748571792265;
        Thu, 29 May 2025 19:23:12 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb9d1cbsm516126a12.56.2025.05.29.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:23:04 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: brauner@kernel.org
Cc: daniel@iogearbox.net,
	david@readahead.eu,
	edumazet@google.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	lennart@poettering.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuni1840@gmail.com
Subject: Re: af-unix: ECONNRESET with fully consumed out-of-band data
Date: Thu, 29 May 2025 19:21:29 -0700
Message-ID: <20250530022303.3189981-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529-sinkt-abfeuern-e7b08200c6b0@brauner>
References: <20250529-sinkt-abfeuern-e7b08200c6b0@brauner>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 May 2025 12:37:54 +0200
> Hey,
> 
> I've played with out-of-band data on unix sockets and I'm observing strange
> behavior. Below is a minimal reproducer.
> 
> This is sending exactly one byte of out-of-band data from the client to the
> server. The client shuts down the write side aftewards and issues a blocking
> read waiting for the server to sever the connection.
> 
> The server consumes the single byte of out-of-band data sent by the client and
> closes the connection.
> 
> The client should see a zero read as all data has been consumed but instead it
> sees ECONNRESET indicating an unclean shutdown.
> 
> But it's even stranger. If the server issues a regular data read() after
> consuming the single out-of-band byte it will get a zero read indicating EOF as
> the child shutdown the write side. The fun part is that this zero read in the
> parent also makes the child itself see a zero read/EOF after the client severs
> the connection indicating a clean shutdown. Which makes no sense to me
> whatsoever.
> 
> In contrast, when sending exactly one byte of regular data the client sees a
> zero read aka EOF correctly indicating a clean shutdown.
> 
> It seems a bug to me that a single byte of out-of-band data leads to an unclean
> shutdown even though it has been correctly consumed and there's no more data
> left in the socket.

Thanks for the report!

This is definitely a bug.  Even after reading the OOB data, skb holding
the 1 byte must stay in the recv queue to mark the OOB boundary.

So, we need to consider that when close()ing a socket like:

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bd507f74e35e..13d5d53c0e53 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -654,6 +654,11 @@ static void unix_sock_destructor(struct sock *sk)
 #endif
 }
 
+static unsigned int unix_skb_len(const struct sk_buff *skb)
+{
+	return skb->len - UNIXCB(skb).consumed;
+}
+
 static void unix_release_sock(struct sock *sk, int embrion)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -681,6 +686,11 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	unix_state_unlock(sk);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (skb && !unix_skb_len(skb)) {
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		consume_skb(skb);
+	}
 	u->oob_skb = NULL;
 #endif
 
@@ -2569,11 +2579,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 	return timeo;
 }
 
-static unsigned int unix_skb_len(const struct sk_buff *skb)
-{
-	return skb->len - UNIXCB(skb).consumed;
-}
-
 struct unix_stream_read_state {
 	int (*recv_actor)(struct sk_buff *, int, int,
 			  struct unix_stream_read_state *);
---8<---

I'll post an official patch later.


> 
> Maybe that's expected and there's a reasonable explanation but that's very
> unexpected behavior.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <errno.h>
> #include <sys/wait.h>
> 
> int main(void) {
> 	int sv[2];
> 	pid_t pid;
> 	char buf[16];
> 	ssize_t n;
> 
> 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
> 		_exit(EXIT_FAILURE);
> 
> 	pid = fork();
> 	if (pid < 0)
> 		_exit(EXIT_FAILURE);
> 
> 	if (pid == 0) {
> 		close(sv[0]);
> 
> 		/* Send OOB data to the server. */
> 		printf("child: %zd\n", send(sv[1], "1", 1, MSG_OOB));
> 
> 		/* We're done sending data so shutdown the write side. */
> 		shutdown(sv[1], SHUT_WR);
> 
> 		/* We expect to see EOF here, but we see ECONNRESET instead. */
> 		if (read(sv[1], buf, 1) != 0) {
> 			fprintf(stderr, "%d => %m - Child read did not return EOF\n", errno);
> 			_exit(EXIT_FAILURE);
> 		}
> 
> 		_exit(EXIT_SUCCESS);
> 	}
> 
> 	/* The parent acts as a client here. */
> 	close(sv[1]);
> 
> 	/* Hack: MSG_OOB doesn't block, so we need to make sure the OOB data has arrived. */
> 	sleep(2);
> 	
> 	/* Read the OOB data. */
> 	printf("%zd\n", recv(sv[0], buf, sizeof(buf), MSG_OOB));
> 
> 	/* If you uncomment the following code you can make the child see a zero read/EOF: */
> 	// printf("%zd\n", read(sv[0], buf, sizeof(buf)));
> 
> 	/*
> 	 * Close the connection. The child should see EOF but sees ECONNRESET instead...
> 	 * Try removing MSG_OOB and see how the child sees EOF instead.
> 	 */
> 	close(sv[0]);
> 
> 	waitpid(pid, NULL, 0);
> 	_exit(EXIT_SUCCESS);
> }
> 

