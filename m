Return-Path: <netdev+bounces-226712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031BBA45DD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A9017F48D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DAC1F4168;
	Fri, 26 Sep 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAdZii/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4916132F
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899598; cv=none; b=sCzQZ7IPCueuiFLUZKp02E7cnbtJmxvf/Q+W2exkynL5f0I5OqJ0So9dcl0UDErHHcz9E3Io/KVuUuD7FgPcsDYg+ungjBR/gj7j5ugrb/K0iHvM/y13dMOJj8x1snetHRLHB+6lPh3NGBXCIWNp6MqC8tyQpQQHgutRcmmlbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899598; c=relaxed/simple;
	bh=IQFmS2b3CSbDyxTJ1k0olpO1pF+5NlHDCznP976Uqtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RVb+0dAHwLnaN9n8KjvIvGDqRnQGesIWJ1+huspI2y3beGRUjTxAB7V4SXiTMWndape9GsXK5AI8jBsoqahmEDehRpOEdGvwlUp3YGIzD5NZsUz/UJgoYpXrErPX/Y24RNbhq/2S+EEYEyLr3Q3Bo9pukd39+rMfJlc7v8w6JII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QAdZii/I; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4d9a3ca3ec8so42761491cf.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758899595; x=1759504395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RFze8MCWGys7zJOVvS/nT1PreGBr1gveQhPMWrZhfVs=;
        b=QAdZii/IXRSJW58tzOdFm2YxNMsKmvSJzDINH59IOF47zouTADXz6ttoFS5AvFxTta
         H7F4VZ0pP0eBaUxoylaOORzbJwO7BfBjRZI1pVohoThKxgFZbQ6qR0crf/XoD78AE4fY
         SUGv4OL/Ple2bEPEblbi4UQ6y7a9Qspznp1tKVxXw1h5+ub2ATYNt9UDnJtsjWEo9OTJ
         n6n7UCQHdx/WsVFYaOziUuKWlpss8JXR/uwGEJllYqLDtPJcf9dkcrZWcZUsTKyHArDv
         qDst0RFa9H96ncH96uR93of0yd283kJ43vIKGJpfP+1qdzgsaqf5frq7PRiUeuEJn1h5
         Dwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899595; x=1759504395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFze8MCWGys7zJOVvS/nT1PreGBr1gveQhPMWrZhfVs=;
        b=htsFTh3i2HFsYuaNTBgwlwSqPWcVjtgk68dRickovT4MQKr5mUpRRtIhRDr0L5il9q
         LKFpMWKSribzkstAWOp8WCyHXUN0x1Enn3pQsSUjX6U2p2tUMPEARem/vqYRRquDEeiB
         ZLcvR10AX2wydWlKKUW16rFH5HWCNPZYtePsbwKLQNEJgl9dmnggJFTHLLnaR9HhqKDZ
         8g4ZikfOXmCFWFDSW5woHTrh65fEQDxBjZ03AFPDyJTJSgXZgryBoogbWJdYFweUZnrI
         wlUzadDDKZFV7GKELA3qbAX1bjSoUiFwte44/pD0CUqwFhIeh9WWBeREG5i1TXnb8RKL
         d69g==
X-Forwarded-Encrypted: i=1; AJvYcCU/xxvOMG240cMrxbkIPM2osH1yzVG3ukQ3oQIAsjL1YKITTP29xuRbQ/GZql8mvrY+ehUjUps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3uzhHNKmxkr+ZvTJw9R1rzvWEpjIuQZzoB+RVKh7/o3JVtTxY
	N5tJRcnpaHkMISQjqQ2bhtIiVzOlfJ4C7zIFY2COF4n0um7crO029lWS5U01lBrFLmOXQPolXxJ
	AEsXkl0mlSSx66g==
X-Google-Smtp-Source: AGHT+IE2Wl49d9yn/fThOld87lvrenlijo4S2xZot39vbJEkosU244eSr62V8B6r/qqp+MdehwM2RGEjcy1bBA==
X-Received: from qtbbx12.prod.google.com ([2002:a05:622a:90c:b0:4b7:ab62:982c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5e07:b0:4da:7d53:c01f with SMTP id d75a77b69052e-4da7d53c586mr62792901cf.28.1758899594898;
 Fri, 26 Sep 2025 08:13:14 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:13:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926151304.1897276-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: lockless skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Platforms with many cpus and relatively slow inter connect show
a significant spinlock contention in skb_attempt_defer_free().

This series refactors this infrastructure to be NUMA aware,
and lockless.

Tested on various platforms, including AMD Zen 2/3/4
and Intel Granite Rapids, showing significant cost reductions
under network stress (more than 20 Mpps).

Eric Dumazet (3):
  net: make softnet_data.defer_count an atomic
  net: use llist for sd->defer_list
  net: add NUMA awareness to skb_attempt_defer_free()

 include/linux/netdevice.h |  6 +-----
 include/net/hotdata.h     |  7 +++++++
 net/core/dev.c            | 43 +++++++++++++++++++++++----------------
 net/core/dev.h            |  2 +-
 net/core/skbuff.c         | 24 ++++++++++------------
 5 files changed, 45 insertions(+), 37 deletions(-)

-- 
2.51.0.536.g15c5d4f767-goog


