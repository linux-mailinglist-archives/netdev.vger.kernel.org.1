Return-Path: <netdev+bounces-282023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPJ+Hj3u8GkvbQEAu9opvQ
	(envelope-from <netdev+bounces-282023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:28:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A2489F48
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 119BB301B8E8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B03D9DDF;
	Tue, 28 Apr 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPLtyoQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5838D007
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397295; cv=none; b=tLIBLsu1vqVsyZrDCHXLgQEhFXzG1ZXQq2FEMJZyDp33Wbvr2UyTl5jr302r5sWIuPC/Nz/8VSJZ80xDuVUn5OQ1GbK4I0g651AuNVO9bhxNcYsokiX+TftdpbIaB0EurwCldHUgtrfgVQDn2GClTy9elQN6BL9sG5jt8D2jMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397295; c=relaxed/simple;
	bh=Ov6Z73OWB0yJ4KhzvnjCfgONZrE/JXPnnvASVYe6Hxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkLzfumqGAu1qUFET4OUV0LdZSH/kP9t5Tg1xQpa0TDr9CPfo6NtwDEDgcJCuCeltl/uHbepf5DCf5qlnmCqxKX74DO7Bij7P5hM2VVNm2SglfgpSaCqAooWb7S329T9Hkj/ornG1C3R4yUCKnY2/qXmK487Pf1u/av3NHjY6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPLtyoQ9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a15ebb3abbso10915346d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397293; x=1778002093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DkiXZIqoja4hUdiY6GHZgLnxhAYGb4XuXxmU5ET7Mw=;
        b=ZPLtyoQ9xiegCAbx7HQ79bLy+FmRyrSXges1G0+sRd8VnvQqbONP16vRl+NxOPsIKN
         jV57USVWtuTn9kjodKpBThJI7r/BrO682D1prXDb6cRrc3azE4SNoI/jS9sYenDXz12V
         1FkE3cbRvgpIhhHZcExtwJ7RWM52HVqxrwgfgc6rOYQHbxcW8yzRrn0sL5vO5mnQcaQq
         +viiig5l/hBjWSLHqkk5jQJZs/gvRfnrRb0T6EephuEFgMx2XnHn7KgMBazqY38Av1Q2
         BtvewWm77agQj5s7lmwaa6tWwZm98d4T7kYaxt7aTpyTnT+sdJcwSz6TgAf+tY9N51qK
         g1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397293; x=1778002093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DkiXZIqoja4hUdiY6GHZgLnxhAYGb4XuXxmU5ET7Mw=;
        b=T/R/lXLVBqKPaaz3c4SDgd33S1S5EHDUHxDfyNTdUu4N83aDCtgzcScw357ko6o64o
         jNgANobTniW/sfsUpfb15TUzUM9A4zwHs6NeND9ovVhS7vOUaN7qncLebZuPx0UGVU7q
         H0KxphvxG+4mwiKDsy/RIl+Sd60KCc9IXwTbeYvtuzh9/mTrDhIbOi2zcdlfhlUW4nMe
         pAfIVzrZflgc5fGz+0EGdn3+HUnpZzAKgWdAhHvjAFQDgxZQcYRw23Vmf4tw5d2IMfbd
         6nIfiQFVIidoKpqXTTgfUNqsdOnQrERTIPh9UGoM9+7QDRVhEyojstNzOaiaP5bJmRWL
         gQEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IcYMg/BpYuBJTqsy9gdnksr04Wl+AsenS3Q5qEGRCgKICL4H/5DqcR00NKnrFuHHi2W1JhoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyddyncBMH85yuy9a+/gWgwsKPf+u+uSTQNFVcqhnfeJNItHK4t
	rzr1RgzfBShgnOI06YaeLFYE7xhoVsqxudMrktmVSh8+fsKulpem/ttP
X-Gm-Gg: AeBDiesSWHQD3cmHauCpWu8iwHX0rGobd4Mp5TTmu36x5tEPl6XZf5Rr594bpA1DmwE
	2M/ErSU50lS73jzmifUtNEYcylBNpfKfYQO3xqkClNOijcMan15xzqeXHkdT+X+UjNgV/ScBriS
	2gSyfEr3iO5bvA6Fq+vhheoXeIRIrmNDsYIrnPNmEZYTVXIT/+fTamTyCC66vTKpKqjtBuNp4TR
	BvXLuph23E9i9j7SQysMAlNo7sdgzSOUb7w4vBWNznS3RY+CMQGzYaK0lbuPx9BiuQJrMf98MXf
	LUZP15Um6ID0NM+ArsmClG8oulAZ0Qjnw3089YZNwdR7bS9IC1eBbJjnp7ti8bcVmmt4udh/O0Q
	hY8VzI401fhhP17JTtWWt2hUYKK4JjNmmoBi2seidvRU3pwHOjF72ZFtm5VwA3LcD88+WtLIJkJ
	e4GV30/RPOmXuT2EHBJnHP9mvcSh9psjL5Me47nmNEWsu+0OSAJKx1OtAEkOF4BGbLlCA=
X-Received: by 2002:a05:6214:3f8a:b0:8ae:5ff7:fb32 with SMTP id 6a1803df08f44-8b3e302c005mr76384536d6.6.1777397292590;
        Tue, 28 Apr 2026 10:28:12 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e299d76asm26253676d6.48.2026.04.28.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:28:12 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next  0/4] first series for xpcs based rsfec configuration
Date: Tue, 28 Apr 2026 13:28:06 -0400
Message-ID: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 080A2489F48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com];
	TAGGED_FROM(0.00)[bounces-282023-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The series:
- Fixes an addr validation error
- Adds MDIO defines associated with RS-FEC
- consolidates the handling of the boilerplat ID registers
  into a routine to report id'ish registers and reduces the lines
  of code across the entire set of c45 routines.
- adds PMA read/write routines


Mike Marciniszyn (Meta) (4):
  net: eth: fbnic: Fix addr validation in pcs write
  net: mdio: Add support for RSFEC Control register for PMA
  net: eth: fbnic: Consolidate register reads for ids and devs
  net: eth: fbnic: Add pma read and write access

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 129 +++++++++++++++----
 include/uapi/linux/mdio.h                    |  10 ++
 3 files changed, 116 insertions(+), 24 deletions(-)

-- 
2.43.0


