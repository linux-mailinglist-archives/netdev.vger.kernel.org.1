Return-Path: <netdev+bounces-253323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMNFM3QGd2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:15:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DA84652
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CABD300103B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0826A08F;
	Mon, 26 Jan 2026 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYiS41Hl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBD225397
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408114; cv=none; b=Yk86XYRGz62kqr7PL+M+On3mLfeunHmRgalLWzpzRYCDFSdUZKM45+20Q6a+KnAAhbeB8UGytoxYu4HA8jAxYn/Jla0ZRUjXUCY9++VUobZ/UEiUSjZNVNb8xjrW96Pghsvlf74tu+L44MS6SmVqPFXhkPtOsO0p8pfAkqo4LbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408114; c=relaxed/simple;
	bh=Gr4+bhITkx9F49J6vCV5YDDpTEU83G+mJCTwFLDDtl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bInCZTQCulVY+tc4KWZmobdcQSGYwwSiZcfsc4/kd0EBb1U5/WeaIFwYE9YsUROA4gQe0Ugv5VJwd7v4LchWu3N8XxNQSmhxXQ5C3xC5qvgTolhbUJQc83WX6gTg1nZcEfVQfnYtNOa0YeeuZymYkEGIGa/Tr95nvw8r5drhIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYiS41Hl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81dab89f286so2039458b3a.2
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769408112; x=1770012912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiEoE4nGi5AEu3XaJSow5Ow49M6nU87RQ3hnz+11yU=;
        b=NYiS41HlzXQaZ7aCKT5sG17Ja2vaerxgtfqI3MwSF/rEJTEBQN/2eR1wm+H3rY1kp/
         ZVeBolSvqrxx0kMN5JYn1ENE/TxVOgAjJpG+1pvICChaygp3t1sDW2C/RkbLqWa01yT0
         KNu9tgm7e3azoS+4LDL5oj0sr9xPvdu0hpwWc1cRuu+h9jTB7T0Sn84byPoFwejADxM7
         hdiXYhS2FBJ540mWNj/sBO7aPiJTb9MeC7m9HIVCuN5d5VFuaHlD2OhDerM+MdrLhtQZ
         WTdue9mzWP4NHdZwATskHhGQ0VBHSrUC5ElBP9xJfmbEHTB8cmvurAgcVnOjuGGaKBTl
         IR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769408112; x=1770012912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFiEoE4nGi5AEu3XaJSow5Ow49M6nU87RQ3hnz+11yU=;
        b=EfDXiF71xzICupY/MCNFiWgD0p7qP2tMw83lAnqwrzg++58JpraElaKI2b0E85f0cm
         Ix6YHUKwZed4H63oVQViGsKSM9pw0rt7vmMYxfdptrhKKwUmC0GdLF1Re/2yuYc9w0F1
         /NXia+soX+cs6gYQQnExuUwV3nqadjAFvZr9GDLanLH8L5Tw+pjZ7fHRxMv1xFPui42I
         mRSqXlFve8WdJ2yMsZk0lhf0gBSiTlshj6dp82Fw4C9DCkOPlHdmI+DWUXQyavVLS/xg
         /RRtgNBU7P+J7zW9l5FhmUCK5D8tQYU+sryhL4ak5w1dZ/r1Pug6gF8kIQVJPF2g0J78
         O+yw==
X-Gm-Message-State: AOJu0YzBHlOWPpMvmBe4NIuC2bmDgaDBPXhJZmil4lue+bDxYyL+rbcv
	DdFWvAD+iK3sRtpzYWDbt/rp8WpY88WT9IH/vNrYmPNRdaS4BHdVdpiLEiyVlQ==
X-Gm-Gg: AZuq6aKjYlGhL1tQO8BXGCBMWo+0onC6j2Bd3U5B9xnW4HKLFv3CRuzSD9xEK6cdv0+
	hTuBUDvlrO1gfzTVznd52TTOpQpihNU+KhPw7Vsi2sdXaW1VMjP/eLyPW2YHt1Sw1w7NxOnkPxR
	Fp8A1OUHG/oNnfKUw1f+qUSrzi+PGqXNR5q7XtNtL0FQVFsoO41O3UinVzUgRJvXslPQJLXGuIq
	h+Z4IfAU2SYJu63cNCSfNtl3EK7TfjPXeeB/gUbTzAxMdYN2FlpUDIUB1ClqRYJE65WdE+I3rjV
	59YKleX876K4s5ctRySiGbGWPZdv0Zad9lL2+qZJo8XnmxCFXFfJt+NOHmuYcHksEOgR0LyCsVW
	gxP+d45XQR+kuUzN/RCMNTYXXYkfz255H6x77sACmizlxSa2sr1xdAJuFZ2ojuPudCpLJ7qdf3Y
	2y1oj1Ln2xawYdYyRUN7fG4gY827qPzJfiR0oukJZ2ZcD3mZYQpq7IsA==
X-Received: by 2002:a05:6a20:1604:b0:38d:e716:c1d4 with SMTP id adf61e73a8af0-38e9f0f3ecemr2689078637.3.1769408112024;
        Sun, 25 Jan 2026 22:15:12 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm79477325ad.44.2026.01.25.22.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:15:11 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dsa: sync dsa_mall_policer_tc_entry with FLOW_ACTION_POLICE
Date: Mon, 26 Jan 2026 14:13:28 +0800
Message-ID: <20260126061340.757543-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-253323-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6D5DA84652
X-Rspamd-Action: no action

Fix tc command which should not succeed:

  tc filter add dev lan1 ingress matchall skip_sw action police \
    pkts_rate 80000 pkts_burst 100 mtu 1000 conform-exceed ok

David Yang (3):
  net: dsa: sync dsa_mall_policer_tc_entry with FLOW_ACTION_POLICE
  net: dsa: add dsa_mall_policer_tc_entry_type() helper
  net: dsa: ocelot: check policer entry

 drivers/net/dsa/ocelot/felix.c |  4 ++++
 include/net/dsa.h              | 25 +++++++++++++++++++++++++
 net/dsa/dsa.c                  | 33 +++++++++++++++++++++++++++++++++
 net/dsa/user.c                 |  7 +++++--
 4 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.51.0


