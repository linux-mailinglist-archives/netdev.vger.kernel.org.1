Return-Path: <netdev+bounces-56340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7E80E8E6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F693B20E71
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A55B5B7;
	Tue, 12 Dec 2023 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dcYNv8AT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0492
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54dccf89cfdso7133078a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376258; x=1702981058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyFz37zOopijAs6FvGs9QhUXSjjHqSSR9f3mj9EE3Lk=;
        b=dcYNv8AT5SIvuM4lcLDrZFDm6ZxZn9Hx/qn0SH65jFd6xxS0sITBu5NZfJBV0NQxTD
         e4GgmuyxrN5YWEEIw7FQZtznV0rAzKEV2UxCg8Idm+fwzHdX7odao4OknUq2Kyh6UkU1
         xkLrWGQLP+TSBTlVv0BeBnhyqKkNxaWcBi53lIGVZ4+mG4gxo/VKTGdwDLGipUSTWXnA
         j4dXNb9jk/2cAy9hepl1aT/X5hE6Wds1RhAhcD8M+1ip83LKD3EB0aQacmfLMY3XBcBe
         ONfG0j4vzhL8i8o+89UE8QMTPPyRcixerar1HcpMC8xMu8scpobQ7oL8BaJesq2Yytel
         OG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376258; x=1702981058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyFz37zOopijAs6FvGs9QhUXSjjHqSSR9f3mj9EE3Lk=;
        b=mpPpVn1WJgJCP6nGLyQ/rYHmJRMzm4dN7ZxUZDdmAsDVascxFTy6z8OoBSp7UE9Ad7
         MKCALrU6Q+8H0qzwDleMpQcfqswiL3fR4KJPI6yarpjTzhOO5uueOa2ZGlJA8lZaqupL
         OS53JHdfOpwi4BUH4e3r8YDaUDoUeXLHqVfFQ+S3yD0/BbOF82BSjDwkX8w9MKzDrw7t
         NU9N15FXLz4yaxvhkj55SSOUMF7zqxhYP7kn2TRybK7bcjFDitG8zLL6THCTNzUBpdZj
         hg6EuFAl/IQ4t3krNyCgLNM5a3AfnEiw9NYi9MFj5RKm6wdNqR9AcXX6XtbS1ZMwgz7u
         /bMw==
X-Gm-Message-State: AOJu0YwWvyHsAjhJjd5tT2mTS1RY6H1rBopHXPmE/eP/j0HiPS1RFK3C
	74SJJpgoKw5RGaR3u1upxY9SVUUCNhhzORJEW+w=
X-Google-Smtp-Source: AGHT+IFZAprxrA5q+J0jssi1IEfkogw8dvcU1bVZFyJtqBwuT5fem0vHv3Q+dtkMv88IBoUHY0385Q==
X-Received: by 2002:a50:8e15:0:b0:54c:4837:9a96 with SMTP id 21-20020a508e15000000b0054c48379a96mr3716015edw.61.1702376257968;
        Tue, 12 Dec 2023 02:17:37 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dk11-20020a0564021d8b00b0054c8415f834sm4607360edb.34.2023.12.12.02.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:37 -0800 (PST)
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
Subject: [patch net-next v6 0/9] devlink: introduce notifications filtering
Date: Tue, 12 Dec 2023 11:17:27 +0100
Message-ID: <20231212101736.1112671-1-jiri@resnulli.us>
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
 include/net/genetlink.h                  |  51 +++++-
 include/net/netlink.h                    |  31 +++-
 include/uapi/linux/devlink.h             |   2 +
 net/devlink/dev.c                        |  13 +-
 net/devlink/devl_internal.h              |  59 ++++++-
 net/devlink/health.c                     |  10 +-
 net/devlink/linecard.c                   |   5 +-
 net/devlink/netlink.c                    | 116 +++++++++++++
 net/devlink/netlink_gen.c                |  16 +-
 net/devlink/netlink_gen.h                |   4 +-
 net/devlink/param.c                      |   5 +-
 net/devlink/port.c                       |   8 +-
 net/devlink/rate.c                       |   5 +-
 net/devlink/region.c                     |   6 +-
 net/devlink/trap.c                       |  18 +-
 net/netlink/af_netlink.c                 |   5 +-
 net/netlink/af_netlink.h                 |   7 +
 net/netlink/genetlink.c                  | 207 ++++++++++++++++++++++-
 22 files changed, 539 insertions(+), 54 deletions(-)

-- 
2.43.0


