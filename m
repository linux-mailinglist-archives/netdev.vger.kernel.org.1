Return-Path: <netdev+bounces-225949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424E7B99CB6
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B094A5148
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59251301015;
	Wed, 24 Sep 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJjjshIk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA62EC57E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716199; cv=none; b=FPXuwXMhfk9nF8hbWyLrq7bMZd2oSpOpJvIG0mUi6Snw/x+FLC12BLfwfAnghB2qtTCB/YIQ0IRo+VYaI9tNbeZ1oDiP6PRMZGMq6o4QL3xWWnJ/pPX/iBRQ5N2V0EWeLGCiC92pxa2N8CAm8Q/CLtViIXvQAc63b6lXCLL1Wms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716199; c=relaxed/simple;
	bh=364lEeycBuEXMkJZD3BKEPubnd38zUnsS+qH235tx+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E5q8Mq2gjXjWDVLkLEEtyAjIjqSOMAnzsYM+QRqeb47/wETEHkqKYqlu8Yh0JhlMILqj7wWkYULnyvwwpXRXGUmxyMCssYyREwaC0G7d5x1ZeD/KAGObzcJNYVcsq7taWyw+d/XJ2CQtKSo0orWifJTCNKEmavRHU7vs9kd717Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJjjshIk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuPth1OMCQ8SbxKm/775cV+Dy82pA/caL4LJk1/VWIk=;
	b=jJjjshIk0ZgL9WbjS8tMHm78i+oQ/03D2Rx2/KBvtiuZMUkS4u6SASBKXepWvvD97T3x97
	6bXFQlUdjGHk3HmxxgmrYGovf1+AqaaiN/XmPMU9/A1gYKJfoBmSAXWRtEJq1xx6W4+Qdz
	2nLNCAOsZMc5HVIh44wvB+6MtuAfmwg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-W1tmtPbUNIiD21p5Hxcpcw-1; Wed, 24 Sep 2025 08:16:33 -0400
X-MC-Unique: W1tmtPbUNIiD21p5Hxcpcw-1
X-Mimecast-MFC-AGG-ID: W1tmtPbUNIiD21p5Hxcpcw_1758716192
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04a8ae1409so656183566b.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716192; x=1759320992;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuPth1OMCQ8SbxKm/775cV+Dy82pA/caL4LJk1/VWIk=;
        b=OQFXmUoLZZje15VFLYnl28I9SzjlaUcYW6Ex4GpccR5ff+JUL8q8AA2BdEAcA+JuM/
         1h+vC56aOnhqtdbbItrtYVVwcVvl+LAMnxnW2ej3HqHBCNRC9AFd9pizV6ZJDBx3+Es6
         odWAz7hVFhWu2fX5NjMHcjZRCIyPXuLmM1tKZ0lChgpjl/cfkU/RI2z3LBuM2E4j/uqi
         UCqtcC/JHVf8jjxxYzC+O1V/ZLf/m9lQhXFyRdXTgaQFKgp+0LEM/HVhfh30mkTvIvfr
         CMx7VmPJeK2EX3HrKXjdXSxYb99jWLiNm6d+TLatNSdftUQQYglYj4iXSUcdEix1WnNC
         jmNw==
X-Forwarded-Encrypted: i=1; AJvYcCVskiOO/eLkA7AMufScDJBURQDhi19xzN/5YC3q0BVzU9OWZstS0wn/nvhmz9kkO5O+nvDAg84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCS5PtlLxsWKopXJ20JGdIMg9UhIbpfSoLio3pfPmsyN6pfF2P
	XHoaYGwYXFwkw0oIYB8W0GVXjPztz2F2lCI01RWtYeLsgVs8gPM1PrznnHCOrjRb6Jk84gEox1X
	LIyU/DJuWb3dJnftRxe0xBhdTVyV6kVEgCubdhYs0dAKKDcQDD/UAlaAwUA==
X-Gm-Gg: ASbGncvcYovBntik9Pb3bgk7LVltH43PoMbvIW8sdcsDb+KpyuAS5MUJi1MSbIZZ+Ok
	iQ4V7pVsnjNhJLIuu5xP7ay9V/iYfmAqGd+s78UJlw92SrHL9R/3pyNwSB/AS/C/HfdmCMT984x
	eYFs+8s0USs1uOZKO03dpQ4DfPtpIYTxX+20GE+BBJ05ysY9fmRBkYcnXyFMOc8u2onfUgq5xEB
	cOc7CtPelMfaWwyqeKSom3SYlKU6YMNND4g6M9v9tuW8DaLZCvm6YBZfm9wwy+p3pRcyWZhuD6W
	j4KBTuE0ouox4hSXHiuxGFrYMU6dZluYlgN88K4YtYUzDSMvKo72w3kKo86Le8gFFTA=
X-Received: by 2002:a17:907:7e8f:b0:b19:4e64:4f1a with SMTP id a640c23a62f3a-b302c4e9e23mr502597266b.58.1758716192102;
        Wed, 24 Sep 2025 05:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDZH0PSUoiLS7X01leMKuEsxf5JPkNqDgQTQKpSLi7IeJxy/OrQqJ1qPDfQ2S/U+UVVai9Jg==
X-Received: by 2002:a17:907:7e8f:b0:b19:4e64:4f1a with SMTP id a640c23a62f3a-b302c4e9e23mr502593566b.58.1758716191604;
        Wed, 24 Sep 2025 05:16:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52aesm1097887666b.54.2025.09.24.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:16:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4AF09276E26; Wed, 24 Sep 2025 14:16:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH RFC net-next 0/4] Multi-queue aware sch_cake
Date: Wed, 24 Sep 2025 14:16:02 +0200
Message-Id: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAALh02gC/x3MQQqDMBBG4auEWXcgBrLQbcEDdFu60OSPHaSxZ
 mwRxLs3dPkt3jtIUQRKnTmo4CsqS65oLobCc8gTWGI1Oeu8ba3j18phmMH6GXmNooFDTHb0bXQ
 Jnmr3Lkiy/593uvVXk7Fxxr7R4zx/ZzX1pXEAAAA=
X-Change-ID: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

This series adds a multi-queue aware variant of the sch_cake scheduler,
called 'cake_mq'. Using this makes it possible to scale the rate shaper
of sch_cake across multiple CPUs, while still enforcing a single global
rate on the interface.

The approach taken in this patch series is to implement a separate qdisc
called 'cake_mq', which is based on the existing 'mq' qdisc, but differs
in a couple of aspects:

- It will always install a cake instance on each hardware queue (instead
  of using the default qdisc for each queue like 'mq' does).

- The cake instances on the queues will share their configuration, which
  can only be modified through the parent cake_mq instance.

Doing things this way does incur a bit of code duplication (reusing the
'mq' qdisc code), but it simplifies user configuration by centralising
all configuration through the cake_mq qdisc (which also serves as an
obvious way of opting into the multi-queue aware behaviour).

The cake_mq qdisc takes all the same configuration parameters as the
cake qdisc, plus on additional parameter to control the sync time
between the individual cake instances.

We are posting this series to solicit feedback on the API, as well as
wider testing of the multi-core shaper.

An earlier version of this work was presented at this year's Netdevconf:
https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate-limiting-across-cpu-cores.html

The patch series is structured as follows:

- Patch 1 factors out the sch_cake configuration variables into a
  separate struct that can be shared between instances.

- Patch 2 adds the basic cake_mq qdisc, based on the mq code

- Patch 3 adds configuration sharing across the cake instances installed
  under cake_mq

- Patch 4 adds the shared shaper state that enables the multi-core rate
  shaping

A patch to iproute2 to make it aware of the cake_mq qdisc is included as
a separate patch as part of this series.

---
Jonas Köppeler (1):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq

Toke Høiland-Jørgensen (3):
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 include/uapi/linux/pkt_sched.h |   2 +
 net/sched/sch_cake.c           | 635 +++++++++++++++++++++++++++++++++--------
 2 files changed, 514 insertions(+), 123 deletions(-)
---
base-commit: dc1dea796b197aba2c3cae25bfef45f4b3ad46fe
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


