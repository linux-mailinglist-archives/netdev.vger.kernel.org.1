Return-Path: <netdev+bounces-292243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE+uAkvGFmpVrwcAu9opvQ
	(envelope-from <netdev+bounces-292243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:24:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61D5E29A5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09A6A3009017
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBA3EFFA6;
	Wed, 27 May 2026 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/NqUaoH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB63E867F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877295; cv=none; b=Pr1fmuy0jMm7q8+ETjs57c25TCZgraQXCpW7Q+W9wLewpa0QL9RFOa4BAujJAizKsc2EHHtJcVNuYsfNwotwt14dxOaiAF+vmmrAMBf9JvAwlWw6RjVlIEIC1VXuEe1QfTD3CVgtGua+Fx7gu0biaA2wwDOdBEOLRtXgJf/gjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877295; c=relaxed/simple;
	bh=Hb5mmUyG+wBrn6VfqA5DOGUO30RVbi40UdpuJZ1U48w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AF9CA3GKTMlhbuEyrdGcTRyu9aeU8qOMz7Ztg2pLrxRvE3aT1EOWe+ERXMSmtcKWkEY46M1vayLv4sQcpwbDgM9skzQgOKTVm379bsZINi2JWRPi1/aLpUin6l/0VoGcuG5zKwVQkFS2M3UzbLEEeezq9Q4l9BueY0kvwQPRxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/NqUaoH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3719D1F000E9;
	Wed, 27 May 2026 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877292;
	bh=GCDBQyOqO+wkKS4SzAvFryKV14tQQLMUO7YZ3xM4bRo=;
	h=From:Subject:Date:To:Cc;
	b=P/NqUaoHvULOOBMbnPno7nkQDdfZa4eFiHLySPdjY4k5Ig7q3Vfdfa8YI5ace68bb
	 nUmhGtar791JCXurQFWy3J+tNQrRDkMqL3Q4RevNgS8TBkCRZmdzR6Acmzccox8vAZ
	 HB6pS0p1O6qK0XOU1uJTozZMmGgzahov4CYS1rH7ZuH6kOXOvxFYkE8GACK7CFNrkd
	 NVePQIO9BlVFfpc7rctOoeja53Wr6ppqdhTjZWv/qsUtQvWO+hagUXDZHuYwATrwTb
	 LuO2dUKgPUElESMTror7TmBzX3lHMmn5jYtqsKCbbPVSBIw7eh3adZhcamiJaCof+4
	 OB7BEQgbq2w7w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/6] net: airoha: Preliminary patches to support
 multiple net_devices connected to the same GDM port
Date: Wed, 27 May 2026 12:21:14 +0200
Message-Id: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDQAwAvyI5N7AGtdCvlB62mu0GNJbsWizi3
 xt6HAZmDihswgVuzQHGHymyqkN7aWDMUV+MMjkDBRpCT1eMYmuOyDXjss1V0AMTF3wbz7KIRvt
 i31Lo0nPoKI3gJXdJ9v/lDsoVlfcKj/P8AU/XkBx/AAAA
X-Change-ID: 20260527-airoha-eth-multi-serdes-preliminary-51204fb642fc
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292243-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC61D5E29A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
manages the traffic in a TDM manner. As a result multiple net_devices can
connect to the same GDM{3,4} port and there is a theoretical "1:n"
relation between GDM ports and net_devices.

           ┌─────────────────────────────────┐
           │                                 │    ┌──────┐
           │                         P1 GDM1 ├────►MT7530│
           │                                 │    └──────┘
           │                                 │      ETH0 (DSA conduit)
           │                                 │
           │              PSE/FE             │
           │                                 │
           │                                 │
           │                                 │    ┌─────┐
           │                         P0 CDM1 ├────►QDMA0│
           │  P4                     P9 GDM4 │    └─────┘
           └──┬─────────────────────────┬────┘
              │                         │
           ┌──▼──┐                 ┌────▼────┐
           │ PPE │                 │   ARB   │
           └─────┘                 └─┬─────┬─┘
                                     │     │
                                  ┌──▼──┐┌─▼───┐
                                  │ ETH ││ USB │
                                  └─────┘└─────┘
                                   ETH1   ETH2

This is a preliminary series to introduce support for multiple net_devices
connected to the same Frame Engine (FE) GDM port (GDM3 or GDM4) via an
external hw arbiter.

---
Lorenzo Bianconi (6):
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airoha_is_lan_gdm_port()
      net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
      net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
      net: airoha: Rename airoha_set_gdm2_loopback in airoha_enable_gdm2_loopback

 drivers/net/ethernet/airoha/airoha_eth.c | 445 ++++++++++++++++++-------------
 drivers/net/ethernet/airoha/airoha_eth.h |  35 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c |  34 +--
 3 files changed, 297 insertions(+), 217 deletions(-)
---
base-commit: aa064a614efcfa4c300609d1f01134e99a12ad10
change-id: 20260527-airoha-eth-multi-serdes-preliminary-51204fb642fc

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


