Return-Path: <netdev+bounces-115006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7B9944E23
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0216282DAC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1D1A4861;
	Thu,  1 Aug 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TbsHtVCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF21A3BC7
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522921; cv=none; b=H6nWI5nGRptlpaSdW0xtTGvhYqXuXrmyl5JDYrK7UEzIcb7fxsKEP11y3xwx2GAzBR8dhmbcHCyU0ji3QWGpUR73vuai/xrJBpuXMZHvgPXKYOIFAgOy1wn+oQNZjpQfG5HkJd8hSyvStP/cO9SvksyCa1LOtppMUf+a6MbhuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522921; c=relaxed/simple;
	bh=NWqqvQC9Rjzhlei1DVBE2BkDuKt2JBfnm0PHYf66KlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM6lF438chsURzTJ0WAhvOWeSUwY9StpT/ppT4pdwR7UcW3TOCOy3JXrO2w5ysPN+/uLUuTBqE4rENzlWp1djHi2nTv7AvMuPw5L06bHMXwsk6V0jN4giMhU993LdWswTzMRziXym2DY+gJlUgfTFX+gdZXWjSjd6tXvTMKKfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TbsHtVCD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so711505666b.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722522917; x=1723127717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdtgztGFO3dAZiJr2lVyHoohtdrXM/F7+30RGLozJ+g=;
        b=TbsHtVCD8mShfeXUZiTnwSvOiA5+koCR3P/DAkxgHIvDa91JVhpXk0o3ul26GgaIZA
         m/Ogb2CM65tn/t3h+LUON8rTm1FCZgW6wa6QnqxBhTjzIjNKY+TCImEy3cJPwsbjlXD5
         ZoDoXtO8PjerQedv14XAUiVjuoHP//IkNJ1bnSozjhdGYcOJnj3sFgmkdR3bIYboM/3v
         1GwdQzMMbWFlKOhdE2YxjP5fZLwx+xXgyBscwlqywoVmyci3HnZ2+KbQ3UCPohLLm+bt
         PiH+NMILgRTp9arWId9Er2+yl6r0MD0/hvabmTHQ4CERdKaadI8GKhX9ncxInX/GlFlP
         Rxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522917; x=1723127717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdtgztGFO3dAZiJr2lVyHoohtdrXM/F7+30RGLozJ+g=;
        b=xKpueK0Wd4jS5IX3zGRxswWaVRkTcFBe6zZHJ2h0gCrvnXxHC84WwGVq24UF7GvJz9
         uvb+HC8Jq1plewFYFDgX5a9BjlrJ6XqFN7kL3ipla3CqRIvjBs1cnGeGpIOY1EqOjjBW
         U8mUx1e+c5SRSjnfOHJ5+nmHd5cH63PKisSENXpOJ2A/naHFapDHROZYl+PTmV92o8AE
         FFohRqEdaXrE8gmoq006wvIlhOOD2Vmc0BaB2odPUf/pSAJ1n6+RtD324E8hCdX7bfto
         guUcrM6oa24l8ECSpEogUTIIIHHG+YDVEGWUrKoVwc09of32z5x8cKwgBvZFITCxVdTb
         yEdw==
X-Forwarded-Encrypted: i=1; AJvYcCWT0PSLgpZWNJVqHxKRr1KlQP9T9/udvf2ktgIwKy0WyAW70UYin/TNRGAG/RO/me15MR4Jf9LlIai8OoRr8FwFTNN9bG8v
X-Gm-Message-State: AOJu0Yy7d7zR3i3H5kq1i0wS4NrNCWdUO2nQ5/NlJd8JlzDpEBEBuGi5
	1mKNIPC8g62lg10mvv+qsprYzEKBQGObH0wYl7LdP9TZrylBkBve8rBtUhUywEM=
X-Google-Smtp-Source: AGHT+IEi4RHER4X+Un2+wj6gzZAQIqGfLn3HSw4x8WIVGCLPNyTxiXep2TqpFZW0s6zmbSn8ypvbkg==
X-Received: by 2002:a17:906:db09:b0:a7a:9171:88f4 with SMTP id a640c23a62f3a-a7dc511e80bmr20367266b.68.1722522917293;
        Thu, 01 Aug 2024 07:35:17 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590aa3sm10277012a12.31.2024.08.01.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:35:16 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:35:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqudI07D4XfNZlkO@nanopsycho.orion>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>

Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
>Michal Swiatkowski says:
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

Hmm, interesting. Did you run these commands or just made that up? There
is no "devlink port function del", in case you wonder why I'm asking. I
would expect you run all the commands you put into examples. Could you?


>
>Make the port representor and eswitch code generic to support
>subfunction representor type.
>
>VSI configuration is slightly different between VF and SF. It needs to
>be reflected in the code.
>---
>v2:
>- Add more recipients
>
>v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
>
>The following are changes since commit 990c304930138dcd7a49763417e6e5313b81293e:
>  Add support for PIO p flag
>and are available in the git repository at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
>
>Michal Swiatkowski (8):
>  ice: treat subfunction VSI the same as PF VSI
>  ice: make representor code generic
>  ice: create port representor for SF
>  ice: don't set target VSI for subfunction
>  ice: check if SF is ready in ethtool ops
>  ice: implement netdevice ops for SF representor
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
> .../net/ethernet/intel/ice/devlink/devlink.c  |  47 ++
> .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
> drivers/net/ethernet/intel/ice/ice.h          |  19 +-
> drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
> drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
> drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
> drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
> drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
> drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
> drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
> drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 331 ++++++++++++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
> .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
> .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
> drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
> drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
> 26 files changed, 1396 insertions(+), 137 deletions(-)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
>
>-- 
>2.42.0
>
>

