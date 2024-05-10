Return-Path: <netdev+bounces-95406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30778C22D2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9151C20BA5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A216C844;
	Fri, 10 May 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="faQcGGRb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11158168AFC
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339366; cv=none; b=ZOqPrk53tfa7uDXPj2SEm11TKp3HZyn2jJz4+GPiS4J510HNKi+0kNblM9XGDpiniyRkfglzP1tMzkQ0ZXwkN7hgfeV8rfSzgT1uwsC6O6rGEdDsUaVnSrln1lLx3+cip0OGBVEuoRLLfaVVIO36PYkPbvprncE5NjwJ7h3VSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339366; c=relaxed/simple;
	bh=yXm0rGv0SpUKCUwVX7b65X94UNh8dxxZjbauFPeL+MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRAV734ze/4EFquJ7OLABmt99p4aUMJk6DoTlnyOYANJsUeJU1d+mAOh225AjU1YOkv0aeACP7R50dEVCulObuDj98gpSRXLAFgmXOONXcZIRbK2MBACWa2FIho6W5R2cJFwb/M91KhIqe/PbdCOBMesYsfmqgYDOdWGRi3jmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=faQcGGRb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so13205385e9.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715339363; x=1715944163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMwf+DCXvMg1n2aNwOdekgphxaHoyXL6HU0CbhNE4i4=;
        b=faQcGGRbMRMAgY0BIJPOeyUang5o4xOy6ug/5AAJFqam2KAHvDSq3MrJ1wxtpFPWUu
         PBFo9Aiw+9MEp/KvIYgiPFCulh1fbSXm9cRiZJV44RhKUuSpc6JIXSgTCr8Yy0QtVnWT
         agaqm1VhWHmGrJ4Xvd2oynhsUz4vsebXFGfYHkTLwY6fy3PgVnXIEVx0Dcx4ep6Yg+in
         EU5owss5H+h19jY4T/25tuhWNK45QMF3w/gxV5khvjdZbs+/XiSBp1CzWdZy8JSEvvev
         O4NoFm/hc7SOkoUFIrkXky/vD20FsDfbGuuh7bWBhoxae9hQhv3NJHyA0gaKGIyKywkw
         wcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339363; x=1715944163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMwf+DCXvMg1n2aNwOdekgphxaHoyXL6HU0CbhNE4i4=;
        b=A+DZSYLDJG5MWqFqo4XVtG8J8MtDAdKR4yP9hNvVrlOxUGqJ65umC+aml/7NWZ3Lv+
         quMYglv0BAFta7Obc0o5jtmHSTy6ZR6rWHOIj97+aYbaL2gUIcWRVgwydiyFIcM9ycxD
         CShXIZT6hvyem0C5UJ8jiBxiv9QWqD5dsssPrDLLawGN9uPzUffDGCnfN3IPXRND2W8/
         nn7NlIlrivTRcSxsvEqC+QrcE0hbgWDWSrEZ0Z8Kl0559Kizi4uFkzjGUG7yrRhQ+b7Q
         ht9qz5ln8vPc/puCogCMWAzOyOliNYUS1C4WkGSz01eG86C4QJ/sv8AREN9Zhe1+8kOG
         mUOw==
X-Forwarded-Encrypted: i=1; AJvYcCV9mB77TBH6pK0ORhQu8gj6nP2Lnp2mNnoN03uUJ19b0J1Y9TQ95qYtUONGkZvT9b+8k7QdDE2KJ494jzvysYxr/lMWTQbj
X-Gm-Message-State: AOJu0YyFKyZeQs6Sums6ITm2Y482i2eSHjmpVoxST/abpRT4X7Chjg/I
	S3ZrWTXrROR0FmwR+6sVgQvK0xAuyhZrzTX79LBQuK8FxD3kFmj3SnlUnbRUW3qyBH5yVn+Ibpd
	P
X-Google-Smtp-Source: AGHT+IH7bU+JTVmvtCYb1yGI1ZN7O+t2cgLqlM6omTt5lqwzAFbTeQgMQmETXsC1cB8cknIhS9uEaQ==
X-Received: by 2002:a7b:c8cb:0:b0:418:e6fc:3708 with SMTP id 5b1f17b1804b1-41feab40c17mr16382645e9.24.1715339363142;
        Fri, 10 May 2024 04:09:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f74sm60380915e9.8.2024.05.10.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:09:22 -0700 (PDT)
Date: Fri, 10 May 2024 13:09:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 00/14] ice: support devlink subfunction
Message-ID: <Zj4AYN4uDtL51G1P@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <ZjyxBcVZNbWioRP0@nanopsycho.orion>
 <Zj3LwDMbktRXk0QX@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3LwDMbktRXk0QX@mev-dev>

Fri, May 10, 2024 at 09:24:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, May 09, 2024 at 01:18:29PM +0200, Jiri Pirko wrote:
>> Tue, May 07, 2024 at 01:45:01PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >Hi,
>> >
>> >Currently ice driver does not allow creating more than one networking
>> >device per physical function. The only way to have more hardware backed
>> >netdev is to use SR-IOV.
>> >
>> >Following patchset adds support for devlink port API. For each new
>> >pcisf type port, driver allocates new VSI, configures all resources
>> >needed, including dynamically MSIX vectors, program rules and registers
>> >new netdev.
>> >
>> >This series supports only one Tx/Rx queue pair per subfunction.
>> >
>> >Example commands:
>> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>> >devlink port function set pci/0000:31:00.1/1 state active
>> >devlink port function del pci/0000:31:00.1/1
>> >
>> >Make the port representor and eswitch code generic to support
>> >subfunction representor type.
>> >
>> >VSI configuration is slightly different between VF and SF. It needs to
>> >be reflected in the code.
>> >
>> >Most recent previous patchset (not containing port representor for SF
>> >support). [1]
>> >
>> >[1] https://lore.kernel.org/netdev/20240417142028.2171-1-michal.swiatkowski@linux.intel.com/
>> >
>> 
>> 
>> I don't understand howcome the patchset is v1, yet there are patches
>> that came through multiple iterations alread. Changelog is missing
>> completely :/
>> 
>
>What is wrong here? There is a link to previous patchset with whole
>changlog and links to previous ones. I didn't add changlog here as it is
>new patchset (partialy the same as from [1], because of that I added a
>link). I can add the changlog from [1] if you want, but for me it can be
>missleading.

It's always good to see what you changed if you send modified patches.
That's all.


>
>> 
>> >Michal Swiatkowski (7):
>> >  ice: treat subfunction VSI the same as PF VSI
>> >  ice: create port representor for SF
>> >  ice: don't set target VSI for subfunction
>> >  ice: check if SF is ready in ethtool ops
>> >  ice: netdevice ops for SF representor
>> >  ice: support subfunction devlink Tx topology
>> >  ice: basic support for VLAN in subfunctions
>> >
>> >Piotr Raczynski (7):
>> >  ice: add new VSI type for subfunctions
>> >  ice: export ice ndo_ops functions
>> >  ice: add basic devlink subfunctions support
>> >  ice: allocate devlink for subfunction
>> >  ice: base subfunction aux driver
>> >  ice: implement netdev for subfunction
>> >  ice: allow to activate and deactivate subfunction
>> >
>> > drivers/net/ethernet/intel/ice/Makefile       |   2 +
>> > .../net/ethernet/intel/ice/devlink/devlink.c  |  48 ++
>> > .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
>> > .../ethernet/intel/ice/devlink/devlink_port.c | 516 ++++++++++++++++++
>> > .../ethernet/intel/ice/devlink/devlink_port.h |  43 ++
>> > drivers/net/ethernet/intel/ice/ice.h          |  19 +-
>> > drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
>> > drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
>> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 ++-
>> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
>> > drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
>> > drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
>> > drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
>> > drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
>> > drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++++--
>> > drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
>> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 329 +++++++++++
>> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
>> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
>> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
>> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
>> > drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>> > drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
>> > .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
>> > drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
>> > 26 files changed, 1362 insertions(+), 138 deletions(-)
>> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
>> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
>> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
>> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
>> >
>> >-- 
>> >2.42.0
>> >
>> >

