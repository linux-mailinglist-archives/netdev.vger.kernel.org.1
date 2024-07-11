Return-Path: <netdev+bounces-110841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2217492E924
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC20CB223F9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60F15E5A6;
	Thu, 11 Jul 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEGLsNzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5A15AAD3;
	Thu, 11 Jul 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703669; cv=none; b=XaCmnBQN4xPiVpGACvbIOU6Z02ZYZEpcCv6AbxXJogHjViMORGdryaX6Pw96HjN3qYhq0vemlLSK7qxgAhCgvXKLRKh63+Uyh4o4WCHKgtFbqjCK5qw5gTSpyFp9Mc0QcTbfxIwTfFmhmaFYO6FEvPqvpJQPwv2e/SVqwJgsWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703669; c=relaxed/simple;
	bh=GzEACVD+JqkdYmDO3AwNpm6xmM9v3fwgfez/OD4okQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FTkYq4sZTtyR/jaRFPL+WV/D8iEoNRp/+oY7d4S62guT4cnP/k1rpsfi5eS7XirpG5M4UoPorKx4oJExW5pvAlu72E9IF+7B/I0Q99D/bF/m6KVMylTX5G2FknNSunKRFZ0Seveuab0ZsJOZMU/9tWcVQ4R8YuyDKFuGmlxtvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEGLsNzm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f535e82so5546855e9.1;
        Thu, 11 Jul 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720703666; x=1721308466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SW4rzMU+cmLzXEzGKinf4A7N4+M41M8PEaZuIQWHA6c=;
        b=SEGLsNzmaL7gH2kz+D4hxbCM9JS1zV9tLMbXPPaT6ZfAGOo2ODlwEB1pBU1COputFp
         4/CsbtqkGNKPK4E4l9wBkt01ofSA8cxThRa+Za0tVOzWkMdPzJEXRGqWfT9vM+p8punz
         NiviIbJ2GK3S98sieuxQPW76HR5JnMmECiHgsWIyBbGUYMVArBHgstC1tm95pnraKMs2
         ADVHKaZX3PPwwUCsQlzN+cW0Ed+v801A/H7F5JU56ehu/E+TwHVZnYd0KkCk1QhiOALJ
         YIUw/ZyDT84w0MWs1xmX4aUNoTW3dqiai9W9HoDtFCnL/qxyqzbx0eY9HEAWMkJg7Yz9
         0WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703666; x=1721308466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW4rzMU+cmLzXEzGKinf4A7N4+M41M8PEaZuIQWHA6c=;
        b=UvIa7OF+ZWzpKXtiGPHmsA9wiNsaCsFnAXqJdOy7TDU5fr4Jsj8DFkdA4ALTRUk5du
         MJP1EFd4QbhAR0mjP9pzrk2nN9vXAcSYudfKHtspB/4lvREoA/4YUVUAZ8p/lf7yCR1y
         2zAOYB2S7rqZcUCpyxVwb6/++eTP0vC1wvpW8BXAPm9EoZqYDENclSt7gfp2Yhu5iNEC
         zt+1j6N//NNkK6/BXlbWXsHTS8aHp6vnnG8V2Jqp5sdyuBTDxN9MVFASEIKIwKLPadZS
         /F5UaATaPx/ixvD799E3qnu09CnrSvjT89NohVoF6W+KZD1okNJretQUSuTTkSc+ZEIZ
         9PEw==
X-Forwarded-Encrypted: i=1; AJvYcCVdGzE3+H1y6Km1KsWVi69cMoRiH21Tgx19ygSHsVRWwINypbpXnpaZLpMYKI/SWD0uzVB+zsydc3N567YqULfRwILD5tgLQfnyyV7zBJvYkrHBRN9VwFBVsyRqTuYoQSyjXB4M
X-Gm-Message-State: AOJu0Yz/WoKZqyfjAGhvyiWwtk9pMqqC1Ide1NSLSb15g7b6lE63tNcj
	IYpRjlghnMIjZNTypWcC3x4g3vegsT4JSW8Ra06mRRKT0yCFrR19
X-Google-Smtp-Source: AGHT+IED9wyDCvyGT/hdPKwB/fdPHFOGVK2PqvM5ZboTWYLnq1dcnzvRgy6G60d7cNZUKQsr5QjMaw==
X-Received: by 2002:a7b:c015:0:b0:426:5b34:55c5 with SMTP id 5b1f17b1804b1-426707d8b15mr63878865e9.11.1720703665813;
        Thu, 11 Jul 2024 06:14:25 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42799224980sm27167565e9.38.2024.07.11.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:14:25 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	gnault@redhat.com,
	jbenc@redhat.com,
	b.galvani@gmail.com,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	aahila@google.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 0/2] net: add local address bind support to vxlan and geneve
Date: Thu, 11 Jul 2024 15:14:09 +0200
Message-Id: <20240711131411.10439-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds local address bind support to both vxlan
and geneve sockets.

v2 -> v3:
  - Fix typo and nit problem (Simon)
  - v2: https://lore.kernel.org/netdev/20240708111103.9742-1-richardbgobert@gmail.com/

v1 -> v2:
  - Change runtime checking of CONFIG_IPV6 to compile time in geneve
  - Change {geneve,vxlan}_find_sock to check listening address
  - Fix incorrect usage of IFLA_VXLAN_LOCAL6 in geneve
  - Use NLA_POLICY_EXACT_LEN instead of changing strict_start_type in geneve
  - v1: https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/

Richard Gobert (2):
  net: vxlan: enable local address bind for vxlan sockets
  net: geneve: enable local address bind for geneve sockets

 drivers/net/geneve.c               | 82 +++++++++++++++++++++++++++---
 drivers/net/vxlan/vxlan_core.c     | 55 ++++++++++++++------
 include/net/geneve.h               |  6 +++
 include/uapi/linux/if_link.h       |  2 +
 tools/include/uapi/linux/if_link.h |  2 +
 5 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.36.1


