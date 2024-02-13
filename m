Return-Path: <netdev+bounces-71297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9232852F4B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F61F22194
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9612C689;
	Tue, 13 Feb 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r7i1eckM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F5249F3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823707; cv=none; b=kmYKcMAfSmBk18bpzz3E7qoowvV+AEoJ1V5VgwWR/QBFpbSaS7vByCR/WqoWWmQmq5poZfdjPgiNMB58b7HQuq19MjSCEg40q1U6oE+eLGhToVJmZ/Lf/8Ui+2piwUTSD0c3OR/rmnMCpTNH6Dz6yT6Mbb+VxPXJA7o7PLCfvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823707; c=relaxed/simple;
	bh=W+W+lBKYWBe5Un6RCgzrhk9uR/rMvm10g7KmE30lAuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVomZCa0Zi4IxPoWbXd6S8RvEJbc2+h4gR3zi1KB7MzkQFbGXC3mu1nRkaX63dwzyOM7HTbXqSfRXdxFYA8KseTI3DSJutxkAQxCY4KLvDzcWCetVs8jZIXcJn1x+yLuG3Y2wg9MFoNv4a7ZNoQoQTiuPgDot0SIAsrulOxIsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r7i1eckM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41102f140b4so5447075e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707823703; x=1708428503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0KsMl3OUOHVKyryv15HOu1hfiEpJzNqLTxDU6ueUs8=;
        b=r7i1eckM6Nn5ASR82oV4/KFwQLWHp8D+Okb7Z685q2eTR4W4YYk86xyi9OIbdnFKU8
         K29VxLBYY/QMz7HTlo1YVAHU9hyyQVJ/NCbkcIbB1z8vwEOrnaSPg45LVvIA35TwJtur
         h0zieb0YmDQpc/MgfEMHMawJH8Pp83K9X7oGMZAqwR5UiP+GJfdNoI5q6B0OXlBYN385
         EP7f+rbaButezblFngt3h/MFZoycy/9dQJdBCHDgu2FowRRyttKZR2xxSJoA6Wl0I1zr
         2PXTYzn/UFbkQW18WSFeKZiN0bDlMqa5ebL0CMWTdARiC4R6w3YOB9g3AFIpcgbVeZfo
         +U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823703; x=1708428503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0KsMl3OUOHVKyryv15HOu1hfiEpJzNqLTxDU6ueUs8=;
        b=gpe4R9Qnj8RKJj4AtUlquJe8VtRU73xqpgMRU/p90RIB17CGD+L7nOsNNUc2YSRZ89
         uD31NmJR2qAxeQuHA782CeYZv4JEvBZhGrdx17lA1tvzzuOQ151MFRDqsUJqCtS4VjfR
         ae1UDFYc1JH30twDO11nlIme3+SOWJywoKk/BeZtAXWAjDRHGDhHx75ZJmS7RngnbyYe
         uQg+3UdF0SrwmMvFXbbNeogtXbLpcMQtJTV9i/XkwAQrKG1dPczdjKj5C4gErtD2s5wn
         UzYV4dsKwodor3zyKXougtg2CPuMAjZQmAQZWQ4jsPbJLNdo5/pWfq4IpC6KA83OwMp1
         Iduw==
X-Gm-Message-State: AOJu0Ywz19G5KFQeqfByw3B5rVetoDGxCjvlR3ppDY1la8ft2ooGN86u
	kPfLJ4Yx19Dndb65Zlfles2qGYAkAvCo3R0rKKiOimNah7K1jxDGRCi2pJs6QsQ=
X-Google-Smtp-Source: AGHT+IGOcSpHCRQQoYtjfQGfP5Z1eG7LPtLZ32xdQD3na646J9S2DUW8pa/E3Kq+ZmDyHCtiRSyszA==
X-Received: by 2002:adf:f6c7:0:b0:33b:81fa:ed8 with SMTP id y7-20020adff6c7000000b0033b81fa0ed8mr3380188wrp.0.1707823702900;
        Tue, 13 Feb 2024 03:28:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4x34xtqUTcgCA0jVqo2tsEdax+/5mEZoZbQWb6bjtbUozgvIf7rc5xJFC/FsIaaFr+BmNUp2ulWtZb0KY9qQb/YorukS24M/EU0pguGth7vuLYLskeOQ95FQIqPcCAXwgUpnogj4E10l1qDdFbGpqSGNP2+cJZbdcjEzHBjW+6bA4+DEIch/BRfYNaEHu6ga3jZzBpmrg1k2gR9BoWNuVlqtj5Z3mUGWvHa0dOBpXBi0pKTwMXSrft87deYMvAbHPZegLakVtJSjB/v2myTgpQA7zjLex3k5WK8NP6ceZrAOfRRIHN3ChgQ2IHhXKVmg4asVpVeKCpFw2mhBI0W1MOapqv9ona1roJptjofE++8cijgn9jye4JKEXRTzkmt7r+NvhjAuxxU7Bc7jK+h6o4Oc5
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id c1-20020a056000104100b0033905a60689sm9272579wrx.45.2024.02.13.03.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:28:22 -0800 (PST)
Date: Tue, 13 Feb 2024 12:28:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 06/15] ice: add subfunction aux driver support
Message-ID: <ZctSU2cJHVwPhyhZ@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
 <Zcsu6MCX-XkS8bki@nanopsycho>
 <Zcs5pFtmXzTxWO5s@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcs5pFtmXzTxWO5s@mev-dev>

Tue, Feb 13, 2024 at 10:43:00AM CET, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Feb 13, 2024 at 09:57:12AM +0100, Jiri Pirko wrote:
>> Tue, Feb 13, 2024 at 08:27:15AM CET, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >
>> >Instead of only registering devlink port by the ice driver itself,
>> >let PF driver only register port representor for a given subfunction.
>> >Then, aux driver is supposed to register its own devlink instance and
>> >register virtual devlink port.
>> >
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >---
>> > .../intel/ice/devlink/ice_devlink_port.c      |  52 ++++-
>> > .../intel/ice/devlink/ice_devlink_port.h      |   6 +
>> > drivers/net/ethernet/intel/ice/ice_devlink.c  |  28 ++-
>> > drivers/net/ethernet/intel/ice/ice_devlink.h  |   3 +
>> > drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
>> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 214 ++++++++++++++++--
>> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  21 ++
>> > 7 files changed, 302 insertions(+), 31 deletions(-)
>> 
>> Could you please split this. I see that you can push out 1-3 patches as
>> preparation.
>
>Do you mean 1-3 patchses from this patch, or from whole patchset? I mean,

This patch.

>do you want to split the patchset to two patchsets? (by splitting patch

Yes, 2 patchsets. If convenient 3. Just do one change per patch so it is
reviewable.


>from the patchset I will have more than netdev maximum; 15 I think). 
>
>Thanks,
>Michal

