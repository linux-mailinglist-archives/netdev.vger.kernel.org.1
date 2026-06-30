Return-Path: <netdev+bounces-303326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lXXTIW0JRGpCngoAu9opvQ
	(envelope-from <netdev+bounces-303326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 437916E72B3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:22:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="W+BG/mzo";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303326-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25642307CEE3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C044B663;
	Tue, 30 Jun 2026 18:21:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B0466B6E
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843698; cv=none; b=NP6TcIUPoMs39gOSseqzp9BtafS643MwKCgOr6KOeDH761gWD8dqrkXU1+c/DLIz7coOBdTXsK05sd/w7P+bbf+kwZQji4jbZ8G5A0E1qPwqBLVr3Vm4UG2z14MJIW3Bsw6kcK2bPsaPx0krmMDtEy0LM90TAndek9ukXtTrQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843698; c=relaxed/simple;
	bh=R0j/qNYveSeY8vyL0/e5npQklgus96CIbETe93stoCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obeCDtJkoYFm7mR3XF62hDEUV59LXhzUnLNcXv/eN+hFSgEj/OtJtT4SY0a9NiIV0vghhRDMhBQMuGc3e1I4G4/L9fx3j55bFilBfRFEYrz1uHypMNxE21RWc7H7qJvQWZKygbDaOYfG9lIlZUQYvMtvsdi9jgZW+aX6AJGaF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+BG/mzo; arc=none smtp.client-ip=74.125.227.128
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-37c6c8fa1d0so113115a91.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843697; x=1783448497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZhuHYG8y80lULc2rLkcuyGBpLEov+tMve8Tm1aOgdM=;
        b=W+BG/mzotfFH6UcjYoWnH/vjZMg6OJX4cjrCVxcgCKtNqN63dhd3+MmvJ4JIMQ0gNC
         pRo2MJjDtYgGfiRjpZ4obPIY8i7estm1usVlM6h5zRL+AWUyzA4V7p4zYTw0j7scHvhj
         iH5rcoC3lBwK913vgtHEiXI0T++W1/Un5lT9Vy2+uAihwJO6YN5nJd1eTGRJ39Bk6Yzx
         8UrbXSDc8cSQcc4gKnLK/pYab9A7gylLy5idG5NNi/Hf84+5D4CIIj1LP0ETuXF1jQif
         nRmmgigwSE1Uf+tFOWgVmnCpA7A9VwJf0J0Eo4iCAVW3MYmuhLpftH2SvqaS9Ab+ZLA/
         E8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843697; x=1783448497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZhuHYG8y80lULc2rLkcuyGBpLEov+tMve8Tm1aOgdM=;
        b=Zutg1dY++v7TvY8o1lX7GYOnTHSz2GECOAJ4Ua9tc1lHRxb1nP8+iJXly/juakHyKM
         n88EIAvn34fE2r5Xx+hWXnngsrlun05yKZQ9e3hjapUGXKegkafrQAQFpldjBNxl4T8Z
         XKUod+SQuWKmjK0IN3tu7ZhPLDSUiEUnoxN7BHbH4bDEZB/7w+yD76pA7g3vyGOCmD57
         SBbOURXr5yD5MyFGz28J7D13a6rVW4lJ8P65wdg/EOcawJC3CiIcP755jxnD3bTXmsXw
         YLXwAiG5r0bd8K7eCQpu24h/GrDfyJ3DFs37i1KPtaXxS1L7SFUtC8Hf2b5hSDV3SP4O
         6tGw==
X-Gm-Message-State: AOJu0Yy+5vvs3WZGCmuooCPkmcue4kL2BkuL3tmXBD+rGqZ2LTqeq7rj
	x6Pk3l5JYgl4SzjRog2pEh6yhU1hoD8Jn1aToPe6MHVhv4oTRJi5/IPKAgWlgG+n
X-Gm-Gg: AfdE7cnfaTpyozgZClKQeBEDWiZcZQfIi/+JNc+AtC6lAXgX3Y4jqfgWenT8iPMWO0T
	Qoe3YLdTh5Cr7I1yYJmdusn5cZzgM9nJiPgUkiPxr7EZQR+y72IEaiIKYFxpCxi33vIp19BXBTn
	ZP4uCLS1PeAhmyY8GAXUsSJY8jNanHk525unYxLAs1I6n88n38PuI6SBiULnBw/lAcmE9kfe86L
	oY6MPo0NBw3n9Etk1TcvduwL//cWQrN+45jIcuZk25P1AEMzR9vyGxaCDArw4OPvQYpyKBkxQiY
	9v9DxDLKKX7qH+RG/eR9robPdSk5fxTsyzdG9Ltz6w+aOsdqfS3Gp/RTC5/6p7WUwUtdnlQCFdi
	/89Q5a3HV3BHBpdKt3GDpiw9eoI6rgcf5Pl42ztflccejlXl3ttctrrFxurMP5efOgGhR9qBCF6
	7OuyVW
X-Received: by 2002:a17:90b:1fc5:b0:37f:9ce2:348b with SMTP id 98e67ed59e1d1-3808c0e4f16mr1237399a91.28.1782843696658;
        Tue, 30 Jun 2026 11:21:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097dba406sm46026a91.2.2026.06.30.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:35 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 4/6] net: rtnetlink: take instance lock inside rtnl_configure_link
Date: Tue, 30 Jun 2026 11:21:27 -0700
Message-ID: <20260630182129.1601784-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303326-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 437916E72B3

rtnl_configure_link calls __dev_change_flags() and __dev_notify_flags,
both need the instance lock. rtnl_newlink_create grabs it but stacked
devices do not. Move the lock inside rtnl_configure_link.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/rtnetlink.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 12aa3aa1688b..1b7d6f6b8b68 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3660,14 +3660,16 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 			u32 portid, const struct nlmsghdr *nlh)
 {
 	unsigned int old_flags, changed;
-	int err;
+	int err = 0;
+
+	netdev_lock_ops(dev);
 
 	old_flags = dev->flags;
 	if (ifm && (ifm->ifi_flags || ifm->ifi_change)) {
 		err = __dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
 					 NULL);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
 	changed = old_flags ^ dev->flags;
@@ -3677,7 +3679,10 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 	}
 
 	__dev_notify_flags(dev, old_flags, changed, portid, nlh);
-	return 0;
+
+out:
+	netdev_unlock_ops(dev);
+	return err;
 }
 EXPORT_SYMBOL(rtnl_configure_link);
 
@@ -3918,22 +3923,20 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		goto out;
 	}
 
-	netdev_lock_ops(dev);
-
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
 	if (tb[IFLA_MASTER]) {
+		netdev_lock_ops(dev);
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
+		netdev_unlock_ops(dev);
 		if (err)
 			goto out_unregister;
 	}
 
-	netdev_unlock_ops(dev);
 out:
 	return err;
 out_unregister:
-	netdev_unlock_ops(dev);
 	if (ops->newlink) {
 		LIST_HEAD(list_kill);
 
-- 
2.53.0-Meta


