Return-Path: <netdev+bounces-106290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E38915AD8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473C21C214D0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1D4C8E;
	Tue, 25 Jun 2024 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRRhCUnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC14C76
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274357; cv=none; b=tRbvqLUYadwjEfynp+ZgRd378k8fizsVnlL9A7QN8IPTi5xQAjk8w4kThq6voo4Q8eTu5icm4fI1xJxiKkXrTytcGwCw2JI4KDqa0ZvNZfGX25IEpY9/jJGiapkFoSc9eb9OLEVzMp/AMQwSksDwpueUb0fyOoBrzEy1roo8POo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274357; c=relaxed/simple;
	bh=MkWZiVyEZaCpvL/hUYtur+Aez3cVyzMvIn1s9J+PG+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HiCDn00ii9hZsjvaXNcBwrACyAvpBn2rm7mE2l9w1tLKDQ/dTsvj14Rq75hToKWvpwY7E5oBFOKFPvFFUNYIQYHSm8MaQsSb7Kw6LRSLbRhFS1aFAzVp9n8rdAwIydlg/szrhH0ftbmTo0Ps3gF/s5spcn823XnhHq+6+iC3L7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRRhCUnT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bab20b9f4so89575817b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274355; x=1719879155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WFK4Mw2uavVsHauf1ixv/68eOcjdeaRcJ7jBEkj+1c=;
        b=hRRhCUnTzKWwuvFy9Cj+0ZJcyYfveaMBvFtef1lD7CG+xEpLtLK9NHsm5YBblpsSx7
         lCcvV5b2NxD9zU4t0xe7uiwbEAmRLHxSVRcGOedJ0XdhB7LGH7lWTIUhud5olrbsTuj2
         GR34R9Fq6lOQifW1pno3A3T+LhxigL8X21J8YGn+gE7Nb/aB4T8Vf2F2/Od9dlTSVaVL
         Qh47LGMT8CUHWyc9UBZ9tsTecsHBdMYUKfaZ51ek8PK691/5+YNjPwfOirxQ1h3VMyoa
         2cZbc0InriPVorSLPPv8v7IVR3odcPrm5mrGEJoPW1AAGL9GLmYdvJ0ZvCyzbD6TzSCk
         x4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274355; x=1719879155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WFK4Mw2uavVsHauf1ixv/68eOcjdeaRcJ7jBEkj+1c=;
        b=kytGBjCB7FB1d1sg4iAHgWWyB1UjRfhkbJeWeQZzEcPyFWeh14qfqHsuDrIW+IQHuQ
         HtMTr+kn5TXgNWUlZVExfHPWvN4olY7DC36EU/mNCin8CkmKS+4AEoWNnGHEaDTEypUj
         rBAhc6Nk/jFiEZxwcdt+awxMtam6XD5YI+eBKln2P6gr7WrwMpPvMyMyN8PvJbxjNTPb
         SCMSiu0Sr+ILd0GIudgaLE95D76nO6bWEFeDPCZ6T1rq0NYuQMSkovwcygkgvu7by/BG
         QIh93qttwuMJ5ZwFw9J52ryOAXFAXteEhzjzN7HoNMFHiYD/6oViUd12OtojGUtod5d7
         mw9Q==
X-Gm-Message-State: AOJu0Yx5F6hY4WPrgyn+fJj150y6OXax/hyPTaVOWM0KvwoohkhrmycD
	TKw+6KYx5ZFkRIx2xepPy997IN8t+ViTZM8VN39NE8f2iHNPsZgUlT0nHF2sBI/iaURgD6pv52s
	wK0CF9aCJSWr3Jc74eYVFDJVQ6w96y8q40jl4YjpzAj+rmzGnNQ+St4PXafVimY9XvwKpAlrXiU
	bzHdVKDpRuKIMe+fvtxSUHv6XBtyhqdokQSXYEr0hdOyqz755A
X-Google-Smtp-Source: AGHT+IEAHN6vxc1a3hrVU30O90SAL0p+cJBk3eDBbdM0X2OSdmjIP4I1Ga7PbaKvwazJ/rjKfnZmjb62J0yq8Gg=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:690c:f08:b0:622:d03f:ebf with SMTP
 id 00721157ae682-643ac03b294mr1989627b3.3.1719274355090; Mon, 24 Jun 2024
 17:12:35 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-1-ziweixiao@google.com>
Subject: [PATCH net-next v3 0/5] gve: Add flow steering support
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
several NICs at the same time. This could be achieved by the future
changes to reduce the drivers' dependencies on the rtnl lock for
particular ethtool ops.

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
 drivers/net/ethernet/google/gve/gve_adminq.c  | 228 +++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  | 103 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  72 ++++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 298 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  83 ++++-
 7 files changed, 817 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c

-- 
2.45.2.741.gdbec12cfda-goog


