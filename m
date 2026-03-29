Return-Path: <netdev+bounces-272940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM/rKZBYyWkuxgUAu9opvQ
	(envelope-from <netdev+bounces-272940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4759935327F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 461903005785
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF538228B;
	Sun, 29 Mar 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLnAJ29P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622F37FF70
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803047; cv=none; b=Wi8oOsPnkZgvdY7QYX2/z11zNbT5Ui1/wz7HOiFIY/ajBcfQL8huv+tbbIMQ0LEaj7So23eRBCQuKyZC0xGAtI7isI7YiF7TBBCvhRI7FWK0eEzQWwD7nFJmZP4hlflYlIM8Jyw353qZImFQVElxjh0d1hjbs4RFwgaUm07k0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803047; c=relaxed/simple;
	bh=B8Wh+OKhBzmwRsiBIJtM2UgSuJEeudpnLpYyPMFLMFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQG/NVr+08kC0Tf+mcmWc4wiifUVfrrATNabZ8s3x0YnqNUlDgrRDa+XsNaNusWy9ej00cWXje9KxFpyaNT35NbemEFpQMkvq+N/NKZ4J4p7o7DTiG4+xa8gq/HD+sHrnzgQtvS+2loOFjz6eFj1ZPB5cjpu+56MzaxxFCrqesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLnAJ29P; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c73c990a96dso1616279a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774803043; x=1775407843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DPnBm+ae0zOwy+ktvv0TAbSToo1fEQfvYGqtSpxCLrQ=;
        b=RLnAJ29PfdpYVP/XF0P++SG4GuVZBJNYRiUL87iLUVtlA0ChcSKCVZqfYtiuDtnGEh
         Jfgk2+ExJ4Hj4LzvXqSP1Hc6OqoNZAKe1lyShyDcFwDs7lyLtuYn0Z/Pfd8Ph9xBH3lJ
         g2w8dbxlLIFpn4K6lwIjliBnQ/2A7LZz8HWtFoBbyf7QzXqvcERW/x1eQ+8lyCpui+0H
         P9owGmY2tgDWgcFP29C2NQHt1tfLNpON9Oet4a9I8D3SAhPYy1JsPJQ3KpJ7LtsofYpU
         m1/hs7UW5sksgoXU31jzxAQiiWJUvpLbOcQV4CBLSCyfgUWFtkYnSc8u2gJPE+CU+9Tq
         QsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774803043; x=1775407843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPnBm+ae0zOwy+ktvv0TAbSToo1fEQfvYGqtSpxCLrQ=;
        b=sZfm87XJArjUhmykFc+ajXohw6IvN+kF0BUxiW2vpljPZaEcTj/geV9mjU+AcaEdqP
         4an5n1KmSxNBZnyw+MdoPX5RtbC/czih8kSghQOamkP3BpQaioyRK0rnKQfqwIl2de2G
         PcIJhPRUkJCv8J9WsCi+DY06QnqnP325YHt5h3WBwMhiRdZYk50F3tdlHqRWwow0dSY+
         JtsCDjNH/E70ZvvkvXyTfSrif6A3mNkiV+UXLRGzl9pFVcALf//ysx0SidfKvdEA+Om7
         o3A8wpb+W0rEMbMypv5O/VKE3noPTXBYykJTM6e2q1v3d5OnjkDx+cemkqFTeCGZwE07
         Y6sw==
X-Forwarded-Encrypted: i=1; AJvYcCUubp9LMEG6aX4HpbiHAxzQ0huSXqAY2iA9GsIehfNkvibo+xe/8HWk5iIL39pHF6Qe6wH5cbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4NhUc9GIeXDEoOTYBjevR3krKtqmCDPBNnS5opkGfYs1nikg
	crS75rFz+3J83CAEqDmRhz2CiNFPOis9rKf14StTHijrS6lTyS5KQEK9
X-Gm-Gg: ATEYQzwuNBhxpsEyiaGqz261kJCQbiBRsV7dJ9D0erySPNlfs6/ZOGUWYMLYyb9m5Tw
	jDYYG0Zr+w+PYyCrTo2C5Eb6qRIulDoyQayLTPc0AWowp3gZu4CVGJ/VaWZpNVN8IF0ue/+Xm59
	6sp1eEZo+ZLZ7eGuB7Ra2dSzFPJ3EzyEm6f8Xzr/NWVaBS/Itz5RUMrSTMSS0hbXOQvTYQqYooB
	/XCIi/FExK3kKP1Y297AU4tTuTkv1+5AGVUuFKCIsjODu8o8lJyp1dPie4Gy2WfbZyzjJa/lSyP
	13xEqFFTaG+pWkp6Tkmmu6POyOMTKvpdkQPMZpcdZw/ScB9AlI1jmXVJG7XD2dRNXt455iuJ1hK
	EGrN+sOBsnePDyZJbFn4jHX3KtKXc0XHNJWJVg9aI9WAAsj7+ABkeUxQany3DhX+gEJ97b7sZgu
	MgqdemgA9vIFyNlqDvoETO/H5Nbt2wqE9nkA9FmN0N/nxgbw==
X-Received: by 2002:a05:6a00:2d9c:b0:829:862d:6b46 with SMTP id d2e1a72fcca58-82c95e58edcmr8610359b3a.6.1774803043470;
        Sun, 29 Mar 2026 09:50:43 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8498489sm4708920b3a.27.2026.03.29.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:50:43 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] netfilter: nf_conntrack_helper: pass helper to expect cleanup
Date: Mon, 30 Mar 2026 00:50:36 +0800
Message-ID: <20260329165036.240932-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272940-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4759935327F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nf_conntrack_helper_unregister() calls nf_ct_expect_iterate_destroy()
to remove expectations belonging to the helper being unregistered.
However, it passes NULL instead of the helper pointer as the data
argument, so expect_iter_me() never matches any expectation and all
of them survive the cleanup.

After unregister returns, nfnl_cthelper_del() frees the helper
object immediately.  Subsequent expectation dumps or packet-driven
init_conntrack() calls then dereference the freed exp->helper,
causing a use-after-free.

Pass the actual helper pointer so expectations referencing it are
properly destroyed before the helper object is freed.

  BUG: KASAN: slab-use-after-free in string+0x38f/0x430
  Read of size 1 at addr ffff888003b14d20 by task poc/103
  Call Trace:
   string+0x38f/0x430
   vsnprintf+0x3cc/0x1170
   seq_printf+0x17a/0x240
   exp_seq_show+0x2e5/0x560
   seq_read_iter+0x419/0x1280
   proc_reg_read+0x1ac/0x270
   vfs_read+0x179/0x930
   ksys_read+0xef/0x1c0
  Freed by task 103:
  The buggy address is located 32 bytes inside of
   freed 192-byte region [ffff888003b14d00, ffff888003b14dc0)

Fixes: ac7b84839003 ("netfilter: expect: add and use nf_ct_expect_iterate helpers")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netfilter/nf_conntrack_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 1b330ba6613b..a715304a53d8 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -415,7 +415,7 @@ void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 	 */
 	synchronize_rcu();
 
-	nf_ct_expect_iterate_destroy(expect_iter_me, NULL);
+	nf_ct_expect_iterate_destroy(expect_iter_me, me);
 	nf_ct_iterate_destroy(unhelp, me);
 
 	/* nf_ct_iterate_destroy() does an unconditional synchronize_rcu() as
-- 
2.43.0


