Return-Path: <netdev+bounces-177445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C016AA703BE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844433A8095
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1925A33F;
	Tue, 25 Mar 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="mKeKHH2I"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECA2561DF;
	Tue, 25 Mar 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912705; cv=none; b=bmxqyEQ516fbA7lPCKUH3dadiKBTOXDlHqrYfR7Ub2KimRfB8b291VBb6V2fLyRQhTbBU1S45CAPeMPfu/BbybaophJw6MbtdPv3HEsE5+tBVdgOEf6vSDO6Adpyk/wXELcZhofD5/pVhTHIe8w6JqCPCf3gEuOKGC0WRpqzQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912705; c=relaxed/simple;
	bh=eMk1f/RHiH+lKxFlP00WZ8fNmi+GJKXqW2G5fZKB+qw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scBqlvuXJFiW9rbQ796rXL3e047AABZk/5LPpJeTixKHVXbSOQjyF2Qd4GPP4H+LzTX5rjEYWcw3vWgifq5FkOSy+k3Eyqtzsx4v0YA1jXHkQsZudQaBh5bimqd5b59xWUIkjDM7ZJlUNXBMCW+5OxkFS6IdNK1WZ6PNT7rEp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=mKeKHH2I; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 04363C0016;
	Tue, 25 Mar 2025 17:18:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 04363C0016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1742912316; bh=tmgQrOdqbX3U/2BKIqDRRlI0g7Ca44O16T1BCXK717Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mKeKHH2IEl6gCiluS7BD3w/pNU1UKXwQ/mFP/N48Dt+zm49GWm3TaQS+LKiAqXr+s
	 PU+QBqdpJYqEUlbszu2MRObV343IrvoAsySL+xe11PF7QwwNzitAeAWvOF7mDLUA+9
	 oMy4Wsyml6iilKDx3cZ2X+Io1mFSXCZ6CEj4orGoqKnS4MJk/E8h78WIw6pTpoGJdr
	 xKxhzNFMcWyOv5Vz0iUGqotmuItBtFZyNnsD6nGp0uga/V5NxjDdh1jBHrfuOkAM2L
	 yv//ykJh7HR7SokI1RL4SmzzG6eTOYKqjjUy7lU3zIYoIeWmsrsiaT9pSMWTXlTLi+
	 YvZlB4pI+ouDw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 17:18:35 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Mar 2025 17:18:34 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net 0/4] Avoid using WARN_ON() on allocation failure in device_rename()
Date: Tue, 25 Mar 2025 17:17:19 +0300
Message-ID: <20250325141723.499850-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/25 12:54:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, git.kernel.org:7.1.1;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192091 [Mar 25 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/25 08:37:00 #27838357
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/25 12:54:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

This patch series is based on
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/ and is
intended for the generic netdev maintainers, as it affects multiple
networking subsystems.

There are a couple of Syzkaller reports about WARN_ON() being triggered
by failed device_rename().

They are triggered by fuzzer's fault injection and subsequent allocation
failure in kstrdup(). Failure of kstrdup() in device_rename() should not
lead to WARN_ON(), so means to avoid it are introduced in this series.

If it is possible to reverse the changes done prior to failed
device_rename(), do that. Otherwise ignore -ENOMEM return code in
WARN_ON().

Ivan Abramov (4):
  ieee802154: Restore initial state on failed device_rename() in
    cfg802154_switch_netns()
  ieee802154: Avoid calling WARN_ON() on -ENOMEM in
    cfg802154_pernet_exit()
  cfg80211: Avoid calling WARN_ON() on -ENOMEM in
    cfg80211_switch_netns()
  net: Avoid calling WARN_ON() on -ENOMEM in
    __dev_change_net_namespace()

 net/core/dev.c        |  2 +-
 net/ieee802154/core.c | 51 ++++++++++++++++++++++++-------------------
 net/wireless/core.c   |  2 +-
 3 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.39.5


