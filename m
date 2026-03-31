Return-Path: <netdev+bounces-273478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPR3O1tmy2mAHQYAu9opvQ
	(envelope-from <netdev+bounces-273478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:14:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F67364692
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE446303648E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E44386C09;
	Tue, 31 Mar 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N28C7yGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDF37FF5C
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937686; cv=none; b=H95wb8cawXa9n8WQxG0sobS6yh1tTp38El2TaplqZVzIu6bye1DflipdJbZiGTeH3TwSuwuEqXSg154RBmR/V99AbW+cKWbrkTPsjYS3MDgGqJObgjS+656mIF1L3r5rYUqKlKFPmOaZY2ZrOl7WngXVkOWAZNrZEMRMGFI4CKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937686; c=relaxed/simple;
	bh=+MVwa06bQ80jTsJAxdYTPPItAkzHNOIIwQDDMrjTfLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNAn85YUFAGYpyxpipHu5LEkiPS6NKg0jvL4PEMb7owXbZ1ufA5yBLLLnfdZUaLh2CPfrxIJkhaMn8Qir0Uf+MdOJrIyDFabrz57dMGdVVY86gFVLOlHbztHYZ8iEPU4T0otkUY+x5nGB90EsDJSUsL894grozONI5/Pi/6lIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N28C7yGI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso3725748b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937683; x=1775542483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkzyJ4oLOwweestkp4e2+gtljA8YSDiok5IOKRVAFxc=;
        b=N28C7yGIHxXtTsQUQvJnagExwZq9OdR3fGxH2aynR9nmtIINYAuBrw4tR1dNIxM4u6
         M17p/Nyq9ZyieWueXt9XNZQCnx3cwJ3xSY32FoCyYpNeda24tr1EPBV0BRs2F0yx47ni
         Xlw4x/BoQSaTeap3QXPbWjJVDChh9sP5rnpO7DY6y7Qdtqs/1GkJC+oon1ibtdvGiEqD
         mc2L9uqNysR3t9ZZaMxLVG7d9iW3w5la/TS53m7h6Da+UnInNeLc/wSB/d6l+7QrnuTe
         WWk2SkAAbLcgOQqhZbw1+GlntZ1QYn6FFzPWeg2uTJSUVBClum3nzgj7XP4JnyuAkMjH
         2ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937683; x=1775542483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkzyJ4oLOwweestkp4e2+gtljA8YSDiok5IOKRVAFxc=;
        b=Ft4sLlNxbIojTZDVpM9srVLOPM1a/NUF2yAb+Nzpkr2WW0GW8DAfX50dkoI25hF52x
         gwF53yZy1KkIRw9thTiuF24XPWyVaFBO2uG/P/3skHOWpGQ5c79nW6sgvb4wpbdyIdKp
         LUSMoZ+c3J/W3vt3IlPI7HRnOK1adhhQhFGSS+fi6pD6aPzjaSG408+lzqj23ZKleINP
         dgGrzYzu8vds8MgVkfJDy2y1ZvVxlzfRP1JKbLw3/va31KP6CCe6zDe647I+5VXgWZkZ
         nGNyP1aAznA8lniRMTSS936BiZyPVfI802gCbEn+ViPcpzLeWTXHmdq8RCC047vax8r0
         kq7g==
X-Forwarded-Encrypted: i=1; AJvYcCXmiExVoxcMaolNA1keQEQSk2WotJZKIkBSvXevjmQS0Hq4EuB5y6GvwpOtUf1icb4jyIHvvdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2V03U4a9LEb1mLv3SU0hDKqmUOm/IpscBn07pru8J64/tiDHU
	w75A/+lsPJNRFh7wntdtN9O1ssvjBkD/UsefEaagHuvYX/y3fU1k8cJn
X-Gm-Gg: ATEYQzzv3Dh0077cuwvQFL/89s2pHvoGmaqvTT8CLF+flgzBAinFKULd0ReFWYNziK6
	gf0GLz2MM/7HRcF+ibAJuYRGen/4Cn3xq6ud5T4pwCAxisqQ6DFPGylgckuiNFZNX/u59vr8FcM
	R8PNyMjPQ0fLMYpfWQ5HFXo2ZfEQ06KQyjTBl7ZgzqeWR4VfifsMd85Jixo+Jm2mtrSFVFSNuao
	tVkUU5N6Xut/PyQaUMsyzXtqcx6MZ0vhwULtkX11ri7RyYueBDXM4nrfJknh6wXqplGjHKpifCJ
	rAh9wUsQT8W+/gsG2Mh5jhNq0lvQ1+x5VB8htU2egwwXjyvjbVQO97KUqWp0+FYoOUAN16DDum+
	rwXcBJ4ItVk95yibwgYBkDZZ8KbgDhfJXBN+6SGg1c6fiQpxfR9wteSJIxoI0ix33X0Jal5LBjT
	mF43DaF4B0xQXhffxY1YgMEUDMhrroiNU3BRrFbhuuh4mY4w==
X-Received: by 2002:a05:6a00:2d0c:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-82c96024f3dmr15124148b3a.54.1774937683377;
        Mon, 30 Mar 2026 23:14:43 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8498779sm8984835b3a.25.2026.03.30.23.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:14:42 -0700 (PDT)
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
Date: Tue, 31 Mar 2026 14:14:33 +0800
Message-ID: <20260331061434.84238-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329165217.241038-1-tpluszz77@gmail.com>
References: <20260329165217.241038-1-tpluszz77@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,vger.kernel.org,netfilter.org,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-273478-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99F67364692
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


