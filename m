Return-Path: <netdev+bounces-257715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HKjFLWqyhmmSQAQAu9opvQ
	(envelope-from <netdev+bounces-257715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:32:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 137DD104CA6
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB7C3011861
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115E33121E;
	Sat,  7 Feb 2026 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQddH7Oz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F923D2A3
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770435175; cv=none; b=eqSwFubq3vXTsFP4XDhKE6ZKKlZrrsnCZuHxvYA3KVykyFcwbWvOpQIw6Mi6+PF8KIizQBTyDbMwRaB52sdszjLwP1SkCB7ICqEj+PauW7cw6skCLBaMPZ4UECYPxeSk4M6zgPBNLVCxPqsX3F+lZm5xxbUCdB+9pbxMvTCppi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770435175; c=relaxed/simple;
	bh=F75+iwxlRTLyIzKuJzJ+ID7DQ02GZVbuxnZkr4FlfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zgt9zb+0CMRSudWhXnjAZT8alA2682dxJW102f8OrHjiFEiTjLeZR+2G0p8raglqDruBK806/civ1Ih+w7Knr8vhAL7UZC+iIc7WSNvrzjyIdScyIw7Cj03+/iiMH+8Xk+wpiBvlfyUbZbftJbVE6b/rdeeKrzcs+ATJ0X/JMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQddH7Oz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48068127f00so25754565e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 19:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770435173; x=1771039973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=mQddH7OzOoYQhkb+oRz8ZMtoCNemJ0nFfYzmzinYhYkIary4u9QNSo3go94zZrAdEa
         7Egka4BO2/WM+PIIdmIZQSLBE3ELgrsVtpV0fiW49H7ZsDfZbMKOQNUWIZNA6vHL8QAh
         pvUk6O5HqTF+FjZ6HFQ47Q8HF2n8OUiI+oAuSG9nPjmCumIuE0BLF6PeNLifPIqbPTlR
         8U+L/gFhol0rgRAAidiDumcVRATibNkHlx1ZrFJL72L+tvpw+5QjP8McN9/qG6SdLrt5
         K7myOXCE8Q7z4d4Dhj2KuTcgbTFUMBFPU5AO3o2IFgz/MHWKfT+JuuajB8mP32L0eapU
         RbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770435173; x=1771039973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=f7n8Ge8+Jy5UqQi2hbrZBq/EDusb9hA8YyF0uHG9UVbILNCz/fXH3IUW+9iJGKUVQd
         sJmut3Q9ICtRcrv+0UlYwrKMtAoXIlOQHGuvItlmbwdpHaB51u6fCmaa/Y6UtgqQpee2
         YWX8rzOsu488N3BJ3kj7z6f0KFHJcDKHUMfVLWHKsuofkWMGKRZifdCVfVhCMGTXFWNN
         /azM0Dt2Qbni8rWW1MByhhxEp3fIc7mF4hFwKc2KPIfZ7boixNQeT8vtMVxliAw51WrD
         sC4CkREqVnu+GY8MmwaNpUxXFxbO1jPijaHvT6DkZRLvXl+rFVYUsDW69x13npeT9+ez
         wESg==
X-Gm-Message-State: AOJu0YwBnuiAiy2+i2bgPOTS0yOyhOCDTVlWLU3JMK2rC7JqjTqRpS50
	jFurfgY0QXzCUjHMbUnZAaqWKpwtpvs6Ar1glE3PcMU+zAiUi8XEDi4hfZO2jvcB
X-Gm-Gg: AZuq6aJ7UuD8+ig5F/27N9XAqFBgRItxLmbgIZsLF5j12tp0R7SP5mbIK+VgPn3FYEO
	4G6jHTl1DuMg39HwkwTmP4Rcqrj4Vt1Q8q47nqj+PkBhrR1Y3/FZ8FVl86itD8Txhjxs4GEu5/k
	w+2C+ZDIJAtIpHcHqfNayeeyMsai8wxNuJhDpev6WQpck/AgJKGiMAxEkEdUY3EK5vkZJADCaM6
	sUDWr8BZNPxwnumPZUJEzUhKRdZAb8TStWR4K7HHHZr11wfPHLjYoluJLbGY1wCnddd2C3cUwMI
	e4pF8J0NsKHuajq2CrXH7qiDo/XT5rh7EFsfr5nIz3gJcEacwh8zPxYQqHXseZnS6D8a9WAyw6c
	Bp2THj9+LFs7l2W4w15FyX/CpXS9Bn7oEtHTQtkanWrvJ5gQ6Erajg/Ady2ea5WAZG78UdvrPuC
	NsQUBRVbk=
X-Received: by 2002:a05:600c:8b6f:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-48320236963mr61223265e9.29.1770428553506;
        Fri, 06 Feb 2026 17:42:33 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961701sm59340825e9.5.2026.02.06.17.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:42:33 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 0/5] net: ethtool: Track TX pause storm
Date: Fri,  6 Feb 2026 17:42:30 -0800
Message-ID: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257715-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 137DD104CA6
X-Rspamd-Action: no action

With TX pause enabled, if a device cannot deliver received frames to
the stack (e.g., during a system hang), it may generate excessive pause
frames causing a pause storm. This series updates the uAPI to track TX
pause storm events as part of the pause stats (p1), propose to use the
existing knob (pfc-prevention-tout) to configure storm watchdog (p2),
adds pause storm protection support for fbnic (p3), and leverages p1
to provide observability into these events for fbnic (p4) and mlnx5 (p5)
drivers.

---
Changelog:
V2:
 - Clarify pfc-prevention-tout applies to general pause, not just PFC
   (P2)
 - Add pause storm watchdog timeout configuration via pfc-prevention-tout
   (P3)
 - mlx5: Report device stall prevention events (errors) in pause stats
   (P5)

V1: https://lore.kernel.org/20260122192158.428882-1-mohsin.bashr@gmail.com/

Mohsin Bashir (5):
  net: ethtool: Track pause storm events
  net: ethtool: Update doc for tunable
  eth: fbnic: Add protection against pause storm
  eth: fbnic: Fetch TX pause storm stats
  eth: mlx5: Move pause storm errors to pause stats

 Documentation/netlink/specs/ethtool.yaml      |  13 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  25 ++++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  11 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  46 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 110 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   5 +
 include/linux/ethtool.h                       |   2 +
 include/uapi/linux/ethtool.h                  |   2 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/pause.c                           |   4 +-
 14 files changed, 250 insertions(+), 2 deletions(-)

-- 
2.47.3


