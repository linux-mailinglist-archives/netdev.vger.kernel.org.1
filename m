Return-Path: <netdev+bounces-242281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9DC8E472
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A7C3AF214
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D495331A41;
	Thu, 27 Nov 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq7FgEOp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B61331A5F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246930; cv=none; b=B8fq5WYbtg6Z8EmpbyXVR5VSQ4WpoZQyb3lbWHb5GYeZthH1usNALcA6onvDr7IMak6mKz34n1eQzyWgXrhDSfTSN2MbzI5FouLtgWhjjeAdn6Ij1LVyYymAG3nFaiKe8WjG0we/DoahR/KAwQ6ehf3FUHZi8eId9HUKYz7yF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246930; c=relaxed/simple;
	bh=1K4OCvZxEzQDRE8LJKge4XKxycRUKZFB0OkSlB8s6xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA1kDHIGF3HPrK5Ad50yw61qKfkVL+DmymGe+XK3Gv4ihGuY0u0aNhg/mzk+TRtmLlTknacbkshRYlr21Fz2puSA/LcGYdkjSSPG5BKAALlj5SqufOGLxLgp1le9+E32O0laA8cgsy7dUmliZiM0QRZrDA0NkZ0iF60ZI6E1Fp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq7FgEOp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b38de7940so400177f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764246927; x=1764851727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx6ShXvINXIIs7xWDlK1aRtaDSsS7EPpkVWjDVXl6gQ=;
        b=Eq7FgEOpWKud3QRarQqbF/7tgKPPTycBc4ulQ50klzdZJ/Eb2DMKaCoppLopWVOOXs
         MzW3N2+DlpM/rsl9GVCIhNFTLzcJklid43i+ZiMmqAmDua/5jLTs+4cBkhw6nAWzPO+j
         wN6UBY6BnDPK2bG/2Pf2uab0Jr6blaFJYdVTtbDSKng7FtnfRmiMdh3/tekCgkA6e1Ql
         e4EGvHTBaA10Pqc1btZIU+75uRx5TecoQyyRhZtmnbXhJv3LmpsJZR9IMxS569fb7Usz
         5TDWCBrUCSwm4HuiLl+4eqPWyzgQ1nYt+wv9WS2Of2GdUj22d0l+dy9IjnBRs+yNdZXc
         NoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764246927; x=1764851727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tx6ShXvINXIIs7xWDlK1aRtaDSsS7EPpkVWjDVXl6gQ=;
        b=uQIjRvFUrK9O0XX94Sf30KepcfAc9gS87KrGWI9NV3TZUK+v4VTKXAc6EjxtBlRfvu
         e6f6pEEzUuMLmR4NIrk7YLPf/hxzUHvxTLdA9NsE4VFhy74un5PCzT+1vSs0jaOD64Qy
         JO55BRTwjNpWrEPYSxGA1vAMrmD178g8k81+5Wf+uMtPYXVd7yldqX6RNlRG/PyZcKuM
         gN2YxKXG5Cg6nRfT+/rgD3nMWXwjKglHhJnfBU4CtmJx/bu+p4f0c0++AXGA8KIv9r7Z
         FFLnJXGc85tiubnQKwW3CyhAf2ox/gxa5OD7z2GeLTwdcGn6TxmBot8ir46/tumzlTx6
         gC1A==
X-Forwarded-Encrypted: i=1; AJvYcCWQTvYQlXFMZ2VHM4i2b8BBU2EXH2qDHjL5fNGmP6VxNSyTpDoRLqi+md7dOrYwHryXRnLA6WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjycHL5d/UJ8P4cUA9vhNeo3mozZYPEhTcxjUzEUU67ke+TPZ
	1+n5IhCmqG2jmThdeGTlsFAJs5XOOMC09E4sBXnb6PNKSeXOPK6/K5vY
X-Gm-Gg: ASbGncskXNYaThvWSVR3gGKsqms7aATfhd84d8wCERIz6nPg6SsElefkg1ekKnuJ9Nx
	P8D2TPm1H79gya0yRFmBEs/6OYBuXBL7Xv8i2+Uyt2bRAlm2wImNnibiGnkCp5RorrTpwdWRMQq
	IXEDf78NR5vhfZSEE2FADm3XaLnUwcBQRFBLYI2IjFfM336AlmC0soHuwD7MCq3ihEgnlyNxb0g
	LnPp7y9fjvhkq4D3Fe2rQaogGLa9Yig1YDyW1GK1YSBUogaLk/zw4mOS9UDgZ+wkhfe8JLAa30t
	Y3lGsibJEZdMfmvoP1KcBWMOCYV4DAQAQDH8ya7w0cNy8hZXQhRUCZSuvQb/wG7Y3RK8U/OAYTV
	CzM6GgpWqh5fd1IKBCVT8zbYjVZyid9Co6qQO6hjhelWzBrT72lqX+pCMDu0sCSD+7CstYjYMXL
	7L9UEwG/mkd/Z2nTJtPNnxtEXjyA==
X-Google-Smtp-Source: AGHT+IFHMT4PxMZxx9w23PTENIaJwUdHxx5Drc4Kpue2ONvrVFGEKFtRv4+0HIY0osgDTEBL4Ox+gA==
X-Received: by 2002:a05:6000:1252:b0:42b:47da:c318 with SMTP id ffacd0b85a97d-42cc1d19514mr19969954f8f.52.1764246926683;
        Thu, 27 Nov 2025 04:35:26 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:7864:d69:c1a:dad8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm3220718f8f.29.2025.11.27.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:35:26 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Florian Westphal <fw@strlen.de>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/4] tools: ynl: add a lint makefile target
Date: Thu, 27 Nov 2025 12:35:00 +0000
Message-ID: <20251127123502.89142-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251127123502.89142-1-donald.hunter@gmail.com>
References: <20251127123502.89142-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a lint target to run yamllint on the YNL specs.

make -C tools/net/ynl lint
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
yamllint ../../../Documentation/netlink/specs/*.yaml
../../../Documentation/netlink/specs/ethtool.yaml
  1272:21   warning  truthy value should be one of [false, true]  (truthy)

make: Leaving directory '/home/donaldh/net-next/tools/net/ynl'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index b23083b2dfb2..7736b492f559 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -56,6 +56,8 @@ install: libynl.a lib/*.h
 run_tests:
 	@$(MAKE) -C tests run_tests
 
+lint:
+	yamllint $(SPECDIR)
 
 schema_check:
 	@N=1; \
@@ -72,4 +74,4 @@ schema_check:
 		N=$$((N+1)) ; \
 	done
 
-.PHONY: all clean distclean install run_tests schema_check $(SUBDIRS)
+.PHONY: all clean distclean install run_tests lint schema_check $(SUBDIRS)
-- 
2.51.1


