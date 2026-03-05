Return-Path: <netdev+bounces-264306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMwXGZtlqWlN6wAAu9opvQ
	(envelope-from <netdev+bounces-264306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:14:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C91210682
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5933C3050ED1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25368378D97;
	Thu,  5 Mar 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="Ov00LXTa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347A1B4257
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708978; cv=none; b=m5S8l/Z2tBsa3RZx/W4PXSdGOotsOHAB0imXZJXBr5hhQROel4ZiWZ3lfji5lv99PipyxT0WMF/TpZ3IQEMtx+GOxNW9E5PUqmpBfZCFEOW2IIGDTwfqxKhAjmhKF1XNRmCjtpnPK+mLMNFXTsOarssBdnna6A12ASftW4gVuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708978; c=relaxed/simple;
	bh=l5Xr+uHD/kIgcmg+mviCrCRCGCv2tMRnHs3cqqddHBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H2zc5BpmRayU9SZcpIvIDlRCWZVCWo1l3PFYH8lZYPkC2gqGfP2fjIrXLo/TRY4sr3m+e4SBAW69PUPKD2zhxV7cvuz1JPFnqVvjsDgrO7sX3/Dx725spLg3RMu+Mq0jve2JelMqJ/0UMl43tafEIm9FB3BJPoFXUNeRjPIr4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=Ov00LXTa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae50a33ff8so34627645ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772708975; x=1773313775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLtx7H3uqOo9s5fedif7rKAr7wusiY0HBhlLK0qaVbw=;
        b=Ov00LXTaHuWGOH18oL1sPnToTz+7N/eKIIld+/dE/oXKchX+c23eGK4tpzxNvUcJUt
         v+JtPKvHkZPL7b3qy0zw+3D2LHSRQMCYYO3CAzAfFifPy2F2sXVtwNfwMoReE8B26ZOj
         RMtd3pFLx9H7Et0YXpAkPaS7jKMB2b/SWj8WGGgSrB2FX+niBdFQvYckbp+UU6YltULA
         wrqzljHq9Ci/02a8g18Koj199NBKaUIfgarZ4gdCxXyK4JOVJuCbpeyFKQUdHPIk1321
         11ihiUKlb5siGqpmKLBf6P+yWj1kjFkvmLGQgQEYJE1roZV1ljnirzfvk59QfRM2eF3a
         RhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708975; x=1773313775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLtx7H3uqOo9s5fedif7rKAr7wusiY0HBhlLK0qaVbw=;
        b=HjuAz2YUQNMlzprJreW9Qfk9cJQUnXeLY/YXAAmLyMbnDJdkJ2rsq514SwqreWTLLQ
         3TvdfTLhmqEDmGdbrJqC2UKkYRnU3OhGCV95dBMUiWSuyQHgwZQt8NZ61VXRxTBpoXxA
         zJl5QUNFZ9D9VGLpJjDIQV5P4IMar3arkhMAg6RasyVAsDvuI4mE0aJgYprXTudkQDEV
         w2/PTWITFI4/RNRhFJd2FCQAYmB8/MicDp02Tu3dTAQS+Z8GeAWEVu3X/dRaRnsfeVm/
         PHuVOnE/hjY+TSFyPTyf7OXVdLc+Zm6+Lvm70FovH5Q0pMFIPcyk98kHVjEQWJPRzTwf
         Hkqg==
X-Forwarded-Encrypted: i=1; AJvYcCXCbmbT5Na1BBvPmS4sKNFfEASPXd/FIg8MWU9dOx5654r4lSTO0NpojJc3FircG8iQV4iD59E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCMWxIdA8ybMIop6SIs0wYT28X1gaE+VxLefuD9ORI6/ub1PY
	+BVW57yQ/Zkp9Oj3Jl8v2Do6493sFXpBHia8NSqIO4Pe61WW7VWvHZ6VwtOjLlEc5vjHmdUwbpN
	qRvVM
X-Gm-Gg: ATEYQzyIK7f7DDUrvXSOGNtKZW70xs1sb4NAxCiUJcOkgzI1BLf2CoWEIVJ2jNSbNpV
	aRUL15t7XMS5/Om99IpSqRtmdlHw48tGY/P6+cdIuG+QWz0wtmOBdRfUN46aUlgghCMagCs1YV5
	SrZkn2OaVhsjbcNS3d8W+qbaDZLjCrTnznA36NdSDT7Q+PGRpejzcsmZ6nng/aqgjrUUQBloxUf
	HJR8yPA7TfV7yTjmMcnT2Dn1vVebBbesHEEwCtavOShmEgaVeoXThBttHC2AfPQ+G8sLVmWsgYX
	Yboab7tkXmwzF92hRhoyhDG8W+gR7rpRfTdTGGSD6VOQUnDFyQnpHEZCnoQYfmjLqdZqNKFIe4c
	Dk/IYFxo1rfLjKTgSOHKAx9mNTcQ6cmudjYEsYeYx0n8wShNapgB4ApOpSP/8o/EpAZwl90CmFQ
	sqBZ5/DQzh0SALflJq1wVId7U0MkY+WQ+DCQ1/HdBL85Gla0u4hnH/pkX9W3KxTpArmpXDU2FrU
	0JsLL6/sZSrXWL54biOgA6/XHoNnk0Rjw==
X-Received: by 2002:a17:902:d549:b0:2ae:3f3f:67b8 with SMTP id d9443c01a7336-2ae6a9e507amr51888285ad.15.1772708975632;
        Thu, 05 Mar 2026 03:09:35 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34fesm153501155ad.28.2026.03.05.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:09:35 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Jeff Garzik <jeff@garzik.org>,
	Jay Vosburgh <fubar@us.ibm.com>
Cc: Kota Toda <kota.toda@gmo-cybersecurity.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Subject: [PATCH v4 0/2] net: bonding: fix type-confusion in bonding header_ops
Date: Thu,  5 Mar 2026 20:07:47 +0900
Message-ID: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0C91210682
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email,gmo-cybersecurity.com:mid]
X-Rspamd-Action: no action

In bond_setup_by_slave(), the slave’s header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

This type-confusion bug can lead to out-of-bounds writes into the skb,
resulting in memory corruption.

Patch 1 stores the slave's header_ops in struct bonding and sets
wrapper callbacks in bond_In bond_setup_by_slave(), the slave’s
header_ops are unconditionally
copied into the bonding device. As a result, the bonding device may invoke
the slave-specific header operations on itself, causing
netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
as the slave's private-data type.

Patch 2 uses READ_ONCE when loading header_ops callbacks
to avoid races with concurrent updates.

Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>

Kota Toda (2):
  net: bonding: fix type-confusion in bonding header_ops
  net: add READ_ONCE for header_ops callbacks

 drivers/net/bonding/bond_main.c | 67 ++++++++++++++++++++++++++++++++-
 include/linux/netdevice.h       | 41 ++++++++++++++------
 include/net/bonding.h           |  5 +++
 include/net/cfg802154.h         |  2 +-
 net/core/neighbour.c            |  6 +--
 net/ipv4/arp.c                  |  2 +-
 net/ipv6/ndisc.c                |  2 +-
 7 files changed, 106 insertions(+), 19 deletions(-)

-- 
2.53.0


