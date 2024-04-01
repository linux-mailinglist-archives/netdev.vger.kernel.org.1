Return-Path: <netdev+bounces-83700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5618937AF
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA78281845
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207D7F;
	Mon,  1 Apr 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvIm+TI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D7138C
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941020; cv=none; b=ppKfy0eq1qc+dkElA0gluiJMbCKh/65ibzsW+VevEBJsyqJa9IS6+8K8e8XpTOOm6FCGOHEmhPeNp7DPXJyntCMpcl54XNOIeEobn1aMZ75jOtmuOGTPiRKAlBFVZHCRvf6Yh+AsYptoDXNcZhFE3F/btQrp8v+YpQvMDHFJL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941020; c=relaxed/simple;
	bh=O8l43z+9xWt5bY5rnvG1tYwfWpeXPDC9CRP1/JzE9Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIf8jRecp+jVx+OHj2BN/deKoujJmisvF38QjafM4A9pok7CkqpD4tSwZcZ3cJkRq16yIKqSya1ev/5BhvHUyO2jc5vczGFSnSgnsAo1HMnzhEGFLixbAMkd4yqTRzsryqP7aKPocbDivwAnjk1KO8ihWaBexpd17wCbdEzA+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvIm+TI7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0edd0340fso32694745ad.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711941018; x=1712545818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EdJvpze9KmC5Xtk4TTwD/VAz7ChnvdLi7MDLlni1Fs=;
        b=IvIm+TI7Ub7saeyAJgOkHylCZD2RQFkRjMnyBXVijuSF2cUjIRsFArt+RvuXlNjJWi
         OuTnufkKfcqhVQmEtPWZbr4a/j0kQusKfmp3KQjaPDYHwFFiyswl8FyZiKuXDzse3If1
         ZvatIRwo0jxCB6UJDzdtGGmJkrf//3ia/wsHyS0xqMhkx8yYiQyKPvkbaQEI2heOtT7f
         wFC+a99TFEzZQMvDU6boGWa+sA1uHZgb2uaCrxvhw1mZmZiu1l86dWSXeTyzWZWMDFsm
         kCUB7sYaYEqEUabtxKzvvQqIMvmN87Dx/4h8+U7+9etejSLMiI7q0GqqcsO7fCdxSMJc
         mswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711941018; x=1712545818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EdJvpze9KmC5Xtk4TTwD/VAz7ChnvdLi7MDLlni1Fs=;
        b=XQLowGNCOkbZYLEckEOS+9QQNU120kboMgTt0NyaTk6W0k8BChvW8i7VQfrEvtahoZ
         EUiv67k+hevNSNDrFw0fhbh57blcZzk8Fj7BsuHLBgURhTJK4u7ViWLDHIUyA3haYKKz
         /3QPTRlTvuO8VUJX4k01GYn3MyKWKfoZIBRlp0lQ1QqX/iwikD7uzzkxGhDeULpEh6/d
         cyD88K/+Eu4SjpE8FN5FYtvTZ5mktdJhItQsg6GEHaMzG/cL5BQpKjz2AmUR/6lj6m3F
         /uL2TMBUkSlnmZpmxErXZHaYmzjuBQGyhiDDSCkduyaRqaFlpZflqo5uSwWInTpBVzbT
         RUew==
X-Gm-Message-State: AOJu0YzbGbRU7fBHKKOz+KKbO2Kp4YbsH41fPNPu9l20RG/rbezt5lKX
	jfbYoc7CHT02Y40Wb9QjscyJRZsr3cythVn/B9+3akCz1778psJeb0EwHDq/vyQIwA==
X-Google-Smtp-Source: AGHT+IGNTcLbgBQ8XJ4oww4KAWQ2XWr9ZrUGqb1uIkCI6HNg2zkhdMangCnbSBtc8EDKuF6xZgQBEQ==
X-Received: by 2002:a17:902:d545:b0:1e0:5aec:ed9f with SMTP id z5-20020a170902d54500b001e05aeced9fmr11311821plf.30.1711941018592;
        Sun, 31 Mar 2024 20:10:18 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e00ae60396sm7807464plk.91.2024.03.31.20.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:10:18 -0700 (PDT)
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
Subject: [PATCHv4 net-next 0/4] doc/netlink: add a YAML spec for team
Date: Mon,  1 Apr 2024 11:10:00 +0800
Message-ID: <20240401031004.1159713-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YAML spec for team. As we need to link two objects together to form
the team module, rename team to team_core for linking.

v4:
  1. fix the wrong squashe changes (Jakub Kicinski)
v3:
  1. remove item/list-option from request as they are not attributes (Jakub Kicinski)
v2:
  1. adjust the continuation line (Jakub Kicinski)
  2. adjust the family maxattr (Jakub Kicinski)
v1:
  1. remove dump from team options. (Jiri Pirko)

Hangbin Liu (4):
  Documentation: netlink: add a YAML spec for team
  net: team: rename team to team_core for linking
  net: team: use policy generated by YAML spec
  uapi: team: use header file generated from YAML spec

 Documentation/netlink/specs/team.yaml    | 204 +++++++++++++++++++++++
 MAINTAINERS                              |   1 +
 drivers/net/team/Makefile                |   1 +
 drivers/net/team/{team.c => team_core.c} |  63 +------
 drivers/net/team/team_nl.c               |  59 +++++++
 drivers/net/team/team_nl.h               |  29 ++++
 include/uapi/linux/if_team.h             | 116 +++++--------
 7 files changed, 346 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/netlink/specs/team.yaml
 rename drivers/net/team/{team.c => team_core.c} (97%)
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h

-- 
2.43.0


