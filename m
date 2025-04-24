Return-Path: <netdev+bounces-185466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8898A9A8EB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5359F7B5BCA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829722127D;
	Thu, 24 Apr 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nIi7EaKW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CA22CBE9
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487742; cv=none; b=Kie9T/HMxJREzlrYiU/aSW70azpICt8IAmYwMJbMarf7UPuwGPYAEBsIRU79CjnwD4IFx1jnLScBGjV/oRKwl7J40sDoJp5ocnHYqoiVT8umcA0o6FBzhsTpFqbw9jRu6tF4jwXz2VDIE3kkqmO5SP36xhlAw1CJ4INHtWaYYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487742; c=relaxed/simple;
	bh=ZWeAv14hAIlH3u+5vm3wmTFhVc3xnzvdayuTO5HgaMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCdbdlsXpeisCzP4H+HJ1vIrpfHv5GULyef37/+1mrrgPNEWCI0cjAkG1tTlfVlsFATKYLK1MBL5tgb1hDnJfcs/pH0cr9YHTwdUYcN+6oOFWI83K8lVIGwpwVRsxDqteylP6xxquXz4nSm+iyPBMErh/Dx8JtDhdoyPwsQ8SN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nIi7EaKW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so6633985e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745487737; x=1746092537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3skhr9i/7wj3j1OBOewH70sqcchHHPPA8Lop+hdfSVI=;
        b=nIi7EaKWbjucrgClMQCgHU6kwgMWouTHEjTuKwnv4mmUOdwhx7dgq5GsRm4ihHyz8C
         hV3q183rwCBD8U7m4TV+HhsmmMjhJ8nLFZ19h0HBLAXHFC3JgbPS4/81wUnA4UGw+nGv
         m05FRqRvn7ehl0rWLwSPOXXJP9zV3nRv7lmbxrvRiq5PDPdMT2nTi7OxK+4noJgieqa2
         eQfsu07pWawie9OG1nXL7qV0KXA7el5jdO69eVXV8BoU8JC53nuVvFFwcSREQv3Yv99k
         YXtkCZXJCaD06r1T44IyOgUd1QjoSG4XdBBSdHok9xzuJuHlnA6OhlX9Uk+MCK1dSdLV
         E+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745487737; x=1746092537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3skhr9i/7wj3j1OBOewH70sqcchHHPPA8Lop+hdfSVI=;
        b=wiwbPN197S2+J8y8P35drbbD/G51Q3lLQhpecp0QDAGW+byuVRsSGhfxoTaECqo79s
         /C4SbEJgnZ/raaegQMQn3ZzQ7fCFblvmXN5mEBHA16r4Uk1yKy5pmpDJoSajCisJWuWP
         5T3Gkl63u+mY9A3B2R6S41RScPy1d6CDnEEe0IURGq8t7Y3oAH81ZQ/exAbHO/5Oifhs
         35OMG/SUohvTujC3DJyQl7XTCZlWGwT5t/84idXphpYp2yylpS3JVjc9zkwTFFo9GKIw
         /pVuJgDcnaToSvMgQ7A6yMTbYBqiRCUHgZ6lO/gpLc4hh9QE54Npa0v5ccxng2+APK3X
         xwzw==
X-Gm-Message-State: AOJu0YzPFE8ybTA8ofDMZeQnkQw91peVNK6rKSiHP/dG2AyVf7ILsyRX
	D6WSjAe35PXHJcx5JVpI8ZF+hpRDIxcUjJIbm7edTdG9NvDEBarbaglySRIiioI=
X-Gm-Gg: ASbGncvsX5R/t8JW77k38qVOAqgl+xPIu7a1xZ6FoDiWIJK8vTsFuvA+0nSXVyjNyhs
	0z5bVW0wkmvdC9t2mTDr4KsIwZQrD5SkUy1gu8lX+7huWC3uDBjKzygvkqnwdE5c5NptTvRNdOE
	2voLmtqNxsXgx8BEqJIjyqcr213lMJDO9nE4l4gredbcAv/OFmmRcc3RSemwUw7zlx06iGoIRKx
	YGlouR/I3IKAxSfsNaJ0peU2MbmUYpVZBxtKhZX+6FohbbeIu0S0KqAhenxStrNVQDfot8dZdoH
	QwNjGrwJlchBYsP3m1JizAf6yhejZwQr6v/bbAU9RgN35X9jOt5bmw==
X-Google-Smtp-Source: AGHT+IGFsT9M9fsEjYqX7z5YAuzC3ZPefP/rIRdB77vDTCUL/M3vp43J5Rr/ZqrndITBk4qhWZU3Lw==
X-Received: by 2002:a05:600c:5029:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4409bd8fee6mr14034115e9.20.1745487737129;
        Thu, 24 Apr 2025 02:42:17 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2acfb3sm13570645e9.19.2025.04.24.02.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 02:42:16 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:42:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
References: <20250416214133.10582-1-jiri@resnulli.us>
 <20250416214133.10582-3-jiri@resnulli.us>
 <20250417183822.4c72fc8e@kernel.org>
 <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
 <20250418172015.7176c3c0@kernel.org>
 <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
 <20250422080238.00cbc3dc@kernel.org>
 <25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
 <20250423151745.0b5a8e77@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423151745.0b5a8e77@kernel.org>

Thu, Apr 24, 2025 at 12:17:45AM +0200, kuba@kernel.org wrote:
>On Wed, 23 Apr 2025 13:23:46 +0200 Jiri Pirko wrote:
>> >Because you don't have a PF port for local PF.
>> >
>> >The information you want to convey is which of the PF ports is "local".
>> >I believe we discussed this >5 years ago when I was trying to solve
>> >this exact problem for the NFP.  
>> 
>> If you instantiate a VF devlink instance, you would also like to see
>> "local" VF port? Does not make any sense to me honestly.
>> 
>> Why PF needs to have "local" PF port, isn't it a bit like Uroboros? The
>> PF devlink instance exists, the ports are links to other entities.
>> What's the reason to have a like to itself?
>
>Neither do VF devlink instances in the first place.

Sorry, I don't understand your point.

In VF instance, when there is no eswitch (in theory there could be one).
There is one devlink instance for VF and within that, one devlink port
instance with flavour "virtual". No other port. Simple.

If VF would manage nested eswitch, there would be another ports as
representors to links. This is more theoretical scenario, but I can
imagine VF managing eswitch and spawning SFs under it.

Same for PF. In case PF does not manage eswitch, there is one
devlink instance for the PF and one devlink port with flavour "physical".
In case the PF manages eswitch, there are other devlink ports, each
represents a link to another PF or VF or SF.

What are we missing here? What should be different?


>
>> >The topology information belongs on the ports, not the main instance.  
>> 
>> It's not a topology information. It's an entity property. Take VF for
>> example. VF also exposes FunctionUID under devlink info, same as PF.
>> There is no port instance under VF devlink instance. Same for SF.
>> Do you want to create dummy ports here just to have the "local" link?
>> 
>> I have to be missing something, the drawing as I see it fits 100%.
>
>Very hard to understand where you're coming from since you haven't
>explained why the user has to suddenly care about this new property
>you're adding.

That is simple. Same as we have serial_number and board.serial_number to
provide identification of NIC entities (asic/board), what I'm
introducing is a way to identify function - a function UID.

So 2 PF that belong under same asic would be distinquished by fUID.
Also, if you create couple of VFs, each will have different fUID.

Consider this patchset:
https://lore.kernel.org/netdev/1745416242-1162653-1-git-send-email-moshe@nvidia.com/

That adds a counterpart. PF devlink port function property:
$ devlink port show pci/0000:03:00.0/327680 -jp
{
    "port": {
        "pci/0000:03:00.0/327680": {
            "type": "eth",
            "netdev": "pf0hpf",
            "flavour": "pcipf",
            "controller": 1,
            "pfnum": 0,
            "external": true,
            "splittable": false,
            "function": {
                "hw_addr": "5c:25:73:37:70:5a",
                "roce": "enable",
                "max_io_eqs": 120,
                "uid":
"C6A76AD20605BE026D23C14E70B90704F4A5F5B3F304D83B37000732BF861D48MLNXS0D0F0"
            }
        }
    }
}

This you see on the PF that is managing the eswitch. This devlink port
is a representor of another PF, let's call it PFx. PFx may or may not be
on a different host. It's a link from PF managed eswitch to PFx.

So you have 2 PFs that are in hierarchy (one is on downlink of another),
each on different host.

To find out how these 2 are connected together, you need to know some
identification, on both sides. On PF side, that is port.function.uid the
patchset mentioned above introduces. On PFx, the same value is listed
under devlink info, which is what my patch we are discussing here is
adding.

Is there another way to see how things are connected together, if we
don't expose these identifiers? I don't see it :/

Sorry for not being clear from the beginning. I can extend the docs and
patch description with this info if needed.


