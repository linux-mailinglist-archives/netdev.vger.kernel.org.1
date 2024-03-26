Return-Path: <netdev+bounces-81877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21788B78B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03911C327A2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06938128368;
	Tue, 26 Mar 2024 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVNRBgEg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C23127B5C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421043; cv=none; b=NFnCN7BIlIaSGm7X8UFavCIGmoOHVkO8vPm6uUabSswdNBWBFbjsnt52U0YI+/hNcVd922g/A4uGwp8Fgp7qb/A/DfgeELr4Ihr7p4+7M3hSYjHRrZ4Yxv/Qy6kVaSbMG53mQ4+JwSgBFaypyC/df8TFMbQGooC+0PU/UlUL+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421043; c=relaxed/simple;
	bh=N47dWlrs+41gXkXcY8+tDuv213KW76+pzAYxYvqHQZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBdv0y9iO3tI0x2hr3IcwXhwKWrJXR3h/Wy0f+60Q/mqjEfGg14y74m2/EaMWXTTPCvHwCsQ9WEktrVlf3N3tLHhkB+GMj0tVn4EGJxMfT7v4mOefeZLE4z3qb9jBAeA8QudfgTS7LEK+srh9bo0OD4qPwk1OMHe/Vln/CUW8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVNRBgEg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c731ba369so3634247a91.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 19:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421041; x=1712025841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mr3KC1upbOWtM1fJ6itKFCPFnwjq8eYNBlzYiG78J28=;
        b=SVNRBgEgTB8/auSh7+Bcf7AA20zZclwSg2hHUa7dewTtlN9eKl+rlvMmN+Encw6Iqz
         Erax7Olwph/WesE909AcdwmnX75dlIgAyQU2HErdd0d1iKL4N3FF2wYa7T/ptqYSg4f9
         S3ZKWJMWsiPfIVmt2qvaBZ1JMHctfF5vRA2urXHhbpA7Q6puXvAsIvHMHyo0Ms8zaMQv
         zF9n9c88URfMn8QAJ5cBm6XFJef3QzU75y9dkgPnTqwiewfPbScMo8F8aKUghVxAgu9f
         rsN0cZKfgae/ejvlMwozFy/WG0liFm6SaOQDLLy+p5aAFVjRN5zzXmyAZuTh0YaJrqt7
         mvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421041; x=1712025841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr3KC1upbOWtM1fJ6itKFCPFnwjq8eYNBlzYiG78J28=;
        b=f7IrXB8LIIt/YukD05rLyJxr3uapwsGb1PxWzr3J1ikirR2Ic8FN4tA3d1Dba6zEUr
         y1rbboYUK7XO1SW7Eb2nw+amlnR9JSePUc9VT+R125/UfEy53rp8LU0I5LWmLDoIg1Zf
         k0OJ+ynCJ+7CmyVg6AO6LibkqvW7EGQ9dj0Dal4GD5wTaodSguzyg/gCyONwrlI5iwhP
         +IEY8AMUL2M+YsjwZSjRfmR60qv9kK/MbVnHKp8BUFZrkEmmxqnXj1Gqb97K0hypYwbT
         2DdNVyU5Uw89jv3JOwE7WWXDE2nEwI7NJOXW+vXwyTvUJhlPS4ryJN6MCVuaHJ4Xb5+y
         obww==
X-Gm-Message-State: AOJu0YwrA9o/I8QjFrt2GJt23LA7Jm1Qh6+Eao2ubfiuPuO0GuRkGJx9
	aHv8NmMVziNJbIiVQhGOXoQeq2am7/rOLJO2hAmt+CD44hMndSI8LL/sCO5RvXE6CpUZ
X-Google-Smtp-Source: AGHT+IFX4g6PonPGw48JfS/YGzLPG20etp82d5oiPq96zBW906YQd+6Jc6pOqWlEz5VTscPdsQILMg==
X-Received: by 2002:a17:902:e549:b0:1e0:b257:3261 with SMTP id n9-20020a170902e54900b001e0b2573261mr6930446plf.42.1711421041408;
        Mon, 25 Mar 2024 19:44:01 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001def088c036sm5499193plg.19.2024.03.25.19.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 19:44:01 -0700 (PDT)
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
Subject: [PATCHv2 net-next 0/2] doc/netlink/specs: Add vlan support
Date: Tue, 26 Mar 2024 10:43:23 +0800
Message-ID: <20240326024325.2008639-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vlan support in rt_link spec.

Hangbin Liu (2):
  ynl: support hex display_hint for integer
  doc/netlink/specs: Add vlan attr in rt_link spec

 Documentation/netlink/specs/rt_link.yaml | 83 +++++++++++++++++++++++-
 tools/net/ynl/lib/ynl.py                 |  5 +-
 2 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.43.0


