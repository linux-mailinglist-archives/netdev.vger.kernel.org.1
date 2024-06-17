Return-Path: <netdev+bounces-104200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A590B827
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C7E282BDB
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8105185E46;
	Mon, 17 Jun 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R7BFxOxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE36185E47
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645659; cv=none; b=qvSkXyn/re3fGJPjCEoqNVemsEHhvZgfJlFb3fhdXzn6eem/DH1hByCnI11FkBYfl8cq0oPsLcJn8Iam7WlJNsad7ag003s8IfOjxgoh1PWhizbsgC0GJdHLjoDw189uf7zc4UYIYMRNbW3k65zPBH4WTHk00kpOBOjsUzawT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645659; c=relaxed/simple;
	bh=n5zsoap90dLAiW9uxMwsgb0AfnGmEvJPxvVpYWgPQXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teqkWgA7qEX7uqUGqKkN6t9dGlOc4GJfxBPp7vEUsL93o4q8QTarwT/dubFaeip9HDCON7PFALNTCUlQYUq8XO0Geuvmk/guLo/L8UV/bwqOrArTOKL6QJMl7CM82ifRCxvcPkwbftGPslo0iX3Q4eF6o6f124eOxFg0UMp1jB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R7BFxOxj; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718645658; x=1750181658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3mD8RTLjthZT4rFotlnHRFKaJVopsiQ5cQ/tCyr5PGE=;
  b=R7BFxOxjjPl+I/AAYtk7LL7ndOIwf/tL6YNF63rusTI4tComLbQ95it9
   nQVgRARbvHcSs0B2Fili7FiR6yqj6aicQDMJbGvO3v0EYHuFp367VEReI
   gYIGPi+KisEJTdPf3j4USjCsFiDlF3D0Qi/kC4QhIRatkhziJBoHXoegK
   w=;
X-IronPort-AV: E=Sophos;i="6.08,245,1712620800"; 
   d="scan'208";a="639863571"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 17:34:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:21648]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.125:2525] with esmtp (Farcaster)
 id 8c0869a7-a74d-4590-9da6-51ff8ca04a26; Mon, 17 Jun 2024 17:34:15 +0000 (UTC)
X-Farcaster-Flow-ID: 8c0869a7-a74d-4590-9da6-51ff8ca04a26
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 17:34:15 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 17 Jun 2024 17:34:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [TEST] AF_UNIX selftests integration
Date: Mon, 17 Jun 2024 10:34:05 -0700
Message-ID: <20240617173405.57122-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617073033.0cbb829d@kernel.org>
References: <20240617073033.0cbb829d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 17 Jun 2024 07:30:33 -0700
> Hi Kuniyuki!

Hi Jakub!

> 
> We added running af_unix selftests to the net runner (using
> the same kernel). diag_uid seems to be missing Kconfig options.
> test_unix_oob appears to time out. Could you take a look?
> For the Kconfig you can either create a local Kconfig or add to 
> the existing net one.

Thanks for running af_unix tests.

OOB test has been broken since a recent fix and rewriting it is on my
todo so that it will completely follow TCP's behaviour.

I'll post patches this week.

Thanks!

