Return-Path: <netdev+bounces-303562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xthVJ73jRGqa2goAu9opvQ
	(envelope-from <netdev+bounces-303562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:54:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00606EBC28
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:54:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=snFLCVVT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEEF13078C35
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01B3FD941;
	Wed,  1 Jul 2026 09:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAC3FA5FE
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:48:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899296; cv=none; b=MFo3JQypDl3vGqOVHg/GYnvK3PC6fYUBOacl+/V5Fw3pfTms+OAGjeJgT5/uG9De2L4C9mtzPlxXUKqjCt+b78uywU3vZ4Nhot8Vo0Lbp99lzqrXZGL7LIFfpZgVRcEHF3FblnzMkM4QLsU35/pEE8DeHJzKG9VuBF9co/o36b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899296; c=relaxed/simple;
	bh=mz0vRNQWV5JarJs5YU7f1UVIX6UZW0zFBNIMdXMVDrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZY0hv0I2CtpygHwFOK7X6bTj6456RjCN1IeUrI3EeFxR000VjsC+YlI3N9dsM3pfl0ecg+M2neY2cC29xqfeHC9DIGs3rgNVe+/1ugxO6PzOUygonfBnH39ZKgjelatz+kmf2mG9keNAQilHvcaTk6VeugEG/fK0jUhNuuJ0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=snFLCVVT; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so4017085e9.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782899292; x=1783504092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mz0vRNQWV5JarJs5YU7f1UVIX6UZW0zFBNIMdXMVDrg=;
        b=snFLCVVT9Q8TYu0Ii4Luf+Z7+h1E+Sy0+rdd597Lp2CjdotKOm/YaflZZZPoK3xZI/
         DFIfniTh9a5XVRHuIHi0uZA23X7NwexbGAOdHumZkIpWcaTuS04LwGIJJEreOsuk6bu5
         GAWiBfDZ7zflO7KEWgz8jnuAtb7bcGTZxgdQYuTFY61A4HtvoZgPX0Ts/8aseRqJ0B/r
         JSXWco1PowUxxWYJq42RcPJ51V4Z1WoeegiuwtPrcxDOzRdfdVDo5Z0yETlUZHYr9yDO
         qaPFo7aIDBrzLRccVCicxd+4TBhie0aGG8YLJMN3zYUcsFkjeK+88UQZkaKGTQBh0XYY
         sEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899292; x=1783504092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz0vRNQWV5JarJs5YU7f1UVIX6UZW0zFBNIMdXMVDrg=;
        b=EVpKfNJPeGww4y1SsuubuRr/bcjuoH+Pma1u9BT8pkX2peO14TRpww6IclFvlSwVyi
         vBZOrP4Gy99Z5TyfGNwiZx0JbgFn5kUBEuy2E3jtKatDTVGZhZFOyj5LSIZMJe8lg3cf
         URj7/r0ScSm6OEYfRbSeVPgbTlIxJk+X/novBgfFa3ljncRRa8zT5PZuc+UNFU6c5eDB
         1qBJ0sjgLaU9EA6sFvfn6YXFmPb89QCmstgknbabskIAN8HEUzOPsu8UUZdFkEAud8AR
         Y7W7rUPTMoFG4wPybz1zDGHJuoNVFdOGBu95W0LAsBqhcrmcoroI/D9ik1v98djGm3o6
         UGtA==
X-Forwarded-Encrypted: i=1; AFNElJ9Owe4ORK+wZsWPGK4MHChnehNyfIRij4zMHjrlwFX6cYEFsWuc+1ckGKZ53StsJV2EGSy9B/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDhhjC6YZQ03mmrJOb5MYyJtKUISpq/S7MBgXdqbVoQTwqEhi
	mSwQXciYUFP9klTyPZtd5a91LjrDD5t0JqZXEupf6io+/80cnVE2th0GW3h+rm2KQdY=
X-Gm-Gg: AfdE7cnO8+59F4eLukof1tJ2Fr+FOmtvG7Bl7VTcXAa4hv47B20vTQIUhrIdJrgwT6u
	B0EdKMXi+ziwWPn/uU5PfJ2hlIgYuIQB6Zz4PqsANLmwRvQKCfostmvpjzIiO13Cq20pa5I9B8j
	Nl6keZ+DnlFo65t1f72lbOzPTEeDYNX5f8H8Zao2BhkKeEE1NHA0lE4bQpHIGGsaqGIZPKjOMyR
	j/aoCsnHcO14vWvKmSmf4f3URB/iaiKrvnE/aqBWwm7JWwMmMeEe3CXDHtHwSOuT+Oe+Fe6vgWs
	pAaPAHMV29ViDAwOw/cTd1jYgttkOtaw1A27pY0Lto5XejdU0s52Mo46C+gsQVrQje5qR7vxT97
	aX6KjH5p65zyBZwmVtfDBdAhVCztl2eWxdYqv4Gorwg0WQXJHbi5BDdVSbkuyPsYD1jX/y9bDTP
	bQ1OJ7J3VFrPwI6jn/6PUVMg==
X-Received: by 2002:a05:600c:8b44:b0:492:5bb6:6d4b with SMTP id 5b1f17b1804b1-493c2ba5968mr15237255e9.34.1782899292593;
        Wed, 01 Jul 2026 02:48:12 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756778fac3sm14575152f8f.32.2026.07.01.02.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:48:12 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:48:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <akThPmvUHvCMT2cp@FV6GYCPJ69>
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629182102.245150-5-mbloch@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-303562-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,FV6GYCPJ69:mid,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F00606EBC28

Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>Apply parsed devlink_eswitch_mode= defaults after devlink registration
>and after successful reload.
>
>devl_register() may still be called before the device is ready for an

How so? I would assume that driver calls devl_register only after
everything is up and running and ready. If not, isn't it a bug?


>eswitch mode change, so keep a per-devlink delayed work item and pending
>flag for the registration path. Registration queues the work, and the
>worker tries to take the devlink instance lock.
>
>If the lock is busy, the worker requeues itself with a delay.
>
>For successful reloads that performed DRIVER_REINIT, devlink_reload()
>already holds the devlink instance lock and the driver has completed
>reload_up(). Clear pending work and apply the default directly from the
>reload path instead of queueing work.
>
>If a user sets eswitch mode through netlink before the pending
>registration work runs, clear the pending flag so the queued default does
>not override that user request. Cancel pending default apply work when
>freeing the devlink instance.

These AI generated code descriptive messages are generally not very
useful :(


