Return-Path: <netdev+bounces-296243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ENf2MUR3JWqxIQIAu9opvQ
	(envelope-from <netdev+bounces-296243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C42650AB5
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:51:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tk154.de header.s=DKIM001 header.b=Evj2L04x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296243-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296243-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D943002E76
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC532B99E;
	Sun,  7 Jun 2026 13:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E013AB29E;
	Sun,  7 Jun 2026 13:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840258; cv=none; b=dXCziG4lFXiNdgMDVHMlP0czjeaz2D+Sv396Q497OfqtWafla2BCIccWd2PqrI4RbE71KrjHY8b7h5nm9jmYi6/LCtrHrbFJb8STBJPXUOp9l6gcTtcZqmPcRzgJoISRkmUu5cEEAiK6IoQPyk0gidgc7fxZfniwHc3ZyBltYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840258; c=relaxed/simple;
	bh=xVpGXQjW5z6eyU+GUxxWplVBYw1+nlCwHkms84d3DS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc4B9RGz7OohwKPx+6yFIvlV8DOHkBCgzp98ORsMBrAn+u4hnu9vRzId6VI3YeD5gWW+apTdo3jhJg6R3VOkrX5gyM3ecwyFc5XnngxYxJ61hdeWWhy4O1Ry+F0ZzBCO3uH3a8KFYn9G4hlq8eyp0+XZ1OUCtYB86yJagvkaBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=Evj2L04x; arc=none smtp.client-ip=85.220.189.106
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id C9D02240937;
	Sun, 07 Jun 2026 15:50:44 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id DA251240263;
	Sun,  7 Jun 2026 15:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780840242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RY5vvpBdIrhlPmSwQt+qsx928b8LsAM9g3/uCePEky4=;
	b=Evj2L04xkrrFMzGrZeY+67ieB3ybNuXg1zAWRgDpU2UXzXShHpMThwlEc6uPikhiwsIjXj
	m4xamoPXTfgYXwBbjXjMtVP/NU7Zn1s1QhrmuJwLJ6OWCxpW2U1CMahJMTPdPQ7szaX7po
	0bPLrdt9cflGp9Sr5SaHrvtm4wWeMR4VplFXuiXtMyMaQBteYZFXifzc1djouJ9URKku7e
	wC/1DCPuAXTfco/JDqCtbO7bNZIeLS5/gqKZ/dGAivIxFdb0l8p2xt+5qwMKnzxRuaqcMz
	VmyI+ji0mapBeOUS7zJMmyBsQFglWdMPdrd0hmTmVINCHe2RnUtJlQleseCUEA==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:3300:7fdc:421c:b21a:ba71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 9D3BE240023;
	Sun,  7 Jun 2026 15:50:38 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@redhat.com,
	sven.auhagen@voleatech.de,
	lorenzo@kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v5 0/4] net: mvpp2: fix XDP RX buffer handling
Date: Sun,  7 Jun 2026 15:49:39 +0200
Message-ID: <20260607134943.21996-1-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 976ab9
X-Rspamd-UID: 8272ca
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tk154.de:s=DKIM001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296243-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:marcin.s.wojtas@gmail.com,m:linux@armlinux.org.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mcroce@redhat.com,m:sven.auhagen@voleatech.de,m:lorenzo@kernel.org,m:mail@tk154.de,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[tk154.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,voleatech.de,tk154.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tk154.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tk154.de:mid,tk154.de:from_mime,tk154.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15C42650AB5

This is v5 of the earlier XDP_PASS fix. The XDP_PASS change is
retained, and the series also fixes related RX/XDP buffer handling
issues found during review.

Tested with tools/testing/selftests/drivers/net/xdp.py on mvpp2
hardware.

---
v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
v2: https://lore.kernel.org/all/20260602164635.62517-1-mail@tk154.de/
v3: https://lore.kernel.org/all/20260605121332.147397-1-mail@tk154.de/
v4: https://lore.kernel.org/all/20260605154457.163304-1-mail@tk154.de/

Changes in v5:
- Kept a separate page-pool recycle sync length for skb allocation
  failure, which must stay tied to the received buffer range.

Changes in v4:
- Reposted as a new independent thread, no code changes.

Changes in v3:
- Reworked RX refill failure handling to preserve BM pool depth by
  refilling before the current buffer is consumed by XDP or an skb.

Changes in v2:
- Fixed RX DMA sync range to account for RX headroom.
- Limited XDP frame size to the actual RX buffer size.
- Fixed refill error paths so retired buffers are not returned to BM.

Til Kaiser (4):
  net: mvpp2: sync RX data at the hardware packet offset
  net: mvpp2: limit XDP frame size to the RX buffer
  net: mvpp2: refill RX buffers before XDP or skb use
  net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 67 ++++++++++++-------
 1 file changed, 41 insertions(+), 26 deletions(-)

-- 
2.54.0


