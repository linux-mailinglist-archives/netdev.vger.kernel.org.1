Return-Path: <netdev+bounces-55581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2B80B840
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DECE1F20FD1
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85FD7FF;
	Sun, 10 Dec 2023 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="U6sueWoO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E3D0
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 17:04:53 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d4e557c4bso14625515ab.0
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 17:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702170292; x=1702775092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+eFU91pk6ANkIFaP84jpE8UFztaVrMd57mCDFSkoQI=;
        b=U6sueWoOHN5MJhQG9mUS7NrF3BMfGCu2nijSpeFAcIY7EbCRedna3YVAf0rHPPS7sk
         reeFmuShoGNcHTNXgKDJ4VHDkaY85bSk/dr4IDfyaWb8nRC5NvlRAnwkKXaqKru9PnfP
         Jd9y+ReFUOMtLnyllPspWqRqPvqUtdiitCIkSNaq3bqCE4Mqg/n7nh4pGoeF/7TY0zc4
         gqNM7gtJ9lLB3d58hpJQOv+lgH8Nyib1WEobVNgXrWQ+zhy9RjSC/Jjxqpy8n7faeF9o
         yqe1HuNm5vkMPFL0hFEi4FKZmOwotZLXcGPx+mWntIKLlKiI2dUkXerOV6FCcb7n+VTB
         W8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702170292; x=1702775092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+eFU91pk6ANkIFaP84jpE8UFztaVrMd57mCDFSkoQI=;
        b=P8rFt1Agw3MqLkA6DRyWSkqZ2vxPvoPENc9rR9wRqeTRTsH8h1sy3E+2aKWCYZN0AW
         QH5wXXtH6kBsk8s2NOt1ObWMhV6zhFr2HlnX55lGt689gEFx6pRjCFzzasDYyez1OHIL
         6t+xi7+W3CoMqvGgPPjj/l4iWbFkmlRlaFqj51U0CM9fsM9h6Q5xNcwjrA8f54d12lP3
         BhMxBgWSwyRvej8m1XuJmmuz1W3y7UKqJHHogFo4E6pF4Mq8UU+3FBjJ4VuYWg8/hjgQ
         A5xYY/venIkiQw7C9dVi6N96f+8fY7+e9eaZQkg4OHnXuqJ/hzVqIWpMOMTY2144xXMl
         Wf7w==
X-Gm-Message-State: AOJu0Yw1dCCTHTxN0d/ofGJU4TnZO1R3wV0Y5E3sFRcAFz4Hh/vFjU1a
	zAvHAxgaLsSCMaetmaVIg/85EA==
X-Google-Smtp-Source: AGHT+IHIDV3qWXzzyQX61gZza9K5mYJYnGENCpgRWPBRfa0K2ElmyZyHiv+qXH1VkEpmIhW6dxFy+Q==
X-Received: by 2002:a05:6e02:12ec:b0:35d:37e8:7f8b with SMTP id l12-20020a056e0212ec00b0035d37e87f8bmr4221295iln.5.1702170292651;
        Sat, 09 Dec 2023 17:04:52 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b001d0c0848977sm3961649plg.49.2023.12.09.17.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 17:04:52 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] netdevsim: link and forward skbs between ports
Date: Sat,  9 Dec 2023 17:04:45 -0800
Message-Id: <20231210010448.816126-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

---
v1->v2:
- renamed debugfs file from "link" to "peer"
- replaced strstep() with sscanf() for consistency
- increased char[] buf sz to 22 for copying id + port from user
- added err msg w/ expected fmt when linking as a hint to user
- prevent linking port to itself
- protect peer ptr using RCU

David Wei (3):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports

 drivers/net/netdevsim/bus.c                   |  10 ++
 drivers/net/netdevsim/dev.c                   |  86 ++++++++++++++
 drivers/net/netdevsim/netdev.c                |  29 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 111 ++++++++++++++++++
 5 files changed, 234 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


