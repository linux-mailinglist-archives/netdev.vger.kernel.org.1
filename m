Return-Path: <netdev+bounces-72998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B885A9AB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6DF1C236E2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E0541C84;
	Mon, 19 Feb 2024 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2yCuJf4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B43F8DA
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362921; cv=none; b=EwASjFBQBBFcQTteqSDoObbWYzXMGfkX5JQtz2soxc5HE1YjkttfqlEV++g1xj7jfIVfPar/6fHqhalULw817StBfTmC3q22bZb+7oIwrOOQzSzn29eHXhj1I9rw5/lD7ucf5iOZFs8nJ8gZOv3hiwOuGqR+vekLAaDrjtpCpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362921; c=relaxed/simple;
	bh=TXbmp6HJ7zcWc8R4bOuacZFxoKfqsIaHGvCJrA0QY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9afXVUfNQi5uaqlN3j5u3XolRzPDfNGqLYZo/y6U2M3JoL5s4P1Rv9TBjJlH18fCXwJNE/Nj5w61IYVM+Zf9SKQT4XCJ5is/pDmcFpgIKO/IbA7DIJnKbmKymNCiRrUaTqyifrkeUpS8e3gITzm41319N8vNxdzraOBlq097XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2yCuJf4J; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso792105566b.0
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708362917; x=1708967717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gV3wjQ4zA6Qt8y8Dc+hWx/Hk0gCmsgyAQmmxpl97FQA=;
        b=2yCuJf4JgcgZLdxIKIrORI31Qb5IauX//01bmqW7wlBWc0AE7J+uHAF7O9w6bIHdaP
         hRvw79gHNl8qfnZ8mIIA5eXQerxlbDCNiaB/1T3XH3WLnli65GSShUa222R0VoaoE/Nq
         ipi66s5/ObvN1PS76MK0JqMZNr1GzsOqjxNzj6nAM74GLycdiXrmt/H2wVlPT19jWBt0
         VOCV+qRf6ldom5FqHxn3hvZ5I2fGzmo822J3Wwl/vWweNDkulPN3hpqSKvOQdUDg0Pkk
         5LBT2qkh0zePyeVX9mBFV9PG2aAw9uPmkElYw1nkEtBMNg2cAHga6Bp/m7UUbsytu5FY
         1Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708362917; x=1708967717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV3wjQ4zA6Qt8y8Dc+hWx/Hk0gCmsgyAQmmxpl97FQA=;
        b=mJfsyUOU2uhfJM7Wd0uJOpWBCShPXgBEuvkk7IixI4WlIfQhI7lv0ZS+tWdmeUc+VW
         YIy6Cr5lei3JuhPK36AINmvkWq+O3ML//Umj38x09+L0JpzXkpcXb/j1oB0VOeevKzqT
         ks+XaoH/wNY+BW/MrBoe3bfi8BmWMdsb+4KLf946j45rHCd60j5H2GmGlzcuAVWVe/PG
         woJT3tZmOZlJapwnR6kVybDzO7AzgZhs7jpsLPao8YgVgBVgeW/OSib1Zn3m4h3zH2Fr
         qXOoNF6jXgB7Xr9vaqE+WFlnEkBXyQdKf+rIkEBA2ZrPG7vazmvQ3zLnoYymFUg0a/OH
         x2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWfdAoB1iPd01xbDS8j6Av1bjg5rf09OoH1llaoocqWfdFDeCxa8leXFq1czhYtxwMfIULgAQK2QY4YMTQpzaMybajnYHxe
X-Gm-Message-State: AOJu0YyezG0d9+By5OauW3ezoCyrBMh0TOiQDLGKoZ61m6iu1MZ+WbQv
	K9y/9+ie+vuEC7E8ohhA4mjz0U/rp+eLq/jnAgTfxnC+CGjiEN2SZFcSJO+OB5Y=
X-Google-Smtp-Source: AGHT+IF4rMbaI1FXxyl0+RFHp2+SjnFsMCU98DaaR35GvyDbT0D46kHdni2ArzHTlvliaFYchHpsng==
X-Received: by 2002:a17:906:b84f:b0:a3e:961e:722c with SMTP id ga15-20020a170906b84f00b00a3e961e722cmr2567019ejb.1.1708362917172;
        Mon, 19 Feb 2024 09:15:17 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id vg8-20020a170907d30800b00a3d2fe84ff9sm3141033ejc.36.2024.02.19.09.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:15:16 -0800 (PST)
Date: Mon, 19 Feb 2024 18:15:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <ZdOMoX4gdQ18fRbr@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho>
 <48675853-2971-42a1-9596-73d1c4517085@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48675853-2971-42a1-9596-73d1c4517085@intel.com>

Mon, Feb 19, 2024 at 02:33:54PM CET, przemyslaw.kitszel@intel.com wrote:
>On 2/19/24 13:37, Jiri Pirko wrote:
>> Mon, Feb 19, 2024 at 11:05:57AM CET, mateusz.polchlopek@intel.com wrote:
>> > From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>> > 
>> > It was observed that Tx performance was inconsistent across all queues
>> > and/or VSIs and that it was directly connected to existing 9-layer
>> > topology of the Tx scheduler.
>> > 
>> > Introduce new private devlink param - tx_scheduling_layers. This parameter
>> > gives user flexibility to choose the 5-layer transmit scheduler topology
>> > which helps to smooth out the transmit performance.
>> > 
>> > Allowed parameter values are 5 and 9.
>> > 
>> > Example usage:
>> > 
>> > Show:
>> > devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
>> > pci/0000:4b:00.0:
>> >   name tx_scheduling_layers type driver-specific
>> >     values:
>> >       cmode permanent value 9
>> > 
>> > Set:
>> > devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
>> > cmode permanent
>> 
>> This is kind of proprietary param similar to number of which were shot
>
>not sure if this is the same kind of param, but for sure proprietary one
>
>> down for mlx5 in past. Jakub?
>
>I'm not that familiar with the history/ies around mlx5, but this case is
>somewhat different, at least for me:
>we have a performance fix for the tree inside the FW/HW, while you
>(IIRC) were about to introduce some nice and general abstraction layer,
>which could be used by other HW vendors too, but instead it was mlx-only

Nope. Same thing. Vendor/device specific FW/HW knob. Nothing to
abstract.


>
>> 
>> Also, given this is apparently nvconfig configuration, there could be
>> probably more suitable to use some provisioning tool.
>
>TBH, we will want to add some other NVM related params, but that does
>not justify yet another tool to configure PF. (And then there would be
>a big debate if FW update should be moved there too for consistency).
>
>> This is related to the mlx5 misc driver.
>> 
>> Until be figure out the plan, this has my nack:
>> 
>> NAcked-by: Jiri Pirko <jiri@nvidia.com>
>
>IMO this is an easy case, but would like to hear from netdev maintainers
>
>

