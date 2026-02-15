Return-Path: <netdev+bounces-258754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEJ/IFs1kWkXggEAu9opvQ
	(envelope-from <netdev+bounces-258754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 03:54:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C489E13DEDE
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 03:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6310E3019505
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 02:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49AB238C3B;
	Sun, 15 Feb 2026 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1dcHURW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE103225A3B
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771124054; cv=none; b=gMO1FeyJCc5bCgQICvVwTx+PrKyuyh8jEl5tQvXf829KdJ1B4RjcxkQGqn4L4AbywM3fB5wXlcbBNL098NErAtNtmqPJDEocQYkRREKwoL0m6j0ixwc9ADV2R4O+qzJBnhGM+9Qfj4RZmAP1oKX0hyC7C6l6gcJNnphUvBIRnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771124054; c=relaxed/simple;
	bh=8uDMoEbtVZaqbq5/a6aHIQitCZjudiNcZyzvH+IYQx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Msy9851FWKhMh7MFdn5QLB6QaJwKWicCWfcEQsCbn3YjHQtm88GI7ieMH3ArclJLrPDQnN6MoX5YeJZKooJ8g/E1MixRZ6JrZ1Vh8uaNzUeYa8Je5XpTNY3Q0HIpUm0HjbAOSC1IIb6ao+4OS1UyHvy/GE9c3piJCOHg2yPw9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1dcHURW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c70ce93afaso222923085a.0
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 18:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771124052; x=1771728852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vY6pS6uqvbdKyKmWVIJPf4qddUuH7f5iT7TRrxx4qc=;
        b=K1dcHURW65lu0p/6Xhjmt6rJ2cq6EmWUmnl6HEimyy+cNRnGVmTJLlzGxVnIIxciEu
         D/paz9XSVza72jWI4oIYFWLbdFrT5F559x/5j6PkjHbR9Um37TLinolfF4JP2+AQhx7f
         KaLFpHHoJA5CvIVoJvlCqPcz1ILKhwshl9gDOSJwYeyN8bnXo8WO/yfvPUNV8rcQe5Kx
         pfZ19LlGOaSqq7aS4CWrykJMt3soW9Tx3j1oFX+IMe9ojAP7yduUChA8HrAk7Gwfr35Y
         gwVKLm8vvliwBm2beeKR8RkIv6nbemUQSjs0MJk2lb5v446SPKK4tGQQEdF4+o9ivdHd
         gESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771124052; x=1771728852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vY6pS6uqvbdKyKmWVIJPf4qddUuH7f5iT7TRrxx4qc=;
        b=wFqbVbupyKJitNN0ykkJkwkz1FaGW3gWh5AvRsg+6Equ8Y66n3XvbnIXD+57p4k/fa
         iuYviHtMuXnmdGiD78luC+tP+LNPQJzgTN0IyLhA1OKO/4kuKpHGSmZTyUz/j7Aj7S2n
         6zwC+LfXZFbVMP6KgSDlcw8M/Xvo3aEDiYGBfiSCaYfrC5Xxkl7UlKC3UrIJoeQMow7i
         0d1MXUZGIllrhCW10fpKlJZNb0uvzQjQz8VQEv2wl9MRFj4RmbPOfdfunL6VUTbZJkSS
         q7HWdlyjcHtKrndj2PMmJ3u82XO/KXXECUhLsJh76qRNXbOr6Mjl+gae9ojMBbvkZAwh
         uFxQ==
X-Gm-Message-State: AOJu0YzuXKoohATeW78cuoPZ1nb65lQi04YtfVA6sm3k+z258JYH3JYd
	HJeptf7F11ioLXXu1YyRbwdyCqzeMhJvf7NUyjREsL6en8+wpPhyDnmQNd/jWQ==
X-Gm-Gg: AZuq6aJpqWOw7Qr+jBtJ0PrRNRm4LCMLG/20taJvUfCIqrJjJtBdRHBO1R+VU/y66CK
	p7J0RJATd07kvGFWcvSLDumiWMJljAI3ScrNrpBl0AV7SFxUqR1SlK947RFyz6wZVMK/QeeDMbD
	QaqraW70m8J/Pxr4LxUAH9GPavxraVuaE0xBwWfOaOrLG2Gf0bwwPTWoV46evFzzyqCJOS6YxEb
	LDyQEewqLu3nMP3keOZvRfJpKgC2YeDpt75ASckd6cM+PnMeKeT3h+7/4G3/bSWuVKaVxI29qxY
	DP1/vGMxU7LeStq/iK6hZbfUZhT3inazmj4WSJ5YPR3lP3GmknMQfJv7xjSJYvwb4zF9sLcAtFc
	98glgokHn956RtMAvSg1jivs9HebSSwXz238INFvE8h2MZP71Atai8xA4KCkBARZvlfjSjT4zti
	jJ0BtHWp6g2drbL5s/DUBu0MZFaFD5XekS4E1av5kuZyi5o9YLlete4w==
X-Received: by 2002:a05:620a:4554:b0:8cb:3e7c:a4a4 with SMTP id af79cd13be357-8cb4243c232mr821799585a.46.1771124052590;
        Sat, 14 Feb 2026 18:54:12 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cddc120sm119517306d6.52.2026.02.14.18.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 18:54:12 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net v2 0/1] serial: caif: fix remaining ser->tty UAF in TX
Date: Sat, 14 Feb 2026 21:51:40 -0500
Message-Id: <20260215025141.1106576-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258754-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C489E13DEDE
X-Rspamd-Action: no action

This is v2 of the patch previously posted as
"[PATCH] net: caif: serial: fix TX UAF on ser->tty".

Changes since v1:
  - Send to the net tree as [PATCH net v2]
  - Base on netdev/main and ensure the patch applies cleanly
  - Update the commit message and tags to satisfy checkpatch and netdev
    submission requirements

Link: https://lore.kernel.org/all/20260212042236.639174-1-shuangpeng.kernel@gmail.com/

Shuangpeng Bai (1):
  serial: caif: fix remaining ser->tty UAF in TX path

 drivers/net/caif/caif_serial.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.34.1


