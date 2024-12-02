Return-Path: <netdev+bounces-148020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F069DFD1C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC62281E33
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37DC1FA841;
	Mon,  2 Dec 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V4LHsKFd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8451FA252
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131652; cv=none; b=in8INkXClrluHiyCiU94lP09Vr6DDW3uXgmZxaI6B1lJHPTJ2ZdClfaLbuRmm9vHosvr4MGEDB1v9nVMj9Xf/giMqemkKRun+luIO5rIPnhkuMfSog9QbuhEl7fukHs+3QuZSLsNlRTytt8LoItnMmGK5m8T3lQqq5T2vl12tf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131652; c=relaxed/simple;
	bh=pl7QvLcG+llVV+JTbsX9ovJ8Bb7kDx0u2bflIzoYcYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puQxWSKqnRm7S+b3ohPCPasIhfO4Qn4lqURuFbHwP/FBl6mXyG/9eZVFjKPC3q3Pf+DwpQs76TvDhx3AqBml308MjidmQXp80epmI58GQ0pxdGBsK3dZ3O794lm6iLY3fgdICxuHYPvJkzpuKPXxG3543knKiftoK8UXr5yc1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V4LHsKFd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so525184366b.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 01:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1733131649; x=1733736449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pl7QvLcG+llVV+JTbsX9ovJ8Bb7kDx0u2bflIzoYcYI=;
        b=V4LHsKFdNLMpnxNUcoBkFMOwyfjhCM7hGwl8AyYz8JDZPRoYbrgARMB7LfMzajn5Eh
         +uRCoXbPpiWKCAENxRMoPuaQC+mSD4FnrG8DILMUDa5KgIvQ0WomE+AJUBBOIuD9fkIl
         vYutBSN/Vw0ETxrhNuO5crOX0kwONrPwlR2BuN005lpBZIQWmJay7gCVMgiAGbzlzp6d
         agCcbYboSH6oi8a6x8oxiiJPiyhV6dc7m/Vq+MjQIDceFypZv+eOqbglVj5oPKWxLXjI
         Xemc5HylFTVdeQCSNz1OI5xuxRBbTjROQtxiUdzj1bMwtfXMPaqOXS10tL1N30HMeXj/
         Ni+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131649; x=1733736449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7QvLcG+llVV+JTbsX9ovJ8Bb7kDx0u2bflIzoYcYI=;
        b=s3sNfFy6fNXVYPlE49qWtr+Jrd6+EZljOGDmWTvMd0aJuPVz1XVjBvVNisPJQINdWU
         3K58IJBu4OlruOjmdrrNbj2+b2cuF413xjEKgKTtH7332O5XSRZ49qxvBQRHWvsLrXzV
         tI1d48GVvgpKETXe/a1RKy13mYS6NsIHbF1csviEMWVTNhGAo1+3HMo7ZyoDWhXQCzhN
         wxohkyFGb+g4fBudio/YLTbf1dLQO/+X2s3FYQVV4mdAWnhDsYG5CS6DduxmVG3p024h
         NCPmDhptulAFY/etwPeZ+tF1hm1jQTogKB+LTvwlwhiNO+hbwsa4xI/ag7pqJCGyYxia
         miEA==
X-Forwarded-Encrypted: i=1; AJvYcCWYBUeae0aRAFGBj9QBqIJKNezzMURzLMl1wKx3RERbGghoYV9epx9LdMcdrQqcKpje0PXYLL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqUCq5z6tkQDF0EYJ6dla8GzUKHIguM7Iu1idgNTiDyNQmHx9
	LuSEuH7+YPU8v43ut/+o1XVBsOF0RsnQeh/cHK0tKgog+tJ3YrLLKTpeSVEvWsE=
X-Gm-Gg: ASbGncsbow9aN659H/uYpYmyxy1iP6FSUc4YQXk4iu4k9R79+B7C4xdJvV4khbztlEw
	A8lAhXuzjn0+YGj/yXtry1WfpZSWobliNQc70reD0vaQtdvuyU0zQOwIOTuW2c59cqoCzcCYzMf
	curwyoPw3fwyQN5H/XzrK/IJaOcatuZRKmXxMDLyRAzMAVhS5a+Yn99tPZLqXZDHEkqxxqLJzs+
	O3tFAIg4rX3mafXPvbFx0bxiFPdJxeu4OloL1t1Wfp5eXF2vdVlL4f4gDKh6etqUHM0Ww==
X-Google-Smtp-Source: AGHT+IHJFEiwo9Lyc15w9Ds/jb9CjQsGIpHj5PkE/zOc5gjY9Jh+95fpF9pzLyoiB9rNK5ro+urwJw==
X-Received: by 2002:a17:906:329b:b0:aa5:241a:dc75 with SMTP id a640c23a62f3a-aa58103b03amr2063507466b.41.1733131647333;
        Mon, 02 Dec 2024 01:27:27 -0800 (PST)
Received: from localhost (89-24-45-172.nat.epc.tmcz.cz. [89.24.45.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996df78csm492732866b.67.2024.12.02.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:27:26 -0800 (PST)
Date: Mon, 2 Dec 2024 10:27:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Strohman <andrew@andrewstrohman.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dsa: Make offloading optional on per port basis
Message-ID: <Z019fbECX6R4HHpm@nanopsycho.orion>
References: <20241201074212.2833277-1-andrew@andrewstrohman.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201074212.2833277-1-andrew@andrewstrohman.com>

Sun, Dec 01, 2024 at 08:42:11AM CET, andrew@andrewstrohman.com wrote:
>The author has a couple use cases for this:
>
>1) Creating a sniffer, or ethernet tap, by bridging two or more
>non-offloaded ports to the bridge, and tcpdump'ing the member
>ports. Along the same lines, it would be nice to have the ability
>to temporarily disable offloading to sniff all traffic for debugging.
>
>2) Work around bugs in the hardware switch or use features
>that are only available in software.
>
>DSA drivers can be modified to remove their port_bridge_join()
>dsa_switch_ops member to accomplish this. But, it would be better
>to make it this runtime configurable, and configurable on a per port
>basis.
>
>The key to signaling that a port is not offloading is by
>ensuring dp->bridge == NULL. With this, the VLAN and FDB
>operations that affect hardware (ie port_fdb_add, port_vlan_del, etc)
>will not run. dsa_user_fdb_event() will bail if !dp->bridge.
>dsa_user_port_obj_add() checks dsa_port_offloads_bridge_port(),
>and dsa_user_host_vlan_add() checks !dp->bridge.
>
>By being configurable on a per port basis (as opposed to switch-wide),
>we can have some subset of a switch's ports offloading and others not.
>
>While this approach is generic, and therefore will be available for all
>dsa switches, I have only tested this on a mt7530 switch. It may not be
>possible or feasible to disable offloading on other switches.
>
>A flags member was added to the dsa user port netdev private data structure
>in order to facilitate adding future dsa specific flags more easily.
>IFLA_VLAN_FLAGS was used as an example when implementing the flags member.
>
>Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>

Why is this DSA specific? Plus, you say you want to disable offloading
in general (DSA_FLAG_OFFLOADING_DISABLED), but you check the flag only
when joining bridge. I mean, shouldn't this be rather something exposed
by some common UAPI?

Btw, isn't NETIF_F_HW_L2FW_DOFFLOAD what you are looking for?

