Return-Path: <netdev+bounces-115178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E259455F0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11941F23412
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D5CBA4D;
	Fri,  2 Aug 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDQ0uqVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347717571
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562135; cv=none; b=CIPQVsRsQTpaxAoD5Qhj/ylq6wzbBR0fNsSpS7R9Opo+TSmTr/Cq2gUKTgWUX30bw1wETomRmtf8JC1uLKvHsMI8jBihDLZeOiEi8K5kpUloXYT3F+CP0AYM5nV+CQGUPfavEt6JRBX4TGnUKuCeFE4Mpdsltk77Yx4QTM0lyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562135; c=relaxed/simple;
	bh=ZhGuG694tNivF7+/8mSK1KxSe6wytetxNLeGIQqjCMU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c1t/v9UdBfjLlvKQnMq/wNwepsffEnYWasUJG7I5ooW0zdKHs9XWrrZ+XvBwaIxZE8frLJgTs3kkZsXYJIjsbrtwTudV8pKnF9wD6ROeba4O5R0JV/oFvoUceXDh14t21/mze6FElNAdZTOYrss7IqWTEzZahABAIiGCKX1vx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDQ0uqVZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc54c57a92so57867095ad.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722562133; x=1723166933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uELXDpkyVQY+QMSJ9BZf0Ngi02BaugXYYNbID1ESn4o=;
        b=PDQ0uqVZpHFmx27HIHJsfWIJg+RDrhnMSku/yH4Ufd8oAYyS8bTtWUmlM/mf4V2tzZ
         ZhrMt0Vgy2HwzFtbyItkErDSFJM8IAUU5S7Fu9RJIoexEpOtnKy3dXICWBnyl8SVaKEN
         2xf/ufMH9Scpaq/fK/VDgYjxVArZ9BPizFTkOk3yqBnU7NGoVKM+yQ7Av12aoLnzOw3G
         6qFHG7aCw5kk0tUKP7uKlZUO5QXinCUBsWdEYwlusqlBemePMWcHEPd3blYe+UGmtdjN
         ibWwTwFA8YcIAJa8Ohr1l6fdzjh6Y8PF4fVIwENeOjdh2fkkAevY0zq9Gi+30um1DF1p
         RbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722562133; x=1723166933;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uELXDpkyVQY+QMSJ9BZf0Ngi02BaugXYYNbID1ESn4o=;
        b=QBZvOfsMrpuAcl35B2EwRGhSeJQzQeuBikJlU6J1GiYrKvrhjBAz5fxXmrHPT6gB5+
         SM6khvs+uoAhp47oxU7patyd7dLKET4Z0+3RrrAt0VM+f8btlGxp4Ne1E6gWp6rV99MD
         sN5yZ8LmKT/BT/Xcle7/KJ2563RBkeLAePglNL1nBbbuvg+K1iOz4k1zeLnzygp895ik
         LS427Z6k88xPAGcbBKrGAXvtGLSSHSNyrFALED7Qn6lg+KmwoeiJac0ztIopjO5YWRRm
         3KwfANd6+NKLH91BYBR2iejDjeSJ4U5l/PinaNzJ9oxL1dBUCJzCxo4Zt1VaSfN2/2T2
         sO5w==
X-Gm-Message-State: AOJu0Yw2gZbwuxIb0xJrqpyL+7HkuDmFSSaSdctxdA/GpXAcmIvN6MWL
	YIkL/nUbUlOq5wIV6+n2hdJjOGGb0HuTKvMBZC9raq6kIyBb/N5uzqzODd38BB+/9CtDVY8jeK5
	6J1NWrBUJKWyqLKqa62iqsPI3bFNEpaLXh+JiRRtIoK25yWp/hllf5X8GXwavIRlUa0i/wFf9MT
	oibUvNd9N2X2spvF0qnmNcNGnUGokmEs66kTfOPw88s2kHgzX5wlRG0L8njM8KnS4/
X-Google-Smtp-Source: AGHT+IGhikI3Rjm1wgqoqxvleKnwjwJFQ5hVwN+5wTPmpwEb37S9qSIbm4w/P1ZDzERzFSENN+4DCzCkcSlPwjaIPEU=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:fe4c:233c:119c:cbea])
 (user=pkaligineedi job=sendgmr) by 2002:a17:902:d4c1:b0:1f9:ddfe:fdde with
 SMTP id d9443c01a7336-1ff573f60ecmr142445ad.9.1722562132659; Thu, 01 Aug 2024
 18:28:52 -0700 (PDT)
Date: Thu,  1 Aug 2024 18:28:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802012834.1051452-1-pkaligineedi@google.com>
Subject: [PATCH net-next 0/2] gve: Add RSS config support
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

Jeroen de Borst (1):
  gve: Add RSS adminq commands and ethtool support

Ziwei Xiao (1):
  gve: Add RSS device option

 drivers/net/ethernet/google/gve/gve.h         |  11 ++
 drivers/net/ethernet/google/gve/gve_adminq.c  | 169 +++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  59 +++++-
 drivers/net/ethernet/google/gve/gve_ethtool.c | 118 +++++++++++-
 4 files changed, 352 insertions(+), 5 deletions(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog


