Return-Path: <netdev+bounces-273479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMMoGgBny2mAHQYAu9opvQ
	(envelope-from <netdev+bounces-273479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:17:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9093646F0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AF3E303E76F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E41F5437;
	Tue, 31 Mar 2026 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWQiRofA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA3227FB1F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937841; cv=none; b=gTp/MsgZ+evuV1LMx+RMX3AsTNWKMb+AknJpRnFcbBAcyH9+HbTII3voMDTzPZbLJ205NJaQ6ugNCkycqrAbKY2/+KvmoMna9onBrq7oPHWxLvM7CQ3WeSL/XpjllmC+i2R4BWWxVu2UXKsoH3ppgaez8sKVpggZwveLw4ZQ0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937841; c=relaxed/simple;
	bh=+MVwa06bQ80jTsJAxdYTPPItAkzHNOIIwQDDMrjTfLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7jI1ymEbWWuqwx2HqNPzh+ulTVadznjgZhBTBO1NuSmLEmgADPlAMplai1eaxuIZig8dfuY1gNuxwaAa6jhUOajsqS/gwcZ8YRiOUP6bEPfhccHDqK6XpC+mqb90XsApCpQe0Yh/C6pfycFll9Q9hraomo8BXht2+zCcH+Hxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWQiRofA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3724370a91.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937840; x=1775542640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkzyJ4oLOwweestkp4e2+gtljA8YSDiok5IOKRVAFxc=;
        b=SWQiRofAKkGjqPfXCm5gjRdeLdi78+27ZTwJKQifuOlhXyRHa4NzFEIFj25Q9AlTCr
         DsMsdzYTcUi34q/h2h5G0E/V+194WBNjwSLZKL/qmtbxI+9D/Qbq+xnTYht7OwF1KrEh
         qFBEJFrMrspfU3QXoEaYz4XGqtIdWFn5E6V7yRefT54D9U7+6HkJEh4UDxFIT7gXEbeX
         kU99dNgITl8F6W081WHukjqikKobxz6Ne2op61eHGETg2a4sR3lW0870/hfkp1HZ65fu
         5c+bO/raqzGrqO+Ca7eOLauFMbPi6PMkAv5NpJ4EwJZ5DzCRzLn/zbv290TWDNkZtJNg
         3faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937840; x=1775542640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkzyJ4oLOwweestkp4e2+gtljA8YSDiok5IOKRVAFxc=;
        b=PMNySVjaq5sblyCuDKdDisz1MrThddNIzlB8jFlPGEn9OyU+BRvNp78hSnUdQ5sQaH
         Q7EbszLJW5oyYUFppfRCHybtv9DSNsLGf0mqN0UzfVU4Sqk5oRbCoq+pDK+5USxBlgDA
         X41fB7VxQSOze+Pu4MV0GhWWMbve0IFguG4MqW0I0Pi/ca3RN2Mg8ZnCo5qyAWrASx+N
         /Ps4orWrU4AHWRYhYPRws43k5IERl/vvTTRmGSzMGrbH0XMmY1UpN2f2upJGeCWSrKJx
         Ifpuj/6XJaT/UcSsMGGVNYQ8F/xmzXGzvR3K3EZ0EYv5spDk3dgmPu03wicBcseLiCqR
         MUwg==
X-Forwarded-Encrypted: i=1; AJvYcCV1bXrLPtj7ioqYn8cxGm+M7lBkbYIXTu+YqkO3SpkuxmaT62lQKf2Z/v4efT/8tXj5IV1WbJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz03mDL+Er1PXY1HXQQcIHXwHDKxdKLlMMRixbFN/OPjCuHwZZ
	rlrfwamBWjDAVsL4/QipW8EzaLGRlmVgDiFH5TuGdHrCR7S51ZwmergW
X-Gm-Gg: ATEYQzwYsA7x6e6uZrz0ekYwKbYLOZ089unSrUWgyyOstf9Mdlnqa1f52wngzLAPTaA
	eVdIo/TGWboFaf6w2u3+pJoh1hNABRDhNW7h/Ny/C9O9nFU5BeP+vM2yRe808JGDnW2D6QEDBgZ
	tSoZl3LNNysihBLuQApbCQ9H2AfXU/Sv+a1qwO+OqtLmJA5v1SBHxsAimzFq2Y06oyXRTk1dkWK
	DQSoIl5k7kVgNit/c2vSfuN/tzGC8e/N55mNjL7VAWZjBf4+kisdY+AM4/gAgtDiJvpiXkLzZIi
	nA0eI+NhhI7fItg3YsVFELrnw7/s07PnUo8/4tDSnyq7tvTzS/GUFEnRA8bZgdMyWKaSQZhF6Q+
	1Agl18+fQTWhrrkC79zZk0D/XFAujOdHG44ZIzZBHD/SVi1c28vteOeRYkvYC1d7FhbbqlSeMSQ
	kLLS8di3lPWL8XOEQZXiawxjxKVb14C3lm8i4=
X-Received: by 2002:a17:903:1c9:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2b0cdc76509mr162648985ad.1.1774937839921;
        Mon, 30 Mar 2026 23:17:19 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24267397bsm108101525ad.27.2026.03.30.23.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:17:19 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH v2] netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
Date: Tue, 31 Mar 2026 14:17:12 +0800
Message-ID: <20260331061712.85484-1-tpluszz77@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,vger.kernel.org,netfilter.org,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-273479-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: DD9093646F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ctnetlink_alloc_expect() allocates expectations from a non-zeroing
slab cache via nf_ct_expect_alloc().  When CTA_EXPECT_NAT is not
present in the netlink message, saved_addr and saved_proto are
never initialized.  Stale data from a previous slab occupant can
then be dumped to userspace by ctnetlink_exp_dump_expect(), which
checks these fields to decide whether to emit CTA_EXPECT_NAT.

The safe sibling nf_ct_expect_init(), used by the packet path,
explicitly zeroes these fields.

Zero saved_addr, saved_proto and dir in the else branch, guarded
by IS_ENABLED(CONFIG_NF_NAT) since these fields only exist when
NAT is enabled.

Confirmed by priming the expect slab with NAT-bearing expectations,
freeing them, creating a new expectation without CTA_EXPECT_NAT,
and observing that the ctnetlink dump emits a spurious
CTA_EXPECT_NAT containing stale data from the prior allocation.

Fixes: 076a0ca02644 ("netfilter: ctnetlink: add NAT support for expectations")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603310541.XVM8V7WG-lkp@intel.com/
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---

Changes in v2:
  - Wrap zeroing in #if IS_ENABLED(CONFIG_NF_NAT) to fix build
    when CONFIG_NF_NAT is disabled (kernel test robot)

Link: https://lore.kernel.org/all/20260329165217.241038-1-tpluszz77@gmail.com/
 net/netfilter/nf_conntrack_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index c57c665363e0..6d7eab7e8cf8 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3593,6 +3593,12 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 						 exp, nf_ct_l3num(ct));
 		if (err < 0)
 			goto err_out;
+#if IS_ENABLED(CONFIG_NF_NAT)
+	} else {
+		memset(&exp->saved_addr, 0, sizeof(exp->saved_addr));
+		memset(&exp->saved_proto, 0, sizeof(exp->saved_proto));
+		exp->dir = 0;
+#endif
 	}
 	return exp;
 err_out:
-- 
2.43.0


