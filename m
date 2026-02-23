Return-Path: <netdev+bounces-260206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCIPE//DnGnJKAQAu9opvQ
	(envelope-from <netdev+bounces-260206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:17:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA57E17D794
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288F3301465C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25836AB68;
	Mon, 23 Feb 2026 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI0TTOx3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BD2C0263
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881407; cv=none; b=bYfFI6qDla8NZyQ70yleu0MOIP8DvMLhEAgun4VzlxsclCsmy0kq0dGcM6Q97kEZZxOMcS3BOdDtYX6BheOy3vZ5JLx7ZVxKj4wi/sloK3hqbexJvMcchhtE03F3nsvixSZtIxQsj6n9Cjps2FZBumNBDR+iR8oyCpujadPfcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881407; c=relaxed/simple;
	bh=SuMpt0QlF9//RjYRU0EAIFvFxE4wNASoqWyJvJuQBn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L39bdbOeQv8m+ENhm/+fyowNEq4TnWycotunDcnfmvKMg+LMJwS9LxmicYcHTTevfJXuEnJNKPtT/Mek3dWZlZusnCutUiShujRPdJnZXqqpV2zq7URcPxvk8F4snSf70vS34W/a9p0dntJaBC32kFq98Jq+MQ6DUacad/Jsfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI0TTOx3; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so3473348241.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771881404; x=1772486204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJYHWnzDVdlbIgz9CaQNBWll7r0bpnHvy9pTXHf6yyQ=;
        b=iI0TTOx3gDadha61L7Ga0CorERJUbRkrF19eDVR79px/a+ly2Y04aylqONTEZYGlgn
         mH+7fSNtpPh43G8KSMLFGNpABeVm4KgXvuw293Dlj/LFTQTW3g0L5jSXDiSKjUb8bBKM
         cKLTaNFlhR+QBsi4NjTeCD05pJU17TG/LwSLHv5txnx2GN1gythtGsgcLTl6gIqFx3Sd
         CczYbioUJZRqzCsjFa2LyFQR4T+OuR1mruv5vRo8SC053Out/wOG4wC+bo5aNxJWInBQ
         vqE6M/CABIKiYxaFwOCrLVTNA5kPmJHM6HvApWwxaQbHMqMoeYCWvzppWaAdxWSZ7kyp
         iKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881404; x=1772486204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJYHWnzDVdlbIgz9CaQNBWll7r0bpnHvy9pTXHf6yyQ=;
        b=xRPMEGR6BTDSUwxC9kYK4TcOHTwBUiqfZU40yc/llBSJkovLgb1bEWTJzcSedSumQN
         Jtqv3/8V0Y/vId7xM6S05LVegV3DrMB8O3PAhLR0se4sJUQbWJFfUX5V7Zgw5aZBq7hC
         RV/SCnJ5oSt/oyIlGa7VK0NAY2YUFOdBYxaMH4vCQNa/EnVTleb9/oCSGOH7XNU+A9xm
         VzU4w6AC25oX5k9ek1mHpduhHB9q5Qe9gjKyWJI1lYexXhn8jwxCQBDgdlaYfYrjOz/r
         sjyAmA1Upzt/XV1ttbxGFvaX7kIRNi+94Gaz6amUEbsJ6+IA4ww4iIyF6yGc8RoYRw7M
         sL0A==
X-Forwarded-Encrypted: i=1; AJvYcCVW3npmEOew8v0y655W/UqYj+8N0muZ8aKxxgt1CXg0xmFT6rh0PmTg8Psx40DWanBs1zA/kxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJgqtmNVKi3/HppLeGpxmYRchnRE5B7kwyplcByHZews+IbRm
	Ttq7Ct4zLwLqG+piVGm1rbQlifrieX2tAJvSNUwwbkvzwe06Uxcn7bpx
X-Gm-Gg: ATEYQzzBiGhaS3aV/ATg9entSylNuXtoypcnJEEYwVikKooHFzWFB2y3VjO72APQ2n+
	5r1FOgPh2gJLjNHojI0QP3nztBFTPBckLvdieX6gfY+0QsEa/MstumNUyka1aEbRKm6M2UFnQJS
	XtB4aYQI4BVodhOtNzEXn4vX+x8e0Roju4Lc1aLTKMn/nxv845E3ZCtLeF0M/fNmrKUl6b7utwA
	i7E0NxkpU9YMahqSAYD7UCuK51t+c4yXRLg92dgoTm3L0lJ7r6tN1Bt8D1IQa2Sl0FMnP3bt3MA
	g7ZsdaHNXVvQj5xFYb3D/HDRxavwmCqrFyTYwWU0gAm3FOUl5aXnK0Crzx6B5X+2GZ+IIX4aDeB
	IaO1YSUvFJE5sf2GhNWopSR2nEQ5vY1YFUwfq4LVrWyxIu5D9+Ay25+kwlC4xCPfQ0lRpeS2DJ+
	TzmWJ2urdAOm1/ZDF/ioA2bSuSlLhDjeNcduvkJYlMYc0Qw6ZpQe+Hfn6z7Vvkc875LDdr+co5k
	+4il2f22aa5wbnQh7cPsBQta0Aw
X-Received: by 2002:a05:6102:161f:b0:5f9:4d6c:9917 with SMTP id ada2fe7eead31-5feb3449eadmr4342132137.0.1771881404282;
        Mon, 23 Feb 2026 13:16:44 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb61fde14sm9025331137.3.2026.02.23.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:16:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-02-23
Date: Mon, 23 Feb 2026 16:16:34 -0500
Message-ID: <20260223211634.3800315-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260206-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA57E17D794
X-Rspamd-Action: no action

The following changes since commit d4f687fbbce45b5e88438e89b5e26c0c15847992:

  ovpn: tcp - fix packet extraction from stream (2026-02-21 07:04:08 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-02-23

for you to fetch changes up to 138d7eca445ef37a0333425d269ee59900ca1104:

  Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ (2026-02-23 16:08:15 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - purge error queues in socket destructors
 - hci_sync: Fix CIS host feature condition
 - L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
 - L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
 - L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
 - L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
 - L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
 - hci_qca: Cleanup on all setup failures

----------------------------------------------------------------
Heitor Alves de Siqueira (1):
      Bluetooth: purge error queues in socket destructors

Jinwang Li (1):
      Bluetooth: hci_qca: Cleanup on all setup failures

Luiz Augusto von Dentz (5):
      Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
      Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
      Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
      Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
      Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ

Mariusz Skamra (1):
      Bluetooth: Fix CIS host feature condition

 drivers/bluetooth/hci_qca.c   | 24 ++++++-----
 include/net/bluetooth/l2cap.h |  8 ++--
 net/bluetooth/hci_sock.c      |  1 +
 net/bluetooth/hci_sync.c      |  2 +-
 net/bluetooth/iso.c           |  1 +
 net/bluetooth/l2cap_core.c    | 95 +++++++++++++++++++++++++++++++------------
 net/bluetooth/l2cap_sock.c    | 16 ++++++--
 net/bluetooth/sco.c           |  1 +
 8 files changed, 105 insertions(+), 43 deletions(-)

