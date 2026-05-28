Return-Path: <netdev+bounces-292548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPCzNZWyF2p+NggAu9opvQ
	(envelope-from <netdev+bounces-292548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:12:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 512755EC1E4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0DBD301A521
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBAB2EE262;
	Thu, 28 May 2026 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Z84dXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909425F7B9;
	Thu, 28 May 2026 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937930; cv=none; b=tqkO0FVhm8V8CXLbVqf4cOb9B+aGaJ9pdlYMyf/CqTwZdyWGvSVDjL2/JZODnvCwajxB/3ji4b+KHVRuRQgvC+5xU+Caaea4re6q0zx6MGUx17sj2TiPujSWGARL8xJYQpzD6uFR9bcRcy7y2YjHsxGdYzw665uFXG451Bkx34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937930; c=relaxed/simple;
	bh=x5lvd2WieVYFnrOyxhQZQmbBnp68/R28p7d+i8k0jBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYEyRHYA2d9LUY9K5RC+UVtV8drc4MrReeMDQVLUoIFdpAvtTzBWPEkQQiwkDCOHvs9Qcr6gO2Za8Rian2b1K+kDQrFSv+wot2ziN7WQ3VoCO8c/looyxdGfaGBQ6OvOapMWA4Re+EkV0I+dfKEWA2tjuFnh+iNu0hhHjkBx//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Z84dXJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3841F00A3A;
	Thu, 28 May 2026 03:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937929;
	bh=1BY3fIUX8gmKju1y5veWjmaxgiak/EkCD3JD09YnoAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5Z84dXJwZHwM8LCJ5dq+U73AaYLFztuK9cmtaW1jlZREj3nwjCvjF4sShtwV6O6c
	 Tgg/MlMajgZi2b7Cz3+wrk7OYrR2evwR0/SOlpJADHsMpjdwHsqukan7bDUai5ugQn
	 tfEVkaoSmzKeEcts1aAQ1qtgXax1E/XYsfuobOUVSFYy+KLG6C3WzbtPIWPWCXPRSs
	 +1bmlYKcq+Igioln952z7zpRSMDUXV9HylVnUoOpHKcn9a8cbY/1mGWxRTelKQCZX6
	 foAOTqjNORZ9N6/x7IIsoMGE05f4cvb0PfOLCs9/NT7Ht3CvL3fxP3CEYYtoCQL6tj
	 TdqI0kPFMQ5xA==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 06/11] nvme-fabrics: compare transport in ip_options_match
Date: Thu, 28 May 2026 11:10:40 +0800
Message-ID: <148800f6002bae1448d8dfc279f2e22f0851ee03.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292548-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email,suse.de:email,purestorage.com:email]
X-Rspamd-Queue-Id: 512755EC1E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

When checking for an existing controller, nvmf_ip_options_match() does
not compare the transport type. This can cause a TCP connection request
to incorrectly match an existing MPTCP controller, or an MPTCP connection
request to match an existing TCP controller, resulting in a false
-EALREADY error.

Fix this by adding strcmp(opts->transport, ctrl->opts->transport) to the
matching condition.

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..e086e61e8f94 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1220,6 +1220,7 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts)
 {
 	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
+	    strcmp(opts->transport, ctrl->opts->transport) ||
 	    strcmp(opts->traddr, ctrl->opts->traddr) ||
 	    strcmp(opts->trsvcid, ctrl->opts->trsvcid))
 		return false;
-- 
2.53.0


