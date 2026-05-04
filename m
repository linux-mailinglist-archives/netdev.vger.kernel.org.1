Return-Path: <netdev+bounces-283775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QXjAMVVx+GlCvAIAu9opvQ
	(envelope-from <netdev+bounces-283775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:13:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FF4BB821
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3918A30157E7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7810390CB3;
	Mon,  4 May 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXf4BBVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895E347FC0
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889619; cv=none; b=TpY/NpnzOOPnyblpUC4PXgsAQx3b4puIGrsYmxcxLCPwTAjvQNPGh5u6Y5VmkxwSiBOT3fjYXZwNqgeocrq5xZ5VlKwGnm+5V4S/z39fD/gHMvFGoRz9kMZtzR4zhp5Bu9wD1txL138clAJbbJAS5qjYTJykVwuwJC/gclTWZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889619; c=relaxed/simple;
	bh=YVKJD9R/wW93oImveMYOeZh2tOGA99LflrKa9qClbTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLpWWmLj3qTqyQ/IDDqoIPG4ttJ5Qaz+BBcH+NmkyjysowXfKguvWCMdHFqPR8wyjzvc7OeOi+rVhHsUa01Hx8/7uAmOVvea+vEuCJcAHZ2jLo319yx2CBU1YljsYV2tmtfFo99EqCof41xviaKygmp0/csEPzHycEFwwTViv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXf4BBVf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1634903b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889617; x=1778494417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShLqeg6myymJAx5IWhd73H8qF86ItcSHQZ5YQkW7vfg=;
        b=CXf4BBVfo0o/aQauBX44+HKxh0dOcues+uqDMtSGWB0oyhVmon0eTm2rDgLjmUrLzr
         iZ4Zgri07kzP0DXSLXnjMLRiCXpzCDxSYTX2S2AXKGmN0cn5MnCUnaBGI2Eys8T5yIUC
         dgEsr5+GNrzpzm/KOl72HZ/MOO/KOK1hzc8IZD8gmEVb5Mnsmoa8p0Gd71DPNNKDk5ee
         798etOviQ8ZZANCOIYNj2LUMB4VQg5a5mHJuOSW9RJyAFKTXqxpdESVgF/WH/70Bf9s0
         m5MeosC4xo5g7J+sgNLAJp7I9jqIN31vBaQyUC96OXhPl1gk/Wed8CFG6Yz3TFqdlpUd
         IHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889617; x=1778494417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShLqeg6myymJAx5IWhd73H8qF86ItcSHQZ5YQkW7vfg=;
        b=GTVPKa+6RPHSbiLdNRpaDubNQkfDE27EVtlC/lKNC9hWe8IJoYLcOvI1Dr4gFk6jK+
         PzSjahkNxrAi9R3+11ViqywpH/4q35B6/H5xiHjfTGSYUKawFNV4JXNBzdXQtO6kaKAe
         14A+XdM5FPCB9+PDjy5kgSm9G8NB76AK4DYZkLVWeZsLPlbMEafZ20PwKx+j6+zxkw9v
         d95eM5mZdxsO8Ah4DTNtfwe+sl8QUP/POHZdV0ytBxETW//mM1s7Ij+MWOc1icHU8ADC
         qQ/01GHqJwi9z/K2NSyiW0mjUspAM49o3GKWqH6zoEHxQt8MdqzsCzhLOzfjrKbIOSK3
         NDLg==
X-Gm-Message-State: AOJu0YysQEoENdDX4LOtwy6xARdKz73w4TjnWyNW8dYziRwx2URGN79V
	P6R50C8BC7BGexPcqKSnOzOicWbYoVmu37o+FIXNaoeX4fh1HzTFhZ1zgcltRE8g
X-Gm-Gg: AeBDievawusnfSJ7aQIM16YwBexDmgw0G9IbnUcLtWCvQ3fowDSpQxxWE6ZRuJcZWal
	Gf9aeDDLlQLn6peIYIOf2bYYW/2JycnDMHZesOFKz6u0Uerurh2c94MqrzR/bcMFQlzCtR1lP9N
	H/ATsHQA4g24lLCe6MVHnO9GSgufKf+nJ2zGMg3OglFv74zrOuHz1IzSlrUQKkppd591hlRI0si
	doC571BNpDNzbL+IevyLED31GWB+HeypuQ6eomZihCYksgVoBFqMZ+1I9Go0RZrWhiJeBS4PuXS
	TRKNoVdtnHRnaGZfF5OTjwDyP1u3Cx+LoROZnj1FYWW6YMIIyAFGLNLznxU5TUfxuPaAxr5VU3v
	IVulahfe4Ipoz+vCE+oQ3TTh08eLGLJsWHc0Dwxa44Z08XLzfMbTKeTZoz9WOHfOBDKMHMkU77U
	SSNY/Ax9K1fV0TQ+DuhIqnwkJvFJ5F4Znhd8YP5nMgU0R0IjXLYkaNXkZuRoGg
X-Received: by 2002:a05:6a00:bb01:b0:838:1c71:bc7d with SMTP id d2e1a72fcca58-8381c71be79mr1700295b3a.3.1777889617027;
        Mon, 04 May 2026 03:13:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bd62fsm10813486b3a.24.2026.05.04.03.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:13:36 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Mon,  4 May 2026 18:12:52 +0800
Message-ID: <20260504101258.1608004-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 468FF4BB821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

v1: https://lore.kernel.org/r/20260502215314.917687-1-mmyangfl@gmail.com
  - remove queue related register definiations
  - add missing extack param during tbf setup
v0: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
  - picked from old series
  - add extack to the offload struct
  - add all params to the offload struct

David Yang (3):
  net: sched: tbf: add extack to offload params
  net: sched: tbf: pass all params to offload users
  net: dsa: yt921x: Add port qdisc tbf support

 drivers/net/dsa/yt921x.c | 126 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  18 ++++++
 include/net/pkt_cls.h    |   7 ++-
 net/sched/sch_tbf.c      |  15 ++++-
 4 files changed, 162 insertions(+), 4 deletions(-)

-- 
2.53.0


