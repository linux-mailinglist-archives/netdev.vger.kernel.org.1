Return-Path: <netdev+bounces-95448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C578C24C1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5224281731
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734471DA4E;
	Fri, 10 May 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0L/ceFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C92581
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343911; cv=none; b=g+VqSSjAHfJPeQrh6Pp61lOAZfKIXawWf6V7XmZ4oWa8s+EmT1KgOzYFjr7Y0osoK1UWOH/tNDhzMPl4DxC/g+bSDcUtOPDgdrWWl1bicjVwbbpbocZDO6zy5ZQ/Rb9LWy2iPWBMwFsCdOF5eqehW96ehfXaJhax1bcI2fpY/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343911; c=relaxed/simple;
	bh=AIjz+6FfzPMd51cwEYKu9OTVo1Jtx7Ftmkp3bKckrgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qORDT191ZA4pX5lxJFSdPT2+f1SYlBuaxWNtrGu2FlAkh/zkRht7ujYUDRSLU+h1xa7ka9jVEltXYXy2+4pAqIcWdVFKBS9czR/UBEBDjPy7nT70KzRROcRrPWtOzelRz0L2lTpGowsZ8PfudTawDDHWpM8qnlkhCc21C+dOgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0L/ceFe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f460e05101so1453543b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715343909; x=1715948709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuvGQwJ78+nvfDV/a4Z4Shs4q+MjkBsQmIk3gm6vbBI=;
        b=G0L/ceFeN0eERNKFTNPRUZmgnyR6I+4TOynnBVfx+Uf/3EkeojyQqaCx1+SFWcJXJB
         imccgMKRscRB8s+zZAUH4MAv3ODK1TSONROI4Lx0BCdfWJbaerUj/DE/1Jc4tU8yagiQ
         lXwC8HSF7T+N4A9PXIG8/t/zasn8Ul9CnYs5BxFu1WaRiJzgV5GraI+x3JEIHOLXh46p
         p0gqt4Weq84MPGxnFyb3XfasCR/BteNZl75Wn/TswBs1SNV1+PB9Y2RJc1dvTIfx+qwG
         VpCZoANF2+gg/LzgFms62IkXRpYl1EmNHpfqg2HxOu5k/JBKE+Cs4gNfGnnJds+5E8gN
         spfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715343909; x=1715948709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuvGQwJ78+nvfDV/a4Z4Shs4q+MjkBsQmIk3gm6vbBI=;
        b=jKfUM9BuP+Kj79NTduwRw1H6tLdyOBAiqwuC+Dv/zGEL1NpKV9UF2uGCfC+nqbpHFf
         RpWO0frk8vRGJiXtmH9javJbKIEw/fKzTxqUSqNw1SONLdl82D4blfSVcPo4I+bmZrEa
         zLvT2WCCBEKkhEXjM76lLXnWc7AhqGWT33HZ82nK2ADJ0VMzaEhnOg1k0wnkPHZfGoa/
         rjnxRfaSHbQ2K4bzIY4yw7WQLF5lbMZylq7YRB8e4OCOhnK4Rin6J/Gz2rq6jbz1Hidm
         uHTnYF2vqmpxSbRHZbLLs19+OatSr4kbNhmKw6oRtz9qY23npheeWVqNilUmSC8KKjTM
         R2Sw==
X-Gm-Message-State: AOJu0YxtUUP5X9E4W7k4mqR8SDzDswe1bMWIVqQCV4q9leglCyaoNQkR
	rScG/MOxHTDwXGU11g8khdEybH9DxV4VWHfTrGVZiiZ9XnuPiyyB
X-Google-Smtp-Source: AGHT+IGRRrKFJ4/QSD5MQsnidy3nEsTCUsxMb1rM9/jpRtwGcB+8gSuZNx6gi56BVrdVgeAkkqQlLg==
X-Received: by 2002:a05:6a20:1012:b0:1aa:96e9:31c7 with SMTP id adf61e73a8af0-1afd142f81cmr6913174637.10.1715343909234;
        Fri, 10 May 2024 05:25:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f362sm2943530a12.30.2024.05.10.05.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:25:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/5] tcp: support rstreasons in the passive logic
Date: Fri, 10 May 2024 20:24:57 +0800
Message-Id: <20240510122502.27850-1-kerneljasonxing@gmail.com>
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

v2
1. add more comments and adjust the titles.

Jason Xing (5):
  tcp: rstreason: fully support in tcp_rcv_synsent_state_process()
  tcp: rstreason: fully support in tcp_ack()
  tcp: rstreason: fully support in tcp_rcv_state_process()
  tcp: rstreason: handle timewait cases in the receive path
  tcp: rstreason: fully support in tcp_check_req()

 include/net/rstreason.h  | 61 ++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c      |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      |  2 +-
 4 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.37.3


