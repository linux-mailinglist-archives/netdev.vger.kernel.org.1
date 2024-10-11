Return-Path: <netdev+bounces-134508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D341999EAA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D32C1C22968
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388C1CCEEC;
	Fri, 11 Oct 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUxYFDVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05C19C564
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633692; cv=none; b=PPmktQ4fzdBtc3aXMZqt0jW75M5wbT5SX17Xgoe2APBkiK6nuw+ksCPniq2MhIkwJHcSABMhzXp5pgwJmaXv5af3c7vUlbjCcSD2L0OFON4YfmOFAwHJphSR4eCbB71PMIuNcqUj5zo0jjLnyG6cCgmNeQMyB2Hxwcu+SMS0fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633692; c=relaxed/simple;
	bh=wA1T+ZLc/oUEGkpVEdoTWv6RydQge5mAAxllVpxb2Y4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oq8nx8K+Eyi7sC8mKeIs4240FZTDAB0EyrB8NRtBpeDdINgFQGkyhWV/vgvb2UDWlYTSEujdg2VMQUwQfyG+IebcEyeQxBCXqE9N+8SLHgwT7WMLvyc0hlEsnm6nWFvLmhcenAQu4Kq3JIes7Ic/Y8kp32r7nUM9b82Z0+8Mblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUxYFDVt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71de9e1f431so1449340b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728633691; x=1729238491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGPP+sE+c3L70NuisGU53gjppfuyNIfq5ndN9CvF8GA=;
        b=XUxYFDVtY948DD6x9/KWZANdOdRA7cZiX61ftiTjoU+k9quGzSeG5u1XtxND4W5ypY
         cFGyxW7LHpBdCXle0fe3ucsGktBDdJgVm/rqIPPZWSdb5N7TpjW1hc7352qohgDx5VLP
         dTIlalBQP6DCqjxMLOua4qUi9rLwvDHqNaG2g8Y6rvf/X2KCCCh4O2W9+obRRxmUSe5a
         rSD/0mAziE+3GrFiIq9ytgElUCjCCS1y9gbCHivCaPEGcFbY6hme1flcXfGr61PwhSC0
         1ztLvLO7p9BquNRtNIPUE14XP8l8+9w4eOK2HR/41RRE9qVDGFPl4k1Ebr1QKPchMGId
         R1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633691; x=1729238491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGPP+sE+c3L70NuisGU53gjppfuyNIfq5ndN9CvF8GA=;
        b=U5O882nLFFeM+mb7UUS7mj1gSOFzF1LJjouAX0RCPYcgjVue/pWsXwdyWYYZaScZqp
         K2QEKM/vJhgFYehy65a292KwgZF7nwqpr1Okn+1quXx4NATsGe+Gm9Qbtqj0TXszBegf
         8In7BKCMm/fIbc1F3oyelhAQxw5WqubuD5uIQ9f51b6xF7Z68CXQ/R7ddsbWreYLXDoh
         mz8m6Iq4oZ2Tz/oN9XRW3yThGOII3QTDtMcwLk4YT1ah5J3l36e9aJRodr96I6C5XmEE
         SIWuQYsz0k3oJip/1gpnlRH7CJ+sErgx4hNcmW1hAfOqpSDvmkY5Pp7lWX8Auehdlnlp
         BUUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9uHg+UlYyLuxhPKnwQbZIQYHAF+pQQ8NL9g0NZr8VvxACP7A5Lm1T1+cAHAnWZ1wzTC9qRmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYush30ggqD0uR1ZRVbGRZzosinbOkt/MlK8090ba7tMQTO9id
	4zvKGmhRukOilSyFcGqu1PDx0OqKtYDyeOmHwxpwbFbfFE3sTNqpOl5Hew==
X-Google-Smtp-Source: AGHT+IGFdnoujpYFrPU6kYqhdadtzVCiK29uL4vmzglKXfjFmiSKNw9t9sXVVeT7S0gTCGppzqf01Q==
X-Received: by 2002:a05:6a00:a15:b0:71e:14c:8d31 with SMTP id d2e1a72fcca58-71e37ebb999mr2980843b3a.16.1728633690544;
        Fri, 11 Oct 2024 01:01:30 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm2126908b3a.199.2024.10.11.01.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:01:30 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2 0/2] iplink: Fix link-netns handling
Date: Fri, 11 Oct 2024 16:01:07 +0800
Message-ID: <20241011080111.387028-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling something like:

    # ip -n ns1 link add netns ns2 link-netns ns3 link eth1 eth1.100 type vlan id 100

should lookup eth1 in ns3 and set IFLA_LINK_NETNSID to the id of ns3 from ns2.
But currently ip-link tries to find eth1 in ns1 and failes. This series fixes
it.

---

v2:
- Rebase in regard to
    57daf8ff8c6c ("iplink: fix fd leak when playing with netns")


Xiao Liang (2):
  ip: Move of set_netnsid_from_name() to namespace.c
  iplink: Fix link-netns id and link ifindex

 include/namespace.h |   2 +
 ip/ip_common.h      |   2 -
 ip/iplink.c         | 143 ++++++++++++++++++++++++++++++++++++--------
 ip/ipnetns.c        |  28 +--------
 lib/namespace.c     |  27 +++++++++
 5 files changed, 150 insertions(+), 52 deletions(-)

-- 
2.47.0


