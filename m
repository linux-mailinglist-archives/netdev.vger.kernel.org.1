Return-Path: <netdev+bounces-284958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOiKI9Zy+2m7bAMAu9opvQ
	(envelope-from <netdev+bounces-284958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236E4DE76D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8508D3023DAA
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2E4A13B4;
	Wed,  6 May 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+PI/FTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38985496903
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086572; cv=none; b=jkZw8JDIsavZuScHcA8diEAcd6Tf5wlE/t0y2WrUOqpKQP4vURPBxtfGDDDBeMtAoA3BHXykbF02ikfPmPcARCfDnyprt2KkqYRVqqXDyR9JvjAWhHpz/vrpxoUbJpoGmI/7mvvH3H1QoMUi+gImoy+I/C3uUI+OY8UYz784oAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086572; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgvKlTrSh3y/aGPAo34hgb/oN8aQmoYZkqMJ1p3s+dDpDSr620uIB4DH2nrIcNJ5phb9MeWze56CEp2ZDj8XsuFHzZOe8F47nPsQUYTG0zts8YWbxcCDKFJHEUN8jb91kAl6AVSYVUloW1zLcX7LQ2agcnSsse9ZZJ0G4DQWhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+PI/FTU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so27585585e9.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086570; x=1778691370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=A+PI/FTUXcn+VK+c28ZUR6274a3siqbD9VaqcGQZWAQjDixg4v2tXISQSHdK4motUb
         mFCKEYqrI4tKethpHD+diArLnHYZyNm9rnYdIJF6tIdsxRPh6CIXJkuadAAsqPAhweUL
         Ha8YGtrFBsmWM/nGJopGnD4cWFJGLIsJwgtNJ6Ig8ObgOi+vM1jR7upCeWgI1D3noAAC
         KtBFIIOGwsI9EuiRnzokQQjg2TvV51wgvg7FDf7yF1T0q4TwIguBuqJymh+F5KxG0+D5
         expg5HaP4Z1gvjfJrhZ70H1L5oiOroAmV4oo8sRYn9oru33P3/fRrpNPwAFUPfVWyhER
         KIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086570; x=1778691370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=k6wvTuFG0pIDY3gSUN1QuPNzy+cc0i4m2vQwp1dWc1beNu3tkH/grS+HLprQk3gDzG
         K/bwVnwX0s6++9y9tUQvWe5z3kr+p/79u+nPngCn+VqBizgo32nv/3qRGB4oYWaWs3Ge
         1LY16U81KIi/H0BjA3DLSJEdy3unEhOES6ofo6ZT56Fe8OFh/pKIVT+/HAiGvjShH8ZN
         2wp8+fx3F1IWumMqJej5EmoPQVnoWHbn2PeOjO/eYhAhyomwKy1uOFb0q8i8nO3nicGy
         zQuj1QAWg+envsxeG4t+eaW7K3fqBUkdDlMBEEvycsEwLGirE6J3pIdM8JS2fgQTuOs+
         OC4w==
X-Forwarded-Encrypted: i=1; AFNElJ/HvaZAqrzn7GR3bBTMRuaQl2RroDyaEdbNlsxhJkIWOir45HqLh7MKHCdKFE1rf2EVnh7S5ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu64OG8rH5jgwGjpScU+fYpARcjYOAzUZXyd8g9mlFXzxrI0S0
	PnsPRhFxk8Kjsc5L7AZYGURYKIdXLzfAqybwa0scTH64y4Hru0EBn8MpH3oK3QfbMsg=
X-Gm-Gg: AeBDiesVuUAcMTJkTd0RXPwXPUYDQkoxLClv5PXzIR/MFU2BdRAsJ5Pvk1U+KUl2klh
	Bu+Pr2Eo+A/WCNTd4AodB87+O1Ikz3Hf70XTKJ7PMBs2Eg7Js2sHhWo8umQvoZKGPkhhMyQnYs0
	AAa1Jx27gOixgS3nin/lV/yrcI/Mulh4iQtcGrbHKUYt6mCGnuAKAaV7boh98IwJ3KvsNo32bDu
	ttIkQNJKfBiYhFPz5Lo0KIiYsZ7sBHxJJakPVHjIzeyyCzFMqVcywF2eaOBiMyxlyXHrb+2Mgdb
	RcVbbPbeeKdp3RqQ0UTq1GoJ2fg++vPkRJly3LW6UpI3UJ/H9sg1BZvEiPMOpuXugooi41SqVF2
	s6B+QeDA3+0Dz6Boc5eMTgkPfgawP0qPZ0I+mACzTO1I9L2ArrieA/4J0K2Em+gAnYABUWbJKmS
	VYMI1ERGsh0Nji9xCWTFq+VvJYyVM7cDaffDEBGvFvDhfNcKvWsZFj2m2mZfnBRwMqq6EQjnaKQ
	V5wYlViiHOM4FR1nfBp0Q==
X-Received: by 2002:a05:600c:1c26:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e51f5c282mr75087035e9.29.1778086569660;
        Wed, 06 May 2026 09:56:09 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:09 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Wed,  6 May 2026 17:55:56 +0100
Message-ID: <2ca2480bd48417c6074f07728323a63862fa59e0.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5236E4DE76D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284958-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Exercise setsockopt/getsockopt of IP_RECVERR and IPV6_RECVERR on the
MPTCP parent socket, including the empty-errqueue EAGAIN contract on
MSG_ERRQUEUE|MSG_DONTWAIT.

End-to-end errqueue delivery (ICMP, TX timestamps, zerocopy) depends on
subflow-side producers that are out of scope for this series and will be
covered by follow-up work.

Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..95bb2cc8e2ff 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -769,6 +769,60 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_ip_recverr_sockopt(int fd)
+{
+	struct iovec iov = {
+		.iov_base = &(char){ 0 },
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int one = 1, zero = 0, val = -1;
+	socklen_t s = sizeof(val);
+	int level, optname, r;
+
+	switch (pf) {
+	case AF_INET:
+		level = SOL_IP;
+		optname = IP_RECVERR;
+		break;
+	case AF_INET6:
+		level = SOL_IPV6;
+		optname = IPV6_RECVERR;
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+	}
+
+	r = setsockopt(fd, level, optname, &one, sizeof(one));
+	if (r)
+		die_perror("setsockopt recverr on");
+
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr on");
+	if (s != sizeof(val) || val != one)
+		xerror("recverr on mismatch val=%d len=%u", val, s);
+
+	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+	if (r != -1 || errno != EAGAIN)
+		xerror("expected empty errqueue to return EAGAIN, ret=%d errno=%d", r, errno);
+
+	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
+	if (r)
+		die_perror("setsockopt recverr off");
+
+	val = -1;
+	s = sizeof(val);
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr off");
+	if (s != sizeof(val) || val != zero)
+		xerror("recverr off mismatch val=%d len=%u", val, s);
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +841,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0


