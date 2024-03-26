Return-Path: <netdev+bounces-81890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624DB88B885
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BA11C35CD5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655B1292E4;
	Tue, 26 Mar 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpPvE7FU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D19128381
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423823; cv=none; b=rtIC2nTgs3nHw8wpTLBZlqIIiU5+tzmBITJc4UmD87EWK+xGLKG59VBkgT9x91zPS3twDqRRVezW/Wm8tP1Za3mIlR8oq5V1hK467sNHltS0govZopyBkloorEvvxmXDUJrBhFNipoB21iWhH1abIUEzBU8mL42uPviGsexIgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423823; c=relaxed/simple;
	bh=gOVyZvfKGuxVsgLrzxarywZr9aXCRWP/kSjhTtsKMt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtA5JpNQr0MUbvkvVcEMQVRdDqeUzZgsuYSXHH5jcFlhWiRiJfqMr2PyKf1U8JVeSGohM8ggMdoghhro8eIWGx3ABRVZK/fV/FGQWbwwy8iaHXcpftCZ0YZDGVBYK00EiH8UVg9xCHNW4AX/58f3HJHS4UXKzyeBAT+SkJ2xX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpPvE7FU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2804265a12.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711423821; x=1712028621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcIKBW3MH0bAj1VNQemVijuu1cMaCg2vzAaN3fLfHk4=;
        b=OpPvE7FUVKS0p/WpSLGAUL0IFCvFXDebZtcygg5hK1eudRfQHPXkRNKe1xLCdq9sF6
         VFrns45wzsYG5mTQ9EXvYlxjeHv1lcfl2BBrg1BjP7alUVraruqCBKelvSkb3BbFcYMm
         JSE/9kSmkWnyPBUX7SBd+xjkuIvjb059ZkFbU5ZnnIbQI1yiZwUJrWNb9niTgsKpzGaX
         p0mGyD/cCKNaB42fyeEPygE7hXg6uidTnMrzp+Dqviyxe/DByo4AOTW8ZGy25TyjYDNf
         yTYW7ARBd+xa3TUBjJ7rl7xChlkJ2SMsD1LSvsc7B6hvAkzzAON2/fUyv56kdUl3KH4t
         R+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711423821; x=1712028621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcIKBW3MH0bAj1VNQemVijuu1cMaCg2vzAaN3fLfHk4=;
        b=a6090boj559Tm7vZCrGHvD1jWOB8fSyrE7+pgkI9JHbUNlH2pPfXi9vLRanyGRYTLw
         68vHLbqd/RMJmEh8Yqj0ICVC9E+SNYx+A2NEjNI9vWPVUDlIZufqTmi2ZdQ5D7lH+X3I
         IcpSRcMyzOGId+Qoi3jP0CSW14AosXWcR7y2vojP3s+enSZEtfPYUEHgM2FwHo0ZQgCI
         Vo4EXs5bLqyzSjJAKKAS2UOCMT7JMikaZSJuFIWCfU64CoajMhbwdBHJEixgrlidGVaN
         SE44+6Ta6eYy1J08N6G7VHuj6MHbf6M2I7C5X7hWkVgrhSHzXzcroL0R9VcE9mv8ab8W
         QXsg==
X-Gm-Message-State: AOJu0YwCoEHLtu27Gg5jbgxUteiRUtUdv8x/YeOsRuxHwQVoLvDhredD
	GAv0cH4KPO8DPQ/ohusiUcQ8JKNv095hE4KCIfF+XgHqAE+IpD75fVDpTmp3oxtH+w==
X-Google-Smtp-Source: AGHT+IHQvfzfr1mHSbsZI9D1hiYy3B9GfZHJoHn/T6fXpPqh15wOmBOdY+pTcp+WrUw4uCmj1auKGA==
X-Received: by 2002:a05:6a20:f398:b0:1a3:63c4:12af with SMTP id qr24-20020a056a20f39800b001a363c412afmr7626738pzb.58.1711423820694;
        Mon, 25 Mar 2024 20:30:20 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001dd99fe365dsm5676310pln.42.2024.03.25.20.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 20:30:20 -0700 (PDT)
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
Subject: [PATCH net-next 0/4] doc/netlink: add a YAML spec for team
Date: Tue, 26 Mar 2024 11:30:00 +0800
Message-ID: <20240326033005.2072622-1-liuhangbin@gmail.com>
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

Hangbin Liu (4):
  Documentation: netlink: add a YAML spec for team
  net: team: rename team to team_core for linking
  net: team: use policy generated by YAML spec
  uapi: team: use header file generated from YAML spec

 Documentation/netlink/specs/team.yaml    | 208 +++++++++++++++++++++++
 MAINTAINERS                              |   1 +
 drivers/net/team/Makefile                |   1 +
 drivers/net/team/{team.c => team_core.c} |  59 +------
 drivers/net/team/team_nl.c               |  59 +++++++
 drivers/net/team/team_nl.h               |  29 ++++
 include/uapi/linux/if_team.h             | 116 +++++--------
 7 files changed, 348 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/netlink/specs/team.yaml
 rename drivers/net/team/{team.c => team_core.c} (97%)
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h

-- 
2.43.0


