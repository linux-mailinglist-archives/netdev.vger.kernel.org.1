Return-Path: <netdev+bounces-183980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E102FA92E78
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3987B4312
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36A2222DB;
	Thu, 17 Apr 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz5IW1s7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD221506E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934183; cv=none; b=cuvXCgVgTrY0LxUzD5vS2poi/AZWRyVJJFd0Obbrda8nZM733CYN6QztPjvixVuRzK/TLX9kYMNBhyR7ZaBLKhEYrFD4t2Ad3OFvddwNGywgG//LHKqQTryqJzRj6YPANiHnZp+N2KW970/YPQgFHd5ZNi8KFkBKJgNRoMo5W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934183; c=relaxed/simple;
	bh=hXcNvjqqmdQD7NeJInkN2oNSoF4MZOxs/rWBneI8beE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=CfcFD3Ket1K5mF/PHVmWwmjhjQABVtSNR+RPD7OZQv3n8ybv5PtWOBzkqwKJ04ds/N6B+glHqCM111FbGb0LyaFjjXLGU2x2ygv1Q+7lwT+HhdR3qY4MjUtwzbBIOvmWGoZ5lvrnwL2S05OqeFnwkeUiuC8ixFkIzlIYtFpvtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz5IW1s7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7396f13b750so1506062b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744934181; x=1745538981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=fMU2BD0LG1rNlUJ00GvwH9QUeSDku5Oj3mL4kLx1me4=;
        b=iz5IW1s78O5gcs4t2acCBg+YopM58I39glm/noha19z8e3Dl3TkFzEkewTI6yVixpk
         M3w+1CkVOYeGYWB+Gr8lYmNID0wb/U4PFN7nEiznatz2CE5T5Rc50refiofl0M/iln8v
         skWj3P8TlSTK4AtOlxDxFjE7dQf5gI1WvqCy8McEXhA8c1O49csPRz3+4uyA2RHuNOoq
         HXkBcKuU3qZe2JcB1C3YtGL/At1QPLk6VRDePuDBWkiiQh7j7pJNi1t2XDWfGYsXvheA
         HYORj8AVVmJ35Mc+8Z4HBcKpEFZ1Y9Dyp3uP0OfhXwyLzVq0MLR83J99d+AJ+DG/Qio9
         DXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934181; x=1745538981;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMU2BD0LG1rNlUJ00GvwH9QUeSDku5Oj3mL4kLx1me4=;
        b=wkTGoutM5ucsX98OhkPuPuzPlqOJePGtAOP9FD9yL6crGLYD6iHiLebZjuc3cGl0mJ
         BkDdOdWqkUnyIOCop5+iDRuofsB2l7YVJX1PXCHKhRS/buaOeWkvO/E/a3aAlfyalrM1
         vX1dkRbbyzgakFcMrgm42IRoeS0OSJ722Ndef9Y6FwbZivrhA0mlMDpCpzioXqLCjWRv
         P+EPe6dlcQQfOUq1xlO0SiSrIhtEctC213Z7FlkB5IP2WEoDpN2YS477sCLRgLvpZ0jJ
         edlh7z28AKyEi8ns6gcugfSsaPkLhlyUYOkOz76fsxr9lwCEE2YxA+twK5C93yquPzRh
         8n4Q==
X-Gm-Message-State: AOJu0Yy6Ce3G2VxaslCFAG2Jk1VkHLircrYWiLA0Ek4WShLDTZJQLnyw
	0Zu2pGZ3CDuYcuvXV02+FavSA93SMD0SrlqAgiGl6qrrKF7Iswo8
X-Gm-Gg: ASbGncvMwTRaTsyNe0Hm1KpbqyoWwhUP2xywt6+hT0zUQK1VBHpCuMvgjVZFGFQbdw9
	fn3RwYzHowwWUwntW3mIfh0azsHQC/6h7y3otzToGfO7uxNUCaIxa6CAjBCse9q+uUhGT/TMMtY
	9HOFcmiPUMA66ZAFGrKkE5K3GETkunfTvFFOw/kjykFtYEVKeUgzaj/mHHCVuMGao5XhTqKacyo
	Wvv2Ia4ltuJJEtn7Vxlg8cTOj9bDE/+jtKRLav8hCZe8I8SI2yYy1yQi6+6D5sNGB3JU7GwnQi8
	ilBxVRhs2QC22JqOGReKWo9G/ySx4Ww9ZvwP0xyAXifJoDfWTuXWVBJ0oGdZWGg0IIuutYz1CBG
	FSuGr
X-Google-Smtp-Source: AGHT+IHNdHwgJkxU/c7he2qR8Emh4wqA9igXjbObp12d2JZSditinXWK0fb7oRM0CYPKysdzrIMYWw==
X-Received: by 2002:a05:6a00:6c85:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-73dc1497eb0mr844757b3a.9.1744934181209;
        Thu, 17 Apr 2025 16:56:21 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e15cesm476367b3a.45.2025.04.17.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:56:20 -0700 (PDT)
Subject: [RFC PATCH 0/2] Add concept of rolling start/stop to phylink
From: Alexander Duyck <alexander.duyck@gmail.com>
To: linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org
Date: Thu, 17 Apr 2025 16:56:19 -0700
Message-ID: 
 <174493388712.1021855.5688275689821876896.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This is based on the conversations I was having with Russell earlier. I am
mostly just looking for feedback on if this is a viable approach for this
or not.

As it stands I will need to wait for the patches submitted to net to get
synced back up to net-next so I will likely be waiting several days for
that. The main thing I am looking for is if this is acceptable so I can go
back to working on the rest of the driver.

---

Alexander Duyck (2):
      net: phylink: Add support for link initialization w/ a "rolling start"
      net: phylink: Extend phylink_suspend to support a "rolling stop"


 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |  5 -----
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  1 +
 drivers/net/phy/phylink.c                       | 17 ++++++++++++-----
 include/linux/phylink.h                         |  4 ++++
 4 files changed, 17 insertions(+), 10 deletions(-)

--


