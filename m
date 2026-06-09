Return-Path: <netdev+bounces-297347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hOhhOnugKGq4GwMAu9opvQ
	(envelope-from <netdev+bounces-297347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED553664C48
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=fVyZQyCV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297347-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297347-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B580300BC89
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EB3749E8;
	Tue,  9 Jun 2026 23:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EE40D58C
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:23:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047413; cv=none; b=EHcQIPKoYbc+3hJ9ujpO87JCWJ3Dxkv6AOu6zvtimE33zWZk91CyVqxaJDA9vTEGMyL8o7pAfQH1cHkxOvOR/gdabyf6/tj42002aBnDx3tOOmcuuCvIYMMKu7rCBphd61XQFxSP6c36wJeUF4VvkKErCx1s5H80aqiiSagD80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047413; c=relaxed/simple;
	bh=/moGaGSyE23xwp1CWmNIIXZGf49bTpQJ/4nZGzLnW64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMRkJQvxBd/+SG36W15h4IjYo8Vis+1FF/E5rBT3wlq/WNR9lq67px1iNLEeQx3hViv9+btTYc2IsS8UOnqqpIUr5S5LTpCQ8N97CcN66pIhcz9DCuxZkM4bQN/nv3ZkhmYquyuBFmwZ1vvXG7RdzXloT3XqB0CEu+iSpWI2kXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=fVyZQyCV; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5176fc0cc72so61821311cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781047411; x=1781652211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYN2/VUfjfy9nXjDQ56HkTZcEt97aRnd8nCnumbKYN0=;
        b=fVyZQyCVDNl4tYoQVK1/K7jwqV04c6l5gLy++3lpBswkhXDvU9n9a9jb9o4dXoGASi
         8r1jql/OyAJPP317i2e7+A9BCag85t7bfoJwu73R1rMaoQNlGhXorLVvhiqMYuu9/L9Y
         5EwLMXgHXg6FTeaP2qv7JxZwfhNrCWqJ4eVzylcdTPF6ifKCa1uWDd/+OP1EsiG53dWG
         2+Vdm+BbfRUAQch17AUMytUP8mhMfSvlqW1oG+n8P2zKcOqYgD7PoV/eaRlBVkxUv7+2
         vM/saj9gmqBaU/+YcKmq3v4BnJVB1VmCyHOYruOcXgWjuWOYV9NBFGlEhO417av8A5IE
         ayAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781047411; x=1781652211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYN2/VUfjfy9nXjDQ56HkTZcEt97aRnd8nCnumbKYN0=;
        b=GqqKBYfaZPvFTDCAqxJlHP4eGFOzz5OQjkPSSQGy1m4ywRUU6Cwl8AA/9uJ4IJ6qdP
         ICnPYvcDe36MJFBAEfnqVzIpfzq08ZVW5nbeCdLLn+FFL0sipDGW2BkyKS+nQgtjJ5ZS
         i/tAtl39WiSqTSf+GwJ4or3glOPo9c+EnNTYWenGkH8nycf0tOxPCntdTquxp+pH6upF
         abTM8lpOnMLPbiL7oQRmwMeyJ/9snsmpszVlZgtdzXY2pLuakXzjA9ttUpnpwUfLKx/N
         u9DUXAWLHsWROgl47nSAOfd8+JBrXmsEylg7XkKsasQw2MGLDLBRMTsvBKxSZSf6C5U6
         jQpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/195vYQMoVzIFYYkfhFlRLFrYWfwM17VBHd72n+/S+WND3ZQ1ji7XCRxyRJmTB/NEmJ7uIy4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkb6oOXsonAkaDNJqrMGDwo53XmOoTejrMxpRg6GqkFwYltPy
	HoUBnlRlZsGhpkydRrcCSUyDy/P0qWqrkWs3qRmrpd3AVf6IKQW+Q/EYMU2CTBv2a/8=
X-Gm-Gg: Acq92OF/TYfU8HnCvlleFA2JFahlzflk6dt0kYfEh9ehvd2GANnpZx6D69srjSZgpX0
	i/pOG0VNDYxGkksNAqJfgwsSA80R5Q+o751w+9VEvPcMEaRHW9/hAs7sJC3pWsN+997KvceD4vi
	cecEFNu7aXrwefssXPLlwbUCFyUcxMaBn50t2M2B2xtJEENhzTqn0FqdWm8kXpoLrjP6ege8ozA
	DEsHbkjWL+RvZmyeqjuRTqI6Sc1XKz6S60tJzA99NIQDvWmpw5mgo5+2iVTCf07855FnzO0Of2A
	01ujIrV9MKGWwm9TfulFTkQ58MY+bEKBIW3HtsmRv2I2CKGEcdUwNakZu3V3Cm349TJFrgiGwvS
	Xt79W9LuUs5OFHB/IDaMlcj7ifDjfueSaJcOZvGHOyTrD+kBmo6iz3WwSvG316moOkNiYLFJJqn
	oOTfGrB4l3Z+X2HZgbfmMFBAGEHln7FSa2Daqv7g==
X-Received: by 2002:a05:622a:4a0c:b0:50f:b494:7887 with SMTP id d75a77b69052e-51795cbf6acmr332005161cf.51.1781047410817;
        Tue, 09 Jun 2026 16:23:30 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd053032sm224336396d6.24.2026.06.09.16.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 16:23:30 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: pfcp: allocate per-cpu tstats for PFCP netdevs
Date: Tue,  9 Jun 2026 23:22:45 +0000
Message-ID: <20260609232244.1602027.c569f6c530f6.pfcp-missing-tstats-link-create-oops@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-297347-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:sam.moelius@trailofbits.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wojciech.drewek@intel.com,m:marcin.szycik@linux.intel.com,m:aleksander.lobakin@intel.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED553664C48

PFCP uses dev_get_tstats64() as its ndo_get_stats64 callback, but
pfcp_link_setup() does not request NETDEV_PCPU_STAT_TSTATS.  The net
core therefore leaves dev->tstats NULL for PFCP devices.

Creating a PFCP rtnetlink device can immediately ask the new netdev for
stats while building the RTM_NEWLINK notification.  That reaches
dev_get_tstats64() and dereferences the NULL dev->tstats pointer.

Set pcpu_stat_type to NETDEV_PCPU_STAT_TSTATS during PFCP link setup so
the net core allocates the storage expected by dev_get_tstats64().

Fixes: 76c8764ef36a ("pfcp: add PFCP module")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Added fixes tag

 drivers/net/pfcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 28e6bc4a1f14..a6aa30ae0af7 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -148,6 +148,7 @@ static void pfcp_link_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 }
 
-- 
2.43.0


