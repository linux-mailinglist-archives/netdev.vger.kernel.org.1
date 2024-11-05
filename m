Return-Path: <netdev+bounces-141965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6059BCCB5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3EB284AE5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83F1D5AD8;
	Tue,  5 Nov 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu8UW/Sg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923371D5AD1
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809720; cv=none; b=b9xceDWOiwVHsd/33lg6QXWT1ENlibDK74+KC3HQgD6wANhI5J5t5ZluouqcQlPF4bi7TCXaZerDNmXtZ4wbnSsG9eI2FJ3UQ81+ALVdYYzXr2gaPx7/egXBrnnMgr0eagPoEV0dQ2bTbPDAFtlA9bgXuOHOlrNmB5j8mtYpnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809720; c=relaxed/simple;
	bh=vXW6qMZj2JHZwpkQv0VsUXEzy9zjJzQkRLPoa7eK9uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTriruwtkiQjuTh14lP5Eg0/hTJ0D+0rMYidI+F1eztjINWG4/cq2PP84rCjr5TjomuhNM7dWWsnFDoD0pGkx60etmoo01nuIYGLIZF8gQox8a2mhAMZX/b/8L+OPB/gpFhHo7JI6I1rNQKAFvcOR5Z/EwAjHuGBe1avk6t4Aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu8UW/Sg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314b316495so46134725e9.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730809716; x=1731414516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCdc0xFxCOz2IMsMtc/rDdWyq6vhKa1sMbj0Qy7z7/A=;
        b=Xu8UW/Sg28RqmOQpEXoTspvuQhY4Urn6yiUj8j1YHBlzEAF8QqmAY1cbbMxyn8k8oW
         x44HiniapuhAJ3y6qN6DVoaI9JBkkPQVMxTlwdxdOUrq8WIkjD5q493F6hvolGRTZwez
         jH66R4jRckxPuYn30jdxtYxLt16ooGYGJfHOTjKh4U0mrgEsSBwhs/kWzeNz2kstoADj
         gTHW4Dx0BgsaCNG/esdF4E3ycCn0j1h66ydTzp80+K32oJbDDj84Z3aMBhrMbmOQa84l
         T1iEW0+wW4INDa5oGf/5INe14wrFoj1u4Dk79avgvAvHSRYm7MxEDZiBSjP+EAYriUkL
         /W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809716; x=1731414516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCdc0xFxCOz2IMsMtc/rDdWyq6vhKa1sMbj0Qy7z7/A=;
        b=lJmDzpgboZ2RG+0/pYUa2vUzq2x5a/sTK3Q0z/4iNt5Q417IfgktlNJcll0H72n3rA
         u8uDbANCnQNkJmX+GZXGv/oQbJUJAQrObBnUYjadKTPATWzbhgWS3ROCwBxjh5i9aBC9
         ZpnqPFRoTvI/iXqjpnyIzELlTCUGPHuAspDBUyXebRkuQywST6HlOvAYoYsl70uXtGk4
         qD/BinIWVFcZ5qwldE2I5bektLiN39fHhF7vs1BHiXM+HMvBr8pk6At0ob1gDhX3MgRb
         q/o3wpnmv36xajXeKyeGquWbeVoC1T2WPzwNKyWuccy8oFqN2QnVYyUX+9miZOrooTsT
         vIJg==
X-Gm-Message-State: AOJu0YwHleGNIa9XJhyhuncixhHsam4BSC/dPHO0r1VDLTPGjxPLMyZD
	LLl/zNilEiU+e3k9/pGfj36I5IHt3CW3ttF5HpvKHRdxKeTjltjMUZNOZiN3
X-Google-Smtp-Source: AGHT+IHjkemWoVy8DuoHjtmWAB1Q0G6ojVP5kPMh4QZX6niW6Q3Gs/4Ffl3Pa/9GPunwP0Cm5+ionA==
X-Received: by 2002:a05:6000:270b:b0:381:cffc:d419 with SMTP id ffacd0b85a97d-381cffcd7d6mr8032268f8f.36.1730809716242;
        Tue, 05 Nov 2024 04:28:36 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49c9sm16137029f8f.37.2024.11.05.04.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:28:35 -0800 (PST)
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
Subject: [PATCH net-next v2 0/2] netlink: specs: Add neigh and rule YNL specs
Date: Tue,  5 Nov 2024 12:28:29 +0000
Message-ID: <20241105122831.85882-1-donald.hunter@gmail.com>
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
 Documentation/netlink/specs/rt_rule.yaml  | 244 ++++++++++++
 2 files changed, 686 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_neigh.yaml
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml

-- 
2.47.0


