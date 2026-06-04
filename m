Return-Path: <netdev+bounces-295410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N4e2LL/WIWrSPQEAu9opvQ
	(envelope-from <netdev+bounces-295410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A6643037
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:49:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VzeN0a30;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295410-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295410-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF303040460
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBC3C0605;
	Thu,  4 Jun 2026 19:42:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1F3BB110
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:42:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602158; cv=none; b=PzFalrNl9aFhuA8KLR5InO4tFZGoLKl6uNfeqc9/xMIENbeyW+0uLEhDGLDQEU4W9jTDAtwxd0wrrv7b9Cp7VI6oGHRTEYnbvYUx8n9wRKm4UyYiF1L9S+ZJ1bh12LpPBXcM8S/tdmnebS1iFHzuqulUhFzT/Z09N1e4OSrXadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602158; c=relaxed/simple;
	bh=oGBeetydJ8ctI/l0HZK4t28OwkM1UBCncZKaHM4vprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mce6vYfS5+kHVGWEKx+sf/lExyaWSAJ0XgcooVVCY9KXw2B4AzoT58wwR/DWx4uFQM9dQOL1WTKOOP1pqZ9Lzmo6uF0H66gzgPTFUgkfVul8k3QZ1xtyWFk3FGsyJBQ5z4mbBpdujFAf6YyNmyfEU44zvlaXYFuRWoDAoFwNh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzeN0a30; arc=none smtp.client-ip=74.125.224.47
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66039d3efcbso1282422d50.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602156; x=1781206956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOu+XVpO2X8boWQ+XEzE3XtWYFxZXr9vrWN5DioFkng=;
        b=VzeN0a30ZhnHeYnqu6HG5G3MWrkhRWRrhGZ60fJYczdsqOfgkXrPfb+cr4VvokFUKU
         qA2Bsyf5DV7mHIHBOsI++20pFoVT1lHMV2yL4zLM4CKIDUL10+k6JTZ9I6CN0XVVdMDZ
         YHIpeCArHaH7rQHE96w6mswmlFVAovZpkGCPnmDmaQ4mXmDm2zI2AIlVvG4esLJP4b7e
         yEMy9+T92p5ksEEwb18tgWX9PcfeczB0RyWTa/LhOyxnIfl+5kY8Fd0UH8rI47kcSG1g
         ucrVwhHaCwau4IF0SqOxEkyeaH11UJzpyyKRLFyKpZ+/0J9k6TU8n1yDmAHa3L795qRT
         wySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602156; x=1781206956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOu+XVpO2X8boWQ+XEzE3XtWYFxZXr9vrWN5DioFkng=;
        b=CR7/5Uycc907QVPc2U2MxweR4u8aNvGSmje6Ikixyh3pA2lFD5nJgKtZTSxS4clbpO
         WA1nEEGtrUsC0lv3ThiudxDFBugBnDaYunR+wXWH1JNhX1GaVWt/m9X3bEC+UYpwdh9W
         1kpD7O1BVqgLqkKLiKBLKR6ei9jDsX0MjrHulvB8g6DTrQcLPItNkKt7koNPxr92IrYz
         pbSDnsbZIiun6hDGYvG8gTth1ypQ63Nt/vLmGViZl+v0D8ZRoaX69L5MV5WC9Dqd6QuW
         neDNLdjpft6ZraqzoA134vZp6LBMwZ6xhTAXv8jrT3iFN46X3+CpMJ8alwOgHI07t365
         SVPg==
X-Gm-Message-State: AOJu0YyFIBYje6FEbE9haM99iDJERwGngPc3/Kj5h6oHilc2UaGpeMb1
	Xdh6KVpFGlqrRGioxGkXmGAFfI8NUmG9YA8r151cx4SkzdJZw42XmHFjP0gIAQ==
X-Gm-Gg: Acq92OGCGJvvc65nwZ+NExqOwsNLvU2Dc76CGr2bjkVvuog/KCL2VvjKYG56X6Aha1M
	wQTd4YAmJzXLRaXfw1uvUa4E3jIOuXRL6/JuSUBFGKjYyc5CeUnrIW25v+03FApArGCb184wzrU
	jhJ5No/1EW6GOke3K+DLLF6npDvi+9bt5ja9wO1m57rE7cjsxRwseqU8YMSxeFStIZr7+rgNGNK
	R3pZMbRwazx6wUVMuCsABGQnRnLiVKkYa4Tx9FsoLcQ6E2ZLofgqM4jTinY4d7xWsEW3xLnKR7E
	dqtffRliumuykcn6xSRSZRMBBeBaVRVkffKgFnXW+mmrm8BzxTEmyYnyDmu6QkzV19XNWgsil+e
	4s2vufgIu5oIkaw5jwN2jCS4OQDyzqdaxMGxoqjHitWeDPm2SCrMmWh/ncS/kyOrXfEJmdg7eP+
	ZEZU7BJ/DyCWSIH0bTViREQzeVUQ1Th8cRG3FUEa8f6q2nvDXfZTOhB0uE2AK23mFVvpENoN7Gs
	l/9FTH4OuhMwIRc528xBO2o1hv+9VHkI6Mpy2A2xgO68nZr58U=
X-Received: by 2002:a53:d9c5:0:b0:65e:4cea:a06b with SMTP id 956f58d0204a3-66106f886eemr209433d50.45.1780602155906;
        Thu, 04 Jun 2026 12:42:35 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm4360772d50.6.2026.06.04.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:42:35 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/3] net: ensure SCM_TXTIME delivery time is no older than system boot
Date: Thu,  4 Jun 2026 15:41:03 -0400
Message-ID: <20260604194221.3319080-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
References: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-295410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 189A6643037

From: Willem de Bruijn <willemb@google.com>

Limit input to sane values to avoid having to add tests later in the
kernel hot path, e.g., in FQ.

SCM_TXTIME timestamps are converted to signed ktime_t when assigned to
skb->tstamp. Avoid having negative values overflow into large positive
ones when again used as u64, e.g., in FQ time_to_send.

For CLOCK_MONOTONIC, only allow positive values.

For CLOCK_REALTIME and CLOCK_TAI, allow equivalent values, i.e., no
older than the boot of the machine.

skb->tstamp zero is a special case signaling feature off. This is not
converted between clockids.

Handle the special case where the realtime clock is set so small that
real - mono is negative, however unlikely in practice.

Ideally we would also set a sane upper bound, but that would require
reading the clock, which is an expensive operation. Continue to defer
that validation to users of the data. FQ already does this.

Bound rather than return error on older timestamps. This is the
existing policy e.g., in FQ.

Signed-off-by: Willem de Bruijn <willemb@google.com>

----

Changes
  v1 -> v2
    - remove spurious semicolon at end of switch
    - remove Fixes tag
---
 net/core/sock.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f362e3ce1efb..635d8f2f7e2b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3041,12 +3041,42 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		sockc->tsflags |= tsflags;
 		break;
 	case SCM_TXTIME:
+	{
+		ktime_t tmin;
+		u64 txtime;
+
 		if (!sock_flag(sk, SOCK_TXTIME))
 			return -EINVAL;
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
 			return -EINVAL;
-		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
+
+		txtime = get_unaligned((u64 *)CMSG_DATA(cmsg));
+
+		/* Allow sending without a delivery time: zero special case */
+		if (!txtime) {
+			sockc->transmit_time = 0;
+			break;
+		}
+
+		switch (sk->sk_clockid) {
+		case CLOCK_MONOTONIC:
+			tmin = 1;
+			break;
+		case CLOCK_REALTIME:
+			tmin = max(ktime_mono_to_real(0), 1);
+			break;
+		case CLOCK_TAI:
+			tmin = max(ktime_mono_to_any(0, TK_OFFS_TAI), 1);
+			break;
+		default:
+			tmin = 1;
+			WARN_ON_ONCE(1);
+			break;
+		}
+
+		sockc->transmit_time = max_t(ktime_t, txtime, tmin);
 		break;
+	}
 	case SCM_TS_OPT_ID:
 		if (sk_is_tcp(sk))
 			return -EINVAL;
-- 
2.54.0.1032.g2f8565e1d1-goog


