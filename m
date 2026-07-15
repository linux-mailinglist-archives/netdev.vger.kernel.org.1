Return-Path: <netdev+bounces-307667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V9FWDz0hV2rCFgEAu9opvQ
	(envelope-from <netdev+bounces-307667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:57:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C6F75AC92
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:57:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=zsRXIQqc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307667-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307667-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64D2F3018C30
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5863B7B6E;
	Wed, 15 Jul 2026 05:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33203B7B96
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095018; cv=none; b=PP8womkDmv3jtTUglIR4bGfYCRtv1r42TEX4y3W2P/PKcYF5zoElWon5nj9bIAuoeuengoUsmGtts+xw4uLA5dqXSmTSr0QkmJBXmArBenx8pBxQ5lZkzOFE9Bv8BsavVvRT5iiCrjBksCnfk9spluPSmvegdkP9XI7QV7dlCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095018; c=relaxed/simple;
	bh=JUgcjgzKZlD5NiT4TvdYD0wcCzeZqi59Xs+dSlvz/vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLZKPEamjBeoD2ANb+lkcvPRmnmLhuVzK13I0W8Isx751aaaz+BHn2zOra7JpgoHot0/UjvidO7LOCexiSZzsfcCcUYbKFb+gi7csaMp9k5p2xBLZFs7wSt/uj2AhvhiKMh9hP40h4xI3RkOqCuldceUYJ5spfuLjru3EdTM+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=zsRXIQqc; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-474560436c3so1251593f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784095011; x=1784699811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLDox969500edpp7yPoO2VoVcW+rCs50A1jCw1l6TY0=;
        b=zsRXIQqcofkfwxoSezx/3qtFNEyDgAwMVidWUs4ekiRFPvqJEJSDr0z01FEDlnblsa
         /3+LUtTvqGXMrVN/HYTJ9kwNsuTRcZwsOlhqE/Mp7/gkIeGzegivtSM3FI6JVpGj5fPZ
         EMOLNHMNWosr0VfgwDowuDgczfiw55UV6LD8QkUky6R/gYw2GpMtosMADIHmUPO2yOeg
         bs0V79vjbW3tHAa6E6qWiAC3KdHGFs9s02ZHrGHlptqG/PuxlgslDkX+XCSybFm37jPT
         lqY/d/K5tY9PrhYtbO5ULEFcrZq/rP3air+2QhNbpdZY/H045JR71rW3jl6ruIkuplgm
         Oe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095011; x=1784699811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLDox969500edpp7yPoO2VoVcW+rCs50A1jCw1l6TY0=;
        b=jNlcNwhTWpdaJnWLu9W6wXJso7SBXYg+lmQV18QbqklouH4DR5hQDXM5epbFX+R3cU
         grD6CXrBY01t7aMdTlTGQjC2DPEWTar3xxK5dsSv+rbVwm6UL70B7YAI8CCTRWBIv13A
         VVliPqLSyGfG5Q8H2tKSiTNMVa8hpBF1kOjQ1Dl2BiVHIJ+bcsnwSq7xGZojVImhM3y1
         4d3uCnM1JXc/IXPoZ4J6vZl4NwbRMsJcvUp1dj1j2AX7qltQ1NAKtgrtKbQd7Vnjt407
         4ecIXvMMm1Fa4CVDhxUMQB1IAC7bt+CFiD0kkxlgQpfJxCEB09FXrd/3ZuiaDz4vg0Sg
         BZKw==
X-Forwarded-Encrypted: i=1; AHgh+RrWU9JM6DnvTCudn5r+WGUEsRiZRDl9nAKYZ18sEglv+zoekZI9U/imAqYzD+4C2cOuJYSKh9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2ICZUTxcfG8kj3PefKF7dXmyuvB3TcBbawgB/a+FBj8N7DMQ
	2GN7gbCcjAr9JLsKW+lNCZPsTvvZ9KB0JiKNvR/GTDejH1J52SBbBy86M5LrYuybl7xW
X-Gm-Gg: AfdE7cnlc1yyclnCNy2f4OPtlFe1XzYkEcexCuWbjfGwHR78kL4wTzV509+STiNPmbQ
	o71Fo8WD5J5Hfr9RlQMy86FzXvtX1zI4I/YDp5Gqj/Isl0cBbllsdNe2jhT9Yax9/yta8e/GSBt
	WhyvsWoadjA8vEN2Ayf+bw1ATA6zSqcHuG9jPrTUfHUgSXtSTOId1Jy3izbQScFbe/PacDtva9+
	xprUZjrkl2KEin8uIr5ImmYzD1bQcYNdd5MWuihotFR6MFf40fac8Pr7kmCKa9E3tjWL9peS+ds
	np97ulfPGe4SBYLpECArScrfvvR+zEHh+ZIdJiWzvLpNUXgHFRygevWWWPtgrx3D6x3uwVe/DPp
	TxbCHoIfOAZlL7u87GFwLRHkxZiC+nFY3ijechWikMBhM/x5aBNQhTLQWI2dT9NGFxNVxhTuJP3
	kFycjFIV2E3SBEh0zhnOMF0FMFGzSUFjegRsPfHwT8N38bm7Y3nJ68pFSXbGkBderZfDd2ysMA3
	eVx/WVOgqd4UthHJ6IN5vHv2U19gTFOEdw=
X-Received: by 2002:a05:6000:4b1d:b0:475:f0d1:eb59 with SMTP id ffacd0b85a97d-47f2dd11257mr18449527f8f.52.1784095010720;
        Tue, 14 Jul 2026 22:56:50 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm14220369f8f.7.2026.07.14.22.56.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 22:56:50 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] vxlan, geneve: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 15 Jul 2026 07:56:46 +0200
Message-ID: <20260715055648.33060-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307667-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FREEMAIL_CC(0.00)[queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:sd@queasysnail.net,m:linville@tuxdriver.com,m:mschiffer@universe-factory.net,m:maoyixie.tju@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6C6F75AC92

The recent series "require CAP_NET_ADMIN in the device netns for
changelink" (8165f7ff57d9..27ccb68e7ccc) added rtnl_dev_link_net_capable()
and gated the eight IP tunnel drivers (ip_gre, ipip, ip_vti, ip6_tunnel,
ip6_gre, ip6_vti, sit, xfrm_interface). VXLAN and GENEVE share the exact
same shape but were not covered: both store the underlay netns sticky at
newlink (vxlan->net / geneve->net) and their changelink() operates on that
netns, while the generic RTM_NEWLINK path only checks CAP_NET_ADMIN against
dev_net(dev). Once such a device is created in or moved to another netns,
a caller privileged in dev_net(dev) but not in the underlay netns can
reconfigure the tunnel's underlay.

This completes that series for the two UDP tunnel drivers that were left
out. Same helper, same placement (top of changelink, before any attribute
is parsed).

Verified on next-20260714 in QEMU with CONFIG_VXLAN=y + CONFIG_USER_NS=y:
an unprivileged user namespace holding CAP_NET_ADMIN only in a child netns
issues an IFLA_INFO_DATA changelink on a vxlan device whose underlay lives
in init_net. Before: returns 0 (reconfigures the init_net underlay).
After: returns -EPERM.

Doruk Tan Ozturk (2):
  vxlan: require CAP_NET_ADMIN in the device netns for changelink
  geneve: require CAP_NET_ADMIN in the device netns for changelink

 drivers/net/geneve.c           | 3 +++
 drivers/net/vxlan/vxlan_core.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.43.0


