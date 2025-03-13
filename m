Return-Path: <netdev+bounces-174436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11439A5E9F8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 03:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515D7179103
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625621C695;
	Thu, 13 Mar 2025 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3F1/vbl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD32E3395
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741833409; cv=none; b=cOr2HSahDwAcd0zBpOG/TtCRftl1JtePR5F6tUBIt+8lffhqmZu8I7gGcaAMSKOBljPoE37ArS82cZnEKd0JMKKOvwn8hrTXcrfsM+saCxHzNJpUYt7gC75lVAI4PtD0ZF1s6hmCk/AIs/0vNjefMTM09gOmanadN0VlJUtcuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741833409; c=relaxed/simple;
	bh=1Fzz/vnENn6Rnc+gdFpduaGjce7G7nZfmQdWZvATJeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nulR2MYkwCONsXdE9GajQ3HkwbONolYK5NwwyiJm8c0JoNR9f0PchEwXQnUuKa0A2b/A5b2Gt0gWmHgAv3yv4juARvv1OidTrErvCiAVBtycnpZEt7WaEsiMQI9zWB7CoCvrYLV5j2DduTCysITFSPiCE8cpHOKgtuUZru4nOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3F1/vbl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223a2770b75so9887665ad.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741833407; x=1742438207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XC1r5eElmQgLxs9sRr0XwO491Cg6pKVsFB0X+CnU5h8=;
        b=C3F1/vblcFgDvvFLBPGNiR1I8KZt5bKraG7WdYGPAptgxBe0Zq2y4i7baV9mBKLMTT
         ScM643OLNPFyAsI0hfZ1OizF5lqCqbRWTjC6CbOspnvVDRozjY0IWiMOEwL5jSOCxSlH
         ZCTvdMuhr6S0FZKJxgehqEJXVLWbmeFwIz6dYnXoaTI9ORL2p84g2WVtRc8GIpFJfcij
         BqJmHmbk0K9CIPSnU0QXY4aJCcJCl6tmWjYORnQYs2J2t6IsHOkOQJgF9JpZJuRUqF8o
         lpbmE2tAUGS+y5I0iD1Nwn6pEsxZ25jGz25bb4XckGNpB9PmSjsXWN9sAWG6TesrWo3A
         tVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741833407; x=1742438207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XC1r5eElmQgLxs9sRr0XwO491Cg6pKVsFB0X+CnU5h8=;
        b=U4oeVhZmV/cYf/PUkLnTbNwiwG0Sfvb/39YZoICsM4yqAYx+IlwHZKSmpmHyyxrKvi
         Hs2y68xW3schmUfhuV5NaWbH9ubAHI5p93queF+7UMYaJ1xhsJ0pzUxxj7S8QrV7DCKs
         iDPtMvYcLbTKIKmET20gooTeItOYnbSVvZ+ds8EGotZ06j9PYnRrxcOEDFhRnKZUYe4/
         JVRmh8ZD51zd0HST5ffzyOiMyQ9Tlvqv/2ssnvBYTEVk1zMSfVEa+m/rCVlx9rQZ0wYT
         AwWPaOUjEaazyzqB3fh81UsyU+jcqDTDxh5YSUcSA3NVA/C8KujbLrctlZEwOOhB3qtd
         CeVQ==
X-Gm-Message-State: AOJu0YxVUY/BEySuM3S7BD68tskZah3pdgfArFH7BZ8jp5JcD/hSLXoY
	y9DREm1ivRUhtpCxG1yf9vxHtzGyPevYFLvER6O2qC3SDcD8GV10mW8RHfK2bS2v2ZPdITaLK2+
	IWS0hGhZlrsyfaP0YD2kTE0VWyCbspaC8wmM06pfkfu7ohjrNtcpzN+F7F8kUbz4i/5iZKrDqWY
	noH4XcVDa/UxxvHBUNPawDtp9K7yqC7ppzzIDUdqqkX1O0WcDdMw60YxQ4QaS3s9OF4vPrdA==
X-Google-Smtp-Source: AGHT+IGq1/goM0WQxlVnPa03z8Zvj7fjzw57nhoPc/ywSpvHISK1YNSWAmB2yeieAnx39v3LlqVXoek2U8PE3/5xbeGb
X-Received: from pfbhc23.prod.google.com ([2002:a05:6a00:6517:b0:736:3cd5:ba36])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:928b:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-736aaa22109mr34897291b3a.12.1741833406955;
 Wed, 12 Mar 2025 19:36:46 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:36:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313023641.1007052-1-chiachangwang@google.com>
Subject: [PATCH ipsec-next v5 0/2] Update offload configuration with SA
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiachangwang@google.com, stanleyjhu@google.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"

The current Security Association (SA) offload setting
cannot be modified without removing and re-adding the
SA with the new configuration. Although existing netlink
messages allow SA migration, the offload setting will
be removed after migration.

This patchset enhances SA migration to include updating
the offload setting. This is beneficial for devices that
support IPsec session management.

Chiachang Wang (2):
  xfrm: Migrate offload configuration
  xfrm: Refactor migration setup during the cloning process

 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 24 ++++++++++++++++--------
 net/xfrm/xfrm_user.c   | 15 ++++++++++++---
 5 files changed, 37 insertions(+), 16 deletions(-)

---
v4 -> v5:
 - Remove redundant xfrm_migrate pointer validation in the
   xfrm_state_clone_and_setup() method
v3 -> v4:
 - Change the target tree to ipsec-next
 - Rebase commit to adopt updated xfrm_init_state()
 - Remove redundant variable to rely on validiaty of pointer
 - Refactor xfrm_migrate copy into xfrm_state_clone and rename the
   method
v2 -> v3:
 - Update af_key.c to address kbuild error
v1 -> v2:
 - Revert "xfrm: Update offload configuration during SA update"
   change as the patch can be protentially handled in the
   hardware without the change.
 - Address review feedback to correct the logic in the
   xfrm_state_migrate in the migration offload configuration
   change.
 - Revise the commit message for "xfrm: Migrate offload configuration"
--
2.49.0.rc1.451.g8f38331e32-goog


