Return-Path: <netdev+bounces-261931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GEgDe7XoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:44:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47A1BB93D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8C453125D55
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7335F8D2;
	Fri, 27 Feb 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eYHiObAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E443E9DE
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214131; cv=none; b=IU4B6Ccop9VuBMX85bFvtiJxWh1hBPaYkdwI2RZuH4IWHXcxrxzNgMp1XvdST0OCrq5kOgvxs4YQrerA4Nx9RefQq4DXglUs7IinSnD29njEj8gU73HCXJMnjYCHG10na34Mx1SPc0oNMSZ4A3KrzsHcrIlryTWntawCz+hqUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214131; c=relaxed/simple;
	bh=wlYJNHp+EGFmqiim3z8wdiqCaTuHFQeVOxxyb01uGJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4bVHQ22T6pFdIbUAGIVC6APC37GnkuMdfYvyu1HttO31OdeBM0/zKpeVmlH627h026tfCTgIsw96wK3PyUQ1G5q1yVgoAgXQtnR0ZCxDmPuuZfIuTjndw+6YlXd+u5DBpRQquvcw4einKic+D+B3p8Z4nd7h2vGRFfEhMNnT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eYHiObAQ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c7d04890so1696850a34.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772214129; x=1772818929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOSTTPOtp0HFguKQvmsnkWpDGw1Tid3aGCL4G0QCjjg=;
        b=eYHiObAQ48nPQsg86gftY05dcmpKUzxkcCjzsDYeTHbQwEqleh91y4f777nkO7mm5G
         F1FdG98OuCjWk68ejkfo+w83udGQSYOECzOSHjTMRQfjGRVic+Om02kbIjNa+hfZUymv
         JFCNzvrrmdx3LktO3pcao1bJR9VkhWFxQA8NhdGvTJ45UVgKZohLAs040HwEuoDX6HSH
         yFnA6qxqMSJGgTOqiHQQmXJUashhId+CXyodtn2QZepkNfBRkhMP8G762M+oImojeSRI
         p2Xlw2ZQK7zjjWRKlUucbQ7r6xUpi/amVPGX1FVTnIA5Iyh1PmIdFwRQ5nzaL8CipaYy
         quUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214129; x=1772818929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOSTTPOtp0HFguKQvmsnkWpDGw1Tid3aGCL4G0QCjjg=;
        b=tGpnCf0K94sPlHF62+MAzkWNlgmZNCfhSS4DA7dflmfCAZLPLfGAReXbZ6+/u9xA01
         N7wcwR2ZBFSvEleJdRm2riLPp0uqj20gv+MmCeY9/1F8IwCG7KWufOoVpY4lmPtKg4nv
         fzv/rUJpn6zdkCJsQ8LWSyCWWwXJohQ2tVaKejpRHFllYvY+mI7NPwlm++kTnI7IHj2d
         P9c4AnrtNmzvv//oqXFeCws931BfVrrh2unFQrwCrgIiraeW7x9zw4TC7Q0X6YMFcWkh
         1t+cKyGexemj2VMg0xLxV4IBT3xmpxvXJWurxIWqgwEbkaoyvjzJu/HSahq9OaTJ81g8
         4SqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWhlrOd7QjYOwpWipmabfZ/9/WYi5/kwZxj7VAr4qpNXceQEiYc60M0z2Y9ibNhp1McEhLnCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++XlLYn0Zgv6bmnJFRO/h8BrIMPYdBhZZyqS9kpPcvbSeKVXH
	2Es6dYfIAW3g3AV2qyDag7UsSeZXY4LhedR19Dl7MP21xCJCnePktbzCfyeSth7IwgY=
X-Gm-Gg: ATEYQzyORbB55GA6GdmkdWSlaDQUJnovz5jRIpHkS4AtvmD2aJJz8OesfHEnthRTXoN
	Et9CQ+qlroV652zhnbc1to2aNKB2MyQdx3jskRHloi8snSILcOYAbQ6PksxJ0xhEFx5vSVjoF+5
	RqzNxgCoIyCYNPMOaJmGLnSJyVfMKpvHWPySuhNZBxCdos0MxzAB2RUWxQWl7IH204ebX2IJ807
	mewMN5VE1JisYUtWpLWk1QCx4H/alEUv2+GxMnCxCPLBvRkiOwfQzegV+0i3ogxbrvFBwKmptaF
	ke8vqTbSfPA3x9OQ6rzJQxzrjQs8fZo7ahCnSmZ4taxda9tlm35VuUuAdpocPlA+LNJ7IFVs0v5
	WqdH6Iv4bFr2V6kl3hyNi3OaHoc2iwkfoSMH1cQUto0y1r32n2BdoegxZX8hxONLH02P+V8dKQ8
	rpb5uQUsc=
X-Received: by 2002:a05:6830:6201:b0:7c7:69c8:2d2 with SMTP id 46e09a7af769-7d591b324dbmr2356264a34.13.1772214129060;
        Fri, 27 Feb 2026 09:42:09 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::f:3cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm4723385a34.2.2026.02.27.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:42:07 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/4] bnxt_en: add XDP RSS hash metadata support
Date: Fri, 27 Feb 2026 11:40:16 -0600
Message-ID: <cover.1772211065.git.carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261931-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xdp.py:url]
X-Rspamd-Queue-Id: 8C47A1BB93D
X-Rspamd-Action: no action

This series adds XDP RSS hash metadata extraction support for the bnxt_en
driver and includes selftests to validate the functionality. I was able
to test this on a BCM57414 NIC.

The driver changes introduce a bnxt_xdp_buff wrapper that carries
hardware RX completion descriptors alongside the xdp_buff, then use it
to implement bpf_xdp_metadata_rx_hash().

The selftest changes refactor common XDP/BPF helpers into a shared
library and add a new xdp_metadata test that verifies RSS hash
extraction for TCP and UDP traffic via device-bound XDP programs.

Chris J Arges (4):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction
  selftests: net: move common xdp.py functions into lib
  selftests: drv-net: xdp: Add rss_hash metadata tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  47 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  10 ++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/drivers/net/xdp.py    |  95 +++-------
 .../selftests/drivers/net/xdp_metadata.py     | 144 ++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   2 +
 tools/testing/selftests/net/lib/py/bpf.py     |  68 ++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 163 ++++++++++++++++++
 11 files changed, 482 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/xdp_metadata.py
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c


base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0


