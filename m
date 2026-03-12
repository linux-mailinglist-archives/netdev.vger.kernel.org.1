Return-Path: <netdev+bounces-267181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPQPMHYIs2kMRwAAu9opvQ
	(envelope-from <netdev+bounces-267181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:39:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF927738B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D2230E5008
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C013FFAAD;
	Thu, 12 Mar 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iaq94g29"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE193F54AB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340707; cv=none; b=ZcyVZ49ZoMo+I+kG9irVzKsBemBql3FwlD6nA61S2mJxL1WyENYaNvzv4HYvQlG6mVXiy1183gwu7bnoWWHZjRoPnWLnQ0VoeKojtzio0/CE83aiJC65qrT44/EltsboBAJ7rFVe5s5QIIafIuz6LhgwOxHwej0L4yG6zCfLXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340707; c=relaxed/simple;
	bh=gWKYnA9y4mRp/F/hXQk0HtNNu/EJeWyE9t/c9l8lo/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGBvqUtTzhRirXZfQK3t5FNcIrnX/ESEf5RtWNZoNmRLs/o9Gkf3G+JUGUq/6AZU5Fr+06j7TggrhBVgT9rb6aFgHVqkuvKOpZZ44puZdgigzM+I2/5av9ujUwtSrl5xJcMzYZI8xZIC7bUcQdzMRP3aexfd4KXt0sI0VwQc+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iaq94g29; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so15519915e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773340703; x=1773945503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OnplUakzpDGl0akz+yg54GLhkStqs6kOTbb2DNMmxE=;
        b=Iaq94g298bAeB5MUt2jvG+jvR6C72rLWJXuvnR29jvum+HDt2IOa/7eRR63I4XLHjQ
         G1WEuEvCEAb//1yESfM+uEwU8kiSDOoXU1EXKYMA0mvKSo57bTgvJWEU/iQOWl6sIW3P
         S8Dx+WXAYsqb7gkyhlJ3XogQkvaWzVBtzDIStRJPBOVXuFPK9ScDDPWEQWLBWyp9IJ6z
         pFTbL8DGtTZ7xPoYSF+U3oX6rAp2dg87+wDVLnM5KQhUG6PU8pwsby6W8+MWoYTcrDGH
         6XiSHAQ99y9A2xnirnemKUotFMtP3t6ksJxunLNh0IhZnYQIythFwOPIyJ+XDEps+woN
         Nl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340703; x=1773945503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OnplUakzpDGl0akz+yg54GLhkStqs6kOTbb2DNMmxE=;
        b=d9PAEEx+D43L67XPQh1y9DFQLpVDKwxbA9IGp9Sc/G72NLmVMYGBZsRIfsitd08S0f
         G5Z3r1mXr59uLCiuM3yr+IMlt5EyuW5NfHBfUa3YL3D0v1pASyqq5nvctJZGwhTVfRhP
         aYYX0X+YWK8maNoDXbbBkeG3edzY7oLEwYy3Kh900+0zKv6EytlS8mp9p3AP9n/5qCXF
         kEPT968t67VccRFfuCTc2ipGrpL4wtkqVrMueFVnfa1QIlwvX4QNACCOC7gGw1ToLLTk
         7gl4jUFSYHJRcyAh1sDUVkSurOjPLoGj+6PlwLTVPWQk/4TsPx11SLF2H8NKPA1yiDji
         vJnA==
X-Gm-Message-State: AOJu0YzalXA7QEOfDE5p8y8gWe1NslUxYaXu1T7dZSUGyIV2/Kp2vGy8
	VblcSk/G6htS1tTD6Oks6XxBpq/y5HDT/VKzeobzbuTs7FW3hrgefG/s
X-Gm-Gg: ATEYQzya1wavw0Y3WeDd5qBI9Wxlz8t2acHN6phAePFxd3QIL84Il4IzW3HHyMtOSkU
	dYi/As/Awjf4jUi5P+qsSnx6o/YbHlbE8cJYMt97WcjJDB6FCISUNy2lUALYAeFo8dz1SNrw/dY
	vC22brYIAkOhlfRWnfs87LgciPRLQGp357GwEhcqQu1itVNpMGcs7KIIBsUBLKt6VPg29rUreAd
	qOtVOMJwd3LTbSOzrh5lW09+auil0m+d4FU1oR1FPxN840BrG0QKe+qiuQENpXr11oi17oxI2B+
	IWs0BHt1wRqMXi529n6oM2D3ZNwh+9EPc5QbG61JMoNvdEOUqJ03e90FOC0ZrE/6d3kavuxHC1y
	/cFnOY9HeRWk9IL243O5MgP25WSrZC5wnf6gxp8sNPqXOc3lOrp3BXu2TOAn78Ckzije3j9J+qt
	Fk8L645MasxvlxJj/YsLBNJxpR57opjV7R8HO8KqLWG0/RPmpRMfsqNtdfRn349eEf5IulEdlC
X-Received: by 2002:a05:600c:c4ac:b0:485:40a4:364 with SMTP id 5b1f17b1804b1-4855670c2a5mr5450795e9.26.1773340703080;
        Thu, 12 Mar 2026 11:38:23 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm135560395e9.5.2026.03.12.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:38:22 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] e1000e: add XDP support
Date: Thu, 12 Mar 2026 19:38:15 +0100
Message-ID: <20260312183817.104878-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267181-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid]
X-Rspamd-Queue-Id: 24DF927738B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP support to e1000e driver. First patch adds basic XDP support,
while the second one adds support for AF_XDP.
Tested on an Intel 82574L Gigabit card.

v2: added a missing 'select PAGE_POOL' which triggered a build failure
with some configurations.

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |   18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  600 +-
 .../net/ethernet/intel/e1000e/netdev.c.orig   | 8529 +++++++++++++++++
 .../net/ethernet/intel/e1000e/netdev.c.rej    |   46 +
 5 files changed, 9182 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/e1000e/netdev.c.orig
 create mode 100644 drivers/net/ethernet/intel/e1000e/netdev.c.rej

-- 
2.53.0


