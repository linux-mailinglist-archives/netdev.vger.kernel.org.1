Return-Path: <netdev+bounces-238839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE3C6000E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 05:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9118235C1B0
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 04:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518922B9A4;
	Sat, 15 Nov 2025 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7zXSNM6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADD1B7F4
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763181337; cv=none; b=ncgZJ2j2IMh//AhUPQztGZ/DuWa7jgxg895uvtvn3A8nr+RHG2lURYBRFq3GCVbh2A+PkbJKWySYH0CBmGnJK5SndO4sl08tupdjPyrZ/RoHxPVjoeRijg7LrRpfi4OjYE3GwOYKHMf6Qfc8bd2uE8rQF2g7dtd+9QBM6LrPApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763181337; c=relaxed/simple;
	bh=hylTYYkVPhcARjzp061F7B87PyfZiJe6MSdABJ48VyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TQIGTCE/rQ25B0WrdNN25huUGjfYjcCCyt5RjVPWQdmNa5spNmTZGnUTyN6RnDenTJBid2GL2x3WiTCAbXCxHYRz3sGKdkxpzh0qFRu1j2HYzecSQIb6ukn7xh1wFxanmMx2drJEA7FrPd+ORz7ohrxbGA2hQ4PWiSgNxKd6Y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7zXSNM6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34188ba5990so7961442a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 20:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763181335; x=1763786135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrFSMX6rsnXXQ3BE+NZt7lQ85vIY1x/4wbBO9Bg9Lmw=;
        b=l7zXSNM6tr55JYobZnv27/Wwha5n4ZvzVkBcvH32NBDetQap8b7Zwesxj4pTSCFvRV
         ayKE9C3P/hBGxfxO9xveVZpdCcX8MR47DgJrAxfZLe3VaX1iTGGtBh62QS6C/1W0TZi8
         JVfKjlsrJVxzVq6yG9lmyDeoHsFMajLWOdkQ0QM3kkfiSxR9mN0t8nQAhLJAs0h/SEVi
         jlknj62G3z+LU63hV90R1F0GX22/MWUStTjWX7EL+aARcENbxAukHTW6TKZTkwi84LH+
         RD2vkVCB5ujp5PU9pmDIA/DhEUgCHB4c9Alzud01pNquY0SMTmMmUtwlyAYw05LgKxle
         YPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763181335; x=1763786135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrFSMX6rsnXXQ3BE+NZt7lQ85vIY1x/4wbBO9Bg9Lmw=;
        b=VOn35uUel15IZOApjxv/KonDHMtk9hpDv9GT6Rs9mST/3Fh9FPOeN+5wMDOY2hNJ13
         35VNuiE5zOP/dTAYo9FB+Gg5wyim1iXvRCFRwyxsmCoKsecHVLgaLJlpHtR8UDQdYB2L
         2/NSum1CEpvE2JfwErwlnIVd6eUraWVReBIFg2OYQuNlPJhmh7E6CjjIwcsRopqkokEL
         mVIkjORiongXPIqXt2WdVkjEU+q+htM9JQvic0J5VEQMvyfvWANAs+7k15vQaeTr+OWV
         axjFNWugIXiIPo3lba1jQmVW4Uvd8nS4JCC80OMC07zJmlqrCKZkH6CCwqT5h48QPuaL
         yJXA==
X-Gm-Message-State: AOJu0YxrNCUXBL52ohXQtbQNc+VICig7MJHqFtS/lIVWNTcCFLlhOHzS
	XTvPEOXiaYBhF3STm+ZoD8wrA7aAd0hGUwiHjejKGoM+1CJVpcUPRSsbEI3RJyaNjzZ6ZFAjhws
	mtXy8Pg==
X-Google-Smtp-Source: AGHT+IGN6jWS2HZfjJKOcF51O52+OlIz9jHkCNL1rsy/gafOHSNfQzLuQJaQZHgwbgdOS/xOlSQL7UjlOSU=
X-Received: from pjbmy6.prod.google.com ([2002:a17:90b:4c86:b0:340:bd70:e76])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d0e:b0:341:315:f4ec
 with SMTP id 98e67ed59e1d1-343f9d921c0mr6724212a91.7.1763181334697; Fri, 14
 Nov 2025 20:35:34 -0800 (PST)
Date: Sat, 15 Nov 2025 04:33:25 +0000
In-Reply-To: <3B969F90-F51F-4B9D-AB1A-994D9A54D460@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3B969F90-F51F-4B9D-AB1A-994D9A54D460@gmail.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115043533.2689857-1-kuniyu@google.com>
Subject: Re: [Question] Unexpected SO_PEEK_OFF behavior
From: Kuniyuki Iwashima <kuniyu@google.com>
To: shankerwangmiao@gmail.com
Cc: netdev@vger.kernel.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Miao Wang <shankerwangmiao@gmail.com>
Date: Sat, 15 Nov 2025 05:03:44 +0800
> Hi, all
> 
> I learned from the Kernel documents that SO_PEEK_OFF manages an offset for a
> socket. When using recv(MSG_PEEK), the returning data should start from the
> offset. As stated in the manual, suppose the incoming data for a socket is
> aaaabbbb, and the initial SO_PEEK_OFF is 0. Two calls of recv(fd, buf, 4, 
> MSG_PEEK) will return aaaa and bbbb respectively. However, I noticed that when 
> the incoming data is supplied in two batches, the second recv() will return in 
> total all the 8 bytes, instead of 4. As shown below:
> 
> Receiver                     Sender
> --------                     ------
>                              send(fd, "aaaabbbb", 8)
> recv(fd, buf, 4, MSG_PEEK)
> Get "aaaa" in buf
> recv(fd, buf, 100, MSG_PEEK)
> Get "bbbb" in buf
> ------------------------------------------------
> recv(fd, buf, 4, MSG_PEEK)
>                              send(fd, "aaaa", 4)
> Get "aaaa" in buf
> recv(fd, buf, 100, MSG_PEEK)
>                              send(fd, "bbbb", 4)
> Get "aaaabbbb" in buf
> 
> 
> I also notice that this only happens to the unix socket. I wonder if it is the
> expected behavior? If so, how can one tell that if the returned data from
> recv(MSG_PEEK) contains data before SO_PEEK_OFF?

Thanks for the report !

It is definitely the bug in the kernel.

If you remove sleep(2) in your program, you will not see
the weird behaviour.

The problem is that once we peek the last skb (aaaa) and
sleep (goto again; -> goto redo;), we need to reset @skip.

This should fix the problem:

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e518116f8171..9e93bebff4ba 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3000,6 +3000,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			}
 
 			mutex_lock(&u->iolock);
+
+			skip = max(sk_peek_offset(sk, flags), 0);
 			goto redo;
 unlock:
 			unix_state_unlock(sk);
---8<---

We could move the redo: label out of the loop but I need
to check the history a bit more (18eceb818dc3, etc).


> 
> The code used to carry out the test is modified from sk_so_peek_off.c from the
> Kernel test suite.
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <errno.h>
> #include <sys/types.h>
> #include <netinet/in.h>
> #include <arpa/inet.h>
> #include <sys/wait.h>
> 
> static void sk_peek_offset_set(int s, int offset)
> {
>         if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset)))
>                 perror("Failed to set SO_PEEK_OFF value");
> }
> 
> static int sk_peek_offset_get(int s)
> {
>         int offset = -0xbeef;
>         socklen_t len = sizeof(offset);
> 
>         if (getsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, &len))
>                 perror("Failed to get SO_PEEK_OFF value");
>         return offset;
> }
> 
> void test(int af, int type, int proto, int do_sleep){
>         int s[2] = {0, 0};
>         int r = 0;
>         int offset;
>         pid_t sender = -1;
>         char buf[100];
>         if (af == AF_UNIX){
>                 r = socketpair(af, type, proto, s);
>                 if (r < 0) {
>                         perror("Temporary socket creation failed");
>                         return;
>                 }
>         } else {
>                 r = socket(af, type, proto);
>                 if (r < 0) {
>                         perror("Temporary socket creation failed");
>                         return;
>                 }
>                 s[0] = r;
>                 r = socket(af, type, proto);
>                 if (r < 0) {
>                         perror("Temporary socket creation failed");
>                         close(s[0]);
>                         return;
>                 }
>                 s[1] = r;
>                 union {
>                         struct sockaddr sa;
>                         struct sockaddr_in a4;
>                         struct sockaddr_in6 a6;
>                 } addr;
>                 memset(&addr, 0, sizeof(addr));
>                 addr.sa.sa_family = af;
>                 r = bind(s[0], &addr.sa, sizeof(addr));
>                 if (r < 0) {
>                         perror("Socket bind failed");
>                         goto out;
>                 }
>                 r = getsockname(s[0], &addr.sa, &(socklen_t){sizeof(addr)});
>                 if (r < 0) {
>                         perror("getsockname() failed");
>                         goto out;
>                 }
>                 if (proto == IPPROTO_TCP) {
>                         r = listen(s[0], 1);
>                         if (r < 0) {
>                                 perror("Socket listen failed");
>                                 goto out;
>                         }
>                 }
>                 r = connect(s[1], &addr.sa, sizeof(addr));
>                 if (r < 0) {
>                         perror("Socket connect failed");
>                         goto out;
>                 }
>                 if (proto == IPPROTO_TCP) {
>                         r = accept(s[0], NULL, NULL);
>                         if (r < 0) {
>                                 perror("Socket accept failed");
>                                 goto out;
>                         }
>                         close(s[0]);
>                         s[0] = r;
>                 }
>         }
>         offset = sk_peek_offset_get(s[1]);
>         if (offset == -0xbeef) {
>                 printf("SO_PEEK_OFF not supported");
>                 goto out;
>         }
>         printf("Initial offset: %d\n", offset);
>         sk_peek_offset_set(s[1], 0);
>         offset = sk_peek_offset_get(s[1]);
>         printf("Offset after set to 0: %d\n", offset);
>         sender = fork();
>         if (sender == 0) {
>                 /* Transfer a message */
>                 if (do_sleep){
>                         if (send(s[0], (char *)("aaaa"), 4, 0) < 0) {
>                                 perror("Temporary probe socket send() failed");
>                                 abort();
>                         }
>                         sleep(2);
>                         if (send(s[0], (char *)("bbbb"), 4, 0) < 0) {
>                                 perror("Temporary probe socket send() failed");
>                                 abort();
>                         }
>                 } else {
>                         if (send(s[0], (char *)("aaaabbbb"), 8, 0) < 0) {
>                                 perror("Temporary probe socket send() failed");
>                                 abort();
>                         }
>                 }
>                 exit(0);
>         }
>         int len = recv(s[1], buf, 4, MSG_PEEK);
>         if (len < 0) {
>                 perror("recv() failed");
>                 goto out;
>         }
>         printf("Read %d bytes: %.*s\n", len, (int)len, buf);
>         offset = sk_peek_offset_get(s[1]);
>         printf("Offset after reading first 4 bytes: %d\n", offset);
>         len = recv(s[1], buf, 100, MSG_PEEK);
>         if (len < 0) {
>                 perror("recv() failed");
>                 goto out;
>         }
>         printf("Read %d bytes: %.*s\n", len, (int)len, buf);
>         offset = sk_peek_offset_get(s[1]);
>         printf("Offset after reading all bytes: %d\n", offset);
>         len = recv(s[1], buf, 100, 0);
>         if (len < 0) {
>                 perror("recv() failed");
>                 goto out;
>         }
>         printf("Flushed %d bytes: %.*s\n", len, (int)len, buf);
>         offset = sk_peek_offset_get(s[1]);
>         printf("Offset after flushing all bytes: %d\n", offset);
> out:
>         close(s[0]);
>         close(s[1]);
>         if(sender > 0) {
>                 int st;
>                 waitpid(sender, &st, 0);
>         }
> }
> 
> int main(void) {
>         printf("=== Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, No sleep ===\n");
>         test(AF_UNIX, SOCK_STREAM, 0, 0);
>         printf("=== Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, Sleep ===\n");
>         test(AF_UNIX, SOCK_STREAM, 0, 1);
>         printf("=== Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, IPPROTO_TCP, No sleep ===\n");
>         test(AF_INET, SOCK_STREAM, IPPROTO_TCP, 0);
>         printf("=== Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, IPPROTO_TCP, Sleep ===\n");
>         test(AF_INET, SOCK_STREAM, IPPROTO_TCP, 1);
>         printf("=== Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, IPPROTO_TCP, No sleep ===\n");
>         test(AF_INET6, SOCK_STREAM, IPPROTO_TCP, 0);
>         printf("=== Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, IPPROTO_TCP, Sleep ===\n");
>         test(AF_INET6, SOCK_STREAM, IPPROTO_TCP, 1);
>         return 0;
> }
> 
> My execution result on 6.12.48 kernel (Debian 6.12.48+deb13-amd64) is:
> 
> === Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, No sleep ===
> Initial offset: -1
> Offset after set to 0: 0
> Read 4 bytes: aaaa
> Offset after reading first 4 bytes: 4
> Read 4 bytes: bbbb
> Offset after reading all bytes: 8
> Flushed 8 bytes: aaaabbbb
> Offset after flushing all bytes: 0
> === Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, Sleep ===
> Initial offset: -1
> Offset after set to 0: 0
> Read 4 bytes: aaaa
> Offset after reading first 4 bytes: 4
> Read 8 bytes: aaaabbbb
> Offset after reading all bytes: 12
> Flushed 8 bytes: aaaabbbb
> Offset after flushing all bytes: 4
> === Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, IPPROTO_TCP, No sleep ===
> Initial offset: -1
> Offset after set to 0: 0
> Read 4 bytes: aaaa
> Offset after reading first 4 bytes: 4
> Read 4 bytes: bbbb
> Offset after reading all bytes: 8
> Flushed 8 bytes: aaaabbbb
> Offset after flushing all bytes: 0
> === Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, IPPROTO_TCP, Sleep ===
> Initial offset: -1
> Offset after set to 0: 0
> Read 4 bytes: aaaa
> Offset after reading first 4 bytes: 4
> Read 4 bytes: bbbb
> Offset after reading all bytes: 8
> Flushed 8 bytes: aaaabbbb
> Offset after flushing all bytes: 0
> === Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, IPPROTO_TCP, No sleep ===
> Initial offset: -1
> Offset after set to 0: 0
> Read 4 bytes: aaaa
> Offset after reading first 4 bytes: 4
> Read 4 bytes: bbbb
> Offset after reading all bytes: 8
> Flushed 8 bytes: aaaabbbb
> Offset after flushing all bytes: 0
> === Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, IPPROTO_TCP, Sleep ===
> Initial offset: -1
> Offset after set to 0: 0
> Read 4 bytes: aaaa
> Offset after reading first 4 bytes: 4
> Read 4 bytes: bbbb
> Offset after reading all bytes: 8
> Flushed 8 bytes: aaaabbbb
> Offset after flushing all bytes: 0
> 
> 
> Cheers,
> Miao Wang

