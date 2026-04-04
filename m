Return-Path: <netdev+bounces-275335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAWhFJPU0GlPBAcAu9opvQ
	(envelope-from <netdev+bounces-275335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92539A81D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 272DC30065F0
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED11F35BDA4;
	Sat,  4 Apr 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgbpTY5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060030F819
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293584; cv=none; b=T7IlopTl4ZCvrlmlBr33PgMbS+jSYRKC5XFZm/Re7eetaKoKAuGL4A6+Jr3NOXlWhwRnaNYiZHZ/bu11t7i6fHw/hqc0t3SkXHHAgoUffJke9VF6nYPqfU8ns5H3BKG3MWiObfV0LCO5sTO1JP69tpNi6iCge2+/GmmoXohqkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293584; c=relaxed/simple;
	bh=x6NHf67PA+FctHdp05p4vVKsKOo1ssYCbCqNoS4XW2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqYuYTiNnXu85F+PGs0Q4P4e5hrmoE86Va3VegOhqI4MGjWkcyaBSFS9BQS0XIDd1RAQWn0vCbfs9cGEj76srmNcBr9G4nP4SRnwKrjpLxr4Xq/93WylxCNV4yZ1onmc924QtfHlJEy7Mg0aGKZbBknMiQeqRr5tXkov/NpLtO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgbpTY5a; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38ddc25ce01so7633101fa.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775293581; x=1775898381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SVaApXpBURJ/dYQeY49l/eOAeEeadKwYfEwL6/3qpQ=;
        b=LgbpTY5aGZhgR5SC+OivuLaV+Hr6E23kMwoxrHyyEKyf8uPbQpUrefw1y74MdIxWIf
         mdfbH0XiYQxIa+Lxq1hnZFdOb4yVC8N3b0QMVqkOhBfgaCx+fzeO/siFK9wShS3nT+r1
         5tOT4dSNdmBMBV8+QbBfKs2+L/EexFUnZgqQDCMnAWcGvtnyIxcgPgIabdA3tFEOtW35
         pKig3ao2YaqVdEonYSFQv3SWwh3oYfDlrkdVcW/RGY7eXvTAvzS9llfLHsMtmde68+o5
         erK85ro2mMq6SdbSHse6dRLbe+/+oAv8ImIhRrakaNuGHdvfrHjqUhfcT9/7Zbk+Zwwk
         jiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775293581; x=1775898381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SVaApXpBURJ/dYQeY49l/eOAeEeadKwYfEwL6/3qpQ=;
        b=a8TzvpD//l6lTs/aoCh2dD2CtMmA3BJkvg/H621DEgY0GEZ7DlU7fxYzRWc6L0+c/K
         VWJe0R/U3pa+0MxHfzJImDDL3jtHksdlFDKfuxk0g0lsh6+N2W1ogqX2kLZCXxAXiil3
         elPWkdadgj09HrdEc6ZS2P11diNjrhQL7UNPcrZe+oijp9Cmmy9lIyaZwS2aVJ82qi1C
         dH5U/94F9q8ehV+L3omnHfqnMkxA8rbo+70K1Y0xm+LcKQpsQ5wWqk/4fG+YpjinNDsf
         sxEUV8tyb11EKBCAKfF2iEt5y3uW/48xxFFuu7qNelegmdPHW6z5KWNra8PNW8gJAErs
         MMbA==
X-Gm-Message-State: AOJu0YzOWNPMXbszg1jTZhj+vf4iYLCLL3NYyxEVPpTSdrLcOUMvtD/N
	prOxq4uMAVdlQZMWtaKI9ZhawhmQygn8jzhhG89vJW+eDJAFOb7Y2OTLQBTa8U2p9e1vYElY
X-Gm-Gg: AeBDiesyLzQ73LyJWIS3GdIuEHjLNsNfAxr/cT1+4/71K3Fn7K3+0cF92dwGFbMmRjU
	gTZqin7Rif3uJs7bdCNn0NoXY993W60UaX+zzexjb5f9Rx/SwdWWHO6p7eI4t45jLjCP0M/cbaL
	nc9XVrgVhhalqu3r5BC3dXLMh19u/wyGU82HxaFm/S0vjlolNtgYmI64kpjs71GT8vXd/Vf+Pr4
	t2PvyA8P8hginYLEfX1foleFdbEQTaxBhDY5UKSu0ws+Y8u39RRmNgFvGp2jssEPMMr+AeLWZWq
	+ioOGGvsTnRT7uzvSv9s37d3H985O8ojwQ1CAleZoCpqbgkw4uzvy9hL4Hbu1VyIkb85h1czlIc
	PxPfK1WwCK4Ph5NATdWFCWLIqVjXy5GBWS4a9iMrke7ERofPiiX0fNIfAUkzqv7WrP8dvpoGYGc
	7/ytCQqydJDUp+0DKueKSpNqdEUVirh6pvyPk=
X-Received: by 2002:a05:6512:3f2a:b0:5a2:b0d1:d03a with SMTP id 2adb3069b0e04-5a337588bc0mr2077323e87.31.1775293581118;
        Sat, 04 Apr 2026 02:06:21 -0700 (PDT)
Received: from Raptor-X102-mclgxx ([93.175.1.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccdefcsm1957236e87.68.2026.04.04.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:06:20 -0700 (PDT)
From: Kotlyarov Mihail <mihailkotlyarow@gmail.com>
To: netdev@vger.kernel.org
Cc: Kotlyarov Mihail <mihailkotlyarow@gmail.com>,
	lvc-project@linuxtesting.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	fw@strlen.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH ipsec] xfrm: fix refcount leak in xfrm_migrate_policy_find
Date: Sat,  4 Apr 2026 12:05:20 +0300
Message-ID: <20260404090525.105083-1-mihailkotlyarow@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linuxtesting.org,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mihailkotlyarow@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: ED92539A81D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzkaller reported a memory leak in xfrm_policy_alloc:

  BUG: memory leak
  unreferenced object 0xffff888114d79000 (size 1024):
    comm "syz.1.17", pid 931
    ...
    xfrm_policy_alloc+0xb3/0x4b0 net/xfrm/xfrm_policy.c:432

The root cause is a double call to xfrm_pol_hold_rcu() in
xfrm_migrate_policy_find(). The lookup function already returns
a policy with held reference, making the second call redundant.

Remove the redundant xfrm_pol_hold_rcu() call to fix the refcount
imbalance and prevent the memory leak.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Signed-off-by: Kotlyarov Mihail <mihailkotlyarow@gmail.com>
---
 net/xfrm/xfrm_policy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..8566bc464668 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4517,9 +4517,6 @@ static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *
 	pol = xfrm_policy_lookup_bytype(net, type, &fl, sel->family, dir, if_id);
 	if (IS_ERR_OR_NULL(pol))
 		goto out_unlock;
-
-	if (!xfrm_pol_hold_rcu(pol))
-		pol = NULL;
 out_unlock:
 	rcu_read_unlock();
 	return pol;
-- 
2.53.0


