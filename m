Return-Path: <netdev+bounces-94915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F28C102F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CED21C21CF1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C411482FD;
	Thu,  9 May 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpZj3BFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B5147C96
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260397; cv=none; b=atcl8ArNIPgi3u/U6alHQzawadkkKWxcVo9QXlm4KHAp1MPqObUzT/0Tv5lAs1ULRFuOxgss4ovBSe4f70eIIGKIBHg0qHwk/UH/5xgEd96jvVLchENdh38Qcp7ujdsdGR2qUhwqUbQzu15/Wn/+1YGo/RzFwX8bzDGOZb72KjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260397; c=relaxed/simple;
	bh=RmyoiTA+NsxpTKsCp488Zp2NRwfkrXaFJ8aL0A3NWXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HCyK/nOay4Pm2x+SP0MQ3Hxac2+PTg4NYt1Pr0O7I8+Y5qwCEZvv8BhfYu0f1gJQL2w8wUakPN71Jm+fCo+raD6U8q2ziLgDaoCdXpWXYAwLcQdhRD2zJkJyNXw3EhhgZ/m213NqpLvGgYfO6Um0jJY86XoKCTOnaVExqWDQtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpZj3BFc; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c826d6edeso3876725ab.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260395; x=1715865195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVF7RLqsLPE1xxxlpKpUv52vvMK0xNvheputuJuYpRw=;
        b=CpZj3BFcMOgV30aQLoQEDSevjCrxBeGS+FIo4fQasB7ar5gD1xwHzluyQ3BUpD7863
         djWI05zUrG6Zz0O7O3d+ZJHCrEDyuX4bDhuUDkXJYtoK9bbsZC0Yu6aR2QJhC6MzPHbE
         uipTvUXrwr13S3Olai3QeW9sfmUs6QvwPvDVA1Wmr9lJjVt/ZuRBUBkAnzGtH9/TJQxh
         hL9bOY4Nm2OGeWDTOwcmjGsnqU0dHZ1zCB+nY25GhzV4ZIucLsFSkNbLRgyeGDzDWqzR
         mUbQm+/MVDck5uGBfLzlOts8eTKTcYlqUl3sUPS7zLADIq3SKFJE3qcQm9DMpmcpGXaP
         tGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260395; x=1715865195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVF7RLqsLPE1xxxlpKpUv52vvMK0xNvheputuJuYpRw=;
        b=Yg+WiaJXf2FV63VFDNf4J8WXi+0ZcCtCTWZA8w//T2X81fVpLXSPsrUgc4afgm5O+W
         wvl8lEuHh7xX88DKeOcnp7xjwdA7BnGnCT2K9PIunWmW7PC6ex6Og4NjCRr5yyg9DU5w
         aM30DKPpXDjZBQky8dUy07wudJje821f/zIdx126CnvXGJ1svjjXOaMEemPcrEh+9Sbe
         hJBYqHG7EI3nVfn+WrY54qPyG2+UHVm7cucNDfRZyxTZ+teJr1j55IdAswUDrTckAU2q
         MA7ICkebl8dYdXvMI3FW9/Pt1QgoghwaxTbdPFOhyOlurU3Gcjm3ZhDfqWzt8Fg7MU8p
         WbeA==
X-Gm-Message-State: AOJu0YxzhTT4iFP8O1oGxO99DG/hYMUltaBX9ZoZersJ8IEfVN0VgKnL
	Wrv7un/1mjkuF2otRJY89zoLU5aTGBdzr+tJtAVyjaj2oM0wNzpJ
X-Google-Smtp-Source: AGHT+IHnPcRrvgstPvXfIgMPzTN+bmewRUoxSBDzHuvLxS1rO/krjfDse4ngc6mW7dL+sMH1HukGfw==
X-Received: by 2002:a05:6e02:138f:b0:36b:2438:8805 with SMTP id e9e14a558f8ab-36caece74f0mr60888865ab.12.1715260394869;
        Thu, 09 May 2024 06:13:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346eebsm1133887a12.84.2024.05.09.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:13:14 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/5] tcp: support rstreasons in the passive logic
Date: Thu,  9 May 2024 21:13:01 +0800
Message-Id: <20240509131306.92931-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In this series, I split all kinds of reasons into five part which, I
think, can be easily reviewed. I respectively implement corresponding
rstreasons in those functions. After this, we can trace the whole tcp
passive reset with clear reasons.

Jason Xing (5):
  tcp: fully support sk reset reasons in tcp_rcv_synsent_state_process()
  tcp: fully support sk reset reason in tcp_ack()
  tcp: fully support sk reset reason in tcp_rcv_state_process()
  tcp: handle timewait cases in rstreason logic
  tcp: handle rstreason in tcp_check_req()

 include/net/rstreason.h  | 58 ++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c      |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      |  2 +-
 4 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.37.3


