Return-Path: <netdev+bounces-279144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAG9OZhA4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:03:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A865B4146E3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31CB130333B3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F0382289;
	Thu, 16 Apr 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nexnkos6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAB370D7D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369810; cv=none; b=rqRka1VcwZk8nr06AgmNmQ1fdJ5JK4veIbxZT1Czt95G3wUvU8H/1FqdXnLtSTSpDePshHsbHavtg4RsT4MHutvrVVh/btQnza67gQS9DBszJAjVPYBrUWeiixc55vpjbM0IPSnUZ4tkKm57t7yaS6W1pwPnlSM/PrTxWOjHsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369810; c=relaxed/simple;
	bh=OtMKJsjRaeBmhdy8H3KMRkLIGb5stJx60a6ehmDjUPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kx2gVBdpIuwyj5ThdScr91PPF9OmDI0syFquzphsTAqrvwv5vnpUfpi7sy0LIGX9xeTCP0rbKV1/mTvjwS8Fr5DhyNAaYA9TcJrK2mwqQFT0yL1F+Pvdq7aqW1rZq/9Y/7GH/T70pyRGBnX9zrcRYJaESCoZ7igByXFTwMJ4HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nexnkos6; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d5d1c2289so158450481cf.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369803; x=1776974603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cV7hJFwn48CKJv93KYCZeqcPsftB9nfuekaA47HvrM=;
        b=Nexnkos6wQmo82tFzIUeRQR1ScowHETHgxVfIuPmCnjb7OmuoP9rCAwXQyZFUdk1Lz
         zppfzRIR3L9e7JnKQ59eh1gQ/wVy+mRf+60MmrNCgAi2/hYQYwoBULfs0qb4JnkC74Jn
         iFQqOT5G5NwKse6doRdG+DAh10//JmnJBWhfbns0FVfQaAk9XftJVvjxaL4tZ0zoU1KA
         CoUChbU/V7YQM3g596ACsKu2UrjWN0pIbg30KJv8WGAZOUwTEf8k/s+ZaRdbHpHMtwCT
         VCkCIcBMV6qjiUIcbEcl9kNS4slSAd6TKq51tyi3dEEDZGBXeuJPnznYRy2NvZnBEZZX
         pz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369803; x=1776974603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cV7hJFwn48CKJv93KYCZeqcPsftB9nfuekaA47HvrM=;
        b=bqYqXy08SCahF9uKRSv+mcz+r7zsci4tLubC8Gjtd+qmtX1XJLANi4n5bZd77ABkM+
         YXcrXstrAKGymVDTvFy8GNvLLHkUeguvg3F+f4hsrTxLJwPiC3GRkFKrnr3mGErz3lK0
         zWHPT943oGaGIQcA21/CW8LNV6L1bwr7W84fgjuZJ10v5m6cwZ9Q/2sv2HERloSpcVBu
         JoVKNmeYwORTiMiTlglkgQrT9Jb1NO2SFBkQziBc6Uggm153/QT0MRc3rpXRxVm9QDVZ
         QThSIih+ZfiVz/cSG6wFtrS8enranxXgWvfKRND4clq7uIBtfIS6hGuwrVxPYtrl+1IY
         2zNA==
X-Forwarded-Encrypted: i=1; AFNElJ+cH/v9MtsHrgUhMFH5uoYKUPXkE0VTaZX/AwEakOjZ/6SYAtuSOTtPcmNBQDfvNMUXAU24QMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNR/zhNOMi6F5J2VojBid7YogDXbqImkblzE7bnGb+NhTEdFs
	ra7X8F74w0t+sElka8Ya9rHkYha54xwgAfh5/U/7Ne6PW1CMneeSw8axHbl4TvCom77GgA+gPwx
	qFzKXCz5acNXKyw==
X-Received: from qthd6.prod.google.com ([2002:ac8:606:0:b0:50d:b85d:f307])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d8a:0:b0:50b:4e60:93b7 with SMTP id d75a77b69052e-50e34a3018cmr8274201cf.43.1776369802583;
 Thu, 16 Apr 2026 13:03:22 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:06 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-2-edumazet@google.com>
Subject: [PATCH net 01/14] tcp: annotate data-races in tcp_get_info_chrono_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279144-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A865B4146E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() does not own the socket lock,
this is intentional.

It calls tcp_get_info_chrono_stats() while other threads could
change chrono fields in tcp_chrono_set().

I do not think we need coherent TCP socket state snapshot
in tcp_get_timestamping_opt_stats(), I chose to only
add annotations to keep KCSAN happy.

Fixes: 1c885808e456 ("tcp: SOF_TIMESTAMPING_OPT_STATS option for SO_TIMESTAMPING")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 10 +++++++---
 net/ipv4/tcp.c    | 14 ++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dfa52ceefd23b7a25ed725e3a7fde3bd7e442e4e..674af493882c802ebe03e0cac6e40b7c704aa0de 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2208,10 +2208,14 @@ static inline void tcp_chrono_set(struct tcp_sock *tp, const enum tcp_chrono new
 	const u32 now = tcp_jiffies32;
 	enum tcp_chrono old = tp->chrono_type;
 
+	/* Following WRITE_ONCE()s pair with READ_ONCE()s in
+	 * tcp_get_info_chrono_stats().
+	 */
 	if (old > TCP_CHRONO_UNSPEC)
-		tp->chrono_stat[old - 1] += now - tp->chrono_start;
-	tp->chrono_start = now;
-	tp->chrono_type = new;
+		WRITE_ONCE(tp->chrono_stat[old - 1],
+			   tp->chrono_stat[old - 1] + now - tp->chrono_start);
+	WRITE_ONCE(tp->chrono_start, now);
+	WRITE_ONCE(tp->chrono_type, new);
 }
 
 static inline void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1a494d18c5fd130c2a7bb4c425eda8e4ddcdf612..7b7812cb710f6e05a83615811eefd0cf8a845cab 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4191,12 +4191,18 @@ static void tcp_get_info_chrono_stats(const struct tcp_sock *tp,
 				      struct tcp_info *info)
 {
 	u64 stats[__TCP_CHRONO_MAX], total = 0;
-	enum tcp_chrono i;
+	enum tcp_chrono i, cur;
 
+	/* Following READ_ONCE()s pair with WRITE_ONCE()s in tcp_chrono_set().
+	 * This is because socket lock might not be owned by us at this point.
+	 * This is best effort, tcp_get_timestamping_opt_stats() can
+	 * see wrong values. A real fix would be too costly for TCP fast path.
+	 */
+	cur = READ_ONCE(tp->chrono_type);
 	for (i = TCP_CHRONO_BUSY; i < __TCP_CHRONO_MAX; ++i) {
-		stats[i] = tp->chrono_stat[i - 1];
-		if (i == tp->chrono_type)
-			stats[i] += tcp_jiffies32 - tp->chrono_start;
+		stats[i] = READ_ONCE(tp->chrono_stat[i - 1]);
+		if (i == cur)
+			stats[i] += tcp_jiffies32 - READ_ONCE(tp->chrono_start);
 		stats[i] *= USEC_PER_SEC / HZ;
 		total += stats[i];
 	}
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


