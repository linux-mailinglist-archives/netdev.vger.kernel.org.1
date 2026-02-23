Return-Path: <netdev+bounces-260223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHakLQDQnGllKQQAu9opvQ
	(envelope-from <netdev+bounces-260223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:09:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514FB17E01B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4874F30A54F4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA97378D64;
	Mon, 23 Feb 2026 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xaTN2/xT"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F435294E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884155; cv=none; b=M5iShRkq3EH6I8GXBaM9X+jtTC9Tt6J72eNYnyjoHWd3OShj6R73hwn+kYCpj8VMQuAQ1tuqVYXrdXOybekzQgjzEwqhdL8H5ufA6VGlS6/uG+JsahCdpbdZavVitfQbRgQ9PiGvXUvGEZ/72b6hxQyzCvgEiHIxSIwxG36iw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884155; c=relaxed/simple;
	bh=nPFa+DaruW2SFnGWq2pXxl9db3bpEKOvPVb2kScJ7j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT50BoZnjJoi/ww1dc5QcudI48ilwjGkQTOrxjM5nQxznO4EX6Xc3RuJ5H17iLaBwEE9I2b2YEhMrtbv+mjo+Iiw83UVU8j4Vbxfx4v+WxJwGwjMjpqraMR9yi9c+r7ADd8A2gNCUqQAjJ+nMfpCyLvhGG6/5ka3WTMpPuFPiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xaTN2/xT; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsR9dezXZFX0ROhQ/bAFuXWz6GOBnMZu01MKdxvJYXA=;
	b=xaTN2/xTV8C1Qp0WiEWrZ8PEgCWIeeiVxCJtwA7dO+avBO1TMM/QMrbDBu/oCDNFLlBAWU
	PCzFmK6Tlc0fPO1XyTZqGH91b1nUTOSompfgQK1V3/hf1n0fa43L22xOuYnsoEOkHDFnf/
	4K1kQDV2h8C6BZ4LaHV3PBpBv3ECUh0=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	netdev@vger.kernel.org
Subject: [PATCH 20/62] octeontx2-pf: Fix locking in an error path
Date: Mon, 23 Feb 2026 14:00:20 -0800
Message-ID: <20260223220102.2158611-21-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260223-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bart.vanassche@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,marvell.com:email,acm.org:email]
X-Rspamd-Queue-Id: 514FB17E01B
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

Only unlock pf->mbox.lock if it has been locked by otx2_do_set_vf_vlan().
This bug has been detected by the Clang thread-safety analyzer.

Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org
Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management functions")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..8c9f08ed90fd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2588,7 +2588,7 @@ static int otx2_do_set_vf_vlan(struct otx2_nic *pf, int vf, u16 vlan, u8 qos,
 	config = &pf->vf_configs[vf];
 
 	if (!vlan && !config->vlan)
-		goto out;
+		return err;
 
 	mutex_lock(&pf->mbox.lock);
 

