Return-Path: <netdev+bounces-48956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4517F02EA
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E40280E95
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2710A2D;
	Sat, 18 Nov 2023 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lalNSHdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF7EA
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b709048f32so2800324b3a.0
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700339900; x=1700944700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LSMU/ZukUtOx0B/ljZRjSlpSbsqtb25KF9BQkQx1OE=;
        b=lalNSHdxpdrUJP5cyGraBh49PPVrjZv3nlo5MKwt6savkR929iP6HbcbGVlE1KLgEA
         oaRuFW+l+HXwR3UProkd4il5IgbJbM365Y78Ee6vAxo2rRiUZPxKWb7xUPkQOfpLa942
         Q0Xdl5aq7mm6KjHCyM4P7OyUfL5bbWLPwIfma/6egEXKiPDUYdQDZenAXv4RDWMR79Xa
         DLH/i0HRR75lWHQsDuJZairMeRqobIx+7CnTI5vjdYeGT34YBwNLF8iUVt438pH9DgtX
         uoiQxWebic72qIuKi9gwIUjmUZJ3DjX0ylbVjEZPZPVj92sWv8bp+83WMAyaQv2ROpls
         O3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700339900; x=1700944700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LSMU/ZukUtOx0B/ljZRjSlpSbsqtb25KF9BQkQx1OE=;
        b=CvH8jeV86i6PlY1Mc4qzS2tWKU6iTVqWPM17bsY4LHaM0UA30ZR9aaKm7FxtWSHVHf
         eQ4zwTpP4nvX/+SsbdGunRNrfW3My70KceVcPH1mZ1VhjNsqs9HT+7Y6XCD19jCBVr9A
         TGIXqW12n+Kjg6i/XHMEQb6cHDrZZAn1eF6RJd7BUzsO3FQI+usvHr5wCp5YQPNEmq/J
         /CTsVsT+LAVvWSs6NUcRpvr9Hh4Tl9gzlDgTUHNmiqnIatD8nn71X/RosmLfh91AhrdW
         dBuyYZI643x6h4cvQBQ2yBzplIxrpk8eTfro8UrnBLRzgaz24xIYERv4gN/ktk/iMtuI
         Q39Q==
X-Gm-Message-State: AOJu0YzDsGyTTOVkTJt31yVHtjEJuDKz/psjPqOfZ19u90KZFn2PYHRM
	oZ/mHdapPCR1JoPA4CFL4fxNKA==
X-Google-Smtp-Source: AGHT+IFHMhPEwbGpAjkRwDPq1TB+P10y+mh5wr8RBXIjk6csddJYymbHAcyf7nQQoRod6oNDc//50Q==
X-Received: by 2002:a05:6a00:4509:b0:6bd:b7c5:f777 with SMTP id cw9-20020a056a00450900b006bdb7c5f777mr3274613pfb.16.1700339900429;
        Sat, 18 Nov 2023 12:38:20 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:b02d:77:2195:4deb:3614])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm3403875pgm.87.2023.11.18.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 12:38:20 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH RFC net-next 0/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Sat, 18 Nov 2023 17:37:51 -0300
Message-ID: <20231118203754.2270159-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch builds on Daniel's patch[1] to add initial support of tc drop
reason. The main goal is to distinguish between policy and error drops for
the remainder of the egress qdiscs (other than clsact).
The drop reason is set by cls_api and act_api in the tc skb cb in case
any error occurred in the data path.

Also add new skb drop reasons that are idiosyncratic to TC.

[1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net

Victor Nogueira (3):
  net: sched: Move drop_reason to struct tc_skb_cb
  net: sched: Make tc-related drop reason more flexible for remaining
    qdiscs
  net: sched: Add initial TC error skb drop reasons

 include/net/dropreason-core.h | 30 ++++++++++++++++++++---
 include/net/pkt_cls.h         |  6 -----
 include/net/pkt_sched.h       | 18 --------------
 include/net/sch_generic.h     | 46 ++++++++++++++++++++++++++++++++++-
 net/core/dev.c                | 11 ++++++---
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 28 ++++++++++++---------
 7 files changed, 98 insertions(+), 44 deletions(-)

-- 
2.25.1


