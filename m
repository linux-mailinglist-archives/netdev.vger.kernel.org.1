Return-Path: <netdev+bounces-214426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4798B295E8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992D517CB72
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFF54758;
	Mon, 18 Aug 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ffQPZmnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C19463
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755478234; cv=none; b=m8ktUF4LkQlZX4yz+0ZrTcTPo4KKX/C505F1dPe2UXHX/cjtCZxe3UxJdCLR5pGWtCAygxM3KACde4SEok3aOSc+aqk3t2rhk+wWdIXIXJrUmk1+/aDM9tx/4WPlbHQDwZ0sCq/ZSIvKcc/AzyF1yNegRl9B+3FJ8upQGWHYXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755478234; c=relaxed/simple;
	bh=z1bTIcwoj3neRPp9cBzAqlfm/t1Sw6DLjIeEfGGmkgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDBy76IA4mUhqf8dThhwrYCpjxcXx68n5OxecUenQs0rLN7NY/Yl1eNaJEmtd7Mbc9qdnx/v1P+HKmndOiCrH4JzxzG1TbjlUBkM1cIOnKarfxYJhel/jVzJAOXf5ODPxER3Fw2AlsTJQk244krAuFYa5pLJAZD4udWVgum31xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ffQPZmnr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70ba7aa1300so17914626d6.1
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 17:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755478231; x=1756083031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YtROmDEGv0AsAfj+6FMvWW83OHuZzFKRDlVkzI6dEuM=;
        b=ffQPZmnr9YbTel2efUG0a01xSYmcNf8PtnW+AwMqNANNoXaX8NLti8jktTE0bz6a04
         deyahDYE4R2PvR6Tw2Ocigbocqz+n05qQW+r8MyXaobi9pgqHdLpXorT/zghlY6hrV9I
         AMJ2rWwX44bc3SfipZpLLuQ/9tXp98oqouECk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755478231; x=1756083031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtROmDEGv0AsAfj+6FMvWW83OHuZzFKRDlVkzI6dEuM=;
        b=RfuenFgvFgl2CBKEauoXtzMIrPbDHh+bW3qUVT2mRyFw1PIA/Igu3Mq0fDtzn9Jg6n
         mtOx2e2B1iTkeHx/2nvTRYSfqGYvTjeCzegIVErg/uvXDEBVgPCHivfxX6kFh2rl9s68
         yFrT+P+JR2ec9+KQONUWcqV8V0OV09muylVb78JTlkPZAZw7FWTQJrQo9+ti64qLhzF5
         d/o5C9R9dePM0VRK5f+sYAdzua6L0gZVN6Q2rHX3RaIyAp9wyZ3F9j+hopkSnZqkOGw+
         RzB22BhhKzQSEjvrsMhdrpeH1PzNJEkhP1fKppHqkbndZipBmHK2Y9T0h1didg5VAYKT
         UKlQ==
X-Gm-Message-State: AOJu0Yy4Idg2ozU88N05HXrrN92MSx/FBlyZcOWqZ1lCFZf/ZS9bXdD1
	09akE4zTzlAKlI32s+fyUiWxMay68Hm4o4r9XHkcc5jIKuqxHdhVumMKD7kRc+ieNQ==
X-Gm-Gg: ASbGncuLshgAsKYKmpEN23CtLMZBlk/4gaRv9UsDgxyc51Gd48gKwLr10wO9r6aNqUS
	JM8h009KN3RFZH8ic6TBt+OnzcfKQi5ZsOPFU46mDqdjNhpoRRyOQ8sA9IsefNsOySieCCfWdJb
	JAQKSpjAtEh3QbCo3Gs3vkT20tm2GeZb2NWUeAGYBci8V/8PjvvCVasWBrNrvBE02cDk8pe4iZg
	znBcvlu0ROvdMT6QiJ0Dd3XBePikEf33qU45us2xSCKBHvoaEz9VhidI0uLugfCb2K5gw1aViGO
	G4hq6skqzyQtduuiqf+WhcSJGJoFOUeucIzJJ9C6HkukDYEMT3e40ZxCi6wRBmCMMXQaeZEMdAX
	w/UQiNH8bb+PIVTGWhxb5mg5nZw3KF/hGQOTI+AE3C93mWvIfhsFvYUJztk/PxtgkcWEv4e3/7R
	krMGnpqBMg
X-Google-Smtp-Source: AGHT+IGB6NmbA/F3V2u7KK+W+ucCzZ3bG2TGaA3elopBJaxZsEGo7e3h0SN3J/GTyhW9y3RgkzXhOg==
X-Received: by 2002:a05:6214:21c7:b0:709:8a1a:c875 with SMTP id 6a1803df08f44-70ba7a992b0mr147646226d6.14.1755478231505;
        Sun, 17 Aug 2025 17:50:31 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm44987526d6.49.2025.08.17.17.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:50:31 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/5] bnxt_en: Updates for net-next
Date: Sun, 17 Aug 2025 17:49:35 -0700
Message-ID: <20250818004940.5663-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is the FW interface update, followed by 3 patches to
support the expanded pcie v2 structure for ethtool -d.  The last patch
adds a Hyper-V PCI ID for the 5760X chips (Thor2).

Michael Chan (1):
  bnxt_en: hsi: Update FW interface to 1.10.3.133

Pavan Chebbi (1):
  bnxt_en: Add Hyper-V VF ID

Shruti Parab (3):
  bnxt_en: Refactor bnxt_get_regs()
  bnxt_en: Add pcie_stat_len to struct bp
  bnxt_en: Add pcie_ctx_v2 support for ethtool -d

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  84 +++--
 include/linux/bnxt/hsi.h                      | 315 ++++++++++++++----
 4 files changed, 317 insertions(+), 89 deletions(-)

-- 
2.30.1


