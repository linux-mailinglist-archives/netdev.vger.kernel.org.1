Return-Path: <netdev+bounces-266929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOL9GRJjsmntMAAAu9opvQ
	(envelope-from <netdev+bounces-266929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:54:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1226E0F3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB623038A49
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4103A6F04;
	Thu, 12 Mar 2026 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz6VpJP0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAA3A382D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298447; cv=none; b=YT9ElksCxX/01psx1dsTrDM/IHbzObhg1qfa0ma6zCFwK0sWXWghCUN/yYoJMlTFsnAQSbZvOg4JEvzycu2ViFCJUVkqcQRK9+PrRMAcc4LGgk1USbn6tEal1RfA6PaeXSv6Y7XG+nA7kphmGStK/KOBU6w5yn+0AzOW1vsgRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298447; c=relaxed/simple;
	bh=FK7DVf+XgG7j7P07fhgc9JBXj7geT5T9WTBx8XFG1rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pB8j68I8poCu8x2YaiAQG2/O681MNObobV2xM4m5wqi1db0vnScL2vP+I+bBa8EP8h1UOo35zeb2HW+11/4ELnnnDB9zAJHf4msl40K2r6XKVut/HZdndEP29PvTgyHrek53FgtdvWcFMJfPYCrwWQW/tyyZrlEGo6usmPSybPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz6VpJP0; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-89a08e6cd15so69048386d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773298445; x=1773903245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqiPiGDZb24MhgyV2QYoX1JsUxwMRDXoHROoecNkYjY=;
        b=vz6VpJP0Ayh8Wnik313XNfR6nqFmVPerurnVTfx9nO2LB+BO5LImSX+xvBA10aY1W6
         xtC7qgOU+URzARbsJr6Il9eHZqPRibB5liAU+OzXj4b+OkdTiRcen58sDibQ9jABzFBt
         p6bH4ZbRx6tFa3GyMTXBZauZci/DvCFvxOtwbT2mTFp1gjbjbc4qRqERxLzj1snwxXSI
         7QaNvzDU9BpeKIhxyKY+rNU2/zIPEsyeSdaBWQ3LGeogV2M1hAYnriPPHwoK4Fc8yhNd
         /WlSCKz3XsrOki/uZTRpdGNDOeoNmE5ObqW2d2dr3tS5pjTyd65K9yM8NagDo/irk08z
         YBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773298445; x=1773903245;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqiPiGDZb24MhgyV2QYoX1JsUxwMRDXoHROoecNkYjY=;
        b=fAzsQSqceK23QjIp2m5F398fFVX6Sa9OFp02gYL7PN0pHGmo9/dDsNFf6IficXPQlB
         GJh5xe62rC7jiFRv+zKOBVnHxYKp8GkDnngiKTpYAhdQtbyBDBRU6zXgzfhWpucAnBPX
         CNjFGF52S9ZsUbh0KtQ7LFBrP2XPpZgAx72I+NGMu02bWdx0lldxa0lctTvrHLb5B+5P
         FCL3xNOY66dt5AbJ6FiWfgvYuuooONedp69mCVA6DWovrkTO0hxE3dYTqLoRO0Av41n5
         iSBx4x34FvNvy0Vm2DNeX4Tjluhe9lpkDskOYBQEbOVic6miu34NFsz1Fm5VqZj6DQ1/
         dxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Y1j8Q75URqrEc87Mm92pHBoYonkBKq5Xl8Wg3kY3Ax/fl76XtrXjL8ziC9OD4MIpSGuIvIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9pb9IRXVw0Ev073yE0KAYEVCIwRgIptLEELlVfWqqWImd997
	ilD4BPEwxIbWZjgOSu6Kt5XCtlJOMRwikQJZt5OiHMZBLjCqnLKO8YzjmkuqkF6eRAHgKOaexWq
	l5xh74jjgVdk3Yw==
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
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DATE_IN_PAST(1.00)[90];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266929-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9B1226E0F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


