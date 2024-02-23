Return-Path: <netdev+bounces-74318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37019860E17
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A189B1F21A98
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9795C5F5;
	Fri, 23 Feb 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xNFIFZyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7E18B04
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680991; cv=none; b=CQ9xDOZUXxYA1jqWopGBgoh+KYFXWO/mgDA3liO4xlv+es91JE/4SdSo2jK1KjBfbDuyJZGrMAxt8GBnvdiCaTNZ6ohIjApxglfXdJ1vV9q75CV8dX77AxFD3WIyTdNhgb8IrSZ1GBkYDfpMOTbLTAOEcRWWk4T9Y86U+yI7P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680991; c=relaxed/simple;
	bh=PFchzZvpAgoHyUnjpLFnydPsiu6lM2OMHrampsFXiRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDznT831IRlTtMuPi+oIY5YobUi6TRYzUlMzvie8M8J08Kbh2hg/6aIOH+IdAEnWqrQ78LH1ycNL6VdPIroQOnXXEh44dfHWVxmf1q36ghqxXmqjoA1hb6SXojpbuDcFSrmkXAvCLNYlzVXC2ZA7f8Xnb+Ac/7w19cduKe3UoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xNFIFZyJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d09cf00214so9513161fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708680987; x=1709285787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8zK+OM1/XuJg6fUnsgLvsvr2bwhxswfrHrN5zNfO2Q=;
        b=xNFIFZyJKJ+h+Nvpk1/+k9KZyZa6ti1kBi7TIJkfwqNZJnML5GaRhJCz7X7SONKYO+
         5Q/cIv+ZUOuHD44Zz+nrB28POFaSByrOCCP0p2XzfI9RCibnn+XHNu6u6RPCPOW6JaKT
         6OrCJlkgPA2SfanFuG9YJGJ/EU1D3/Z9EIRWW8Do9A3s877svUtM9a0gZkalB4W1Uhmb
         Epye1wsNOddsa2FlZnwbHv4APiCwEAUM9MEEZ/0+axG0oLkTcnyQxO3j1W8KXzQ6Mnnc
         vUVrjfXUXrXGnKMbJbcYB/IQ4IgXRkBVh9w2AWVu+2feZY0+3CJAHSCwR1lmVX6sGFRz
         kjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680987; x=1709285787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8zK+OM1/XuJg6fUnsgLvsvr2bwhxswfrHrN5zNfO2Q=;
        b=r7xcX2FPIdsyMM8aVWjtFGO598SPn2Z1s4QZWkvAqyXXgIadfKqLc0uzP405c4WZZz
         DDa896g1B3tmInGjYTfNHjrR0aP/c6/+CGOD+qutIoyT4o4GH0D1jXsGm6U/o1r5kXvn
         ui+XWw6iZgev9D81H92Rnnh1QjsKCO3JUYpG5jJFH3sLfQeX8uP/Xnn3CfhugUI5mGcL
         0MPX1z4ajhlJLOsZ5ygywRNdTrZBJ0GRtd2MIgSXi59fX/qYls/YSu/FLhA+x8LwLqvc
         kB92m7hkPImR6MN1Dhe/Qy0boOjItd/QbW1ZU//9rNjchLCSPQtziWgnBqaonXXKHOYj
         tNMA==
X-Forwarded-Encrypted: i=1; AJvYcCXuxXSMBNrIUnHbUrtJK5pDiF5jiGmoPL2YKjcZnL+ZLQZQ7WguriFW0arTMDhgC9OVs12ksK0Xw40HpetN5OT0t5xLIUX6
X-Gm-Message-State: AOJu0YxXCd1xlkhVGEhc3LQ1K3s/VUMMeeXSwY+a/CuuJQqITvORF5ty
	/mPbu2c/ef321i/e9l3cqzYQscr4Fb9q5RJYfe68tVvL7u+e+mKe1DRGGBHUNjM=
X-Google-Smtp-Source: AGHT+IEcWWqywAADMsE00eGfYYvqbkM8cZo9QvfC4B7fvRV+BVu/5IjW5Dg9G55iQLbf6Wx1CAZJQQ==
X-Received: by 2002:a2e:a1cd:0:b0:2d2:3998:adaf with SMTP id c13-20020a2ea1cd000000b002d23998adafmr974056ljm.32.1708680987349;
        Fri, 23 Feb 2024 01:36:27 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033b406bc689sm2118801wrb.75.2024.02.23.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:36:26 -0800 (PST)
Date: Fri, 23 Feb 2024 10:36:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <ZdhnGeYVB00pLIhO@nanopsycho>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>

Fri, Feb 23, 2024 at 02:23:32AM CET, sridhar.samudrala@intel.com wrote:
>
>
>On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
>> On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>> > On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>> > > Greg, we have a feature here where a single device of class net has
>> > > multiple "bus parents". We used to have one attr under class net
>> > > (device) which is a link to the bus parent. Now we either need to add
>> > > more or not bother with the linking of the whole device. Is there any
>> > > precedent / preference for solving this from the device model
>> > > perspective?
>> > 
>> > How, logically, can a netdevice be controlled properly from 2 parent
>> > devices on two different busses?  How is that even possible from a
>> > physical point-of-view?  What exact bus types are involved here?
>> 
>> Two PCIe buses, two endpoints, two networking ports. It's one piece
>
>Isn't it only 1 networking port with multiple PFs?

AFAIK, yes. I have one device in hands like this. One physical port,
2 PCI slots, 2 PFs on PCI bus.


>
>> of silicon, tho, so the "slices" can talk to each other internally.
>> The NVRAM configuration tells both endpoints that the user wants
>> them "bonded", when the PCI drivers probe they "find each other"
>> using some cookie or DSN or whatnot. And once they did, they spawn
>> a single netdev.
>> 
>> > This "shouldn't" be possible as in the end, it's usually a PCI device
>> > handling this all, right?
>> 
>> It's really a special type of bonding of two netdevs. Like you'd bond
>> two ports to get twice the bandwidth. With the twist that the balancing
>> is done on NUMA proximity, rather than traffic hash.
>> 
>> Well, plus, the major twist that it's all done magically "for you"
>> in the vendor driver, and the two "lower" devices are not visible.
>> You only see the resulting bond.
>> 
>> I personally think that the magic hides as many problems as it
>> introduces and we'd be better off creating two separate netdevs.
>> And then a new type of "device bond" on top. Small win that
>> the "new device bond on top" can be shared code across vendors.
>
>Yes. We have been exploring a small extension to bonding driver to enable a
>single numa-aware multi-threaded application to efficiently utilize multiple
>NICs across numa nodes.

Bonding was my immediate response when we discussed this internally for
the first time. But I had to eventually admit it is probably not that
suitable in this case, here's why:
1) there are no 2 physical ports, only one.
2) it is basically a matter of device layout/provisioning that this
   feature should be enabled, not user configuration.
3) other subsystems like RDMA would benefit the same feature, so this
   int not netdev specific in general.


