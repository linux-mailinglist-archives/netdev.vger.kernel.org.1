Return-Path: <netdev+bounces-52915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E0800B53
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07474281380
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A72554C;
	Fri,  1 Dec 2023 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="EB7lMl11"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997110E2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:58:48 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9b5b72983so27925401fa.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701435527; x=1702040327; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6nPMIeiOzXojMtOnec9dlfj2tC6M+GsyaRnfz50osY=;
        b=EB7lMl11UY1P0KDuFap6sqcY8ZodnRZ/rMZ2JLkkTcJ1v1rnC1LV6Px2k3WkvsYEWQ
         6huWq1MnfbkMU9xFgXEzQYPr5wSFv6jqQsPqR7jHm8t9Q8wZwLtu+ufyv89daLTho1KC
         uKeGA98alerPnnHx4FHB2k0L/RV0lm4VG6YAT63tSQhNtzX11OaaTerh1bWtbLFNWszf
         nbxBn8IbBmO2Ujs8BGd8LUROxudQj9nGdpXBxJIIo6fgkZ27+NjCrK44JxMqk6AbkIw3
         5ZLX/70jUFR+9T0nY26WVr8FH8jmJxV17t1KaSdBHRBJOA9Efk07PSEWSNJsmjB2Wz/X
         ZnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435527; x=1702040327;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6nPMIeiOzXojMtOnec9dlfj2tC6M+GsyaRnfz50osY=;
        b=Mtc+wwTJZIZrvYPhaJ4PasOSJaWe2C88qp+GkX74MTRXxQ0sOvDkcWbh2W6lwVHgx4
         iE2u3MVLcQAqP4EtVhY2Pq5sCouG7zUw2Ns4PB+zB5OL4ZjteiZSOSlwhN44uysbVhOJ
         ubzue0ZzIykA+qNllX2Qi2QTE+xHaLPZicRNWta6KrH8DgCopFXLvkkxmqr+/dCQZ/id
         pet3rXRZZdeznC99cKvEh0oYHRqwwwQi/snCZ8ncjRoYloEsIxHgDpMx39LqJmYuwfbE
         C42JVYEOfOwo5//rzhDIUoPNjJU3w3RHajB3bsU5KtwCatib3FeOlEwaClebKY92BMWI
         Ieiw==
X-Gm-Message-State: AOJu0YzP5ebUViAGh3kGVktynvVSGDamQBlvvs0R+fatzi2va3/YYf0z
	sw70yMu3vpaQZr+xZQ7AWBVyIA==
X-Google-Smtp-Source: AGHT+IHONMOZIyUDFFN6eU5oJ0ZXKF+mjcNGH45TJTId6KrCw9eoKyFNHdjMtwI7/P1W8RxBletgIg==
X-Received: by 2002:a2e:9911:0:b0:2c9:baac:2e8c with SMTP id v17-20020a2e9911000000b002c9baac2e8cmr787430lji.35.1701435526566;
        Fri, 01 Dec 2023 04:58:46 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b002c02b36d381sm417036ljo.88.2023.12.01.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:58:46 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] net: dsa: mv88e6xxx: Add "eth-mac" and "rmon" counter group support
Date: Fri,  1 Dec 2023 13:58:08 +0100
Message-Id: <20231201125812.1052078-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

The majority of the changes (1/4) are about refactoring the existing
ethtool statistics support to make it possible to read individual
counters, rather than the whole set.

2/4 tries to collect all information about a stat in a single place
using a mapper macro, which is then used to generate the original list
of stats, along with a matching enum. checkpatch is less than amused
with this construct, but prior art exists (__BPF_FUNC_MAPPER in
include/uapi/linux/bpf.h, for example). Is there a better way forward?

With that in place, adding the actual counter groups is pretty
straight forward (3-4/4).

Tobias Waldekranz (4):
  net: dsa: mv88e6xxx: Create API to read a single stat counter
  net: dsa: mv88e6xxx: Give each hw stat an ID
  net: dsa: mv88e6xxx: Add "eth-mac" counter group support
  net: dsa: mv88e6xxx: Add "rmon" counter group support

 drivers/net/dsa/mv88e6xxx/chip.c | 405 +++++++++++++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h |  27 ++-
 2 files changed, 288 insertions(+), 144 deletions(-)

-- 
2.34.1


