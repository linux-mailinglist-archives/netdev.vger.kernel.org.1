Return-Path: <netdev+bounces-252650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIjgMx8cc2mwsAAAu9opvQ
	(envelope-from <netdev+bounces-252650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:58:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 539FD7147E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82AC3018754
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099233E347;
	Fri, 23 Jan 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoDBF9u8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA333EAEB
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151504; cv=none; b=O0RthI/XK04VuWrniUg9yPRRHmuA7ONhMTONVIml42kitUZLBmTbDzAO8oe9/LO8Vv9h+sPk1n32D/p5LdOPo54WrmeaOhi3c5ONWWXcAsysaZRbPpVEMIDc0n89XiNuMS2M4sN6dIu8xbLGmFEJckqyDI4eHcbc43CAzgXF00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151504; c=relaxed/simple;
	bh=6+3nZjgoHWSP4ea8zSCT148SAOESmqsnhw6/Ni1AyDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MMg27ydlV+LQuiBIJ1Qv/9QhqZ34QDne83BdvnVWRS7X1Nx2vqJkFhlRQmWl7EJ6ZVj8rpE6b7h3yC5APUOC9aFR542PX+NuII8W0BAzxkXY/qD29J6tTBVDGZilQLBmnZkjDnRvwXx7QZrGQAXsJYIU5XViQ0MU2ZOwmP/aWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoDBF9u8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11b94abc09dso2797254c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769151502; x=1769756302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNuK2/dOALJQhNEGtJ2LlGL6rosoPqMbD+3I0jKBgfc=;
        b=QoDBF9u80vu0mQmzoIz4rihEci5tnb/dSisJw6uUCJOO9UAvRbH8bzPdcTSdjyfBkq
         l6rLfbelYxG0YvWhY9gXu1m8oSb0+kZYoIbTjs0wLosnqjFKXQXXqhC40LNbhnhxPZP2
         1HsySEibF0mhZcp+R6QMzRqWa0ga/pahzhX7TKWU4lHTTkV0Z+LfzzRy2MwhChoCmW3C
         WN+nC5Mp2ETCAJEVfn/e7Hdxu/GSuf/YdnUMJHEnFB42PJYyFq65aNXD3qjU8BQPLYdw
         uyfEf89iIBy02fG2OjrCZ4OotYKzEhmUAL33loWPCfAzfRDp35fTzxAoCGJbwJPBxdl3
         CS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769151502; x=1769756302;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNuK2/dOALJQhNEGtJ2LlGL6rosoPqMbD+3I0jKBgfc=;
        b=eTM7d2zdaq7N8bXflQ4iE9NQ37sdD6DNAG8sXXs+CoaEWrYHFp+XM1Afa9G1CkLWzJ
         gKuFEopXaFoZaGwKruFWOWuTwWE8bCF+mKqdmZyBUbf2bdfg3MYQJh9fVVQdARDXwjk1
         HNOtmJUsiMcXOo0M/xp5tXJUPTE7/M7m3wRBSfy/FiQI2NoMOf4n8LFd68sHegw9S3qF
         SLMRRkaetH5HzTnVVr8MDy3b7MbbFigoiP4+EuuxzzjGtiaQqrVGW0xzTpDS4fw0CSi3
         Tv40/thxKGFUnUucMp5PvJEPuWBIZ/4ZJPA9XvJxKG+C1/V0OwIaLh9cOXVpPvJt/1XA
         Xdlg==
X-Gm-Message-State: AOJu0YyoXD59RPmkhdYxqCZWDWvkGRmAI0ZwE8lqwaRnZlu98VLnJIMO
	vit8HwpN7H1GVn+BWY5ehu5RIROTqrQzFzQ+YNbkkb8oAxseawZ7l8q98dHLNbfCLaxUW9kt8Jq
	lSNfKKw==
X-Received: from dlbuy11.prod.google.com ([2002:a05:7022:1e0b:b0:11f:3ccd:73d7])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:112:b0:11a:273c:dd98
 with SMTP id a92af1059eb24-1247dbb0d6amr858556c88.20.1769151501761; Thu, 22
 Jan 2026 22:58:21 -0800 (PST)
Date: Fri, 23 Jan 2026 06:58:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123065806.3858623-1-boolli@google.com>
Subject: [PATCH v2] idpf: nullify pointers after they are freed
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 539FD7147E
X-Rspamd-Action: no action

rss_data->rss_key needs to be nullified after it is freed.
Checks like "if (!rss_data->rss_key)" in the code could fail
if it is not nullified.

Tested: built and booted the kernel.

Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethtool operations")
Signed-off-by: Li Li <boolli@google.com>
---
Changes in v2:
 - Remove the line to nullify vport->q_vector_idxs as it is not
   necessary.

 drivers/net/ethernet/intel/idpf/idpf_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 131a8121839bd..f63ab58428d2e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1308,6 +1308,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 free_rss_key:
 	kfree(rss_data->rss_key);
+	rss_data->rss_key = NULL;
 free_vector_idxs:
 	kfree(vport->q_vector_idxs);
 free_vport:
-- 
2.52.0.457.g6b5491de43-goog


