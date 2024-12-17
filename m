Return-Path: <netdev+bounces-152680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055A9F5620
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B292E16F37C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD01F8932;
	Tue, 17 Dec 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NyN/diK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AC1F8676
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460023; cv=none; b=J2n30QEvyd4dkynIyemMVgu3sZGMNnXhcsU0Do4DkS8ArYV63oOI9hB+lHAMk4/bOi/0IWtEsP8cnb1G5kJhfPCHMg4f9MVdEG9BFyFVOR4lJckgDQtOFgpEgM6iYWhUxNsBQ3+0t2/nsrOwdf2V3dzkYdeSXgHDCVrikuGGxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460023; c=relaxed/simple;
	bh=KauswkWFAECMetfCophdlDWVl1jngSbZ2WeeL8LJPcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kU2dX88BwBo20OOc6xeMlNpSovhBA6PVqgsF3rJQde95C6YmvxtGPqpOB9ZAe5WOtMHZ+BWBRop1sTOefcSnO8Gq0wjjx1/MQMQ6fHuJuSfRU/HrsydordcO++0T2DEK1IVAPBgQETp9WEcVPyRxj2X2DvQj1rXIWWz1PCPXqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NyN/diK7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215770613dbso38492355ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460021; x=1735064821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkCdjjIPQ6WvIvcfV1RpQOyHSjY7MUW7CSoPvahT1RY=;
        b=NyN/diK77Zgq3zcU6u6LY/d+uaPwvkPlqooKWbHj2GFn4nV3CP0Kdd8eYIFSF7+78l
         PeOv+Zki0gNLl04aouBfBRoRhM21ZjR6cW9Z07436ufAY9LPtmFVM1OeSSZSlKJcskHo
         ht+qMO+ZUwMFHkAezi57CTVuxMnu83T1ohZuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460021; x=1735064821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkCdjjIPQ6WvIvcfV1RpQOyHSjY7MUW7CSoPvahT1RY=;
        b=a44fw/zVv5QvfrsaP8pDb2J6VOwajz1kZceHLGUbUF75ZRXJHQB3xLTAwxlM251dV+
         AAGeZex/48FayRbn6qR7s1Ur3Yc+Av67hnyOsBA5FRbfJJViEOPPE4YBthm+o4td4hQ0
         ZEqQughi05ymsz/Gx+44MlhHAcbq7feNgM2ptVobeHAAGek45H+V31Z3t+ejuRlIFj4x
         eI0tO3v3ExykQUIC26d+mFE8aIwNRbTSO7TnexDFkQlC6aEQAySpZzEjWSr0MPScbYKb
         0MwiIU/sQWhxD8ZTOe1tEpALerEOG34LPJuNrbymxPcUV32LWh3onFLl7nknKkdLVEuf
         9sTw==
X-Gm-Message-State: AOJu0YycVB/GPV2J6rHTCBBG6N2/iqpz6H+xbwiF0hwUxGY+Il640vlv
	yyJ2PLY7NXtCJgGjNIh1Iell5wvGQlJ+TvEDJFEnBrrCKUoqfEkvKzpM4ZR1tg==
X-Gm-Gg: ASbGncsH04cyMfJvfK06pUBWQI93kSV/9vGM0tkYsdbdJHiX7O2EDws5rZdYnYT5wQq
	lsZMeIICaQ3q7NAiymEUX6VUSR4b6knYR27ggjFtvmn1OoVN+bLCTIfXqUzDQ5F1j6SPwnUSZsn
	8AkKqf71KV9HHlapr/QPBK85gqNFCTkMgtm5yxlQ5U9kGbecA2gok1vyaEsViImxR5dXHGhWfPa
	7mUFFDZBXWqnCuSeM3irJNS9vwcMvsaeOQfrJ/c7aMAvdSGtKYQhra9mYuJQ0eUGQjiAw8sKUgA
	rfgS5esfr3oz7VdCyGxQ5sz0S/nJMNBk
X-Google-Smtp-Source: AGHT+IHXLeDJWMAaVDKTDMukzm3pZPkiwq8hYDe44eEEnp89FAtNw2bd5Deq25P6lsw8dGPMIHK0lg==
X-Received: by 2002:a17:902:e807:b0:215:9894:5679 with SMTP id d9443c01a7336-218928bf775mr300727545ad.0.1734460021505;
        Tue, 17 Dec 2024 10:27:01 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:01 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 0/6] bnxt_en: Driver update
Date: Tue, 17 Dec 2024 10:26:14 -0800
Message-ID: <20241217182620.2454075-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch configures context memory for RoCE resources based
on FW limits.  The next 4 patches restrict certain ethtool
operations when they are not supported.  The last patch adds Pavan
Chebbi as co-maintainer of the driver.

v2: Use extack in patch 2
    Fix uninitialized variable in patch 2
    Use void function in patch 4

v1: https://lore.kernel.org/netdev/20241215205943.2341612-1-michael.chan@broadcom.com/

Hongguang Gao (1):
  bnxt_en: Use FW defined resource limits for RoCE

Michael Chan (5):
  bnxt_en: Do not allow ethtool -m on an untrusted VF
  bnxt_en: Skip PHY loopback ethtool selftest if unsupported by FW
  bnxt_en: Skip MAC loopback selftest if it is unsupported by FW
  bnxt_en: Skip reading PXP registers during ethtool -d if unsupported
  MAINTAINERS: bnxt_en: Add Pavan Chebbi as co-maintainer

 MAINTAINERS                                   |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 71 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 13 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 44 +++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +
 6 files changed, 109 insertions(+), 24 deletions(-)

-- 
2.30.1


