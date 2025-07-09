Return-Path: <netdev+bounces-205359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84324AFE4AC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942AC3BFDD1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3F2877FF;
	Wed,  9 Jul 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IDlFllrl"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242F283FD3;
	Wed,  9 Jul 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055039; cv=none; b=lohLcf0pmGwEj/bX+P6UlOH3D6+WM00p2tYCZRtFX+5+hTNZ6dc0aBfGedvsXDRnGRuCfbE5shCKCchKgkqC7mhkmSqMBnDrP4uQmKFlUVFGeWDM1B/4QYIaAOx5yJ9d8Acify5LPS3L6hw/8XDaj6b508ZbpSHPvXP5mzuq6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055039; c=relaxed/simple;
	bh=vterP2lbqJfVM+LRua662GVvAJRfre8bg+d7uhEXYgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qi227FTkjUl+IyJvKb3Itn++KkC0M3hsKOabG9tnJg/hS2Tqo6H4i5gShL3TJLXXIqMHk2Cq2qPdhuyMWvPQJv3Eb+Mq4BcoHBZmR36c1inK8ReOwhUcgs1J0XYnfBA931PWypPHf9mexsYaWBjczswOTZCgLFvgfQsYmgitV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IDlFllrl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xg
	REeszcf2ZOBM/naDNg6kKErMTPAHGiqhxpYs2RS0Y=; b=IDlFllrl+oXEJ5lYvS
	y6kQCiL7kNihDM5e3kdZ0RbDsngYtaOmbP7uDW/4/HxDdg62IMVnw2NPTY8JnsFe
	YGAlGxJCmViQbbE0OzIBiD8TOLJIFK/cOF4wnMfVPcF2cNOKhs1SNtcdWtqSlK5C
	5Sj11byawTgqxvtForjkJP+J0=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBn08jlPG5oBz4hBA--.440S2;
	Wed, 09 Jul 2025 17:56:54 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fix two issues on tpacket_snd()
Date: Wed,  9 Jul 2025 17:56:51 +0800
Message-ID: <20250709095653.62469-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBn08jlPG5oBz4hBA--.440S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry7XryxZr47GFyfKF1Dtrb_yoW3WFgE93
	s3Za4vy34DJFZ8CFZYkF4Dtry8KrW8WwsYqF42qFZrt3WfArZxGrsrCrZ3Z3W3uan7tryY
	yF1UJr1vvw1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8PCztUUUUU==
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWxuFzmhuPGkO+gAAss

From: Yun Lu <luyun@kylinos.cn>

This series fix two issues on tpacket_snd():
1, fix the SO_SNDTIMEO constraint not effective;
2, fix a soft lockup issue.

---
Changes in v3:
- Split in two different patches.
- Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
- Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/

Changes in v2:
- Add a Fixes tag.
- Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/

Yun Lu (2):
  af_packet: fix the SO_SNDTIMEO constraint not effective on
    tpacked_snd()
  af_packet: fix soft lockup issue caused by tpacket_snd()

 net/packet/af_packet.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.43.0


