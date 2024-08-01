Return-Path: <netdev+bounces-114981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14417944D7E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439811C22E2A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4091A38C1;
	Thu,  1 Aug 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eGOpjyRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4F16EB57
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520400; cv=none; b=sreAO/tJSInCwi0cWc/gUlqbmDXxOGFyB53y4EJhVxlurVekE6JEdJldw7Qlk358/XEwXwVBBdfj61iIKIzOl6A6yCqSR65NfM/Nq6dpsMaAtG/69oeODKXCuB7StnRKBe7TwejuMZZbv2KPNNapCJ0J3IaVZiZGoWhrYHrOuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520400; c=relaxed/simple;
	bh=0neTjZF4XFugD3gNMM+H+SFzITapaAfiGIvCKX3O4tY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NlFX/xqEoa+7igjSfWYp1OVJy+1ElS7KypYA73KQjQOj0NDZKA/tnlw02zH10JtLCPW5Aw0OiwpU4CU6nDVKygsVsymiZxsrY+iaTPbmx4yJ+2fX1RKYZz3hMSrtvhXPdnrRXeAQi9Rojd4nC+gJXt+SBavX08hgprEWgRgFAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eGOpjyRB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so10340545a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722520397; x=1723125197; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9FVDXUjO8EiEArKperGgg0WaU8hDDahVBH8YSFEjiI=;
        b=eGOpjyRBHbFkf1zqGZYSgFeEeooSc1Laq3NpAFlSmFlbCzTlnzjRj9urzyvU60gTcT
         CyQEPFYORX1PGxgvJRqYJ+WVM0scqkfEFHnUWWKR4sTpuxS3h5aYzKIZ7wRf37pedXfY
         DYl1c1EEKJy3L2tP2kKMFdbNGG8pcHOCuvZFIUgjpFe1VmDQwdgP5e6j6gAwKvf0ud6d
         5ix/v4PAo8OVECnfzLt5AmHTiBnUWsDv0IQhKxJLaFEDp0ypMPPC8zT3rVcimLr9txZR
         vt0UJvhTrFhHNNKS6oZiQ7Q3JLyq1D+KQ51aoJbiopMRniHlYnBvSsiGxjel6ROidYLk
         Oung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520397; x=1723125197;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9FVDXUjO8EiEArKperGgg0WaU8hDDahVBH8YSFEjiI=;
        b=k5Cygg19Le25S756/rTCxs1CODnCkeurqQ2zTXZiOLsZhP8LgWDGZx1sEbkRu1S/5n
         w8EwrnK0aDgdpGIA+2oZOZ9u+ZUTzWPQ13V4mudO2yxeBrdMnNXHrxLoR7v8XslWxp5x
         zp7oaVP80vJ9YuoaLgE1MKkJQYeRn+Tcwe9gxRPJgiHMoF0lR79XrDgQq7G8dApc/3DP
         9mIlNsAtb+rUN2N9zL4FfIyuGgN1+JphGJePP6YsFc2i2QgCyEASDN9+BQGwoth9oBkr
         WcmXrtMzOedURqrcuH2QSyuu1+p4UxJwFK3mm8VF9Lj5k/M0robj98VZQHq8Tr4oZeJ5
         QSaQ==
X-Gm-Message-State: AOJu0YxdEQauQ7SItUWLMMV/GQGbAxRO3H2vrv2Edn5sLNuqkEiHfw7g
	RN4w0QlBNztxcPXDkSY+VJAG9GVyK00+59nz8lEufWByQ+OK7FvI69I0p+jdW8vWlJ23apqjR4K
	6
X-Google-Smtp-Source: AGHT+IFN5Z0vWSZfQnGJgZ6B0a4bTFrWfAyc3qtkHbC4VGXA64/1I5vvJhttVcu4lGitEAZTyA1U7w==
X-Received: by 2002:a05:6402:40c:b0:572:9962:7f0 with SMTP id 4fb4d7f45d1cf-5b7f59e1fd7mr266949a12.34.1722520397348;
        Thu, 01 Aug 2024 06:53:17 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63593a8esm10197933a12.30.2024.08.01.06.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:53:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net v2 0/2] Silence bad offload warning when sending UDP
 GSO with IPv6 extension headers
Date: Thu, 01 Aug 2024 15:52:52 +0200
Message-Id: <20240801-udp-gso-egress-from-tunnel-v2-0-9a2af2f15d8d@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWTq2YC/42NQQqDMBBFryKz7pSYGgpd9R7FhTU/GtBEJlFax
 Ls3eIIu3//w3k4J4pHoUe0k2HzyMRTQl4r6sQsD2NvCpJVu1F0bXu3CQ4qMQZASO4kz5zUETAz
 j4Gp09u0aKoJF4PznlL8oIFNbxtGnHOV7Brf6vP5xbzUrNjDmpkrA6ObZT3G1buoE1z7O1B7H8
 QN/RaDPzgAAAA==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
X-Mailer: b4 0.14.1

This series addresses a recent regression report from syzbot [1].
Please see patch 1 description for details.

[1] https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Contain the fix inside the GSO stack after discussing with Willem
- Rework tests after realizing the regression has nothing to do with tunnels
- Link to v1: https://lore.kernel.org/r/20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com

---
Jakub Sitnicki (2):
      gso: Skip bad offload detection when device supports requested GSO
      selftests/net: Add coverage for UDP GSO with IPv6 extension headers

 net/core/gso.c                       |  6 ++++--
 tools/testing/selftests/net/udpgso.c | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)


