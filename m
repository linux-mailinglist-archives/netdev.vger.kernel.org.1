Return-Path: <netdev+bounces-119605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7C956507
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460451C2165E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A015AACA;
	Mon, 19 Aug 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhxzZRfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B715A87F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054029; cv=none; b=aN2emzZiEH7ahjgTMo1bWpDSmgfjheDzWNVRUCQgoHPYiPhOY9sv988sBpnKOUJxzba+G0bE+O+0SYk2uV9SGTsTzXpQXdyP6XGzkkkYpe3mlTmkiAl8W64bJsZutFmohP3Lk8bkynJEHJEe8U2zjnv38e1flvfpuA17s1K3w4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054029; c=relaxed/simple;
	bh=mHVAqpYu02YHlnZTa9Ag8PLdCzHWk2pFM2y0+C0zvok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7vv8LEgHqAvYxJuusuR7uHE/+O7i7dP25kGtdxSnAllrA2HevQ4aOwQ5ETCjI+JLs9BwVDbK0sNDgaP35FRnfSGnKWe+toxlanTjJwXS9+nknh62SVm23DijRUXW68XkLmEFBE1BkFryvotxbPuhD1I0J3VSKi1muTdrwEUrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhxzZRfl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-710ce81bf7dso2860438b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724054027; x=1724658827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/Rj5yr8yXCHksuinOFCCLntbnEFvlEWyxLTFoDjU3s=;
        b=VhxzZRflVz0NBDDc0XJ9cUL8aDm+VfUD2GihTlVaB5IMz6leeI6NvGkdIb8vvoX/jA
         dh9/6sOIaDRlbmgQ0fWptFcGvKZYFIhEV/p1GSf4X6i6MW4fg/9K08Ma8rfIHEgy6/fs
         HcDxdFebmLf3L6agWEpv4gfhtQiryhCYg+ARTFCiT+V6RhHycvIjXlPeFB1Lfh7qfdC3
         1oNqQH/R0uaP7CDjxrD5FAXEuZApKk+M95n7u9usPc2gmFGuB+LDcATY900lA9vcwUxo
         kLSpE3UvPhCnAl7A4/Yhyo5yBbj1CBpC/Rkmsil2kHW9lVZk5qZwwMt8a1usc7fln799
         SjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054027; x=1724658827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/Rj5yr8yXCHksuinOFCCLntbnEFvlEWyxLTFoDjU3s=;
        b=HEZ794UyOaRm7N3pALmOeG+ywOKu36lANKGyJHkIXwIDyhIgfQqeHuxirul+jiKBIw
         zwFykN+xq0OBjUEoCk2heb9y3VxuBp9NGw8pQzW552sXD8XLPVgUFLiv/fCiHpzn4bHc
         7wuM066BSpGpz9dsRdqppIo8+kgUAF1CiC84Oqks0iwSBeSAMAa4922+zpCr+zVt/fXt
         CB/fGhv/9GpfyqNBO11aP6IQrR6qX++I+pd5RigmmQ/ZZL9RE6c4exvakueQL5oLwygZ
         Z6GG4FCDQkNWYCBst3OfKdNiAtbirY0qlJ+FgLceif/gk9Wo49AKrMyViNEKi3tv+Hpn
         oBAg==
X-Gm-Message-State: AOJu0YxbmIAYwY3bboroukIvU5HR3vBbxK6AVHeKy5il5ByS5UGezwby
	Ui9yrA7oR4sWZpOQVoJrhC2nIUbwK9YDVG0CLCv1fjjvlw2Sg5XxPJRjWlMiRpZFQg==
X-Google-Smtp-Source: AGHT+IH330uiq0pcsS0AKcGZINlGZjK4yr48daBeT8W2vgqbzt1jm3uiPUbcEFE6h3EVZZH+O7DWgA==
X-Received: by 2002:a05:6a00:9155:b0:705:b284:d65b with SMTP id d2e1a72fcca58-713c4f28a79mr9228338b3a.20.1724054026695;
        Mon, 19 Aug 2024 00:53:46 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6eeesm6147151b3a.118.2024.08.19.00.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:53:46 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/2] Bonding: support new xfrm state offload functions
Date: Mon, 19 Aug 2024 15:53:30 +0800
Message-ID: <20240819075334.236334-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
in future.

I planned to add the new XFRM state offload functions after Jianbo's
patchset [1], but it seems that may take some time. Therefore, I am
posting these two patches to net-next now, as our users are waiting for
this functionality. If Jianbo's patch is applied first, I can update these
patches accordingly.

[1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com

v2: Add a function to process the common device checking (Nikolay Aleksandrov)
    Remove unused variable (Simon Horman)
v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: add common function to check ipsec device
  bonding: Add ESN support to IPSec HW offload
  bonding: support xfrm state update

 drivers/net/bonding/bond_main.c | 93 ++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 13 deletions(-)

-- 
2.45.0


