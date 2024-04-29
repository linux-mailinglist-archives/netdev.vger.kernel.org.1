Return-Path: <netdev+bounces-92104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDB8B5736
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76231F21FD4
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB64DA19;
	Mon, 29 Apr 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pNDvFlRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8531611D
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391750; cv=none; b=eBgm2qzZTCfTEjaKFJGD5D4U/ylkRc6KuB4tsKR8Nx9OgP03pIgHEL4OVNx42+xFgaEXDOerZ/SF9HXhkD0thRrPXiqAdeIVVcvtEX4jBFx4VEDirm+jRD43myNywbZuA1KptcxkurRcdiwpzZtpCz4Q3bbok7j/51lXl3ZUTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391750; c=relaxed/simple;
	bh=FH0OG9THOIsi0MAw/aQ2Fido8RosHPfoiGo6vbo76EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhNAgMKv6QUriqAh8wnfWOK91i5w7vdjMrATbFkarY5FKZmtoYwtr2d9zYra+SfikjGumXhxyj0MOeXgyRbzOJW0Gdb3AogoUyVCITxf6OM4en668ONIBUtt6qBswtwADGntuYcc1nmz94XDBcLaGaAtHzKYEtbXnaKhrTxLxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pNDvFlRQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so2945959a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714391747; x=1714996547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTF8L7As+P2RTQMXeQ1vLyfoKhnmlLupR/xIodvbScg=;
        b=pNDvFlRQLCvmHgpG5Q8YusBcG8jG5brK3GhdXNSzX0d5sD2u6NIHJwgWkwF0megKxr
         fmFIXkMy5YtebqD/r4LSa5R9Hg1yHlP8owq6MihhZx51ifmhaCyow52Y3gmBBsICqjyS
         YPzHL/PuDWRIviUQgCLcWQzUgo5yCzTVTtPjHozXIbSSYiMcrSeaTz1bsKbieMrzpwuS
         THMX52Z61xS8cuHXtvhN5Hzr/MstVa0vh9Hmd5IJ4GXREHqV5B4y3vE+LoXidUUgOQkR
         cHHfUcm7DQY3F1m+K6txvAzbbhwB2eJTDGmkKZKi7Vx51hxqI8NdkDEc/JX2AET7MAc6
         gNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714391747; x=1714996547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTF8L7As+P2RTQMXeQ1vLyfoKhnmlLupR/xIodvbScg=;
        b=jEHrr2Bkx1PIgZYMes62TyhTVx8GirMWC4MKn0k3YjB9mmXXk80hxCb3c9hddUCINH
         1lHTbaWvoLIaUbDsLwa/0kjflMTuy80Nc+nF70jcw8En+h+iDxBMyB3zIrZv/sftpGKY
         xCVDBaZWeQhypDHPT2ASuKoEGEiZ0efFlYVduqxNwFNaD1+ZozK/+MZlT6rivYCP8SgH
         1cygsrwMw66NZntWohI9matWsvKnfGaWY/IaRBOKooKf89HbAybKNa/oRjcl7Qy6JBDS
         nP21yw5OuEB5q3FhI17H+PNT8dZUg7uXOuzJJcqNn9Fsm4Ez+frxH3urZQCrvvneW1x2
         nU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWpfDIGVr/oBe1LBsP3MmqOi3cCG+1xFd3LhcN/cg8sFxHUYGRJO9giI4XDHLNmf7lZWvwSaNwk5Q92zEV36rPs3r2aOKb
X-Gm-Message-State: AOJu0YywvI8geE00yimit3K9+q7htt6jBhiE1sE3HFG2f92cCoQaVNHc
	2EaINIRPm/f5Ykc+7QxdQGnc5ayjkdUiV+qL8b33XQ8ueVVA8F4iVDuxH/KHLjG+plpp/Xfl2eh
	S
X-Google-Smtp-Source: AGHT+IHhwi1H6up0yF9MTnOVyl3efgAzj76SyIMaLjZeX+Z5PwYQDs8O46dlMbYsRwDH+VrbWfGdYw==
X-Received: by 2002:a17:906:ece4:b0:a58:ea99:6709 with SMTP id qt4-20020a170906ece400b00a58ea996709mr3811297ejb.3.1714391746637;
        Mon, 29 Apr 2024 04:55:46 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170907360500b00a58a67afd2fsm5439156ejc.53.2024.04.29.04.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:55:45 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:55:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, kuba@kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Extend auxbus device
 naming
Message-ID: <Zi-KwL3WJrJd3zdR@nanopsycho>
References: <ZiedKc5wE2-3LlaM@nanopsycho>
 <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
 <Zie0NIztebf5Qq1J@nanopsycho>
 <3a634778-9b72-4663-b305-3be18bd8f618@intel.com>
 <ZikgQhVpphnaAOpG@nanopsycho>
 <3877b086-142d-4897-866e-e667ca7091d7@intel.com>
 <ZiuNxivU-haEQ5fC@nanopsycho>
 <39daba1e-5fbe-495e-8398-200434f89230@intel.com>
 <Ziuvjj8h7GzsL9RF@nanopsycho>
 <698dd861-951b-44d9-91b0-5a39a953857c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698dd861-951b-44d9-91b0-5a39a953857c@intel.com>

Sat, Apr 27, 2024 at 12:25:44AM CEST, jacob.e.keller@intel.com wrote:
>
>
>On 4/26/2024 6:43 AM, Jiri Pirko wrote:
>> Fri, Apr 26, 2024 at 02:49:40PM CEST, przemyslaw.kitszel@intel.com wrote:
>>> On 4/26/24 13:19, Jiri Pirko wrote:
>>>> Wed, Apr 24, 2024 at 06:56:37PM CEST, jacob.e.keller@intel.com wrote:
>>>>>
>>>>>
>>>>> On 4/24/2024 8:07 AM, Jiri Pirko wrote:
>>>>>> Wed, Apr 24, 2024 at 12:03:25AM CEST, jacob.e.keller@intel.com wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 4/23/2024 6:14 AM, Jiri Pirko wrote:
>>>>>>>> Tue, Apr 23, 2024 at 01:56:55PM CEST, sergey.temerkhanov@intel.com wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>> Sent: Tuesday, April 23, 2024 1:36 PM
>>>>>>>>>> To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
>>>>>>>>>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
>>>>>>>>>> Przemyslaw <przemyslaw.kitszel@intel.com>
>>>>>>>>>> Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
>>>>>>>>>>
>>>>>>>>>> Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com
>>>>>>>>>> wrote:
>>>>>>>>>>> Include segment/domain number in the device name to distinguish
>>>>>>>>>> between
>>>>>>>>>>> PCI devices located on different root complexes in multi-segment
>>>>>>>>>>> configurations. Naming is changed from ptp_<bus>_<slot>_clk<clock>  to
>>>>>>>>>>> ptp_<domain>_<bus>_<slot>_clk<clock>
>>>>>>>>>>
>>>>>>>>>> I don't understand why you need to encode pci properties of a parent device
>>>>>>>>>> into the auxiliary bus name. Could you please explain the motivation? Why
>>>>>>>>>> you need a bus instance per PF?
>>>>>>>>>>
>>>>>>>>>> The rest of the auxbus registrators don't do this. Could you please align? Just
>>>>>>>>>> have one bus for ice driver and that's it.
>>>>>>>>>
>>>>>>>>> This patch adds support for multi-segment PCIe configurations.
>>>>>>>>> An auxdev is created for each adapter, which has a clock, in the system. There can be
>>>>>>>>
>>>>>>>> You are trying to change auxiliary bus name.
>>>>>>>>
>>>>>>>>
>>>>>>>>> more than one adapter present, so there exists a possibility of device naming conflict.
>>>>>>>>> To avoid it, auxdevs are named according to the PCI geographical addresses of the adapters.
>>>>>>>>
>>>>>>>> Why? It's the auxdev, the name should not contain anything related to
>>>>>>>> PCI, no reason for it. I asked for motivation, you didn't provide any.
>>>>>>>>
>>>>>>>
>>>>>>> We aren't creating one auxbus per PF. We're creating one auxbus per
>>>>>>> *clock*. The device has multiple clocks in some configurations.
>>>>>>
>>>>>> Does not matter. Why you need separate bus for whatever-instance? Why
>>>>>> can't you just have one ice-ptp bus and put devices on it?
>>>>>>
>>>>>>
>>>>>
>>>>> Because we only want ports on card A to be connected to the card owner
>>>>> on card A. We were using auxiliary bus to manage this. If we use a
>>>>
>>>> You do that by naming auxiliary bus according to the PCI device
>>>> created it, which feels obviously wrong.
>>>>
>>>>
>>>>> single bus for ice-ptp, then we still have to implement separation
>>>>> between each set of devices on a single card, which doesn't solve the
>>>>> problems we had, and at least with the current code using auxiliary bus
>>>>> doesn't buy us much if it doesn't solve that problem.
>>>>
>>>> I don't think that auxiliary bus is the answer for your problem. Please
>>>> don't abuse it.
>>>>
>>>>>
>>>>>>>
>>>>>>> We need to connect each PF to the same clock controller, because there
>>>>>>> is only one clock owner for the device in a multi-port card.
>>>>>>
>>>>>> Connect how? But putting a PF-device on a per-clock bus? That sounds
>>>>>> quite odd. How did you figure out this usage of auxiliary bus?
>>>>>>
>>>>>>
>>>>>
>>>>> Yea, its a multi-function board but the functions aren't fully
>>>>> independent. Each port has its own PF, but multiple ports can be tied to
>>>>> the same clock. We have similar problems with a variety of HW aspects.
>>>>> I've been told that the design is simpler for other operating systems,
>>>>> (something about the way the subsystems work so that they expect ports
>>>>> to be tied to functions). But its definitely frustrating from Linux
>>>>> perspective where a single driver instance for the device would be a lot
>>>>> easier to manage.
>>>>
>>>> You can always do it by internal accounting in ice, merge multiple PF
>>>> pci devices into one internal instance. Or checkout
>>>> drivers/base/component.c, perhaps it could be extended for your usecase.
>>>>
>>>>
>>>>>
>>>>>>>
>>>>>>>> Again, could you please avoid creating auxiliary bus per-PF and just
>>>>>>>> have one auxiliary but per-ice-driver?
>>>>>>>>
>>>>>>>
>>>>>>> We can't have one per-ice driver, because we don't want to connect ports
>>>>>> >from a different device to the same clock. If you have two ice devices
>>>>>>> plugged in, the ports on each device are separate from each other.
>>>>>>>
>>>>>>> The goal here is to connect the clock ports to the clock owner.
>>>>>>>
>>>>>>> Worse, as described here, we do have some devices which combine multiple
>>>>>>> adapters together and tie their clocks together via HW signaling. In
>>>>>>> those cases the clocks *do* need to communicate across the device, but
>>>>>>> only to other ports on the same physical device, not to ports on a
>>>>>>> different device.
>>>>>>>
>>>>>>> Perhaps auxbus is the wrong approach here? but how else can we connect
>>>>>>
>>>>>> Yeah, feels quite wrong.
>>>>>>
>>>>>>
>>>>>>> these ports without over-connecting to other ports? We could write
>>>>>>> bespoke code which finds these devices, but that felt like it was risky
>>>>>>> and convoluted.
>>>>>>
>>>>>> Sounds you need something you have for DPLL subsystem. Feels to me that
>>>>>> your hw design is quite disconnected from the Linux device model :/
>>>>>>
>>>>>
>>>>> I'm not 100% sure how DPLL handles this. I'll have to investigate.
>>>>
>>>> DPLL leaves the merging on DPLL level. The ice driver just register
>>>> entities multiple times. It is specifically designed to fit ice needs.
>>>>
>>>>
>>>>>
>>>>> One thing I've considered a lot in the past (such as back when I was
>>>>> working on devlink flash update) was to somehow have a sort of extra
>>>>> layer where we could register with PCI subsystem some sort of "whole
>>>>> device" driver, that would get registered first and could connect to the
>>>>> rest of the function driver instances as they load. But this seems like
>>>>> it would need a lot of work in the PCI layer, and apparently hasn't been
>>>>> an issue for other devices? though ice is far from unique at least for
>>>>> Intel NICs. Its just that the devices got significantly more complex and
>>>>> functions more interdependent with this generation, and the issues with
>>>>> global bits were solved in other ways: often via hiding them with
>>>>> firmware >:(
>>>>
>>>> I think that others could benefit from such "merged device" as well. I
>>>> think it is about the time to introduce it.
>>>
>>> so far I see that we want to merge based on different bits, but let's
>>> see what will come from exploratory work that Sergey is doing right now.
>>>
>>> and anything that is not a device/driver feels much more lightweight to
>>> operate with (think &ice_adapter, but extended with more fields).
>>> Could you elaborate more on what you have in mind? (Or what you could
>>> imagine reusing).
>> 
>> Nothing concrete really. See below.
>> 
>>>
>>> offtop:
>>> It will be a good hook to put resources that are shared across ports
>>> under it in devlink resources, so making this "merged device" an entity
>>> would enable higher layer over what we have with devlink xxx $pf.
>> 
>> Yes. That would be great. I think we need a "device" in a sense of
>> struct device instance. Then you can properly model the relationships in
>> sysfs, you can have devlink for that, etc.
>> 
>> drivers/base/component.c does merging of multiple devices, but it does
>> not create a "merged device", this is missing there. So we have 2
>> options:
>> 
>> 1) extend drivers/base/component.c to allow to create a merged device
>>    entity
>> 2) implement merged device infrastructure separatelly.
>> 
>> IDK. I believe we need to rope more people in.
>> 
>> 
>
>drivers/base/component.c looks pretty close to what we want. Each PF
>would register as a component, and then a driver would register as the
>component master. It does lack a struct device, so might be challenging
>to use with devlink unless we just opted to pick a device from the
>components as the main device?

If I read the code correctly, the master component has to be a device as
well. This is the missing piece I believe.


>
>extending components to have a device could be interesting, though
>perhaps its not exactly the best place. It seems like components are
>about combining a lot of small devices that ultimately combine into one
>functionality at a logical level.
>
>That is pretty close to what we want here: one entity to control global
>portions of an otherwise multi-function card.
>
>Extending it to include a struct device could work but I'm not 100% sure
>how that fits into the component system.

Who knows? we need to rope them into this discussion...


>
>We could try extending PCI subsystem to do something similar to
>components which is vaguely what I described a couple replies ago.

Well, feels to me this is more generic problem than PCI. One level
above.


>
>ice_adapter is basically doing this but more bespoke and custom, and
>still lacks the extra struct device.

Correct.


