Return-Path: <netdev+bounces-88209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B38A6550
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2965BB21704
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D88E3D0A4;
	Tue, 16 Apr 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1q+xU2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D9386
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253377; cv=none; b=IfIiLjiCaTW+G0bf0FFK6cYnQ3Vyq/DBmoHgrsNqDh2ULIZYC01wqyT5uusR57dPBZuA0tFhlKOnRlGcRfkBf9nab4GTGrWl68DiuqxjyycBqFd90XniEDg4UWCh6OpL//70EC3Og0opMKOg+CWSfZorAmxnsmCY0qrnszgBI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253377; c=relaxed/simple;
	bh=hOpRlSEd9HkSfP5QGtdr2pyzFvD+ZF4fxtgAEjiDcHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJE2MCuGBcKMugVrVldDsompqrB8jZeJ3MZk2/p7RaJagOnyy+KEBaPtuI28fDoL3M3ErMLQ8MacogVP8b8oVipvssJsA5M4dGklur7uroM90ELKX1sUsvcN7pLCmLxn+UJvuu2m+3qjny7b/jf3Iswv14ziYMSHAuKF5xQGm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1q+xU2L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e65a1370b7so19300245ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253375; x=1713858175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7fQIMNYG8bjv/F6Fmy/zAR53wzaS116ocAL9e+R8fQ=;
        b=L1q+xU2LMAgrPYMNgYtqYqbDjK6Hkds1qCkHp9UVbXW4EgsT/1B9lD8dUqRkto2+1u
         ODNlbzWAoWIt2+/jFqdlp105h00EEqkXx5z4MJnsZE+D+X4BgVq13cy3U8TLGTGId4Q6
         3KuyoPUj0b22p5hNU+Enz0IWpcc6oaU7Ae10x7Py/SRwQIgAnpGIaWC9b9WsAmPQIJES
         OIJxH3G5Z/GPMMLStbhP8PBLh+t2Jmx/UOSVFGjGte6OJgUX+F+ZW/71dn/g7THE2rEc
         A2t9r2U73qL6sJjpJLEuboirdiCw9TqBd2Eck2+gAIEp8MZKED/rc2mcTr9wXftm2xuA
         ZKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253375; x=1713858175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7fQIMNYG8bjv/F6Fmy/zAR53wzaS116ocAL9e+R8fQ=;
        b=YUmt9hZIJTLfv3loP8Tq1dhfjM3wWpn7A9fdpv26kUtFt9dDCNopos95hW1UWNfLIz
         lvIoD/qoNrOg6MhHiMddjb250KhtoO5RXgw/5HBPLD5N3SzZzkLKAT5pPD5nERrlGrQs
         a2XqAITcERXd+Wy1CStNzH9yN3Xzsr9VA/AZu2ORHamQKfof2nEDOjSYIlHHL/jpq8uC
         EP0UpF3fx+a4yWuYXthSo/ZTXmSMwW6wCBanCA9y7i/1a3iMlzddTdXO9f/mRqBktyts
         QQ0IszIcPmDM/towiyPZnBsz4NO52SWsIJtg93aojaXc76SQ7jaUhaB1QajfL7Z8mlwK
         Bv0w==
X-Gm-Message-State: AOJu0Yz+xg73k1dklDZaHLlabmMwXG8RLu2L0GqMc4vGBFYZAC69RFE+
	jUlGRXbtG4H0ezaYyZDuGqBanBalbfsx4VbC7wsGAeWtOTAUydkm
X-Google-Smtp-Source: AGHT+IE/WfbyVqMj6SsLLcuXqTBqgLx96EJux5ZjkPPuIQ2vcbq5ysx+nmCYrG6NKvUMpM5TvfT5eg==
X-Received: by 2002:a17:902:f60a:b0:1e4:2b90:758e with SMTP id n10-20020a170902f60a00b001e42b90758emr13353727plg.39.1713253375000;
        Tue, 16 Apr 2024 00:42:55 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b001e4881fbec8sm9126947plh.36.2024.04.16.00.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:42:54 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/3] locklessly protect left members in struct rps_dev_flow
Date: Tue, 16 Apr 2024 15:42:29 +0800
Message-Id: <20240416074232.23525-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since Eric did a more complicated locklessly change to last_qtail
member[1] in struct rps_dev_flow, the left members are easier to change
as the same.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=3b4cf29bdab

Jason Xing (3):
  net: rps: protect last_qtail with rps_input_queue_tail_save() helper
  net: rps: protect filter locklessly
  net: rps: locklessly access rflow->cpu

 net/core/dev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.37.3


