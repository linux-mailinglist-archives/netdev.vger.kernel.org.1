Return-Path: <netdev+bounces-133096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D091599494E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E37F1C225C0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7F1DE8BE;
	Tue,  8 Oct 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H56mVSIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7717B4EC;
	Tue,  8 Oct 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390103; cv=none; b=MhV526qRF+V+u8t+JEykgbZGMLeR5zC4OmIfFSjcGAaD2ptwsV+52kuZw5MDNHuNxLQs1EnAvfosJgaP1PkK0Tf3uAJ4/VaUwSne8rZEsHrcOzBgmeqFSL4XtvNcxjGmpccbDTjIHZZyl9U3QA07a9DMPwZa2NxtxY2Pf0+iwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390103; c=relaxed/simple;
	bh=MrIcKIS0Evz36ZFoiu/9TvqvSUU6T41eriIKcHrpMHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkZt7fhIKXqPGNfAZiRoAnHja0jM5OiTzhkAwdcpIf8AhRyxIZnl9HI0ZNuDONbIX8CLXa8l73FdpCXXEypQ6ubEBLFcHhNPlGlE+LVO11PPq9H3tpZ5BnzVbJuir+CNR5e9FSLpb5PDKck9yvia9B3AOPiyPteSo83Sgx8rU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H56mVSIK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ba9f3824fso41799365ad.0;
        Tue, 08 Oct 2024 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728390101; x=1728994901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCa6kmV4QTjRycyLJwNG+vYH5BbjeTSDnzebKHNVPek=;
        b=H56mVSIKdKMn3rwunLLCFfWK6ohxaz/j/bb2BfuYGdhu7yMGZjice0bcdlozdEv6QK
         dbo5WGpJXiJPXX39jJPZLPMmPQIVkcDvfyBKs6zkn6YFvBUQhbJvzcHFLY2jWbhHr5KW
         gvLRDSWuwyU2uza2EFdPkqTF4t8x60UY3SbVpxlXA3NMGBwshjWA8LkjPnDtqHF4ohVq
         QkPA1O9xAI4BovC/nUA0rirpRd++CP6dbyIYhdIyIX2Ld38gTX5ah5v4GER+MPVYix/r
         igi67b235c7GwA510qER3CLT8ya8Dm/7FsLZHu7j+MeTQeVipfURn48BYYhMXyz1l8Mo
         Tdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390101; x=1728994901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCa6kmV4QTjRycyLJwNG+vYH5BbjeTSDnzebKHNVPek=;
        b=NAMjB1h8ws4fv6kCzJrkdWcli2Pt9lcfjSfc6Rzmbs3xFvdbsd4nTN5DWMCFsyku+h
         FsF4Vji32Y5r8ur7Mld0ceAbaLDIh4sdJiK2j0bHyVICknKYZ0TUP/yRexGQFlIGIUje
         SEzOSfzvUFrIohT9c7ozAQ5Gwfn+M5Jrt8a0lOGm0NX6MS5GYcixJVVOzjUZL8CNRvdJ
         b6ctkh9jQ4XRr+r9Kl6Z7+8jHIM0EgiaTvrop1J9hLh50YU+mnKnPyxeQInAw2YNudGx
         WYafHycLy/dQuvUQ8mBhgpFhYRsNQry7Je1EgjDev0XLEzi6aiW/mvFmAevuMbI1l52i
         OgSg==
X-Forwarded-Encrypted: i=1; AJvYcCWJHBX1DvUp3nlJWBHzhhjVQJ+G7IBHCIdm4Pd14B+rKHX82NigjXhegkgkItkyDUqQVblQwkUMOn/OQ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeVjI/rBruszG5cu3ktgF/nPlOnQlKUKpXg6HjeDsCk1i/4Yj
	G8Qgl2Qz9eno3WkLFHk6whxEuS6VhWAG4Azc+mHYF44suNkt8Rs7BijtyUIJ
X-Google-Smtp-Source: AGHT+IHBHW4p9FEvsAO12tU7TN1E6sF/r7xuVW49nAnNbNJgdINWhFMHHnjIFX2+3HY637Oi/WeGyQ==
X-Received: by 2002:a17:903:22d1:b0:20b:8778:27e6 with SMTP id d9443c01a7336-20bff04d064mr231570345ad.55.1728390101123;
        Tue, 08 Oct 2024 05:21:41 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393175csm54737175ad.140.2024.10.08.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:21:40 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/2] netdevsim: better ipsec output format.
Date: Tue,  8 Oct 2024 12:21:32 +0000
Message-ID: <20241008122134.4343-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These 2 patches improve the netdevsim ipsec debug output with better
format.

Hangbin Liu (2):
  netdevsim: print human readable IP address
  netdevsim: copy addresses for both in and out paths

 drivers/net/netdevsim/ipsec.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.46.0


