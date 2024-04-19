Return-Path: <netdev+bounces-89754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8A8AB716
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 00:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361CD1C2096F
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 22:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5B13D25D;
	Fri, 19 Apr 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="1+I85GYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF312DD97
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564549; cv=none; b=hPLw6kYCwkNxMcHe1pe6DfTBhrAKQZte/BbXi9esi/P3WzAuLYLVbFxk8XR1+PEcTTnTYms9K/UZsdMM63tLbxhYbQYnImDe7eoQPp3Ppy+UTe5ylTL1d3fYlRuuSPx6tZ7aMoI5syA8M0SVfx5AFbqaJ8MIoOeLS5fW+qfJ3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564549; c=relaxed/simple;
	bh=VGR1gj7N54vbye4Vtd6cav/1bI1OT0ogCezON7IIcFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxj2JuZUjXMVHOJGLaDqX8B/gfQx4Tx6PTSD5J3iw4gpTHKjpE/x8P+DLsbKGea8BEAHnTwPheaby6TkHpeo2w7OUTZu/MvEOZ4QvCdPcEOoXUwUSVjUSEf93tmsAOJmvITHSdBCVNNst26yBLPdl2bho/mNczcuXwEv9Wjy9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=1+I85GYP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e50a04c317so15454205ad.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713564547; x=1714169347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPqKRDY1EPX0rzokeC64goypKDPVXVDJ7KH4doMhHzo=;
        b=1+I85GYPqGkAZBC3kOclmKQfbv+3iKLMvo5MfdHF1IKpP68Hna7hyxEgB5utw5g3wr
         Vq0BMtcp5Mx4f5SlCYlT0Nar4jafVUiVEmx7qMd4YfiLw+kw5srhwdYNoY/3siNQz5dm
         2UQqhUeK/fQCjnm/HSCN6GP6GycOFwPpwCO4VCZpVqXQkks8/ZOSD8gWG50AfOqdrsXc
         fi9G8r6ng9TXh16iZb9wjJ8pyv3sEgjb0c6rLRz+tqqP8cEAVmzF8gpNtfYJZ9HIRW0f
         1dCPU/ECAaLt3uuRi2z0CRi2f+dKO2YQDdrEIdTB8iCnfj/c3DAFkzuvOaP1Ef/FnhBG
         JN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564547; x=1714169347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPqKRDY1EPX0rzokeC64goypKDPVXVDJ7KH4doMhHzo=;
        b=kY3zuHHgm96c78XL8G3VHej3ikFK+BkoxhAccxdOFQpqSnsa0WieM/BpOAUNOgzq4d
         FL/KuU5zr4QRc1uAZrdY6hGEd31yXYvFUFsncpXQ6LGBpDe8rA1YFLAhuOfPmaoxWFkx
         WeJOyht4x7GZ5hUMKnB4zxYaqxmCyR5tv9J4pDx91PpJ0okwZIOaQxVvlCc10p9ZGRbZ
         bM51zUZvFapje5AGXakMORsIUX5Y+ZLvnTujesCUCCNAzdnsCwiTjJLmpwDGGVqg+NYo
         LI/iOSCnhsLbMLbqAqZSevx0+syRTEDIZX6PkYUvWwVtHbAXcjgWFkHCWmQj8b+WE3vm
         TD9Q==
X-Gm-Message-State: AOJu0Yx/qBExn7R6oJRYm/B95ZubyXAoFZXuOB6gpNecCiHoIxsrx3YF
	4j71sZ6wG29HFpYCcPOTpB0How34SSMA1iN+zt7EjLZU85IIN3GxpqQdv3OSpm1dVnsCFmqETv7
	i
X-Google-Smtp-Source: AGHT+IHzqX0LXblKjFJgJ5aX0+NpYCyZqujRt95rGkKO+gGumyajEGuztgMoYRW2UksE20dg6lyPPg==
X-Received: by 2002:a17:902:c952:b0:1e3:d4eb:a0f2 with SMTP id i18-20020a170902c95200b001e3d4eba0f2mr4270127pla.51.1713564547405;
        Fri, 19 Apr 2024 15:09:07 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001dd578121d4sm3844027plk.204.2024.04.19.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:09:07 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/2] netdevsim: add NAPI support
Date: Fri, 19 Apr 2024 15:08:55 -0700
Message-ID: <20240419220857.2065615-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NAPI support to netdevsim and register its Rx queues with NAPI
instances. Then add a selftest using the new netdev Python selftest
infra to exercise the existing Netdev Netlink API, specifically the
queue-get API.

This expands test coverage and further fleshes out netdevsim as a test
device. It's still my goal to make it useful for testing things like
flow steering and ZC Rx.

-----
Changes since v1:
* Use sk_buff_head instead of a list for per-rq skb queue
* Drop napi_schedule() if skb queue is not empty in napi poll
* Remove netif_carrier_on() in open()
* Remove unused page pool ptr in struct netdevsim
* Up the netdev in NetDrvEnv automatically
* Pass Netdev Netlink as a param instead of using globals
* Remove unused Python imports in selftest

David Wei (2):
  netdevsim: add NAPI support
  net: selftest: add test for netdev netlink queue-get API

 drivers/net/netdevsim/netdev.c                | 210 +++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h             |   8 +-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/env.py       |   6 +-
 tools/testing/selftests/drivers/net/queues.py |  59 +++++
 tools/testing/selftests/net/lib/py/nsim.py    |   4 +-
 6 files changed, 272 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/queues.py

-- 
2.43.0


