Return-Path: <netdev+bounces-130439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE398A862
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDAF1F2366D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FEF18DF8A;
	Mon, 30 Sep 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxTFH2X3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3992CA5
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709788; cv=none; b=L+MITJh/9Tn5fa5Onxrg3dl8VM0LVhJflvvQVMo45+hSf9dTfEZOOW+uZRvGkS/Gq5P/K3cbO85aKjXvznXfPTXP2xuax3sYP1v5NX4pdZMzoTm0s8rlO9X51+k6aJ13qUHbZ1CVAgD/h70SOyAUaPJoVMHRFPHoVTqYhzsUPTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709788; c=relaxed/simple;
	bh=6F3WfmZZLMFsHFH/YOConu36frhNlhQGKVYPrDcbn6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n72vz3Io6KpCY8BTbZCR7mT02V28snTvV6Kq2WDd1duUYMx0rwZJLJDypnw0y42L8SCKecjWmFlnCLyH6l76kR4Xy5Wv9pCQYQVQLCnZ5EtTrY9LXcK1EaaWy8kOsZMuHUYXLrUXsheCwj9G1dtJo6NOg9yABsOMZLGBdCeYDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxTFH2X3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f8dc491so25137457b3.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727709786; x=1728314586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wtLH9jpd0PpZZ9goQRCr1u6YzXUJhVSrznB/rdtnqkM=;
        b=uxTFH2X3/d2z5tOsAEbjcpK3xyqKxoW76d2tKv7O7WStoAc7AcMHGMjgltYXWr0U6F
         iRf09WpKV12tfzr3onZ7GGJJcqlkIFINR/q6i8SxbjVjbQKi+eHc9SfrJMdq14fAe+HF
         rxpfAGTjhS+A5pTzTQ48shSGg7Xmg8yTCEHucUWjWiRT4Bjde5ap7q8h8ukjQBWtDuOa
         hAWKTj0bB2gFm9vd90xyXa3VvQsErorLlsyCWhVSulDoxrs3aJtUjo3LjMQ+yl13OVnZ
         iQA6Rx1vUf3ow7mkGO62PrjvnB4gw2Fw0ymnzKIXlxi+EFYZt7eD1DAgS0lYcDFTokLH
         qkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709786; x=1728314586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtLH9jpd0PpZZ9goQRCr1u6YzXUJhVSrznB/rdtnqkM=;
        b=QUxExa91ITFM61EDrItbuoVtVD5tj6kQmhUgbqM3v1p5PcIAS4d2ADqaWuCXNMLMQO
         YYqIUoknTHLCQDQr95sdHV7QQLrP5uusTD5NshEhDlbD7+ZJcKZEu60XdXnQfQ3VM6eK
         0OFTOTeV/MtTHhTaMfqhRo5svDygcYshyJfivCDOspLuTWRZv5+5rr76cKdc0+wVh9gS
         IoAhvE9huSx+tMzGscW7aLygIV1Pbyq5/zrWaVRxhNbheKNESQpAQ81mQ9MiyhVVUztU
         03arLtouWDf0BlL2RZ2rAWS0IEYwLk1yFI8giPZPqOnMlOfslt+kAosqsoPYIQsq/DKB
         zxhA==
X-Forwarded-Encrypted: i=1; AJvYcCUwcjZyU9EvNADwf9jecQBkDUp1xIH1InQaevNpiYk3y7hoAttOdYTDNm/WajJ9C4Mmy49YYOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8XMdTv+qatLtSLntOk3MUaBOFr1mYLdCJ5D7N5fL2OyE3tls
	b5gIBVayh04KQeXpZhu7FkqPWotbO40Xh3THm2bEhnGmfIWlf2DywiF/U6YE9RzNHwyLSsmz45d
	45Sh2nn+iNg==
X-Google-Smtp-Source: AGHT+IHi3hT9JDXfUWsmJxXkdAc+N9FuTESs1uypN+g0PxAYKrf1KHKT00PQ3UA/QqU0ZZcC22vUAk0MsiQziQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:488a:b0:6de:19f:34d7 with SMTP
 id 00721157ae682-6e24754e9a0mr4736057b3.2.1727709786339; Mon, 30 Sep 2024
 08:23:06 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:23:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930152304.472767-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: prepare pacing offload support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some network devices have the ability to offload EDT (Earliest
Departure Time) which is the model used for TCP pacing and FQ
packet scheduler.

Some of them implement the timing wheel mechanism described in
https://saeed.github.io/files/carousel-sigcomm17.pdf
with an associated 'timing wheel horizon'.

In order to upstream the NIC support, this series adds :

1) timing wheel horizon as a per-device attribute.

2) FQ packet scheduler support, to let paced packets
   below the timing wheel horizon be handled by the driver.

Eric Dumazet (1):
  net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute

Jeffrey Ji (1):
  net_sched: sch_fq: add the ability to offload pacing

 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  4 +++
 include/uapi/linux/if_link.h                  |  1 +
 include/uapi/linux/pkt_sched.h                |  2 ++
 net/core/rtnetlink.c                          |  5 +++
 net/sched/sch_fq.c                            | 33 +++++++++++++++----
 tools/include/uapi/linux/if_link.h            |  1 +
 7 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


