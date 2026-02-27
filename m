Return-Path: <netdev+bounces-261848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCQfE5KhoWnEvAQAu9opvQ
	(envelope-from <netdev+bounces-261848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:52:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C11B7EA7
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32553100DFB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5C3D3D18;
	Fri, 27 Feb 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im2KpmP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F5239E7E
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200277; cv=none; b=XVzh9fB9gfeSwoq+wB0JBih4yPUqMmZhT9+hHxP85sb77z+HFhiPHAjq+9fol7ACxb2bx3ulxcIr+355MD5+tSOY2QTikO3l+huvTFBwCh4/AbhTckmUwxbIznDQnGVGYRF9Vb2jqx47UaR3u6F2Pr7v/TR3i5E6/bD6onUOwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200277; c=relaxed/simple;
	bh=WMV6tn9mlV0pqCABiPGQtimzOZaKzA39wcT5IAboG5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juK3QzTHv0h2v79GLu+TcEB6su++Wad4iaXzVBWkb3JGMM527AC88Jt1wzyDZIy9ihzM8Gb4T96ZpelH3Pg4bUBtd3eWaPp915CS2aJ6sMIya+Zsxp+2kLkooXeuPJJza9Hz7/zXSpOtmHMOLE1hlz0rcASGsHURY4rSrH0QBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im2KpmP+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaecf9c325so13549295ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772200276; x=1772805076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrFVIKJXuTTRJc6OBlh3QLrFvbOq4eWriAnMmF1D7xw=;
        b=im2KpmP+YU4LHUMi4C5Uado5p3Lm8VOEvLShoiECz7ndOl7N/cyNIv8mtJK0ZinKKJ
         DiAk+aeZzrmB8ss1RJ2NBsnx02lEgvhxWz4jr1SlUX7Mwa4dJAPsYZq6zKH4p1QEPWaf
         Nga/nZpAiWToGEP6ZJwHrxo4kgMQ4t/3FRDAJAsmWCAsslZ1LgM5GZ+xZ9/tizYMyb1b
         Nk0z10rzPcPXXIs1y5tPy7sVhw1VZ8nQvz4EEWjnxRaLqAgXLjL62AHASY3e6a3xuTHf
         YjpTMI/G9VwLRdmeWvEkj5+45i+iSCjrTdp5QNp0upUHOdaUuDzBKLguf9yLoeoebJP6
         R85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772200276; x=1772805076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrFVIKJXuTTRJc6OBlh3QLrFvbOq4eWriAnMmF1D7xw=;
        b=V4tmYzlRzTapH5CejJifKuuYjV31JFWz506WqXQxFG63C5rPfXx5KC4lR01p4A5ZMB
         wGbN4ARGEFMSF6Wmy9g+qTz+G2HVH5Z8lf2OZ85iGi83M5W7+ekGP3enEV8b3UzOeELb
         GQ4kq8fPH9N5/iGtMp15j+PQouhrRGmOAYrfHRTtkxiFnnPg4OEfJ4BmISghEE2iGvxd
         Pdcz02yz8N2P423gRsW9TJC3lrDzj8bWYpjiHDb55fFMMMeIOk8P/QOE/5TW9mQD1PNP
         3s/W3Anx7ltM8sGd8nziJCqdpENbyFml2QLudC97DaYrnRa6iRD0jnSim4aFGHGS7qx0
         LBdA==
X-Gm-Message-State: AOJu0YwYsvR1RlFSTae7eEhk9maXTKzuOriilVzrvQYUQ5cv6vYM/Fhv
	AkI8Fomh0/XGUAWF08U/tC5Y82rrbxLQY8lX0XkOUyEgfcJt/F2viCXPeUiBX7yx
X-Gm-Gg: ATEYQzzAMBThppkAgKLy1NMnFEjuhmxk1qlsjk1AcPj2ER/0P2sZx5P5l5sAIWcoG2q
	7CeFrzZq+sR/g4A8asRUhRbS739IvVvK8wK+I4VmRCbqYWlDDwc55dHr2xH49qzhpG0587JlpgB
	t3IbEYZWUvMZ2jtmPHjM9XadLZ9wbhoVj6acOKbRJLX+hqcCuNbfqysJF2KBBZ/Yy6EPNa/Oag4
	jIWxX0vQBEHHdDBSdLHrF7y+iEQVmqToHGUhue6MnKvRhT/eoxIsmJCEKdZtN7LWcFyar/nLxM1
	HUGC0KiC7NXoPV5f/GScIDMPLSa1err47feKF2Fk9wXC3dMQRC1gitfW+cGWc6/hayILERuldS2
	gZCHSfSRntijuXuFsjBogQfC2FRK/+MInxHSPBlLoC4NFU4wSiyf690yuWTJ5sdReZsNuEq3U3W
	sp9YBrMu5ssfhYCT5/Did/gFJSPxixtfc/26jsOzlqIAVuC4eFfVIfyak=
X-Received: by 2002:a17:902:dac6:b0:2a0:a33d:1385 with SMTP id d9443c01a7336-2adf79830bcmr67920805ad.17.1772200275692;
        Fri, 27 Feb 2026 05:51:15 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d24b3sm55490275ad.78.2026.02.27.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 05:51:15 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Fri, 27 Feb 2026 21:50:52 +0800
Message-ID: <20260227135057.2730254-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261848-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A72C11B7EA7
X-Rspamd-Action: no action

Avoid load/store tearing of 64-bit values on 32-bit architectures.

v2: https://lore.kernel.org/r/20260224112411.1561917-1-mmyangfl@gmail.com
  - git rid of print_port_err()
  - remove unused variable
v1: https://lore.kernel.org/r/20260203171305.95085-1-mmyangfl@gmail.com
  - use functions instead of macros
  - rework commit message
  - hold lock for stats when possible
v0:
  - Sending remaining part of
    https://lore.kernel.org/r/20260118013019.1078847-1-mmyangfl@gmail.com

David Yang (2):
  net: dsa: yt921x: Return early for failed MIB read
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 206 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 114 ++++++++++++----------
 2 files changed, 184 insertions(+), 136 deletions(-)

-- 
2.51.0


