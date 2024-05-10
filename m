Return-Path: <netdev+bounces-95404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9288C22CA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7E21F212FE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625415ECF1;
	Fri, 10 May 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uZEEjAGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C388168AFC
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339274; cv=none; b=KPPZz0qfo7qP8pefZUh6ndmXpXQoUqtUnv/3BgjKrwZBSQ/lU4tGIavmIsrGywU/BXhcYD9ZGbYCHacjcIT/5ybKN3TgtmtIWDTJEUvFaD9eYth22Cd4Dn2zetnVAN8UvESpyafDeJF8/3BFsJBq73HBF1UGjwNsezIXMM9ljrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339274; c=relaxed/simple;
	bh=859+QiXU/TnqrPU0DB9n6V6TYTzMlRUMHngv/RVC8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCj2v1E0Wtj57hk8fusfVrSmplZEPm2S93YszbPzARM78hEZrrlENjBApYuxxHnlAak+Uz1MKTWAr0OG67RI+HMvkqQWc2o5D4vSQwmrpbjy7eiJQli1JlgZBPUYEiKIj/ixV1RFLVqlUTC3zgRNwVSFi/E2QO53a3o5FE0D4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uZEEjAGD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e30c625178so22684791fa.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715339270; x=1715944070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOzOAqmI9nIWypFH/CIb7APO0wwyBNqPyzkSkyjLNdQ=;
        b=uZEEjAGDF49Brnuk/HQDG+wVxmKiakaflNabzoXLSxWk4mMqFaaaMQs0OnL5saqyRK
         hYIkmeC3vr8CxC617Ce/u/sMA/sFAtsKqeYu8sygyIRfjkDjqm7mYo47aDxZonnHIRUd
         ZfzRmEGbAGQzsl1KGX6stBHfiwZQArH/X5VWNvTccLZhyPvPIZrHFgaLSF4Kg60/ZSmT
         cBR6L8sFGAiF6P3Bo7hQr5m4/Ml1TRuvVZS8wYyQOMzud5KRlRkYa5ufFYXPyulkCgiB
         EoOrWd8Lhoh1IBzZZhoSlC6H8Z3hPvFcIDxprS42wXmRXneuKZHk7fWgwdHXKVfl8+Gh
         nldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339270; x=1715944070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOzOAqmI9nIWypFH/CIb7APO0wwyBNqPyzkSkyjLNdQ=;
        b=aGzEwpX1lrbkYk+NnlcRDgALFhOz4obaq6zRlxQUbdVgu1te63fyTmIXYcISzOoJ0t
         zdiP/N9u43EwjxhOQjuo+nENOL4bnUh7NRkNbYKDnf7CND+ieIkN/+gdCkBJ04pYQ4A+
         y+fwWMT3s8usgttXLmp/5Uxqv0Zv+yFi8fA3yPsiWBZkWhhdQSGlV9Dz3Drc6B/yXehR
         AdZl2UEBl0+1K/fL7F7tSlHAkoXeFYVFyY0+VdEx4N4o1rXtFtD5LZEzgvWR3ajCFD9j
         rCCjHHksnGONqfmF+jIMkVhpSjq8caDj19Hm1N3h8HwxeKo2V/uJH8PR1fskdFmPx9/W
         F2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ltmriiy1fqQFFDP2DVEdxCTgPN8H7VRzsGbi8CPwdGzstXVhWs8ceSgrEEdVkxxf08z3cDjX5cN0vZLxY53Li71m4aOK
X-Gm-Message-State: AOJu0Yza6xCFPOUQbYa79D6i4+MYZ2oSWZxzyP+JMDCyN396LJPHQDpD
	04Ehy45MWJzGjxrzoPGEhT8/70y2IIDggQpze5/LwEvGAVJoFC8dh13GgCbYxOU=
X-Google-Smtp-Source: AGHT+IGW5QBg7jd7ZGdFB8kWjrOudgTh1Lj0FwS1SZreq7UTrqwgF47iDm7dS4XOHKLf8AuxaLt5AA==
X-Received: by 2002:a2e:9045:0:b0:2e3:38e0:54c7 with SMTP id 38308e7fff4ca-2e5204b2f26mr13611271fa.38.1715339269900;
        Fri, 10 May 2024 04:07:49 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm80088015e9.9.2024.05.10.04.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:07:47 -0700 (PDT)
Date: Fri, 10 May 2024 13:07:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 08/14] ice: create port representor for SF
Message-ID: <Zj4AAFwZudmyOWTm@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-9-michal.swiatkowski@linux.intel.com>
 <ZjywddcaIae0W_w3@nanopsycho.orion>
 <Zj3NQw1BxqtOS9VG@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3NQw1BxqtOS9VG@mev-dev>

Fri, May 10, 2024 at 09:31:15AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, May 09, 2024 at 01:16:05PM +0200, Jiri Pirko wrote:
>> Tue, May 07, 2024 at 01:45:09PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >Store subfunction and VF pointer in port representor structure as an
>> >union. Add port representor type to distinguish between each of them.
>> >
>> >Keep the same flow of port representor creation, but instead of general
>> >attach function create helpers for VF and subfunction attach function.
>> >
>> >Type of port representor can be also known based on VSI type, but it
>> >is more clean to have it directly saved in port representor structure.
>> >
>> >Create port representor when subfunction port is created.
>> >
>> >Add devlink lock for whole VF port representor creation and destruction.
>> >It is done to be symmetric with what happens in case of SF port
>> >representor. SF port representor is always added or removed with devlink
>> >lock taken. Doing the same with VF port representor simplify logic.
>> >
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >---
>> > .../ethernet/intel/ice/devlink/devlink_port.c |   6 +-
>> > .../ethernet/intel/ice/devlink/devlink_port.h |   1 +
>> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 +++++++++---
>> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
>> > drivers/net/ethernet/intel/ice/ice_repr.c     | 124 +++++++++++-------
>> > drivers/net/ethernet/intel/ice/ice_repr.h     |  21 ++-
>> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
>> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
>> > 8 files changed, 187 insertions(+), 80 deletions(-)
>> 
>> This calls for a split to at least 2 patches. One patch to prepare and
>> one to add the SF support?
>
>Is 187 insertions and 80 deletions too many for one patch? Or the
>problem is with number of files changed?

The patch is hard to follow, that's the problem.


>
>I don't see what here can be moved to preparation part as most changes
>depends on each other. Do you want me to have one patch with unused
>functions that are adding/removing SF repr and another with calling
>them?
>
>Thanks,
>Michal

