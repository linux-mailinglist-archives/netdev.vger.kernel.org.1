Return-Path: <netdev+bounces-57604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF278139B0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1976C281689
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B6167E95;
	Thu, 14 Dec 2023 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kq1EwSkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AB116
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so59843425e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577751; x=1703182551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haTWuvvb3wg9rSHuJ/USxttW24h6lX+MTFJZTs+fzZM=;
        b=kq1EwSkJI1GtlN0KIXhEmpzfQk9MBBo1NziDNNkmLOrLq1SW1NGzUK1fbJJ+opOf/e
         RZyJCuc3kzPvdrQ6rlvzkyIubaPY1/Sc+03Ba+YiUrAzLpjNmr2cbGXO+4ZyXOX+ByGI
         gwJi82edTYYl0gDR/8YuA4PUBkIy7W93lmrsK2MhnwHBwYl70Y3Cx7ouXbzQeQd2sGNc
         /vaSmhTlj1dW3ZxK8OgZMRcsxS5WjfCHBpHjNb5YGo933keNtckJmUyUjSd2OuWF8Ysl
         KcFMdXhZBXutcMAWtAZGIjbDQahQpLdeWlLhgA/CJmf4wiMY2+IRugHxGnMx7J4B5Qn3
         bxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577751; x=1703182551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haTWuvvb3wg9rSHuJ/USxttW24h6lX+MTFJZTs+fzZM=;
        b=OtQyGWgb1KgANLUt8tPpc3qYDcDYEn+4wfaKQKjIHASZM/420ke3mz1akbs1B8muUN
         TBCY0ZyCMX2whz7vNru0v8xC7+LTH/UkyLaUYJMUa1M+g+9dWir9yOmqbS/6WQKxOYkD
         9kgCIfIwdMkM/BxpEg2XFnvVIWaaT6Epo7sI4ObqK1KmPTJFMgtLJjoTdeNOe+YOrMFg
         3e0lhAgjSgubt8x5zMxBCfafSRmOcfZwJ/2S7VM/TSx5DHsOsGGnmpnfLtR3gUBBoRVs
         vaaA8195EKsB6h3RApD9sug9mRkIouVKVlX79/fdVmV/aiyFShal175tR2ZzDmRC39gY
         PGjQ==
X-Gm-Message-State: AOJu0Yz8T6LLv9omgKIzJ+5Vt5n5+qabMJktt/4eqBLp9H/l21TBd3b3
	EGwjY4M1mp1Xk7ty6i7JLUyc9gwCBoXPfswM0Uk=
X-Google-Smtp-Source: AGHT+IF5y6tvmXuhyd4Iy7d+lJcmRgtTV1kcGSICuKUicJFUyNAC43+BfqDfRbukH3AT8z6vtXIq4A==
X-Received: by 2002:a05:600c:3c9d:b0:40c:4a4d:b534 with SMTP id bg29-20020a05600c3c9d00b0040c4a4db534mr1557303wmb.354.1702577751006;
        Thu, 14 Dec 2023 10:15:51 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm9618505ejc.182.2023.12.14.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:15:50 -0800 (PST)
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
Subject: [patch net-next v7 0/9] devlink: introduce notifications filtering
Date: Thu, 14 Dec 2023 19:15:40 +0100
Message-ID: <20231214181549.1270696-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
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
v6->v7:
- bigger changes in patch #5, moves the tracking to the family xarray
  with sock as index, makes all lot more nicer and fixes the race
  conditions
v5->v6:
- in patch #5 added family removal handling of privs destruction,
  couple other things, see the patch changelog for details
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
 include/net/genetlink.h                  |  46 +++++++-
 include/net/netlink.h                    |  31 ++++-
 include/uapi/linux/devlink.h             |   2 +
 net/devlink/dev.c                        |  13 ++-
 net/devlink/devl_internal.h              |  59 +++++++++-
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
 net/netlink/af_netlink.c                 |   3 +-
 net/netlink/genetlink.c                  | 143 ++++++++++++++++++++++-
 21 files changed, 462 insertions(+), 53 deletions(-)

-- 
2.43.0


