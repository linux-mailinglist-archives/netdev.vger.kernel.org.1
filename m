Return-Path: <netdev+bounces-123386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0575964AC6
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36051C23208
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD021B3F01;
	Thu, 29 Aug 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wSpyoNFd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4531B3731
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947073; cv=none; b=WarmMEwy3TucmZEhgX9XBK6eTWrCVLhe9AzCOhjVPx+mVkZcHo+EO2ByHusfGZNb4DgJblVA8Odrkr3z7gvVrNSNKdYT8FJbgQ4n7LfcntGRVLLK+mFcHeoKuE66W9VszcntkDca7wVY2hoWTeQtqe6HQkA1k3Dpi5ouch9RC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947073; c=relaxed/simple;
	bh=BjQzomJdfelQle+FoyKCfNVMJnt/w3H756pm8LAAsZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNTbfA5O0w2VTh/cRZ2zYKRE4p4iwwnQDbjP18N78fMrVVK9B0+xFVyeAd3lbaOdaeZFucLkUZ2YVpEUQqEOsOunvE8qP5a5GPVuuFWmj8Wk2wbddzcPASu+RCmAas2Ei3M/EqAZVvq0OEb1q+EHQtEu9WVDGwVwCDur9r3y/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wSpyoNFd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141e20e31cso698969b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724947071; x=1725551871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/41oDsZHfxhcl1cqUKA01PWjnJrjTcYi52+9QxRI62A=;
        b=wSpyoNFdEh10hAqmGC56DeP0G5vUzxzxB3mY5K4cg0WB1ONH9vvaczzDZLlITE2N6n
         GYDqf7y2rbYjeuQDmj6GAG/JIveq7pcHL2CWWqcpVuKYb1gfNI+wWvVlqNWwDgEF80dL
         TwljAMLA92vo/opYyrZbUcT5Jsy7DREYwpO1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724947071; x=1725551871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/41oDsZHfxhcl1cqUKA01PWjnJrjTcYi52+9QxRI62A=;
        b=WjJUCpel4ylZo03um5bIoZFfpMCvXl28xM0X8JvSM1yotrz+2T9Mzh/OAEUqQryIAf
         dnMXWV0s7Ngkul3+WrRP+GOPXbnIQ6bKU2EUhtbnlOgr0D1DgXvsQCkeTgwmS8iaFERg
         vbJT1ONWkxeigiwyVhFFMw/ZGimnSZAqwIxqSFhjQ0l/Go4+7BPTJIo+OUNZ9XFv9Um5
         A6p5tkk22gcIhN4tAKBYMice4SQShRleu5goEgepaZoDEU5jw416FjhgWnVnRp0dE5j9
         sWvKVULTQJgRii6/mVA7nxDPrWJb0fGyuXKYBs1GqSq0W0WYUYzJQWGjKQsNzC/4mOLy
         1i4A==
X-Gm-Message-State: AOJu0Yzi7gU6sdLTGGAYmo0vxf9gwt3hJlbavkEOHmxOtYj7KSd8CXO+
	0Qe/U//VIvvzxh0e7SYBQ44c8yNzKVOz+zfoHlqb/+cLf6kvKc05HMPEIeSihpvwcSfRrhQqSo6
	nDDiZPuSblc8gY4vVjhr9lX3SEnQB+nMCduhZ78d8nm3Mby6m2KPKBOslix7umaiOkac4UBuEW5
	flulrY7uwnn/1JEuR1ztkJumETjGqRGtorSQ2pyA==
X-Google-Smtp-Source: AGHT+IEN/5x5JumXpn1GxODDJHBpZA1fqwxshkNBrm3W4Pi55CCH9podw+EpN5OXTvwZkSm6rfsQDg==
X-Received: by 2002:a05:6a20:d8b:b0:1c6:b45a:df51 with SMTP id adf61e73a8af0-1cce1022303mr2371314637.30.1724947070902;
        Thu, 29 Aug 2024 08:57:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569dccesm1294592b3a.136.2024.08.29.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:57:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	edumazet@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] Documentation: Add missing fields to net_cachelines
Date: Thu, 29 Aug 2024 15:57:42 +0000
Message-Id: <20240829155742.366584-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fields, page_pools and *irq_moder, were added to struct net_device
in commit 083772c9f972 ("net: page_pool: record pools per netdev") and
commit f750dfe825b9 ("ethtool: provide customized dim profile
management"), respectively.

Add both to the net_cachelines documentation, as well.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/networking/net_cachelines/net_device.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 70c4fb9d4e5c..a0e0fab8161a 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -176,3 +176,5 @@ netdevice_tracker                   dev_registered_tracker
 struct_rtnl_hw_stats64*             offload_xstats_l3                                               
 struct_devlink_port*                devlink_port                                                    
 struct_dpll_pin*                    dpll_pin                                                        
+struct hlist_head                   page_pools
+struct dim_irq_moder*               irq_moder
-- 
2.25.1


