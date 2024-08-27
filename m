Return-Path: <netdev+bounces-122509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC59618E3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B02283958
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC111CE6FA;
	Tue, 27 Aug 2024 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIwdE3WW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121C79945
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792364; cv=none; b=culCxOdcO4SjuVZTJ9Vz5Il/Gz3c1YTeC7deeFhmWhyqO8gmdUBmAWLC6JA4rvn84YGfk5O1leP3HirJOyv0rIXu1CwgXqay3+JNQm3jhBMuddg7nOq2Rt81hGfhnn9Ha/b1jvWMa/oA90RdU8qJk03R2lTb414cR6aTvHI8tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792364; c=relaxed/simple;
	bh=mKtWxp39X7wfnLd+I6i9diAROFqsMKfOP2Df1RXYwFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX9LDEqcCXS/QKjA/5n6LNqJdwZAN6YN/dcVUeK6XJkp4J687yQDVZEqgsAzhTH7zN/C4IwNOjrajK1isVtXCRhVIqZI/JVbf2NhxbJJDomAOHU/nIXQrVDQOg6nu+nGrrgmv3YCjh8STA+ggiWW9BMaij2UB9WZnDqHEr2ZTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIwdE3WW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso52268015e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792361; x=1725397161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQm5lvIf6yCNUyqn5WbCuggbUyMQIRw147axRrgtMv8=;
        b=AIwdE3WWMFRnMSP2duvw9qgyeNTILCiWEyJhTO5XfZrUjC4bGKUW16m+XHn0b8Pr6y
         hDTpOn3OMie92vWtd1ugYkVLa8zHuVkt0IJ7I3iiPPIn7VkJj7CVb6b+b+QG1v0y/S2r
         Z3gfuf6xVGJWUA6agzoSkyaOXKkOePRZU5znGV87+qcdGdtatexrvSRLenwrrQpVJffk
         6nPdJRfgJqV0Az88dcuPQDT7sN7oMSLVGub4DSOGuttbTi+OHW4PODMtmZddipeB8/lx
         DiOnJUGxJKbwIvjzaGS3xLkNtL15BSwgRLqD0dF1zTNrWanD6xXXRfu4fcaV/RU0G1QF
         jitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792361; x=1725397161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQm5lvIf6yCNUyqn5WbCuggbUyMQIRw147axRrgtMv8=;
        b=YCtZfq84FBcwNM5eRJLqrfaJom6ZT8xwkBpHzMvVL9qBAbq1ATN27kUScPGiLvYtQ2
         GVHxQVFcCId4EMzIX4Rc5TRdIw3PNHjI/Tf2iJQcYQTzgfpzpmxC1JDUX7K8AnyCbJUd
         c1V1M49G2S1Qs+JTa/dh9svFIqz9gvqKuQAoMjwpPsM/UQiXO4nSraXQ5bicudnOMZ19
         PdFDQKLoGXIFQuzu/3LdGcYH6cHBVl7ji1HlROiOzeICM0h/7ScC9f2MPHga5Xuo5Jbr
         Q/fzj+PtE47VoCrS6PMgHop8fwthzhVx6jtOJUOYQ2LKRUupv1bKT5NyCs8bXo4JrzhE
         SQFg==
X-Gm-Message-State: AOJu0YypRgrFWC4KP7f+Z/T0KhdTXXZOyYFFESEr47YIU4dsJ8lDa4p6
	JMX6Nnn0Mqkdo7EVpm7ItDh7V3QBftqGC2G+Up3AhS0jTaMTt2JBJuuKwQ==
X-Google-Smtp-Source: AGHT+IGA+ncozP2J8vW9Q3uDpHazGJi5vimhYMzNlP/XUMPv7Z6QbpyVuL5VjxmUfyi884rPwDHdZw==
X-Received: by 2002:a05:600c:a47:b0:426:61ef:ec36 with SMTP id 5b1f17b1804b1-42acc8a1862mr112145985e9.0.1724792360269;
        Tue, 27 Aug 2024 13:59:20 -0700 (PDT)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308265655sm13906739f8f.104.2024.08.27.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:59:19 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	sanmanpradhan@meta.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v2 0/2] eth: Add basic ethtool support for fbnic
Date: Tue, 27 Aug 2024 13:59:02 -0700
Message-ID: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds basic ethtool support for fbnic. Specifically,
the two patches focus on the following two features respectively:

1: Enable 'ethtool -i <dev>' to provide driver, firmware and bus information.
2: Provide mac group stats.

Changes since v1:
- Update the emptiness check for firmware version commit string
- Rebase the patch series to the latest
- Add cover letter

v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com

Thanks, Mohsin Bashir
-------
 drivers/net/ethernet/meta/fbnic/Makefile      |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 37 +++++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 75 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 13 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  6 +-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 27 +++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 40 ++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 50 +++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  3 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
 12 files changed, 260 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h

-- 
2.43.5


