Return-Path: <netdev+bounces-291123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMXTED7HEWpApwYAu9opvQ
	(envelope-from <netdev+bounces-291123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 17:26:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67655BFA5A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182DF301FA85
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB331195B;
	Sat, 23 May 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvMgPCmF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B22313534
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549988; cv=none; b=B7HEDI+81GA6alYiLf0CmgVVjMSFBQQv03b93AvmhbzPhox8A7AX7qcH0TzgVsB3SNICCaYwekt+RHTMpEz8HQ46TRIE+lf68pfed7cc/kydSG8DvqGZgKBAzDghLesQha16DuAD//xPT5MRgsTyTALJCxNc1+1yUHUq+NpUT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549988; c=relaxed/simple;
	bh=+W0lClMlP6AGBczS6QM9IYnRqQO8vnGqznmuI/qcPjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwlOeKJ3yUuGPHjfOkqRjlPkSJbTlFOLVDBJAdUDB6AHlf7AR7WTPv/03qdvvfeUXbT16gfBgbePDDrJUCCpwbmy2RK3Q+6jgo9nTQdoT73F/hDyS3wEBJj7oLKRxcSnnnz+bu+l5vd2SNGNunPtT3nzNMbxrOG2i5TPNCkxhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvMgPCmF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso13063245e9.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779549985; x=1780154785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GR+4fL0PGlkXhCcZaGs/e5Y6ZryBZ08nVorvm+PvDxo=;
        b=OvMgPCmF2x2bEsnQAPmtt3fv4szcC6KOYwMnjZ/Y1CMzU/tdnzZT4qLrSJmecflDlg
         XJT1JG1qkzfMipBDMi5LimhzT43qKlUm782jfYsh2a7j/MSW3qnoI3bQO7RnBDBDxQbO
         l6AQzpREySszKQiYeYOIb5xt7uUckIHDEZomQssFR7WuyDGXel0Asq0lKHLtplcjkWt7
         tzf2gus/iFAX995hWWT0On3Kxfb7U0M93s30rhbulSrJcO9A0vCk7znIR1qdIzbC6t+O
         DApFetG4JJ+XSRF0K+u8M+NafI0KThxXgrVYv5roYgFCt/xAj+l3mENLC7d97KLAQREB
         nFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779549985; x=1780154785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR+4fL0PGlkXhCcZaGs/e5Y6ZryBZ08nVorvm+PvDxo=;
        b=GuxELHmstEyvOO5XtAemrjXs4tVpdoRiUeiu9DyZppvmiWPntz2FVv0SYNEFp6Dmtb
         rkjsf7DdezvUnQ++1C7oIEmmoha0puMNtA1GPhcln1B6Sem7WfT/b2KQLBy+AoQ3H+OT
         s4ZVbKNh8VXAglUzSiDFN8gs7oUGJh80WlJvzAT2Px79DHQbCyOnozaaeV6RWkI4MB5w
         DvnHquL7haNU+FCqRNxBQWZBEd4uh1yFVN0C9rlcbvPqo1E2xV3i44DZOc2bogc927Ip
         EiEyyTd8yk6TDwySgxI+er2b3lFVHQVb5+TjGVT7S6f7EAAn79RV1FHDxao5h9mV4q34
         gANg==
X-Forwarded-Encrypted: i=1; AFNElJ961nCOwxvZfglB44dPgNAflpfMjXmgcgly4KWVfJacJTh14fZOndFA4djl7nE4g7kt65Q7Cng=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZ3zeXQC9YuK5ABMHVCuvPmXUB9cakmoScR0hl2bEyMgy9FWf
	KggQ/nwOUlRzfEFSYeYqQJpesDqk1GC+ul4sX3etJKs5/5cizDndRExq71CJ5u1O
X-Gm-Gg: Acq92OETEgzHmd/HOWpQ8XKXL/TXUTLZ16B4YN7QOC/P+QibL0Z4ukPE3BzjEc7fKF8
	0TC+H/UZ5fgAcgvczSsldIwGbVaJ8nHBsrV9906gc8c8THqAJjzrU/nlJxwKAYvStUWrOSsQOld
	JNy/EvGnJvhU3xkLGuwSLWNg4HnXiARS8I+QIQpgzm9C6AsRlefhim/aIkXuakAWSWQJM0e1R1y
	c7eoxEJKhnfbiI36RIFNKSoeBQukFKgsmFjXNrhxOZiDzzVQwQ287Jh+uJlPsJGKb/ps+a6Ve52
	scbSnA09nsSITt9/8v0WL893OOF2Tbs3vGd7Eia81ICXab2zvNDX3A+puoL5Mhw6QuCXvYIg4Ok
	DWBffoyDIp3YrknQax99W+6/UI5SGQJI10/hevAzCiiMbFY2EZ2PN+TUIXOY/bDZlUyQekbK6KN
	XZpjKDitcshRIBOTxUXmhKja1I4I7eM81CrWzPjj7anojONcmK8GhyNBjCdaRI5rDNPAb4359Le
	yT42lr2KfDDclhUWZKkEQ==
X-Received: by 2002:a05:600c:4fc9:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-4904248afc4mr109914165e9.3.1779549984777;
        Sat, 23 May 2026 08:26:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428f6786sm48617045e9.25.2026.05.23.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:26:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH nf] netfilter: flowtable: avoid num_encaps underflow on bridge VLAN untag
Date: Sat, 23 May 2026 16:26:21 +0100
Message-ID: <20260523152621.58576-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291123-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B67655BFA5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The DEV_PATH_BR_VLAN_UNTAG case post-decrements info->num_encaps
inside WARN_ON_ONCE(). num_encaps is u8, so if it's already 0 the
decrement still happens and wraps it to 255. The break only leaves
the inner switch -- a later path entry can set info->indev back to
a real device, and we end up returning with num_encaps == 255.

nft_dev_forward_path() then walks info.encap[] (size 2) up to
num_encaps, which means an OOB stack read and a bogus count copied
into the route descriptor.

Should only happen on a malformed bridge path stack, hence the WARN,
but worth handling sanely. Move the decrement out of the WARN.

Fixes: e990cef6516d ("netfilter: flowtable: add bridge vlan filtering support")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 9e88ea6a2eef..6263e07a1276 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -163,10 +163,11 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				info->num_encaps++;
 				break;
 			case DEV_PATH_BR_VLAN_UNTAG:
-				if (WARN_ON_ONCE(info->num_encaps-- == 0)) {
+				if (WARN_ON_ONCE(info->num_encaps == 0)) {
 					info->indev = NULL;
 					break;
 				}
+				info->num_encaps--;
 				break;
 			case DEV_PATH_BR_VLAN_KEEP:
 				break;
-- 
2.53.0


