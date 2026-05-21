Return-Path: <netdev+bounces-290315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAqODwrWDmr2CQYAu9opvQ
	(envelope-from <netdev+bounces-290315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:53:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE8D5A2B68
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4200D300B9CA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580CC37702E;
	Thu, 21 May 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvJEN88+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC03750D5
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356186; cv=none; b=OZ1KEkZZexpJnzg88rxmYz8iShELebA5Oo3YpMfBIaJSVSzlulZtBuSzpL0FQk6hUk5stFwylxAqn5X40Ze/aKMh/woEqLC3no56vegEerghJB+z+1i9mVQR8PQB1g3VIVfDZkughyuDOlpQWC+kg/geD0P5hu1Mfaz1RBWkjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356186; c=relaxed/simple;
	bh=n1Ym8sC2tYw3JwVQIr8QOYkS8HeICb8ExlRhTy/6eOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkFQ9OYHsyR5zQvy4WX5Zg1dV7dtGxTSd4ii+RQ1k8hrYZ/yrIyGwm8XV7GLuWI3rM+jvtrxJnjKeVKw2bR5paLCTUqhdNyj5Lx6YFvJsyiPtfPeOmi9/nC4hIyszFsXsiVhvo5vBlr+2xy6fs+gnP6rEMC1Jb4lZ00IfXlfnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvJEN88+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2677581b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356184; x=1779960984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/4CELazT4J7bYabOPvJV6gl1L91iH5vUTjK50awgg4=;
        b=GvJEN88+9TzWf6xmEK3r7A2P3yB32DIMyFYHlyUOkwzDVeF4WXsVodMrELXe4CzbWT
         rjmGX3wH4XP016TSrK4mB/3pm57wiHjUk+jVJYkDeN4DRnBh5N9g/OQ85AAW4LaCJPHm
         tUNV37QxWodw44vyJqJLxtN6BGhNx1gE0aLuAr4hrnb1dAzVX+k9U6Sa2ARGKHsN9dZK
         er6jk9npkJz1vep/0HdlyoVFHuJcHYLkQz4AvY4n+xbaOaNg2BVRaV7lqEZlGKori6+b
         Bl/4ngO+3CSfqFdot096C/RbSGh8Kl+07KJ0edN4ab5k2KstVKBm8AXwAcVf7FzMsQn+
         6qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356184; x=1779960984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/4CELazT4J7bYabOPvJV6gl1L91iH5vUTjK50awgg4=;
        b=pn9JupXMiwuxuPKe110OaqtXAF34NuQFcw6DbTge/gO0O2vXgq6Y7AjWKWSQVaHqdW
         mElcxCtAH8ui0rV7AKhrjePEVopC33UJhp6U5sMwgPPbGvRyP9tQmWPPwyl4rECaf+mB
         rb+d7GerpTvRo8zFP/4gbTSRg547q+LD4wTXQh1eaa8hfhCbs92fNaFNjxcjZs1gxZI5
         jEFlsTzSULKCYwWJjXoNv+GAXhwag2QBnrUb5g80pG4xkCWNkR4ucXC6sFEQcGssIYaD
         dVS78xjls8Q89Bqhlhdy1tfq1R5K0NC5Tjgaf6ASFfjUMwvF0g3A7RikbSfwxiKu+UT+
         wCvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rGkce6AtDS4b9N0Se+Ut1oO8DVJUwb/655jkvsVjaVTZCP06JnG+MKWShHeQhvqYjN6xO0as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOdQacVfotA8/1KPh4Rc04TiMPgk0ptVS9bCJSAqVa+rT+jFu
	QZnMeiRoKsJL4OLoavkSR+X+MjHC37L4ff6SwtodFhsLasYtXIcuQBaL
X-Gm-Gg: Acq92OGv8qL0DlnE30LyreMnE61c1ADW2ssLLhmquDdO8RwZlAwkYERIqQizWIJveIJ
	6iQVRqrsigKn3kv9N3DLoz9KDINvkO3dwrVriVMq4RI//IR4xFKpwsSv7s9MNEFh6a96W+ErxF4
	mmkbnczOOKsV+urddNncfcf+rIjWNZiGw5byzKtsSy91jM5GODSz0Sx2otCTB1jIh3lMjtpI/W+
	47M42MjZk755+TPWzgOWNCdeX/qeIO05yL0Pz2/LOabZYR1xEtMSAWDP62/UKQsd98WmmH4sl33
	6UCDy+reIWotK7QlmbTRg0sshjsrPs0rcIzu/xs6vCLBgv2/hEgcYLUyy1HliKDtWKLYnuKKaPd
	WTWh3/fbIRhF7OXB2ASh8YszjGZPBPkZeGBAREtwLEQkZaFShMug+FtOt30JisHGA+9rDW34lnt
	R07b4tz/2jhZ+r2zQ367gZHVb18ww+8y9g3xKw26Y7psgwJDWIwwVJFIt/KSqaHzN8Lzne/FR3A
	hw=
X-Received: by 2002:a05:6a00:1306:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-8414ae56cf7mr2470482b3a.45.1779356184338;
        Thu, 21 May 2026 02:36:24 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:5c80:bb9e:85d5:f1b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154b1acf2sm912053b3a.22.2026.05.21.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:36:23 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ipv4: igmp: annotate data-races around im->users
Date: Thu, 21 May 2026 18:36:12 +0900
Message-ID: <20260521093612.207475-1-sigefriedhyy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-290315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3FE8D5A2B68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

/proc/net/igmp walks IPv4 multicast memberships under RCU and
prints im->users without holding RTNL, while multicast join and leave
paths update the field while holding RTNL. Annotate this intentional
lockless snapshot with READ_ONCE() and the matching writers with
WRITE_ONCE().

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv4/igmp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 27d120183779..f2aca659b29c 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1541,7 +1541,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 	}
 
 	if  (im) {
-		im->users++;
+		WRITE_ONCE(im->users, im->users + 1);
 		ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
 		goto out;
 	}
@@ -1550,7 +1550,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 	if (!im)
 		goto out;
 
-	im->users = 1;
+	WRITE_ONCE(im->users, 1);
 	im->interface = in_dev;
 	in_dev_hold(in_dev);
 	im->multiaddr = addr;
@@ -1784,7 +1784,10 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
 	     (i = rtnl_dereference(*ip)) != NULL;
 	     ip = &i->next_rcu) {
 		if (i->multiaddr == addr) {
-			if (--i->users == 0) {
+			int new_users = i->users - 1;
+
+			WRITE_ONCE(i->users, new_users);
+			if (new_users == 0) {
 				ip_mc_hash_remove(in_dev, i);
 				*ip = i->next_rcu;
 				in_dev->mc_count--;
@@ -2977,7 +2980,7 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 		delta = im->timer.expires - jiffies;
 		seq_printf(seq,
 			   "\t\t\t\t%08X %5d %d:%08lX\t\t%d\n",
-			   im->multiaddr, im->users,
+			   im->multiaddr, READ_ONCE(im->users),
 			   im->tm_running,
 			   im->tm_running ? jiffies_delta_to_clock_t(delta) : 0,
 			   im->reporter);
-- 
2.43.0


