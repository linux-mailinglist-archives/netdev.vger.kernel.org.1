Return-Path: <netdev+bounces-168502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FEA3F2B6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FBF3BF204
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375520897E;
	Fri, 21 Feb 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UIb1ns6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C56208965
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136188; cv=none; b=rSynKpSH5/IBcNGX+PVb7V72Rmiiz5k6YiTit/xSQlHuUCguotMdyd173uO0+cbkCCVjU7MqDTtsNe75Ws0SkLA7+/jdMIU/IeeiW7ItApHSze6rjGvTdJvKDjXyt/2Zh5roxwXMeYf0xkhp7NdnvEWXqPBv4Xlzf802R7b1eO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136188; c=relaxed/simple;
	bh=VuRk2rQ6jS0rYMJXepBxzZx3vmpYk3RK/PxGURB5X74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCTUy3424ir1R/2ue0IRFnL1RtAbTlYuWhYJ+bVw8yy6DoDvxyhXwip1y8RLEbIyBYzLu33QGuSJRg1drKZRp+lWGegAzrl5bR+FdV0lrhzhYtGfk4ke1L0lZBlgwj8nLzGFiaHqpo05SnxIhjA1C68oMa8fAUczBiWOVe6eLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=UIb1ns6G; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-307d4eaab17so1699361fa.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740136183; x=1740740983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN4584voZoALNYMNOO4DGl8MJ0k1uaDKF69K9TzX/9c=;
        b=UIb1ns6GLLyf15tCxnZjaIN2Nr6ApphDq9ORiPGY4+WP0pPMCRJiQSjuuWzLAfQEFm
         WEkQO6ZjVM2mhJVzCIvV0O7tB8nGrcaEh4wbIHN708fEoJa8v332thUamdO6gG190dSO
         5W7mlpmuEFBBcbOXq8vj/zdXos9yxeRz5u45Uxal11pEG10FKHTre8YRqUWcHRN7aJRS
         gK/ewwANPb+F52BMR1hGgcsU7laGdLjA/Z68DA9up4zCz1DR53qRNiQ3VCNwTvn0TQzb
         u1VYxsBXXYXrC+LvDoj+kuHIfly0xwYENSFvmH5E6kBAD8XkX+dz3xtCTBCMHMr0VHzM
         8nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136183; x=1740740983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN4584voZoALNYMNOO4DGl8MJ0k1uaDKF69K9TzX/9c=;
        b=EGYeVjeSeXJy6N6PWqyi1aghrAn575Me9CXp5HUpBXasaEgHxi7HSclT+ytK5fMiIr
         XBMMgGbqa9ujeWxdbi9s2ldGUPlFv6zCZpUbxzszJqcAtt+B5V+5QnMX2/QVdlNATOmz
         KuYPYRjYrg625DpHG6JBlwc+Oc4Hn/UnfIF/PjpjOUlPXjjkktnQjbWGPiwpwhDdr3Jh
         ZBWQfOv4jB5U8Op1eUL3SweebM0tMmJfHKq0xtUEn1un2fiEikJunaX1bM+vQr15tiUn
         xYiVfmNu/BZlRoaoFOWXoM2o6d4Nw3++8Uj+YpYUez2e8F35OZSnxCBtldx6Iyfk5Pxj
         QkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJpy69ZXzt1AGCO8A8+qukNdBh8SUNxy75/UQdqATwvt1ayXl0nrHGqBHedmVIQrEcqayUy7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxW0VK8epMdvsj5K5Um+WGSJz6DY8oRC/pfz+aELEXKl8OxseC
	TClRdy0YpY4JTFQAbc6GgKP8oj4HUBOJUW21mShoY7ZfcY2nTn287c9KYGolMzLTuPGuKc2ubdy
	dWDYt8R8DNjbG7BnIUDSpK5K1LCUZszX+
X-Gm-Gg: ASbGncsRq6krSiCZnFHqA6F0ObYO6Ujol602kgALAu3mcUKB3ZhDdGZeBKw8rW5kGsm
	cZWBlEenwUHldYScMYepsqGzaL3HW06Nzj0p7PnINqQZDQBrDvmkwMJlqD8bQtptJTC+h42Jc9V
	D5mG83Lo8XSxSdC6E1liHjfCdrgVcHKHYNe5EKSidt7bKbkdbrS44RDyvHxc/7Q6+qKaYKozJtk
	i28JvZiqu0l46mXjqjmgMRTIsKJQVBx9ciV1xGqkWNQG3wQxie6sOVsZbRCp01jsJ/TYTAaBRN1
	o9prpC/VA2P+Ttb7NbOAnOErmjYztkYAYjmwzbGmkE29Fj5NRBgQXnQQVHiZY8BepCUtnsU=
X-Google-Smtp-Source: AGHT+IENrd4JOt32L9C4nheK9HOt9/X6P7LLjli0+Aau3OLyan282XrQBQb78fpx1glfFvRaB8wpsDGLIGO5
X-Received: by 2002:a2e:a904:0:b0:308:e7f3:af0 with SMTP id 38308e7fff4ca-30a5996b226mr3149961fa.5.1740136183023;
        Fri, 21 Feb 2025 03:09:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-30a39458e10sm2061991fa.9.2025.02.21.03.09.42;
        Fri, 21 Feb 2025 03:09:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id C121213DBE;
	Fri, 21 Feb 2025 12:09:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlQuc-008ZCm-HK; Fri, 21 Feb 2025 12:09:42 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: remove skb_flow_get_ports()
Date: Fri, 21 Feb 2025 12:07:27 +0100
Message-ID: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Remove skb_flow_get_ports() and rename __skb_flow_get_ports() to
skb_flow_get_ports().

v1 -> v2:
 - remove the 'Fixes' tag from the patch #1
 - add patch #2

 drivers/net/bonding/bond_main.c |  2 +-
 include/linux/skbuff.h          | 10 ++--------
 net/core/flow_dissector.c       | 10 +++++-----
 3 files changed, 8 insertions(+), 14 deletions(-)

Comments are welcome.

Regards,
Nicolas

