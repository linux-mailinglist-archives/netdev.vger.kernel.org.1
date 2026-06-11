Return-Path: <netdev+bounces-297971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A6UUCy5fKmpGoQMAu9opvQ
	(envelope-from <netdev+bounces-297971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBEF66F412
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NdXMx9Zq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297971-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297971-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85650309EBE4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1983B3BE5;
	Thu, 11 Jun 2026 07:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2C31E845
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161763; cv=none; b=agRUTHjok26Et6B2MPOOOq5E5j5il1qET2JMbj4nuO35r7Wrj4fktFRPARA+/b4BtTX1gpfRDfnKiUumB4fYa2IY/UTnccaNqQQQ8W3Py3WW2gYUxf/nePms+aT+zqUzahwkh0M0YvroRtWdQ1N+xnp1oALTq1xbned/2mlrQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161763; c=relaxed/simple;
	bh=paMrpVaqkxNR7VYdDxSVGRSSUoSLVwMg5mLCIJSQAgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZgxGgBgEDqcxQrWium4YtZkD2Hk4yWH2rwJ4Av0vYJiALlW+ccrm2fY2MOwPoBt+ypstntRDL5OYNbTsSDWUvpdmbCoqyHEaqz4rrLam9QadDTOBxfmcHY8WA6+OLr5AMUefktWSrEJzQCOiNL1IVmmwSRS4LjVwgh8AlHGFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdXMx9Zq; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so50578175ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161760; x=1781766560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buXxhkPyI/DNtCn1fhuFu52950bMmTofVQXIfRtoi64=;
        b=NdXMx9ZqjzyZLxdo9P4LYhQ4b3Twll/Sa2bS0zVX9cTXb1j2UhDdKvgJ0pTiBjFGLV
         bcgmdzdzjRMOgjeTUqF54csxScDRJ4MCLoYWvXBVw1AYI7xPtjN6N+oqmtXp1866OMFV
         KUkfmUley6wzSsDBYSHtfwZiTkfIuGUifXiHe+o2p6VULEOdJj+JcYqGW7qQo1urqlYX
         INlhf1LC7h2dMvrZ9xM955J7fvIE4TAZGIv85tpNyCGwrkwVCpZrCGXfRlAgbe/tOQ1O
         H1FPBFoFaezuf78CNBUun7wYgRSBd0OSBIw849S0FU1jCVUexZOnyiWhOo3yt6WDY5Du
         5mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161760; x=1781766560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buXxhkPyI/DNtCn1fhuFu52950bMmTofVQXIfRtoi64=;
        b=owHx8lv3K/AuCXAth5PU0I7z2/hUZi9mR7rj9Q6Sx/MFBkKvwPLGEk2qQiVvEIGXa/
         rQjyWheIjmcdgrXvEN6GEchE94MXLh58rNdoPP8X1s7vU7egTB62GM2/ppLf0QUMC/0V
         WSbjeiMAY4s91C/iybT7SMZ2ZrlnlEXTtIMOvC5OSYavm7eu93eNFxN4hobPFPfUjn2X
         F09QZtpu5qXDv59RsLj9HHfDameKWJ5/+R+YmiJuVZ5AuAi91so+3Elfqa4RNIEb9P6g
         YeadKObARVY3Qjp1W41UBWkhAUUxfmzy1123VKF7X7IIhZeZHrNAmWNNgay4V4TSw3Y9
         NCag==
X-Gm-Message-State: AOJu0YwJPS0w/LgUKxYdJBh0AoktDq/9hylUY+36iSAl+sR5gvV3ZAn9
	oWR+1sSS8mCxXCvOIEsGQtGu8ecXZZucEcmgLnHZqGnm7nc3kaZNOKuuU/TQsBMN
X-Gm-Gg: Acq92OGDA/UKVmE32grqO81yeD9Hy/BzDTaWhmlXyd9TYisGIISZqW84QANbX19X3HE
	RTRsQTZcYW8r37JJaOfvfcjhGED+S9iEsJMQ6EcK26XIvNnhwXVFEr9OvmMYqJwtFBuaKMK6T2s
	7R2py1D+YVD4GW9D6iJBOUmcNMGvUgLM53hWeOFVlY+iENzO7EHAQPai5594Nav3W5HtzWysods
	2nprSsr4vbnQBSfKWPd+sOZwH6eKjW4TkIA+lJc4t3AP6PaVaBBgLrl+6We1n12Hbj2iMY294CG
	Mq5qFYmskJegoZ+y9zWya0hBzplNVHunU/szmvuEKMVeStqsmYNHvhYGCCRKUl3W7T8/kk54GCV
	oOms3QnDcrIzuEQwrrOOgoHfrFFsHbkShRTWmGJ4VHOnW8tWYIC8f3N6JgtiIGZCJvNJUJ/OYAz
	pKmmTyGY3KGTp7hYnYjfxPF5uwtVSYLh/PRXyIeY0smd5PizlXR+MWaSxHE7BX
X-Received: by 2002:a17:903:1aab:b0:2c0:b5c1:8e22 with SMTP id d9443c01a7336-2c2f0447703mr17696665ad.12.1781161760291;
        Thu, 11 Jun 2026 00:09:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:19 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/5] devlink: Warn on resource ID collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:46 +0800
Message-ID: <20260611070856.889700-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297971-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FBEF66F412

Filter out the ambiguous case of

enum {
    MY_RESOURCE_ID_A,  /* == DEVLINK_RESOURCE_ID_PARENT_TOP ! */
    MY_RESOURCE_ID_B,
    ...
};

register(..., MY_RESOURCE_ID_A, DEVLINK_RESOURCE_ID_PARENT_TOP, ...);
register(..., MY_RESOURCE_ID_B, MY_RESOURCE_ID_A, ...);

v1: https://lore.kernel.org/r/20260610062554.769892-1-mmyangfl@gmail.com
  - make a patchset

David Yang (5):
  net: dsa: dsa_loop: avoid devlink resource IDs collision with
    PARENT_TOP
  net: dsa: b53: avoid devlink resource IDs collision with PARENT_TOP
  net: dsa: hellcreek: avoid devlink resource IDs collision with
    PARENT_TOP
  net: dsa: mv88e6xxx: Avoid devlink resource IDs collision with
    PARENT_TOP
  devlink: Warn on resource ID collision with PARENT_TOP

 drivers/net/dsa/b53/b53_common.c       | 1 +
 drivers/net/dsa/dsa_loop.c             | 1 +
 drivers/net/dsa/hirschmann/hellcreek.h | 1 +
 drivers/net/dsa/mv88e6xxx/devlink.c    | 9 +++++----
 net/devlink/resource.c                 | 2 ++
 5 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.53.0


