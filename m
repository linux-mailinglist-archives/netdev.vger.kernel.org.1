Return-Path: <netdev+bounces-133852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F299973D3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28401C21971
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321961E131F;
	Wed,  9 Oct 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hx1NARyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4F1DFE24
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496521; cv=none; b=obFtkJ3hHqivc9olS//DIdqXRlZryN9avuuYwBPcB3cOA8VEv04iLQvup8SDeHzLq+zvjeYrHoMNy6PzyBm5sOt8qaFUqHV/rhbwbwb/PFvzHdwK9nnu9b0ZkVcTOKzqBzIDYxHAmJyiMKjbGoDSlcKgbEZGHX/m7cvo1LBG/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496521; c=relaxed/simple;
	bh=vGJLzVn6ACBjNyAxufJAhPEnZGXpgNZxXi22jQsdtlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjOiwDk4rt39pQbfrWnpcP27VWJYBSNvTfVE7C1TDmTs3AQKy8n5451EPGhrDJgRDkNu9z9DciT8pFSiFDG74g/IDe4YLcgFsNiK8vxCXDiZW9HqxU2hwzuljjkEfL7Mg7repLpFRrgTnp28Zx9h6GiEbXPMjiTUZH3W61gFUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hx1NARyO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea03ecf191so44300a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728496519; x=1729101319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HH/gzvG8N4NA1DWdDdAxFZw2FZEGnZKbz4/QrTFxK6c=;
        b=hx1NARyOL2a0DI7RBtYxOxfIZuY35W4mM01XcImPuOOAT//F9g5L8v2KX0jI/jOjuk
         7rFFDRKnCN+xw9M+xHVTkzqJ5oy8KHvGA1lPK5QnuD3kLJJ4iCLWzN6bDVYFkpYXiqP0
         RAlZqPNj0t3HcTbxeXk2PxsmorovdMvrSsgkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496519; x=1729101319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH/gzvG8N4NA1DWdDdAxFZw2FZEGnZKbz4/QrTFxK6c=;
        b=rDAYktSNiXWnAN1kX50uQhWKtXv/09ycnf+wcO6s1kxH0Ycv85aq5cqNLmFIjO3y6N
         X1kadP42n1Xmnhh8n3xvTqp1SuM0dKowG0MqDhTQe01ypL/JUZHZDu4HoHCmwj/RLlfk
         ZynNc8Ob+lOLCoX2s4e+UWlZZjt/SQeO3OTqkV03rXCQpXi8MUtcN5Y2+pHibh/tz4IH
         hlFPnDejX3fR6qYAh5BVFGSBfZcmLX/jsSFO8IdjCjNtjFEYLCqInWIJoQCytp5Hhp97
         7r+Vpj40FmwE67nsM+MT4+keyrPrnQSJ9063Gcs8KO+rnliHhZ9+7EsoxWES6N7WFd/k
         JIFg==
X-Gm-Message-State: AOJu0YwAIgvw+Fln4zYQDXW/QycnYbJzZ3N5w2oc/5vYwAwR5Idplu9I
	dyUUvcoU0jWByCAAtRYTCOgzq2RHKctWJmZKXI+XE27vRJ7IvLP6bB3j0BveZ2MKR+Fq6wMl2d0
	JyOcdyXYSmIIEFKiAvEzf0JYKB+2I97ycYmQUTXMPw8342vzQca5tOoF5PIyw4OfYVf6l+by9M5
	08zjRjfv65DHFymn+ZyROhXqCnrmJYYWk07vg=
X-Google-Smtp-Source: AGHT+IGn4oqdTz2c/4KgQ/JCXeWAlimaFO1vIWCBGOUjzPUnpUWNpMDvCnm/bUqgZsWrH4Un5kvs+Q==
X-Received: by 2002:a05:6a20:d494:b0:1cf:6953:2872 with SMTP id adf61e73a8af0-1d8a3c4e2b9mr4667261637.48.1728496518543;
        Wed, 09 Oct 2024 10:55:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc86csm8044685b3a.27.2024.10.09.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:55:18 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Michael Chan <mchan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [net-next v4 0/2] tg3: Link IRQs, NAPIs, and queues
Date: Wed,  9 Oct 2024 17:55:07 +0000
Message-Id: <20241009175509.31753-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4, now an actual submission instead of an RFC.

This follows from a previous RFC (wherein I botched the subject lines of
all the messages) [1].

I've taken Michael Chan's suggestion on modifying patch 2 and I've
updated the commit messages of both patches to test and show the output
for the default 1 TX 4 RX queues and the 4 TX and 4 RX queues cases.

Reviewers: please check the commit messages carefully to ensure the
output is correct (or on your own systems to verify, if you like). I am
not a tg3 expert and it's possible that I got something wrong.

Thanks,
Joe

[1]: https://lore.kernel.org/all/20241005145717.302575-3-jdamato@fastly.com/T/

v4:
  - Upgraded from RFC to official submission
  - Patch 1:
    - Updated commit message to test more cases, no code or functional
      changes, so I retained the Reviewed-by
  - Patch 2:
    - Switched the if ... else if ... to two ifs as per Michael Chan's
      suggestion when tg3 uses combined tx and rx queues
    - Updated commit message to test more cases, including combined tx
      and rx queues

rfcv3:
  - Patch 1:
    - Line wrap to 80 characters, no functional changes
    - Added Pavan Chebbi's Reviewed-by
  - Patch 2:
    - changed tg3_napi_enable and tg3_napi_disable to use running
      counters to number the queues as there is no explicit queue index
      assigned in tg3

Joe Damato (2):
  tg3: Link IRQs to NAPI instances
  tg3: Link queues to NAPIs

 drivers/net/ethernet/broadcom/tg3.c | 47 ++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 7 deletions(-)

-- 
2.25.1


