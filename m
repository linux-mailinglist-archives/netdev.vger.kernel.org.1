Return-Path: <netdev+bounces-121325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF895CBAF
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D02AB20D94
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B6183CD0;
	Fri, 23 Aug 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WuSUWyLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51E61FFC
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413823; cv=none; b=FdBh5sKEKPb4cPlC2rN7la3QbzkGW7llPG+rh+GCTFCr+LLAHABet8MaiZJx7cal7faJ6sey5lrV5wjm7DSXUEj7q0rEhJXVG68XNZgeovxBrMyoJQ7X2pn+Q07scZRB7GNu7AtjEmw23gS4PkWW3Nt7Jkw31HdSgnRWONQAlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413823; c=relaxed/simple;
	bh=R7047wckOLjnQ4vqZUDBBKyUA37U7NNV5RGnlOC0Uxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS65CxWFJWcww/tXGmIlO9WmCuSH5PxB72bcGGuQuSn6FOPE32TF2JsZ2UmmPiz91DdK0RgicIYyS245ZEhlcJ6MdO0XbjotZZkn6B0UbC5GIp6+fQRRDN+ZsV16ZqlvBnhetlK8zBfNiC48EdAKdMDBEyRYsNlMHmBq/nahqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WuSUWyLh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a868b8bb0feso231894866b.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724413820; x=1725018620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVV41zM6FBweqUyGSWldISlBGUW0VzBR2nzics3/mJ4=;
        b=WuSUWyLhuUAS5wybaN65FMfr8ocmRw0iWVfSGbNIBkMzGjSToeUMNgYklxtoqHJCZc
         ZWiXyOHm7zlo5Bw0J9A1PhWa0pJ/cPeN5C3HtrbU0s1alWy7vM1OTcc8O5LeXtF8Qp12
         9f+ngoiAZgd/vaY1IbwNvOWnHENBSImGrydo04+kVGfdCJ8U7cdptHYBy4uTYksx16cU
         7ieJqLrhr0dI+sLd+PveYU/cVRLF/TKSs6Vbd+FbXcNhVX+zq38zE1h4JX1CHHjIsJdD
         gu0lWNIfQ3FOHVj+PYSPYPsJKWdEaqzOQcjoyFKGu2v1z/SPEDeBH/n5fX9xUq31rXFz
         ok6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724413820; x=1725018620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVV41zM6FBweqUyGSWldISlBGUW0VzBR2nzics3/mJ4=;
        b=j/uoQk2tPa0eQwiAK/Yy9MX5mEgDFgaPScNbNLXbjRlZamSlmZA+j6odSDO0SkrV1y
         3BUevPuU9+uHh9ohvAqbDMHoxMKDeJ52+dKGuDAgnSYJ3NbqAHRNjj5nRqTB8p9JIrCK
         4mUgBWmK3YythtCOWN9WaNdLnedgDYsLXlqlv3vIZQvDFQesIqoxS+WyMG69IaQ33ZXO
         9Yyet/aYYstwTRehep1HzvYHTa7guxABqTMp5xMk7PYfReEI8qt7bGj3Iv6zHHeXBO+x
         S8JM3G+YTBoOd+t8QI/ifxSPiEasXZwS7hDHRrrORgTD9EktEcXVGngL4vzj8eJQO5hD
         Qjbg==
X-Forwarded-Encrypted: i=1; AJvYcCUrC0QfIzKziGctCDAt8XyvrRpqQ+/mkpGjSGuw8R2t6xCfaG3koLhTwbM00CQKFjHO60cfKdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzet/TtM4TL+BdUdIIosGxmR+dkAJFNaMwDo1uCevOyHkL6VfSl
	PUYDjkkn5fDN6Dp+0hQ7qKdlQtie29iBigWFrcMv4K5V1JroFLjwTaZv7nnEqh8=
X-Google-Smtp-Source: AGHT+IE9/n1i/e+iaIgO7fAn/0lwDarD3dA7RsaJ2gwhHTUH6GxAVPD4wRNNrxo1sSTk3NkYm/GbIQ==
X-Received: by 2002:a17:906:c105:b0:a77:cbe5:413f with SMTP id a640c23a62f3a-a86a5168f11mr162710066b.4.1724413819419;
        Fri, 23 Aug 2024 04:50:19 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f639dsm247637566b.207.2024.08.23.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:50:18 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:50:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <Zsh3ecwUICabLyHV@nanopsycho.orion>
References: <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion>
 <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
 <20240822155608.3034af6c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822155608.3034af6c@kernel.org>

Fri, Aug 23, 2024 at 12:56:08AM CEST, kuba@kernel.org wrote:
>On Thu, 22 Aug 2024 22:30:35 +0200 Paolo Abeni wrote:
>> >> I'm not saying this is deal breaker for me. I just think that if the api
>> >> is designed to be independent of the object shaper is bound to
>> >> (netdev/devlink_port/etc), it would be much much easier to extend in the
>> >> future. If you do everything netdev-centric from start, I'm sure no
>> >> shaper consolidation will ever happen. And that I thought was one of the
>> >> goals.
>> >>
>> >> Perhaps Jakub has opinion.  
>> > 
>> > I think you and I are on the same page :) Other than the "reference
>> > object" (netdev / devlink port) the driver facing API should be
>> > identical. Making it possible for the same driver code to handle
>> > translating the parameters into HW config / FW requests, whether
>> > they shape at the device (devlink) or port (netdev) level.
>> > 
>> > Shaper NL for netdevs is separate from internal representation and
>> > driver API in my mind. My initial ask was to create the internal
>> > representation first, make sure it can express devlink and handful of
>> > exiting netdev APIs, and only once that's merged worry about exposing
>> > it via a new NL.
>> > 
>> > I'm not opposed to showing devlink shapers in netdev NL (RO as you say)
>> > but talking about it now strikes me as cart before the horse.  
>> 
>> FTR, I don't see both of you on the same page ?!?
>> 
>> I read the above as Jiri's preference is a single ndo set to control

"Ndo" stands for netdev op and they are all tightly coupled with
netdevices. So, "single ndo set to control both devlink and netdev
shapers" sounds like nonsense to me.


>> both devlink and device shapers, while I read Jakub's preference as for
>> different sets of operations that will use the same arguments to specify
>> the shaper informations.
>
>Jiri replied:
>
>  > which kind of object should implement the ndo_shaper_ops callbacks?
>
>  Whoever implements the shaper in driver. If that is net_device tight
>  shaper, driver should work with net_device. If that is devlink port
>  related shaper, driver should work on top of devlink port based api.
>
>I interpret this as having two almost identical versions of shaper ops,
>the only difference is that one takes netdev and the other devlink port.

Could be done like that. But see more below.


>We could simplify it slightly, and call the ndo for getting devlink
>port from netdev, and always pass devlink port in?

No please. Keep that separate. You can't always rely on devlink port
having netdev paired with it. Plus, it would be odd callpath from
devlink port code to netdev op. Not to mention locking :)


>
>I _think_ (but I'm not 100% sure) that Jiri does _not_ mean that we
>would be able to render the internal shaper tree as ops for the
>existing devlink rate API. Because that may cause scope creep,
>inconsistencies and duplication.

Not sure what you mean by this. Devlink rate UAPI will stay the same.
Only the backend will use new driver API instead of the existing one.


>
>> Or to phrase the above differently, Jiri is focusing on the shaper
>> "binding" (how to locate/access it) while Jakub is focusing on the 
>> shaper "info" (content/definition/attributes). Please correct me If I 
>> misread something.

Two(or more) similar ops structs looks odd to me. I think that the ops
should should be shared and just the "binding point" should be somehow
abstracted out. Code speaks, let me draft how it could be done:

enum net_shaper_binding_type {
        NET_SHAPER_BINDING_TYPE_NETDEV,
        NET_SHAPER_BINDING_TYPE_DEVLINK_PORT,
};

struct net_shaper_binding {
        enum net_shaper_binding_type type;
        union {
                struct net_device *netdev;
                struct devlink_port *devlink_port;
        };
};

struct net_shaper_ops {
+       /**
+        * @group: create the specified shapers scheduling group
+        *
+        * Nest the @leaves shapers identified by @leaves_handles under the
+        * @root shaper identified by @root_handle. All the shapers belong
+        * to the network device @dev. The @leaves and @leaves_handles shaper
+        * arrays size is specified by @leaves_count.
+        * Create either the @leaves and the @root shaper; or if they already
+        * exists, links them together in the desired way.
+        * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.
+        *
+        * Returns 0 on group successfully created, otherwise an negative
+        * error value and set @extack to describe the failure's reason.
+        */
+       int (*group)(const struct net_shaper_binding *binding, int leaves_count,
+                    const struct net_shaper_handle *leaves_handles,
+                    const struct net_shaper_info *leaves,
+                    const struct net_shaper_handle *root_handle,
+                    const struct net_shaper_info *root,
+                    struct netlink_ext_ack *extack);
+
+       /**
+        * @set: Updates the specified shaper
+        *
+        * Updates or creates the @shaper identified by the provided @handle
+        * on the given device @dev.
+        *
+        * Returns 0 on success, otherwise an negative
+        * error value and set @extack to describe the failure's reason.
+        */
+       int (*set)(const struct net_shaper_binding *binding,
+                  const struct net_shaper_handle *handle,
+                  const struct net_shaper_info *shaper,
+                  struct netlink_ext_ack *extack);
+
+       /**
+        * @delete: Removes the specified shaper from the NIC
+        *
+        * Removes the shaper configuration as identified by the given @handle
+        * on the specified device @dev, restoring the default behavior.
+        *
+        * Returns 0 on success, otherwise an negative
+        * error value and set @extack to describe the failure's reason.
+        */
+       int (*delete)(const struct net_shaper_binding *binding,
+                     const struct net_shaper_handle *handle,
+                     struct netlink_ext_ack *extack);
+};

static inline struct net_device *
net_shaper_binding_netdev(struct net_shaper_binding *binding)
{
        WARN_ON(binding->type != NET_SHAPER_BINDING_TYPE_NETDEV)
        return binding->netdev;
}

static inline struct devlink_port *
net_shaper_binding_devlink_port(struct net_shaper_binding *binding)
{
        WARN_ON(binding->type != NET_SHAPER_BINDING_TYPE_DEVLINK_PORT)
        return binding->devlink_port;
}

Then whoever calls the op fills-up the binding structure accordingly.


drivers can implement ops, for netdev-bound shaper like this:

static int driverx_shaper_set(const struct net_shaper_binding *binding,
                              const struct net_shaper_handle *handle,
                              const struct net_shaper_info *shaper,
                              struct netlink_ext_ack *extack);
{
        struct net_device *netdev = net_shaper_binding_netdev(binding);
        ......
}

struct net_shaper_ops driverx_shaper_ops {
        .set = driverx_shaper_set;
        ......
};

static const struct net_device_ops driverx_netdev_ops = {
        .net_shaper_ops = &driverx_shaper_ops,
        ......
};



drivers can implement ops, for devlink_port-bound shaper like this:

static int drivery_shaper_set(const struct net_shaper_binding *binding,
                              const struct net_shaper_handle *handle,
                              const struct net_shaper_info *shaper,
                              struct netlink_ext_ack *extack);
{
        struct devlink_port *devlink_port = net_shaper_binding_devlink_port(binding);

        ......
}

struct net_shaper_ops drivery_shaper_ops {
        .set = drivery_shaper_set;
        ......
};

static const struct devlink_port_ops drivery_devlink_port_ops = {
        .port_shaper_ops = &drivery_shaper_ops,
};



Some driver can even have one ops implementation for both,
and distinguish just by looking at binding->type.


>> 
>> Still for the record, I interpret the current proposal as not clashing
>> with Jakub's preference, and being tolerated from Jiri, again please 
>> correct me if I read too far.
>
>One more thing, Jiri said:
>
>  If you do everything netdev-centric from start, I'm sure no shaper
>  consolidation will ever happen. And that I thought was one of the goals.
>
>Consolidation was indeed one of the goals, and I share Jiri's concern :(

Good.


