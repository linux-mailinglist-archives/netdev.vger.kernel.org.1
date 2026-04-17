Return-Path: <netdev+bounces-279377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DPnEv1l4mlm5gAAu9opvQ
	(envelope-from <netdev+bounces-279377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EA41D5DD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DC6302EEBF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3C3451BD;
	Fri, 17 Apr 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RhBapEvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUn2Ljql"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3235DA6D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444627; cv=none; b=b9wqAEcBCsazv6CDawiKbQQRixbG3c8BfS1xnzXloX8fcgn44GM7htlbCbav4jnnlURjUsRnsiVH5TnfCu/qsmrVp61mkqWzfQkMErIVq4EbfnYjlkaEVbWC97S0xY5OGGxru8ziwdHftyapYfg+OhqIj4vBcibFjcQEFs1fTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444627; c=relaxed/simple;
	bh=+WbumWtECJKJPMmQTmB9HMHeZNvye+Vx4KZuN12wWNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPHC6fxodZn26kP4NKxznXXx6SdOIrgCRiCqaTuOPTSaacZf2gnJZIKGHFL0mzPb9/Ycn0aKkpzIBc2ZtemLF5oWt4jIf0u7RPU7/Q77NR7Pxln+Q/2p/Lq9XDxEpk4kGGQ425YOuI3SPa7s357kCPDRA5/AfbRu0uHqiaiGUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RhBapEvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUn2Ljql; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F4451D001F0;
	Fri, 17 Apr 2026 12:50:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Apr 2026 12:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444625; x=
	1776531025; bh=sfolPV9EMV94lmc/rlHo4Dz7g+Mbfi76yLS6TsnoZW0=; b=R
	hBapEvvn5filC9TlLR29Ij/evgnIMeJ37M8PGDYichd9gAgbTStsT/R6n6ggwKbW
	BfS4hukbT+rsw8b+SCdMrLY3IsSldfSuGYnTHoZ6f7MuV0UBvyDcA6k/DMaQ8Nyz
	0k+cCKmmPwFGd5oOEwyO6vCIN9oWjCuy7EubzsaKVUg/E4NVD/Ef1j1t8Z5eY24/
	nwfs+hPvKqDcvAFc5HnWJVRYN0ehJP0z8OFoJsWtvYROuiQvzF6hTxZEds55XskK
	fM89kjqRDW7PDofSo4huWF/QM4MfUzGjb5M3dUtjmhxDPTNPD0ae5QvAwcv8e49m
	oBHGfz/gJwx8vuQwyyzyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444625; x=1776531025; bh=s
	folPV9EMV94lmc/rlHo4Dz7g+Mbfi76yLS6TsnoZW0=; b=hUn2LjqlAqCVVf1vk
	zIQEcG+566/iMqnnNlJ6lWZslkVnMv7P+uof9D4myGpZilAjZClFywENqPzB4I43
	IK1dobPqHo9p+aAbLzA5UFf09iO27Z0DvLHGBvwqIciHCiAd2+TkO3FdBXz/lseg
	vUN2gsPzuMWf+YwYp4OHG7TksLQgq8f/emyfaF0Au1PgfIXmiHfPqkDi76oVHUuf
	4iBlO5qgHc3uyEuCvUhoRc9EcuZYDBYfAdgGkDRsjFLcxBFD8srSrmZD4oKzkydW
	EaQJf+P9BOA3uVGrDD03+VMopg//zeb85x3cSuSSQHkQi12mkiO+UlEb4lRAP15s
	ipEog==
X-ME-Sender: <xms:0GTiadfuigk0K6Dy4d8f_qKL4vejxmmUQYKdY01IiEvcK6DUUBr6GQ>
    <xme:0GTiaSOcH-YlSzIq-T2NIYV2pVQA1gjxccwHeZ14UPbicqZhQFy8XT79h_CtUxtu_
    ph7xaqUYSRsVsMRj6N-sGppcAalXdrRUepEbK3ZewOBysPbDthoog>
X-ME-Received: <xmr:0GTiabj66hk2u2zggvL9OQSCMe_KmMUFjfVc3Pw7YkEJ84vrVVpCRivE4O4pp8AsBbm2zC7m7SsU9H1SBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugif
    segurghvihgufigvihdruhhkpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0GTiaV0eDrGrDyJ973ZLHa85o9Jio8jIC5PHQy17ZpYhUP64ve5xfg>
    <xmx:0GTiaVixR2NPPNrRLzxXzaTzfl187o-tkOzGmYFDqKD_c_TqRAQYXg>
    <xmx:0GTiaVfgkcqf7quZNlvl0vGzG489w1tRdPh7Exc7K4KtRRYXCmy6iw>
    <xmx:0GTiaYnCyRkNB1fXiU73k_Ux6Y6WoQqgmSyddOildyXMwGdmCdNrtw>
    <xmx:0WTiaaT79zWDnFjy-f1u3o6ttvHc2jk4NVZ9Tfz2pBstPqErQemsaavO>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:50:24 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 6/6] selftests: net: add rss_multiqueue test variant to iou-zcrx
Date: Fri, 17 Apr 2026 09:49:52 -0700
Message-ID: <0b116e438eeed6aad77445a5d477c2298f096d1d.1776444379.git.juanlu@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com> <cover.1776444379.git.juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279377-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email,fastmail.com:dkim,fastmail.com:mid,cfg.target:url]
X-Rspamd-Queue-Id: 743EA41D5DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new rss_multiqueue Python test variant that exercises multi-queue
zero-copy receive on a single listening socket, where the server
dispatches accepted connections to worker threads by SO_INCOMING_NAPI_ID.

The setup creates an RSS context spanning N receive queues and a single
flow rule that uses that context, then queries the NAPI ID for each
queue at runtime via netlink queue_get(). The NAPI IDs are passed to
the C binary via a new -n option so it can map each accepted connection
to the worker handling that NAPI's queue. The client spawns more
connections than worker threads to exercise multiple connections per
worker.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 59 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index e81724cb5542a..896376b26e01a 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -29,6 +29,12 @@ def create_rss_ctx(cfg):
     return int(values)
 
 
+def create_rss_ctx_multi(cfg, start, count):
+    output = ethtool(f"-X {cfg.ifname} context new start {start} equal {count}").stdout
+    values = re.search(r'New RSS context is (\d+)', output).group(1)
+    return int(values)
+
+
 def set_flow_rule(cfg):
     output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.target}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
@@ -100,16 +106,65 @@ def rss(cfg):
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
 
+def rss_multiqueue(cfg):
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 3:
+        raise KsftSkipEx('Test requires NETIF with at least 3 combined channels')
+
+    rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
+
+    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': 64})
+    defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': 'unknown',
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
+    defer(mp_clear_wait, cfg)
+
+    cfg.num_threads = 2
+    cfg.target = channels - cfg.num_threads
+    ethtool(f"-X {cfg.ifname} equal {cfg.target}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    rss_ctx_id = create_rss_ctx_multi(cfg, cfg.target, cfg.num_threads)
+    defer(ethtool, f"-X {cfg.ifname} delete context {rss_ctx_id}")
+
+    flow_rule_id = set_flow_rule_rss(cfg, rss_ctx_id)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    napi_ids = []
+    for i in range(cfg.num_threads):
+        queue = cfg.netnl.queue_get({'ifindex': cfg.ifindex,
+                                     'id': cfg.target + i,
+                                     'type': 'rx'})
+        napi_ids.append(str(queue['napi-id']))
+    cfg.napi_ids = ','.join(napi_ids)
+
+
 @ksft_variants([
     KsftNamedVariant("single", single),
     KsftNamedVariant("rss", rss),
+    KsftNamedVariant("rss_multiqueue", rss_multiqueue),
 ])
 def test_zcrx(cfg, setup) -> None:
     cfg.require_ipver('6')
 
+    cfg.num_threads = 1
+    cfg.napi_ids = None
+
     setup(cfg)
-    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
+
+    rx_cmd = (f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} "
+              f"-q {cfg.target} -t {cfg.num_threads}")
+    if cfg.napi_ids:
+        rx_cmd += f" -n {cfg.napi_ids}"
+    tx_cmd = (f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} "
+              f"-l 12840 -t {cfg.num_threads}")
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
-- 
2.52.0


