Return-Path: <netdev+bounces-60083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8BD81D464
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 15:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4BA1F21CF4
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85DD529;
	Sat, 23 Dec 2023 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="h8c385V2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FADDA5
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-781048954d9so205811385a.1
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703340125; x=1703944925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7R/2bDk9lZWXERudlbTjvKb59TzofmLv9XCU6Xn8E8=;
        b=h8c385V2YM50axc5tm7Jxtw0ir78t3AMiqFKpmAxdaJcBbDkXHzoFTJTUBMYEfazC/
         rmR9A9SCprCC9jrKN1EvP4j8eMKHfyP4kcgHVkxQsXU95RmTUHn2tZgxU68ucv8KcysM
         ODFotEaonz6t8hhw7jamk9KxBlRF66D7jtysxxwjGMI5P38yNSYR4Ox79TjMLFPkuu/X
         kr9P1563hnJ0U8hnXaL2m5Swfz+yTv1QZQXduZb0GhprYitYKK4bMeQ2uG8q4s5BdBkv
         OHDJPcBvaFu1FuTzUzNuaSu+PhStf7gKXNXf1EY2KUEj/ngxaNyfdM2pTBXKRHVUoKBb
         OQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340125; x=1703944925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7R/2bDk9lZWXERudlbTjvKb59TzofmLv9XCU6Xn8E8=;
        b=fKKlG2lHc2C9KOwRA8ohkC3uFBO8BnjO+nXJr7K4g5dn0HuoBS1zAzZZMlwFyRY6bv
         LSTm983YXUEMyjYQmYn4d4jCOhLlxEmg5mkotcqb4NAjThKCC4oHZhj7IsN4y1KKK0sv
         URXRchVD1fhTbsp9CMymVx2hJVDBpEkPu+/ewbcZyCewpqoxEkIMAzE8evziBOlH3kFo
         ozhNnhLsSLSVaQWAi0XO1mqWU94ZSK8FlCF5TKRKtyTI4bf7VCsbdcDpxcRdfZtTuolA
         Roy3LBqrK72ea6PrXqEMqsyBVa6y+WeV6C70OWayj8RqtGWdv6h4gtwly0ujHJ76XLDA
         +vog==
X-Gm-Message-State: AOJu0YyvzsLLfu4Z0sHAeMVyItw/yh8Yak3+XiOaV17RZ3F2c3zFqlcu
	ugXAVkxdkXYSQ0wMJcSdA5Ko7mZv9YKa
X-Google-Smtp-Source: AGHT+IGlAdUewqdATbPzUCUS6JbmACwNbwOXXhBnnlmU5vbESSqiHAPWRluYoJionTWwFG/OFJeP2Q==
X-Received: by 2002:a05:620a:22a4:b0:781:23f4:16a8 with SMTP id p4-20020a05620a22a400b0078123f416a8mr3293816qkh.94.1703340125530;
        Sat, 23 Dec 2023 06:02:05 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm2062968qks.77.2023.12.23.06.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:02:04 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 0/5] net/sched: Remove UAPI support for retired TC qdiscs and classifiers
Date: Sat, 23 Dec 2023 09:01:49 -0500
Message-Id: <20231223140154.1319084-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Classifiers RSVP and tcindex as well as qdiscs dsmark, CBQ and ATM have already
been deleted. This patchset removes their UAPI support.

User space - with a focus on iproute2 - typically copies these UAPI headers for
different kernels.
These deletion patches are coordinated with the iproute2 maintainers to make
sure that they delete any user space code referencing removed objects at their
leisure.

Jamal Hadi Salim (5):
  net/sched: Remove uapi support for rsvp classifier
  net/sched: Remove uapi support for tcindex classifier
  net/sched: Remove uapi support for dsmark qdisc
  net/sched: Remove uapi support for ATM qdisc
  net/sched: Remove uapi support for CBQ qdisc

 include/uapi/linux/pkt_cls.h         |  47 ------------
 include/uapi/linux/pkt_sched.h       | 109 ---------------------------
 tools/include/uapi/linux/pkt_cls.h   |  47 ------------
 tools/include/uapi/linux/pkt_sched.h | 109 ---------------------------
 4 files changed, 312 deletions(-)

-- 
2.34.1


