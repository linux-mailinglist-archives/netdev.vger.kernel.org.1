Return-Path: <netdev+bounces-71227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D412852BD5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C81C21FE7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC71B5B1;
	Tue, 13 Feb 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iD3GvqYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56811224C6
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814828; cv=none; b=RDdEb60dLKfgbQYWPnlrdztcVt9LNOCY/rTu7taPCwRKjo1OQHUYyRn6JAEY7T84m5mQmwUsLZvJYpPtKzks7TLbv2S8O+XL+y0Xrbj6zcqRkskmvdt/JLyPoyhooK5UsPB7lptKV6H5DekyqO2ke0BsN6Hdi7x8Ko7N2VDizII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814828; c=relaxed/simple;
	bh=G4ak1fJs5LIlxcyjTCNdjrc02mhjfyxapvhrm9PqB3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ+m6jbOxzOZSg5dyFSQ/jyKcO7KDdhczDUok7OeJd15mR7XgcMPn8nABs973B3J43eFVrx9dGIJ0zr0q5l4lZ4ORv+aqiUSTvYbmCNYdR6iMz2L4dL6TDLwUaPXvcUXf54zqKYAwKVq4trmU1oIq+5mzy75QCAPU7oDQsGSTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iD3GvqYx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26f73732c5so565181266b.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707814824; x=1708419624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqUPPNy4GfJSI61OTipqiXkGCm8NPtsO8IerHdBwao4=;
        b=iD3GvqYxAmgiZhVw5G5vUko3Nm3DNgEQl9UgWNxMVrBBv25FZ8zDwI6mCP8ZepEuHS
         FJI9c3qDx8uy/r/co3133gR3fwirdD9vb76DCXTSd3CpEcYbYg3YUXVr17qZjslU/3qT
         qHdU8cMNFxHaLX0zgoDkN0IC3Ad8lMtqEohFlWTOYk5jl2BtUG0V5Vs8+X+ygcqgZ7+Z
         oOxXoNnxAX0GpIKxfTRaazEL0mu5gi9Qk+fweqHfIzozM1xPIDbklsTp07t4ixX1gpl7
         ivnM1QKfUB44jKjzsdZsgNdfFBko5igJG94p+0Xoj2izdruBgon/x/IvoKVc1Itm/Hgf
         uXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814824; x=1708419624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqUPPNy4GfJSI61OTipqiXkGCm8NPtsO8IerHdBwao4=;
        b=W8oH8v246dYnex2rc+MdCg+K/SKrTb9/KCBAtLkSCOmT9OT0hzG4KIRp/BU/dtCSW0
         2apyIxgt3cEIlfyGo9X8VBfTrWyvT5EwnfamSj+Acx7hGCR2EhVeT7TQKGJzwJfAHMyK
         D7QuZrKWBsImwFEp0vhGJ91zn0bWk/aBVn4JBnpfdFgW4xPvDRdueEd79/S7XufREHAF
         6AEZyn1kVle6Iv8T52KE/jUOUdwNzuS3OisE4Oj4GB2N4NQeDy/F7kCUZ0GWavaXJlYy
         sqCbbdPdK+uNInytBISQ6ML2V4sfRVMAgGxRi6b9yCXzg5geJoKy1gwoqb+N3UofOBlY
         DFiA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1rzrbTHoGxqglOSLM9VKYBUsKW6KF9WkwBU0qA2cHhkgiutz48XR1VD/OXw18ks6oSkKVbVL+Nyl2c5Y/gXkKcEoTa2f
X-Gm-Message-State: AOJu0YzQA3SRnFJdanmPty8ta0ZuJkysi7VGJy9ua8mcf67EafH2taMj
	VNFhoFhvk5WccBmNSQuBsY45mnHLrVCC0dSs/D71ZoENDwQnO6X9Z1Zvd2nJGE0=
X-Google-Smtp-Source: AGHT+IFHIu6hhkqL7MIUl/jZbvId0QmL81seiUP4GF2B4jqgYRRfuUByv0ryWqlqCArLmoUyJkvT5w==
X-Received: by 2002:a17:906:d8b8:b0:a3a:779a:78a6 with SMTP id qc24-20020a170906d8b800b00a3a779a78a6mr6228652ejb.22.1707814824421;
        Tue, 13 Feb 2024 01:00:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrXLjRC3ikr4ferEpmsLtCbYbJ0tiEaLfvRthnmPkWRPjZf2YWMS9qHmyAn2HujsW93A7jnfWCGvfE8I3pEm0txvRGrveBHW276B6iI/JqzkuWvE5M5cuLoYGKCxEH3R8jW2qwsypruPT3VRUgpkAQV/PK8JQcmkL7Q4ywjfJL6mUqZOIkNGFXn+P9FB+Hqsea0COA9K8wAWnJj5APK58dlHsDJS+FoWABXBIBUXoOoHxfacoXt47p79WzNB15bKVn2JFoWGyzfE22RYdGWRQy3ear5OWLl5fWuaObkgl2NUJITj8FqU0pyCfTlOmrugYkLUn7HpYTnVgWNYaBfmXexXu6deoj58zrdkusM/3H4DvCozJqDLII
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b00a3bf7a9edc4sm1090078ejr.15.2024.02.13.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:00:23 -0800 (PST)
Date: Tue, 13 Feb 2024 10:00:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com
Subject: Re: [iwl-next v1 10/15] ice: create port representor for SF
Message-ID: <ZcsvpByD9n9BR-6D@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-11-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213072724.77275-11-michal.swiatkowski@linux.intel.com>

Tue, Feb 13, 2024 at 08:27:19AM CET, michal.swiatkowski@linux.intel.com wrote:
>Store subfunction and VF pointer in port representor structure as an
>union. Add port representor type to distinguish between each of them.
>
>Keep the same flow of port representor creation, but instead of general
>attach function create helpers for VF and subfunction attach function.
>
>Type of port representor can be also known based on VSI type, but it
>is more clean to have it directly saved in port representor structure.
>
>Create port representor when subfunction port is activated.
>
>Add devlink lock for whole VF port representor creationi and destruction.
>It is done to be symmetric with what happens in case of SF port
>representor. SF port representor is always added or removed with devlink
>lock taken. Doing the same with VF port representor simplify logic.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../intel/ice/devlink/ice_devlink_port.c      |   4 +-
> .../intel/ice/devlink/ice_devlink_port.h      |   1 +
> drivers/net/ethernet/intel/ice/ice_eswitch.c  |  82 ++++++++++---
> drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
> drivers/net/ethernet/intel/ice/ice_repr.c     | 110 +++++++++++-------
> drivers/net/ethernet/intel/ice/ice_repr.h     |  21 +++-
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   |  11 ++
> drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> 10 files changed, 184 insertions(+), 77 deletions(-)

Again, please split.

