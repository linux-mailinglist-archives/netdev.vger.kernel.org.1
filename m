Return-Path: <netdev+bounces-131023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0444198C673
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2951F251D7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904291CDFBD;
	Tue,  1 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZRGUy2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007631CDFDD
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813131; cv=none; b=XylXriZpE4A8Dxm8JNQS1lMH83XzFtjrm2injw3qDtysn6ZipUcrLacXjgAEJoMG1ivUHNaKFUjMH1L5WOcWmss+ckU3/vlgHMNRvGJifynNAhyJxgPOOcgp2E3WwuMvbuzAwNQ8oGL7XwZZumKxm4EPdpo2mAEb4EPpuyKreks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813131; c=relaxed/simple;
	bh=SpLf6J+NeXlXF7nMY3zbviUShyK9Ms/vPL+B5+x3Ch8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGZr6OtDhAVxt7JAbabdXXmi330pqQ0LYNFfz85xCVoR0fA0QtQENFpOE2oLHvPjxVZgIRcGYJ0a0pytJzwJahsuNgRx7WCvkPBkNwGGbU1Ynku/1S+1R5kKLtyYKa+KHPil4Zfe6NZizI5Y7aH9aG8N2/VNZ2fZdrPAToFCsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZRGUy2V; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a3b49a6408so132411137.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813129; x=1728417929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0JE7mnELg1Z9DW8aRz+C2DUl2g3zMxwqIff7swKpUI=;
        b=fZRGUy2VRaZvgQnn+SCAVjNSA4TrtszTY7iGXmfglux4YBt9q2cPiy0MrkTJsavTBR
         tIyRgNt27r5ddaJWQbl1aN9kO+k2ZQJYo1zOb4bWwKUoUscIDXg9ZZpMIxi7XsNJFekY
         e30LLFEsZj+KBek2UcbiL/CDUEAZ0gyeJlR/ZVxjc3lWrVDCE9DFYa4zay7bCXl4gm/G
         25/aeVtVgWt2dU65v4JwqlIWZXDrFP6bEP9yIBD4RspxGSMnWqKNV/LlrVur6xzVDS8U
         S630HTHmFEOqovmKVZkNjby7rkSG1zb3kr/pVf1ijlIxOE4LYV4wtJA8gJSZvpxHYJ+w
         xLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813129; x=1728417929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0JE7mnELg1Z9DW8aRz+C2DUl2g3zMxwqIff7swKpUI=;
        b=cTkl6PZyeo88hOUEKmf4JrF96QMaAMAolsD316B0civNCTKv5vXapn6mOInhNCPt6E
         JIWvXj9uJmOsw1q8m8kr5OZLeQ/mQXVRKU/JPdL3jcKSaympK3pLrOgRlE1p4Prxkx1L
         t+kUAgZpzSBV2kVEeiz5q+Fxm2U0WXzJOvpWSeunh+N+k8tlBVFC1OGtWmRoVb9DvSjs
         2mt+ODHIQ/3yYAcleSNhuk7JP7m45eSVcye66SOOn/xWyOLRlA7pTSsj26r8+qF9D6k4
         Tt32WwopefPdRMtXtodvFaaWrbTbq+A09aB/rqgc9ttmil0//d71jFJZH4e83+B3Ls/R
         MOAQ==
X-Gm-Message-State: AOJu0YwhdsFAqib21Wy6+GnJcHGTuI3ySPRy6H9lfoNDHmBuiVHfu9S8
	l0DjWi/CWc/4yGAayhimt+aenMU1+sESU16g3jgszcfUJqYd+qNT
X-Google-Smtp-Source: AGHT+IEX2eJ/7vEFqKcoP/74Xb5n0IgZsiMZHnPdW7i4rwhDLXL8dIbyUw/HPqTi81CklesmrcHn/w==
X-Received: by 2002:a05:6102:32c9:b0:48f:1db0:e268 with SMTP id ada2fe7eead31-4a3e68e9ef6mr440035137.3.1727813128821;
        Tue, 01 Oct 2024 13:05:28 -0700 (PDT)
Received: from ahoy.c.googlers.com.com (182.71.196.35.bc.googleusercontent.com. [35.196.71.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84eb504217bsm1237447241.14.2024.10.01.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:05:27 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net 3/3] tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out
Date: Tue,  1 Oct 2024 20:05:17 +0000
Message-ID: <20241001200517.2756803-4-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
References: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Fix tcp_rcv_synrecv_state_fastopen() to not zero retrans_stamp
if retransmits are outstanding.

tcp_fastopen_synack_timer() sets retrans_stamp, so typically we'll
need to zero retrans_stamp here to prevent spurious
retransmits_timed_out(). The logic to zero retrans_stamp is from this
2019 commit:

commit cd736d8b67fb ("tcp: fix retrans timestamp on passive Fast Open")

However, in the corner case where the ACK of our TFO SYNACK carried
some SACK blocks that caused us to enter TCP_CA_Recovery then that
non-zero retrans_stamp corresponds to the active fast recovery, and we
need to leave retrans_stamp with its current non-zero value, for
correct ETIMEDOUT and undo behavior.

Fixes: cd736d8b67fb ("tcp: fix retrans timestamp on passive Fast Open")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 774fe1de8a922..e7111cda25494 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6684,10 +6684,17 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss && !tp->packets_out)
 		tcp_try_undo_recovery(sk);
 
-	/* Reset rtx states to prevent spurious retransmits_timed_out() */
 	tcp_update_rto_time(tp);
-	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
+	/* In tcp_fastopen_synack_timer() on the first SYNACK RTO we set
+	 * retrans_stamp but don't enter CA_Loss, so in case that happened we
+	 * need to zero retrans_stamp here to prevent spurious
+	 * retransmits_timed_out(). However, if the ACK of our SYNACK caused us
+	 * to enter CA_Recovery then we need to leave retrans_stamp as it was
+	 * set entering CA_Recovery, for correct retransmits_timed_out() and
+	 * undo behavior.
+	 */
+	tcp_retrans_stamp_cleanup(sk);
 
 	/* Once we leave TCP_SYN_RECV or TCP_FIN_WAIT_1,
 	 * we no longer need req so release it.
-- 
2.46.1.824.gd892dcdcdd-goog


