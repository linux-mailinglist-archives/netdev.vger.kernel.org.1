Return-Path: <netdev+bounces-83715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E048937E7
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A681F21292
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957315664;
	Mon,  1 Apr 2024 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXyLzwrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338CF1C2D
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711943820; cv=none; b=bKuqVZP1+qAGQdZ37OslVvKyoXWYfnuaapE0KRx9VdzDECFgTLp+Hj35Yu4WWdJ4WQ9HKtzC8nEMNyrkKhgVRXNoDN6jIZvGtR+ulmP95XZKiaLHzEzhCcDuiBR5nm/q9tjZFZR3U968+kdWrhbchgpRp4e01BIIgbjatwoFqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711943820; c=relaxed/simple;
	bh=7BzYqTcRqQTVr98nIGLGUc447IgKMCAAT0Dih5HVe3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGsY+DuAse6pGpwmtrjVtCBag6bNLZWWzo7ARwP3EoDndamXRd58jDy+fuh1cP3SlOajyMe3PiRt+8cdbht59RobaGhAhvik13hlRxFToc7vvPLu2iUAeU0+QEKeUJjJLATH4iVVLIJsvfI4SIl5Yg4sk7lZEkZzjhm/L+bMYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXyLzwrX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def89f0cfdso34427555ad.0
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711943818; x=1712548618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiYKpmpQQFvQw2NO55APHrdgM+0rk9lktxhuxQ1WrRc=;
        b=HXyLzwrX4AQ1gx8A7E14N4lUgn6DfvHAqw3UHh+wzprwiE57QGq99po3KC3Jo4JuhE
         to61ZL+CaC0J+fd8LCxXAlmWcC9bqmmeUz5hv08DIYhNe3X0t1JtS0mapThgaPX8DGEd
         AR/fziN7o8BAIJK99vTQJrxxpQCv2A7vkqJVy+KUqufhNSwxgCyH5r402LwP5T7NkqfK
         XEjqK7kOFnEf3WywYozNxLFPxlpZcn6aAGCEf8ODe0T9EHBACJqMnQEu3TVuAVzVMkJC
         BHgqCtH0pTEwYA7Qdl6V0r3TtXx3dxkh4M+GIBW4L/QvQZH+XCGV3liAbUajQUCycB1m
         883A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711943818; x=1712548618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiYKpmpQQFvQw2NO55APHrdgM+0rk9lktxhuxQ1WrRc=;
        b=A6vmygF31ugFtijoEFlgEeEJ6dYdkDJz+wsL5wHqAo8DsYNWUgpoBkRCoxANbwT7po
         mg8x6PExC2K+P5bl+o2HZGyNmm0i0mDfNlBFotBoqAIviDxDSsrI/TX78IjuqNI+xu3i
         X7D0PtlGc7EXu3Ew0rOyi/0r+ixJcZuIsA+1/jomhWZEOPRUa1uHteuoNITiqmZyIXs8
         5RdL+Q09iqb5sfmBxelm6u4sTrYUJr0rA4IgOsolV1y0etHIwPEv/whc1n0tEDuwzL1M
         PKl1VjbNxzk0j+5S6EV04dSTDl6pQy/uRWJ7hLkuHp3mzKX3Ik33mUuduUUC/HnIyl6R
         SfbQ==
X-Gm-Message-State: AOJu0YwXtBcwqJF/EINCLt1G1uBfuaqpDRcA7Vs9fU9Mfp8hMWeN6qZm
	uYRnrqO+ERfNtabKjp5BlSNJU+YueY51bIG0vp2bzBnjGWFCn8u49B1TAuRUaMHUpA==
X-Google-Smtp-Source: AGHT+IHoOdLQOcuOQYWSbdIMTIv6zw4HU49tc2dCpBGViLrl3zd/a8/H2Eii6SsfzSZvR9vrSvFh8w==
X-Received: by 2002:a17:902:db06:b0:1e0:e8b5:3225 with SMTP id m6-20020a170902db0600b001e0e8b53225mr11134048plx.12.1711943818210;
        Sun, 31 Mar 2024 20:56:58 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902b40a00b001dc486f0cbesm7660143plr.222.2024.03.31.20.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:56:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/2] ynl: rename array-nest to indexed-array
Date: Mon,  1 Apr 2024 11:56:49 +0800
Message-ID: <20240401035651.1251874-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rename array-nest to indexed-array and add un-nest sub-type support

v3:
1. fix doc title underline too short issue (Jakub Kicinski)

v2:
1. raise exception for unsupported sub-type
2. merge all sub-type handler in _decode_array_attr
3. remove index shown in indexed-array as some implementations are
   non-contiguous.

Hangbin Liu (2):
  ynl: rename array-nest to indexed-array
  ynl: support binary/u32 sub-type for indexed-array

 Documentation/netlink/genetlink-c.yaml        |  2 +-
 Documentation/netlink/genetlink-legacy.yaml   |  2 +-
 Documentation/netlink/genetlink.yaml          |  2 +-
 Documentation/netlink/netlink-raw.yaml        |  2 +-
 Documentation/netlink/specs/nlctrl.yaml       |  6 +++--
 Documentation/netlink/specs/rt_link.yaml      |  3 ++-
 Documentation/netlink/specs/tc.yaml           | 21 ++++++++++------
 .../netlink/genetlink-legacy.rst              | 24 ++++++++++++++-----
 tools/net/ynl/lib/ynl.py                      | 18 ++++++++++----
 tools/net/ynl/ynl-gen-c.py                    | 18 +++++++++-----
 10 files changed, 67 insertions(+), 31 deletions(-)

-- 
2.43.0


