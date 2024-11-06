Return-Path: <netdev+bounces-142284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706729BE1F8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBAFB21AD6
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D91D7E43;
	Wed,  6 Nov 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuwSZZHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6A1922EF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884046; cv=none; b=U12MCDv3OD1Bbqw5uHmG0xQpsGV4jzuQTtK9F7fiuANuGMK4+GcObG+Oo08kv5SLW31nc+vuz6I9jsK4PHzcHRkUDxqe4L09a3n2H375fiKAxFvyyRqjXELPVxnOgWC7R17eCgiAhFrlV0RhVyZqVyhdgmuhEMySI52e0z+tq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884046; c=relaxed/simple;
	bh=2YSBw5d3ZzVauiy65E+3NLMuMYcYDqmmu0wA0QdlLG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCxCR9dpM68O9PwpneFAtKC5C3+0JhZOHPZGABdMH695rv+AjPpAcOxHchJ9J+TaSg5ranZSsOQVdmw20ag6eQuj0wWINj5dJX4Ro/ipML0Fe246LzfiSMe4qYlYilzPOMibEiOD8XImw39eYBA3o9m2cPnv5cG/gb1A96FLY0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuwSZZHL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso50544335e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730884043; x=1731488843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eg9B1rYqwEVpjwJ4zoMRU8WAB13tJ5jB7RC8OIC8iZI=;
        b=EuwSZZHLgF8tVXGf2+TwYqQ9PnCts+HJjyBCL0Swx3V6EvqxDCZsNOos0A2bM27Ne4
         Hom8y2Di4aUIKg3VzA1k/yjHL3Fj9cmkoCMiJBGTJl0iHKLj3f0+GTmmxxFvRdM06FmP
         7/NASZjogEvJTK6JMiICBPYEsPFCoFr6KEb1ej77k3miCfa0VvaB7DafN9GII5vDtQvo
         Tj60JxmeT4rUF3VQdq62R5vlKGiCD1PJFC4KCgC5wYD7/UH4Lw9y6/g8pJh/ubckYzVt
         oghRvY0UscEq3id5H9lGbzhSf52FAJ0NfWBL6y+rZ1KGneP3i8mCbObtHT6biMqQ8Imt
         +lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884043; x=1731488843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg9B1rYqwEVpjwJ4zoMRU8WAB13tJ5jB7RC8OIC8iZI=;
        b=kQrnwesxigjOryJWa/JZdVaUupO6AKMXdi2++4RCppgy5ZMrQP5SbXNWVyofQujsfD
         iBsh+Hqn6A4paK4Hc/bNw9FtfJKiHYKJpGYVXK2DvZ9rmQ79f+VJ6ih7ss+Nr7z9jsCY
         xp8w23396BFw55ICU5PJjTAImO5DTVnEo9sYrnwjRp7+yXkQgxIrZa9dtPZo8Hvz0r9q
         ElmWI4gjg7Kx/kBIYw2u3xlG9OyBil9DQ4qZhashS/FuWlZU1P8Wt6+eeVC9bNP4zRKy
         cRaZ0Bt/nnZzR4eyFbpkdGGdkqvMlVURvBi6zj0HDc8B3j5GKvOnJ8f3pyjrs5eSSSWB
         O7Gw==
X-Gm-Message-State: AOJu0YyTv5nB+csT9nb/Sjv7rnhiXNR1VL0avsqQTGPpF5DRsmHnMCSp
	aAgxES0v2dTnAJqzRdebY+Trz/BlNOuk0JAp4cn8+8iUV5vrjAxeR72ZkkVs
X-Google-Smtp-Source: AGHT+IGWGLBGUWwgc0qoms9KYmzQA/Q4IL7OA3S5htxsVRpFAfac69faCEV8T2EuMWBL+VsyMMvgGw==
X-Received: by 2002:a05:600c:1548:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4319acadc1emr339143435e9.18.1730884042683;
        Wed, 06 Nov 2024 01:07:22 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c7530sm14933795e9.25.2024.11.06.01.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:07:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 0/2] netlink: specs: Add neigh and rule YNL specs
Date: Wed,  6 Nov 2024 09:07:16 +0000
Message-ID: <20241106090718.64713-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add YNL specs for the FDB neighbour tables and FIB rules from the
rtnelink families.

v2 -> v3:
 - removed spurious dump parameter, thanks to Ido Schimmel

v1 -> v2:
 - added 'dscp' attribute, thanks to Ido Schimmel
 - fixed types in fib-rule-uid-range, thanks to Stanislav Fomichev

Example usage:

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_neigh.yaml \
    --dump getneigh
[{'cacheinfo': {'confirmed': 122664055,
                'refcnt': 0,
                'updated': 122658055,
                'used': 122658055},
  'dst': '0.0.0.0',
  'family': 2,
  'flags': set(),
  'ifindex': 5,
  'lladr': '',
  'probes': 0,
  'state': {'noarp'},
  'type': 'broadcast'},
  ...]

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_rule.yaml \
    --dump getrule --json '{"family": 2}'

[{'action': 'to-tbl',
  'dst-len': 0,
  'family': 2,
  'flags': 0,
  'protocol': 2,
  'src-len': 0,
  'suppress-prefixlen': '0xffffffff',
  'table': 255,
  'tos': 0},
  ... ]

Donald Hunter (2):
  netlink: specs: Add a spec for neighbor tables in rtnetlink
  netlink: specs: Add a spec for FIB rule management

 Documentation/netlink/specs/rt_neigh.yaml | 442 ++++++++++++++++++++++
 Documentation/netlink/specs/rt_rule.yaml  | 242 ++++++++++++
 2 files changed, 684 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_neigh.yaml
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml

-- 
2.47.0


