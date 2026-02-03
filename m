Return-Path: <netdev+bounces-256088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNnbM0pbgWlnFwMAu9opvQ
	(envelope-from <netdev+bounces-256088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:19:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F30D3B33
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B430D303BB11
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4272F3622;
	Tue,  3 Feb 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAtVnUHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFD2F39DD
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085146; cv=none; b=o5TeSNRuXZtbkypOUlVKnr7v2JS8xX9EWbdL5QIZzz5h5DFi2E316pRtQ199AMhWrLESwZPc2xVmdmC7oUre79zAW/8G2G7rLH39s96dWS81t/uVip1A7X0m6ys5RV2BctMUWssV9fMIFvci50EImJeSsKaktge01keSS4WKznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085146; c=relaxed/simple;
	bh=A9J9Vbw3cZWxxdrLeN0e2dFSVHQM1IePSv58Izf3rdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jVVSJq4bi2gH3tcMKaUahHmQR+Oy7z40EPR1VJRsEwnv7vf8wMEPP/58m0cYHG8Ck0ehygkO9pXLZpfiz3TbkZqFfEls40M60CAAHMrcdoCCIYmyuEynYPRsAm0r+uvkjkSPe02bu5ulIe9riuLB/UcpGW53waz2N0mI4Fk+tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAtVnUHe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c655e0ee70so554332585a.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085143; x=1770689943; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vRFnWyzTvIVC5B3GNzk5VoRZ+dqVfddbc1ZSFOhpp0=;
        b=TAtVnUHeAuJVwei9ER/yWl66HCzMRfupuvKyWEkU2vnP+ifJ7KnQFFsBVcfJqCQWA3
         WcQJfn0mBq0wNhRjr1FA3EclDsSrTNn7u+jyziADkbHsYWHNclHhNpn8qair6U0mEEY8
         RHZsWORjrehGV11jMlFXmQ0QYd7AoJWAM/0nUCy4wslpzRman3iRiOCsRjr6M7YLQ0W1
         X9v1FS5+4q/Me+GOb6Hxh0kgJGTk6dehfjFjpBcTN4y0DltTCxpFtsZKgKHcB/yO5iF/
         u0p5pALfO2S4CAGmtmJfXbzlMhuBisG7Lw6STSzVRFrr8BSpkOvNwrHhaijW80PWdREp
         6+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085143; x=1770689943;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vRFnWyzTvIVC5B3GNzk5VoRZ+dqVfddbc1ZSFOhpp0=;
        b=lKB3vdLNmHpxh7cMg81Yr92BqoXnv6lBcrl2gvdLd8/i8u9B7hfQBbPJqAQ1dfMGM4
         LSI7/LIHh6z1ODCjhPork6hydCBfBkjsh3PGoXSxqCxGHGL1cW+PEfkEwd8T6FSbK+py
         LBBDCWtqv0i3rGSMn+ZgpQ5UoUaRiODFMWzhW17oTSyQiqN4vbohgHe4QKyWXW1zallT
         zRR6hBCyVMiYNg+00i10vEggd3YcesWvkt8Eqk77Ke99FamtM0E3v8IB2TvdWvY0nAWG
         SzWHon7KLUOZz6ix0X9HCtd7+0I779m1D3cD3QWoQDsHB3ixhYExNiwE8UIWEyZw2++U
         6Ffg==
X-Gm-Message-State: AOJu0YxT3zQxDfGcJVhDsKH6dfheBcBbnhQV8F2/u2wO9D/XQ8eUavQ9
	oXitpk5R4NjeGlS5eUjV3Z/QiG1brGKb2ab8/91dGPIo8fu9jXMC7DuM
X-Gm-Gg: AZuq6aL5s515v3EPsxwUPtc37IUBiTglUQ7PV+T2ZWiae7HGdI9iKIBjxeSa4upPZLq
	GUTyZLhwBWklWP7jAGaFfH3LkW1x0lyZiMcUCkzzL+cbMah/YzkaNh6OkaVIWOF5OROeZpgZaAT
	qf+7ZHn/yLwAN8TvMCA/Ii39UIHgRXuiUsQ0QFQ4FGptNB9G027XnmsAXHmP96hNMfqX7BSEkC2
	1sYO6zwfdI1mtSB+ErSv1cYkTrZYaYL2x3sR0w9daghrTBVx8SIBAnLZhCy/iKRHf3oTYhSoycl
	L0yAaum/DKn6UKt1ki1h27k3IS1sJDNVIo5aaVW2gl5vOYqHnagi0YGQzoGrIGDjFJfpQLT3JEC
	BNb+ZObXXdPhVAi93mL6JIoVApyDWaIlqWOFrymZdiiL6Mt9FrdmcjncqNMm48VqYkQ/v0wqgqf
	mtYt3pINjEj1VLXE1FB9Yw
X-Received: by 2002:a05:620a:472b:b0:8b2:db27:425e with SMTP id af79cd13be357-8c9eb309af1mr1776216485a.50.1770085143102;
        Mon, 02 Feb 2026 18:19:03 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5c34asm1337199885a.50.2026.02.02.18.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:19:02 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net v5 0/2] net: cpsw: Execute ndo_set_rx_mode callback in
 a work queue
Date: Tue, 03 Feb 2026 10:18:29 +0800
Message-Id: <20260203-bbb-v5-0-ea0ea217a85c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVagWkC/13MTQ6CMBAF4KuQrq2ZdloqrryHcdFfaCJgCiEaw
 t2tsEEyqzcz35vJ4FP0A7kWM0l+ikPsuxzkqSC20V3taXQ5Ew68BMaRGmOos1gqGUrFHJD8+Uo
 +xPfaciedH8kjL5s4jH36rM0TW09/JROjeVRpwCh2QeFudavj82z7dvUT3xu5Gf4zUqgQtLGVw
 6PBvVGbwWykVyygAMt8dTRiZxA2I7LhxgGAZtKi2JtlWb5HelIaNwEAAA==
X-Change-ID: 20260123-bbb-dc3675f671d0
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38F30D3B33
X-Rspamd-Action: no action

These two patches resolve an RTNL assertion call trace issue in both the legacy
and new cpsw drivers.

Thanks,
Kevin

---
Changes in v5:
- Apply the same fix to the legacy cpsw driver as well.

- Use goto label in cpsw_ndo_set_rx_mode_work() for the undo path as
  suggested by Jakub.

- Move the disable_work_sync() call to after unregister_netdev() as
  suggested by Jakub.

- Link to v4: https://lore.kernel.org/r/20260130-bbb-v4-1-2bd000a15c34@gmail.com

Changes in v4:
- Using schedule_work() instead of creating a dedicated workqueue.

- Link to v3: https://lore.kernel.org/r/20260127-bbb-v3-1-5e71f340c1e9@gmail.com

Changes in v3:
- Resolve the deadlock issue identified in the AI review [2]
  by moving the netif_running() check under the RTNL lock and removing the
  cancel_work_sync() call in cpsw_ndo_stop().

- Link to v2: https://lore.kernel.org/r/20260125-bbb-v2-1-1547ffabc9d3@gmail.com

Changes in v2:
- Addresses the issue identified in the AI review [1]:
  - Adds a netif_running() check in cpsw_ndo_set_rx_mode_work()
  - Cancels the rx_mode_work in cpsw_ndo_stop()

- Link to v1: https://lore.kernel.org/r/20260123-bbb-v1-1-176b0b71834d@gmail.com

[1] https://netdev-ai.bots.linux.dev/ai-review.html?id=bd885e1e-1aed-4755-ad60-7150737ad0f5
[2] https://netdev-ai.bots.linux.dev/ai-review.html?id=c9fc3cf8-a06c-4cb8-b26b-910e775951a0

---
Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

 drivers/net/ethernet/ti/cpsw.c      | 41 +++++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_new.c  | 34 +++++++++++++++++++++++++-----
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 3 files changed, 65 insertions(+), 11 deletions(-)
---
base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
change-id: 20260123-bbb-dc3675f671d0

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


