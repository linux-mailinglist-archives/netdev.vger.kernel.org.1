Return-Path: <netdev+bounces-103047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BED906143
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7E21C20C16
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981BDDB1;
	Thu, 13 Jun 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIjBPnQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059F8472
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243270; cv=none; b=OBEDY+guBQPFW25yJUTUp1Zg6NOdkXRShsyFY8jc3B+uMDahbe8Z/PiTpiDe0aYfvOHXwfrxQ7gzk65oHwMceMg7JP9TD3ZFMsdK834GUNHIHG8LZkSh3od9W0z1adxZmbP+F5CwSRRVlQhdoo+KyDGF5BYf8kt0PL3jInFPBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243270; c=relaxed/simple;
	bh=zbxyjIDuMMcN+EEDnZYAiPqVzRxwnoc2iPnyqCMqU68=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fTcpFMdZ1f7WXXxvRjCRRzbH2w6JJPcgI3QuHMH9ssFCmexUnhRxYuDeiAuOezwUFywS9KmPjuvOuAW6gxFtHSzKEetmZ+eDPaLXZLC7eSj4ABRN6fzCUW1lSUfVx6oQcfDlQXv0QYtgmXSPoiugUsDPdGM4z1m/OtKOleaLE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIjBPnQQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfef7ac17f8so851296276.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 18:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718243268; x=1718848068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jglVciy58w4IphO2T75On6BML/WYaKIhiX0KdFEt8kM=;
        b=wIjBPnQQw/BWusKJ+jLt2qHL2fNQrtjEYGnTxka3WvmUh9HulQf5qw0SoRsIQmQZri
         pId+USU4ZVisWWbytITHv9WG72O3wVs8SkxuGP8FXXmMN1DACrOFf78aC809xeU6wpf+
         wD3QNOinfCIRE3Wo8yXPVeqvGd6dvON7QLcI8kLShhVOl8Ns83fWkvSEocB5JVyJRbAy
         GWllOJvN8PhAHV3ci2zsmgZ07hCkARhoOjeBc9IHR1TIYbRxVrwcdiDRb59bCAZHmUyD
         k+4WCzyJtNEQFWxuZdzHdqIuqqw2HlwDoJSYDUBMtiFKdcdEh3clN2nJi71IYbMMeKDH
         Kj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243268; x=1718848068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jglVciy58w4IphO2T75On6BML/WYaKIhiX0KdFEt8kM=;
        b=No9EXx7L3k1+AwlOoxqpp1XPj4buHgeV4y0C1XVtmgiX3uh75CLODYj5A67fcMvDaW
         gw2sW/HjDuY6zf+V3ItC/waxesW/amMEPjq73IbW2pMtn/Q2EuJ+FSpuhuzgCm4+QtGw
         mDz+MAhp7t7ALpi/Sj3QlesHw7JT0nD/EmFcLbAW4Z6xw2gNMpROwKUMeFxUfDfnM4lG
         XKnv2wmUtHKHL2BoYhQOlyU+3R9op7seEk13JOQpyD3lRWsRGxXFw6clkrZOyfzLDgTN
         R2GUdWNT+v+4lQcrWqeHGxJUHFsfilQrZ5QUr9Mw2u0+NvPRRv5JRq4g3XSc42xq3xIA
         EhMw==
X-Gm-Message-State: AOJu0YxVpGW0+axaf3Ifs0bsgx+kilrkSabV9rEJtQ3FZigmqrXTWddC
	BO8nA5ezllXgq9oZqdv+edPpUa+XtNDLCkJm/5c948EOzudJEFvIXthutJVojvBngqEqucI89Gg
	7MaZCJDKaXknyyGgAiAZ2EJokrNEdVvIADtLWRXQb4C1SP+UFe+qlW1FbAtlTDgatr0rBIu6ZRQ
	aVvMuXhUeuuHkF7PADBMLIuEpA53iWKSrKFotg9c0498QP26S1
X-Google-Smtp-Source: AGHT+IGO20dpRHNPspMaKfvKGdAZ/6Zf5KtX+Wm02VwbZzvwUHHb6dzJp/78cfJdqkfgTmwC4zNPis4NCHNbzXo=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:18d0:b0:dfe:fca5:2b9c with SMTP
 id 3f1490d57ef6-dfefed223damr351149276.2.1718243268195; Wed, 12 Jun 2024
 18:47:48 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:47:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613014744.1370943-1-ziweixiao@google.com>
Subject: [PATCH net-next v2 0/5] gve: Add flow steering support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To support flow steering in GVE driver, there are two adminq changes
need to be made in advance.

The first one is adding adminq mutex lock, which is to allow the
incoming flow steering operations to be able to temporarily drop the
rtnl_lock to reduce the latency for registering flow rules among
several NICs at the same time.

The second one is to add the extended adminq command so that we can
support larger adminq command such as configure_flow_rule command. In
that patch, there is a new added function called
gve_adminq_execute_extended_cmd with the attribute of __maybe_unused.
That attribute will be removed in the third patch of this series where
it will use the previously unused function.

And the other three patches are needed for the actual flow steering
feature support in driver.

Jeroen de Borst (4):
  gve: Add adminq extended command
  gve: Add flow steering device option
  gve: Add flow steering adminq commands
  gve: Add flow steering ethtool support

Ziwei Xiao (1):
  gve: Add adminq mutex lock

 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |  54 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 230 +++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  | 103 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  85 ++++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 298 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  83 ++++-
 7 files changed, 830 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c

-- 
2.45.2.627.g7a2c4fd464-goog


