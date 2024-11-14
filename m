Return-Path: <netdev+bounces-145031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7E9C92A1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE08B22D58
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FAC199FD3;
	Thu, 14 Nov 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="aE83gcD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441416EB4C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613876; cv=none; b=hAEqsL8V/dXvLSIjBDNAKgJUrE/WCMHqZXXEXVxWy/xgBDQiW+lHA+ltt1XgzAuIpD00tmJ26792SKO+aUwJMxDwgNJO4k07s2vlmO3WMZoiHP1ZK7Rwa1z45dTUzJdLPBgM+zgfs61vnds3XGjuDV/d37uiGT+0h3xtZO19oBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613876; c=relaxed/simple;
	bh=6Jiy1XQtVz3ggjpXB78+B5kVI9PN3UAJnrOhRftuiXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2NXWNg3xsWkEDQsIX0mxEEnQPoNsRvN8KTqMTLhnYoXNtvkqNdHHC4CjFoXQqzJB/dqYMUASnW+UC02x21xyxHr+3wH0eWXHkMG8y7P+6RtbHY6QXnvuGRyugsRPFMge29K622cme6DEMkKk6mWz1UeVaeW5ua0RijjdlUsgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=aE83gcD8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1012197e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731613872; x=1732218672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+WUtALkjSye65cOuODIzVIJuEmqRgNvoIJj5DWFwQU=;
        b=aE83gcD8CchvJe48ngkmnIKcJV0/Jjm7rZv7IaSB45eNRr7388CGC+YkcQXOq466px
         Rmbum6ds5NDtBwJW3mZcmLf2884IaKngXOIF2JuAsXPqZsZ7jxmZVOBbcSm2WDvdDKFE
         gR7EF6CsT5jMrBncc+FCWpXUFpPUqoVuyY7kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731613872; x=1732218672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+WUtALkjSye65cOuODIzVIJuEmqRgNvoIJj5DWFwQU=;
        b=X2q2QEWdstkprLBYqCeCnesvegvJWf4gZiyc0ni0Zy3tSo39+tPW8nVL6fdZlCk0HY
         sgfFuhU6zZd/P9NR3yG5LABZTscZBHMshDl0kJ2amQaDHWncaxQIsN8LM4yY2xc+WYP2
         V+FiI0pOZLYnB7csagbQs7XZI81oiWWr8vK+fn/tUGTQ29rSHbRGEnCYoR8L7FcFd76l
         Cr+0OFTDMQiwdmjHT+ZcGMVssziW/ZKHbClU9iFFugXihwVzsUrQ1gnxhDk/1HJtFTQW
         hT75mN40ysm+g0I/gSW9grE/1X/MZnV0oXgIM4jk7ZlytUqbdEtVJTbau+jSaGhPvSJ5
         GSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgvxA69BUq0IeTms/DGju/2KdueI9+dnMETqir82fVJKDAIKCguhFJs5NYyqJZgxe5pAl9TX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IMJD8w27Pw40Klv2IMooWOLoY4NwtGOtY9ep3u9k2ZmskjjS
	k61YIFvIeKtbg2lflkWiWTEg9VNHMmy1rSeNDfXkjL+Zwz3AvFTHnFu3cpk6H/0=
X-Google-Smtp-Source: AGHT+IFJYFAKSN4vXxLSb2DTOieOWfQk536o625a5AAAchNjruC3YUkGAlycamJngjPvHpRkjvBljA==
X-Received: by 2002:a19:914b:0:b0:53d:a4ff:317c with SMTP id 2adb3069b0e04-53da4ff3214mr1588261e87.43.1731613872230;
        Thu, 14 Nov 2024 11:51:12 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530d81sm288780e87.160.2024.11.14.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:51:11 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: pmenzel@molgen.mpg.de
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	ernesto@castellotti.net,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	tore@amundsen.org
Subject: [Intel-wired-lan] [PATCH v2 0/1] ixgbe: Correct BASE-BX10 compliance code
Date: Thu, 14 Nov 2024 19:50:46 +0000
Message-ID: <20241114195047.533083-1-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
References: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
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

Changelog for v2:
- Added Fixes tag as requested by Paul Menzel.

Tore Amundsen (1):
  ixgbe: Correct BASE-BX10 compliance code

 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


