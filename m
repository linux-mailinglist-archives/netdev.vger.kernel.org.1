Return-Path: <netdev+bounces-248737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CCD0DD85
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D943025FA3
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086027B4E8;
	Sat, 10 Jan 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FntSP08Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FA4A0C
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079126; cv=none; b=EOh/uVFzt8Se429rvnmXGwz/gqtEmLlt5FzW/5v3t0zGTv5WCdbmh3S4h3ZKwvWEWbSucbSPpt8BKPlanZlljwDRfRZBgVzxF5GJWzxqmkyaWsTGL1cG59ElhLhsd3gUMskR2OjfHh9EGNPRe3vrv5gnk+kL2XicLoDRULaa8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079126; c=relaxed/simple;
	bh=YpbZsCPgUtK+YNOWaJpwHQw8D9O6JEbSkLrjqbbRMrE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=impYEsGJimNQTLkAW9BvDAgATReRvcg+SaX1uWZ++RXdzoWAm/qZK2khf66QAcoLx+FcQGWZTur4Q54+0DjBYEU0rjLo94512y7miiKpP5DLZG+E33QfcsHoAbUoQ/7LyNpnG1r5W3244JE/8lt7BRZrQ2Z/U7n3Otg/3bYbndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FntSP08Y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so1044442566b.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079123; x=1768683923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lC30p+B2g5PX/MfNZDYtTYpmlqLfqwjvQthF+EF4ADY=;
        b=FntSP08YwvxcL0BuOnxibKPqK84pB7ihoMJzmQH0NfzP5OrFS4Vx827bKMY71PWFbE
         D9zkL7vxopmNgz2CbWVlMs+s77A2Ft9SULIlpLI1Mpg3BXH5hk1WpozX5IAsTJfKAoX4
         1G4BySACKv3GC0061mMdeLOKkALzcWCptp/d6BXD4nBBrMbD1k4VH4q5DXTUj0OANbTM
         QOFbFcsBmHtunzhHuZg2G5F18GLya46OO9NpaOvkOlnuvDzbqSAtWmNpEDzAhB9oK4Zn
         ROAwi/1NDc+0dqcREXrNIguwWiw3y6VE7RQr3C/NK6Tf13IHsfp80scRs1x/pKvdj4h/
         vpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079123; x=1768683923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC30p+B2g5PX/MfNZDYtTYpmlqLfqwjvQthF+EF4ADY=;
        b=g33qtBUz0ca6ARV4F3ZmgoFsKvjVoOD3lt37wCb0ja+pcDZsGr0cvSIH5SfIVJR2fD
         AQjWua2cMsTmkRwypyu1cen/eLy7Y2aTEMaKgJtgBDeJiSTrujeXmUS/KE088Op5jaSD
         m+TzsO+uvymZYuQqG7r+b1RfZoOwJ12UlIc9E0Q7uMsmZLJWJFI6y9TIkp9VLncNBp8F
         Wj68YZSQfVgPv1rMpQErYUHNc5YDgjv5CKxuWTM3XQygElwLIeNDT3qq5az5y+sAQgL9
         9lEN8PIfom9mrsTW/57SllxFD0413QlSVX95e809PY1+jp2mjryda/Ip7yBTeojYPWG3
         Sphg==
X-Gm-Message-State: AOJu0YzEUFWAtYl8+4k+W1+98Zhx3PcHpWREhTYhKHSynzOv4bwFn2T3
	IAri32eNplrda9o8q+kc2Kg27ZQSgi8QzJ9rKg0XMriDaErc5GQQ9uIsljCdmnxhG9I=
X-Gm-Gg: AY/fxX7UD9J4+81yRFxPPyZMG5gmZ2+cxuUPFlzitp74AIC+TAvmepGmhalnIXNOJPP
	DzNaHZRqe3qS3SF7PqvjUHAYi520UWNMgMPt57864kUaWngF1bin5plcS2jKO90kGanSUYUutGY
	LjLuKdYx+ky1T7laj9OwAWwqQE1tv7iUbk52h2fue6KzCxH6eHRR+Rz19qJ4nThTuVm97fuU+62
	LdNsG5MiG/j2mwNY0skI2/96gqA08ACbL0I28lz5UZfHFhx3crTtdi4/YdtfQuRq47zsbTIKRmi
	0qO1KZcalK6z7bTSqSfk37JUo3c3vGQvI6n1+WexF2iX0KLZqKIAB/Z6W+WImtjTdNla1xC9Foz
	1KfY6zYH3y9n6qZV22mvs0mdHSiDyPkvviUwxZXRPQXbG8jI2B+aKLCq+3L9wZfIZUgooNrx+yu
	6iXKhVrDYrEkdc+xD7K2zApUBYEhudrkOw2kX+0jd6fmbyLVxh1UmuVtX1Zlw=
X-Google-Smtp-Source: AGHT+IE4AcfstCcru9GHC8O+sbKkpLiZU/SVJ2RJZTUoj4FwyqUUl6TpJ4rXM8j6vltoVQ5e62sCOg==
X-Received: by 2002:a17:907:9802:b0:b7c:e320:5232 with SMTP id a640c23a62f3a-b8444c4ce48mr1225722466b.5.1768079123136;
        Sat, 10 Jan 2026 13:05:23 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm15151666b.56.2026.01.10.13.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next 00/10] Call skb_metadata_set when skb->data points
 past metadata
Date: Sat, 10 Jan 2026 22:05:14 +0100
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAq/YmkC/x3N0QrCMAyF4VcZuTbQzDLFVxEZcY0anHU0VQZj7
 27m5Qc/5yxgUlQMTs0CRb5q+s4O2jUwPDjfBTW5oQ1tF4gC2vOKL6mMN50/08Z+Y+LKvUnFgcf
 RMCY5HONeInUEvjUV8f7/c4bsWZa5wmVdf8VUy+aBAAAA
X-Change-ID: 20260110-skb-meta-fixup-skb_metadata_set-calls-4de7843e4161
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This series is split out of [1] following discussion with Jakub.

To copy XDP metadata into an skb extension when skb_metadata_set() is
called, we need to locate the metadata contents.

These patches establish a contract with the drivers: skb_metadata_set()
must be called only after skb->data has been advanced past the metadata
area.

[1] https://lore.kernel.org/r/20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (10):
      net: Document skb_metadata_set contract with the drivers
      bnxt_en: Call skb_metadata_set when skb->data points past metadata
      i40e: Call skb_metadata_set when skb->data points past metadata
      igb: Call skb_metadata_set when skb->data points past metadata
      igc: Call skb_metadata_set when skb->data points past metadata
      ixgbe: Call skb_metadata_set when skb->data points past metadata
      mlx5e: Call skb_metadata_set when skb->data points past metadata
      veth: Call skb_metadata_set when skb->data points past metadata
      xsk: Call skb_metadata_set when skb->data points past metadata
      xdp: Call skb_metadata_set when skb->data points past metadata

 drivers/net/ethernet/broadcom/bnxt/bnxt.c           | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c          | 2 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c            | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c           | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 drivers/net/veth.c                                  | 4 ++--
 include/linux/skbuff.h                              | 7 +++++++
 net/core/dev.c                                      | 5 ++++-
 net/core/xdp.c                                      | 2 +-
 10 files changed, 21 insertions(+), 11 deletions(-)


