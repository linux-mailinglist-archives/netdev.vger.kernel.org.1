Return-Path: <netdev+bounces-277923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPzTHawY3GmeMgkAu9opvQ
	(envelope-from <netdev+bounces-277923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:11:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2F33E640C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 222AA3005173
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09CB31F9AE;
	Sun, 12 Apr 2026 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FOINCqfs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0B31B828
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031892; cv=none; b=gKetZ2VdYMSrRAbkmbJuvio2ujL5m8FMPGyRw6KOAwT0dQqT5WSffv/Ckgg9bQvo9RN8HmrG+GU79IufPWoMZUfXSu2iVOztEXHQLQ8SrDB1g8iHm4QEOArR94hdZth4TaeTP8cnxpy0tmdAnAEcNQuRoG8LlRU8ZU6PL6/Hbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031892; c=relaxed/simple;
	bh=ACqNhFI1MIObwQ/zd6HM9xcvvKsYhBMBSXPFUz3+sTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM58nrCPr2NBMs2sOa+l5bFMTfVsn9XjSJvlhMPPjLLGos7jWGUVLqJT6Icd0Q4bZNaEYka1BPY5iHpSXYhYEcVQeAqmk/gzu/pkFrurYqS1+1kTeCSsVCQwwOZ9BohGZwUiwUP3cWF33+VDA5QxM7e3/o1x2qz/Un41dlNXK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FOINCqfs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso29943085e9.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776031889; x=1776636689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muzoXm04O/nZwIVSr5NGmunmg9jfR4kefxQYyd7+9T8=;
        b=FOINCqfsCXiG7EygCVOSB5qtFMSZ4WTWutT6GYKM43aokGnqjS7Sp3CTvQavn/JFGE
         TAnkLT8xQCKQ9Yr7Eq9XnLSCXul71q27xz1se9JP8MyQS7OAlMIx60kO9RRJDkO5cK1n
         TjcXUcLzB4CS+Beu66Z5jGRFZJJsPdybv8QZDU5nYxtwCx51sJFQs2k6bix09uNxxkwQ
         KpQvlEZCoXj8MHYRTkv41y5JfOPwh569uKiG7FhMY8jcDNw7js9vpmau+OSqpJxbH8VS
         JJI0nTWV2RL5bugDNWw+s5QIas9p2GjKipm5kvMh54q9nBqzwQDXlQpZTRe7Iv3uOR2W
         Fo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031889; x=1776636689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muzoXm04O/nZwIVSr5NGmunmg9jfR4kefxQYyd7+9T8=;
        b=F7Zn2Sm00tUID5/9KN7vJfbAX4jmcFgvZA5XsgORhi3SBdLcZKXWYjVcVZN16qYABz
         hPAoYuvCRKVdyWgWmE9dcsb+KEOFqNJzmyxJeRDPS6Q3dd840Wz74/x6wNDeX+IJaBpd
         aFj0V58+kcb/gKZ6izgssq09p1i0THBq3JcAOJLBhLfENxnwTeLNpxF6OpB5QimrVxKl
         cliINf/H9vnZ+ooBoeAWmxxPk4hV36hSYXXoQueZ/PTrOPlDychMItFFBs+wwM+X07H6
         H83Yh2SDv2ysqXvpvrFGU4gqpIjIMrYC8ygCvkPxbXriqqGWMg6xwuEXCw8A+uZBtZgd
         WjzQ==
X-Gm-Message-State: AOJu0Yz/F4np0593tD7q1iKbezUAacsiggG63xnG7c53vojAa1x1kYsJ
	Ke876EsacJqZHnytjd1fZ7Qw0hcjCSsUxgCEYgo7UoqfjXAo4Huu/A6zmkI71ebYjtVhFV71uvC
	uDs90J0YxmLGxQWogUktiErZ+0MNLEtiFVZpzgfOj4vlemh9mnG6NxFYGms+jdDtI
X-Gm-Gg: AeBDietLCYDThI9gCPtrmyBsihAF3ZXy+YiyxtGxYOVldfejqFLD0w1mxwTIi1XqlCy
	Tp9ADUmhxOJCoIEGBsGwrB27MHq6ljhCJLpuW2z8IoNrHywRzG+eGvyvYSDauWLCYyd+wI5cPCN
	LMse7ni2/toAGk34ihRhR6sH0JoKNsjEMt+/v0z8mrqOTX0uBIw18eCGNEsCTvamxSek4JBZp+q
	BqmWwAitIxAYCRHgAT2078qCzBC1cIGoqU+dC7QbgGajvejxfJxJgNQFicSWVYU33IRPt3lwPaE
	nvZDAkSWnwiWuW8nyd/bTHIWbslRowLN/mneZs1Mo6ypeF+YCYGKqb4Lj8v9yql2mrVk1ysMdeD
	EmNyEEdmj/YMfdUxowKpEr6Aoil1jQ07iURAnZDq/aETl62blcaCb3SXB4KUhh4pPxi9pEW/TvF
	qeLBxpwLiF3Z/ZmD+mapLbg0KyPrNEzb+oY0Nk
X-Received: by 2002:a05:600c:8207:b0:488:7a24:9ddf with SMTP id 5b1f17b1804b1-488d688dd31mr144761635e9.28.1776031889564;
        Sun, 12 Apr 2026 15:11:29 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:e36b:fb32:ad41:43a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm84910805e9.2.2026.04.12.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:11:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/5] selftests: ovpn: flatten slurped notification JSON before filtering
Date: Mon, 13 Apr 2026 00:11:19 +0200
Message-ID: <20260412221121.410365-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412221121.410365-1-antonio@openvpn.net>
References: <20260412221121.410365-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277923-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,mandelbit.com:email]
X-Rspamd-Queue-Id: 7C2F33E640C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Notification comparison uses jq -s, which slurps all inputs into an
array. Some inputs can be arrays themselves, and applying the .msg.peer
filter directly on those entries triggers jq type errors.

Expand any array-valued JSON items returned by jq -s before selecting
.msg.peer, so the filter handles both normal notification objects and []
entries without type errors.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 336a2a14285f..dd562cc41b95 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -15,7 +15,8 @@ SYMMETRIC_ID=${SYMMETRIC_ID:-0}
 
 export ID_OFFSET=$(( 9 * (SYMMETRIC_ID == 0) ))
 
-JQ_FILTER='map(select(.msg.peer | has("remote-ipv6") | not)) |
+JQ_FILTER='map(if type == "array" then .[] else . end) |
+	map(select(.msg.peer | has("remote-ipv6") | not)) |
 	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
 LAN_IP="11.11.11.11"
 
-- 
2.52.0


