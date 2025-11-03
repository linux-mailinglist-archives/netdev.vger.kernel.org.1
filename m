Return-Path: <netdev+bounces-234916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40283C29D1B
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 02:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C142934801E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 01:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDFA27FB34;
	Mon,  3 Nov 2025 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en+CFps7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72127E056
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134667; cv=none; b=OAIsxHLTL4E6LIhjwJ/JZzZYzTAHyfF3Mq/Tvasl6q2HieRv5419wACw0c1vv+Tax9B0gw2XYqc3JnGiR9Pxj9nFTtkXW2QWkHtehTBDLbIQcwGoyo/KDYz1+sqTxhsgdM8xzb8O7MmWng2jW8I/8D4V3YqDYRGIPqPZginTzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134667; c=relaxed/simple;
	bh=IguGKpS5VQ/M3vLUdSUXAb+iSeTOTwLAIFBgATkkuRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=leUBUdi4jJCnaXMmb+9EEfA92o4J4BmljWRRaO5Y9sMqiSdziYyRymWByriaOU234Vm9IH5wJdqWDJMc/WFXyujsc1QCz653hsm83XhDNuOZFx0j6mefWVSxxJbh3pusGbfBZ5S7/s6OLQenCe9wNmCc3NWeol9KSv6o8UV1apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en+CFps7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso389272b3a.3
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 17:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134665; x=1762739465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TaO2MetV3N+eF97av/JpASJddKmaM/RwWRxYKGrZbs=;
        b=en+CFps7l+qeVjqc+IdUGzSA3/x66dr0QFUyiw5grxY6DydX1cYip4YFNshuURWdYe
         s/XeQbclH2zoIgWCluQ4uGS7tIdf1nUZ/zxJIcEfHguy8Wq4Td04gFYU8t+RG+8pIU42
         DeVO0axoH6wC2BFri/Aiqxe5rdlw4y4WtVXqLjbsAW6ZFf8HIyLspIRv5iYJYMIebsfu
         sR/waFqrxA6EeEibYdP0l70BZGF3EMzQCDjKkQJY7mxici5fkIO9iZV9j2joCJlz/Src
         bs3GJ+oqC8ehsl+DTOwyDSQv1DzFpVpOt8TW4FUuEX4plexuoacmvebqTHCHFjCJD1ld
         X1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134665; x=1762739465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TaO2MetV3N+eF97av/JpASJddKmaM/RwWRxYKGrZbs=;
        b=jQ+n1+4tpMWtU5RBt1RUTZ9q6AuRCkp+76070Un7vyIoLaXDhwgZLyIkqc6H3L9QNI
         yWwd1QfemA6TQAEzObLLziwte6O6PcM1fNGU975g/gn3QRBw6ny9BJllC4E0wh7n7W0a
         qjBpVvyseGtFGrxigXtvCXo/Oa60yFDIVQ1bnTsgRj0K/ulutAdTP1cJWBdd7WUjStIt
         S/jen8K3PWo6aCFVRAT2vomR3+HrQdRXf592zZpHHXmeMAXVF1tqlaIFrXeSY5UCi6Hg
         CxNdvt9QLoRo9aSZB7w8nMk3KecI5pCMv1cgl35kWSvc55YaaFb4CbWAENPHiZTqPwZp
         tm2w==
X-Forwarded-Encrypted: i=1; AJvYcCU97h+kufC2RUHHq3USzsx3lX5HMAMlm9kvFixZ/yxZjLZOO5pNYT6o+nRbJvTy6qdRf3glw/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFH7/JGTj9IPBjjwhv/mGuiVQWkj8AlbWRRlCnRqUbjitvAqZy
	AKQ9w2WQ4bMabKLwh1K2rZF3s60cavt7Tyig8u35W5cGoIa38Yd/IpKC
X-Gm-Gg: ASbGncuuCQtAZ6/EZWLBmYcMQ+yr9CJINAS+68g9k84zrrYEeqKLij4LOCzZhjusjhX
	P3IKYMunP1ItLjYN0v3U3w4RHJYjPeilv/YHnLULNt53idyyaAqh6qmKFxBqOXTzIzQy9n0lD1V
	EpZleXde5oVty9dCb33eNuYrSH4248ESzCEiX1M93N3NL8mfztQaaXR9qQkdqOK9t9cGKFa8RIw
	Ioa4TlrUDrgdQe4uNux1A5JwCcqyfmx0pf0DM1gqo5z51qP6JK02xIBOOXkjktEImC+vM4n3soj
	JK6OTUb8MnNNM8t6/VpBwzGJ9ipm+fpKzqrWLddJiUPI+vxZykf1tzHMAVXJ0EtCYiPyQ6Q40LN
	V68XxkTAbTlFJ4LVhzWi2aUgObt/9nyV7xfAnbRu2GbbLB2WVPM71xJP78Q/DyP8DteH0ZO+y/2
	1IEvGri0yZMPA=
X-Google-Smtp-Source: AGHT+IEs7Cde5AmB0FeCkazQwwniG0looNw85gQe5dguOFC5BE6Nn3UEgWK/O7FmBthpdNB3HxhPqw==
X-Received: by 2002:a05:6a00:2191:b0:7aa:9e4d:b693 with SMTP id d2e1a72fcca58-7aa9e4db99dmr3454695b3a.17.1762134665009;
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm9130423b3a.60.2025.11.02.17.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 99D6E42229A6; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v3 0/9] xfrm docs update
Date: Mon,  3 Nov 2025 08:50:21 +0700
Message-ID: <20251103015029.17018-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=bagasdotme@gmail.com; h=from:subject; bh=IguGKpS5VQ/M3vLUdSUXAb+iSeTOTwLAIFBgATkkuRE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnMWqopF8Z+6ckT2upMNkX1+RNbn+0CrNtNPzGgu5b T6FNXzvKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQCljL8lRPKEb04lePDBVO+ xXGLJ9nv3nE6uU5tm81b7ktcJYfnPWZkOJQ7TUnyx25hh7+nNU4stDyocapPyu3T7fz0vtJHe11 /cgMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are xfrm documentation patches. Patches [1-7/9] are formatting polishing;
[8/9] groups the docs and [9/9] adds MAINTAINERS entries for them.

Enjoy!

Changes since v2 [1]:

  - Also trim trailing colon in xfrm_sysctl section heading (Randy)

[1]: https://lore.kernel.org/linux-doc/20251101094744.46932-1-bagasdotme@gmail.com/

Bagas Sanjaya (9):
  Documentation: xfrm_device: Wrap iproute2 snippets in literal code
    block
  Documentation: xfrm_device: Use numbered list for offloading steps
  Documentation: xfrm_device: Separate hardware offload sublists
  Documentation: xfrm_sync: Properly reindent list text
  Documentation: xfrm_sync: Trim excess section heading characters
  Documentation: xfrm_sysctl: Trim trailing colon in section heading
  Documentation: xfrm_sync: Number the fifth section
  net: Move XFRM documentation into its own subdirectory
  MAINTAINERS: Add entry for XFRM documentation

 Documentation/networking/index.rst            |  5 +-
 Documentation/networking/xfrm/index.rst       | 13 +++
 .../networking/{ => xfrm}/xfrm_device.rst     | 20 ++--
 .../networking/{ => xfrm}/xfrm_proc.rst       |  0
 .../networking/{ => xfrm}/xfrm_sync.rst       | 97 ++++++++++---------
 .../networking/{ => xfrm}/xfrm_sysctl.rst     |  4 +-
 MAINTAINERS                                   |  1 +
 7 files changed, 79 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (64%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (68%)


base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
-- 
An old man doll... just what I always wanted! - Clara


