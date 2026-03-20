Return-Path: <netdev+bounces-269758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id thq6LXeuvGkv2AIAu9opvQ
	(envelope-from <netdev+bounces-269758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:18:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BD2D5161
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A966D3022934
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE430ACF6;
	Fri, 20 Mar 2026 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j87OphTm"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFB2D9EFF
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973106; cv=none; b=H9yHeRn3I7/u/nTVn2IIacdGyR5aIYL+ZkrLXc6T7/QadsvCDzSiXrRo++1GpMAPcnSn5p7TLy7rHK2OM2jzVlBkzGWQ6U1KhhKOxZmydCxiXoGmIiBA9Tyw53nWi/kpJ2ChpNzUFC5RBk/P4hgXwxerGWbc6KEj3KROWYnvcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973106; c=relaxed/simple;
	bh=H74bMc39YOkASeARRE5W2jXwxfq5YprOQI9HpoZQJvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orDEmNfRNvoSdEf/wTr1w9QNWWxRZLyhNfWFEM11JUl/f5wHoVWCQKGe21vReKKEb46yZApqIieWCTATXzupTJ2DPlV4h1RDpTFpMqwVApb2+/53OQyMHS41v6UZOyTbVCcyMuBhRF/cWWJbkgTo2LvLk9rBfBazKxu5MQzeDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j87OphTm; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773973100; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RzIow3lYhzYELrv2HUKXaM/1pXNN4BTXgyhYVwM067A=;
	b=j87OphTmkOoWLgjFUA0Hgk9gga0toZ16jg4ChADzVP2qFvv1nIVZ18jd+hJ3YxqG/CoKkRerHklEA2ksLau+0m8wu6E9zpkraExODeVmp1dmieUCXyLKiGrNstOHaJzYr/eEk7MgW1WOc3dgEqU8HoO/2xHPyzVfQRC25ERdPRI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.JxA6q_1773973098;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.JxA6q_1773973098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 10:18:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v11 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 20 Mar 2026 10:18:16 +0800
Message-Id: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b52cc70b415f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269758-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,resnulli.us,solid-run.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.945];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 207BD2D5161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v11:
  1. rename virtio_net_set_hdrlen() to __virtio_net_set_hdrlen(),
  virtio_net_set_tnl_hdrlen() to __virtio_net_set_tnl_hdrlen(), and add
  explicitly mention in a comment that such functions must be invoked only after
  virtio_net_hdr_from_skb()

v10:
  1. fix http://lore.kernel.org/all/202603122214.8Anoxrmq-lkp@intel.com

v9:
  1. Introduce new helpers to set hdr len, and virtio_net_hdr_tnl_from_skb
  calls them directly.

v8:
  1. move changes of virtio_net_hdr_from_skb for udp tunnel to #2
  2. remove change for num_sg

v7:
  1. fix bug reported by robot
  2. Still splitting into two commits, as the issues fixed originate from
     different commits. This separation makes it easier to selectively revert to
     previous versions.

v6:
  1. rename to guest_hdrlen
  2. introduce a function virtio_net_set_hdrlen to set the hdrlen

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.


[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com







Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 ++++-
 include/linux/virtio_net.h | 53 +++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 6 deletions(-)

--
2.32.0.3.g01195cf9f


