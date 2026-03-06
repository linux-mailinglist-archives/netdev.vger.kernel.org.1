Return-Path: <netdev+bounces-264918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ABLDHxDq2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-264918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F83227C57
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CAC43012230
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0536481AA8;
	Fri,  6 Mar 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWQVhSmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675C481AA4
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831599; cv=none; b=VnSL7qhGd269xe5QivmpiZ7MHgD9PnL4/1obQyTJ1fvpVJzpLAvO0T7C+x2fRXF5iFDDhUgpHs/YCzNPXeKSP+zUgpya8GvH9JHFwwjdTaeuTMCUVnWuqB8OLZIL5dqZo5FLct4O/0uToBRwxV/gYqC/8TWBlHh+RAJIg9dGPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831599; c=relaxed/simple;
	bh=qOWkm4KaoM/M/IJUqxWIPVIv0S9czaoP8RjOHXBNsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjLwtiFb5cLzKoLQMiJHLni6JiTHDB2HD2ulxe1nHiv2OQoFBdcFM3xnWqEPii6IxnVdmmN6p4hvX6PdXTp31MzybUIjmUB361Uqmhp9iRO1YwYsDThvb3l0b1bqaxxIC2HRdSNrSqSt/rqlSwQyOVsL2LLOy8YYaAqFRcBuU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWQVhSmQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a12f6871b2so3383550e87.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831595; x=1773436395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cf/zNSP2mIwbDjec2q9Q1Mo/k5XXLlz6S1V2sE7Q5Sc=;
        b=JWQVhSmQmi52tkEO1YchDWC/eCYAj/x0gfcyO/xf6LJuA+NCIs3VNzLOQFTOWLfyqT
         Z5zK2+pE6YSCa54BLyA9lT8vFEX6GNOujBLtW+h+Id5jedtojWGDpcx71p1mxpOYi1v6
         7cRozo2JPtZ14fZvYAEKeH6LBJsT1+P/m/afOnNXSsOehWtuiLNcTrwUh9wTlPOSokeq
         IYXwBTMHP2TexMqWcPLs82xc+Hl2ezIQKW9H0qQUnZ2ozNtDloiSau/vE2mrql/7qAM/
         YuWsXW9uuItzyCOs2XASaczBVWrTcdW7GQDCqrwc4MFit9sLbNFQbefsTySQ/Bv32pcX
         rcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831595; x=1773436395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf/zNSP2mIwbDjec2q9Q1Mo/k5XXLlz6S1V2sE7Q5Sc=;
        b=Jqe9n67AuxMylbE0WDfgCENTk6a9VZjQxq/HSN4d7NARVZlpK5eNVXKrcs79ybmS5L
         bY9rf4VG9A1PcPgse2SJTrWNwMS9gZs0t8eFv5S+FIeIh6j2JMB0nDPjQ2wujvbBM4ph
         Ck4YsGQUTD1mqU7QGJjyf4fU2NySEfL5AlpKzsjRIKn2nPsW9bqFrQSk2yDCJL1yjJhQ
         s9uiRaALU0102BF1eLrU6lzzYr38DKGDnnfSr3GjKogpNmrut5tGMnOkBTZLCRQYp+M+
         82Ye26eqsT0ckqwjM8OTf6qfCoVQrVLfF8mZiUbII8g1qLu46xs0TZ5SPjATD9pkFdyZ
         Qa6A==
X-Gm-Message-State: AOJu0YyRCsVgEKBL4+nOhalZtpwk9GqZkN+vzFy/1r+QY+jX6uQlTgvw
	XdcgSI/QE5eV4rCNSGFTJ77RxwsF5csJLJOTXQ1zJrRsxz8yqaYk9ilB
X-Gm-Gg: ATEYQzz19qte1/BeXtDckN2Vwvy9rU/l3gSV/xP2c0EtOUJolUQ11JPhUYzbUZaRZIe
	kt7FTzyVp7F8BJHNkYaNhxSM4n2YP2axel9Y6vSJXXy0YPsQ47usy3useD8oYVRtkdyiDmrsxMi
	mghJ7agN9wdaDFErQPTyCKO9CH3/TVAmcWwNx/8SdolcjYbzVZNvi32+hnTAyDaTe0vyUoTSBnA
	XSTxUzlYT7HuqDBXwEof4ceuZX92O82beq71U4kDJFc5bqTp+vTdc1DZPI+mAYiEC2FlVNi51kP
	mpVHznryxl96zSPgdomviUwMsm5HRgPcanUpD4MZBHNkpHFxlaSLNb3ng/ZUuZ5jCKwdWD6c9NZ
	B6ZHkFNFlrvXzVAvX4TY1bU1uE6FKhx+uLry8vdSi/Qit4wXbBLaTKX9HG49yvq0cxvicELHbL2
	VxNl8K
X-Received: by 2002:a05:6512:1315:b0:5a1:3c21:37f with SMTP id 2adb3069b0e04-5a13cab3728mr1533744e87.7.1772831595025;
        Fri, 06 Mar 2026 13:13:15 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d07e0f1sm554433e87.58.2026.03.06.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:13:13 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	kurt@linutronix.de,
	maciej.fijalkowski@intel.com,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net 0/3] igb: fix TX stall during XDP teardown with AF_XDP zero-copy
Date: Fri,  6 Mar 2026 22:13:07 +0100
Message-ID: <20260306211310.1213330-1-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75F83227C57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-264918-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

When an AF_XDP zero-copy application exits while an XDP program remains
attached, igb can permanently stall a TX queue associated with the
AF_XDP socket. The interface stops forwarding traffic and typically
requires a driver reload to recover.

Reproducer:

  1. Attach an XDP program to igb
  2. Run an AF_XDP zero-copy application
  3. kill -9 the application

The TX watchdog eventually fires and the interface becomes
unresponsive. Reproduced on Intel I210 with Linux 6.17.

igb_clean_rx_irq_zc() lacks a __IGB_DOWN guard. When the AF_XDP process
exits the XSK pool is destroyed, but NAPI continues polling. The
function then repeatedly returns the full budget, which prevents
napi_complete_done() from completing. As a result igb_down() blocks in
napi_synchronize() and TX completions stop being processed, eventually
triggering the TX watchdog.

Patch 1 adds a __IGB_DOWN guard to igb_clean_rx_irq_zc() to break the
infinite NAPI poll loop.

Patch 2 prevents igb_tx_timeout() from scheduling reset_task during XDP
transitions when the device is shutting down.

Patch 3 adds synchronization in igb_xdp_setup() to ensure that pending
ndo_xsk_wakeup() calls complete before the teardown continues, and
refreshes trans_start after igb_open() to prevent false TX timeouts.

igc handles a similar stale trans_start situation via
txq_trans_cond_update() (commit 86ea56c5b0c7). This patch adds
equivalent protection for igb during XDP transitions.

Tested on Intel I210:

  - AF_XDP ZC app exit with XDP attached
  - XDP detach while AF_XDP running
  - repeated XDP attach/detach cycles

Alex Dvoretsky (3):
  igb: check __IGB_DOWN in igb_clean_rx_irq_zc()
  igb: skip reset in igb_tx_timeout() during XDP transition
  igb: add XDP transition guards in igb_xdp_setup()

 drivers/net/ethernet/intel/igb/igb_main.c | 15 +++++++++++++++
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  3 +++
 2 files changed, 18 insertions(+)

--
2.51.0


