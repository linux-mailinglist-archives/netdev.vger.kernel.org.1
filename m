Return-Path: <netdev+bounces-70970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A393F8516E3
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFC1B2C597
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23628389;
	Mon, 12 Feb 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DunpMee1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998A3F9E6
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746824; cv=none; b=JVKuWrzICliktF1/nHco2HZlfY5iFXXvfqDVqJHPCj4V1EzDhI/AVlVb0GuIGvrLD2c51N3BP29PTh90WksnkR4pJVReSryCGWtj2/2itAG7YMlikUK/NHn3DhgZwfxn5tcZ46SBJUvbaS55G/dSTCa5wkaGHejCL3WPYJgdJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746824; c=relaxed/simple;
	bh=u/8ukmNyuHJeq1yLTrAk1jfOwpewoWmtSMCGJkCeKgA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GbFAfa0CDM20yL7Nn9bS/S5fKMABZEdSwHfdlMaCmjvwGXuUFJUt6yJCIuih0PwF61bU3l2n7rMhEOShP4IIbsziiVeEz7M6G/fNWlcv90RKWPgpGJObAxEe5c2lLE9pyCmg86EqFtFjFlMFNFzRYO3EdYA3so/+WGt4gvIuqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DunpMee1; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6800a9505ddso53028296d6.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707746821; x=1708351621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1NYPp7LJsv27i51BVf4UnYo4W+6UtDpAS1wViEPxBRE=;
        b=DunpMee1ItmCeiIoz3VchIhXMrP1FdcHeJR7FCscbcz1EHkaR0fPEr5a2IsvWjYSL6
         qOjCnKSJaKUnsFBiRzL5uqrHhUAFAtuWad/UTZccIHRvIwcZFbnuagvqQfnvE4vTGpp0
         KF0S3bZT4Jg3JHnqJPJiYWAhKnSIqK072nFY+qbYD3vb5iigSrV5/Nlng8jz1pynQhpS
         w24rDfu3ooTadFLSUruHtVMA0Q/+6gvKR8GPjTO8cCfAnKOe7EQ42x07kLA7IlJKKFjV
         pczSin56+lQuiWwU80/CnsTTgzUf1VUrXo0d9m6o1ntxSLGE4w+J6I7NXEgyD5FK7CAy
         dx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746821; x=1708351621;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NYPp7LJsv27i51BVf4UnYo4W+6UtDpAS1wViEPxBRE=;
        b=lIjWfplv8yONaow9jRyCst4n+iSk0vuQkv0nxUt/gH9OkhhmBt49JalGj09v+VDqiQ
         QDKivUr1OG7YkPGQSmKmwXUWaLmYw/l0npKfmwc10Kfz/hDa5212/ciFgIwXREpwm3ov
         kPqu3lFOMmqX3G6r3CBHaDxhlYM3qqMt+uLqw+OF0am3Q2OLKPdgr/uIrk7vCxOPQRT8
         5VlGhQaec6ouO3v1LBj0wnFZZlumqr+B0TJOlYsk7hO7bn4DAcwyqQXHe46eNidQuB+o
         ZQLv/1XuzhtZSSsE4si5fPggRjJ4sQIBpz/Z/Mtr/tm1lykr/Bcj5fRVvE8jkKM1Rk7d
         lzNw==
X-Gm-Message-State: AOJu0YxH0uuVPjXMtD6M167xM73je52VBettiEjnhkTzDW8Fs0wrA1O+
	vpxJkwZQ8Az3R3IDwesXCfq/nX5mm8IF9C7Q2ZFVJxQqhXYvAvLfQxVAqgSnI6f4U73McPyi7K5
	9tF9UM0VOlg==
X-Google-Smtp-Source: AGHT+IGrvDekNWgCplCylK2IjQQInqg5sEkiT6Av/HV2vCFl7sFx3L7HAGCcwU1UKQh+NVNyQsmPb2NTBLaTOA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:1804:b0:42c:5029:9bfb with SMTP
 id t4-20020a05622a180400b0042c50299bfbmr28098qtc.7.1707746821596; Mon, 12 Feb
 2024 06:07:01 -0800 (PST)
Date: Mon, 12 Feb 2024 14:06:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212140700.2795436-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] net: adopt netdev_lockdep_set_classes()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of waiting for syzbot to discover lockdep false positives,
make sure we use netdev_lockdep_set_classes() a bit more.

Eric Dumazet (3):
  vlan: use netdev_lockdep_set_classes()
  net: bridge: use netdev_lockdep_set_classes()
  net: add netdev_lockdep_set_classes() to virtual drivers

 drivers/net/dummy.c            |  1 +
 drivers/net/geneve.c           |  1 +
 drivers/net/loopback.c         |  1 +
 drivers/net/veth.c             |  1 +
 drivers/net/vxlan/vxlan_core.c |  1 +
 net/8021q/vlan_dev.c           | 24 +-----------------------
 net/bridge/br_device.c         |  9 +--------
 net/ipv4/ip_tunnel.c           |  1 +
 net/ipv6/ip6_gre.c             |  2 ++
 net/ipv6/ip6_tunnel.c          |  1 +
 net/ipv6/ip6_vti.c             |  1 +
 net/ipv6/sit.c                 |  1 +
 12 files changed, 13 insertions(+), 31 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


