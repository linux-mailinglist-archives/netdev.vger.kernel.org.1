Return-Path: <netdev+bounces-119211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18167954C29
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AD3B22AFB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CC1BD013;
	Fri, 16 Aug 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="loNZRDKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0E1BC9F6
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817843; cv=none; b=nXg3K8Ysa4aG8L/47RwS88LsUj86pw/Cfm50gjGNtKqkrVtMCR01zZUxoN4jw4RHz7thO7fILt7D6TkpDYQqbrg2cLVvIIlfHSxC996VYI8XgRbfBYdPMUk589/TjlBbLCbksKKedyB4BYNhsfX6ZupfghYbo021udcEpNb+gFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817843; c=relaxed/simple;
	bh=ukMZebz2RZdo5DgbVI6epr9ngCrJzkah5zzCfs1lWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCo/t8rKTEfyaqqvxeL2vTdHZmD0qN12Bya/4HkCt9RkgEdsdkfc6D3VgwiydxzFxmbsbRxm1d8ZbeLm3Lw/WGgpv83yJ/34Y+IaHsnXGzGPowBNr89ZVbJqfp5hOVfCOfo4tmfQ1CPi96p4ZhE4ULnVdoF6yNE5t+/ccEeZ61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=loNZRDKO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso24089141fa.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723817839; x=1724422639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VvN3FvbpNRoICbi1AtBly0NJ6wX4AMf0pS50QK6KaOc=;
        b=loNZRDKOm1aQR5NN5z2drbcSHHlz1tO0yX98E1TnQOh+pNXFVzcRt+l/AiF+Kxrksa
         jB+sQsaSVd4bA2QY4dLsOMTZGKBfoYfY8g72ikyjUsrrKKWLtldqIIdpAtW8YZUkY3GX
         kKNXo/eGZH2p8OTYg/w0aeIOBedOHAi7UQvzq6iJZifx7Xu/bwyeDrCV4IkMP/9PDQ4B
         ayr3uMsONSBh/TdlcYuxW8rXyJkVSZVVATzIetM32RFXXiDB86/WWVn36C+KLL5jf6yk
         1mB4NhXf42v1C5b7NKpNCmrSxmtMlzehoSE+4Xg+9pB3/aINoATFCUs6LuDULQ/9dUPs
         PjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817839; x=1724422639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvN3FvbpNRoICbi1AtBly0NJ6wX4AMf0pS50QK6KaOc=;
        b=e4ag0g0o6EuN7HMDMeW6C88YOYVVOx3809HLNIUvvvhxQF6ZK3yi7VbCLsYmFuC4kP
         8x6klB9BwOkEjY8r0PdcS06uG+80clS8DHfS9HKo8a5gNtJaJm+k+4xk4v4RkMfxm9xL
         6M1JFXQVnf/JCSG+UiSebY6TegOuGuU36ZTsvt/fRagebBO67/4zLz9TtQg+WISah0YM
         cNC7L92go98JXxW9kE7B10pf3XZJ3/4eWSkqnBFW++d2fE8Dw27Z/RYvcNd2IkKW+MDO
         vEnHFaBdUEj3HdZuA4rqzZfp4NSuuYfSZxn0LDg7KYA396khz/+eLDdPJa9NMeEGbulF
         Zb4w==
X-Gm-Message-State: AOJu0YyS6T5Y6NRVyBH0M5lRn6e+aIzSegwuKTvHhmvLlqPpnRN3qL7Q
	N7NwbJZKpwOwBbq9ziDTztWzwYsmeBRG8l2olHAos8E9ylpoq3XQfvQ54MO8718=
X-Google-Smtp-Source: AGHT+IHJmY4mVajyYXJzMIa95KHs1BP/XHnHGNW3M09OkNCU5WCh7jVf29kVpFgMqUmSLbGupmk/Tg==
X-Received: by 2002:a2e:b8c1:0:b0:2ef:2d4c:b4ba with SMTP id 38308e7fff4ca-2f3c6a22cbemr4193091fa.36.1723817838860;
        Fri, 16 Aug 2024 07:17:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded180e7sm78079165e9.3.2024.08.16.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:17:18 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:17:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
 representors
Message-ID: <Zr9faQVDuJydDwir@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
 <ZrTob59KQxzbcKhF@nanopsycho.orion>
 <CH0PR18MB43399A157452720075C21D99CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR18MB43399A157452720075C21D99CD812@CH0PR18MB4339.namprd18.prod.outlook.com>

Fri, Aug 16, 2024 at 03:36:25PM CEST, gakula@marvell.com wrote:
>
>
>>-----Original Message-----
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, August 8, 2024 9:17 PM
>>To: Geethasowjanya Akula <gakula@marvell.com>
>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>Subject: [EXTERNAL] Re: [net-next PATCH v10 00/11] Introduce RVU
>>representors
>>
>>Mon, Aug 05, 2024 at 03: 18: 04PM CEST, gakula@ marvell. com wrote: >This
>>series adds representor support for each rvu devices. >When switchdev mode
>>is enabled, representor netdev is registered >for each rvu device. In
>>implementation of 
>>Mon, Aug 05, 2024 at 03:18:04PM CEST, gakula@marvell.com wrote:
>>>This series adds representor support for each rvu devices.
>>>When switchdev mode is enabled, representor netdev is registered for
>>>each rvu device. In implementation of representor model, one NIX HW LF
>>>with multiple SQ and RQ is reserved, where each RQ and SQ of the LF are
>>>mapped to a representor. A loopback channel is reserved to support
>>>packet path between representors and VFs.
>>>CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>>>adds representor support for both RPM and SDP MAC interfaces.
>>>
>>>- Patch 1: Refactors and exports the shared service functions.
>>>- Patch 2: Implements basic representor driver.
>>>- Patch 3: Add devlink support to create representor netdevs that
>>>  can be used to manage VFs.
>>>- Patch 4: Implements basec netdev_ndo_ops.
>>>- Patch 5: Installs tcam rules to route packets between representor and
>>>	   VFs.
>>>- Patch 6: Enables fetching VF stats via representor interface
>>>- Patch 7: Adds support to sync link state between representors and VFs .
>>>- Patch 8: Enables configuring VF MTU via representor netdevs.
>>>- Patch 9: Add representors for sdp MAC.
>>>- Patch 10: Add devlink port support.
>>>
>>>
>>>Command to create PF/VF representor
>>>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev VF
>>>representors are created for each VF when switch mode is set switchdev
>>>on representor PCI device
>>>
>>>#devlink dev
>>>pci/0002:01:00.0
>>>pci/0002:02:00.0
>>>pci/0002:1c:00.0
>>
>>What are these 3 instances representing? How many PFs do you have? 3?
>>How many physical ports you have?
>The test setup has 3 PFs one for each physical port.
>
>Below example is for the device pci/0002:1c:00.0.

3 port nic, that sounds odd. Is this something shipped already? Care to
paste a link?


>>
>>
>>>
>>>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>>>
>>># ip link show
>>>	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>>mode
>>>DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd
>>>ff:ff:ff:ff:ff:ff
>>
>>What is this eth0? Why isn't it connected to any devlink port?
>>
>>>	r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>>mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd
>>ff:ff:ff:ff:ff:ff
>>>	r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>>mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd
>>ff:ff:ff:ff:ff:ff
>>>	r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>>mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd
>>ff:ff:ff:ff:ff:ff
>>>	r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>>mode
>>>DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd
>>>ff:ff:ff:ff:ff:ff
>>>
>>>
>>>~# devlink port
>>>pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0
>>>pfnum 1 vfnum 0 external false splittable false
>>>pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0
>>>pfnum 1 vfnum 1 external false splittable false
>>>pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0
>>>pfnum 1 vfnum 2 external false splittable false
>>>pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0
>>>pfnum 1 vfnum 3 external false splittable false
>>
>>You are missing physical port devlink instance here? Where is it?
>pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum 1 vfnum 0 external false splittable false
>This is for the PF.

That is not a physical port. The flavour should be "physical" for them.


>
>Below is the example on a setup with one PF before  3VFs are created.
>
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>
># ip link show
>	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
>DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd ff:ff:ff:ff:ff:ff
>r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd ff:ff:ff:ff:ff:ff
>r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd
>ff:ff:ff:ff:ff:ff
>r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd ff:ff:ff:ff:ff:ff
>r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode

How you setup the netdevice names? Do you have custom udev rule? Would
be great to give here the out-of-box udev names instead.



>DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd ff:ff:ff:ff:ff:ff
>
>Above shows the PF physical port and 4 representors(1 for PF and 3 for VFs).
># devlink port
>pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller  0 pfnum 1 vfnum 0 external false splittable false
>pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
>pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
>pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
>
>>
>>>
>>>
>>>-----------
>>>v1-v2:
>>> -Fixed build warnings.
>>> -Address review comments provided by "Kalesh Anakkur Purayil".
>>>
>>>v2-v3:
>>> - Used extack for error messages.
>>> - As suggested reworked commit messages.
>>> - Fixed sparse warning.
>>>
>>>v3-v4:
>>> - Patch 2 & 3: Fixed coccinelle reported warnings.
>>> - Patch 10: Added devlink port support.
>>
>>
>>When someone reviews your patchset at some version, you put him to cc list
>>from that point. Why didn't you put me to cc list?
>>
>>
>>>
>>>v4-v5:
>>>  - Patch 3: Removed devm_* usage in rvu_rep_create()
>>>  - Patch 3: Fixed build warnings.
>>>
>>>v5-v6:
>>>  - Addressed review comments provided by "Simon Horman".
>>>  - Added review tag.
>>>
>>>v6-v7:
>>>  - Rebased on top net-next branch.
>>>
>>>v7-v8:
>>>   - Implmented offload stats ndo.
>>>   - Added documentation.
>>>
>>>v8-v9:
>>>   - Updated the documentation.
>>>
>>>v9-v10:
>>>  - Fixed build warning w.r.t documentation.
>>>
>>>Geetha sowjanya (11):
>>>  octeontx2-pf: Refactoring RVU driver
>>>  octeontx2-pf: RVU representor driver
>>>  octeontx2-pf: Create representor netdev
>>>  octeontx2-pf: Add basic net_device_ops
>>>  octeontx2-af: Add packet path between representor and VF
>>>  octeontx2-pf: Get VF stats via representor
>>>  octeontx2-pf: Add support to sync link state between representor and
>>>    VFs
>>>  octeontx2-pf: Configure VF mtu via representor
>>>  octeontx2-pf: Add representors for sdp MAC
>>>  octeontx2-pf: Add devlink port support
>>>  octeontx2-pf: Implement offload stats ndo for representors
>>>
>>> .../ethernet/marvell/octeontx2.rst            |  85 ++
>>> .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>>> .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>>> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>>> .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
>>> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>>> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>>> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>>> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>>> .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>>> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 +-
>>> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>>> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>>> .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 +++++++++++
>>> .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>>> .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>>> .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>>> .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>>> .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>>> .../marvell/octeontx2/nic/otx2_common.c       |  58 +-
>>> .../marvell/octeontx2/nic/otx2_common.h       |  84 +-
>>> .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
>>> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
>>> .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
>>> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>>> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
>>> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 725 ++++++++++++++++++
>>> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
>>> 28 files changed, 1962 insertions(+), 227 deletions(-) create mode
>>> 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>>> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>>> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>>>
>>>--
>>>2.25.1
>>>
>>>

