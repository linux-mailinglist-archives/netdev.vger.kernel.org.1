Return-Path: <netdev+bounces-138060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95F9ABB92
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB12844C8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658F1C28E;
	Wed, 23 Oct 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw1fRJkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C973EA83
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650732; cv=none; b=n+RjaFP0iOF7u0kqpB1hz6VXfpvlDM6Eqz+K7egFVX/5wMDPB2Xd7O24r6W+LPa1E4ksYrCAf9cTVfMCcMmia3zrfE74OqIRWEjb6WfYeeN1shJfjl0gcVWFT1/ziz5u/DVniF9carVemXAdF/SfzfkGQd5YBGQn3oReoAFsuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650732; c=relaxed/simple;
	bh=E8VqgTt0snRY5G3+0rrQLeoc9QMTyZ34qgCwTqB2/f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/VuK1z7TaLpk4dmQRhXFuHbijhCOtARCgwslOA97pE+tNdK6NzPqNAx78R9lqBAWANIzYtbxIKM6VjGjsT9sHKg1K0NkCNqzSX3OjAca31Z+j5qEXscR/TNZ80RsYDsYpnbnSnAD/ngiKIIMxIOhwEDnz2pg5+8JX1VqTpIXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw1fRJkN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea8de14848so3907420a12.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650730; x=1730255530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOlOvpDHH05t1qhfWHfWnQ8WPP6EdvC73f/hucgb7T0=;
        b=Nw1fRJkNODqlKHkqX2X0eSJ4saE8HisrXFR8C0ezppDaX2Jt60RmG9AL0DBGgHWOfn
         EpkA7Eu450UFBUFkPk8mhr72NEx6Ja1VrKXfWY6GCZLUhoeneiT9skFAHa5xkGVe1iEe
         bhQ+dt/pftDmDNDEJKaWz6yrjdxh8xirNCgxEUGM/iQUU16zi7A70mZKmNjMZdjmMa85
         jgCulcnaCPfmmaVut751Je7sBdUwFpZi3huKGKYW0eqm1CAZPYGW0+ahg1Ns5ms3VYtn
         d1aIojLX9KFjsZH8yh4qrRE+qj3IomU8/cg6dG9y71yxmMnCAbc78IxUg2aQCLi0SSMv
         rLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650730; x=1730255530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOlOvpDHH05t1qhfWHfWnQ8WPP6EdvC73f/hucgb7T0=;
        b=kJoLEvaDTao9Zca5ANtb+sR3OPuS7Qw/uOSZAxclyOmvB2e4en5uGN7/b5Ko6fzCt5
         dlGwtDomdxLYzdbyMv35sx82l4yOcgAP2U9dC+INE86Dr+IjySgYTROMv2NiOQUNwaaK
         977hvLaFR2kGv7QNMF/usgJT6l+dXxFJQjZORKk0eIR0aLK+2fy1K2gKN5/FBU02ejC6
         1A3PQ0kR0JXU8wJD5A0mESH8ZRQoXrKvAQqeqBqHaw9qqIlxqJwKLHagPhXuqLdodctP
         FVvEUgXyp2JK3BkYWq3GsQAa30jh0JtNP0NrSQfW1FhlFP0J75St3idp7a7b69tJcPy9
         Ecsw==
X-Gm-Message-State: AOJu0YyDtWP0aKn1rfEVqQISMbnS4eudfFhLAd1VGyAPNDAiQE+xNDlb
	eessma+tjpOAQNNv8EOLRgKd3QbstANMljCmmf0f5Fi7amybpHfat+KMa0oL
X-Google-Smtp-Source: AGHT+IHvKKXkc7NYOw/s6wv94DM0KoY0gxhGTYFqbQCBPViNd1YSgHLaiQ0CLyIkR9SOVmZ1HN9C0Q==
X-Received: by 2002:a05:6a20:c781:b0:1d9:183f:380c with SMTP id adf61e73a8af0-1d978b1a137mr1411666637.20.1729650729521;
        Tue, 22 Oct 2024 19:32:09 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaea9386e5sm4972284a12.0.2024.10.22.19.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:32:09 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/5] net: Improve netns handling in RTNL and ip_tunnel
Date: Wed, 23 Oct 2024 10:31:41 +0800
Message-ID: <20241023023146.372653-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes some netns-related improvements and fixes for
RTNL and ip_tunnel, to make link creation more intuitive:

 - Creating link in another net namespace doesn't conflict with link names
   in current one.
 - Add a flag in rtnl_ops, to avoid netns change when link-netns is present
   if possible.
 - When creating ip tunnel (e.g. GRE) in another netns, use current as
   link-netns if not specified explicitly.

So that

  # modprobe ip_gre netns_atomic=1
  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

---
Xiao Liang (5):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Add netns_atomic flag in rtnl_link_ops
  net: ip_tunnel: Build flow in underlay net namespace
  net: ip_tunnel: Add source netns support for newlink
  net: ip_gre: Add netns_atomic module parameter

 include/net/ip_tunnels.h |  3 +++
 include/net/rtnetlink.h  |  3 +++
 net/core/rtnetlink.c     | 15 ++++++++++-----
 net/ipv4/ip_gre.c        | 15 +++++++++++++--
 net/ipv4/ip_tunnel.c     | 27 ++++++++++++++++++---------
 5 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.47.0


