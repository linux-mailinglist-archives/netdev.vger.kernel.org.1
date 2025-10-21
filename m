Return-Path: <netdev+bounces-231148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5058BF5B54
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8762118C7D6A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02332B985;
	Tue, 21 Oct 2025 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Y8IL0pmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA818859B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041419; cv=none; b=f9nv0sY+X6UN2hYTK6lJ7iqK/NQiLkb2mywEGhS8+9CKIf8ML1JlxPYZSxIkbc/PofIbKCzd7K0bayXzZ3hXsAD5B0JyWvnaBc/GzVn9smVbj1U9JuIL4dbb4hIzsgbJn6mIAOTgUN4MGTC8bCBINIrO/tYmu4J4VTCVRLLc4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041419; c=relaxed/simple;
	bh=QWkXla9KhGa4RzfCLcMx24ZSBrG65ZfHYZmPM6DOPr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYCzlh6kWxN8fYVjVnY4wtv9FAg0dzWYmC3QB98N/GaBaV+rh0qq6A4M2owNW1HJ0BHbgFDGCaYaNh3KMdAZ0D1nSzPP1T5gfBocABluTx6GeTvL/bWJDKLTvBFBANDrM0LALQX0FFwD3GR5tSHatR0PMeAhPy0gnHqTRe3jAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Y8IL0pmO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471b80b994bso35215835e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1761041415; x=1761646215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQUiAR30RLSykbyCOJSpDtF8tzW/WFR/WM0pBIVZXlw=;
        b=Y8IL0pmO79Rowhh4dQzgIjsqHJJkRDd4a76BWuOdlCpbyXEFvoBnqXwkV41Fn7w7IP
         rULkjkCJ8ea9huax0YEyhbCIuqJDS1zv8lxVHW8XhDclw+9sdxcPxWrQ4MQtWQMcF+IJ
         NBUxhPd48InYdGYItHNr7u1938xhupilmzNbBeLeAeWbefEMDG1frV3rRhGCbrw88yHp
         Bf2yhvOQoG+1GnY+ifpPtsfZ4MaCUoVwRq/yOLFMm+ywka0VHWLorlcEk801P7396TdJ
         yQElPWVBI+RJRvRg5bZn1scilpl1uZHi/4ddyRjIi3uwtbiG7AzEdzKEJTwA+AaNlsT1
         lXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041415; x=1761646215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQUiAR30RLSykbyCOJSpDtF8tzW/WFR/WM0pBIVZXlw=;
        b=a1zKtkalV1M5hyFy6otqzog8vdtXiqZmjaQGOCKzYKhIbNM7jIkQIz6sO0T30Y6D8B
         /81c0s98fPJDLK50S/hszc7AVQIk8DjXIVohY/lLv78weCAiPlTmaxgUD62CYAf/h5J2
         BtjhirPNecAayv1vAPwTW1QFysqpJgFUbcu4/0Y7y6mZp+p/YAqWpld4+ooWwG7JMcoG
         7uReQ6DhrMv/Y6bBvwCNF60klOsYvKH4P0/CeYx8V5rEjZgXv/0LmUMjMTdHIfyrByyV
         8FDx+zu6Q9od3mVJhsDpysh6UtgyEON9DR+An5UNR8lRQMfvcf1hdxH+9jwyQpsLwi2i
         WePg==
X-Gm-Message-State: AOJu0YzTjaWcfH0hNRYCFVlZr05sU/Egj166z0UP22U1QBHgdhIwrsPX
	Y9z2TM44U7GvVWQc6s2SMVaamN6BTbzItD5ZUkf1COrT3fxSniC3eD8aBoUqOgsnlGkcjfXreU2
	2cSaco2w=
X-Gm-Gg: ASbGnctGmkVAyTVUN0VlW6txnG6p7VWMXH788nGvkzw+67YVB5ujNftR6FASGrPGq+I
	bBZhO+AG4Z9f1HiNP7D4juI/XN08GMa538CpMPs9B+Yop9IKH/itygJYtHkH0UNgaTl8dE/X2xg
	ZPVaXeNH0Xkg9qDWOEoiSYuhParIZsUTqteVX97QYdkXTt7GZlQL43CQYIVXIZTNLXzTknvABmi
	TE604ojeOn6RmapoHaOPhMI0eVE0oVZcowdEycL1sB50Jtq1FGmc7bfaqUJqMslW9w5RgAUh3HB
	p/YT08jOxQkkLZ9MBY+DN+L9qIjNFDmX4oCPXw8eiOVFnQcW+Q1sKjl+ehkO/aR9Si1jvdX1MzI
	jYJlXqRd68Pvwj5XOJZK+YgS5qtUpXbbGQS1cCmTI7MeijNdyRfma7W+yI/usXzy6QI8BWqk=
X-Google-Smtp-Source: AGHT+IFGykqlibzHxxtPew9brkvUd33IT16rqzeBXTt5Nrk+CFD4dmqQsyXjOuZ5iUjTS9jWu1VvwA==
X-Received: by 2002:a05:600c:3548:b0:471:131f:85aa with SMTP id 5b1f17b1804b1-471178a74a2mr92824035e9.13.1761041415560;
        Tue, 21 Oct 2025 03:10:15 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm20172032f8f.28.2025.10.21.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:10:15 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3 0/3] fix poll behaviour for TCP-based tunnel protocols
Date: Tue, 21 Oct 2025 12:09:39 +0200
Message-ID: <20251021100942.195010-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series introduces a polling function for datagram-style
sockets that operates on custom skb queues, and updates ovpn (the
OpenVPN data-channel offload module) and espintcp (the TCP Encapsulation
of IKE and IPsec Packets implementation) to use it accordingly.

Protocols like the aforementioned one decapsulate packets received over
TCP and deliver userspace-bound data through a separate skb queue, not
the standard sk_receive_queue. Previously, both relied on
datagram_poll(), which would signal readiness based on non-userspace
packets, leading to misleading poll results and unnecessary recv
attempts in userspace.

Patch 1 introduces datagram_poll_queue(), a variant of datagram_poll()
that accepts an explicit receive queue. This builds on the approach
introduced in commit b50b058, which extended other skb-related functions
to support custom queues. Patch 2 and 3 update espintcp_poll() and
ovpn_tcp_poll() respectively to use this helper, ensuring readiness is
only signaled when userspace data is available.

Each patch is self-contained and the ovpn one includes rationale and
lifecycle enforcement where appropriate.

Thanks for your time and feedback.

Best Regards,

Ralf Lici
Mandelbit Srl

Changes since v2:
- Documented return value in datagram_poll() kernel-doc
- Replaced WARN_ON with WARN to print a custom message in
  ovpn_tcp_poll()

Changes since v1:
- Documented return value in datagram_poll_queue() kernel-doc
- Added missing CCs

---

Ralf Lici (3):
  net: datagram: introduce datagram_poll_queue for custom receive queues
  espintcp: use datagram_poll_queue for socket readiness
  ovpn: use datagram_poll_queue for socket readiness in TCP

 drivers/net/ovpn/tcp.c | 26 +++++++++++++++++++++----
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 44 ++++++++++++++++++++++++++++++++----------
 net/xfrm/espintcp.c    |  6 +-----
 4 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.51.0


