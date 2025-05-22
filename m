Return-Path: <netdev+bounces-192832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E42AC1544
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F887AF01F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF228C86B;
	Thu, 22 May 2025 20:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29D189912;
	Thu, 22 May 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944432; cv=none; b=eiaO9wewchE/QVGDqlUapc58FWntNXjv/s8qhdhDIt4OROA2AdpE5FW8vw84HpJPGW9DQRASJKxQsEyOi8aEOeIn40occF3o9Rnois4TQBSFdZgLLv4AgZbKrNierJIeLFDZQM0/nmv0WfdX2k2bKWIjnXISzuUjTtxRz7vUHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944432; c=relaxed/simple;
	bh=2IW2R209pVFeKDP8TKFbRcxwbXUxPzIyFAnm0vtxaak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRC4mw51UOh0UNabCP+FwK0KhXVFGyBjK8mfdzGBE48eiUP64TmYglnR1R85XxHZUOQ6flM+czkpUdzuJAYBZ4OMYU/4TLMT4xDKjIHWAT6NOA+Ue0zp5++vszaj4ov7hL2/ia7rPxpsIfagCS8qaMxpDI3OJdbAoOKrxRkBq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBCF354C351;
	Thu, 22 May 2025 22:00:00 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next 0/5] net: bridge: propagate safe mcast snooping to switchdev + DSA
Date: Thu, 22 May 2025 21:17:02 +0200
Message-ID: <20250522195952.29265-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For a plain Linux bridge we have a safety mechanism before applying
multicast snooping to payload IP packets in the fast path: We only apply it
if both multicast snooping is enabled and an active IGMP/MLD querier was
detected. Otherwise we default to flooding IPv4/IPv6 multicast traffic.

This reduces the risk of creating multicast packet loss and by that
packet loss for IPv6 unicast, too, which relies on multicast to work.
Without an active IGMP/MLD querier on the link we are not able to get
IGMP/MLD reports reliably and by that wouldn't have a complete picture
about all multicast listeners.

This safety mechanism was introduced in commit
b00589af3b04 ("bridge: disable snooping if there is no querier").

To be able to use this safty mechanism on DSA/switchdev capable hardware
switches, too, and to ensure that a DSA bridge behaves similar to
a plain software bridge this patchset adds a new variable to track
if multicast snooping is active / safely applicable. And notifies DSA
and switchdev when this changes.

This has been tested on an OpenWrt powered Realtek RTL8382 switch,
a ZyXEL GS1900-24HP v1, with the following, pending patchset for OpenWrt
to integrate this: https://github.com/openwrt/openwrt/pull/18780

Regards, Linus


