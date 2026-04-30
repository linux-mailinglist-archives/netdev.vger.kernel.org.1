Return-Path: <netdev+bounces-282894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHcFHwRx82m42gEAu9opvQ
	(envelope-from <netdev+bounces-282894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E94A47A4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86B5A30193EC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F131F9AD;
	Thu, 30 Apr 2026 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRuHsT6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C322DC783
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561689; cv=none; b=hKuLbCdpAYcM9x7n5BmxE8q2UgPGEUOWnRCriBNPVjQbj2/UVt0+ujmR7AXqiZ3IEtN2nzF945KI/Na/DsJi5MI0pqPIRmVRVn5wzYWon9MI2w6sPWB4ZaTNfKkCBRrV8ldHmeeUpeHaBY57bhgTzmS+aemXPpwvkOGiIZA6l+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561689; c=relaxed/simple;
	bh=TvP7ZTDOMHBu/ZdHZdb2POMtxrpsyT8ynEDaZnjecUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uix8RFyGVf/ZyAwaFbCUBVNyTKWSiFhqk0h9frQ2sekKd3qj2dRfhjGPTNRiJ80y4V3G+xHQMVp9WvECSH3rXX8kAvJg9DI35a4ZBGLCa8Y2LuLS5K6Ef9qLQX+IboeWAF7mBEnESyDKdRiuqVzLzKrtwfUfCwJ+lrHs90eowYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRuHsT6d; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506362ac5f7so7161141cf.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561685; x=1778166485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILCkE3O6mXbfWtPYor9kKdKDv0oBBMcO4rocHA3WptM=;
        b=SRuHsT6dRhpEzAH+dsfisF9dHtvRKZNi4sZ4MEkUSqYYOZfc6Icq4WOhMTVuKnL6o/
         fzpaV4KtEg2IYpfeXQxFT+RbCtBQ80wttSZ9cIvShlJS4o+DFymnJ1CBYpkSxOxu66N1
         v7PNWm3wWQP2phWonAzJnUJrhtZYXSMRtp14DyPorwqUIrCQFfXjAD+sVHDtctzlrLtv
         AaEs/jXem2cZX8vNAyNnV+6w+9KcYlZwwGqs00RTzhu+oKulhKiOSxlPiq3zMJUQgdZ3
         jEJVlq4jAZ/eu8jPnffI53VeYkrWMP5QexBClQZX7dI2vMc+QZfaBYgTO31zTtUixgC3
         GUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561685; x=1778166485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILCkE3O6mXbfWtPYor9kKdKDv0oBBMcO4rocHA3WptM=;
        b=P9DsH89pPD39LPZWIb4LFIW01vNdHDGTeAB5+HMNETQMXluqHjwZLjz1e8YP7pRukq
         AE7T+y5n+SSAaIpbp2YbcV1wlRPcgqplUO85KEhYxhPC5CjOk/N6xBCK4GUllOWPx64q
         jt8qvH3Ek/B9VhCwj+ycYbq7wjWYK/5tAhsJTPbWoLuKqGMJTt5DxXhB9uy3zVKlPP/y
         ZKJDsRk3kY2LIJLJpjgHfmHo+9vd45pxohCtz3VLLYxhQ/m3A7M5pJndthhRhTrVEW2S
         9MQkBq6cYiMazuGzIzdtECy02KRjinrOI/Z2TEQN3cZV6ycvOQzgup7nZewKHoaQ2m/V
         F67Q==
X-Forwarded-Encrypted: i=1; AFNElJ/aJ/dEq3j26lFF0anHY4VRIekRX5EyRA9FfwhXfZuwHmnl5SUBbjS4gOJqDrtuVp5iRVHr2YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg3QjlV3vZcOQUaL1DOX/hfXKedn6JY483TLLzjRkKMcyebtuN
	mEkfCUtfO3KIhucVFbkYvpLMaFvLANw618XcFMZCfDiffFZCAoVY5hYY
X-Gm-Gg: AeBDies1h47Mog7skxCM5hEH4eLT5YmtUsLq2fgHSU2URYsBdhoHQIzSo7yKLCr8ItA
	YbkwguSdF+tqnHc4QdZHvug51socagTj15GUi2y8XS4FKFaZaUj5EoN+ZjyS8nsObIClEG3dueu
	TQ9BwxoBNzD99UCVkt+7dl7ICrBdDwdo+w3gnzIipIu5VAUQd9FGWgbx2gZKMrnM/Ii4RtVk0+i
	ba87ApAy4xsqiCM6l72nqpSRlrq3hvnbIKjjdUcFGhcYkZEKY60iUvp8XAXFXkCrVM+dYQRCdX9
	ebvErZgMG3mVk4NvDLkZT/Mf9CXr5y01d7VCXBnDdJ+EEtMhZIXZk4mZvGSPfXIMrWmNti/gQDb
	a6zWPxjPKdHCudmU+rH+RbpapJhY1z6ORqUTf0srgitVU4sejgcbN0OmZcxl9ijilQVtW8ZlvS+
	gqgxJBx35JAsaug/DPmvBCB15up9ZzHcC1vN1Ia+nGdEguXMmtMm8DRztYNXrOJWmKjp8=
X-Received: by 2002:ac8:5f47:0:b0:50d:ab9d:33bc with SMTP id d75a77b69052e-5102ab34ee4mr47569101cf.8.1777561684734;
        Thu, 30 Apr 2026 08:08:04 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b397c38sm450731cf.7.2026.04.30.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:08:04 -0700 (PDT)
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
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] first series for xpcs based rsfec configuration
Date: Thu, 30 Apr 2026 11:07:59 -0400
Message-ID: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 429E94A47A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282894-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The series:
- Fixes an addr validation error
- Adds MDIO defines associated with RS-FEC
- consolidates the handling of the boilerplat ID registers
  into a routine to report id'ish registers and reduces the lines
  of code across the entire set of c45 routines.
- adds PMA read/write routines

https://lore.kernel.org/all/20260428172810.175077-2-mike.marciniszyn@gmail.com/
has been removed from the series and submitted to net as
https://lore.kernel.org/all/20260429150049.1643-1-mike.marciniszyn@gmail.com/

pcs reads for DEVS1 and DEVS2 cleaned up 2/3

Mike Marciniszyn (Meta) (3):
  net: mdio: Add support for RSFEC Control register for PMA
  net: eth: fbnic: Consolidate register reads for ids and devs
  net: eth: fbnic: Add pma read and write access

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 135 +++++++++++++++----
 include/uapi/linux/mdio.h                    |  10 ++
 3 files changed, 122 insertions(+), 24 deletions(-)

--
2.43.0


