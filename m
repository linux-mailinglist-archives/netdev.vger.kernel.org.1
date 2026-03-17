Return-Path: <netdev+bounces-268449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKv9JxvzuGncmAEAu9opvQ
	(envelope-from <netdev+bounces-268449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:22:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB842A4441
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07BD93023E35
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C833E36A;
	Tue, 17 Mar 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="bENC7S77"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1101AB6F1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728537; cv=none; b=KvgnKJ2d01yr+EfLCEGCUf6lpeyWNbf6N8ZpEeTS0Su9OrlPgsboNsXBpf48dgREu8aEKlq9ITtmlwq0XuC745VwTmK2DMzMTJHRnNBOOmdP/w/DNp6dZipTJ28q3jjQMoPbQ3T7XfTOYZB/rixI4Fh8yNQhXYPmXe7dezmxFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728537; c=relaxed/simple;
	bh=3VxuFkplE+a9skwOUU3cx1fLi+KJLKiAjzyvfE9109M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/AfDjwwCZ0KfOaReNJJyVpNyxE900UFZybnHZ+7uSc+RXixai9GijewA4Uialb8rh+h64aSQL07PnImfj68dWs2tAb9lomQhdx1JoZLpRIScjfgugqa9OMr8IFGsDRtUI6CMAfeuAL/bmzqSQ3vfS3ca5xaZ25shff4PmDsAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=bENC7S77; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (16.4.31.150.dy.iij4u.or.jp [150.31.4.16])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62H6M6QA068854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Mar 2026 15:22:07 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=hE1KLtWcCiihV09QvqyDwy7PHPmXiAwI6Mr7+XOi074=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773728527; v=1;
        b=bENC7S770d7A2k9Enlge0rzfK6U0j/+EsIgTIYsZrFnoC8oqIjy2RfEpz+UPPWtj
         bqUD8CMxnywIsD3xEOG+J95Kq1LjKdhGkYu2u9qMZ95611PPFZ7YKAtc22u5k6DX
         NC0gQAqEIY1IMPDJLKMMmdP2dbpuGJrXCb6ev0C3pJj77ht+RwDTivohJmM9V6IH
         l3a6CIM7paGjDVYeW5G+rfbVNfYH0xGwBxcWFi+iVWlTw94Z5xNrONIZedqFqeXg
         aBaKnwk26PQWdHwl10GTXVoiheX4sI4rtymCtAEbmfp1IGBJui8pcKHrcR6TprRL
         tv8oISYklkjGFj/C/isc6g==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v2 0/2] igc: enable build_skb path
Date: Tue, 17 Mar 2026 06:21:44 +0000
Message-ID: <20260317062205.39406-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268449-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CB842A4441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series enables the build_skb RX path in igc, which is currently not
enabled in any configuration.

Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
path.
Patch 2/2 enables the build_skb path when XDP is inactive and other
conditions are met.

Tested on Intel Corporation Ethernet Controller I226-V (rev 04).

Changes:
  v2:
    - don't insist on reverse christmas tree, reducing net diff in the
      patch 1/2 (Dima)
  v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/

Kohei Enju (2):
  igc: set RX hardware timestamps in igc_build_skb()
  igc: enable build_skb on the non-XDP small-frame RX path

 drivers/net/ethernet/intel/igc/igc.h      |  4 ++++
 drivers/net/ethernet/intel/igc/igc_main.c | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.51.0


