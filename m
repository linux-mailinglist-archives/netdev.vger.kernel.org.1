Return-Path: <netdev+bounces-50629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB77F660A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C8F1C209B4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B14B5C7;
	Thu, 23 Nov 2023 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vbuKfEjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBA18B
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c41e95efcbso155196866b.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763348; x=1701368148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNCHnYGMONHAbHP0W8xOQ7lUVLAtju8R0O5AnJzizzo=;
        b=vbuKfEjFQ34iqztAQGUJRLQsx/K636/EMspisq8UlFFgVTd+jmKCqLc08nhmPq7Kgb
         09Ocq2yUp6fRfbZMmqdzpZ/7/X4CDKFqavLKgfX6NjsnV5mzW7C8SbN6bFZfiPvg73vk
         DVegA1a1aHawxAp8+E4f/c2B3UVPaCnWvg3mfaU2pNYqG928cRh4juCxG223YXa6TQE0
         4WDhwKzz++X+msPKMDE9tFfVlXkkcjRrfLrS+qwqbOfS4kEFNHmEGlf9TVL+AkdayBJ/
         gtFMWrTIxWzrciOMiHugHseWL5yr03foqsv6xiITobx6U4TC0c7/FIm3/xjPGfTPuLPh
         xCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763348; x=1701368148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNCHnYGMONHAbHP0W8xOQ7lUVLAtju8R0O5AnJzizzo=;
        b=YLWGE7VhA1i6Cm3ep+jQqdC+0MvLFYcsMi2NY6iDoGQrM17Pn1P80pS6dMYCdamOYr
         nX+Sc2225kzSOIEXGjoHSZMIgtgWgcOIqQI9GRg9MxZN2CcbvJjwRVnt7SZKeixQRzFM
         JYMMd4Spjs3sme3A0tHGBAv/+ibGuKClNX9M1CijoIyGSFDYYevOu/5f0EcqvR67fPB/
         9+OPiscHhcUOlUWeoEJZTUDZ8MarJFx+yRDv5uZpClqSx33UC/AqhI/pgwA+yH+ff62E
         fsGOW5a8fIM2Uo01kRpMY46skvrIgEc/epSZQZ7iQPubzIOTZBF2rB1/Uhp2qUopFk82
         aMmA==
X-Gm-Message-State: AOJu0YxrpwEJQ0swJVBcWMnxmqIpky3cwU/GZFc3OUfI+BY9CoAUmOY9
	3TKH1aYd+ek7oRepQ8rnhANbE28DkV34SLLqb54=
X-Google-Smtp-Source: AGHT+IGCzFQIG3on7VKir7e351AW0T8x3TxYtHBMO7eYEjlweBHK+882EiQSQa5Iv9mBWylKJYo4cQ==
X-Received: by 2002:a17:906:10d:b0:a00:2686:6b40 with SMTP id 13-20020a170906010d00b00a0026866b40mr91349eje.14.1700763347734;
        Thu, 23 Nov 2023 10:15:47 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b009efe6fdf615sm1059033ejb.150.2023.11.23.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:47 -0800 (PST)
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
Subject: [patch net-next v4 0/9] devlink: introduce notifications filtering
Date: Thu, 23 Nov 2023 19:15:37 +0100
Message-ID: <20231123181546.521488-1-jiri@resnulli.us>
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
  genetlink: introduce per-sock family private pointer storage
  netlink: introduce typedef for filter function
  genetlink: introduce helpers to do filtered multicast
  devlink: add a command to set notification filter and use it for
    multicasts
  devlink: extend multicast filtering by port index

 Documentation/netlink/specs/devlink.yaml | 11 +++
 drivers/connector/connector.c            |  5 +-
 include/linux/connector.h                |  3 +-
 include/linux/netlink.h                  |  6 +-
 include/net/genetlink.h                  | 38 ++++++++-
 include/net/netlink.h                    | 31 +++++++-
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/dev.c                        | 13 ++--
 net/devlink/devl_internal.h              | 59 +++++++++++++-
 net/devlink/health.c                     | 10 ++-
 net/devlink/linecard.c                   |  5 +-
 net/devlink/netlink.c                    | 81 ++++++++++++++++++++
 net/devlink/netlink_gen.c                | 16 +++-
 net/devlink/netlink_gen.h                |  4 +-
 net/devlink/param.c                      |  5 +-
 net/devlink/port.c                       |  8 +-
 net/devlink/rate.c                       |  5 +-
 net/devlink/region.c                     |  6 +-
 net/devlink/trap.c                       | 18 ++---
 net/netlink/af_netlink.c                 |  3 +-
 net/netlink/af_netlink.h                 |  1 +
 net/netlink/genetlink.c                  | 98 ++++++++++++++++++++++++
 tools/net/ynl/generated/devlink-user.c   | 33 ++++++++
 tools/net/ynl/generated/devlink-user.h   | 56 ++++++++++++++
 24 files changed, 465 insertions(+), 52 deletions(-)

-- 
2.41.0


