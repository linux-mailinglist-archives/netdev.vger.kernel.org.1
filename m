Return-Path: <netdev+bounces-117863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F094F985
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA191C212F4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE532194C83;
	Mon, 12 Aug 2024 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Icka+GK8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB614A4DF
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501266; cv=none; b=EKaAF2eWleF7LulAOOkqmAxGICWSKwL+OvohGikIZpbZVbXJBehUWxho/2DvfbDyt2KtmU8QAF5j5luS+tcrQCgw1hFyoC+dHUerSDRrijoMYmJ+O9Ruxb14jzdyGxFbWkKlS4x6TgOOLNBc6A2CzHJcN5J6JI/qOtL/HHRC0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501266; c=relaxed/simple;
	bh=TVtJG8QurToswRsxGi+LNzg1kdsDZUCDsKZyNPoPtLQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LfipBkro+tyMa3fo1HO4lkgz5YW5TRz5o1yLcXoW8TI2jgv/PfjIH2X85qPVABmct22XN3Q80IHM+Gt6OQpGTbImEuwvL7jeVAvQk4xFFyjGVKmuyamO4iz9zxje3Rw9qVwxf5Qen+PtPzd665qOn0Rcu66qvheBYW8KIO5CoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Icka+GK8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc5f04f356so39420675ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723501265; x=1724106065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/b0Cy+86EKXK/QoOcvbYugGDET8BOs8O5cH1rnUZyQ=;
        b=Icka+GK8J/qhIRZx0gjGYCduxTsc54agIA4lxgTGM7B0FeR1Rz5iLcTW79nndPTcYT
         ueKhnaQa1TnF+a4FQtYVv2lqLvcWfuuVm+UWXOQVTA2VT1+B7MAOTp8fyLTWglH0wqd3
         wum3KYFr0XHVEJle2ArxkiNkPeODmIoopFth1uopUr0cEsUnXab11FeeKuo8ZF/bd11y
         HhusMWzCUBsnxrVkPKXzioRm9dR/dHy67G9Pz3VQ/NHMuS9bKNmh2EiV2Bi5w+h/pwED
         dhAu7s4xqW9YqQOBrD41M3B0pKUgml5/2dgKA6pIBQMm27boLGNIxbyHdBPxTn3L6hMf
         r11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501265; x=1724106065;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/b0Cy+86EKXK/QoOcvbYugGDET8BOs8O5cH1rnUZyQ=;
        b=PT27tnRH9OPWOyBgFLrA4lWsClf1QO93MGZgBuHU9FAQGsrCVsSQsxrkg2q2ipStQ6
         GgYKXrkn6xhQAbZWv/qpWK6sBrZxqc77TMV+MCxRC452ru1XFFsKNbDf+wSMLMkAsL+n
         zDkolfXeLx1SyvWiP+IMF4woaCVa9w/k1zDkcpWJqI1PiE6Y0XVqeTyn6HqhMpaqJ6By
         VrV6JbYidnQibyUvXqJFq9Z0W7eC+zniUuLA54ZM7qD/EBUHnpFr04vtvl8MJhoPXo6T
         VZv6fAeGB25644oUPbwx51yPBI0NC+TFb88AEhYU7/o9kd/RpAjyu616iNWSQYInrT7d
         ZvZQ==
X-Gm-Message-State: AOJu0Yyufysx1VD4LJ27ryc+Xi/uIDOW6EzS382l9TvaLRob2y6U8xVu
	m0DO96B6vFTGScd5KqjBNypSpOnasbtqX5OJ8uGzDKU4IQATAVT6TcrfL9WJBn9GmoCY5aCWxOf
	7smq3p06YE4OZZ6wGgBdnid31PCl3nVT5BJf8Fu3+H37UrfkI4paG6G9HZYXqHn03j1ZIAOxXIL
	ozER+AfbTTAe9+1b/sL406mJewYD1SJzEJumgkOk7nkSIGYOZgckJKM32jxxjw4f8f
X-Google-Smtp-Source: AGHT+IH8uT3rdZtRL3hV/gfiTosN02jDrtz0yJcP63g2+AYSQJAZwHNllNI91GoHQVsrBs0z0r+cmC+YmcbBhdLTRx8=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:8c4a:afa1:7322:951c])
 (user=pkaligineedi job=sendgmr) by 2002:a17:902:d4cd:b0:1fa:ce44:c307 with
 SMTP id d9443c01a7336-201ca11f457mr43665ad.1.1723501262856; Mon, 12 Aug 2024
 15:21:02 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:20:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812222013.1503584-1-pkaligineedi@google.com>
Subject: [PATCH net-next v3 0/2] gve: Add RSS config support
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, jfraker@google.com, 
	Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

These two patches are used to add RSS config support in GVE driver
between the device and ethtool.

Changelog:
v3:
 - no changes, pure repost to get the patches into patchwork
v2:
 - https://lore.kernel.org/20240808205530.726871-1-pkaligineedi@google.com

Jeroen de Borst (1):
  gve: Add RSS adminq commands and ethtool support

Ziwei Xiao (1):
  gve: Add RSS device option

 drivers/net/ethernet/google/gve/gve.h         |   5 +
 drivers/net/ethernet/google/gve/gve_adminq.c  | 182 +++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  59 +++++-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  44 ++++-
 4 files changed, 286 insertions(+), 4 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


