Return-Path: <netdev+bounces-305592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dOA/HFliTWqYzAEAu9opvQ
	(envelope-from <netdev+bounces-305592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 22:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337871F89E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 22:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Yjm34Nop;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305592-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305592-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3746301325A
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D83BE148;
	Tue,  7 Jul 2026 20:32:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1F29B78F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 20:32:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456342; cv=none; b=qdOrQJaPj4IR9Z4NQXlZOCzRGh6RvB/jYB7NG0jaE1dEATXtpKQnAQbw+6q2PIRPlzCv6gUcM2WfK9ANETv/C4DwvH+BXG1+qXyBic2dmHn3MH9ZJztBv79PNi31VycF0X8UrVQDl+mvZnHYpuH8Vsbxmv7GJHoTG4Ahfyhzui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456342; c=relaxed/simple;
	bh=YwKMoHINoonDDV2XuHlbEOT76MQPbOs3105Ny8tsYhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apur2is8GxM8ZTEzlgzyIrGIi/SLMZ82S10HO5pdI2yBNeD3eYDYKblMp2iAeBEavBSgFgD1vvJVVBCTBieCR8YVvEQbD0r3LMHiBstZUYFPkL5LrHTdFPKaS2FxpiAfZ8pzNln2UVqeUnadEEaWCKMScC34jYcQtu2FzSSzhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjm34Nop; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so895303a91.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783456340; x=1784061140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBtQp7kflpRbuYZ47bjRgNEVT72fjkLE3FQ1IUzhIiI=;
        b=Yjm34Nopqe7czHIhvDjrny5PfJu+irF1IyQ3jINxTeNRZifN0EHmSH5Z17thHi0BPz
         DKCkUgM36MmbVqaDRLsPXvnsss/g4snHzhdITGGX/SpsRIoCounKLfIGipDvovjQbi6w
         ik2NbQi8QtXGGKiEs5GiPQva8fpmxCc/G+xr3tu9P6z09hthjEbjmaow0ZXx4wZCIHnq
         2Ltkv6eQT4gJYTdBJdE2d+PYowQhcqer2Vjwl2LIBGvpYJ5jjKbDlJLqQHM+d8Glh/5y
         aVTC1bCxkP5WNOVb5c/1lNfDuR1tlZTgLx3UiFvHoYiKzi0i1BsoWw+prGl5q3ixXRAr
         CDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456340; x=1784061140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBtQp7kflpRbuYZ47bjRgNEVT72fjkLE3FQ1IUzhIiI=;
        b=aIG1spnNo5Q9jpfoETHOEZh3m7hiuphdvqzoVeNaKgXzzpe6qCNzpmisebHdJLLGn+
         01F9cZJoYBNT74/tGB3XhK5IM7DfeIau77RAbqxX6g8O6mKOi+aRJnlsvy7X57adG+vw
         FY2oiIRAHifEHLc3qeExr3DTCiN3efT59OjZhop4/25NTxe7r28mMXkQBRV4GG6BBDWO
         sYAsXpZfO76/vXM5+CDgNjxnnDm7Ov2l8CGKMuOhKXpQbhsWriYMmtqW8XQ9Z6O4hUrc
         sCE4MEvSabUCMRegjB+KbOfTzJpHcCyo7z13uIZOckWowYxTKkHdTFu+DRT85nXh1t9n
         H/Nw==
X-Forwarded-Encrypted: i=1; AHgh+RrFUTv1Xc9CrwEKfjoA3By18tEqC4sA3lRrnpqz60ljL50WnpwLvOm19rtf8VFWLaiQlnc36p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnQkxj46pa5QfguzDGZfhZAZPAr4nU/DplQ5M/uxQLjnlGbgL
	ffOPGe6KlUfBOE3SEsouzmHTE5mOKzvERLZ9qNmkE1ZsVzhjcVVkAWpi
X-Gm-Gg: AfdE7cmOFZj8B34kuOs4/CPXnJ7+aH3WryYf7UeyBYd2McPrCib7vqtEkcUrI2gLtjd
	HCtw/dlAIV9i/gomLh8YYOPxb1Xm9qRBHtH3QAe/Wd9F6rv1r48luNbtfqk/boE7bwb4557wuQB
	4VGQ+p3UzwHMBoYQaeVoRe36LL6DRuUlEFTTmisYOHoigr7LjihP3wjb0tFtTEsMltpRSS2NwWM
	LWfjAlhTBR70YajORD7BW7Ik2Ih04wpAUKiTEvI7SIZwIjt/tPr7pqKKrhJSX4Dy/f3GJBIpkB7
	d13j7LVUCj0szSZnX73BG4rnzMhNGbEEizCMTTxK3lphXJqPp45k/mgrQ3DlfaFwwGomJ5VI6yt
	XwDApSabi9xuAJg7/gV3rGHzTESqkmWZ21IL/4Pww1MrDsfaCzTwlNWCJcRCoB8CgZWsB02guzU
	JF5JjHnGJ5hoz6YBKcl2rD0plTxnyUCQ==
X-Received: by 2002:a17:90b:3c0b:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-387d42509d8mr4052426a91.0.1783456340179;
        Tue, 07 Jul 2026 13:32:20 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d19da395sm1808917a91.8.2026.07.07.13.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:32:19 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] sctp: validate stream count in sctp_process_strreset_inreq()
Date: Tue,  7 Jul 2026 16:32:15 -0400
Message-ID: <20260707203215.2752-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,microsoft.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-305592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1337871F89E

When processing a RESET_IN_REQUEST from a peer, 
sctp_process_strreset_inreq() derives the stream count from the 
parameter length but does not check whether the resulting 
RESET_OUT_REQUEST response would exceed SCTP_MAX_CHUNK_LEN.

The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes larger
than the IN request header (sctp_strreset_inreq, 8 bytes). Generally, the 
IP payload is bounded to 65535 bytes, so the stream list cannot be
large enough to trigger the overflow. However, on interfaces with MTU >
65535 (e.g., loopback with IPv6 jumbograms), a stream list that fits 
within the incoming IN parameter can cause a __u16 overflow in
sctp_make_strreset_req() when computing the OUT response size, leading to
an undersized skb allocation, raising a kernel BUG:

  net/core/skbuff.c:207        skb_panic
  net/core/skbuff.c:2625       skb_put
  net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
  net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
  net/sctp/stream.c:655        sctp_process_strreset_inreq

The local setsockopt path (sctp_send_reset_streams) already performs length
validation, but the network packet path does not. Fix by adding similar
length check before calling sctp_make_strreset_req().

Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Reset
Request Parameter")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/sctp/stream.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 5c2fdedea..ea3805712 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -639,6 +639,10 @@ struct sctp_chunk *sctp_process_strreset_inreq(
 
 	nums = (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16);
 	str_p = inreq->list_of_streams;
+	if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq)
+			> SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk)) {
+		goto out;
+	}
 	for (i = 0; i < nums; i++) {
 		if (ntohs(str_p[i]) >= stream->outcnt) {
 			result = SCTP_STRRESET_ERR_WRONG_SSN;
-- 
2.53.0


