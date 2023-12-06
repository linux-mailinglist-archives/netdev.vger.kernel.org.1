Return-Path: <netdev+bounces-54565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC51807777
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEAB2818CF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5486F601;
	Wed,  6 Dec 2023 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EJxQkucl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16930122
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso77021a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886882; x=1702491682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4ZHNQPyMnxmTBxjBuNAXCzWIfYzzShldcJwCTWZAyI=;
        b=EJxQkucl5iJ3YoAyP9awteAx2wrvxVEdobWNAvzN/kjR/kG5iTPP1rLy4PUNP2zNlY
         KPEW94Avf4t9BR/kw10NpoBCq9A5HIOgyOsVvGacvBDtUWsr+xfOyTE7Go90ourBDEcD
         0OmNZ4PC10Ypp5P5G74qtnomvc9+KiXDdkrBQPZP7VaMMSrEXjs0+qs6kC4q0rIDSL45
         NThkHQZjfkpqi/ceWkM938WTeiZ4KEXZ7ekw55/0GPCPatPveRXulMAX1VOFTfbFLgmA
         JY6ERu+j/ur+Ez8K4KfTvE1wMFUhyqC/yu6b0kIKgSyHz2iGSvpNcHXzZJFYFJLPjTlg
         +7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886882; x=1702491682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4ZHNQPyMnxmTBxjBuNAXCzWIfYzzShldcJwCTWZAyI=;
        b=qqtxTqWzSxr29Ck7Sy2Rhx/xDp1L/TcW9MPcTVVjdDZTvVfjLpSuZGnP6wY8tDQ0Lp
         biCQojU4SXN057lkgLT8jVZmX7dmigakbbhDvXXOvql5gZ1l7FxI3Chok/7jL6Gvwc6g
         NLsUHZq427b5Bi0I+AcxZznLAQIYQXkbZY+hGkendpsohuBP9uixoKoSdrEzomUXFDoi
         aQcNsO1Jj5ajb44bP0JSHsfPPHiLQsG5o+Gisj0F5MVr2i6dLcjzhBuxYzfgikruJ/c5
         oWld4JseyWCXMAtwKwnO9KBjljdj936rcrlt0rJXMa5ZVjBYSKaLLBk0llR6y7S0++y8
         ZI8A==
X-Gm-Message-State: AOJu0Yz/BehdwawEL2yG9JLNw+Qasib81xs89cPmxk0lt0NVfD119s/H
	33EF7b4jPG2gJaLID7gcKDpIDT/bLMSi0kpDJmA=
X-Google-Smtp-Source: AGHT+IF1zpZhef8skruM2oIls0r0REd0Sro35A9izprokw0KxpReR9FWRWUecTRQoaR8MIagoQqYJg==
X-Received: by 2002:aa7:d5d8:0:b0:54b:c649:fcfe with SMTP id d24-20020aa7d5d8000000b0054bc649fcfemr953636eds.34.1701886882463;
        Wed, 06 Dec 2023 10:21:22 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c685000000b0054c9972c1aesm254887edq.28.2023.12.06.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:21 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v5 0/9] devlink: introduce notifications filtering
Date: Wed,  6 Dec 2023 19:21:11 +0100
Message-ID: <20231206182120.957225-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the user listening on a socket for devlink notifications
gets always all messages for all existing devlink instances and objects,
even if he is interested only in one of those. That may cause
unnecessary overhead on setups with thousands of instances present.

User is currently able to narrow down the devlink objects replies
to dump commands by specifying select attributes.

Allow similar approach for notifications providing user a new
notify-filter-set command to select attributes with values
the notification message has to match. In that case, it is delivered
to the socket.

Note that the filtering is done per-socket, so multiple users may
specify different selection of attributes with values.

This patchset initially introduces support for following attributes:
DEVLINK_ATTR_BUS_NAME
DEVLINK_ATTR_DEV_NAME
DEVLINK_ATTR_PORT_INDEX

Patches #1 - #4 are preparations in devlink code, patch #3 is
                an optimization done on the way.
Patches #5 - #7 are preparations in netlink and generic netlink code.
Patch #8 is the main one in this set implementing of
         the notify-filter-set command and the actual
         per-socket filtering.
Patch #9 extends the infrastructure allowing to filter according
         to a port index.

Example:
$ devlink mon port pci/0000:08:00.0/32768
[port,new] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth netdev eth3 flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth netdev eth3 flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,del] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable

---
v4->v5:
- converted priv pointer in netlink_sock to genl_sock container,
  containing xarray pointer
- introduced per-family init/destroy callbacks and priv_size to allocate
  per-sock private, converted devlink to that
- see patches #5 and #8 for more details
v3->v4:
- converted from sk_user_data pointer use to nlk(sk)->priv pointer and
  allow priv to be stored for multiple generic netlink families, see
  patch #5 for more details
v2->v3:
- small cosmetical fixes in patch #6
v1->v2:
- added patch #6, fixed generated docs
- see individual patches for details

Jiri Pirko (9):
  devlink: use devl_is_registered() helper instead xa_get_mark()
  devlink: introduce __devl_is_registered() helper and use it instead of
    xa_get_mark()
  devlink: send notifications only if there are listeners
  devlink: introduce a helper for netlink multicast send
  genetlink: introduce per-sock family private storage
  netlink: introduce typedef for filter function
  genetlink: introduce helpers to do filtered multicast
  devlink: add a command to set notification filter and use it for
    multicasts
  devlink: extend multicast filtering by port index

 Documentation/netlink/specs/devlink.yaml |  11 ++
 drivers/connector/connector.c            |   5 +-
 include/linux/connector.h                |   3 +-
 include/linux/netlink.h                  |   6 +-
 include/net/genetlink.h                  |  41 ++++++-
 include/net/netlink.h                    |  31 ++++-
 include/uapi/linux/devlink.h             |   2 +
 net/devlink/dev.c                        |  13 +-
 net/devlink/devl_internal.h              |  59 ++++++++-
 net/devlink/health.c                     |  10 +-
 net/devlink/linecard.c                   |   5 +-
 net/devlink/netlink.c                    | 116 ++++++++++++++++++
 net/devlink/netlink_gen.c                |  16 ++-
 net/devlink/netlink_gen.h                |   4 +-
 net/devlink/param.c                      |   5 +-
 net/devlink/port.c                       |   8 +-
 net/devlink/rate.c                       |   5 +-
 net/devlink/region.c                     |   6 +-
 net/devlink/trap.c                       |  18 +--
 net/netlink/af_netlink.c                 |   5 +-
 net/netlink/af_netlink.h                 |  15 +++
 net/netlink/genetlink.c                  | 146 +++++++++++++++++++++++
 22 files changed, 477 insertions(+), 53 deletions(-)

-- 
2.41.0


