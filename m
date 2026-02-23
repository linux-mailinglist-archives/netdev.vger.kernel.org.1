Return-Path: <netdev+bounces-260065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDQKBm9rnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBD178597
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6694230F667B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599B26E6E1;
	Mon, 23 Feb 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mjWc3on2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF55C613
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858565; cv=none; b=FUc5ej9OoJ2CyAPHnxEHJU+gpk8oSoBxEq0+WlGamYSCEd/y+S/hfHbjnq57AxRX9iItgHHgbNGmpcRceAh1rtW6pkTV5a6TFmcJG68H2YadSXsAAvdOAx7rf3MPoH16ArzlTuO+wOcvCt6ulPY/3kV4sWQH2gJlGqDjKUnAZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858565; c=relaxed/simple;
	bh=u7xsWoPAN17Y/BR2jdrdpoVYb5DBfFYA0RaC2z7xS3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiYA/4BXjBcM2XjqhHWXIoVSWIwxy3ek5/acK1fPzFiCfgdGNzqcCuqqMevFUAhNFZSGhjsQ/AYhX8ipy791uXqkGlX6+x68dzp+cpNWyNGdq3hiPXw1AcOErWsaiQPumP/Uq4HL88VMDrrnom5rcFml8VXGbGMmb11IMRXx0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mjWc3on2; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4837584120eso31533075e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858558; x=1772463358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWPtdc3AKgH7Qa6aP8A9K9zkG5fmObFHBGS+pXL1FG0=;
        b=mjWc3on2sPxG389ldeVG62T1xs0BeGFtYDElQjzR7MmEnI5eMo4D57b6L84QdDf2Fx
         zbtZYFzIOghSrHp8NgXwYMrHIqpnNh/SzJ4/20MGSd67nUhA0eucYH/XJDiiI6/muG0e
         vju8nBDFUn4skcw/Fg+NA4H/egAHIIqUoufbsVjPzL3HiBx7evul5m8cjU421oHSJDFq
         OREZbE17DYXXUOJ/IyxZZ+LXpi0KxFIVCLbXWWYkuN2o6FQ6NVtXJTTqQJb9AGuTnyoZ
         LNTBFExsVkeHl2N6GH/XNxuMFheL3z8WJVWiO8aPqcBA/uznzAwx2cbtHbVkoDd1VXsS
         BqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858558; x=1772463358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWPtdc3AKgH7Qa6aP8A9K9zkG5fmObFHBGS+pXL1FG0=;
        b=e4OQ10F/GsAyQj710iYv0OMxsabPGexRpga/6gOuBnQoagkEd4sn1f5omT/wCYq+Q+
         76pt/Hc1yPCLQ2Q/mZ3X3cPpST45WVZoq6JXY15EqAHrwHN+L/Ptcj7oSHQhkvzSRdhg
         z+aLASnrW0tLS4Wa2Fn1f+yLuLywKRueIQdQmRaZX2Pk9F5HwNuxKhiPQfbs5tdZJcC0
         hCFVeS8leXtjlPvN0RrJL6z91cmQ+0lNvkj7O1+LYk4JURPdWPwkoQRi9yZDdIywKsKH
         hJrU/AxWXngK9yIdhPM6honV74gMk3LGrsf2NPTk8nvLAz4EE9ycObeHNGpnZhMgXGM8
         vJHQ==
X-Gm-Message-State: AOJu0YwLbN5QTgtSsg7JDpxOJOZMhzAgtzNxkZqYpEJkVZRfklCJ3Uls
	dZoSi+lb5Eco/VulgevDlgyOlCjm7iW1FO6uWUeDWWG/A3Xm7wLWeelsqwiZhw7Rb+PmYVuJd0/
	ZR+Yp
X-Gm-Gg: AZuq6aLwyz4KuYlEts0G/E34J4Yg9ktLmyAdQHsTzAzOXB8xH3n1KlhROfPzZGfw2NB
	2h/wuqlU1IpM13KXwy7sYBI91nOSBJIfKhQOO73QgV2zNYZv2EL/2/V0ggJzgbru+3As0xkOqqh
	y6XRFU+Je0EBhA4rhT7tIGZIzcmCKVIzZWR/1c/nMSm7RqBI2sbfhZyFCSrtQsUF/7xdBoCpxNL
	Ch5vEVulfMt62NOxw/Ci+i++H7z6/Uc181SODV7SwkP0A5Ct8Hs/IRihXOwIHDn+8ogt0QTXkn9
	+v9XBIHTPLZAFe7+x8MLlp2f13sQ5sc4PW7EY4QD49qRIxfBqgvCV9rUtl6R5SEwW29I4yUNGum
	ef2Hq5ie4hN7EPDAIrJwmPSO+d+w3qhzGbpQvhdLIwE8Am9uyDl+xT8OVyZhyzQ1/4mbJjkoPEe
	aN5IxmXbuuuCBUew==
X-Received: by 2002:a05:600c:3e8d:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-483a95f8bdfmr144910985e9.23.1771858558344;
        Mon, 23 Feb 2026 06:55:58 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb3f31sm190787405e9.13.2026.02.23.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:55:57 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com
Subject: [PATCH net-next 00/10] devlink: introduce shared devlink instance for PFs on same chip
Date: Mon, 23 Feb 2026 15:55:47 +0100
Message-ID: <20260223145557.248679-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260065-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76CBD178597
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs on a network adapter often reside on the same physical
chip, running a single firmware. Some resources and configurations
are inherently shared among these PFs - PTP clocks, VF group rates,
firmware parameters, and others. Today there is no good object in
the devlink model to attach these chip-wide configuration knobs to.
Drivers resort to workarounds like pinning shared state to PF0 or
maintaining ad-hoc internal structures (e.g., ice_adapter) that are
invisible to userspace.

This problem was discussed extensively starting with Przemek Kitszel's
"whole device devlink instance" RFC for the ice driver [1]. Several
approaches for representing the parent instance were considered:
using a partial PCI BDF as the dev_name (breaks when PFs have different
BDFs in VMs), creating a per-driver bus, using auxiliary devices, or
using faux devices. All of these required a backing struct device for
the parent devlink instance, which does not naturally exist - there is
no PCI device that represents the chip as a whole.

This patchset takes a different approach: allow devlink instances to
exist without any backing struct device. The instance is identified
purely by its internal index, exposed over devlin netlink. This avoids
fabricating fake devices and keeps the devlink handle semantics clean.

The first seven patches prepare the devlink core for device-less
instances by decoupling the handle from the parent device. The last
three introduce the shared devlink infrastructure and its first user
in the mlx5 driver.

Example output showing the shared instance and nesting:

  pci/0000:08:00.0: index 0
    nested_devlink:
      auxiliary/mlx5_core.eth.0
  devlink_index/1: index 1
    nested_devlink:
      pci/0000:08:00.0
      pci/0000:08:00.1
  auxiliary/mlx5_core.eth.0: index 2
  pci/0000:08:00.1: index 3
    nested_devlink:
      auxiliary/mlx5_core.eth.1
  auxiliary/mlx5_core.eth.1: index 4

[1] https://lore.kernel.org/netdev/20250219164410.35665-1-przemyslaw.kitszel@intel.com/

---
Decoupled from "devlink and mlx5: Support cross-function rate scheduling"
patchset to maintain 15-patches limit.

Jiri Pirko (10):
  devlink: expose devlink instance index over netlink
  devlink: store bus_name and dev_name pointers in struct devlink
  devlink: avoid extra iterations when found devlink is not registered
  devlink: allow to use devlink index as a command handle
  devlink: support index-based lookup via bus_name/dev_name handle
  devlink: add devlink_dev_driver_name() helper and use it in trace
    events
  devlink: allow devlink instance allocation without a backing device
  devlink: introduce shared devlink instance for PFs on same chip
  documentation: networking: add shared devlink documentation
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  56 +++
 .../networking/devlink/devlink-shared.rst     |  89 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  62 ++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  12 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |   9 +
 include/trace/events/devlink.h                |  36 +-
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  59 ++-
 net/devlink/dev.c                             |  11 +-
 net/devlink/devl_internal.h                   |  17 +-
 net/devlink/netlink.c                         |  38 +-
 net/devlink/netlink_gen.c                     | 350 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 149 ++++++++
 19 files changed, 746 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1


