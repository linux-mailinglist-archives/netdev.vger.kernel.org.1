Return-Path: <netdev+bounces-272892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PHIKbwkyWm/vAUAu9opvQ
	(envelope-from <netdev+bounces-272892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:10:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F2352175
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C5A3002A0E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E535F616;
	Sun, 29 Mar 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmu95NbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E72C15AC;
	Sun, 29 Mar 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789695; cv=none; b=JheWwL/yK1XmZRqodKsidrU8qaVIRAUe65s8N70z/VAtHHozYSXoCJ+9PT035CezgEzLDhry3OENZBpIXfvU3M60Nu4fcZhViR0GWhzhBTNCaHVsn7D0W+WAJQA86ZgoPYyuzLxZ9gDkwcLnMKiTuGu+z6oeQ+hLLx403CBCfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789695; c=relaxed/simple;
	bh=bBfbGJ9mJcA+NBsd5zGoJk2uB8RFGVX/pg5sGKGq6AU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RU7CgoBAy4a4U0U+5XJJsQ+QtXgSM+Au6ARj+f15ERGg7xQPwG13mTLpZMFNZxIv5F/65EehWUmW0kZt+wjNYUsPskqhV5LzTule9rL/xTFAXLqlatdodKhWSlFrCno6UQfzf8WIzGOg7yWGPuPOFwDEFtPC4THCzGOMe2MwXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmu95NbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3131C2BC9E;
	Sun, 29 Mar 2026 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774789695;
	bh=bBfbGJ9mJcA+NBsd5zGoJk2uB8RFGVX/pg5sGKGq6AU=;
	h=From:Subject:Date:To:Cc:From;
	b=kmu95NbKHUXOmKZo/46eKzQtteubfnWSS7xD5MRWilH4gJmVoXX7oQJYb12czgEDM
	 ifA/taz373k6tZm+GyxKgfJECqO7CEdWUjBoUNZByYC+S5xOqDJEIcD5ubutfU06zh
	 9N2VZe6d6O0HRJWbUl+ISfe2pfGkfvx++yR/lu3LaFQaWIJx/I0Q1QjnZ884bjH7Rl
	 OM+FftzF463t/D97NESwGmtJ8YHWl4fAgtwtdb4hydJnpENoqdNzFdc226eWR3e+/T
	 sRJs9cHXM4YQKuNdue6PR9RDdUeFVXqhrHzkv1p3R6tMOqi9DZP7F8wNQCIFty1Xf7
	 qz7hYcFh4UHyw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 00/10] net: airoha: Support multiple net_devices
 connected to the same GDM port
Date: Sun, 29 Mar 2026 15:07:50 +0200
Message-Id: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMBAF0atIr6dBo4ngVYZZRP2aBo1DEkUQ7
 25w+RZVF0UEQaSuuCjgkCibz6g+BQ3O+hksYzapUpmyVg1bCZuzjOR43ZcknAcjIk9902ttgFY
 byvU/YJLzPX/JI7HHmeh33w/VT7PCcwAAAA==
X-Change-ID: 20260324-airoha-eth-multi-serdes-fb4b556ee756
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272892-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F5F2352175
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw multiplexer that
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
           │ PPE │                 │   MUX   │
           └─────┘                 └─┬─────┬─┘
                                     │     │
                                  ┌──▼──┐┌─▼───┐
                                  │ ETH ││ USB │
                                  └─────┘└─────┘
                                   ETH1   ETH2

This series introduces support for multiple net_devices connected to the
same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hw
multiplexer. Please note GDM1 or GDM2 does not support the connection with
the external multiplexer.

---
Lorenzo Bianconi (10):
      dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
      net: airoha: Rely on net_device pointer in airoha_dev_setup_tc_block signature
      net: airoha: Rely on net_device pointer in HTB callbacks
      net: airoha: Rely on net_device pointer in ETS callbacks
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airhoa_is_lan_gdm_port()
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Rename get_src_port_id callback in get_sport

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  44 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 626 +++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h           |  30 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  42 +-
 4 files changed, 497 insertions(+), 245 deletions(-)
---
base-commit: 68bb4adb58e114336826e2ecc15ecf62e2890d3e
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


