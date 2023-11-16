Return-Path: <netdev+bounces-48436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D357EE571
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475C62810AB
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A235F1F;
	Thu, 16 Nov 2023 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uAtHBd1R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE07D50
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:25 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso13527971fa.2
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153303; x=1700758103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6PldHQDO5sWHVa9ddXZcQubQMVxgzNOraFVyVjPeLE=;
        b=uAtHBd1RjjvegV16Q1/4RVXWBpR2/hzwklFma97NNis/0kAbo0dqM3ji8QVottxbH9
         P94qimjGlXN9BWjVHbv0kVAG7hviQNrKmwnX6sW2BgehLb6IeO6W1vTgqdBFVREA+hfn
         jTeclAjd6oD6w8xGzdEs8o+DX8MRhC/mY9r5BoHXkZBNP5zW2G5Md3hJ8rKeXMyrJmTa
         nvslOyqo2uqFpPo3GW8zaHE/KdNVxwg5czLsM3uniEBKy5+g8bhD0h3Rus0nR67u+7ue
         ihzTgXXevb6rd0DT9+p4NlIcX95NRELn5C9NB/3ZsJKeaplXiEk57w9HhlRAKGnIqnAH
         hwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153303; x=1700758103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6PldHQDO5sWHVa9ddXZcQubQMVxgzNOraFVyVjPeLE=;
        b=dnc8a7wN96niWZ7BMp2hqqjhsPf0ILs+PO8JgX+7XPERLuVT1Z67A7m0n4FgBQ2FD3
         O/xo0DAnGKGT4KzgVDYbuE4oYpAgjNnzHlA3bopT8NTv/PiEkff/MdSL2+rY4fefHHM+
         F+5ImZe5r2T1t64RR/QisGSFnlsNmOjAVC5luReq5zS2MH/wZ1XfDoZ+Lh3FjTfeweA9
         RkRs2efDe4AeNMqg+XwT6OhdafswVwbKjVI/TD6V3qUPmlw7FNTYa1IJGuIjv+BbOVbF
         AHDlZu/BgTll65j1SLDSFg9USk5pexjr4aRFXhCRf9z9woCTlUa483COS/JkFlINtiv6
         b/Bg==
X-Gm-Message-State: AOJu0YzRyMKzv6dRwCVD6Ap97uymIb6S0KPvHNoUZiAnDsF2+LlULet9
	YX83zO5zjw3D9aVzwcS//1fK2BXHSLqPV3DQ36E=
X-Google-Smtp-Source: AGHT+IGg8GYfLRHF39HO9EqW/KirXqshKcEjg8RXkV7kPY0kktfKGSDPjlUes+tu4SvrIOjFo7VDkw==
X-Received: by 2002:a2e:8551:0:b0:2c5:16c0:6239 with SMTP id u17-20020a2e8551000000b002c516c06239mr2177626ljj.51.1700153303533;
        Thu, 16 Nov 2023 08:48:23 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090646cf00b009932337747esm8505898ejs.86.2023.11.16.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:23 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next v2 0/9] devlink: introduce notifications filtering
Date: Thu, 16 Nov 2023 17:48:12 +0100
Message-ID: <20231116164822.427485-1-jiri@resnulli.us>
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
 include/linux/connector.h                |  6 +-
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
 net/netlink/af_netlink.c                 |  6 +-
 net/netlink/genetlink.c                  |  6 ++
 tools/net/ynl/generated/devlink-user.c   | 33 ++++++++++
 tools/net/ynl/generated/devlink-user.h   | 56 +++++++++++++++++
 23 files changed, 366 insertions(+), 56 deletions(-)

-- 
2.41.0


