Return-Path: <netdev+bounces-126688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B59723A0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454F41F241FE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560D9188CAF;
	Mon,  9 Sep 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GnqKLukI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDC18C31
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913673; cv=none; b=ZzOxhbA9LPPONM/Xt7UITcL+86Auj03VUQQNCcz1s0hlvQ8dyRrdPMrw/oCLpLAyoiI1C/qnRWAnc+VXZJxyoyZMoioQbDZ0lQc8mMofCa0ZOR8c1jLr8XPshhAVDrFpYFVWH3O6T7Qhz4Ra56QO0cfZqCPxJSHxSJXeT4ZAC8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913673; c=relaxed/simple;
	bh=S5CGmFXKpLAa5z1RgZKOk0hXD9EVG+qSP9iISqRhGOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAcz+RipWpSZDzvEW56UYXMr6tcdXSb6XvO7UNKMcViO1yji6xuhqB50lr8RbjffzqZjFetnpebSmBOcPsKRwmcOaK6C8ZBnenIJO+AJVvS1xULwe3pvFJihNsEq2CrCYMEa9qV1txEMamBIWAv4tiwwrOS04fWDV50ZEt60J6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GnqKLukI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-205909af9b5so37074295ad.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 13:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725913671; x=1726518471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D63WvmatL9CRXk+7k0HeQjWj60in9rk7cimZSEd+owY=;
        b=GnqKLukIivMG9IlC8tLIK3H8Mb3CydFYJWoYyqOOvxUxF8dNUk+RwjREJeog21qgwv
         ver8ZskkFq9Oe2B1ogvWPtaSDfAsEoPgy8KvwPdsKgBDuX0AjQ0WomZQ9mkbPCbAloF0
         6AKqUXabQ4rP0QtLrvxGFFuVlxKAZcbb+B+0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913671; x=1726518471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D63WvmatL9CRXk+7k0HeQjWj60in9rk7cimZSEd+owY=;
        b=cVsZ/aAntyr2W+swwp7ldlts4lgmnfBqdbFeVGHsUug6bbBefttZAcsyDPEWOjladv
         +NB/5ZnqwwqLSbZEQ3D5CQxrRkKyBvZRN6QMhyp3Pm6Wi1BBn8gx7d2DlppgiCbyVzkg
         5kHEAHGzrCG76NuvJ0HD4OCza7f1QhT5I5QXuH2d7ESsEr3GfZ+S2Qzgq0gwpDUP3hKt
         8Paql89SSTbqFt7kRBxSanENGYQBjXjm1iUY+P35rJfHdxYnAIYcc/qbPye5E11dZpXe
         P63Ywn3fJp9EATREFUlxI/WR3psU/oDg4mNOOQ+IUrLu4TciHt1HzeF0MDjH75uTTd5f
         UIfw==
X-Gm-Message-State: AOJu0Yxi1D8hQxSCbb2MnfVqh3cNcXgc28P8YO90UpLt5doj3fmShFGe
	9AunRutoHfRhgolkhaoryaQIvuetwzrtQs1yWvO4BuOHbmLaKJ0gPWCZtDbPIl0KdLxFAkaaf98
	=
X-Google-Smtp-Source: AGHT+IHGXg9mz0MaAfxk6Wpc4fz8mnrFBOGncmniQ+bUlnSONz75Qb3lVW8NXk7kt54CHKqERfTVVA==
X-Received: by 2002:a17:903:230a:b0:206:c486:4c33 with SMTP id d9443c01a7336-206f0522330mr162859085ad.30.1725913670782;
        Mon, 09 Sep 2024 13:27:50 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8259bccbcsm4427640a12.79.2024.09.09.13.27.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 13:27:50 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	selvin.xavier@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 0/3] bnxt_en: MSIX improvements
Date: Mon,  9 Sep 2024 13:27:34 -0700
Message-ID: <20240909202737.93852-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes some improvements related to MSIX.  The first
patch adjusts the default MSIX vectors assigned for RoCE.  On the
PF, the number of MSIX is increased to 64 from the current 9.  The
second patch allocates additional MSIX vectors ahead of time when
changing ethtool channels if dynamic MSIX is supported.  The 3rd
patch makes sure that the IRQ name is not truncated.

Edwin Peer (1):
  bnxt_en: resize bnxt_irq name field to fit format string

Michael Chan (2):
  bnxt_en: Increase the number of MSIX vectors for RoCE device
  bnxt_en: Add MSIX check in bnxt_check_rings()

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 ++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 14 ++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  6 ++++--
 5 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.30.1


