Return-Path: <netdev+bounces-197617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D1AD958D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD48E7A3D41
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA51369B4;
	Fri, 13 Jun 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asTLAxfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC738DD1
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843067; cv=none; b=OhqrfjGCMYPkdAY4U/s20Ofpcef24zFM4v+jgPm13iefCMuxVnjn1f88j9RxiyQu5kCko/hzF7wXeL1RI2BIM+2gdwqTJNNkntW3kevB0w6d32zm+y6joLvMaNprtcW0liMIdZorO6wgWPsjEYHG00Z+WEwwrUEQiuGquM5aZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843067; c=relaxed/simple;
	bh=mUNcLK7Tz/HN6zvk5vt0JDmZZxU3HQm+SFRcssS+tDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ/VoXvf+Xu7CuV37MR6xdbO/CMOf2bArRTUGfmY+lJ4B17Js2agymsU0UuEpiHofzAtMw9FBLriixX7A5T8yQb/D6sCWZmiLGC09e/uq7Jz2Fy6e92aXDbGm1NPCg4v22fpYuORoSErOWFywRxViunp9+8pRECNqg1k2nVxgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asTLAxfc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so1152636d6.3
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749843065; x=1750447865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW6v6dejOPisLbvN8khlLaoI3qjUIgmYYdBqK5vX2pc=;
        b=asTLAxfcZ8+poBnx6yHXtaJpjyeCb4+7spQ1bae03ow6gQ26t72HZj0GVkJQd1czTB
         QVJzgouAyTDenZnGGDvfUJTE0iuEC77hdQDLHqKpF8+eBLYHcR59xwyTSqj289SvFFC2
         eZhnmGcHxOvzgxrzDz/9zSlZ/8IozN3x5KI58jEnmN7DEsR3pctxhuEelK3Bnmz8A31G
         1gRJA2gjFVQlOfm8IGJSxHszqoU0etwicHj4Z2DU/hZyEsmLVIXLvf4is35I3sHU9zat
         we5IZ8lWkmm1crWLLCAN2ui99b8NkD51fgtMpi4e7kGmeY04y0yNSoagyyRqtPwkJlV+
         GxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749843065; x=1750447865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW6v6dejOPisLbvN8khlLaoI3qjUIgmYYdBqK5vX2pc=;
        b=u5bYay0C9740EE1NUCPmW/OQKumvRU53Sv3S+FLZwkfCbinvAWV++l/ogXHwL0vdh7
         HWGVMscHgLizI6ZbxHSrU/QMZCFAEvgYPuISTg0wjhLRvTZe9rj9781a+6r08/oYv5EO
         Nu8hpwpI6lNEpGVRlX9NB/0ZSBfZV6Ane7oHW9aDOesSOjgNl1z2PMQagmNJF9fzkQVL
         i7e0BYsLAYM/jXZSPYjkya77HCXFaelgqMI5wPhVo3dm5Az3WBK72wKA4cnN9VBAxdwK
         ly9eg2wkix+wX0vY3TCYL5SdA5H8J29EovDQi184zsJU0BYIqkNO56wBLxoTAxFh4Sjv
         xz8Q==
X-Gm-Message-State: AOJu0Yz2opJ1uo62YEn4JBVrjrshsccac4v35jsZbiCWty+/ZiGPrcyP
	jPX2hk7HuTBbLysHw/A8l44CVM1EWqNcV06yC9IMUoT/PLx+Qe3iadfR
X-Gm-Gg: ASbGncsyS6HeM4ov8QQRk3i8WnuPsTZdrgydAvdPqmaAqLFZlIN+i/Hp3daU0/KVywp
	85jKltemXn9EtLP9jMLBEu58X593YyyoRGcak3yYS5dFrcMYjMQfre9q4Io3JrFmoxxgmuxX2lx
	bvE1c8RlMdacMD8sAG0FPYn7I6h7nF6LWbklevtUS6WWsGgpTVNK4SRGnpgdmhT3BBz9mlMu99U
	57ujq82VtSSlhE8n0QJT3Wd+iw/O0kLR7cKmLSrsqfXjakKOplKURI5Y9HHLbnGptJmo5bofPJA
	6n5WOL8wjZ5HBgugwNiPH1oL83Z4dQCaf6c2gI30r8QTF4fPE16JtuSShIMyk5gyqSoFVa2P7Jz
	dj9sE
X-Google-Smtp-Source: AGHT+IHP3xDIsxPLmd3T7ZvJxd/G3VZK8Aq9Fq64ZUQJvzhpVyW2/UGnRUs+3S9DCCKulrtpd6P4Cg==
X-Received: by 2002:a05:6214:2b84:b0:6fa:cdc9:8b06 with SMTP id 6a1803df08f44-6fb477707f1mr3296206d6.3.1749843064813;
        Fri, 13 Jun 2025 12:31:04 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:8d12:28c7:afe9:8851])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b3dc1dsm25283646d6.46.2025.06.13.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 12:31:04 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Eric Wheeler <netdev@lists.ewheeler.net>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net] tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior
Date: Fri, 13 Jun 2025 15:30:56 -0400
Message-ID: <20250613193056.1585351-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

After the following commit from 2024:

commit e37ab7373696 ("tcp: fix to allow timestamp undo if no retransmits were sent")

...there was buggy behavior where TCP connections without SACK support
could easily see erroneous undo events at the end of fast recovery or
RTO recovery episodes. The erroneous undo events could cause those
connections to suffer repeated loss recovery episodes and high
retransmit rates.

The problem was an interaction between the non-SACK behavior on these
connections and the undo logic. The problem is that, for non-SACK
connections at the end of a loss recovery episode, if snd_una ==
high_seq, then tcp_is_non_sack_preventing_reopen() holds steady in
CA_Recovery or CA_Loss, but clears tp->retrans_stamp to 0. Then upon
the next ACK the "tcp: fix to allow timestamp undo if no retransmits
were sent" logic saw the tp->retrans_stamp at 0 and erroneously
concluded that no data was retransmitted, and erroneously performed an
undo of the cwnd reduction, restoring cwnd immediately to the value it
had before loss recovery.  This caused an immediate burst of traffic
and build-up of queues and likely another immediate loss recovery
episode.

This commit fixes tcp_packet_delayed() to ignore zero retrans_stamp
values for non-SACK connections when snd_una is at or above high_seq,
because tcp_is_non_sack_preventing_reopen() clears retrans_stamp in
this case, so it's not a valid signal that we can undo.

Note that the commit named in the Fixes footer restored long-present
behavior from roughly 2005-2019, so apparently this bug was present
for a while during that era, and this was simply not caught.

Fixes: e37ab7373696 ("tcp: fix to allow timestamp undo if no retransmits were sent")
Reported-by: Eric Wheeler <netdev@lists.ewheeler.net>
Closes: https://lore.kernel.org/netdev/64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net/
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
---
 net/ipv4/tcp_input.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a9..12c2e6fc85c62 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2479,20 +2479,33 @@ static inline bool tcp_packet_delayed(const struct tcp_sock *tp)
 {
 	const struct sock *sk = (const struct sock *)tp;
 
-	if (tp->retrans_stamp &&
-	    tcp_tsopt_ecr_before(tp, tp->retrans_stamp))
-		return true;  /* got echoed TS before first retransmission */
-
-	/* Check if nothing was retransmitted (retrans_stamp==0), which may
-	 * happen in fast recovery due to TSQ. But we ignore zero retrans_stamp
-	 * in TCP_SYN_SENT, since when we set FLAG_SYN_ACKED we also clear
-	 * retrans_stamp even if we had retransmitted the SYN.
+	/* Received an echoed timestamp before the first retransmission? */
+	if (tp->retrans_stamp)
+		return tcp_tsopt_ecr_before(tp, tp->retrans_stamp);
+
+	/* We set tp->retrans_stamp upon the first retransmission of a loss
+	 * recovery episode, so normally if tp->retrans_stamp is 0 then no
+	 * retransmission has happened yet (likely due to TSQ, which can cause
+	 * fast retransmits to be delayed). So if snd_una advanced while
+	 * (tp->retrans_stamp is 0 then apparently a packet was merely delayed,
+	 * not lost. But there are exceptions where we retransmit but then
+	 * clear tp->retrans_stamp, so we check for those exceptions.
 	 */
-	if (!tp->retrans_stamp &&	   /* no record of a retransmit/SYN? */
-	    sk->sk_state != TCP_SYN_SENT)  /* not the FLAG_SYN_ACKED case? */
-		return true;  /* nothing was retransmitted */
 
-	return false;
+	/* (1) For non-SACK connections, tcp_is_non_sack_preventing_reopen()
+	 * clears tp->retrans_stamp when snd_una == high_seq.
+	 */
+	if (!tcp_is_sack(tp) && !before(tp->snd_una, tp->high_seq))
+		return false;
+
+	/* (2) In TCP_SYN_SENT tcp_clean_rtx_queue() clears tp->retrans_stamp
+	 * when setting FLAG_SYN_ACKED is set, even if the SYN was
+	 * retransmitted.
+	 */
+	if (sk->sk_state == TCP_SYN_SENT)
+		return false;
+
+	return true;	/* tp->retrans_stamp is zero; no retransmit yet */
 }
 
 /* Undo procedures. */
-- 
2.50.0.rc1.591.g9c95f17f64-goog


