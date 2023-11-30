Return-Path: <netdev+bounces-52562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E64A17FF372
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76119B20BB5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1864524A3;
	Thu, 30 Nov 2023 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jZdgCd4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08181716
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:24 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cc2027f7a2so1046591b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701357684; x=1701962484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2I6w012vtf+s0drXCjCM6Pj4B+/fX0Er6TsWIYRUAc=;
        b=jZdgCd4OBhOALTfjSdsHzeSf4PBlmAM4mS0cX9Abrud3/DwbsIu08dwhaWBF2tRK2G
         3gq2KzvVjP3EfZpe14yznBkXHl2tehV+gE6INgQyyy6Tg3gzy6yZw0E9ehb8MquShgyb
         ZudzEsiRpIIbodQTa0nZhedZtf7z+b0NBdQEj6sdWtwnD81l57nYzA3YCsg93KA1GpyS
         3A6EHXOoL4eEpnTJyvEamYRZn6nnYkNpwrSiBUal/r9y14QltZGinMqtUKwPSR89BLz+
         Tlb4ZTKV/27BJ2NLzDVTa1LO3xcwau5uEVXsIfUeqW30HFDaaYYxeueXX0+2Zl378bwM
         fthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357684; x=1701962484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2I6w012vtf+s0drXCjCM6Pj4B+/fX0Er6TsWIYRUAc=;
        b=TWb++6NLdspdlVZa1mZSLg+PfZ86FQpuLDSBBBUDKDeyukR3dCV9guwgLI3vstWrRE
         hqawh4f3DYXAqVBYoYno1IEGZJ5JPUrICnan480xDy/sOtCJWkAn4vp+ikmRLio7D/Y0
         kIpthnKhNFcPBGQ0XcwymfmMJW61J4vDrxnkrXjUxa+XVJ6EwxIVAKONBM01jNnGKrW3
         CjuVfTavzBu9duP1Wn6ZehH47kXccRUfsF5KZxvVSw6WW29kyCnz1ftJ4C7jPf94qFu4
         9rphwb/XiRKcrW/sfaQZ1Q62vpKczAw/yJrma4R8m5SVCaABWVGC8gKMvQNnSayt6JuS
         1gzA==
X-Gm-Message-State: AOJu0Yz/rWhF96lFy8I9xQGR2mvJQta8G8rFXbDkcTgbgqK7JLpp6I/M
	NP2dLXIVP8uyOZqVgNKtej1OUbucMsO40rElHO4=
X-Google-Smtp-Source: AGHT+IFFuXxaK8esGSKcS8ml+SmFZyRN5CG9O/pzbx0447d9VNppaSuTxQJETEBNOQgmZHdHnqwwZQ==
X-Received: by 2002:a05:6a21:33aa:b0:188:20e0:2bca with SMTP id yy42-20020a056a2133aa00b0018820e02bcamr24896981pzb.13.1701357683620;
        Thu, 30 Nov 2023 07:21:23 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm1342579pfn.61.2023.11.30.07.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:21:23 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/4] net/sched: act_api: contiguous action arrays
Date: Thu, 30 Nov 2023 12:20:37 -0300
Message-Id: <20231130152041.13513-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dealing with action arrays in act_api it's natural to ask if they
are always contiguous (no NULL pointers in between). Yes, they are in
all cases so far, so make use of the already present tcf_act_for_each_action
macro to explicitly document this assumption.

There was an instance where it was not, but it was refactorable (patch 2)
to make the array contiguous.

Pedro Tammela (4):
  net/sched: act_api: use tcf_act_for_each_action
  net/sched: act_api: avoid non-contiguous action array
  net/sched: act_api: stop loop over ops array on NULL in
    tcf_action_init
  net/sched: act_api: use tcf_act_for_each_action in tcf_idr_insert_many

 net/sched/act_api.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

-- 
2.40.1


