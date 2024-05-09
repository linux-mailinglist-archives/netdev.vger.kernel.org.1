Return-Path: <netdev+bounces-94878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468538C0EC8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18B328178C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E1131180;
	Thu,  9 May 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JhTxPRCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E51130E34
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253517; cv=none; b=lauzyDnek5AAmrNTvOwCS/2kWxAat+ECk5AJUswLkhyCegUhxhh8Vh0q2+EIfzYyytUz8sw5i400dMC5hIZVddX6hWzlsbS0hJ2dgR5jSC5GU8w80+Dk1Assbn2wCmIjclQpxuKsnMlUGxH8xXd+TRf86rC3phDPtU3/Ylv3k/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253517; c=relaxed/simple;
	bh=g9I/LdGG1qk13RAYc+vDblir4K52XUjCHOHDwLuohSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4BEGMtjBEC95uE7LxvxR/yd9P6SLGf4nbyQKC9loOGysJALM91mwqikkTMQSHTI5Cej2snIluQKsDaS+GNfVn3w4J0YxPWtnsDFg4DCNA/znd0YuuTgBTT11lJOZWGk4s/89RuBviAHsbFd0q/BOju3v1Yz8Y218zipKP3vfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JhTxPRCU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so8333131fa.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715253514; x=1715858314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGUNol9Sbp9a9YBp3ezTFys2dRZcWsWLHOVDA4scBjs=;
        b=JhTxPRCUeDSlHoS8IAiYf/TLAJxz0SnC/RUhRx5ZPVjOVcGIflCMqic9yqkpyK03qE
         hGxXh4dpCsDh0HZ4IuaJ17Svvg+MMdYfYfXfgAhPYSneuZ6h9GtNO+Sl0yt9a7NNhZ/u
         2cUZLrC3dqzylzu7Us8f4vk1JFnSwFPGzabeZ/1e3gOcSevR5wQwXrIOm0PDPRoCmEd+
         7RcrDYOLQW8iX/NxDGiS3h31qxh8QI1kXYLpKxJJB0qh81BMgmmJNdwgcijdjQXgKyyP
         KFoIDDK6Wg5qbM/MIGUC0iRBUZIExRuckQntgOCgZ7o1Ue5jPUl4joVayDlrdtbmYHSn
         DPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715253514; x=1715858314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGUNol9Sbp9a9YBp3ezTFys2dRZcWsWLHOVDA4scBjs=;
        b=RGpQplSHsCdyqddRG0hodkwJnbM9s4fDs/+rOWcR6JfT3weLJdzcsd0YnPvvUriRG3
         RUigGlnM9SZ5DsN4t4N2Yqs0hTu4G7hsR8PVgH40q1c2LvDc1k+YRQrouzEQogwwIbCC
         OMLTDcZk6T/0A/IDEj9G8t2NaxiovCPZ90avTCZtT5iXKsZtjL1h5MPb10uDATKSgk3Q
         SKl9Kihgf6ObdCNrSx1QZivh1A9eBa7xhuOC0k3HgqZprsK626+JTli0SZIrsB7lbBoL
         iLs5pIc8/az8MrB6NmtWMvCzBwgJ7zF5jed3sVUm2y0w1tZTrU7v9AusAALwy+Cju9E9
         s4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyoLhK+2b34HUqTgd5yR+YzGi65KMm8YBSy77oukYFWv4P2dbFB4SGFUQybBESrBuftPMeoWRkNdGW8FMv9bFD1bjtiR3p
X-Gm-Message-State: AOJu0Yy1Cnq17awntjOwDrMFK2Kp1cVVXNbzfG6qtvxG+nULT/w46P8f
	zwz3dt5HLZ9rGLe3j1idmo8keSpiB7UQz62uzfjYONP3AcARXE69bmRFq0a8Mh8=
X-Google-Smtp-Source: AGHT+IGLVOxxL3kZAoAGeYLKAAGLudw62Th0sDUmhinJ2OI+APnW7jbErU8iaxujeGn+RSwWuPZz9Q==
X-Received: by 2002:a2e:90d5:0:b0:2df:c1e7:ab65 with SMTP id 38308e7fff4ca-2e447698f6dmr34604651fa.26.1715253513606;
        Thu, 09 May 2024 04:18:33 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm57547015e9.18.2024.05.09.04.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:18:33 -0700 (PDT)
Date: Thu, 9 May 2024 13:18:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 00/14] ice: support devlink subfunction
Message-ID: <ZjyxBcVZNbWioRP0@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>

Tue, May 07, 2024 at 01:45:01PM CEST, michal.swiatkowski@linux.intel.com wrote:
>Hi,
>
>Currently ice driver does not allow creating more than one networking
>device per physical function. The only way to have more hardware backed
>netdev is to use SR-IOV.
>
>Following patchset adds support for devlink port API. For each new
>pcisf type port, driver allocates new VSI, configures all resources
>needed, including dynamically MSIX vectors, program rules and registers
>new netdev.
>
>This series supports only one Tx/Rx queue pair per subfunction.
>
>Example commands:
>devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>devlink port function set pci/0000:31:00.1/1 state active
>devlink port function del pci/0000:31:00.1/1
>
>Make the port representor and eswitch code generic to support
>subfunction representor type.
>
>VSI configuration is slightly different between VF and SF. It needs to
>be reflected in the code.
>
>Most recent previous patchset (not containing port representor for SF
>support). [1]
>
>[1] https://lore.kernel.org/netdev/20240417142028.2171-1-michal.swiatkowski@linux.intel.com/
>


I don't understand howcome the patchset is v1, yet there are patches
that came through multiple iterations alread. Changelog is missing
completely :/


>Michal Swiatkowski (7):
>  ice: treat subfunction VSI the same as PF VSI
>  ice: create port representor for SF
>  ice: don't set target VSI for subfunction
>  ice: check if SF is ready in ethtool ops
>  ice: netdevice ops for SF representor
>  ice: support subfunction devlink Tx topology
>  ice: basic support for VLAN in subfunctions
>
>Piotr Raczynski (7):
>  ice: add new VSI type for subfunctions
>  ice: export ice ndo_ops functions
>  ice: add basic devlink subfunctions support
>  ice: allocate devlink for subfunction
>  ice: base subfunction aux driver
>  ice: implement netdev for subfunction
>  ice: allow to activate and deactivate subfunction
>
> drivers/net/ethernet/intel/ice/Makefile       |   2 +
> .../net/ethernet/intel/ice/devlink/devlink.c  |  48 ++
> .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 516 ++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |  43 ++
> drivers/net/ethernet/intel/ice/ice.h          |  19 +-
> drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
> drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
> drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 ++-
> drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
> drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
> drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
> drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
> drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++++--
> drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 329 +++++++++++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
> .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
> .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
> drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
> drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
> 26 files changed, 1362 insertions(+), 138 deletions(-)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
>
>-- 
>2.42.0
>
>

