Return-Path: <netdev+bounces-276071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM4rIV8u1Wli1wcAu9opvQ
	(envelope-from <netdev+bounces-276071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCFF3B1AE6
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8FA30364B4
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DD3CF66F;
	Tue,  7 Apr 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAQwKfp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470633CE48C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578220; cv=none; b=lOFebBOuxRRHnmcPI0Lgz1+ye7gsiqkDR5QydkgF8prRsNe76IbLGq0fmcpEVEQgthSX7qfe9XKe5JzUg5ncQYsqcFIYOHtT3+rlx1oPeQ7XZSHlvTwvTPO8rVJ8tnN9Ybk7Ya0YQk0BGq5vmAM5Jik1d8p+XNmQDsL9OCCx3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578220; c=relaxed/simple;
	bh=TUhAascHJkJnb+sCYbmMHYreDdjo0xGMo6BRJJAqRDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8vjTWloBqAs7eS1oUjCo3fCE03/f+fCkfOk8MXszPO5J8mNiuFaecYMyAau+pqgQHLFOz4qOEPRrJasDN/rfULOfO4NanldLUu2DenezjEokm91u6Ne09MevBkNwEoGM/AOR0nX8g8viC5wgCIto+74VxTUQDKB2VXJX7mSipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAQwKfp8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-356337f058aso2953148a91.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578214; x=1776183014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OB9m1N43YC8Rdb9jnzxP8hF4LQRJNbIUuRpA88h7M3o=;
        b=CAQwKfp8AQst6HrSoti1pVOxvFmfUfHbBUyeUdngnE0HEwKajptWTsxjzGMiUm/uIk
         J7tOpaXU6Z6fXbEM+ShbtzhD40tYyKqW+dft6mx+pJc6lXQ3XAMu2qlvy9yY+pF9dpSL
         J23f4fHfROYVFDZ/4jueKJwh2uCzm2gq9xcE0KZnI8b8NFWtrNwGL/nOPePuxbEi0NHY
         tufxi/Pj7wjTzFSJAhpqizWzqM2ebGVGnzv/b2kt4iW/3Z1cT3XdGjv4W6bkfDARpX0B
         JG5C5Dwmgo1wVdBxIga/4m0eWWnmOiHyV04BUEDXGLayXh2AZPSrPyaWQJsDK3Bgksbf
         eR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578214; x=1776183014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB9m1N43YC8Rdb9jnzxP8hF4LQRJNbIUuRpA88h7M3o=;
        b=VYi+AEMcub7SDZTzAoXDmt0pwVlD7ndIg3or2mZVOaGSVPMxczLCsn2IVkiAerkFzT
         gKKI6G1ArQG5DQwdqoLzXLUv26CL6a1+8bi+7YlWzU2ozqHbquF9MypgnObUBQHRrwzH
         URZXDYzhYrdSfFzgbkQKmVFpEpxjY6usSINjW7HeHxrODnVFplwrKU44/zR9Umqjtr/A
         qT6r20vFUivKykwLC9A1nMCojyb2dgn0g/XmMcjs3czWKbPAPmlhkVWV9iy0wGRP3y9z
         /xXEleJ1odAF6SMgx0J/6fdDkqt3IjiX2ixu5VzjpE5GoIv77LMauj2jurYOlzWz1SyJ
         h/cQ==
X-Gm-Message-State: AOJu0YxoXB7F1xsPHV2AJs8guNnFivK+0uj7Rz1uMVhPSo9CQwIXT/4T
	gwpPGisygF0stvB14X7vcbyurSyfsUdmjj40u/kMhBbqzb2WLBRl/wkKe3o87A==
X-Gm-Gg: AeBDieuVI6PR6xQw2WbQYwk0wsYrxnoreKxhPYJArzeXdKIj3kgAboi6jfqFwxSETyV
	14Y58QwP8+eTOeWcobUF3+tQjwvExa7DCiYQL8FgK2PqjqAYMvEf1XBiqi0HENnORxdchWSkBTR
	+1vA/BGxXS42ptG4lZoBvBOMbT2GI0p5oNRLFZ9nBxDzDcAHS6LGn3ZL4kz/mLjEm1nD6J1h9Mw
	A2DdpEpY9zmj7UtUITg+KozEWGoZqcxOtnSLg7cshgXH5Et4xvQ6/x/S05aeW6EFo8cUAIsaM0T
	wsdB7Z3/bNfEBwE1pWzFwbOFctGT1dOQnq8rpafRJlITNT7oeLkVWzydnGQaB/g259GUkER74j7
	CDeaLQukMmiMk1l5TQJhFDvQZBKCvFLToL/n09XrGGkw9spCKwRwQREUDmTo2NblIV+ZHFTwgHd
	JrGhw08VFp1k2FtcpesjagWxRc3ObHrmb802QVmSFDUcWraJ7O
X-Received: by 2002:a17:90b:2b50:b0:35d:a6eb:197f with SMTP id 98e67ed59e1d1-35de660a696mr16054758a91.0.1775578214310;
        Tue, 07 Apr 2026 09:10:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6372078sm15650238a12.0.2026.04.07.09.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:10:13 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v3 0/4] net: dsa: yt921x: Add port police/tbf support
Date: Wed,  8 Apr 2026 00:05:52 +0800
Message-ID: <20260407160559.1747616-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BCFF3B1AE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2: https://lore.kernel.org/r/20260402223437.109097-1-mmyangfl@gmail.com
  - refine commit messages and code styles, no functional changes
v1: https://lore.kernel.org/r/20260225090853.2021140-1-mmyangfl@gmail.com
  - pass extack to user tc policers
  - keep reg64 helpers along with reg96
  - avoid macros in favor of functions
  - adjust log messages

David Yang (4):
  net: dsa: pass extack to user tc policers
  net: dsa: yt921x: Refactor long register helpers
  net: dsa: yt921x: Add port police support
  net: dsa: yt921x: Add port qdisc tbf support

 drivers/net/dsa/ocelot/felix.c         |   3 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   3 +-
 drivers/net/dsa/yt921x.c               | 560 ++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h               | 155 ++++++-
 include/net/dsa.h                      |   3 +-
 net/dsa/user.c                         |   2 +-
 6 files changed, 651 insertions(+), 75 deletions(-)

-- 
2.53.0


