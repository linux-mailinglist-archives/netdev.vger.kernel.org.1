Return-Path: <netdev+bounces-286786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IWQI3ofAmrAoAEAu9opvQ
	(envelope-from <netdev+bounces-286786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:27:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34698514650
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D75C301E741
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D584847AF75;
	Mon, 11 May 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIDHwKm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296847CC86
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523969; cv=none; b=W7GvaTqEZlDldK6YaxFSQH/WPxX1f9Cw11JOstXNBMVA+fto5vPRTZ+PgVfro2MkpBkCnbGN6UxsxhagKZ3qeccfs2YpkMzo9rgp/wX0n/g12ejOn0lP25j3cFBCTUzhR/Mzm7Ao9ucSBJJ/danl2cw7Do+SjDuB/OGHhFCGBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523969; c=relaxed/simple;
	bh=FXmNtXUbdx7vThVryzbJFIbBeadePTLuGvZfVsHIQ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5zjruu4/7VRp8MAnH7PVWVIgHnvqvuTgavaZOQTSNMkh/6fZeOdA7bVR77zKv9g0oN93vPSUAPlCvQfzhofWZJv34Mt3dTKggzC2/TS3dI66GQIIo8sw6ryx6If79N+pKvrOpp8xGxhaxJl+Pu0oMjNQbbJ76u4xUq7wyJf4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIDHwKm4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8eab809593cso499599085a.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523967; x=1779128767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XcEDDQc14n6p0CoJQizeNK5cPPvfu6Vtg937a8mNsc=;
        b=JIDHwKm4FOnc9xtSXkRssgT3qbbyVu2kssxdwSHxf9VmEmxy6PNbVsnOojFn0xjCRQ
         FfAxmjBg2xteJEOaWNh7j3lAEbaC9YSehgiVt9roZNqfXy8FXSMPkcbUkyUuXS3nK9Iq
         pOsp6faeLsdmKReP66J/zo4mSyEulVvw68SgeFbVJP+O1LfnDX8d8gNtNpApkCxhOUR0
         9qLXQWuodwL9SXWBcqksoA3iKRR/gK9L8MYU2s25Oka2cGXRGf4PtUOnkjVbJ3Ur34uT
         8JTzBRTp07pdK6YshbtWEAp+UYQ6enbp+D9CbcPwFPJbJlpuMkrLTMYI8B3tydbFhXzg
         h46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523967; x=1779128767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XcEDDQc14n6p0CoJQizeNK5cPPvfu6Vtg937a8mNsc=;
        b=rEhCfpfCLOlVuMuZJK1G/mx/Qf/1f6gEQMKx9YeMKDF0EI1UmcEvJN+/L8daMjZy1i
         3NZzSop0iBBYC1rwOv/METEUHa9PzRfwcRyKk0rM15nQ00J9cPFa/7c0fHh6TrBCHKB0
         0NWNjZAOyIjRMPzC+31pD/RB4spAGIvVwpnQwjGtiVnwm3Uk+lwJUK25i+wQbqbsgjgx
         xWElhVLQ1nE15ycwV4uS25OFYBOhde4PWz9+Fm15cOqn3qZyLnhP6ofq3rcFkDOaSUn2
         Ua0LwM3Pnpnlq3+/Z80xOJMh/uNOHooaeYPwYu2a7OTpTZX+Ouu2HtNGYFoLpgWaD2G2
         4OyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zM5LIiVm13pfxpU6qecoFsL+VCPAVDrSmPUR5QOjgvAyiej9TQ6/BqpRxoos6c8uVtV0z8Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNK9cBT44jnI39MyH9tzwkEwu/6hWvnMi8YHPL67jbHCWGktIV
	oftbHZFIOEeYbfu11ZstfmUtyi35Pyq0EsxRKUFCro8PogkGZB6t+K+l
X-Gm-Gg: Acq92OGohGEB0In/E0Zo/fLcp2UDY3994Qy5EcnH4pAWTE6/d3+X0qI8I1PNIQVvK00
	Xtw3HgE3PtFls3vX7tB8bYV3cqtFYSnCcAFRQ/LRQyjU2JrYHT778rbyZ9l38AQBKgsiF+XmFla
	+Y35vlsZkmWblE7MlnXiRi/5hfBMAleJqWLQeKoNJbHrB6r1qtkKQvKZiZhGmfueEvXXrUIdAtd
	2LnahZKvn8FaqFF5TQFPObN4xz5rGKm0jofYPThou/6FS3EzKlvlFe5m/whXn/uBQbYFuoge/Z0
	idaU56nHtzVURvd5ND6+OXj3LMEZ90Ij7Dqzv2YT3pIJGSszY5zioR7gDiq50Sb8/j0NLh2y0RC
	wz736PVawGDpJyf4w0lM/woPrJkp2HRM9aER4hkRN/SznwNyQpReAram5IVSbQieWFld1wf11C3
	cyU13p7B9t/ztlyvWEtFCUfO0LDFP5SRybuGLvz9imN6/EKNr9oGVeWnAwcDGLiyIbk8l6Lz8Iq
	b0MhA==
X-Received: by 2002:a05:620a:710b:b0:8cd:9033:1724 with SMTP id af79cd13be357-9090dfffcbdmr1581752285a.9.1778523966956;
        Mon, 11 May 2026 11:26:06 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9ea06sm1111346885a.20.2026.05.11.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:26:06 -0700 (PDT)
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
	Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] second series for xpcs based rsfec configuration
Date: Mon, 11 May 2026 14:26:02 -0400
Message-ID: <20260511182604.1338-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34698514650
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286786-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This series adds to xxxx to add the necessary configuration steps
for the DW PCS/refec part of high speed interfaces.

v2 removes any use of a hardcoded address by using new helpers all
based on phy_find*.

The changes now probe for addr 0 and addr 1 to allow the helpers
to function properly.

Mike Marciniszyn (Meta) (2):
  net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
  net: pcs: xpcs: Add handling for 4 channel rsfec device

 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c |   3 +-
 drivers/net/pcs/pcs-xpcs.c                   | 194 +++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h                   |  31 +++
 include/uapi/linux/mdio.h                    |   3 +
 4 files changed, 229 insertions(+), 2 deletions(-)

-- 
2.43.0


