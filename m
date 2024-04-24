Return-Path: <netdev+bounces-90994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCD8B0D9F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BE828C962
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC015FCEB;
	Wed, 24 Apr 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0vuskX0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB115FA97
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971278; cv=none; b=qXe47fWJVr2F42HUlP8hqVXsRCBOgr7MPRq6zuCLnTGg8ykfU+6yuP6s5TXq2kvTJGwvnjGMVwXt3wCctbzofwyWz0KRwdr3CS9nk8MNOXNwD35gYNrZRYS8sXOACWMh4ge7Kc++CKvfxCFTgd39bb7VH5dOk0sIHiUzf5fqH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971278; c=relaxed/simple;
	bh=nXw6DmlouvbxAaiLwO+3Ardr0hSqQF1zm3M52kxB5U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPkJyp6WHQXT5N64PaPBZYEYiJaccjgOtw2wYRhlpqQbeNFYIN+2e4g8jchtUxkNEDKn7z/fIxtgR64mhgsllnT50rm8ofw1qN+TVdvBJIQ28x1RADi1nnaFbJyAnhuSNyn5M6s/r4/G4V46EsDSr6dl3fKmAUwWZgqSvEJWJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0vuskX0B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b21ed19f5so2704795e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713971274; x=1714576074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efy+in7jvEoxbRkKx9/WPyXgfp6UU46NpUHk3DHNugI=;
        b=0vuskX0BHZvPMm+VRi2XuCptkivaKCTwWgXAvB2j5gy0Y09BF6XNBvVCQhgRTNi91+
         ccbRhAee4eNiglDbNmeozRlEq2CmQKEdmiqI3VRkvK0HzZPAisA7QXJyq0RlfZaOre6F
         rPfMWq03P1Z5BsQqNsyt5DAlF9mh1CM8fngbN6MlcCJqVvaKTBpMdothamy+8SxhGd2Y
         MRoymWuDZQiN7+yEnQhzdaQA52Stxyb+iW958ow13Ns4Sfvq4fS9a7k6fCJXiwqsdbYp
         m0L/U22xdRy1qoSrOWwR1KYJ2iltP5s8Wjr/mBDdNvlJ8jcRTyqbavnw2QL/DBgoAGFw
         lgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971274; x=1714576074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efy+in7jvEoxbRkKx9/WPyXgfp6UU46NpUHk3DHNugI=;
        b=VJ7lFrYRnw8jJOahqiWl8CifBzBDmiIcIVDLGRDDLJA2EdKUFcagbWtTkr5rQNV+XS
         +UiXyon+UK27ahKJbE4i/bc7IFrPyUD422wkh8XEXx7Cfqtvm+ce8taOng5gOs5zP9I9
         QEZu8s7UtjUyv1l5NcL51C9h1mTRq6ezYnIlRTvbHWR5OHkwHbSQ8wVz01YiEe5IY/9c
         ACyEytIZHxrm7LFXXvYG46+imCnvG7PRMFGZhTYrx17VMrXPUgo3q5jLD5TEO7Bct+nW
         iTxBJLKMjR0NLNUbAwxmBdhTBfxp9FtjVco8c4QBK/4AjRbYdVKbKXxVKnr8GaNTgSJh
         KhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQt+XY6VcDNOYSZcMGHIH7slTL5HrUwygV1sONqewmrxmfjYgVSZEkLL3JXy5Y3Lwp7UQC5U1a0kmAg5W9QipY5xcYHFwc
X-Gm-Message-State: AOJu0Yyo3xbM4xGrDFP8pG+cV9HqosRWfW+5/Tll29bBghCjbzVKIJIX
	GsOqzQlO4J3z5PGBkrXz9FSkZoCBRgS6SjFLXJ9h9VXpIDBjx5PZBYre8EDJceg=
X-Google-Smtp-Source: AGHT+IGqrklJ9g4Awu4ez1S1kGv2SH7T4yfuD4xGz0fef4uCFimKuic39gF7ENhZF2DUGUiC6ihEBA==
X-Received: by 2002:a05:600c:3585:b0:418:dd73:b0a1 with SMTP id p5-20020a05600c358500b00418dd73b0a1mr2058891wmq.39.1713971273606;
        Wed, 24 Apr 2024 08:07:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d684c000000b0034aa1e534c2sm11975739wrw.96.2024.04.24.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:53 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:07:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Extend auxbus device
 naming
Message-ID: <ZikgQhVpphnaAOpG@nanopsycho>
References: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
 <ZiedKc5wE2-3LlaM@nanopsycho>
 <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
 <Zie0NIztebf5Qq1J@nanopsycho>
 <3a634778-9b72-4663-b305-3be18bd8f618@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a634778-9b72-4663-b305-3be18bd8f618@intel.com>

Wed, Apr 24, 2024 at 12:03:25AM CEST, jacob.e.keller@intel.com wrote:
>
>
>On 4/23/2024 6:14 AM, Jiri Pirko wrote:
>> Tue, Apr 23, 2024 at 01:56:55PM CEST, sergey.temerkhanov@intel.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>> Sent: Tuesday, April 23, 2024 1:36 PM
>>>> To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
>>>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
>>>> Przemyslaw <przemyslaw.kitszel@intel.com>
>>>> Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
>>>>
>>>> Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com
>>>> wrote:
>>>>> Include segment/domain number in the device name to distinguish
>>>> between
>>>>> PCI devices located on different root complexes in multi-segment
>>>>> configurations. Naming is changed from ptp_<bus>_<slot>_clk<clock>  to
>>>>> ptp_<domain>_<bus>_<slot>_clk<clock>
>>>>
>>>> I don't understand why you need to encode pci properties of a parent device
>>>> into the auxiliary bus name. Could you please explain the motivation? Why
>>>> you need a bus instance per PF?
>>>>
>>>> The rest of the auxbus registrators don't do this. Could you please align? Just
>>>> have one bus for ice driver and that's it.
>>>
>>> This patch adds support for multi-segment PCIe configurations.
>>> An auxdev is created for each adapter, which has a clock, in the system. There can be
>> 
>> You are trying to change auxiliary bus name.
>> 
>> 
>>> more than one adapter present, so there exists a possibility of device naming conflict.
>>> To avoid it, auxdevs are named according to the PCI geographical addresses of the adapters.
>> 
>> Why? It's the auxdev, the name should not contain anything related to
>> PCI, no reason for it. I asked for motivation, you didn't provide any.
>> 
>
>We aren't creating one auxbus per PF. We're creating one auxbus per
>*clock*. The device has multiple clocks in some configurations.

Does not matter. Why you need separate bus for whatever-instance? Why
can't you just have one ice-ptp bus and put devices on it?


>
>We need to connect each PF to the same clock controller, because there
>is only one clock owner for the device in a multi-port card.

Connect how? But putting a PF-device on a per-clock bus? That sounds
quite odd. How did you figure out this usage of auxiliary bus?


>
>> Again, could you please avoid creating auxiliary bus per-PF and just
>> have one auxiliary but per-ice-driver?
>> 
>
>We can't have one per-ice driver, because we don't want to connect ports
>from a different device to the same clock. If you have two ice devices
>plugged in, the ports on each device are separate from each other.
>
>The goal here is to connect the clock ports to the clock owner.
>
>Worse, as described here, we do have some devices which combine multiple
>adapters together and tie their clocks together via HW signaling. In
>those cases the clocks *do* need to communicate across the device, but
>only to other ports on the same physical device, not to ports on a
>different device.
>
>Perhaps auxbus is the wrong approach here? but how else can we connect

Yeah, feels quite wrong.


>these ports without over-connecting to other ports? We could write
>bespoke code which finds these devices, but that felt like it was risky
>and convoluted.

Sounds you need something you have for DPLL subsystem. Feels to me that
your hw design is quite disconnected from the Linux device model :/


>
>Perhaps it would be ideal if something in the PCI layer could connect
>these together? I don't know how that would be implemented though..
>
>The fundamental problem is that we have a multi-function device with
>some shared functionality which we need to manage across function. In
>this case it is the clock should only have one entity, while the ports
>connected to it are controlled independently by PF. We tried a variety
>of ways to solve this in the past, mostly with hacky solutions.
>
>We need an entity which can find all the ports connected to a single
>clock, and the port needs to be able to get back to its clock. If we
>used a single auxdriver for this, that driver would have to maintain
>some hash tables or connections in order to locate which ports belonged
>to the clock. It would also need to figure out which port was the
>"owner" so that it could send owner-based requests through that port,
>since it would not inherently have access to the clock hardware since
>its a global entity and not tied to a port.
>
>In the current model, the driver can go back to the PF that spawned it
>to manage the clock, and uses the aux devices as a mechanism to connect
>to each port for purposes such as initializing the PHYs, and caching the
>PTP hardware time for timestamp extension.
>
>Maybe you disagree with this use of auxbus? Do you have any suggestions
>for a separate model?
>
>We could make use of ice_adapter, though we'd need some logic to manage
>devices which have multiple clocks, as well as devices like the one
>Sergey is working on which tie multiple adapters together.

Perhaps that is an answer. Maybe we can make DPLL much more simple after
that :)

