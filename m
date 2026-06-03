Return-Path: <netdev+bounces-294884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xueGNFx7IGqb4AAAu9opvQ
	(envelope-from <netdev+bounces-294884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2E163AC1C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="PlB3wvP/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294884-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AE0F30E4E12
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24835B644;
	Wed,  3 Jun 2026 19:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131331F986
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:02:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513371; cv=none; b=kmijWl9/ieHUVEjUiQRwLl80vP+s2U3StG0I/TlLnt3WP6YNmvn2eZl29yGyg/R7zSP7toS5+QopPFp6firqSnfR/qd6wnqbF0D8u4Fge8zcXb8su/9TJzx34tV6OWEXaXwZhxnYJvLx6jx0IEB1f/qvTnqZrCyUPSDasoK+0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513371; c=relaxed/simple;
	bh=aVGKaPtFUH/Rof/ivHV29vM8CafgJ+NHADRqHFp5zLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJCNoZO1tuutD8Cp3akkk3ohEkUrva/YfZ3qIVAxzqCLhvpaT1BRJjFg9F4NlVlkefkySfnNBxouYg69mPL9ixIDzSJhIepW/JI0aBlZnmN1FVuT4C903iVorRpXDHEMucnBIu6F7VF1MiL0eXFLyM/7dKIVb3BVSZzrGT5L1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlB3wvP/; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dbcb505578so79837477b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780513370; x=1781118170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKeJyPb+u8/MUCiabIYpuG6X8kzxIOQHsYa/HqPJEFY=;
        b=PlB3wvP/YRv8pzkXj6IWBWZTCtT2sDGiFGDPwFfQBVhUKWs7GS5hmxCfHWM4TKgvBH
         n+VFZub8tgZCeooi3Tc5odLJg16UsdhUjqC8QscistMP5WJw7RC8lykb2Sa9Y85R9hQt
         EiT8pX/++yZp1GYGrGfs/epBEe6O5TAnqPw8HZrCIGojVPwUNtaWqf5igtDsPqoeJOC0
         s+/AteGzX4vtLl1VPUW16KwpvOjwRzEFQXycBRHPQP79Yn7KF1ICDH6KOV11w+5qUyfB
         72CCZUp/8Gs95Z2fjt1Djw3EDPM9xCVH8QLrei7bAk9rsT/gWcCJTtKnZfqsY6edFXnL
         QOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513370; x=1781118170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKeJyPb+u8/MUCiabIYpuG6X8kzxIOQHsYa/HqPJEFY=;
        b=Ls08l8ExyrPV5/u84xP8zfvgJ2uGQB5htykt3KmaW/P6M+2XssrTXqLM9akfI6EgYY
         gJPrweT2CQMCzQt19XimEYUjezU/t+dWkDgy1AhIs9tJPHtPwc6MgG5B7DeanzUEtIPl
         Rp2BzRX0QJImg3i2nwaaqoahyIZXVDlYwqGYeuA3Dtvsv1m20QgCLaSWxB2dASUV4weL
         47lFED8BRBI4ekZy1Rvs4AcQJuOms91wKkKotpfvoM6g2mvT5MusTSMLdDhyB9336IQ3
         b7qsVx7diVHSptNyCw+58AWuYf/zsmfavSh7E+ktOTsrWYLBLJkiizCecnOcsATgK7gB
         5A3A==
X-Gm-Message-State: AOJu0YySH+jRwT81LYO2Rxs/U4/DcyodVqUkIjU1pSoYMTjvgNT/JW+A
	MdtdrZCE56ZifStFCB7jbdAPAf0DqFlb0zOVC5iHqOoduSWLAPRPQF0GNbUZ7Q==
X-Gm-Gg: Acq92OFZICSRVqOM6p70+6a55yW3/gfaTjTyqyeQBVc2HtZ+CYaaiheUE4SyYQf2DRe
	qYTj9T+Qi69R8BxewXvIf6xMVr/L60Malgm8AMDMBQEk9HChx8VvjPTIwJYIxQ/FTB5nwGocJ03
	4u05fiZkRzma8L05Q0n6Y2jvJBs6Xf63+e6D38hEOG4PMQEby4snZWA0zXHcD35Fwu1mRDgDZxK
	fwOUfveEU24BaAta3jL98ufFY74gtMfMV8c9yjq+Fo/AajIRzbHxkUuN+P1krahchv8cGk0LqhX
	GgTg/WqlTiKktjw++Y5F5F1yU9IiUjpgNiDXFu14oRRkIOVttzUSIwEVzftC10WZ6av0E47xn9E
	nPtN4mLSN2+S8zh1Uu1UmVrSOK7I7TtXKpwkhof1+39iNqciYRyBzeNCK8hQsX2y8yBec4gyeuP
	c27Z+LrgeAlZvlZSpk2NW3rFCbnbgpIVuBdHJdGxpDTpjj/d2TaCoXThum1LLr/hahPLlE/Hm/4
	zZrWgPUFN/guEqFgzlhRKC3rxSUe8DSqzajrzVN
X-Received: by 2002:a05:690c:b87:b0:7b6:f4f:f057 with SMTP id 00721157ae682-7ea4c1b7868mr43175187b3.24.1780513369603;
        Wed, 03 Jun 2026 12:02:49 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8186sm22350467b3.4.2026.06.03.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:02:49 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/3] net: ensure SCM_TXTIME delivery time is no older than system boot
Date: Wed,  3 Jun 2026 15:01:28 -0400
Message-ID: <20260603190243.2789335-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-294884-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A2E163AC1C

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

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/sock.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f362e3ce1efb..dff48ef49a8c 100644
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
+		};
+
+		sockc->transmit_time = max_t(ktime_t, txtime, tmin);
 		break;
+	}
 	case SCM_TS_OPT_ID:
 		if (sk_is_tcp(sk))
 			return -EINVAL;
-- 
2.54.0.1032.g2f8565e1d1-goog


