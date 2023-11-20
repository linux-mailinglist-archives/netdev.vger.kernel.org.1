Return-Path: <netdev+bounces-49124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83D7F0E0C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462661F22B77
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE5DF45;
	Mon, 20 Nov 2023 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QWa7XmH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7119A2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso9896154a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470019; x=1701074819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0VeT3zLu+fykyYzLs7U6Fq+OwTbJ76CUKQLeEFbm18=;
        b=QWa7XmH1DxuhEBgPfJukJ0Cj1Tpo6rQyOZ+6hz53ihC+vphJeROrCZMmMzqa7k+Hc3
         OsI6RbF2qI2vLMCuG/3gk99AeF2+h28V3g4qIORRJ7doNNotmi1vXgWtUyblQRBk9oOS
         J1KayVTW6+5OSy1/Fr83pVcYU60EJ87T/YrVv4txJHpbVJI8Qif1rJyIElpkLbRoBaH3
         e5xZpW3hWiMtoYrpkXSBB6dzTVYMILMDAx3YyniKFSYGSYRMER2xjN2fUUWCewjaxQLr
         nsn3P/rvTRajIYC8NsJO5FjN0VLIfGzi4LG0cA6+OhfsEwgsqM5pZ/W/feO81zhs++pA
         QzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470019; x=1701074819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0VeT3zLu+fykyYzLs7U6Fq+OwTbJ76CUKQLeEFbm18=;
        b=WTimRIupxY/t2pi0aq5eb0nwLxu3/f2/BQT8OsEZ9YknIm8NpExKTT5CncdQ2okKJk
         D8lbkj75PEpKwaZztRs8VV4llqvM9XwEJWqiX56iFh0Rhwo3Z3jIpsEBbBGpgS5nEgGW
         mWP1p1FRgyeCtlQDC9Sa7lVKllcXh9IR2IbaCsoiFXsHzuga0JHbWA2doyF+xs+PgbDd
         C5HbL8OpxXLSbcDLDGvGK6KkPZNIF2WikdgqVrGUBbjcW9cWrHR6yUGB6vNomxSlSyi2
         BXeE+P3ACZyE+jKi9moTFcFg4kPG85NhOr50AonQK92G7NvoJRkdGf+q6wS9Rwfpk6uQ
         0kGQ==
X-Gm-Message-State: AOJu0Yy/JxjuZWdSpeDiamuZKxp2fJIN7SyR/WvYf0cIk22X0OxHG8lT
	XCWUABKkpwX6mIg2gXOV9xcR0uMY8CSsrzWTZfJ1Kg==
X-Google-Smtp-Source: AGHT+IHgMpd3Ws7h8OFdjbNqrk7zpNe2njuCTIe3oTo03bu4H7R5WmIaG6uz2tCQcFv1Ly0whKAYmQ==
X-Received: by 2002:a17:906:224d:b0:9a9:f0e6:904e with SMTP id 13-20020a170906224d00b009a9f0e6904emr1511656ejr.16.1700470019575;
        Mon, 20 Nov 2023 00:46:59 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009fdaab907fbsm1158033ejb.188.2023.11.20.00.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:58 -0800 (PST)
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
	horms@kernel.org
Subject: [patch net-next v3 0/9] devlink: introduce notifications filtering
Date: Mon, 20 Nov 2023 09:46:48 +0100
Message-ID: <20231120084657.458076-1-jiri@resnulli.us>
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
Patch #0 extends the infrastructure allowing to filter according
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
  genetlink: implement release callback and free sk_user_data there
  netlink: introduce typedef for filter function
  genetlink: introduce helpers to do filtered multicast
  devlink: add a command to set notification filter and use it for
    multicasts
  devlink: extend multicast filtering by port index

 Documentation/netlink/specs/devlink.yaml | 11 ++++
 drivers/connector/connector.c            |  5 +-
 include/linux/connector.h                |  3 +-
 include/linux/netlink.h                  |  6 +-
 include/net/genetlink.h                  | 35 +++++++++--
 include/net/netlink.h                    | 31 ++++++++--
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/dev.c                        | 13 ++--
 net/devlink/devl_internal.h              | 58 +++++++++++++++++-
 net/devlink/health.c                     | 10 ++-
 net/devlink/linecard.c                   |  5 +-
 net/devlink/netlink.c                    | 77 ++++++++++++++++++++++++
 net/devlink/netlink_gen.c                | 16 ++++-
 net/devlink/netlink_gen.h                |  4 +-
 net/devlink/param.c                      |  5 +-
 net/devlink/port.c                       |  8 ++-
 net/devlink/rate.c                       |  5 +-
 net/devlink/region.c                     |  6 +-
 net/devlink/trap.c                       | 18 +++---
 net/netlink/af_netlink.c                 |  3 +-
 net/netlink/genetlink.c                  |  6 ++
 tools/net/ynl/generated/devlink-user.c   | 33 ++++++++++
 tools/net/ynl/generated/devlink-user.h   | 56 +++++++++++++++++
 23 files changed, 364 insertions(+), 52 deletions(-)

-- 
2.41.0


