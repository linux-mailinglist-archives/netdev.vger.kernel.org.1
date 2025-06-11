Return-Path: <netdev+bounces-196705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE313AD600E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E685165B49
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED823644D;
	Wed, 11 Jun 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSEsMWNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1119226533
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749673685; cv=none; b=Oay7gg/jXZE9+vWlUeHn7x8DyJE6eKNUmVTPFdLSusxtPjiu3g6o8vUrxQ9Eo2GRSzusgd+HxeRUs7X4NZUfkr/z4EuRlJ5DijF32KaonxeN/jP2ygpcrL/jzXAfz2/eKWqEKCYwoj07B+i7S8DM9ijPv4UZtf/oan7FTV6mifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749673685; c=relaxed/simple;
	bh=vcsqVxisUPc2TNyIU7mVHCCESP4ZmB0UPj7WkvpPZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DfstKgeRBUki3MDjRCwEIMWelaVKXtqfUPGQo3cC8uQFvMlZ44pE3LDpcVF5/R1px31YgK2nTyHm9F8vPcuJl+2PB4Z+APTWPvMrIIxc1sFCPV7uQ5wEDwteQaiGZ3zgGCtC8Wx1FKigJ9UWIIBs+7jrZ+gdWKLbmqxY1cX/Lmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSEsMWNn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363616a1a6so2073145ad.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749673683; x=1750278483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPn/nOhiBHOc30YRYig5J+Si7Mht5Fbl958sc6/rV7E=;
        b=OSEsMWNnPgQviMWZyZUpNioyZkeEH3ZWqeonSAM8O1R/RjWkqtyO4tCMBMDWwhvYeC
         /Gld3IpBA4qjcBGl9NeeJw0DL5uHAyivn/ivdhh6dGb9F/uC830oFklnBa9tTi6LexOx
         T7jgXZxKDPytB+28Aii0l9hESTZi3/I8udadfhKfpWIIPFFE1EmQX4+PRaarvTtK3ark
         qRkD7jLVJky94HgviuEkbM8I3uz9E/5Mwa3gosFslqwvNXC2ub2W5XY7bxVR+OaTsd0u
         +XgGv7IwyblFHR/mJPtw/H3+cmVuxVWNl2q2XZr4ljfyNaMkp0jtwQP+3Y/V8ZgcBfNT
         cAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749673683; x=1750278483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPn/nOhiBHOc30YRYig5J+Si7Mht5Fbl958sc6/rV7E=;
        b=s8Mm+BfzM74hlIb4qeBzJgJQxTGwnZwQ6YDI954b8DTgu7FnCfefkjZ8KbLKwCxiOO
         k7qac6Ge5E6/FHYpSRwsOCshDUO6rj8D1o84EpN0G9dh162AZ693jQosm8ZLSTCQX6AA
         expjPhlPgQjgvAtL6tPl4S9/8IjNVxum0sXUpTvQrxlsfpYS1SPw5D59lkNkXpwGoTOU
         J+EDGmdMNkSD4jXy2A5o0U65jREYHDmIkZ9fOQUvCzBJ6gysCNf+p91giIDjlrlwCcqi
         oc74RgrEMyCq8Au7tnzfuZkbbEDnLMi+4y2CjFoMTxqFTaH8qagZJvhMDeBROTApehxj
         exww==
X-Forwarded-Encrypted: i=1; AJvYcCUQ83U9i7+eBzqJM7J4eBXwVlDtmbgQcHdbIrVVABkZ5gia1D1xB6iCJIEkgzhDm5WE0o0OBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OTLSkj5dK4x+rDPs8RSsx69CJvnoii+uE2XqllqFW/U01SRt
	tR3JRo8zX6obKYDDEH8sMI/so1Vj4Pw9+devj+FE/oW4l9vB5voTfKc=
X-Gm-Gg: ASbGncuOX61Zu+9SXgqDr3AS2Pr9rsQjHIGt6Kyw5/6naIrvQj8FLl4NKQIt0BLhjgd
	s8Xwp31kmNzd1lU2bJ1DhbbklAyMjBReWl+BMfa0j0dJLBfXR7PLJXjU0mmTEDjUZokjtu8636Z
	rf4yoJrsKrfx3U8+iVW1HylowSlZS7kzMkv8RRjJYFQAbMsqldJf1FDeeSb+oRAkN5iP4l2leUH
	XAufUe8BcgA4eX5X1wmW4ZXCxtxVWkhspeWgc6oAXdVIGf2nXxYDPBy/TuXmenE4js3FQxXW5l4
	NR3tkEl8PMmLbBmnrAB8dZ5Uj5CElj/Jw5YNVKY=
X-Google-Smtp-Source: AGHT+IGa1Ct+tVRFRFHHQpeLrf5yWNQn/r6n/mg6TmR/QM76HAMgDVxZzaJA3MQovmnHQPNchfV05w==
X-Received: by 2002:a17:903:2ec6:b0:234:aa98:7d41 with SMTP id d9443c01a7336-2364d8ecf7cmr6212165ad.42.1749673683010;
        Wed, 11 Jun 2025 13:28:03 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034056f8sm92345525ad.161.2025.06.11.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:28:02 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Jacek=20=C5=81uczak?= <difrost.kernel@gmail.com>
Subject: [PATCH v1 net] af_unix: Allow passing cred for embryo without SO_PASSCRED/SO_PASSPIDFD.
Date: Wed, 11 Jun 2025 13:27:35 -0700
Message-ID: <20250611202758.3075858-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Before the cited commit, the kernel unconditionally embedded SCM
credentials to skb for embryo sockets even when both the sender
and listener disabled SO_PASSCRED and SO_PASSPIDFD.

Now, the credentials are added to skb only when configured by the
sender or the listener.

However, as reported in the link below, it caused a regression for
some programs that assume credentials are included in every skb,
but sometimes not now.

The only problematic scenario would be that a socket starts listening
before setting the option.  Then, there will be 2 types of non-small
race window, where a client can send skb without credentials, which
the peer receives as an "invalid" message (and aborts the connection
it seems ?):

  Client                    Server
  ------                    ------
                            s1.listen()  <-- No SO_PASS{CRED,PIDFD}
  s2.connect()
  s2.send()  <-- w/o cred
                            s1.setsockopt(SO_PASS{CRED,PIDFD})
  s2.send()  <-- w/  cred

or

  Client                    Server
  ------                    ------
                            s1.listen()  <-- No SO_PASS{CRED,PIDFD}
  s2.connect()
  s2.send()  <-- w/o cred
                            s3, _ = s1.accept()  <-- Inherit cred options
  s2.send()  <-- w/o cred                            but not set yet

                            s3.setsockopt(SO_PASS{CRED,PIDFD})
  s2.send()  <-- w/  cred

It's unfortunate that buggy programs depend on the behaviour,
but let's restore the previous behaviour.

Fixes: 3f84d577b79d ("af_unix: Inherit sk_flags at connect().")
Reported-by: Jacek Łuczak <difrost.kernel@gmail.com>
Closes: https://lore.kernel.org/all/68d38b0b-1666-4974-85d4-15575789c8d4@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fd6b5e17f6c4..87439d7f965d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
+	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
+	    !other->sk_socket) {
 		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
-- 
2.49.0


