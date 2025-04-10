Return-Path: <netdev+bounces-181382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7FA84BB7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8457188F280
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D72836AA;
	Thu, 10 Apr 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1kr9wcB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5C1E9B38
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307659; cv=none; b=FGf25KopuR4crnaiGiEIDAOEURza5TwF0dgOC82dp1/AMvoE5q5vo1awX89eP7UQIkjunySRmvUhUKIFjNKeePzjVlBuepCIZWEfgsSRfzuX7ut1mZw+y7cCn3RCrwlioXwBA5nldOvmjTiiNr7XittwYlWiNDOXKgTlllzipEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307659; c=relaxed/simple;
	bh=2M+JH2tYO/oJkgaCn3eGnD7HNXtUOZ3Fjp/V0/jRz4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ro8df+//U1OlFzEOOGY0d3+IqOLtdrI0o4tf7KLnAWZmf/kInXsdGFGrq7o4P3KurAXUrqz4ldnDeZBuafDSCxyP6dKDyJPRlIcqCHUCOmJ96zeaEYALLt6029JZo9PpbN1ADSLRz7LrwkwNHGGCQq+BoEg+HKvQeMKj1fAkw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1kr9wcB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso599783a91.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744307656; x=1744912456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tx5UWnt5xRKqicMZjkdx3pxfdcEmdTkzM3F9XBBju6Q=;
        b=l1kr9wcBsiRzPvGMalwkOikuu8iCA48eyraNiDul/EORj9wRtsrP7pbANq+lB6SWei
         e+krVgoeRujT6IdBp/km29m/wcnYrLZhyDf0LyOPdSVhyLQ7sjOQ+xPKy/POML/ordbd
         43efhTYkj72hl7h4q4G5+LWGCzV7K1y10vy9k7yO+JLBA+mqAE5UeTO7w1DoV60w6Utz
         gjb3hnXJlLEds7BjR7yIz5Z3DpsL/gI/OIOaRRP3Gjh3+DGWmEYAlppp0u0gg43MKqw8
         N8klQqRj03I42tk004h+6fwizp16+ZVZgKqz2F1NTc+jsEOLAiRoPnv7MPbq6xt8MB1n
         msAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744307656; x=1744912456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tx5UWnt5xRKqicMZjkdx3pxfdcEmdTkzM3F9XBBju6Q=;
        b=sPbwZUTzdbjiap1YssW+s1sRewF3cDGOZyIW2gNJse8fV/JKw3mKCZeMb7fqWMxp6G
         MbHY4ZiHDnJlC6TgL+UIcJJfapLFFGPYJKG051cp+gwPo6u6lM9PRQgFMRGh3Bkv/ILu
         2Ax73xx407Xcq/l12bPYEvHAW6QeU89/Y6HqHep/YkOgx5MLxvOYFtpt1IIh5n1NNZfe
         32esOCzjtth31eVLzI3ftIzMruZ+Ywr7rX41aReQhmdZC5dDRe8LBRGlhoJtVlkA7x7M
         gTLghnOzsBX2jt1Bf5JoBkbmz5rPHcoWJbKIexq/Or0Du99cgkSogtoyEPwaylLlblbl
         5v9g==
X-Gm-Message-State: AOJu0YzYNesGUUsSUprJagsW8l4RKheXVaDU5rklzDYI7KtrEvedz0eN
	X8cYff/oLIWU58kSVjZMDjg8btAuGiDE/pytZ4kiigQ0j+osOrssw2TQHCo7/m+uRw==
X-Gm-Gg: ASbGncuZ2Gr+78uOS4N7Ru4ZjMdnql0QPoDLV+rpUT41irE2wNnsqQOJg5wde9RrHvo
	Jc9rbBQB+laKYw/AKwI94DhHAbGupMLveSER8idImppECg4jeW/Uu7sutAt68WZzpvRb5nFGR4j
	2cWXubBOAadmKMmB2a8N4GbHOzJzsv7QSjuHrbYp0Hc//VFnvCNCvG+V1TPuOclsUbYphUDhCDM
	KX2JGu3Es5j2FrHobSU9AK1sYJrAOGGtVAr5jSQQ7qJHhxvfBc2y0TrXr8kb6LFfCL0B+pSlOY/
	iqIEbDEHD945s1H6qN1cKK9Ixfau
X-Google-Smtp-Source: AGHT+IGfSgUd+pmWdZLogCJSCGhJmi7BZBRHy15+h/5fkL9LisFrd0pr2WVhWG/s9e5aucR38RAGEg==
X-Received: by 2002:a17:90b:574b:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-30718b70349mr6036910a91.9.1744307655835;
        Thu, 10 Apr 2025 10:54:15 -0700 (PDT)
Received: from ubuntu-64gb-hil-3.. ([2a01:4ff:1f0:8f63::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccbd5esm33782255ad.248.2025.04.10.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:54:15 -0700 (PDT)
From: Luiz Carvalho <luizcmpc@gmail.com>
To: netdev@vger.kernel.org
Cc: Luiz Carvalho <luizcmpc@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND is 0
Date: Thu, 10 Apr 2025 17:50:34 +0000
Message-ID: <20250410175140.10805-3-luizcmpc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current tcp_acceptable_seq() returns SND.NXT when the available
window shrinks to less then one scaling factor. This works fine for most
cases, and seemed to not be a problem until a slight behavior change to
how tcp_select_window() handles ZeroWindow cases.

Before commit 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
a zero window would only be announced when data failed to be consumed,
and following packets would have non-zero windows despite the receiver
still not having any available space. After the commit, however, the
zero window is stored in the socket and the advertised window will be
zero until the receiver frees up space.

For tcp_acceptable_seq(), a zero window case will result in SND.NXT
being sent, but the problem now arises when the receptor validates the
sequence number in tcp_sequence():

static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
					 u32 seq, u32 end_seq)
{
	// ...
	if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
		return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
	// ...
}

Because RCV.WND is now stored in the socket as zero, using SND.NXT will fail
the INVALID_SEQUENCE check: SEG.SEQ <= RCV.NXT + RCV.WND. A valid ACK is
dropped by the receiver, correctly, as RFC793 mentions:

	There are four cases for the acceptability test for an incoming
        segment:

	Segment Receive  Test
        Length  Window
        ------- -------  -------------------------------------------

           0       0     SEG.SEQ = RCV.NXT

The ACK will be ignored until tcp_write_wakeup() sends SND.UNA again,
and the connection continues. If the receptor announces ZeroWindow
again, the stall could be very long, as was in my case. Found this out
while giving a shot at bug #213827.

Could the precision loss lead to a zero window? If so, then this
approach probably won't work.

Fixes: a4ecb15a2432 ("tcp: accommodate sequence number to a peer's shrunk receive window caused by precision loss in window scaling")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213827
Signed-off-by: Luiz Carvalho <luizcmpc@gmail.com>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc95d2a5924f..4d05083372a0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -88,7 +88,7 @@ static void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb)
 }
 
 /* SND.NXT, if window was not shrunk or the amount of shrunk was less than one
- * window scaling factor due to loss of precision.
+ * window scaling factor due to loss of precision, but window is not zero.
  * If window has been shrunk, what should we make? It is not clear at all.
  * Using SND.UNA we will fail to open window, SND.NXT is out of window. :-(
  * Anything in between SND.UNA...SND.UNA+SND.WND also can be already
@@ -99,7 +99,7 @@ static inline __u32 tcp_acceptable_seq(const struct sock *sk)
 	const struct tcp_sock *tp = tcp_sk(sk);
 
 	if (!before(tcp_wnd_end(tp), tp->snd_nxt) ||
-	    (tp->rx_opt.wscale_ok &&
+	    (tp->snd_wnd && tp->rx_opt.wscale_ok &&
 	     ((tp->snd_nxt - tcp_wnd_end(tp)) < (1 << tp->rx_opt.rcv_wscale))))
 		return tp->snd_nxt;
 	else
-- 
2.43.0


