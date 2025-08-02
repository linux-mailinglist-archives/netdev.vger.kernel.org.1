Return-Path: <netdev+bounces-211443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B5B18A7F
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118EA582D3E
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361414B959;
	Sat,  2 Aug 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JanEMQiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419828F4;
	Sat,  2 Aug 2025 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754102806; cv=none; b=dJ/336Ke8bzUmT/87PwHlBLcVBtCyqmMcS4F2EhrHRnEPyxGBNx+MlazASAl/PH+8JmpX+KJV5R/lu0zD6NMRkMlcMfMAeVSvykgoIdW+gGyu+rBvBgYlCQOYerJorVD+vLAKh5xpb/U4WibrlMxjryCzzJWTnDmVrPz+59pNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754102806; c=relaxed/simple;
	bh=V8HN6nHkiIkes1bKZuZo1aBn/XY1HKbA8UnHUqew+Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQQxNnqXKcMVuX3C98qzFIK2dfFq4EW4ykapxVmgG+/1kY+TRUWrpLB4N8/YIWoIQSrMwOD1au5LPM0FMK7ZAWOArCYNyuCSCDCa0AEYyMu76xqkSsXVS03pOOv5yw1Y/BqfTdovTXb8C6awc8Dm7r24UZZ+qKPm+u+z2oqMKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JanEMQiN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4561ca74829so16416395e9.0;
        Fri, 01 Aug 2025 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754102803; x=1754707603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=23JABqC4naVgFQUTxrfo7m12otbYgcHZa18x8mg3fHQ=;
        b=JanEMQiNddog8xdU1GnSqsKsxcnjmzm0UXZKh3Tk3UkPRn4mQczKqLkGA8F1TawIPO
         1NZ5f0FN0SkIA9fEW1WusDkSuUc9rtJM9QlinYIzBve+NIol+igmJW/xQrtkCnHFQjm6
         5z3p39rRQiiRwj5xfIZE5qxsDt/+ZfNjUEJrMmIvYNc5xrbjvjGS0YDos99DOFFkdi4I
         pgB1oD9WPwGN5MG5XDMiY59yUiK0hfbRPXEnkyHOm6fGLTAMwXEjZu5qQlbgNpHjTX0I
         NShl/fof/ZSjj5lgoj7bstvNI3U7kGrjukDNiyDb4s80y78g6u/fwcSAiOdkt8eAuMYZ
         1dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754102803; x=1754707603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23JABqC4naVgFQUTxrfo7m12otbYgcHZa18x8mg3fHQ=;
        b=Etx+kilQUgVJchK4V4sKVwimIqpNImKsU/nPYkHn0dIQ6excuo2lu6eMb1B/3Pzjbw
         q/C/ZI3D2vU+VsIsqN7Ho8IOOpn22dCNlgOcah+41V67jPM73fdCA//TvkUy6iuaC8ru
         e1pG6ozz877dSeK3YtIil9cyb8NcElTxelBo8atmDKvSAHtCpjhAVoVMOrbPdeVFhxU1
         3/Z6s4tKTB2KuCpM0ndb3ptJZxooic/OhsP5A+eblqJqSmnkJ8rEqNEe2WJbL4SwKwyO
         CTS5HJ2bUcFXO1BTFSv0r1wxGLc0b1Mrvzhrbs/6eAfguQN0y/LPmtcQiODfCX6ajpWS
         zMtA==
X-Forwarded-Encrypted: i=1; AJvYcCXqNO3ldudVj1B2lkuYYygk/JEo2IGskLIw802sq8svI8zCwGNHVhfs2ZfmUYfzqfBNqiwLh0m/0auWWLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSlYD4CWTWIDK7nzXXktbEXZsyH9VCsRT1hDhgQgIsfG+kool
	wkENxBUWjXR6yS54c9eoSnd857aMg6BxuDYZNXPyjTiAzs0MkZGp3W/etXZSLQ==
X-Gm-Gg: ASbGnctqUYkSjs2NrffDCSXHbjN0nZueWmCg+Hert+dkkRg+i3UmkzTQwxOWnH5tOcS
	9EHQS/lcaZyxXBWNOl6TyGhyoRcwVJlHpj/lMhmf/UHPHB8jx30zYwkh5HR+vc3J2CLExOvHw4f
	W/JyVOxnWdNYfdoIZYzmHRxCuOg70wikcK0Lv9L5xwwRMV3hDUXO0bWK1aYJ8BRQxA9DEt7DiLR
	0IhO2p4SzVcAsMh5eiamJZ3T0ET5hQibaL+8cGnXq8rLY14Vq4UPkjKLza81SToRD0QFOe6zmMI
	UkmYZ909gS3zebsbbAhb3096ESmWLwK+TsnpmPpuQXLc73FulsHpeQaeL0Xen+9H52Z9eLdf2ox
	G1r+5m6LPCodUFTjVaZ4D
X-Google-Smtp-Source: AGHT+IHQ4pP/o6oRkUMi+DSR8MZSBz54FmupJoYd0rGjmxWW+UZZIootglJRf8x9lFJh+kpr1qmmvQ==
X-Received: by 2002:a05:600c:4f14:b0:458:a9b2:d30f with SMTP id 5b1f17b1804b1-458b6b584c4mr10664805e9.17.1754102802604;
        Fri, 01 Aug 2025 19:46:42 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf5683sm85151105e9.7.2025.08.01.19.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 19:46:40 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net 0/2] eth: fbnic: Fix drop stats support
Date: Fri,  1 Aug 2025 19:46:34 -0700
Message-ID: <20250802024636.679317-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix hardware drop stats support on the TX path of fbnic by addressing two
issues: ensure that tx_dropped stats are correctly copied to the
rtnl_link_stats64 struct, and protect the copying of drop stats from
fdb->hw_stats to the local variable with the hw_stats_lock to
ensure consistency.

Mohsin Bashir (2):
  eth: fbnic: Fix tx_dropped reporting
  eth: fbnic: Lock the tx_dropped update

 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.47.3


