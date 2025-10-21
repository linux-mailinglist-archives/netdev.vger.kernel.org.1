Return-Path: <netdev+bounces-231406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB25BF8F90
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB89C561AE0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106C29BDB4;
	Tue, 21 Oct 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8y+nqG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11029A326
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083070; cv=none; b=AraW0dS1JKR98u97kzzyAt4U4FabwWT4wmliAsSDpBBOQ7aqA4ub7/fEuP3M8GK+Wrc7VdHc2ZDsgDX2iYSdJHHp3S/aNxnYLHzQd23DvzApLCCsz/4lzM84BFgPER59ZWgGsiCB5XRoYRr+E4WSYMvvDQtujyUvIDpEGYY480Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083070; c=relaxed/simple;
	bh=zwEQnRS63FsArBMQrWWg/87nk/3B7BWgQrw4k9fZbFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n6Wrw+mrT5Vu7zKeM2TQUn3Jb+pY6x5Iuwxo1rKoJmDbXvfz445Vl8tMM+9JeaqkZDswF82Uq1xTm5DFH0opJhpj7ay0/wPMiIMEs7QhgScVh3Ziee80s86KW7uoyU71JHhYVwGDGWtcpN55z5yYEouaXDEPNaWo98Ps/gyqxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8y+nqG9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so10078090a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083068; x=1761687868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7R4PquQC7iOdzeoa8eBBcR02cBjGYIkrkyYUw/rwe4=;
        b=u8y+nqG9ZbnD/i5vLNgVxj9LKg1r33VfBbOCUbbla4VB4GzvuhJHNYRgV4v0u0wkj2
         eDDTMEZX9xSFiOSwG+6E5jeAFzGqDsN1fxmhQQ5jYfp42H0YRVycJPQz+8cJXF7dxdpk
         +GiRbpktmIVAmTwmequnnl3cycFvTc2XZNIZ/cdb+JTSnW0pBCSg9ysl3/pmfxPFZ0ts
         yq/iIAvHBmgI5SPjLqSuacZ1cTISGE8mM51YFUY8CnRUoIrW+9duToYfqbtrG+r9ed7+
         QMD74Va+9ORGsIDv/QhTfGipmCdpNHKPOfcpJrh7W2qOe9tbXd7pWkZlMVCe4HZAbxpI
         YGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083068; x=1761687868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7R4PquQC7iOdzeoa8eBBcR02cBjGYIkrkyYUw/rwe4=;
        b=fqeeU22VhztjA/cK/Ja9EzcUG2U4KrdicuCA6+ADhviiHYz2xpbuEgPn5aHFqfjUhM
         BDtZNpAXwWO+CjfKikGQS3xr8lKO8qEoxYuMnDTa75UVeawF7xKgUoNNsO8fbsSced1J
         GRHB80C4aaHxGvt9JwVaWtMhR9S8UTIKcUn6neQBgxQQ809DGytcAMb7i+t7gFCaB6SL
         poajrKLfCyUYjxQXhVa6jjLHolVKxBk3fJV8WrndkMT1TGA7oPrReykEquo2jvPFQL0e
         4VfeTfNAyz0t1VGjz5iEgP8X3Ix4UiaeELG7TxkC7+acsj7TpXIZpL5Lx781jCcwhggK
         fVUA==
X-Forwarded-Encrypted: i=1; AJvYcCWu1RM7j2hkOFJJvU9wbgFBCDmRAAEohKPi6FFE0JbyB5jy9y9wKv5LUjc7zyrR+QaaFEmVK6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6G3JmuzFsAu01+VbmZc1qaifuLqDW2NuXfRYqYXF3n4+AbLPU
	35epYastAkLcyaTVe9gSPXsnxxAAXEK2cLFFc2DBILqYxNU6MzTA0lpvOinoYCbGpv9cofVXv7F
	qxekQFw==
X-Google-Smtp-Source: AGHT+IHRzrm9kPn7DRSEesn0PnJE+57wnLGP216oUrBk7UwaXgT0WJJ46l4Kn+gY6fwyv+OqmsYDQ/2SIIM=
X-Received: from pjbgp6.prod.google.com ([2002:a17:90a:df06:b0:33b:c226:ff96])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec4:b0:33b:cfab:2f2a
 with SMTP id 98e67ed59e1d1-33bcfab2f31mr30471810a91.33.1761083067794; Tue, 21
 Oct 2025 14:44:27 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:19 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/8] sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_sock_migrate() is called from 2 places.

1) sctp_accept() calls sp->pf->create_accept_sk() before
   sctp_sock_migrate(), and sp->pf->create_accept_sk() calls
   sctp_copy_sock().

2) sctp_do_peeloff() also calls sctp_copy_sock() before
   sctp_sock_migrate().

sctp_copy_sock() copies sk_sndbuf and sk_rcvbuf from the
parent socket.

Let's not copy the two fields in sctp_sock_migrate().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d190e75e46454..735b1222af955 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9523,12 +9523,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	struct sctp_bind_hashbucket *head;
 	int err;
 
-	/* Migrate socket buffer sizes and all the socket level options to the
-	 * new socket.
+	/* Migrate all the socket level options to the new socket.
+	 * Brute force copy old sctp opt.
 	 */
-	newsk->sk_sndbuf = oldsk->sk_sndbuf;
-	newsk->sk_rcvbuf = oldsk->sk_rcvbuf;
-	/* Brute force copy old sctp opt. */
 	sctp_copy_descendant(newsk, oldsk);
 
 	/* Restore the ep value that was overwritten with the above structure
-- 
2.51.0.915.g61a8936c21-goog


