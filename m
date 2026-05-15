Return-Path: <netdev+bounces-288427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBEJMjJsB2rY2gIAu9opvQ
	(envelope-from <netdev+bounces-288427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F8556873
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B71D30530D9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AD35E1A9;
	Fri, 15 May 2026 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+P9dBJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6123E2AC9
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871270; cv=none; b=g1g6B1McYg+gPGUAcP0fKnF74ohwkCw89WDVVHkEfxFBf2cotonVYFZ4In0Pg83UEFThrAy7YlwXKLeUL668xEsJBhu8fWuDzrltHREb8lahkWel13nqrohC9jczgETzIdlBJnSH34ChEv/K/N9t1eIwyE7Z/Zq/Gtzk62xijC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871270; c=relaxed/simple;
	bh=DB0n+V52Tzs8cERe6V5xZXHKeaQoXCM9NaKvtCnxM7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C444VwRELk/et5H8Sh9ul7efmd59PQFFoPn7zO4Cg+1MSUJgFNMFxBwlGmLSOAIMCfVGgUZOLmanjH0l6suUMg2W1VJBD2sAfHwUV8napH9Ifh+jrXUT2psDlRvGxxY8G0zRpgNZZ+zritiY9oG5Az2ObuS2xacNjyB+kPHd0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+P9dBJJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so2775e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778871268; x=1779476068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPjE7lCG+YuPbG9M1JzuS9pJL4rG/0cntCt8pBzDzv0=;
        b=Z+P9dBJJtrKuXC+WZZ0VT/WvnIguzk/fLgVX47FyGxSq7p41rHwkX/ebcy4gbYWnsv
         hkYT3lCYoX+HObL8gmZwQYgFEEhsFct5GTPp9Wxvq0pBfdI8bdGgJ/r2TKtoyw8YYEEz
         rSiI8E8gVUrGSeZ7mEfFsi1ikqPyxYNacHu3NG1NAlICxIw4qYfklPJn0g1t7EqWPwWa
         zMKJwagTRm5i1DA10JkEXjxpwz0xBPv6XXXp41F8besuIkSjQMguPGe8HoZD0N5n7RYr
         z4BieY1dEbbecY/7oxTHNBYJ+z3kOTVtOq73hC/gFBnOl48HAyaFSxqq5QK3NHcRDweO
         WWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871268; x=1779476068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cPjE7lCG+YuPbG9M1JzuS9pJL4rG/0cntCt8pBzDzv0=;
        b=lLco9sN53vJ0oP1FfDCvJvnkKvrEgl/ZIQifr4P6VOZeZVqcsDJTZJ5rEM/DN/yZor
         bpgaxZxrAutM8AWxjJQQUA0HaY/H409miPl9d/N1Gq9xbzahHogYBhp7bPCej0000S7a
         nK9hGCbMkeudoQ4McGggiuNXD8jjK2tNdJl4mejUP4cuVvbFl6zk4eRDqEK0gT+bL+fH
         9x74klCcRFM0GNhsKnYeGSYzVf0D4nJlkoLSKEpfCKJbNJVsQr4qVJ+CYgNwlDV+HalB
         INmsJ+459HZZYhu5k/UJ2hQrhk1F/S4NEBxouV1q3jKbxZs+G1tM1BL5LnwzdJ8qCEuU
         lnhA==
X-Forwarded-Encrypted: i=1; AFNElJ/HLNQrcIfenUOpA9K6oCJGIB9C8/5yJB5np73m1/QRligbrgBu3iWmJ6k7GXs40yj5aPphwaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6iFiJ+RDnX9f9EuBhQktzV14VVGf8TgK6UQlepxdwRr61JON
	zJIpKfWfClCIo8+IdAJXCmnRxOSapXT4btUTh+IbEn2qlozgjFTDRai7pskmO/wJFQ==
X-Gm-Gg: Acq92OEckbQJ1/JF/kzxamPC1cBtyKA0hchItOfnmeVhpZgkKGWF+cFb2QntmTZJJlH
	15Pa3sclXSXAWrdYnQQivKoytBxq8/to/8koezY0EZTxVD6esQshCMDeYCKnJ4wBdOX7Sbr3B/c
	Azik91p9gQyPHqIC7jdIOtAN7IFFB+mYdXAIMHnd/4eJq6Q9Zu2mQSVpdG3aOuGLCc0ap3dcgsv
	X5chH8MTk06UAjdjsKDK4/1hobfkwliEER8vEtneKVDKFbAIk6N9G6ev3j7A3K5A8UN5a40zWMP
	u0XKpU8GGwQs7GdlsxPjocDHciFSQK+2kzC38V4YqAZTRhvg7YWNA1k/NHRGjY233TNAcnWleJU
	fqsLPrtqOSRHHeLHiVBOJ86+kso+fIjU4/vW8Jok6Xf2c4teq716HQQRw7rJMR1nd6KOufDtq4g
	pVGw1eBc08oiRQJZu+3yd0zBwvOMESpA8rDYVXLNbEdTz2b6QkPWsA2Vmc7WMmoQ==
X-Received: by 2002:a05:600c:138a:b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-48ff41c2661mr164525e9.0.1778871267322;
        Fri, 15 May 2026 11:54:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:7481:4dac:8e80:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm24658885e9.9.2026.05.15.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:54:26 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 15 May 2026 20:54:10 +0200
Subject: [PATCH 3/3] af_unix: prevent spurious reader wakeups by writer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-unix-recv-wait-v1-3-76adb5f063d5@google.com>
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
In-Reply-To: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778871255; l=1598;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=DB0n+V52Tzs8cERe6V5xZXHKeaQoXCM9NaKvtCnxM7M=;
 b=h9yWkuv++lnVf+DshyCBAH42pN5rw+SC/SRama1UcOBNv1YYgQEbZsgSV6YnzcnjwKb3Bz+g5
 W+jyAq2FhLJA2jwhLG2iPh8SGK3nRNWwM4DtTg9FVTirTkeIOSMGYN9
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: 512F8556873
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-288427-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Currently, a blocking recv() on a unix stream socket will wake up every
time an SKB that was sent from the socket is consumed by the peer.
So, in a synchronous communication scenario where the client sends a
message to the server, and then the client blocks in recv() until it
receives a reply from the server, the client will get a spurious wakeup
when the server receives the client's message.

Similar to other receive paths such as __skb_wait_for_more_packets(), use
DEFINE_WAIT_FUNC() to filter wakeups.

Signed-off-by: Jann Horn <jannh@google.com>
---
 net/unix/af_unix.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b38804e2c5ac..f36ab3e5a5bb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2707,6 +2707,14 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	return recv_actor(sk, skb);
 }
 
+static int unix_recv_wake(wait_queue_entry_t *wait, unsigned int mode,
+			  int sync, void *key)
+{
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
 /*
  *	Sleep until more data has arrived. But check for races..
  */
@@ -2715,7 +2723,7 @@ __releases(&unix_sk(sk)->iolock)
 __releases(&unix_sk(sk)->lock)
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_FUNC(wait, unix_recv_wake);
 
 	prepare_to_wait(sk_sleep(sk), &wait, state);
 	unix_state_unlock(sk);

-- 
2.54.0.563.g4f69b47b94-goog


