Return-Path: <netdev+bounces-146866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83379D65DE
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678E5B211C1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E2E170A37;
	Fri, 22 Nov 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T7fUmqVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC27083F
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315591; cv=none; b=SOUPUr2PNU5Vin+unYVojHWFz2tutKW1MxulqeYOehjH45peX4ecU2e22cMGmsweNGTRYf59tHBzy1RzXgOpELZnvSMG3WPIbxL/a0ROvlt1bDDyNMxsbRaO+VL1NEPUz21m6Lu4Zlg1z4WpZYHaFJlxU3kAi0Hd/UY/KNwciMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315591; c=relaxed/simple;
	bh=yte9FLHXkcXzdKPfgX48qadNs24v4EDSdUTs0LyJkpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxMlpxNy7a/0QwBGo4akDbh3a+93BHngcyhw3BpvYgLcnISNsIH9AAG3oJXhPKokWaPh19n/fPtGUoXnmgidR7VC+sPCvfhLWDSlG0TNRlMtmpH8VmuPwvyh3lUdWfKouATA4md1p4FjrJ/lBcroucHQPcdx31cLVzNj6MnkfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T7fUmqVf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b35b1ca0c2so403097385a.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315589; x=1732920389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z67ZINcKvRNgG+lAqqY2kp44DpUr4Z/2dPQOvU2Fdxk=;
        b=T7fUmqVfygE0RvZHJDQ07MCsEQpTaMY+KnosabytdCN7eVRqSJvIPi/slFqbSHNRUp
         8z4LgMZNRxDNAPf8/OarvJFBSct9AZvuDW9FwnjFjYBnZRMo1lhvVywthnLWbQGgpY5K
         7SCMXmbBZRCzq4l/atdP8mw8WfeOhrY57Oiz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315589; x=1732920389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z67ZINcKvRNgG+lAqqY2kp44DpUr4Z/2dPQOvU2Fdxk=;
        b=n0DbbwwqEPS21TA4CMQNN1W2dY8aV0hwpNbqzG01+VfkI1ANKnqOnDEI65+lvwMKmk
         zTjZIToDTDJnVnf1YsJtzdQqPeQcHIsJquciEn6TMSLiibZ3Tv1n7OuwgxqCZyCU2c96
         80NQPNjhw/SqFM+zaqecDuX/VShT7/i2EWKGHQaRlpeUT60UGe0o9ksD+F66zHln+03A
         DlFMj6rZBSzD4QuoKNyW4w3nmZTtQAKRO69oaaxEiWokneDf/mkwCxF89fqdE2Sed+5w
         2Qja9GVJhxfEkHz723DXxFvUR7Lfy8qfPsASgza4fehhxApYGocCz1sF0oDRD7Lty3bJ
         B4ow==
X-Gm-Message-State: AOJu0YzZkWse+gGjjL78Wi11QVPVp3VOoFoZLUA0wYX3EDBxeLG5n63l
	H/fcunPAwXs5JEbZgiBNb4yEXWClbJDgieRqV38IC0XXBGAq6GGNkX9sY9LQwg==
X-Gm-Gg: ASbGncurCMw4MSg+fSLp/EEfAQGwdbrJ787AwRSwfIXIEPmSZNcV/jV7YmfD+03MWIn
	/FYhF6hUTfHb3JlszFkllXFADkX/deQMMQrUjMrsJWQ57j5eocMbaVYZjUhN42zM0VRu+1IcvRh
	NKUb4lUzpug+4NNPKkWbOfzAb0a+GMBytDhjWUuWefhnh+EVzTRgBhGobSlD7EhcgmhmYd5r9GE
	XA+iV6efGqfXtuVyAWPYDSTirhvrzpciQff2Q+gnf+RNagPmmsmhLDt8Alfzuo7aClOKtf8AHuZ
	r4JOF9setr3PEQU4hHbV6STy+A==
X-Google-Smtp-Source: AGHT+IGKBr23zqn8TlFMs8J0Nxl8mSe7pn/CcLq6OZf5ut5yrVkn+tVnjc/LJwyQsUVODm5Ql0Y4fg==
X-Received: by 2002:a05:620a:404a:b0:7af:ce25:392c with SMTP id af79cd13be357-7b51403d0e8mr975052285a.4.1732315588674;
        Fri, 22 Nov 2024 14:46:28 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:27 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/6] bnxt_en: Bug fixes
Date: Fri, 22 Nov 2024 14:45:40 -0800
Message-ID: <20241122224547.984808-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes several things:

1. AER recovery for RoCE when NIC interface is down.
2. Set ethtool backplane link modes correctly.
3. Update RSS ring ID during RX queue restart.
4. Crash with XDP and MTU change.
5. PCIe completion timeout when reading PHC after shutdown.

Michael Chan (2):
  bnxt_en: Refactor bnxt_ptp_init()
  bnxt_en: Unregister PTP during PCI shutdown and suspend

Saravanan Vajravel (1):
  bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is
    down

Shravya KN (2):
  bnxt_en: Set backplane link modes correctly for ethtool
  bnxt_en: Fix receive ring space parameters when XDP is active

Somnath Kotur (1):
  bnxt_en: Fix queue start to update vnic RSS table

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 37 ++++++++++++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  9 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  3 +-
 4 files changed, 42 insertions(+), 11 deletions(-)

-- 
2.30.1


