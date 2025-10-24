Return-Path: <netdev+bounces-232341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37FC0442B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E983B8E47
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69364270553;
	Fri, 24 Oct 2025 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgKV3oN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A71EE7DC
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276787; cv=none; b=H9391+eJqpeKV1qi9uJDO6yhCnlC1jszKUHvzNTA7U5Jf40t7aeKbBMuvN/kG/Hao9HHTAH6UPotiXgkwvhs6gQSnMNO4RfSC7OaLVvl9C9c6MBK8AjfN7tdG4FgFcLM66kpRr79NGvbQx7/2aacTsaERcF9Arphxku6T3/wyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276787; c=relaxed/simple;
	bh=vLCgzMyCThpgQ64scTXHgaNMRBa1NmayEDllSs4DkOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdGnBzZMpTzIYTXCef+LUMpkjmqnDaactQRLp52Du7+1k/rR49iDvo2h4NMsFoV8LsJqSuBB/peSPgckNPhRVSlGUEqHjYlO1z/DAgEz1Db1OHrTBum0nX5TXx8bJENx9dSa0dalEbgJHUOUMyKgJLLD23F/5J1l7ij150M8VKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgKV3oN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290b48e09a7so19454045ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276784; x=1761881584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbhN64OUg842qsJQSGfmVy1u+1iZgam9qWQhuawKECs=;
        b=NGgKV3oN2kL9sY6hRnQbHiCZTimT5sXguX2PJvLh+3vuwEgJilu1KJboUuScl/0gY8
         NNO7VEk7TMk9O3axiHEaSNHxF8WMAniS6pLQBlLUP6cVZGmBSrkNsYg20ETxOW+aQRa5
         BxOvPZZnQt4dGjJj+fBt7qy+SzL31uhO8I0BDdA68fUndtpa4EcTTEXCQZmxBrZvptdB
         gwSifwmhnSkY09r1+9JV8UVRObbENbMGIStElDQAfkt1TfLvRMb7Dkw255ww6KBDUAW9
         bLkYmVZJMms2J+hcfzjm4No1AB1kDBYyM5tc3atp5grODOGeKL6S8JrEyzEK1sYskc7y
         WXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276784; x=1761881584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbhN64OUg842qsJQSGfmVy1u+1iZgam9qWQhuawKECs=;
        b=siAyOYqX1Gf7rxFh0L+hcj1cfUGpRI9vGzq3vCV+JdP30z41lK4ibj7I7Xj7/Lg396
         SGxdO4kTKscABfFyoX6EcbCAQQ2Lk0joUozV8AhCsVaXAoEgQLVFG2q4CQS77KJaQI8M
         kWRVdkGuuHxrTiGXyJGJU5vGtWjos/okrNEjgBXH/WwKTncADCslr3qA/SrsTM8OkbTR
         bcEsrXI1z+h+PTflEwS1/FnAWNFOH63cgiP6uEPZtNX3vJ8rVmUHGLR7u6+waf1aIfT1
         1pylLruiN1nhvHDohWpBAHZwF4Vj0i8942L5mi9OwI52UMS9nzn6K0ljG+DKKtVNKtbx
         EckA==
X-Gm-Message-State: AOJu0YyCnB2n+Jx9dLU5XJ/+Hx6lZzNgS3dvCB3jjTqO527yetpCXQtE
	RKNVaZV+T8tifIXXt2XLbY2YW5rHr8w7sLk2HdhdLnexhnARZ92b2HK/4yyyc3K+2ks=
X-Gm-Gg: ASbGncsWrPdFu/t16uPYCVhZRdnnLtt+tGyIJLkP3Q2bk3sDLKDNkbcIoIKmzHZ47Aj
	7JSKBWJuKbPW/A8VH+0dr6TFhKKNF7ancm+nE3wAtHFT56ZKYghnqsEo4WTXwFzF1jyOHfc1Mo1
	HXfzIV5An1jTE77Btl+wYsgf+pKjJUp1fIiHPD+BecIBsYeSU1DtSr2Hwovy5Noxb2b7Ejw4cql
	skZ2/GIMRhIYSElhXUxktOM9IqFIg3Gz/eFeH0S7jebH0Pe6jbb/SZG5QFad+oAiNrhLzZr40l0
	YwEAnNYCJKDduuu9+RnbARmuwQ2I42mt1NjUEyWFwkrEKl2JQRQkjNtn/gsneZ38WShkvQgDSS/
	5LjDb6cI6ALda2GqkCIPrzyG91Abuv1YWcuYqOgiCEbzlzOWYkUPlsvWJO/RDOyZfS+167Dl+dA
	49CorAt57CppCsfSZj2g==
X-Google-Smtp-Source: AGHT+IGg+i6jZ7Vc8khvsM0OhsbcyBpi7wwmvLoWQaXSJN/oltobDQLp3m3RiNLSjGcA1vXLKS5jrQ==
X-Received: by 2002:a17:902:dad2:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2930e5f9113mr106534885ad.11.1761276783905;
        Thu, 23 Oct 2025 20:33:03 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:03 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dsa: yt921x: Add STP/MST/HSR/LAG support
Date: Fri, 24 Oct 2025 11:32:26 +0800
Message-ID: <20251024033237.1336249-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for these features was deferred from the initial submission of the
driver.

David Yang (3):
  net: dsa: yt921x: Add STP/MST support
  net: dsa: yt921x: Add HSR offloading support
  net: dsa: yt921x: Add LAG offloading support

 drivers/net/dsa/yt921x.c | 323 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  29 ++++
 net/dsa/tag_yt921x.c     |   4 +
 3 files changed, 356 insertions(+)

-- 
2.51.0


