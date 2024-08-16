Return-Path: <netdev+bounces-119177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58598954845
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCECCB20EE5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F119DF4F;
	Fri, 16 Aug 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QuFR1VL0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684D13C695
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809080; cv=none; b=m3UEGp47rboj1T/X+jqJlC7kHkZ7U25LELV76GyIWsaB6Nn4Khkr6a88mP7JkWavoW7KJ/pYtuXk65bCwuS2bP+ejhcwLomOMxNp7yahgy7te+lhTQbcHgwg/2s0IOzsZRGXwu30H50BSycX7LIkeutpt6KM0d0kSqzu1swkEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809080; c=relaxed/simple;
	bh=UGZL/mAkZErDFt2CP/y/FIvs4tlYqejHbAabBlsj+NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvn9sYO6f35rXCbclrkUZoP9rsfEGnbMtJiHs7kdIpvuoksOrXrWT/mJGoRsSXnBqwdyAKjjedZOkR1XvKEnomZaLtB5vk4CUny3GFRTHa1kHFk69wzYilErWu320UqVJbceFYrL8Apwboq1EIOKLqMbhcXATrH+/rvlEhBs4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QuFR1VL0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f16767830dso20379481fa.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723809075; x=1724413875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ld/u168ByXssnaaADdxVHAJdHsRQneSaRZiRwjZKgQQ=;
        b=QuFR1VL09xuCG4OslP7kx5fFxsVbwvpCo3hlXcpx8VeEt8SObM1CcGk74QrGBVWK5g
         eYH396VyZTViQfV+AzWeZX73GrayiQhXZGA3SDucjWCTQ1oCFmEkM6FIzy7eyy+weIvR
         sCrlXTiIKfxe9Z3X0qbc4A0rQEzoVx5xnr6/A8vTMAgBpt2sGTKNTWFmpwPzdF9ExnG8
         Y1EaPWUmBd8LUnCC8N93FfkZMSrg69R/+tYB6LH355gkRslgt9kbAFdI2AaDcl8EAY2v
         o8BSzNjVRxTRZh8mHokBoUN7w86SVOqvk6FTu7bw3e2wzH2nlwBI0OZGj/3bwIGXYGzh
         Z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809075; x=1724413875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld/u168ByXssnaaADdxVHAJdHsRQneSaRZiRwjZKgQQ=;
        b=maQqXTDIXOSSezDlMBTWgWHtSsNGcIR7C4OtJQAOvvFr82kDrMIyULDy4m+sUb6Zn5
         8wBDd4LiEDGnTNWoK1eljS75dhJwWWVT+Py9wHwM1OdX6If94+tyM9Z0wlutnUImQsMK
         +tijEho58D0ECe+OrVEHpe02iGaNLHEwKTHc/XKD0b9Ql2lFtXTpnyGSMgCi7hQGfJaG
         ZBUXTX6KJMjel6SaLj5t1lbbCfMYvy3lMbaWjuogEGUhUBErdS2cE3/kVe5KexS/oNLB
         ht+AKx4rDEhqExbkl+KsLmqXLMb0kgu6lCSghoMzI6smKSCMlGaZbDm6o5NX3QaJVztQ
         e7zA==
X-Gm-Message-State: AOJu0Yw7lG5XQHv8TlBMaNPjWk+BVg33IDZ2/1Eqw0I1FA+npzs869GI
	a93Vnpcc+KlxRwYa6ayi0q2e6sYHN5ztvyT+a1WA0w/vZ++ESM7Mg3+RoOLYVqBFpgGbGceyZKa
	R
X-Google-Smtp-Source: AGHT+IEUvPG0QNw61jYp8skGfLNABj72aBzRZIOMe11a/tP5xvcrbGt/ZaPA3PV5HmuKLqS+oS778w==
X-Received: by 2002:a05:651c:546:b0:2ef:2c86:4d45 with SMTP id 38308e7fff4ca-2f3be5a6d5fmr19587121fa.27.1723809074989;
        Fri, 16 Aug 2024 04:51:14 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm2152845a12.39.2024.08.16.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:51:14 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jarod@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 0/4] bonding: fix xfrm offload bugs
Date: Fri, 16 Aug 2024 14:48:09 +0300
Message-ID: <20240816114813.326645-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
I noticed these problems while reviewing a bond xfrm patch recently.
The fixes are straight-forward, please review carefully the last one
because it has side-effects. This set has passed bond's selftests
and my custom bond stress tests which crash without these fixes.

Note the first patch is not critical, but it simplifies the next fix.

Thanks,
 Nik


Nikolay Aleksandrov (4):
  bonding: fix bond_ipsec_offload_ok return type
  bonding: fix null pointer deref in bond_ipsec_offload_ok
  bonding: fix xfrm real_dev null pointer dereference
  bonding: fix xfrm state handling when clearing active slave

 drivers/net/bonding/bond_main.c    | 21 ++++++++-------------
 drivers/net/bonding/bond_options.c |  2 +-
 2 files changed, 9 insertions(+), 14 deletions(-)

-- 
2.44.0


