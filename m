Return-Path: <netdev+bounces-142835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A39C072D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AFA1F21FE9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704920F5A5;
	Thu,  7 Nov 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft9Mtpr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC481DEFDC
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985783; cv=none; b=khPxH+zl5PhMVW60n1APx9ZCfN//NBS3eoPgP5Ykj4X7BLWZvZM1tBs+1CTpPJZA9OJFw3Oenbkkxqnkan3AaAVZQ/WOYcJifKN5Gxcy6J/ZXE3FAUgr1iLeIH94rQXD7nFIekKOxQMHus5veqCtEZgcDl8xDSYd/1XRRZJVYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985783; c=relaxed/simple;
	bh=ZSeJ/CzdmJJLx8d2E924qI0yMQxe166t/YpGv4hCc7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7p/Dvzqkc+hGZq+zKD1LPEZksO3u8pgYgHo373p6LG1tqvJbIyUKYFfIN6oY6dW/eAkdhjvJhPdLbAbJU0DivDB2Ebs9IdziTBJdfv9OjFCb6ZFsoUaTzRA8wZuYhNif6TMHCKcXU0Mfy/Qi0l9OOegbGBukVm5PqoH1EE7hQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft9Mtpr0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43193678216so8715115e9.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985780; x=1731590580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue5h9vNOyKUJsXYpVGHZxL/AwDGAL5EqdxBKFPPD8kc=;
        b=Ft9Mtpr04qfHv1qQIrHjKcMemFqlUvH/hIAik3xoavvDEn6ySFS4Q+lg8mravAuXiW
         447IjHwXpLrbBItzIk0TtzcqkxDOpd70e1ceh2ReMDbdTnzcL4ROp6wfk5vReflc/NiW
         Chf5jmZRULLWCuNeK0dKE9JeVH2PY4YUykjIxlqinitJt3U2cTWIh0vayed+ZE1ilYYO
         rYvT7Cf5Ct6/FoSw2TAUVV+xf9BYduXGVi9WeYvNL1B6Q1j2Pg9r6GCtFsQtVNSxYhVT
         Iv3dsCBVIUn8tfaTKe1/kbEG8Mx1IYcRN5R45swkV8MzkI7qyo2q9WreGz1dP5TNX3Eh
         r16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985780; x=1731590580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ue5h9vNOyKUJsXYpVGHZxL/AwDGAL5EqdxBKFPPD8kc=;
        b=Bcw7L/bsYWieiE+NxYNbFy59MvEmbfzeYMPo0Me0LS0URLyCx8XeRMXZHlKsLMNN+r
         7dKCGZD2xwSojo2CZ1Ta5rWxeOrCYme4qRMQGOpBmY0InD+z5KOuXJKzGWUUreG3kRLm
         vBSOg0p/s2Ps1WbBmVAD7K3LfxKpOtSAKCd2JsxzNbKtGmudQwPfh9ELF4Tj5h8+m8vS
         pSpF8ePUunrKnZ00eBqCds0ou8D9hcaflXeLHzKF+Cwdj64hCGInKeVa3YvrZZehLF6o
         hd2NHf/VWuSHbRnT4S2qn9ycjfc4NWsAGXWoIl3Ikv4iTaR6Tf/0nFtluGG5rc7lG4Cl
         52Fw==
X-Gm-Message-State: AOJu0YzufOdLkM+KEApObp6K3DmHZ/CwbvM3YrNbZwKNJHKk15JeSAB4
	gif049Cd6fd4f7Svq0N3JTMWZRyTpqKSpEaPdLfc/H4n0+Ozu9sqG3n0cqvM
X-Google-Smtp-Source: AGHT+IEviyuOn/0e4QeNqKcvgC97sRUiVRwUitPnRkAF5Q1ZBTZX1yYczykeO4MSU9QHhRoqlJqH+g==
X-Received: by 2002:a05:600c:4f83:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-4319ad089b0mr344231795e9.23.1730985779917;
        Thu, 07 Nov 2024 05:22:59 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E912B00E77793ED09024636.dsl.pool.telekom.hu. [2001:4c4e:1e91:2b00:e777:93ed:902:4636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm24372355e9.38.2024.11.07.05.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:22:59 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v3 0/3] SO_PRIORITY cmsg patch summary
Date: Thu,  7 Nov 2024 14:22:28 +0100
Message-ID: <20241107132231.9271-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new helper function, `sk_set_prio_allowed`,
to centralize the logic for validating priority settings.
Add support for the `SO_PRIORITY` control message,
enabling user-space applications to set socket priority 
via control messages (cmsg).

Patch Overview:

Patch 1/3: Introduce `sk_set_prio_allowed` helper function.
Patch 2/3: Add support for setting `SO_PRIORITY` via control messages
Patch 3/3: Add test for SO_PRIORITY setting via control messages

v3:

- Updated cover letter text.
- Removed priority field from ipcm_cookie.
- Removed cork->tos value check from ip_setup_cork, so
  cork->priority will now take its value from ipc->sockc.priority.
- Replaced ipc->priority with ipc->sockc.priority
  in ip_cmsg_send().
- Modified the error handling for the SO_PRIORITY
  case in __sock_cmsg_send().
- Added missing initialization for ipc6.sockc.priority.
- Introduced cmsg_so_priority.sh test script.
- Modified cmsg_sender.c to set priority via control message (cmsg).
- Rebased on net-next

v2:

https://lore.kernel.org/netdev/20241102125136.5030-1-annaemesenyiri@gmail.com/
- Introduced sk_set_prio_allowed helper to check capability
  for setting priority.
- Removed new fields and changed sockcm_cookie::priority
  from char to u32 to align with sk_buff::priority.
- Moved the cork->tos value check for priority setting
  from __ip_make_skb() to ip_setup_cork().
- Rebased on net-next.

v1:

https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@gmail.com/


Anna Emese Nyiri (3):
  Introduce sk_set_prio_allowed helper function
  support SO_PRIORITY cmsg
  test SO_PRIORITY ancillary data with cmsg_sender

 include/net/inet_sock.h                       |   2 +-
 include/net/ip.h                              |   2 +-
 include/net/sock.h                            |   4 +-
 net/can/raw.c                                 |   2 +-
 net/core/sock.c                               |  18 ++-
 net/ipv4/ip_output.c                          |   4 +-
 net/ipv4/ip_sockglue.c                        |   2 +-
 net/ipv4/raw.c                                |   2 +-
 net/ipv6/ip6_output.c                         |   3 +-
 net/ipv6/raw.c                                |   3 +-
 net/ipv6/udp.c                                |   1 +
 net/packet/af_packet.c                        |   2 +-
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 115 ++++++++++++++++++
 14 files changed, 156 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

-- 
2.43.0


