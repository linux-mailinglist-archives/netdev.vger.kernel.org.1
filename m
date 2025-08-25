Return-Path: <netdev+bounces-216689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D29B34F55
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7C42A101E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393E2C159F;
	Mon, 25 Aug 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnJ7LZMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013D29D282
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162563; cv=none; b=tqKjd9Vov9TdOSSuBMreIHtD6HcY5DSDzx/0pofiA3M2Gl1CLEcXgBEWFXKPkeRVmIn9gH481L1v2fPwrmiGzt/2FBoGqESWqfY81Ltw7hR5ZmO3XasccLD6SpuJARU5GdIXqwIaBC/2EbbhLZJ7N6Zaq/DqriFuYSRBdTs6nU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162563; c=relaxed/simple;
	bh=dTuyAPG1XgkWNQtliUXJGHyUX/S5ow/nY4L+olT6BWU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=XmDpkad3pQGGKqezfpzZmdYoNom8tcz9uHmUaU80BNZ3SMlbIGoEQLM7iTJDURZnb/I8rv5o0VwSiOypn5Mk2RDmlvoY2+UEj7IpHP7ULVB3JM+Gl+KGB+4gSUbywGLuh/dlgrvCq34tqX0W0KwOBb4nVr5s3QTsiWci1TMC8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnJ7LZMq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771f90a45easo61594b3a.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756162561; x=1756767361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=XnY2E+Bayd7HSxIlfBTs+fncNkHneV/ckAaAQIuZRes=;
        b=KnJ7LZMqwcppSMo0nMarqMDjvn6WCGvEf6JUpmHI2HY3qFHdX9jCgaqlIEq+t9Odoz
         1MpetamKTEVqM6rKZQLevQBldGb542yt5J8ZuWZcgHJApSXwIU/zLKW9+vOsFNVWxs2B
         wsNxPiXgwhE2wN62D1MT5TbasKvWuQmHdoN+iwiDhsm2m99+HDmgbVc+Xz94CENLylyw
         aBMCf1icn0eoO6iERVObaIge6h+iWgQkOmnxl1PlT20k/nCgNu6mBZuyoF+5sAq6yJE0
         RmPnadH28tCM1qRsdgWyC3uUbJSagJrKthIoKUYBb192uEuSY9cHhZdW1jiL+t/eZScR
         0n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162561; x=1756767361;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnY2E+Bayd7HSxIlfBTs+fncNkHneV/ckAaAQIuZRes=;
        b=il7fBAkL2sxgSmx28U37POQ0A0zu9Pc7LiyMa/yf29nswalZYJiGt3RSkt+Gsp6hg9
         uu53snjScuQh3iQKZwHawgJvJfOCnL+Rwb7Raprv1ZMUIndUQr7V4WO8FxOWJLyq1ebz
         kqlOqdNe8gaYixSR77AObuVV2Ro7LQYSGiI5WX3sZ9ExL4ajvtQafbOX9iDxawuCCr1A
         d84JFzHUPybbF0QWtypqKjR0y5gTsLWC3L9OCq0TcMwQIRshgNt3YK3RKf/rF0bMHHpA
         9NJ0ZV16+j93yZxp0MCdRRnyYGRyIm55J1gEid1fG5c5zWHSIUvgJyDOSVVb2CfoE17J
         eN0g==
X-Forwarded-Encrypted: i=1; AJvYcCWPm7lq/Fx9FL3Lr5u0Bv+RZT+PI3jrjH6OT2LsrfYeRgAvXr+A0MIUHozjUKnERg7pbTI+rIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaayUbgzHdMuKTc4Qc/ylnztMA2tmF5o0LO2GCWiiIBwVEMoDm
	V6cWpmEsdVuEpK82TMsgLMfgKdKsh2MmoCz1mM8gfe+MEkqtxw9Ay2jn
X-Gm-Gg: ASbGnctgCcZzuijUHStMtviY35pzHxSMW1Gt8Xfq9crRl1wEFSl7GB4iL19QLeRQ+kr
	EGxJ24YDz/xc/0lZ+GG5AhTNMbQILKynPSA68aqo4DYRtl/nPnk7/W3FRF05oiH9g6K+uj+RzHr
	hX40AqW6tleA+DCIB07fK/w9I+HoMaJR3pJqB6WdVpN9VgBF8w4R0G8yVxqqg9MdYYNi1sBCHMk
	Ht1OPbxLcB5irrLlRoYR77hbhz3ibHFiTXCyHkPDzoHLj/1QR0b0+636ocjcxl4LBaqoquXJq8u
	dRohoMkfdLUjqXWHuRulMGUXnG1Up9DKmGAxhgs8lRpUXj57FZwCQgSOULhc/P2f+YMIHbY5kgS
	xs9MWf1nbDSfvXaapwhixCX/toI2k0IAob23wFAjQpt+BVkTnE+s=
X-Google-Smtp-Source: AGHT+IERFPU+gDPWVnMHU5usL/p2f338bDTX6VwVazHCwgfHNcY690o8TpjlGdHfzg6HUab9YgieOw==
X-Received: by 2002:a17:903:1a08:b0:246:a8ad:3f24 with SMTP id d9443c01a7336-246a8ad4130mr92318885ad.7.1756162561522;
        Mon, 25 Aug 2025 15:56:01 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.40.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889e111sm78595075ad.145.2025.08.25.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:56:01 -0700 (PDT)
Subject: [net PATCH 0/2] Locking fixes for fbnic driver
From: Alexander Duyck <alexander.duyck@gmail.com>
To: AlexanderDuyck@gmail.com, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Mon, 25 Aug 2025 15:56:00 -0700
Message-ID: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Address a few locking issues that were reported on the fbnic driver.
Specifically in one case we were seeing locking leaks due to us not
releasing the locks in certain exception paths. In another case we were
using phylink_resume outside of a section in which we held the RTNL mutex
and as a result we were throwing an assert.

---

Alexander Duyck (2):
      fbnic: Fixup rtnl_lock and devl_lock handling related to mailbox code
      fbnic: Move phylink resume out of service_task and into open/close


 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |  4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    | 15 ++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

--


