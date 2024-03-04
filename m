Return-Path: <netdev+bounces-77022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A9486FDBE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A1A1F2320D
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE220DDC;
	Mon,  4 Mar 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2E0ApFS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C0224E4;
	Mon,  4 Mar 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544582; cv=none; b=MW29bMqdxvVChAz0CWe4TErDf95X0Fu/p/VAK8HNWTzcdBZ46A/ZsS9lnL3FTzA3fZWuP9mriEnhpELR7UaVYVOrjDntg3wgdjqeCmBXr6+vQAha4oJDoc5/UuH7b9JRaCzSve4aiY7Hqg6cz3222uZcoCo9c5UqjumL4qzVcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544582; c=relaxed/simple;
	bh=mHbB/pz1Pc+uA5rdtv/xbI1HZb5FjofQTuaoijdpJYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W3qefTl0QdEbOowqNpgAJMPx42N4rnGnrGwaYFsGvuQOnzSU2k4ff4VO2ZkaqGbesvcjCdv7AS35CDbGDjXOMk374+bEY8LJSDxnrPBdlDIbmgH/BL8NTDoXaIULgqohma82JKWG70mvKXP2TVIKOHQ6e7fu9BbnhQqQLe3EXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2E0ApFS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcd6a3da83so30705675ad.3;
        Mon, 04 Mar 2024 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544580; x=1710149380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNTwhnnAejbLrc1xpvb+XtY4lUjoQ+7/z31LBeJUkPY=;
        b=U2E0ApFSKZ4eGy9YHPS8vNJ6MV+aX8W+azx3qLTTP5p51sdxgdrqDWjZaOe1UWgTEG
         B7YOE3fyOdBRlCqpFKeN4zexV03qakDVg/ew7St+SCaYBPA2aU7Vy0z4vZJIBVCQ1WUB
         Q2abdHu4YlQFRg06lZFRdVDpFeluMvPSd7wWVhPg1roUrFPS60qPjerkBJ0Vepsndazg
         5JhNkA2LzN8wN4C+bF0QzL384GgKhOYR98r/Ju2k//PycIXdWyuPuNkY1FLTdn7649ad
         OnsxCi3Cr1Ly05iCy7Ebab9XQWwBw5nXl4kgkxLQNY5n6vS3mcacTd7WRi2bgC6krw2t
         aeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544580; x=1710149380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNTwhnnAejbLrc1xpvb+XtY4lUjoQ+7/z31LBeJUkPY=;
        b=XfHvEjnGhhrtsN7yA4w9hGKbtbx6athlizcI8JwbUHfWSTxKndp+HuyJ3wLIf2izYp
         EAbSOFdT/2lZahyjaLNXOcuObxex/4twLaEhrHUkdBEHQ/h/d4RrRHruoQwVDGMTLnUi
         TdCP6cBgzKTndxppa1XpkyX64xz39Gw/lwdq9MyTomiUic+WFCeFs+k2ZkFTW2UHjQp3
         vhQqVDmmONGIWYAQhqS4a4+0db/7Wcx9+84K1u21pWfWjv9C2nkPPq/BgYaQvNVDPHqq
         yxvJVOPmiuyWQXAe4yypYxdQYjBqNkC1JCT5mSlncAXGLLnYKrnsQy1v0jcaKdYsUNiQ
         Y29A==
X-Forwarded-Encrypted: i=1; AJvYcCX6y41MbUjNJflVF9vQ9hPDIc6RW4Eg7e0WOHZr33IErSfnA6uItRnrF/RGMQvRIiTfdVlqDYidzU8HPsbUJUZkLoSw1bDLEcL4OoxFzMBmyUhv
X-Gm-Message-State: AOJu0YxjiQqlCt9TwLyuHcdxxIg3YSYz4rmobviq2AbgQVcFxhHfFqbT
	E9k6lPyZFchnh/lED8Mq7Fy3ft0DXqa6mcv/hWmiUKOlrcuixNQB
X-Google-Smtp-Source: AGHT+IFlt47HdDF1BFH7UVxa3b3BCJK95IjRKsQTk0huYIvksQRHiuIYBvc0KiC4lx8cU9NmOX4oCg==
X-Received: by 2002:a17:902:cec1:b0:1dc:3517:1486 with SMTP id d1-20020a170902cec100b001dc35171486mr11392864plg.49.1709544580230;
        Mon, 04 Mar 2024 01:29:40 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001dcfaab3457sm4095507plb.104.2024.03.04.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:29:39 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/2] tcp: add two missing addresses when using trace
Date: Mon,  4 Mar 2024 17:29:32 +0800
Message-Id: <20240304092934.76698-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I reviewed other people's patch [1], I noticed that similar things
also happen in tcp_event_skb class and tcp_event_sk_skb class. They
don't print those two addrs of skb/sk which already exist.

In this patch, I just do as other trace functions do, like
trace_net_dev_start_xmit(), to know the exact flow or skb we would like
to know in case some systems doesn't support BPF programs well or we
have to use /sys/kernel/debug/tracing only for some reasons.

[1]
Link: https://lore.kernel.org/netdev/CAL+tcoAhvFhXdr1WQU8mv_6ZX5nOoNpbOLAB6=C+DB-qXQ11Ew@mail.gmail.com/

v2
Link: https://lore.kernel.org/netdev/CANn89iJcScraKAUk1GzZFoOO20RtC9iXpiJ4LSOWT5RUAC_QQA@mail.gmail.com/
1. change the description.

Jason Xing (2):
  tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
  tcp: add tracing of skbaddr in tcp_event_skb class

 include/trace/events/tcp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.3


