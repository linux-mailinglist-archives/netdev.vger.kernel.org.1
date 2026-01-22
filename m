Return-Path: <netdev+bounces-252542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHx5JuqZcmnBmwAAu9opvQ
	(envelope-from <netdev+bounces-252542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:43:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 372076DE56
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621EA301AA8C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B420378800;
	Thu, 22 Jan 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B03nPAID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E760350D7B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118180; cv=none; b=fAF/ne6L4htNBjnYh654x779SGs1QYXiixQd72mkc1YwNP6jeV1RXguBhXtw32afqqejdmnNqpnFymIg0clwUrSaBfyXtJ8PPZNHqTRvsg8XlUDxwCmVNMABXrbeh0cXVNC15aOu35vQBYmuWBQnDXnoVPb3Q0zIGeDqiMAroXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118180; c=relaxed/simple;
	bh=XCri6TpeAwwjFdFfbu2Xmenknz9GMXG0BWXH5++IG98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHVRKyrQGvfR06V/j1PcvKMLYByS8SBgu2zKiY6dpYfXT57ziSezaoeR9/i9LOVBQWHw8XcE0Z7YwCG3xar/1u7jgFna++pLe0wKiHOTtDOWUNj+fpLl7cHsBSDDAS0FOqMbHvvYoXLqcet9Fmocr/70/eoefWzmssRNQvpQbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B03nPAID; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56637565faaso1130142e0c.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769118174; x=1769722974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JoZz20dy6a5sTWw9JhLQ9Q8q+pGoGoLISLI96ZLK43c=;
        b=B03nPAIDFRxwuU0XrwfI/OERG4Y6sxCFkJfZ/NfEQvfmSXFkTIyskhRyaGxUPI4XN0
         YiruFhltAFr4xy+PWIX+h5WVuQs/j05QqQw9CZG5aMIHTMtmn2acwVdQRnGwUbEHkSuP
         vcyB9dgvvWZH6ve2aN+j4NFrfrl/7eAyDvFvFey1MHVMdBWFqIyRQuJsTORr6oR9BioI
         +apW7m6pcx6EBLONi6WD11ge/kN7+xjaBPXjJsSAwCjIf2Clrb7+B/WlcpdoeCTFKjML
         rXq0L8pzD0KAo9ivnvF5IuxIzUUYZQPc6yw9RrrSLaOe8NtKLvuR6lCu6LfIqE85c5ok
         0XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118174; x=1769722974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoZz20dy6a5sTWw9JhLQ9Q8q+pGoGoLISLI96ZLK43c=;
        b=okcrjwgNO5IhX/NnXTDQIr0K2eo/6PaQZI3KSoPMU//g7aAa/Zu7XcGL4B7de79Kri
         WSfgeDTLOUyQvTOXeNkKk5IAo44aUrjCdFJIqfozN39KUFUh4pDXEyJaNI4JrWZQOgwo
         nLYxPulk/s+QKHXIHKs+VnYtEf40CuXAzrSYKqRWN4gz62hHUxhXf8kpVaoG0jHOV7Tx
         EhczpgLAuMJ5WTguwUTcQzmRRAwsqFuJxjmxWPiEaUBsj3hiYJaO4xdp52V5vo3Q5orj
         fFoHmUmoxgS7KfPUrSsvTRV2b/mOZHOj3iIyRtvzNCDFIrB/khklnFQXXr/eMG+KCDjV
         owLg==
X-Gm-Message-State: AOJu0YxcI3Ti2VAvcKIgOXDTu7MIBIDLLEkKjhr/gp1921j6it6XqWxu
	aAjWmoB+yHCcd3Kv9btpFNDVBLp6FVZrKb7mwTQX1zFJQC/N2e2ZEbs1zAD/HQ==
X-Gm-Gg: AZuq6aJKzXT4MUznXx/MfHc5+lJyqxwH5IdwhoUq0hYy2qX4dxf+3A0gBb4eOVgIhpK
	p2yS/N5c1osMKWndBgFB/pb/Roa5R1j3PBSHDDii//jRYBwGzaoN7ZgnCTcVgfFtcPgJ8ZltuUj
	XAZaMhmK5CKoZYcr8iLZjRm6bHiX5QloEq8mb9JvSjRLgDKCrsNzz2goFiWKT2oB40Ne7EbDkXn
	3qyJ4HRL6RQLJ0j3OndHPC5CsaxWK4yO8dq5AiwYKX/CXqktq4CIhXXINPo3zMKcj+7M1A3Oge6
	cxEtkdYCRXG6HZOokgSTcG5UcOt1DFBTGXif+0CbD+R133HVqB/67s5nzvpCUhx9RDRNrlgi25g
	hSptuqp4c5ZYQmzC2gGbUzDt+AzOMixKS3ojWd9IcWluR8q7iF5yQ+c06doDltzWZyQMiXte5PB
	W7ERYwwpub4jwq4Q/TQsLkj98T558g3dtMcvqJZj1JfQxIjvlhL900ig==
X-Received: by 2002:a05:6a21:164a:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-38e6f7cef3amr646046637.52.1769111136883;
        Thu, 22 Jan 2026 11:45:36 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a425254sm110441a12.29.2026.01.22.11.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:45:36 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: yt921x: Add DCB/priority support
Date: Fri, 23 Jan 2026 03:42:28 +0800
Message-ID: <20260122194233.2777550-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252542-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 372076DE56
X-Rspamd-Action: no action

This series add DCB/priority support to the driver.

v1: https://lore.kernel.org/r/20260119185935.2072685-1-mmyangfl@gmail.com
  - rebase

David Yang (2):
  net: dsa: tag_yt921x: fix priority support
  net: dsa: yt921x: Add DCB/priority support

 drivers/net/dsa/Kconfig  |   2 +
 drivers/net/dsa/yt921x.c | 232 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  54 +++++++--
 net/dsa/tag_yt921x.c     |   8 +-
 4 files changed, 284 insertions(+), 12 deletions(-)

-- 
2.51.0


