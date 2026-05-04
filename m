Return-Path: <netdev+bounces-283855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGkAKvum+GkExgIAu9opvQ
	(envelope-from <netdev+bounces-283855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:02:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA24BE66E
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEC4A305ECD1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B13DE420;
	Mon,  4 May 2026 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzB3Vqcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E13DDDD2
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903099; cv=none; b=imj1Wud+Md8RKYl1KWJoumpNYw/5z4ImyjcJPSN4t9Xeszn0hcDjWVI5k7cjrHJc2K46+qNOhTApa5g29m7IM8R4O+O8JTAFsIIko74F38tpxAiVMWsR+JlCEKflGRmPBCcJKA5W2PwjulTxRhLoxt7b/8Dw/Fg1Hsw8xLOi/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903099; c=relaxed/simple;
	bh=LBHa51NlHinq5nOhz+ldDHBrOzB9YGO5VwGP55kqKnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nG147qSOivAKKONyNRR9Im0pXyUC7QM2ld1Dmy8dcYVOQT0FTSpExpIWAqWVfCiSJE3/2x56xieQYOVS4TYDDMX5mfQIMtuyyNzisgxZNiZty69Zcc4sjW6P+DupOTN/JDVwYFVVW63SOwui+31OmvYExxRIUWWtCdaRctbstZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzB3Vqcs; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ef45a6d9dfso457398485a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903097; x=1778507897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EN9sgE4I/A0HiPGUSSknnBC439VXbOUaicOa4jJsap4=;
        b=VzB3VqcssFZ4ihIHKQXNiRLgO0clPguKFzXGOgaVHbKecz4XnOgbXl5Un/wNQlQa8K
         CwgPQCkGFe+n2ky6pxlOaXYOHgo8cOrlScKmZjDfyVlIUu3NM8Z/TTyCtrtWy5+dFVS2
         KG2FRTxzBYMl6/7/mlqYwg2qLRjzivtkr2wOIj7NPT6GBSN35yhvu+6+OUVTY02HZZaw
         Qqi8Lcq+PajhvSra9ARrxYfvWsKGQdddPX17S//u3pb2yqEm/Onok20JEhRVgESDnFU5
         4iq8oNg+7STHnqqQQK4QUVkZ7GzNcGjDsC4nIeNTMOcI7g8HyKv7R/BsYcFcy+qfimly
         OX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903097; x=1778507897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN9sgE4I/A0HiPGUSSknnBC439VXbOUaicOa4jJsap4=;
        b=TTh8KZzNfB5w+GOwhltTHqbIztlB4frJHRw1DTz3yAtieiJ1u69FmJ/+HffZCyr6y5
         uGRPaDz5HOBXnWkvQaiUVKehSPRzzhjFJOYezT8DMGjmj1127Fqu+OIghWH0X6d/n7YY
         MN5obzu/EbhQKI+sI8kVZBD4vUlsftvom/dw4hQt+9I+jbSU9vHcZDDJwzf5TM9sxFyT
         R/hp018owm4/aUWongs7yQg2FLTZ7I8hD01hb58vh7AKkTBpBnnxdihDYsVMDdo07svy
         UUf4ZK9XmTE+6KIxlPkBadqN+Q+S+jyxCjQHZtyD/MNdBPJnpid/zPj63tExS0hp2r0o
         KuuA==
X-Forwarded-Encrypted: i=1; AFNElJ+QwE5uhuV7LRN1IFfHXn9o3FyK7peipVTgTfhnv0r5fMyMV8gq/a83KDpmNkNCIGwgvCxHI28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEboIrriY9/F218dfNtub+aNgZbCsgAtvLz73jKZBcapoSm0V
	XWU0kqhibp/fFAhhRtY4ODnqxUkwmjSv6NLwJuXVnbm0sO6RcCa3Hl9C
X-Gm-Gg: AeBDiesnC6omRAiideqdUp2GgY63rqqttBLNYJ6VhwsibSTiF1qTdRc3C0d/sSS9xNf
	BbMzc6d+4t7eow3B6haNcEZq7kHhr6EbsjlpsB6N2Dpd1ZbfZp5WwNq+G2Von6rTyc8XDmthaHv
	7XrgHL9vow7T7wP9v3OcsllMlXndfobc/NfdwtQQWdo4X9EhkOrt+BGuAR9pS6DuxSjRVMgn+MG
	yf7TPCk0mWDrLV3Z1QayyIGuP7j1s2Yh1OJvmemou1J0pLTboqPRg9n/Urm9eQQw67XY8akdW46
	Wn9WChi0UHTLjgWMoHEx4vRG/fV1VN4YarAwRpRGSsnxJue3vfYPO1AyY3/DBk9D9cvA+g4LStH
	Qc/CKrsThSjCFeKcDwTI8knIpahDyLfK5HLAd93nUasJ5KytvOZeb/P6HB+2iN0ZLiXOwuAgUe7
	UTpO3beRlE/gjr6yk1wk141S6qKPbsbcuaGqJJqdWY+w3wfkK8CZb6lH29NkFSQoK+FbE=
X-Received: by 2002:a05:620a:4015:b0:8cf:d6f8:599f with SMTP id af79cd13be357-8fd1863dbfcmr1490402785a.57.1777903096993;
        Mon, 04 May 2026 06:58:16 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm1062878585a.35.2026.05.04.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:16 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] irst series for xpcs based rsfec configuration
Date: Mon,  4 May 2026 09:58:11 -0400
Message-ID: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1CA24BE66E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283855-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The series:
- Fixes an addr validation error
- Adds MDIO defines associated with RS-FEC
- consolidates the handling of the boilerplat ID registers
  into a routine to report id'ish registers and reduces the lines
  of code across the entire set of c45 routines.
- adds PMA read/write routines

https://lore.kernel.org/all/20260428172810.175077-2-mike.marciniszyn@gmail.com/
has been put back into the based on
https://lore.kernel.org/all/9ec11642-8035-419c-a896-52f902020bb8@lunn.ch/

pcs reads for DEVS1 and DEVS2 cleaned up 2/3

Mike Marciniszyn (Meta) (3):
  net: eth: fbnic: Fix addr validation in pcs write
  net: mdio: Add support for RSFEC Control register for PMA
  net: eth: fbnic: Consolidate register reads for ids and devs
  net: eth: fbnic: Add pma read and write access

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 137 +++++++++++++++----
 include/uapi/linux/mdio.h                    |  10 ++
 3 files changed, 123 insertions(+), 25 deletions(-)

--
2.43.0


