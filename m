Return-Path: <netdev+bounces-116931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A596F94C1BA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AF61C22B8D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53BB18E74A;
	Thu,  8 Aug 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="InzQ71Ud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EA1552F5
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132021; cv=none; b=GjI2nkOpSVetYY9voP5tuLGeRix9bEqjnAnHRE9wb9R5mB7W1XAG3RrOeflN/vfU0wgjy0CX2sfgtNmKBE2ZkegYmtmWPzgv/2r/08ltna3fg7wDri8TkGe4rgzcWNZy6JF6DYZexrYTZwip8hv6OuSrv06gXluyDBquBZMNoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132021; c=relaxed/simple;
	bh=KRzDxAn9RJpwk/tqZsp8jq+57KXYd5G7EshwjMGNWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk4YFGFt+9Fp/OzorCd0j9bIv4S5fpwEa5RpVtyysIBdzia9Y6QrNvhReYxHJx0AEghW2B/bbs3tXUz5hg0bXWBjji+ZWdCgabaTq1+ztAtbo4BUtPsML9Bu1exESVtDejrJvXEMkzONX0yb5115YKX/eNHxekkFxtsM8L/FJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=InzQ71Ud; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9e25008aso138349866b.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723132018; x=1723736818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCeRekzLFEJrJabDQJ0cJLMedoMMEpBax/bjNXZ6/3U=;
        b=InzQ71UdOqjtz7ueDLM96fHAW3LdgICpMmxxUhBwhnIMNAB1hPsv9JHIGsU7iE8Nvz
         a7KOBnR7IJdxrfYsirPg76JdYY8sswlOGGR2nHah50zMWGH4WW96+0IqottOAIJwAas/
         uKgvJO6Lu2YMkHrf8i60+LE/ZqWQoSV2KOd3U2C05DAWTADy6eJxpwAyJ8oDJ2LOXXy5
         2Hnj7YzxADfZ7W8wUk1+N87AduG508EACiZJCpMfxtUkfwwg3aFA3xl2IQ4gA+G6GqNJ
         9MuxmLlTwuhppW1YGMUtb61FxQ64dkiEGs8g+wKB9s91VbZUiiEIvJRxgGlBx6zoBG9d
         mKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132018; x=1723736818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCeRekzLFEJrJabDQJ0cJLMedoMMEpBax/bjNXZ6/3U=;
        b=BxtuO/dhDYsQ8mLpDGXt1ykVNsHQCfUHEg8lQD68bZ6h4ua1offbx+59XyigldWgTw
         jqlj5Mj/jA56ruNgdx7XP3VEK4ySAFOjBP9JDJU636XhRQa9WPjJebuRaIYs6zkdP7D0
         VJ+miCMcQQenS4J0+RN22a64vn40bA4bDspl2162IWZ8mSWXiu0QeuXWFxu7YN8R7KA/
         n1W7IsaJcdyizdDEcm3Cam0xHYBm2V5cApU+Gms61p2lDxT9JCf0V2nPCPaqm3E9T1xr
         Q+LjsHWcgXLR17bixUHdINp5pWMsjcJ0G1OlLoi18n81JMJlL/HkvaI7YOC1kkxYtd51
         PAGw==
X-Gm-Message-State: AOJu0YyKS5sNkV84YSrXHjahcjtgRUu8DAKbQGxhgy6llQn73oNwik2X
	Atipazqpdo237bS479t0Ac0bEh/1WplOeNZdsUcaS72jL1hHsKfU9euIyyQ+9GM=
X-Google-Smtp-Source: AGHT+IFahXkRcwGDkqHT+ox+Aw0u5vNDs9X2x46SevsSQ6ELzkieCAHfhpc+nmonFnJTbuurKx1UxQ==
X-Received: by 2002:a17:906:6a04:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a8090e3a702mr186924266b.43.1723132017762;
        Thu, 08 Aug 2024 08:46:57 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8ce3sm755599266b.216.2024.08.08.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:46:57 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:46:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v10 00/11] Introduce RVU representors
Message-ID: <ZrTob59KQxzbcKhF@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805131815.7588-1-gakula@marvell.com>

Mon, Aug 05, 2024 at 03:18:04PM CEST, gakula@marvell.com wrote:
>This series adds representor support for each rvu devices.
>When switchdev mode is enabled, representor netdev is registered
>for each rvu device. In implementation of representor model, 
>one NIX HW LF with multiple SQ and RQ is reserved, where each
>RQ and SQ of the LF are mapped to a representor. A loopback channel
>is reserved to support packet path between representors and VFs.
>CN10K silicon supports 2 types of MACs, RPM and SDP. This
>patch set adds representor support for both RPM and SDP MAC
>interfaces.
>
>- Patch 1: Refactors and exports the shared service functions.
>- Patch 2: Implements basic representor driver.
>- Patch 3: Add devlink support to create representor netdevs that
>  can be used to manage VFs.
>- Patch 4: Implements basec netdev_ndo_ops.
>- Patch 5: Installs tcam rules to route packets between representor and
>	   VFs.
>- Patch 6: Enables fetching VF stats via representor interface
>- Patch 7: Adds support to sync link state between representors and VFs .
>- Patch 8: Enables configuring VF MTU via representor netdevs.
>- Patch 9: Add representors for sdp MAC.
>- Patch 10: Add devlink port support.
>
>
>Command to create PF/VF representor
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>VF representors are created for each VF when switch mode is set switchdev on representor PCI device
>
>#devlink dev
>pci/0002:01:00.0
>pci/0002:02:00.0
>pci/0002:1c:00.0

What are these 3 instances representing? How many PFs do you have? 3?
How many physical ports you have?


>
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>
># ip link show
>	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd ff:ff:ff:ff:ff:ff

What is this eth0? Why isn't it connected to any devlink port?

>	r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd ff:ff:ff:ff:ff:ff
>	r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd ff:ff:ff:ff:ff:ff
>	r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd ff:ff:ff:ff:ff:ff
>	r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd ff:ff:ff:ff:ff:ff
>
>
>~# devlink port
>pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum 1 vfnum 0 external false splittable false
>pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
>pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
>pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false

You are missing physical port devlink instance here? Where is it?


>
>
>-----------
>v1-v2:
> -Fixed build warnings.
> -Address review comments provided by "Kalesh Anakkur Purayil".
>
>v2-v3:
> - Used extack for error messages.
> - As suggested reworked commit messages.
> - Fixed sparse warning.
>
>v3-v4: 
> - Patch 2 & 3: Fixed coccinelle reported warnings.
> - Patch 10: Added devlink port support.


When someone reviews your patchset at some version, you put him to cc
list from that point. Why didn't you put me to cc list?


>
>v4-v5:
>  - Patch 3: Removed devm_* usage in rvu_rep_create()
>  - Patch 3: Fixed build warnings.
>
>v5-v6:
>  - Addressed review comments provided by "Simon Horman".
>  - Added review tag. 
>
>v6-v7:
>  - Rebased on top net-next branch.
>
>v7-v8:
>   - Implmented offload stats ndo.
>   - Added documentation.
>
>v8-v9:
>   - Updated the documentation.
>
>v9-v10:
>  - Fixed build warning w.r.t documentation.
>
>Geetha sowjanya (11):
>  octeontx2-pf: Refactoring RVU driver
>  octeontx2-pf: RVU representor driver
>  octeontx2-pf: Create representor netdev
>  octeontx2-pf: Add basic net_device_ops
>  octeontx2-af: Add packet path between representor and VF
>  octeontx2-pf: Get VF stats via representor
>  octeontx2-pf: Add support to sync link state between representor and
>    VFs
>  octeontx2-pf: Configure VF mtu via representor
>  octeontx2-pf: Add representors for sdp MAC
>  octeontx2-pf: Add devlink port support
>  octeontx2-pf: Implement offload stats ndo for representors
>
> .../ethernet/marvell/octeontx2.rst            |  85 ++
> .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 +-
> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
> .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 +++++++++++
> .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> .../marvell/octeontx2/nic/otx2_common.c       |  58 +-
> .../marvell/octeontx2/nic/otx2_common.h       |  84 +-
> .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
> .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 725 ++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
> 28 files changed, 1962 insertions(+), 227 deletions(-)
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>
>-- 
>2.25.1
>
>

