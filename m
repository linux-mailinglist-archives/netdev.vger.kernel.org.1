Return-Path: <netdev+bounces-266959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECdfBXGJsml4NQAAu9opvQ
	(envelope-from <netdev+bounces-266959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:37:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB626FAE9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82CF3033397
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C338B7D5;
	Thu, 12 Mar 2026 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkc7Kz06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735963B775C
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308265; cv=none; b=SrPu5PINGSTlYqTyQkBP4EGxpC7s6C3TUocdu+9oZNORFsoK5ke1fDZQl+oeEK1dvgr0QODZ5KmqKJjfvNXHaBUXj9mUH7FsmUf0nL41uro2KIxQkRzHxesXX/Dgk3Zm/LwQVuZNsIEY3aFCdwV0Yo4iz9tn3kMk6BdccIEabnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308265; c=relaxed/simple;
	bh=nmS+lsmzgEPjEn3riI1mvL7c2Eoou0UuR1cS2D2z6U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0qAv9VwFquJTnVSVB4sdd5T3J6cDGylp4iCm6giKrzWGrz6Rc38QbMaDsQhnxNlPien/sDsrHJqd+U04xU/xPKH4CgimbSWtN3Qomles+6ihDGFR1qgViZZrTsooXvL1zn3MNuZHs68MOGCPtlkUmSl041n/NhikDnzZG0soTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkc7Kz06; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b942424d231so93067866b.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773308260; x=1773913060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMylDifb+sgwUdyQ3doSis8cOmZPRv2aLJLRsCDWhws=;
        b=Fkc7Kz06QLN/zyyVNUx84VpZu3Wefio2PbXKknTvreAJwVTi0A0GG78OEMONAeUHhr
         Ygn+LRAEeRvixuubkQ7L/avK4ptZG1455jBA9ZnpkdIub1cV0wSl/QjyK8io0zrP/ykz
         QYazmzU8AVxkEGNNNcWmdHN1CGK2euardpaC/o+PZopf42M7dFKzdvjPHhOrnaa3S+CT
         PbyNYo+bYqLiffRSDo9EZhE9AZx/wKx6Ywt86/QncB8pAzfU4RJ1mLL+q1kGtjJ0yk5Y
         ISxBn+duKirsLg22BKIeyW3YpQwGyDEtM9Ui8U6Oici9ZuebcHizFRl4FxkpFBxmvCLm
         AQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308260; x=1773913060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMylDifb+sgwUdyQ3doSis8cOmZPRv2aLJLRsCDWhws=;
        b=YfovO4+AR5QvLvR2Pv5KFGpkIsuvp4vmsj3mLLAceTM8biTgoLeMt/dsDVIKxFE2Fr
         gr5LPNtsQnuPcik7Et9oE7J1LY4id0PIU60To24omYJwQIllRIGbPXDSJc9OAOV9bmNa
         yh3wE6htuCADLgEVMbQY8sVmYY2YSAnq+9wTpwu0UXvd0kOrCc8leFEiHSMuE1P2braU
         /c9j9OAmHnl4RKrcNVS/JUi0PoxTG0doopuCuG6JiLlb8uDMPN2hDjUY9PdbMuDNVStx
         UJsVzzMwQgq7nYdxiwprBNkvhmdPhmgZmKuiMfMxf5T5xz+xInGgPDIX7ZhToxvwRa6c
         wKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6V81+rHfG5F//xDzc2diwQLYfNQ1YhTcIZyIsoCgGKDdPZwP9XRRmFs/lasFyr/ognZW+l60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ukPdhnzGuMMbgFKQWsZ47oUH80j9JZSdburAFSwaOFwuiyXT
	ojSZcqi2oM1IlpFdDrusd/SMkE/E3ogj2ZM8ie6MLa+9sfyWEAlhGDkq
X-Gm-Gg: ATEYQzxbP8cjZ8VSqFXaHZ4An3cISfdEG5fvlJ3bOE/K8gLes/k0J5BEhMq1P57LgG8
	VIhBdlcEXihbSeCE6lWzjp8CprVSd+qWpy/7cC/k5foOsA6cMre9cLxPfC7moF5P84wZ1LScZcE
	77e0RlOtfSLuve2uBG/7TEsVxYFVke5Td2K/Re3d/a24DRpwIdZvXQhIhDvfIu8eHIvLdcHrxpE
	taFib4kSDp8h9rapIq9ZU52FQn6Bd6XIQWZlKnee1NlQ3cqLDp51BILGHpu0IT2JUuZoE+4geoQ
	FAppG/R2i+eXpl3HMY6/cqfTpIJ+hddnOYwoslCEKhqTFbLdyYaQzgFes6sqMQHkAIrM5EfABj7
	oVPR2+4vxoY9T5dJ7Kl7qvPi5yB2fGI4icpqinf5DjZcjpeWkRSCvLiL2PT1uTS+hOAMN4Frg
X-Received: by 2002:a17:907:9452:b0:b93:8995:8f3a with SMTP id a640c23a62f3a-b972e1ac726mr317393666b.3.1773308259284;
        Thu, 12 Mar 2026 02:37:39 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5560::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de82bc0sm114022666b.27.2026.03.12.02.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 02:37:38 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH net-next 1/2] ppp: disconnect channel before nullifying pch->chan
Date: Thu, 12 Mar 2026 17:37:30 +0800
Message-ID: <20260312093732.277254-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266959-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3FB626FAE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ppp_unregister_channel(), pch->chan is set to NULL before calling
ppp_disconnect_channel(), which removes the channel from ppp->channels
list using list_del_rcu() + synchronize_net(). This creates an
intermediate state where the channel is still connected (on the list)
but already unregistered (pch->chan == NULL).

Call ppp_disconnect_channel() before setting pch->chan to NULL. After
the synchronize_net(), no new reader on the transmit path will hold a
reference to the channel from the list.

This eliminates the problematic state, and prepares for removing the
pch->chan NULL checks from the transmit path in a subsequent patch.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ppp/ppp_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 6344c5eb0f98..ad480b584e25 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3032,12 +3032,12 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	 * This ensures that we have returned from any calls into
 	 * the channel's start_xmit or ioctl routine before we proceed.
 	 */
+	ppp_disconnect_channel(pch);
 	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
 	WRITE_ONCE(pch->chan, NULL);
 	spin_unlock_bh(&pch->downl);
 	up_write(&pch->chan_sem);
-	ppp_disconnect_channel(pch);
 
 	pn = ppp_pernet(pch->chan_net);
 	spin_lock_bh(&pn->all_channels_lock);
-- 
2.43.0


