Return-Path: <netdev+bounces-86851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477858A0776
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032872888D1
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF11613C800;
	Thu, 11 Apr 2024 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xWdhQNFY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DB13BAEE
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812304; cv=none; b=fGn8ryAz5QYMavKeLdkO/FQKSl60CQulsCOaTkphXv/8jxdF3JxAbg1BhOoBKgV1PzN1cBhK9X+fmcjaYtMQEq82BmXkbDA0xUr8irke4AbaxcePPm+EmOp68wTIKrUlNOTS8X6+nQFpee5Pe9rqwLofRLYQh+zb0hgL+F50H+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812304; c=relaxed/simple;
	bh=eqKzfNEMu+huefit3g4pn5FoMsoCmnjs0w4DjLQ9syo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQR9vESaS163RY3VTVruXD6e50V2vRt+g4BoS37MPdeImJipI9AqZ8iDXK4vkytePQGI0Pdvel3gwyLUT2FBonRiKNP9NN5CMWSfaKOlk42NF/QVYmWGBimkUj9AqcCWVsk9h5uxkdX6hfNUIEBi346gbQmUntrvaF71uQAVpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xWdhQNFY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416c4767ae6so9986645e9.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712812301; x=1713417101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1XDD90AWzc/KDkSNe2VgDtV2pTCGWasSc0lX5ppAyo=;
        b=xWdhQNFY8XWkockbveuV4gAXGxvGhJWtPWASj3iKU5oosO8utPesy2ukjEEEPfOuif
         Lj7Hw1lkEuqpe6t26DTPUDZqvX7mThM+VCwoQPN4DdB0Zh1cNimBJM3RF8TnZ0ciwiAW
         zaF6Y5/xdzCb2iqF3qPjIysDTVcY707SnQ2SczXsmPc3maM2MdbN+bROvlXE7tGSBGA4
         mcoEJCtBQYha5+1il5eB6bXW6eE6AW7eV05ti2TWpoFl8rI16FBmwdiWxvtmVCxuhzW1
         gkkW3zwM4U6Sy1UEiuD4twcps33fU11L3rbncUN/9xQjCYRLvrY0ll0bjyFi6MQmljfO
         xVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712812301; x=1713417101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1XDD90AWzc/KDkSNe2VgDtV2pTCGWasSc0lX5ppAyo=;
        b=D3bh5zjeMmR6Ri5awHeKSSu+z99DNlufIJUymy0JdqmHSMXC+dCNi95I/pjqtAKDPI
         P4xFW+mfE3SXDLtqVsEXn017I7FYxSRv2gMlCU6xaKl7NL92V2Whm4xsKp3gzViUXKfR
         gM0Is69Iv20Ik653t9ptaMwNt7XS4TgtC3y83CJHQcJwTh6SPn9UQ8eF5QcZj3rhfqyW
         QyKeFDOd0hbLSJ0s9WJ4x5cBR42IFoEOQzo8GHd07RBKjF9tsqqLqZIWs26Eh8PnYqMJ
         5dGoWqqly8v4eV0aoDZ051MvWQ7rMsYa4S4exlWyNW2A1bDEOw8hxsr75gueobX51wS6
         SIgw==
X-Forwarded-Encrypted: i=1; AJvYcCVzFpl1yktUScIkCPunHbtuHB6Kl+P1h3joxZYkT8wNHdrOUQ/WqYGPkp3YudAzLReq9CgFNdCIyhEvErOkuKW62oEqbBXi
X-Gm-Message-State: AOJu0YwjeVEmrvLa0xBsV4Lwv+TFZDXBbmTkjfwPTBp5n2rKhj7FYKEo
	3m5zAp1r+vren6tF9B5Py6r/UsMaHO8Ghr8UUNDYEEd54JDZb2jP4Zb7zkdBrak=
X-Google-Smtp-Source: AGHT+IFrsYS9Liwv2FaXJoTlVoOGxdTxr8zhnBZ1Zxxsie09N3MqZMCUxKWrFSuqivi0LdxMInoJoA==
X-Received: by 2002:a05:600c:1d21:b0:415:5fd6:44c7 with SMTP id l33-20020a05600c1d2100b004155fd644c7mr3232445wms.27.1712812300902;
        Wed, 10 Apr 2024 22:11:40 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:46c7:8900:15f8:24e1:258e:dbd5])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b0041622c88852sm4370190wmq.16.2024.04.10.22.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 22:11:40 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH net v2 0/1] net: change maximum number of UDP segments to 128
Date: Thu, 11 Apr 2024 08:11:23 +0300
Message-Id: <20240411051124.386817-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
Fixed placement of 'Fixed:' line
Extended commit message

Yuri Benditovich (1):
  net: change maximum number of UDP segments to 128

 include/linux/udp.h                  | 2 +-
 tools/testing/selftests/net/udpgso.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.1


