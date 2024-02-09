Return-Path: <netdev+bounces-70549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EF84F7F4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258221F25BC4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89146BB2F;
	Fri,  9 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbg63HOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B43364D8
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490579; cv=none; b=W3sDjIDjlZEvzXgTqAzB/Azn3sm05tUwGF4vmoZXrGhNlukakS7tydRydVeT8GSiqF79hRn39Qk/LkW2BLC2NgFwFbbifueEKa7L7fH24Cjwc+1H04tnUjANJJjeza/THGCEHK7B7n86lt5HJhDBp1CQkEewrbDsMDr4WrHM6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490579; c=relaxed/simple;
	bh=SJfHSoG/F0n8davt0z2YUcM793nU+QFBm9A5KzQ+G28=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WJRbFp1li3hHV9pXha5ZxBpeSmINZG0k+zVbHDXWW0dJ0npXZunY79rBOxsO6I9SClY4+Gp5oz39m02npxPTGdD0uNQSCi41PIK4O3cRhTB02F6EHHvf6jgShFR+MXceMcaf4iiqDgCgEJAZ9w6A/x7ltbqrzZ7pL3mOYQuZUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbg63HOr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1421340276.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707490577; x=1708095377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+65mP3Yw9c5Ml/UwQ4Kv3s34pBdNIckb7RihD09t18=;
        b=qbg63HOricYM3Vvxz9KoRTSB/mcPYPkk1zFsYBHkEubLMTKMQAH8KAdcmzlBDlmcak
         D3KKRl9KDH+2hKAJveWPOmpDU0LIpndke67XD0gp5jD6Kf3tfZiVzySL+IU3gnA/NLrO
         kt4XnONzTvfibkh8dG9q8862SWu7qGxzC3AdXop5clkEegL4alkZw+JZBE5u46MvD8yP
         0LsCQyoYhAp1cG+pd7CBoQl0aRye48BOXwFM7u944aPZEf8RLz/LtsSMQWoQIxyXsGcW
         6NLRLF5MRMWUibWnvMXqiAMHoI0J/J5PegJeGB+M9vJpTd8Kwkwg8bMe83jBDGN7jffj
         R8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490577; x=1708095377;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+65mP3Yw9c5Ml/UwQ4Kv3s34pBdNIckb7RihD09t18=;
        b=EHVQsG/ZjcUje63lpsT11yIJFkfrusURxEOLfMJVFIFxlE5wjENaBCCp+PM8h/tTK6
         r5yA0ged7O9Qc+Sww8Cbgb6Bah+czKkZDCcwNk1OFsyRDf3CnCP5X7j44gDJZ3sWws/k
         hbFxOnBkqSW28Km9zQOgx6Ycg9zDNu5pP7a+/3Ef7nv8ey9g0Ifxg8TzfxsYg5gU58Qw
         2QjyRCqrJFU4/7KhC2sZ5jxDAo8DfYKZC+zOXDmTVzy/EqiahxnmqEzQ9vJn4xaPgOuG
         ennDoJbtzqtZtiNMeQUDFg3auO2yVoCE+MXoC77+BSDc2NWtweKvqVD+GHh/L0XFqzKm
         2Erw==
X-Gm-Message-State: AOJu0YwYiQPLpWubES7Vl/yN9W2t5bAx6N9DC0hE46oI27ereu2GKDma
	PgnZvZZD7vniCo30ypRdoUa0I/dmBku5by/Z7fhYVMO2VsNo3/72MkZBp+HpvtnYH8euoKlw9E/
	25vTJS8u0GA==
X-Google-Smtp-Source: AGHT+IHrH9MdE9QK98rslum7oZDHsA8zu/Fjp7QYpaFFpayBgwwdmEW9bSFOnSbk5iPjny5RdsV0oHoDpqGtuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:114b:b0:dc2:46cd:eee9 with SMTP
 id p11-20020a056902114b00b00dc246cdeee9mr46223ybu.4.1707490577457; Fri, 09
 Feb 2024 06:56:17 -0800 (PST)
Date: Fri,  9 Feb 2024 14:56:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209145615.3708207-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: use net->dev_by_index in two places
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Bring "ip link" ordering to /proc/net/dev one (by ifindexes).

Do the same for /proc/net/vlan/config

Eric Dumazet (2):
  vlan: use xarray iterator to implement /proc/net/vlan/config
  rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()

 net/8021q/vlanproc.c | 46 ++++++++++++----------------------
 net/core/rtnetlink.c | 59 ++++++++++++++------------------------------
 2 files changed, 35 insertions(+), 70 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


