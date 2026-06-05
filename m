Return-Path: <netdev+bounces-295726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zIvKIMGNImp9aAEAu9opvQ
	(envelope-from <netdev+bounces-295726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:50:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F264693A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:50:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="r/bmu2rs";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295726-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295726-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BB6A301A7C7
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641131326F;
	Fri,  5 Jun 2026 08:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A363D9035
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648967; cv=none; b=tnOyXyrBIgp+2MACJJZlvL8AigipwMd2COGLWLDdv3NpS0/u/S4bbLTJ8nRnjEpemGc9UQdjQfHNS7aDgfHfkUIflZgrdwvnhVgxZZWpgiBtQ3K1gKqjdzEl0skCcRKoSmKpik3FGmiMpmxkacHocZoZG2W9T3Apg4J0AStn/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648967; c=relaxed/simple;
	bh=oHIXLuYzIBw7a37yAfN6c/LniYTZOWunKxnbo9VfqHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3FX+uLjoj4+iUb8Uc8AcqcHbJw0IerlMPeZZEnzK0ToNY8Tkw/7vA4bebCAq/oFxDQBAO0gTDQ9viNOvBqyIlogR51SdzfsBWBahsUNDC9DWrnF3saByXpeTtv2WdejiSLJmy7bj+POJZhjb4I/EiREU9NDgQTDFXXxMMYcGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/bmu2rs; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2d792c8so11427125ad.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780648965; x=1781253765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvqlHjcbwyGRdhAJkKALJZgP3oME5pVGmYOXUhA+Uvs=;
        b=r/bmu2rs3dnQsOBuVakQSMW5GAFMCCGiscmhletwaZDO5wku2b3R5M+U/2+7GjXHB0
         M4UZXkaP5+ahXbGMdrcuQeTEE2QGoqUEEjCTyRUsRIOgeYuP7L2nlJI8Yn8g+37bk56W
         DFZjDIfMR+Tl2jty+bRjjtt5lHOY7J1lC6thUvT2qC/UHucINdMj8DgTVQ710+yIti0o
         ejVLPgrwgxEx+n3PVq38hPJATKJodhug7E2iFVctAPXIuuYEAec0zZCwLk+Uql0dHsaB
         VJcvwQJ3KYrZ7AliDNps36pHpZqB0e+BobKaaSjOwMxtn5CS+wPz7XOGDQLhKzBBC8aA
         yF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780648965; x=1781253765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvqlHjcbwyGRdhAJkKALJZgP3oME5pVGmYOXUhA+Uvs=;
        b=QUsdorbkGzJOytrLDv2x2/A0Nlq5WHpPOvMQvNciWwE/M63Vn242MmZiId4RpmVgFk
         VOxXkTfQeG4nn12Y3u5f8CCRcs0EDSLAVsnU+PZmRUK6ddAkrF9mpHKqeKO8oXIXUPQk
         zLeG+mYLCJ6IC6/g2uKj6bM2Ca2hx5rsQohfcCFesxKbsSpuBB/vj779Hoo0LxlgYlLg
         5XNRTHQdpK2vNlfRN2wysi/vFtquGjpeIhn5mbuqcxkNytWTRsvlRHkvJrn/5qGAIZM1
         v+ZGpv2/NXbk7DCeVHJswSycSywqePAVvVakoB/4723i6OGEXfWJBy8aG9qddfjnJbC9
         +TXw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ku/ztGyMjogoHrfSrhVW1llVyEZLg8lOgvqpW9smLofH4pNdoup3hzjz2Pkap1yYt0SiCm+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfw/IFQ2apVlGCCU7lIGYaYqoJmxGou7gWR3wooT4gKY5dP9kk
	xgSfh0GFWprysOsxc1c7F8aOdHftQUN/tWtfQlSd5HNFZHHIl2RsgFA0
X-Gm-Gg: Acq92OFLMEKAUiqtshV6YcCNnq1bF+25XgjSbL7lEljc6xwRomwWGt5QpMekRkPlBNF
	JwmAUJ7vVvnuES1fdazWiB2+RMzPBQDYSHd84MdhPMFw+2AygCbf+n+IjRcUim1NLKGbdoHXGsN
	nnQICaGpmmWjr8o9CymcNI+tKtDMpOK7/IRgzAMuT4lVgs65IgGRE997qgpID6HvMOTlGe9pD1G
	qMsLdwfbHi4b6X1hhf/2aMV3LhRA9c1Ab/g4OXkgXWHsyjl9wXLGqxZMb/xVfZ5C2e52OWjuDS1
	+VKCn8xGLvK563ME91AVdwicTKC3m0wUcCYbatGRMJz9AxK7skGN5PK8y9q0RZVeLvFw4FWdzi9
	CXAPDRfIpBb1jkvZhl9UmlbXXZZBB7ZLrt8q8mdk9vgo1el+sPbvw4LCTBCdsbubvdawWZ0npat
	RmgtmFPxS3szb4DXyh16yufmS9dLk9UZMANP/w5wt8kS8XsNEml7Zb9mpMTJEepzRqIzaPJi/0Q
	xUH8dtJv41dXYQSj/Uv/624Ng==
X-Received: by 2002:a17:903:3504:b0:2c0:ab82:6b9d with SMTP id d9443c01a7336-2c1e80edc43mr25916515ad.29.1780648964638;
        Fri, 05 Jun 2026 01:42:44 -0700 (PDT)
Received: from urbaner-laptop.. ([61.70.109.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm84879065ad.44.2026.06.05.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:42:44 -0700 (PDT)
From: "[Ko Han Chen]" <urbaner3@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"[Ko Han Chen]" <urbaner3@gmail.com>
Subject: [PATCH] Document: Fix missing reference pages
Date: Fri,  5 Jun 2026 16:41:30 +0800
Message-ID: <20260605084130.13363-1-urbaner3@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295726-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corbet@lwn.net,m:horms@kernel.org,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:urbaner3@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[urbaner3@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urbaner3@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hackmd.io:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE8F264693A

Today, my friend and I are discussing a wwan driver produced by
Mediatek. I am reading the related document and reference link,
then I found the page is missing. So after a short search I am
giving the better link and test the two pages with my bash
program for more dead links. It turns out only this one. I check
the page and the following documents. Details are covered in
this markdown [page](https://hackmd.io/@Urbaner/lk_patch_doc).

Signed-off-by: [Ko Han Chen] <urbaner3@gmail.com>
---
 Documentation/networking/device_drivers/wwan/iosm.rst | 2 +-
 Documentation/networking/device_drivers/wwan/t7xx.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/iosm.rst b/Documentation/networking/device_drivers/wwan/iosm.rst
index 6f9e955af984..d28a922391ce 100644
--- a/Documentation/networking/device_drivers/wwan/iosm.rst
+++ b/Documentation/networking/device_drivers/wwan/iosm.rst
@@ -84,7 +84,7 @@ session 1.
 References
 ==========
 [1] "MBIM (Mobile Broadband Interface Model) Errata-1"
-      - https://www.usb.org/document-library/
+      - http://usb.org/document-library/mobile-broadband-interface-model-v10-errata-1-and-adopters-agreement
 
 [2] libmbim - "a glib-based library for talking to WWAN modems and
       devices which speak the Mobile Interface Broadband Model (MBIM)
diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index e07de7700dfc..fd532a7e225a 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -187,7 +187,7 @@ References
 ==========
 [1] *MBIM (Mobile Broadband Interface Model) Errata-1*
 
-- https://www.usb.org/document-library/
+- http://usb.org/document-library/mobile-broadband-interface-model-v10-errata-1-and-adopters-agreement
 
 [2] *libmbim "a glib-based library for talking to WWAN modems and devices which
 speak the Mobile Interface Broadband Model (MBIM) protocol"*
-- 
2.48.1


