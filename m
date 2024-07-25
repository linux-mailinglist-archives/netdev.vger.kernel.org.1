Return-Path: <netdev+bounces-112940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694D93BF72
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8880B219AC
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC16197A7C;
	Thu, 25 Jul 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VbSsezv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86197197A77
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901369; cv=none; b=jdfWpvDgUMrjmbOPzKZkTaM5Uo8SWUUnV4w8MSt7f/ajWKJZeP8IwqJLrq7gN62Ij7u5UyMl9X13zOLJF0U1WBtAwJE5DPu17AmU8tzmVgMXLOPttOu+/aoyoX7zy7+kOM/x0ht//jXVspleYQOkAYK8OfRBRSPYs593qkIruvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901369; c=relaxed/simple;
	bh=+OIqBmJoGz1XxpdVsaMHS322ySwy4JJdHRtFiijt92Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QRj4wJzTQEZwydqqJmPaHv01iDSDUdKJRPqxJCL//pIXoGCGPDeXdOZqfwE0g2xQDoz5ME30K8oPOz2nUTJlEfT+k3+EGrvbtTyeWH86eT9dQ2DTRPAxTpBiUDxoQ9O259+rV758H9xEPJaZPUUZsqB7qEyGIRfRGlkpy6bjkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VbSsezv7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so781779a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721901366; x=1722506166; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmFtdftxbi5uXANrCeTOaJsmhJhvhXxqeLNdYaVB9KE=;
        b=VbSsezv7MbK+Z52JIlrlR1M7B4j/YuazOOlVBmu8FMaZb0LtxAkK6Oddphi3/oEyDK
         hGkJ+lWPHTBnY+uz9sxTKZz80niBbA/CYFrG3rvTpN/lz0zCC219hj6MLrAPQqH38Lhr
         iveLfAYuoYO7Imj23se3Rh02niqkTBZH5z74o4G94fSxL4v2CBZ2pfXiqshVp+/zxmKS
         xWVmz8wefnrrEC7YyxWX1RtSq/A5DZuVB0NtwHl/8iHIdHaO8URfgKL7QDnTJCNS2fz5
         E7tbvEMH5YF/x88Hg/NaMfMWzqfsxEC0iag+0se+zJv9RQy8FVvs82rgEYKUt0zz+OS6
         foKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721901366; x=1722506166;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmFtdftxbi5uXANrCeTOaJsmhJhvhXxqeLNdYaVB9KE=;
        b=RpmxmS+blXAIXU0KQ6nlbGtbmu5b1JSOr4wX3I4tOCRQi+QNGaZduIqBqWh4XR1MLq
         DCgx14wkJmPLo7t9a41W9g927eUNFn/5PuweIxi/GJ9rsw4IHaoFtvs1B4xYCS1N5PRM
         nSjsetWk5dUP8JuFb1PAm0utNdo7hlSMrIxSAWXdE3gVkhVo7bUeqedHOCU6Z0/sCHqL
         VVEuIBYXD6BaVYPrKY8jS6BQMMatUKYdGL4rO7aM4nB+D8eMnFIedKOhB30SluUS65ES
         +Q6SJqJKiZR3SK9Q3pgGGMYSTmTABPMQ+2TNkJf1ZpLtqBHSkWCYDE2nhePsaxgYXxxZ
         jvIw==
X-Gm-Message-State: AOJu0YwkQ838w7UqqmhAEXSFAA0gFotwbhmF7r5o1LHS9cIXN9XLLIoK
	Z+YB+ajn+hGcwIOIclYSbnkw+9tErN9JrkRBogRwIKKQG/vOGy3aQi/cAj7fcKo=
X-Google-Smtp-Source: AGHT+IHxIBEMwg134tOeAdgqCtkp5ChdUeBxDUeQBABmYjvmfgehSTQRtZ6ESLcBEz8J40uW/d2qgw==
X-Received: by 2002:a50:a697:0:b0:5a2:594b:be56 with SMTP id 4fb4d7f45d1cf-5ac6358f490mr1115847a12.12.1721901365834;
        Thu, 25 Jul 2024 02:56:05 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac65783561sm637430a12.92.2024.07.25.02.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:56:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net 0/2] Fix bad offload warning when sending UDP GSO from
 a tunnel device
Date: Thu, 25 Jul 2024 11:55:53 +0200
Message-Id: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkhomYC/x3MQQrCQAwF0KuUrA20Q4vgVcRFdX7GgGZK0opQe
 ncHl2/zdgq4IujS7eT4aGi1huHU0eM5WwFrbqbUp7E/p4m3vHCJyiiOCBavb143M7wYk0AGzPk
 uI7VgcYh+//mVDCvdjuMHsFiUlHEAAAA=
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
Jakub Sitnicki (2):
      udp: Mark GSO packets as CHECKSUM_UNNECESSARY early on on output
      selftests/net: Add coverage for UDP GSO with egress from tunnel

 net/ipv4/udp.c                        |  7 ++++++
 net/ipv4/udp_offload.c                |  8 -------
 net/ipv6/udp.c                        |  7 ++++++
 tools/testing/selftests/net/udpgso.sh | 41 ++++++++++++++++++++++++++++++++---
 4 files changed, 52 insertions(+), 11 deletions(-)


