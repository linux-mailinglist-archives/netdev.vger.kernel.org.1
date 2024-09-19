Return-Path: <netdev+bounces-128988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B097CC10
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610721C2154D
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B01EA85;
	Thu, 19 Sep 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="26pvBbD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6519CC13
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762251; cv=none; b=FI82WKxEfi362eq9ytGN1/QnhXcaXanhgWC0qlW34ufQraYxNyEa0YNhqvd+FjB/C7GyT43sWwSQPCwsTckW2TE1N4Ozi1vW8pRE2F15ZFp+U5CODMUKffql3vynSGVhNKeg24/fV5Db0U/iMtsr4NH1gBDV7c1Jcpqnx9BfNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762251; c=relaxed/simple;
	bh=Xfkj6lfBhiTLHS2sVkNs2RP8tZuX6iIjwjxRiKtUx3A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=qVE6onjKK+9w8Q2BDFMfqfm2Wx9A8hsM1urKM/2ybFj7NyxsZ6YNwqHZaVkKTHVGat9BGOvLmEe6mlkU/77mteGmx0zfYuNccpMzF2M+r9MLz4BMgpgarWGUexUPKJ34ZmrGxZGoYLedBMgCF1P4YXFP8Lx7aMM/zW78hgVASuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=26pvBbD4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so786757a91.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726762248; x=1727367048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQbZPqzPtMKI722MB+ApBN1z0j12hjBaSfYZZDBWTCg=;
        b=26pvBbD4CAOJu7ohFDxmoZ9HYUtmmkyxDkv7RPKVRhzrWpKTDMxtbWpgs2V/x1wXa3
         nEZu515twWy6XNirn+IxCFI5+V4qcwOI1MvN9NT4Cn6c4ZN1xBs/VhVv/VgSZ2be4RYn
         FLVjlqJZEZHNHCsf2hVO9F1mZ0QRPNRyix6QuZGILAMCYNDrayIl0TGkMCKgCmazCZBj
         K5XiaUZefvBEeUVFyoP4Fx91Id0MBEu5fGPjlqaM44ammzR6SJUHGw/3+m17dDoIPwvp
         kgn0VsJcNI6AfsCG3z7r4iF4MRFDpQ9JnUx/4TSK00tUASXTpH7jENHQZr/TZ6N1aaZk
         VRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726762248; x=1727367048;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQbZPqzPtMKI722MB+ApBN1z0j12hjBaSfYZZDBWTCg=;
        b=hVOL3clDYA2A43LOC9QEHjmLt1UXmNLC2ygbdqwPsiSxuY10Gapb0CBL9TEfPYofjV
         O9br2J21wZkUkBAku56onDsHc3na2/WU7FlTx2EvkoIz7BwWpEhzm2G7vX9di77q+TYm
         bXKtF5faUOyhS7oR7ubI7CHmiRz/DMdOa1vqNiBzSHDWm36dG8dS+FdQKL+9AALS0cfv
         33lBCN5cl/xLX6JfkAppd1q6ra/RfU+fYK01JdlM24f3ZGXv8LioM4CiZMil/khbNvL6
         ybuanc7prt/53pNY79SXiPHfJeBWPcLmOBDOKs1PaQZfdreSlO7I5PXkhwl7TSlxycMK
         SbHw==
X-Gm-Message-State: AOJu0YwZ8gfU3skOldkjyCAOS2DSxQMouXOvHu0FKwaWmIhevPn3Mlb5
	WvPM33uNgPWis7K5wGzLv/qGYZTZ/2EmT3ITSjXIacug2azd9W3uRm9eUwE7gNwVNJYXqgRpGoo
	C
X-Google-Smtp-Source: AGHT+IG+hvHAruIhWiGuSiyNtj/3NRAiKH6lsb0e4Opn0lGxFOHDF4qVbXLd78drtgSyAHpt2w6bqw==
X-Received: by 2002:a17:90a:d507:b0:2d3:b8d6:d041 with SMTP id 98e67ed59e1d1-2dba0064f94mr27753465a91.32.1726762248310;
        Thu, 19 Sep 2024 09:10:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6eec7b36sm2082602a91.30.2024.09.19.09.10.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 09:10:48 -0700 (PDT)
Date: Thu, 19 Sep 2024 09:10:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Dealing with bugzilla
Message-ID: <20240919091046.64cb49b6@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Up until now, I have been the volunteer screener of networking related bugzilla bugs.
I would like to get out of doing that.

The alternatives are:
   1. Change the bugzilla forwarding to netdev@vger.kernel.org (ie no screening)
   2. Get a new volunteer to screen
   3. Make a new mailing list target on vger (ie netdev-bugs@vger.kernel.org)
   4. Find someone to make a bot to use get_maintainer somehow to forward
   5. Blackhole the bugzilla reports.
   6. Bounce all the bugzilla reports somehow.

Any suggestions welcome.

