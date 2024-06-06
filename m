Return-Path: <netdev+bounces-101471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B34E8FF04F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B4D1C243F1
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6B19B3D1;
	Thu,  6 Jun 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpvhNue/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EF19ADB8
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686201; cv=none; b=kPk4cUmy947/AT/d90V7ut+2t69xPvcA3iwn5tvL84jW4el1mayupdmxigDJ35XIqZE0rxEDaCvWKJgQ7eykAX9quYsdW9Xlyb56GPLCxWy+fWKS1EPVOIT1OL1pAiExuGhRilNQ8zyv2SPhQ7NZneEJrreTnud6/iscfSWdtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686201; c=relaxed/simple;
	bh=HKbxcFzufS+xlM0Vvw6iD6QEvzl+/bBhXOdf7ZlPCxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKl81RzKGJZsFrt+rb+M6OeRH6XZ5YwNLvVDTaZfJ6ZE+Z61h+C9qnIzRfZg48zdUyCCwmc2XC7x3E5ck371zsN9u2YhPg15hjIu14Z+Ih8issb4vt0jS65jzX79buEGy2M84N4+nglyhEs+4v0LXrsnbeTHQ8igVakEesNOjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpvhNue/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso841007a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717686199; x=1718290999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNe2uQWbBWpdMHa8ZHipYgZx5AAWi/oo8idhRXqluto=;
        b=QpvhNue/ZDJWuQAS0S3o7Fs32c/Vq8bK7/zwWS1CWE83/mXDZk4nsaQwI6C/XhYnvp
         OYfdYAvnCusmBmNK8ehS/qBsMDWA74rlZqAZFWAC7SHl2Wq12Xf5k5ECcHaxe93OJFYJ
         ma5S9JfswS2OhvEoOzXa8jTvBd7QdHvZtY8KrR6aL0xD04XNHJjkP1PrkX3+F4y7YW47
         QZhiZk210on0N1trKcDjF0IqTt+gmAnlCDxQD5Rfvgo6g+3QTlKqnwQldzHOZEAnWg5I
         lOLjY1cuvInX1TBj4eiJT3b7SZElvBKV9ZW8QBAFY6oy55KewLPoFbdCAkKCTbQ4tq8J
         Lpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686199; x=1718290999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNe2uQWbBWpdMHa8ZHipYgZx5AAWi/oo8idhRXqluto=;
        b=pla/BbdPUCqEovlgaocHW5D55a6Cmgs6cotqpMIT4Wd3jDbcAiu44m9Hnh81jihJL8
         uyILIL7wXGX3jS6YDO1NuuMGSJR8slPimljh6Ohosmxb2+BFe0BYSU5a89/JEWHS4+qM
         IPhRKqI4NXfM79EXz0ZpxbudsUYPOjKB/Rf6fsQKROrx6WUXRZ3daEZ1sftfQ2TmWfB2
         GJ0heJu0DfSGWM50Qg2SEo3oEpERp6OimaMzVP5SH5fU9iobdPwnPWtBul5FY62tmJvv
         FzH0eRYra3y5wiKRg4QUErbP7IpNqGzvALAuE5LFSbElBZnDpPQpreu6OMzxqwxUbEkx
         cSVQ==
X-Gm-Message-State: AOJu0YwVxMU+GaSoF5bAGtft5BrogbRc4355wG8tloyMa+BKBCEOlFQ1
	xRzzPinzkX2OnRKv98bdrPRvuwzurmVOSeACv+PcCDJvH/GnxGvW
X-Google-Smtp-Source: AGHT+IHI0MCL2jq9KOq94tzHlC6jsAU4094bDOepuIGuU6KenSHFge0oXhnB2puwv/v0yHEPGQQ+1g==
X-Received: by 2002:a05:6a20:3d8f:b0:1af:d228:ca5b with SMTP id adf61e73a8af0-1b2b6fbedc5mr6901721637.21.1717686198753;
        Thu, 06 Jun 2024 08:03:18 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de264ae03csm1215853a12.68.2024.06.06.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:03:18 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] tcp: show the right value of TCP_MIB_RTOMIN
Date: Thu,  6 Jun 2024 23:03:05 +0800
Message-Id: <20240606150307.78648-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When doing 'cat /proc/net/snmp' if we already tune the tcp rto min by
using 'sysctl -w' or 'ip route', the result always the same 200 ms.
However, it cannot reflect the real situation because the minimum value
of rto min can be changed smaller than TCP_RTO_MIN.

Jason Xing (2):
  tcp: fix showing wrong rtomin in snmp file when using route option
  tcp: fix showing wrong rtomin in snmp file when setting
    sysctl_tcp_rto_min_us

 include/net/tcp.h  |  2 ++
 net/ipv4/metrics.c |  4 ++++
 net/ipv4/proc.c    | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

-- 
2.37.3


