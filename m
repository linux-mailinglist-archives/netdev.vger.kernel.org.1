Return-Path: <netdev+bounces-268021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CTEHpCGt2mOSAEAu9opvQ
	(envelope-from <netdev+bounces-268021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:26:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5172948BF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A636F300D157
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3E339870;
	Mon, 16 Mar 2026 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq51PXRO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632A322C88
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635214; cv=none; b=uam73EyhsWIphnA4X9rUUsECOM6a5NAilUGYQeOzkElXJAtTgXdfxMFKRviCJ+CVET3YDY7vyITlzbV7j9rSjQLOvVlNRQp7VjZR1p+ayP6216gN8/7GFimYiKeh70sQ8C7q/2vx+YC51lDXMObmN0P7cOKd0W5kJBxLqCNAmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635214; c=relaxed/simple;
	bh=4vs8RNGc7MDno4+X32x3Mh+tGMstn+YXEKpVY+sxySA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WFOXjTPPlvi/URQtWu8D1NXX50Iyt17NPzufRxvbSpUOjnBMmiD/N1PyDsUYpL3E68czUAxlaWNzWk5Drv/XZThF7eiFa5decyuFOnyrzzhXxhnwbXmLikW9yfnzeJhSX+q57O+wQVXToIWbs8qVyDrdOC+HlFNwpUcfZpySb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq51PXRO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82990763921so3886971b3a.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635212; x=1774240012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QG6YmZw2q5tnLzZ0HARS5dPxw6jYWbvpIUxUxyo/SI4=;
        b=Aq51PXROcONEBWQuUS0xKvq/C90pfpb0wxCCmfR/O8rXyGqZvYC7b7CEJXipXnqVin
         U6e/4qf7R6o4kIHRM2SORYgq5MHaC+l0jW/Gm+kTWK/eUpjk3G423T/YQ7TJY1kY6RDU
         6ILUTqaKNz98kjuBLraijOWcIN9bj9pV1xvezm81O5Wv7qv5S2rGxZAn3NMt4L8+sDfT
         H0JgmVI0uThdGC2LJcMVaVvqQrlSVEFFSLCE96UF1rzJEnvBUsqrCcBEO3BWIqk1EL2r
         suKeuqbqCM/5N5Ai4ZJ6nggFAfM3YPBT2nokBTivZ82y51C8Ws7xDPvjNza1atbuwaED
         AV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635212; x=1774240012;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG6YmZw2q5tnLzZ0HARS5dPxw6jYWbvpIUxUxyo/SI4=;
        b=FnwoBhhklDwgyxZEPbmJFaXledi5R19/dLTqmMMOA4aZfgqKkcM3+eMxLtcKBz8JDU
         t4Rz/Rd25fu/FSmQT+FIiVVLei5rksLUAptHuI2OiW9+7odyTAEJQqxWRKt4JZ1biIBU
         lPe1o1XznobIS+JInmkF1eypbRWPlw5v3HjWnGz/mbOmg6nWoCrx5C3pxqoQFeY9qglF
         Uoi7Am84YUNQKl6oqkXxDR1gUVHpCrCpcc6s0vW1laEaRyfrE4sbDnN+p/Rh99SZVpxe
         IQPfuC/uIBuYZWQoNHTp+8QEiDD2XQme7iMTRk92pCpA1aOHqJorfCT6w+8u/xmpCOoU
         tMpA==
X-Gm-Message-State: AOJu0YyneZtnkjKqmEEVaTPVsrWLu/8SfVUgbIk5hX6Ms26OtHo9v3eL
	P+/WvRheDv24dFyL1jvmO31ZHSeS4lE2Fd4SYyVP008Zl1RQ67abtynf
X-Gm-Gg: ATEYQzxM2P1F/NsT+5OrntxMFRvygpbAX2LHyRh/OBM4LnhlyWhXCcmZ6bzi9Og7cXQ
	QPfKM/Xf976FKD4BaNSnLj1KKb8m01+L2A61AWvfxY8hv8YOC9z/0v33td0jyAp17Yqi+U6wOEI
	hd1DgYEnUSmw2/7FZFuIwGckDQpeDnP/byd4p2//pEcjKH/MeT7LtjYflnLcEPHPUGKVwzwe/Df
	IpMDrW4SO5wwDG59SoLeM/VoeZqfvoHOXehEx5LckU1STNtmYUQhc4SsqysgTBRwtYrvg/aq1nF
	g5vKj9vwQzENsl8sg/VZFbrwl1zSA5D/LRDXTF18xi9wvi+FDEOFDJ4Sh67YK5urayy7opNPY7E
	JO4sXIIkGMam06XVwZBKoENjrpSvxe0zEQz6ScOLQYC6P/82JFp7ypbQn4M4EW/XoZxiiFfsuQu
	1CRNJGvV+am8f4v4U/y/3fAwsOTtfl8T4LKVfxfehwYa+/eqv4eIRvU1xH3bGvizWO4g5Q
X-Received: by 2002:a05:6a00:929f:b0:829:822e:cdc9 with SMTP id d2e1a72fcca58-82a1970498amr10802677b3a.2.1773635211899;
        Sun, 15 Mar 2026 21:26:51 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:26:51 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
Date: Mon, 16 Mar 2026 12:26:08 +0800
Message-Id: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WN0QrCIBhGXyW8zvinbbWueo+IcPq7CZsONVmMv
 Xvi1SC6/Dic860koDcYyO2wEo/JBONsHvx4IHIQtkdqVN6EAWuAV0Cd1qMT6iXdNL8j0rOETmj
 BEBgj2Zo9arOU4oNYjNTiEskzk8GE6PynXKWq8L/VVFGgXOlLK6FF0dT3fhJmPGVeWontff7rs
 +xr3cmrxFrVIPf+tm1fUZn7QPgAAAA=
X-Change-ID: 20260310-offload_compute-4c0bafa2e022
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC5172948BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series adds a new ndo_update_offloads callback that is automatically
invoked during feature updates when upper/lower device relationships change.
This centralizes the feature computation flow and removes the burden
from individual drivers.

---
Changes in v3:
- ndo_set_features may be skipped when no feature change, fallback to
  use ndo_update_offloads for offload computation (Simon Horman)
- Link to v2: https://lore.kernel.org/r/20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com

Changes in v2:
- Fix macsec Security Entity uninitialized issue (Sabrina Dubroca)
  - Tested with macsec-offload.sh, rtnetlink.sh, link_netns.py, all pssed
- Link to v1: https://lore.kernel.org/r/20260310-offload_compute-v1-0-3df79c09ea65@gmail.com

---
Hangbin Liu (5):
      net: add ndo_update_offloads for offload computation
      net: use ndo_update_offloads to set offload features for bonding/bridge/team
      macsec: move netdev_upper_dev_link() after macsec_changelink_common()
      failover: use ndo_update_offloads for failover offload compute
      net: no need to disable LRO specifically

 drivers/net/bonding/bond_main.c | 13 ++++----
 drivers/net/macsec.c            | 23 +++++++-------
 drivers/net/net_failover.c      | 66 +++++------------------------------------
 drivers/net/team/team_core.c    | 14 ++++-----
 include/linux/netdevice.h       |  7 +++++
 include/net/net_failover.h      |  7 -----
 net/8021q/vlan.c                |  2 --
 net/bridge/br_device.c          |  6 ++++
 net/bridge/br_if.c              |  6 ----
 net/core/dev.c                  | 11 +++++--
 net/hsr/hsr_slave.c             |  1 -
 11 files changed, 55 insertions(+), 101 deletions(-)
---
base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
change-id: 20260310-offload_compute-4c0bafa2e022

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


