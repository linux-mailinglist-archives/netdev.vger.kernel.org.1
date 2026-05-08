Return-Path: <netdev+bounces-285679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA0JA9qJ/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003B4F2B19
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EA0930471EA
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1637B417;
	Fri,  8 May 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCZpxMVU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9E366814
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223490; cv=none; b=vAvOcYRNjzZ2ZNA4jRqiWV0pV/KCNEa5vPj5mJ1SQOLV6u6bZ2GD04qM+xAeVzPkAoLLtRrDU6T3RGA4sPEQ9L6dgo58kaZ6wUionM8cwNABO6Uc/QQy9wsTllAo9OxjTEvVrt0w2i8MNXmQZK7tT5ROgKFd1lFaR+fp13am1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223490; c=relaxed/simple;
	bh=+8sQ2772jG9uh41pZUIDgqtmEXsFdy2R5gTr81xqa6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxNOwdTgX2xQi0B2zlreVt+jhscNOH7GE7fRcxQM5wKMtBigWTE9171AcVzxDqSc8ucNIxtGKunp7VDSfhWW4rBJMbfXL0LDPElLSvjEpbVmaQQHkiy2VtaD1A2I0j3d5bP8bvPRfupmprT9EDIrrPOovhkwO98Umr+tS3EaWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCZpxMVU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9a9be502so9772465ad.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778223484; x=1778828284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv/X3BhxVASEO6JMep9L4gX7yC8TIZKizbewYQdLeJc=;
        b=rCZpxMVUTEHnF7qqLipk/EdPo1nh0taPT2cZ0u2Ephd6ADoEqjd0uGodViUs4OAU0L
         7hjLDFHGtMRh0R5zKLJ3TukZq4ezlgrBqt2J+TJiAmwL+Ks0D2hVBbT0YTIriVCsO8tw
         yuv202SrJkXM5qEaZDx9flsEjtF6Yy7VLoUzhN9YDHPuQ4JRvgVDPzopl710I22MilKm
         syFD6Vaexd0HtWRVwDBPqxqKkBHSHSWnlBnszXLh7Z37pAOpBS8/71+d/OfQs8wg3Nw4
         ylGCoQofogmtQdythNLSOI3BH9TIjXSVnJahAJ3y8MzOdtrqViUEH3rVAAre4IiWObFx
         bnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223484; x=1778828284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv/X3BhxVASEO6JMep9L4gX7yC8TIZKizbewYQdLeJc=;
        b=Co8iUXnMgVjj8d/cckD+KQdzdKOHxQ6yOsP+jq0SOHLjwfT9ecGMiWV3ly+WuHj8ZC
         dlTuZavgWfeLrNJXGZMGXAf29VGg/pxkBnQQRKFRncf7NlxITOm98YczZ4yZ1+pDHWrX
         2eqB3mlUmTq+nHrz71nIYCQ+b65EbYukJJAhdJ53IzxwHiZi9wGRsF91NvqOWmQGaoPi
         dCE0sPBpaStmG36HRERBaMcWcMftf4BY8LF7CKbWFHFaKJEDq50N+/8emKX3ZjRyJGNE
         0R5dQB85mBir86dDwShHuD8WygI+lwejCKlFi02A1+0nvoIm++xKrwyhxsehILx27ruF
         CKhg==
X-Gm-Message-State: AOJu0YwQxWJX9qK3QXfV8F16e76nihihuXmgX4uk33js+18hSYEvqtCy
	rylf+4AKXJpCLG7siQh73XMw5Ywaz3uHr1tikxem4cVm7VArZZMHACHB60aY3pvb
X-Gm-Gg: Acq92OFSxCL6eHOX1M8IAEJwfeqW3WiK+hQHpTRx55gKF2IYoGoIgZDosJSfJ1rNlT/
	V0kmVk1QjfGeqWmwyoiwLeO3uG0K/VjETcIjO8/mpqfruswCVFyUGZ17hb+d1At2CXhvtjBEMfy
	GZskYKghWSoFED0d+lfL78z8PcjLLfzcBg4ssibe7MY70ZumIT+bGH/Vl+Ih7IP7meNY9Yxu3mJ
	OSxnw2zAYl0KeTunOKMNNcCngoE2pmFkLkgJG2vB5SVB0vTXcslLVf4IKdsxaRYIVwxRrrsA6I6
	q33/MMJ/G/TDMC1v767XsZOBVvMlpWrdJIlyMDIaSY7idS12yPURyZWqjADEq9XLU9CDTdbHf2e
	9EQjfyhgeeLp2ALznRfbiZon9yeqwkjDN6kVIm/Bi+hAnODraAoYo5iBD9rU4KiqGDHuHz/5uea
	g1mxUdKeOqHkZ+DnoFUERu6BiH+oP/BmJ4He7QM6w+ysGGL5f+m3qNHeaJL7y+
X-Received: by 2002:a17:903:2904:b0:2ba:85:5827 with SMTP id d9443c01a7336-2ba798d3e99mr82780775ad.26.1778223484400;
        Thu, 07 May 2026 23:58:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35bcfsm9488785ad.38.2026.05.07.23.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:58:03 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] net: dsa: yt921x: Add port TBF support
Date: Fri,  8 May 2026 14:57:51 +0800
Message-ID: <20260508065757.2566258-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9003B4F2B19
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
	TAGGED_FROM(0.00)[bounces-285679-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

v2: https://lore.kernel.org/r/20260504101258.1608004-1-mmyangfl@gmail.com
  - drop changes on tc_tbf_qopt_offload_replace_params
  - drop excessive checks for tbf setup
  - react to TC_TBF_STATS correctly
v1: https://lore.kernel.org/r/20260502215314.917687-1-mmyangfl@gmail.com
  - remove queue related register definiations
  - add missing extack param during tbf setup
v0: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
  - picked from old series
  - add extack to the offload struct
  - add all params to the offload struct

David Yang (2):
  net/sched: tbf: add extack to offload params
  net: dsa: yt921x: Add port TBF support

 drivers/net/dsa/yt921x.c | 84 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h | 18 +++++++++
 include/net/pkt_cls.h    |  1 +
 net/sched/sch_tbf.c      |  9 ++++-
 4 files changed, 110 insertions(+), 2 deletions(-)

-- 
2.53.0


