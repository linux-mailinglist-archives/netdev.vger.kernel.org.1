Return-Path: <netdev+bounces-88577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D98A7C48
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18526285651
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDD4206F;
	Wed, 17 Apr 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmNKj7tS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFD1851
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335253; cv=none; b=UyWzTnFa72IpODTLIuDOlTBulQ1EPH1sNY44QGgu/JBiP5Qd+OJ4rVN4cs7iL4wtWhdeC8+2KW2VXZmJr4/qJNqcVcDB/U3H1iFJiw4j1h2Pr0C7aA0Ryx4xOgF4Sc3YWIGq0ufSW/76mWjSApsrSI4Rt+kpGPrI3qrwW5AVbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335253; c=relaxed/simple;
	bh=4ZlttUKtyoExP1Nv9yogHzO9e40SW3ngtgJva9rK2Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jV5aCy1Q0oD2wx/NxmjP+bpd9rvb4Ugv2J9S8/vFSJX1pLU/KFed9FLdmAkYsXbGRf9839Wct9L8iQr5C74SlTrhgdEDg9pXAjbITMPv34rUckXnbmAgfl1KyOO4y1knuDK4kfQ+gBlfz6vPi7T1y8UwwaBY1et+w+TMmJP4cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmNKj7tS; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d9cdce41f0so55401039f.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713335251; x=1713940051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECLx2TLF4J2VfxrnMuUnajOpHCAyB1HvLwkhI8pOM8M=;
        b=OmNKj7tS8lGoh/0/3vRWyOJkdmVGkB89q8oM5Vcs3KoHCufAF+teTLZ0vutPLu1DA9
         YbQpACKL1aPfEeUvhzk0UN164WhoLgqGz8a8PtDJuo0e/GdSgMYaQwaX6RQZV7uSiepr
         VUrr6uBcSUqx+1jruo6PQmyim5ww01/rq316lcvph3/V8sxd1mDzfUA/cN4w7tSMAzm4
         fupfsxKcVBR+verTbJVYvRdCqj10nmhZbAgdcQD0FJtUxXXOIHX51IkpLO14w1Ob0CDD
         efAULIcdHMwRE4ekMe4Y7Y54wfRxdIqhTvM2Y0R2ZK3ZdmUQsp0Hp4I/XU2QeEP7IXSj
         3FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335251; x=1713940051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECLx2TLF4J2VfxrnMuUnajOpHCAyB1HvLwkhI8pOM8M=;
        b=ICikxsBm1h+EIz3WwybmT5Qe6vDrFO2dnsB4ZL2m32HlyEFsF+kv7jjMN+d3IL7dEk
         Ror6Lk/pcYvX94yBUPwzXdXIdlD9QLzKm8YqMvlWCR33EmclEcKE1xJQcv9Yf4ZbAFZc
         +9KQ9GitJm8Xh3PIbglBrvxhl9GoTgT/CdCWLca94XOVVsSiMyKizFw5O2cwW19Pcmjr
         u3LhlgKxkuI0MyO46TApeh1pWXJ9HX0KqGRsKwkSxdt7GZ/qpWaPwU0xswCgVHf68ydk
         L/kqyDIiBAu9ZktH6WvckQAFw85oR2iUPVXcxtjrlDyOY+x32uXzK39MnOOWP6D7zsiD
         gVOA==
X-Gm-Message-State: AOJu0YxwlQ/CRHZTtWFuaf4sVmu32L40M81rFziZ8oDGlIr3hcF3pR/7
	hwUqMJ/zSRx3M7KGtRzoKCg71HFpymVJaiuJl2hnIY+bC/Aed/oy
X-Google-Smtp-Source: AGHT+IHq5/V0EhFuGEvF7dW4hGc5u/WgZoQLGgDCG6DUjnRfFFTlJ/PnGl3LIpkEUUHbEc8u4aLwkA==
X-Received: by 2002:a05:6e02:1d89:b0:36b:19f3:5606 with SMTP id h9-20020a056e021d8900b0036b19f35606mr12584407ila.5.1713335251035;
        Tue, 16 Apr 2024 23:27:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id a193-20020a6390ca000000b005dc120fa3b2sm9821006pge.18.2024.04.16.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 23:27:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/3] locklessly protect left members in struct rps_dev_flow
Date: Wed, 17 Apr 2024 14:27:18 +0800
Message-Id: <20240417062721.45652-1-kerneljasonxing@gmail.com>
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

v2
1. fix passing wrong type qtail.

Jason Xing (3):
  net: rps: protect last_qtail with rps_input_queue_tail_save() helper
  net: rps: protect filter locklessly
  net: rps: locklessly access rflow->cpu

 net/core/dev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.37.3


