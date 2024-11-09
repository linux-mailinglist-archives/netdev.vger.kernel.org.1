Return-Path: <netdev+bounces-143563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401039C300B
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 00:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645AC282301
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3A719E994;
	Sat,  9 Nov 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="SUFe1c1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFB15383E
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731194815; cv=none; b=q7mhn3CNKA43rLWjGd+1E0pry42TyhJGS+qSK4pA1KeGjTlavv/pM/vuMbpi6jiU+MJ/5VK+PWmtm9umj5KJvQeE0dugBqKSeWKnVxf18tOSnDRhqdLHIcEmdY3LyPVawH/JpFZIhO5Gi+KRnp9hhWPTPYiqKfKmNJHgR0SVdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731194815; c=relaxed/simple;
	bh=Cpk5ZBU9/k8RYhqX6ZYvMJrLN1gNQ/ahlhBBu9GJFjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uso7/G+MjrPYjdCu2XxpbwSRZxFRiq92i8V08C6Z4R+cKMv3SkqyJDimhApgiBXm5zV7odWcXnF2wpXvY0C0MT3vIJXtpMWHNhMSLgDV1mNzthelKCSo0RhV8mxrURtZh7RXeo1NJFH4g3SZuHhhnFR4iCghX/t7E6k0VfosShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=SUFe1c1t; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so39357511fa.0
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 15:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731194811; x=1731799611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKYtXxX3PpnBma4nIdw63BnV/Ds5TXBbvJ0ct3MPA5Y=;
        b=SUFe1c1t9D6PUcua7oE3VK9CXxzUbZlJzS4dk9dLwqomo2N70Mfg8ZjX1PxqVKseBV
         44s/MvK52DWW52YYSzho98VrGByHk4QxtReanl34h1EznVnI/9WMcfRlH0l5iVAKsbzB
         0+KsciW38uFA95xEv+ClIh0Rgjra9Qamizwac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731194811; x=1731799611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKYtXxX3PpnBma4nIdw63BnV/Ds5TXBbvJ0ct3MPA5Y=;
        b=fLs83d7W0l7qinI/86cwXZqkekOPyKA63A2NsZPuYe6zPYal3iZqkGLTt/9PsL2J8u
         rVjvROZmBwHKMsg/RuMxszhdmWJepSWQYpBxhKt6cGbf43qdWVdgWS518LF43oAv8nEH
         HFlskPktBubqHV8PARXXDyEl35OSqqs6PN6PjaILjzf9DsJhfV5gEL+x26g9/Fk0Yonr
         PIrE0F6YZ9NPoMNdm9KjMIQxosY0HBvjjFrKSOvYeCqPhmcIfKVLxsrEv4q9TedKPMTO
         7/hsF5xBgbLOeQvrUny0r826X5JgV55OAKOJuod3JuOtQCj9CfN+pCfVor6NpcJ7lX7i
         NXLw==
X-Gm-Message-State: AOJu0YzfSL3Xk3K3L8ldWjJn8Iey93uYrKCDOyt8Pb4DcfYLKJZQVpp+
	nWVFyUEi/pd75U3DskEVHnvbUyLDWCOT5+TQCLqwf3b2juF+B7zy0nQcLg/FUB0LSLioiaMY5/p
	o0SY=
X-Google-Smtp-Source: AGHT+IE+4osdFH9b1wj1O8ionrC7MCM9mzuduMTfaES7SFRNmeiLoeGcSrqhKnSBDH+izun5KD+urA==
X-Received: by 2002:a05:6512:485a:b0:539:fe02:c1fe with SMTP id 2adb3069b0e04-53d85ef6c4amr1982226e87.16.1731194811244;
        Sat, 09 Nov 2024 15:26:51 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826aeb8fsm1057142e87.239.2024.11.09.15.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 15:26:50 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Tore Amundsen <tore@amundsen.org>
Subject: [PATCH 0/1] ixgbe: Correct BASE-BX10 compliance code
Date: Sat,  9 Nov 2024 23:25:56 +0000
Message-ID: <20241109232557.189035-1-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code in ixgbe_82599 checks the SFP Ethernet compliance code
against IXGBE_SFF_BASEBX10_CAPABLE to determine if an SFP module supports
1GB BASE-BX. According to SFF-8472 (section 5.4 Transceiver Compliance
Codes), the BASE-BX10 bit is defined as bit 6, which corresponds to a
value of 0x40 (binary 01000000).

However, the current value of IXGBE_SFF_BASEBX10_CAPABLE is 0x64 (binary
01100100), which incorrectly sets bits for 1000BASE-CX (bit 2) and
100BASE-FX (bit 5) in addition to BASE-BX10 (bit 6). This mix-up causes
the driver to incorrectly configure for BASE-BX when encountering
1000BASE-CX modules. Although 100BASE-FX does not pass the nominal
signaling rate check, this error could lead to future bugs if other
codes start to depend on the incorrect value of
IXGBE_SFF_BASEBX10_CAPABLE.

This patch corrects the value of IXGBE_SFF_BASEBX10_CAPABLE to 0x40.

Tore Amundsen (1):
  ixgbe: Correct BASE-BX10 compliance code

 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


