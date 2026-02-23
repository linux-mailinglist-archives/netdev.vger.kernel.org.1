Return-Path: <netdev+bounces-260084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBi7HkZznGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:33:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5929178C3C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B5830804DA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42BA2EBBA4;
	Mon, 23 Feb 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGRmqmhn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A2EB856;
	Mon, 23 Feb 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860682; cv=none; b=TQuWYnFNg9aYk7Dv1cXbvg8qbrwPY4yMNpp7GV2DNUjS4KQIuzRbVa0DLsUJfMjZqgSlhnSY7DxVI+J2YITBwh+4dU/KgLj2dFMXTX3CohCvzOLT+TH+2wusBc36dZ8Y4YNJZu851D5nVDHdH0UWYkI/X3lK8s+Hvwfg9OocBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860682; c=relaxed/simple;
	bh=asIr6HoAWgEgFuiqGCFTBNTg4dHGyiVNQ+Sg3mqF0j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LM2i6/qSV8BpDexBsk8mdyj8/9iHkMzlsPDUGhvoDIYMH/hddGOIWvoebqNpkCrYCVh4RF+l/4Q4vsfjFYWcIj1DEbCwVstaDEr83+mxAGpfMqVkwvWtFVe1IvqBoZuCIRg/At6klczNTlKHCi6X6v24qlCdZSCWDaXwU5D+32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGRmqmhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E605C19423;
	Mon, 23 Feb 2026 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860682;
	bh=asIr6HoAWgEgFuiqGCFTBNTg4dHGyiVNQ+Sg3mqF0j4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGRmqmhnOOdD80BaRp/I4lfutkLHmXko8tJNjSySshSpNIrfUbYviQ4FYVNdumi5C
	 JaC48nMQ+FneQeeozs0gj3EprvwFmIh4tSIwpF2tME7XkXBB6FCVro2Ox62qfTcnYz
	 o7ymu5gVUO6bU8oQ55idBSG32zLbxpCF5bqFqiKgcSGPYzN/8ebE4Aik1VNUof4Yox
	 bcu8c1mz4JvA6gkg+eqhV9z++zlH2OV4xANtWuLlJbIpsL1iEV5zaiuIukupN/RhYf
	 5TEFjD559d2lnH0rQ+/6yOdRbEGZS/WOR1yBB8xQ94fNHJwVAcweSh3mHxgZJy4L1x
	 C0NzBM96p2K6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Feb 2026 16:28:38 +0100
Subject: [PATCH iproute2-next v2 1/3] mptcp: uniform stream closure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-ipr-monitor-json-v2-1-f91fccccf917@kernel.org>
References: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
In-Reply-To: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=asIr6HoAWgEgFuiqGCFTBNTg4dHGyiVNQ+Sg3mqF0j4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLnFB3rmHxjvscM2U72CbMvFPMJBy65ZWuS/eynqpX2q
 +TC5XH2HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5W8TwP0Lm96dr95/H7rsV
 f/ZU7Bzpa58+M5/+/iBPvWT/w/7t7/YxMiy/zKdUVfPyZpMc+0tfIdcDM89JTrlyxacjdWrJrWN
 TkzgB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260084-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5929178C3C
X-Rspamd-Action: no action

Use print_nl() instead of print_string(), close the json object, then flush
the stream to flush the end of the JSON object ASAP.

Note that in print_mptcp_limit(), the flush should have been done before
closing the JSON object, but because there is only one object and the
closure was done just before exiting, there was no visual impact.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index ec9ef62a..18ec05a8 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -273,8 +273,8 @@ static int print_mptcp_addrinfo(struct rtattr *addrinfo)
 		}
 	}
 
+	print_nl();
 	close_json_object();
-	print_string(PRINT_FP, NULL, "\n", NULL);
 	fflush(stdout);
 
 	return 0;
@@ -426,9 +426,11 @@ static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
 
 		print_uint(PRINT_ANY, "subflows", "subflows %d ", val);
 	}
-	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(stdout);
+
+	print_nl();
 	close_json_object();
+	fflush(stdout);
+
 	return 0;
 }
 

-- 
2.51.0


