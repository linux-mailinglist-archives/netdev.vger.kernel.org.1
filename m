Return-Path: <netdev+bounces-265288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFLqHi5qrWkU2wEAu9opvQ
	(envelope-from <netdev+bounces-265288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 13:23:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46C230319
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 13:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F10A300A52A
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9024C313E17;
	Sun,  8 Mar 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2p9BBhI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67730AACB
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972587; cv=none; b=aksdNR2cDz9MCiSjpPrGAn/LvrgUYJH/I4Qd6hsvQXS0aCsOpdt0PyxSQFhTG94orgVMvBCr24QASkNx3N5r+xrE8ucfETRilRSTE92LC73/whrNsJd87kPK1uNJ2bL219jbnzqAWjurUhSVnoxQYRDBRya1nHuXRJpffpk9tBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972587; c=relaxed/simple;
	bh=FK7DVf+XgG7j7P07fhgc9JBXj7geT5T9WTBx8XFG1rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=egb2PfdORyJpsch23dANf6/20oiG8jcCfDihbQ+99UAJM9JVu4PItLnts+DaIUCWqAERHysUciAVhNg0zJgC8b3aQMVDSjGUiOAYnJS8oE1SdbNPTUT2/0+gfs3hUj7Zhf5pmEIUKeMU+GgOhMtbiYn15XtdP2ng7XkIG607KGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2p9BBhI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-509162597f9so16385791cf.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772972585; x=1773577385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqiPiGDZb24MhgyV2QYoX1JsUxwMRDXoHROoecNkYjY=;
        b=n2p9BBhIk4KlYJ/BnzFkWvNIO6iXX7FNSL+EWdupOgjnXbHBFVdEsNydNVu/+iyWkC
         i1nMWc8MjfAbNME4iEZm5a2UDalh+1pHAub8IY4jAYRDzRxgCzpitK60MDbyrZfdkb+l
         XiMnjgAtKhET4XZBr+jNQo8HrpjM6JRlUEeSQCQWr9CImwh6yatZjPIfH418yp6nnqtP
         Wg1+I45QJ89pIyPDvndcrzP1oX7kTKhv4KhTF9QueG1o+RCox8LuPzUmjYM4f02kZbc2
         dSJRnqUUfSrNr65UOhLY5d3w6xA8ZoBa3k3TPtrsYl8k7WeWZG0iZyFU5qdZwAH9e8/j
         Vfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772972585; x=1773577385;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqiPiGDZb24MhgyV2QYoX1JsUxwMRDXoHROoecNkYjY=;
        b=GnMlJu/GP+eI9uFoo7Bb6kfgMLGeIXRGBMwA3gZy2xu1Z+K2l9Ore94ZbVsTt5jHsv
         OaUnxqajyD9swp8QKXfH5T6KqCsE3vrYh77tvoJhm0xP7Y+Wu2ZEWkZXGZCbGcVefaie
         8uQ6UpDtyFOazeulHHijRUrOVhC5VzIdP92tToAfliejP+KGwr8B/SSOja9coYHLsEWo
         DHxfDcWxYWU2wPK65Q8osMMbQaD+4zJLqzFRJU6M2igeS6jMkXAZqSMYaihLtDOn9Mjj
         hzPXJto2peHEavBQvZ2uddT9h9OvW4+NY0GqB7p8SIDeCQD4A6pH+O9KPYg91CcN3EeH
         Lbmg==
X-Forwarded-Encrypted: i=1; AJvYcCWPsxHaqg/Y5z0cFw5vrPnigrTYJaYqhd2vWyJPqRxskN/t1lrFhj7R46lxNlh1FY6rcnAX9U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDqYStR1RDiVDXjhJzW4bfiIpoQfaVapvrs8AK+oLYkmZSjdj
	S7kk905lIUDWYEchDRZr/2Cq5Oc4CVcEVXwbiAlhYueeO2FW7lF3MjTyMlmAwZbitn4TewSn0Lb
	75u8JKTjzHbHUVA==
X-Received: from qtbki10.prod.google.com ([2002:a05:622a:770a:b0:509:17d2:9620])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c4d:0:b0:505:e4ab:ce7 with SMTP id d75a77b69052e-508f46c8ac7mr102293221cf.10.1772972584927;
 Sun, 08 Mar 2026 05:23:04 -0700 (PDT)
Date: Sun,  8 Mar 2026 12:23:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260308122302.2895067-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tp->chrono_type next tp->chrono_stat[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EC46C230319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265288-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

chrono_type is currently in tcp_sock_read_txrx group, which
is supposed to hold read-mostly fields.

But chrono_type is mostly written in tx path, it should
be moved to tcp_sock_write_tx group, close to other
chrono fields (chrono_stat[], chrono_start).

Note this adds holes, but data locality is far more important.

Use a full u8 for the time being, compiler can generate
more efficient code.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..c44cf9ae8d16f5cc7808a6ca78c1dad03354dccf 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -228,8 +228,7 @@ struct tcp_sock {
 	u32	sacked_out;	/* SACK'd packets			*/
 	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
 	u8	scaling_ratio;	/* see tcp_win_from_space() */
-	u8	chrono_type : 2,	/* current chronograph type */
-		repair      : 1,
+	u8	repair      : 1,
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
@@ -264,6 +263,7 @@ struct tcp_sock {
 				 * total number of data bytes sent.
 				 */
 	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
+	u8	chrono_type;	/* current chronograph type */
 	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
-- 
2.53.0.473.g4a7958ca14-goog


