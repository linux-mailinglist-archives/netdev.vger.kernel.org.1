Return-Path: <netdev+bounces-160263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09ABA19129
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DA31889CDE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66C211A2B;
	Wed, 22 Jan 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2zANVVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA91BDA99
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547790; cv=none; b=rolsphL+q/608HoragJEtFudNj2qqSqYUMk0/EVqEDMMXylUJaRzxDEyKRcROrGIdDKQkb9rMdSNcr7zjNDcHjbMYzqGOKsEqq7VOjMSJLQUY4V1vvLdi6Vt+Zt95MceWPtisbBQ8R8O3mcf20bz+6TEblG7I4z9Szh6zye4h8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547790; c=relaxed/simple;
	bh=1JF+zLZllFrozOQTe2l1vt1DiXMOu6fxQQy2zRfAYRg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uG+UOBhRU2Bve9zYtKkWkl+innAxE9vsIf+QhBvvsasNC1Oj6cN1xwS+6XBMjbH2/q0MnFycM6VYzcCqmCk3H673JoGrN04sHt+eoX4EPvBuw6UezRwDSRlrU+Dr5JWshPa1Qw27EZqXezWZZqw3sRDu7F6AZgUvwGc+vOwwawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2zANVVm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163dc0f689so68956025ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 04:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737547788; x=1738152588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WKicSUmSJE4k8rBNPd/O4K/U2c6/YBAmlnZbeFXBC5I=;
        b=P2zANVVmsKQFC2C59ujS5P4d1GUWXK6UlnuzUG0cwDU6xfKBNyuBOvLsWyFw0R0ZOn
         09IYyEfuKHGb0YJ+8/737qvSUH+BkrmnM9vNUw2VuPfX3r+LzM/q8rb7ztdwfoue4ZlL
         YawrZTHGtC26pdCHrNPVojZ6xGrR7BnQAIlWKoiqClgO5QxukELDvCRqIJpcqLatMMNZ
         QSh1MbEsghsSpi8BN4nzIwremqPd43ey/VcFVAvwaUHoplLs7wYCZgc+TLXRroNkchbW
         3gJefNUdcv41+ii6kv0Tw9wvs+RjRlwR9MfPBg8aKua82/I/ifh/pX36tQlLcXeo+4RL
         ZGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547788; x=1738152588;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKicSUmSJE4k8rBNPd/O4K/U2c6/YBAmlnZbeFXBC5I=;
        b=UOEmWTrwy/fkMMc0HNACLRbYWSi/MbARvGpCI3LkMZpRf7n9BOtvRpaQZTzbJOza1F
         GgOuqveazpDXLLtSNkSTUaBZTsB36jJfDkHBu5JypJlelMYPnqFo2L39eEZaGsGX9CFq
         SNfAwI0vP0BGhpTEPR2SKuGGYQabHlNeq6x/DbkLl9e6TpdSVL9FFt39ZOl07X3rJ3ao
         Jclcd5D9MGng7xp0J7IGOUqf7uFvZPG6EWfCTbbNn7/7skKMt/5IMTIQdTh25qAvZwx4
         RXVrv9N/ZZvERs6pt/9VJcyCWf6dwbS6z/6t9Hq6Y4Cs6n7y86QmFblzi2ffwa0MhzdN
         LuUg==
X-Gm-Message-State: AOJu0YyS6d80GQG/a3+/FxgxAMALozX63EuSDihwOV9o0qz67UTf/MCB
	FPNJ5bpGfqhCAAKbh/47sQOTFCdUBRhg/jek45GftqNJ7FULiOqoJ3ZbHOIWVCDjPe1DUI8EcN6
	6TZ+do9dxPfLdoMsEUtK4ey0wmhH/2xoakZJv7fQGWwT0OdIyvXIxF4KYzh8yKNa+CwLCaMPCFG
	EX27NDvXpvx80P845IeYw/FY49b1wh84rjtF4MwF6EFOBOt8PE7pkOswDOoRiXzWRR5m1Yag==
X-Google-Smtp-Source: AGHT+IElWGqIOo9YYwCLKMunl8pN2x3G/V6Ij94TT8lWoXBN4HZGXshRYaKXSj+2G+7hIaVSGQ8y4LYQzycQ857oaRNS
X-Received: from pfau8.prod.google.com ([2002:a05:6a00:aa88:b0:725:f376:f548])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734e:b0:1e1:ac4f:d322 with SMTP id adf61e73a8af0-1eb214a0817mr32980508637.14.1737547788313;
 Wed, 22 Jan 2025 04:09:48 -0800 (PST)
Date: Wed, 22 Jan 2025 12:09:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122120941.2634198-1-chiachangwang@google.com>
Subject: [PATCH ipsec v1 0/2] Update offload configuration with SA
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: yumike@google.com, stanleyjhu@google.com, chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

The current Security Association (SA) offload setting
cannot be modified without removing and re-adding the
SA with the new configuration. Although existing netlink
messages allow SA update and migration, the offload
setting remains unchanged even if it is modified in
the updated SA.

This patchset enhances SA update and migration to
include updating the offload setting. This is beneficial
for devices that support IPsec session management,
enabling them to update offload configurations without
disrupting existing sessions.

Chiachang Wang (2):
  xfrm: Update offload configuration during SA updates
  xfrm: Migrate offload configuaration

 include/net/xfrm.h     |  8 ++++++--
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 38 ++++++++++++++++++++++++++++++++++----
 net/xfrm/xfrm_user.c   | 15 +++++++++++++--
 4 files changed, 55 insertions(+), 10 deletions(-)

--
2.48.1.262.g85cc9f2d1e-goog


