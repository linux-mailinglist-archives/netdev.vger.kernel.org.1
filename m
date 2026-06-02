Return-Path: <netdev+bounces-294127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDKREEepHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B902A62C069
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA2C31220AD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB63C5DB6;
	Tue,  2 Jun 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1riN+nt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788037754B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393803; cv=none; b=LxaXMN4oZnYMs3lcSmtKvbFwejJ8u3j2//58lmk7gn17hf1BCBAtE/4oYvFaoJEYecomsKTtw/2VMKJFSBAPiH6XdL28jjIve0iQv3+H9eMlyeFswYTI3e1HvyK+MvS8b8obEqE4ValC5n8ZXtMzsrPMzLJxGf04WWusxbzNdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393803; c=relaxed/simple;
	bh=lfdnB8JHOL6TJUwmiVdb7QmVDU4hGb/TlMaA14Jn80k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bK97kOdH8Dwq71NMI8xU4Keiq3D1rdSEHUMKKtz2b70BylwZyMeBD1iWC480uY6BoetkC/K15IDU/YQ/q5/4xpF7A9hYPfEWVojjsWC15lbzZV0ezlU3prnd8DnWoL6PlxD9B83MtRmBI7LUmGT3cURRvDsCAXohPCr8CrnUjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1riN+nt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf20f6be6bso23612075ad.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780393801; x=1780998601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7D7KX83byfNQhjrfKE/R/xlqUStOZtk9OhZBvAEMzKo=;
        b=r1riN+ntBHVqPNuHcKM++1mcJIKfxNrMmXHgkagi+8uCTkdqaFDHyahS+maVKwRZiV
         af9WNgIx3/V+ZDk7+OaDXYbDSr79Wz4C5t1b0l0tTzR+gA7yY+poQPoXzqX+XW3Rkx3J
         +ttDJ1fLsQhWCyKl/q19prOLwAzSjInT8iIgHZZtvFMB0SAruB8dJ5V3TfB0W7Ue6YDW
         Ul1uszKbUvwYXw1EJpcFMU2d/1IanXxc5S/RgCUJBcTexcrz2Xqk1kHyV4kqm3G993TT
         PHeILix3y5cvEBGb/s24E35RPyCyqjuYPwAn72nEycir3xYEz275sk4zK/Cw1QnVsEab
         bd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393801; x=1780998601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D7KX83byfNQhjrfKE/R/xlqUStOZtk9OhZBvAEMzKo=;
        b=DpsiBJ1Bh7fdBp770jpvcNWme9I9wsLxexm5l46135j+DJG+ejUH43+fiPaw0aTOP2
         dcb0Cc2r/kWr+Mx+8ncq0IMiZbufQSXrVC9t1He2TkaV5zIQ+ulc+48NSthajXv5Jq7j
         YK1eHxuHpGgwuTvH2yeu6ru07e/i+gJ3b9rQ5Sllfo9T3uR06U2RnVvGIzaJJHVHAazb
         7j802SKy4iwEPr0cHd+/PKpsG3TKKzRg3e8dw+NoaNvhvSmDS1ZNdDhh7cPKm3gBiHUT
         I5+RcjxWN4Q43kKMYDO4YF2oJ8Xj4XMnJaxWktC9cF6OlHMQa45UA3VU/eQNvVgTy0ln
         yWsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tIKqMOx9Kck8/6mcL8N0AWXwQRM7GJH+Rq8g+4kWs9D1qZTuyny+D+R22pHLKWJk1uDEo5vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JK+0CIGKpkc3Xb/Skn9+49hMilIYRfys66tJkCrfKnm8TQjU
	kCg93w3ziBb4XJWepyC5thUy+uqvs2yJ/cA2qhCcPj2rsOjkcq8Kv02m
X-Gm-Gg: Acq92OFQlCO55dbbIFilVFn+DzARqWu3OVfKqoQ36sg5R4KCobdUPXbuzmTLWHSqi/e
	C2/zjBrddMLAjkdLRKNgelzSOGxwXlSk79Dg3fUzpSLKqrFPixMMeYfUGBfW7tY3YfFybu1pDNU
	uBmtLrPCnL3hSHRyWf92RCnOEIyJ7BOVjI5j7dQNOeahyGZqSMZ9x6Ei0KFJu0QPC0kDZmI7+4C
	EuJiUatOR/qRsXUMWchW9D6cT4Gjjw+aojKMokHyx3T/1QCVXKYAzWMEVdVYnOAWhVoF/jihKtW
	Qs/myb6q/KuQbTw28WAb4waqf0sLibrMjdAcAU370L2/SIhpud50YlHfPWyp3CVXKGLl60Sd+m+
	qNiBaB8Mo/3QlPpMqTlRaeqELCLOuvtIL0cJitJGH4NZNIu4+LFBd2GI5oq/IGpVN33v2W7nC31
	3/Z3Yn58qH8mkT079rc8URwKa8siQ/Gpn3eTsB6ogx7JSd8ktGq7Xs+q9B5uX1YOz5Hgrql1bg3
	92CNDaCOQ+B8xsW69KXFl9hIw==
X-Received: by 2002:a17:902:e5cf:b0:2c0:d9b7:b7b0 with SMTP id d9443c01a7336-2c0d9b7bbb8mr96460005ad.31.1780393801088;
        Tue, 02 Jun 2026 02:50:01 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm125017325ad.63.2026.06.02.02.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:50:00 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: steffen.klassert@secunet.com
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	fw@strlen.de,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()
Date: Tue,  2 Jun 2026 18:49:05 +0900
Message-ID: <20260602094908.2194262-1-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B902A62C069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294127-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,strlen.de,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanghyunparkcnu@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Fix the race by pruning the bin while still holding xfrm_policy_lock,
before dropping it. Use __xfrm_policy_inexact_prune_bin() directly since
the lock is already held. The wrapper xfrm_policy_inexact_prune_bin()
becomes unused and is removed.

Race:

  CPU0 (XFRM_MSG_DELPOLICY)           CPU1 (XFRM_MSG_NEWSPDINFO)
  ==========================          ==========================
  xfrm_policy_bysel_ctx():
    spin_lock_bh(xfrm_policy_lock)
    bin = xfrm_policy_inexact_lookup()
    __xfrm_policy_unlink(pol)
    spin_unlock_bh(xfrm_policy_lock)
    xfrm_policy_kill(ret)
    // wide window, lock not held
                                       xfrm_hash_rebuild():
                                         spin_lock_bh(xfrm_policy_lock)
                                         __xfrm_policy_inexact_flush():
                                           kfree_rcu(bin)  // bin freed
                                         spin_unlock_bh(xfrm_policy_lock)
    xfrm_policy_inexact_prune_bin(bin)
    // UAF: bin is freed

Fixes: 6be3b0db6db8 ("xfrm: policy: add inexact policy search tree infrastructure")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
Changes in v2:
- Use the correct Fixes tag.
- Drop the extra ret condition and keep the original bin && delete
  condition, only moving the prune before dropping xfrm_policy_lock.
- Trim reproduction and KASAN details from the changelog.
- Avoid whitespace damage.

 net/xfrm/xfrm_policy.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index fca07f8e60..14fc87b2e7 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1156,15 +1156,6 @@ static void __xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b, bool
 	}
 }
 
-static void xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b)
-{
-	struct net *net = read_pnet(&b->k.net);
-
-	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
-	__xfrm_policy_inexact_prune_bin(b, false);
-	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-}
-
 static void __xfrm_policy_inexact_flush(struct net *net)
 {
 	struct xfrm_pol_inexact_bin *bin, *t;
@@ -1707,12 +1698,12 @@ xfrm_policy_bysel_ctx(struct net *net, const struct xfrm_mark *mark, u32 if_id,
 		}
 		ret = pol;
 	}
+	if (bin && delete)
+		__xfrm_policy_inexact_prune_bin(bin, false);
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 
 	if (ret && delete)
 		xfrm_policy_kill(ret);
-	if (bin && delete)
-		xfrm_policy_inexact_prune_bin(bin);
 	return ret;
 }
 EXPORT_SYMBOL(xfrm_policy_bysel_ctx);

