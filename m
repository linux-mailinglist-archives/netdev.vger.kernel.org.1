Return-Path: <netdev+bounces-193402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B429AC3D05
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9103A0656
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DC1F0E37;
	Mon, 26 May 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ktyoC3kQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B41EF36C
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252184; cv=none; b=rO/5ejbniiGMbH7helU6Yd4K3MAaqF3hyqbYBfLZXYsz0jjAvMTfAS1duq+JNZTYcef7aBeBXCnx9fNYTTcflDQTztL4PxFxrAitupMRdqi7VSOFdfn7pyy2QmNyE3KORAHBWQ3g2mtKk/IV/Vd6LHKYMqjYpHFkQHSzWCrfixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252184; c=relaxed/simple;
	bh=DDVEnB3+og+dd3LXUpJ1xgMQIwKxMfEZf9aH+Vn41gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi9I2C0jZnzOq88mRr+DmerOkePUzsz7fFU5vtkmP0ldEyplo6noIaog0LdCJ1iy6nGuFJANalGfpwy4xh8F0WJmTUhwSCp3aiaStdxTmyXSyHbECN78CJ6bx81VWaaiEsfYj8DIY1q30vewUPaT+13dlUyJt2PJ+t3tp8LmS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ktyoC3kQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso14961205e9.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748252181; x=1748856981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akRWiY61vXSqwjUp4+3SAOB/I392KNgK//SHiZbby44=;
        b=ktyoC3kQWDeC4wmZtpiAiPbUUznI8gVoS5yaZtVWmxcjjybi2HGt/IET2iHT3OfMnc
         dk75LavzAY8CxymTk54EL3XxQi7FPtaJRy3dOWf5o66Gp7YSvQJ6RQCXHRIyL/pLJm2J
         J8zHvdm34c+OYYvDVph6uOpUM7MEr32ytc8IphKVM1HRQLeWqUY35RrUSj1YtpP9fkE6
         +JDPEDyLEWcgt7wzyTJTHaAdfLDOKe7nZTc2EImMtaL+qO1bfytymfg51IuCK0+1/fgD
         b2NcujBb/J5Zq0/+gT+VbA2rZXVs9VH5CcHTN86RdNVIRGFxIuljOnAxiDV1UbWwg5fD
         pp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252181; x=1748856981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akRWiY61vXSqwjUp4+3SAOB/I392KNgK//SHiZbby44=;
        b=bmR0sYcO4Nw/c8ITOEjmRRq46/asq9m+KgKTE1AydbfsgNM7kZPbqE9uz8o/6Rexzq
         oPBeuLPHyzGTltlUJ9j2JOzeD8M5m6hcILdzPe6CHEgb3fkqxR1B24gp2QqTAUa1SBLC
         2YAX8kqoluUav3cg12Z3NddVnLVxuT/ScZErZHhM3BAj6Xo76qlehMqvpWYaew89dX4M
         bSy4uinkFbZht4dLiW3ejU90HMixO+VflAQPhMJvMptczFcMgLYaFUsRoKNZCUW17wJY
         f0jtVpw0/IoLyXuMI7URxKZEeu5Aztmu3QgWMidrZZ3BJ9tie6SJp67ZgzW65TypNLS4
         8wxA==
X-Forwarded-Encrypted: i=1; AJvYcCXHnSlxhg60TZGzEfLYNxs6Zbp2m5ICW5OSh1azrjreRbyLilK9tOkkKekHsgBONQZYtMoWoSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezcTFR3KzH6Bhsrg2lAvMvkxxQ+XtqZUsaoarFfYh2SUge+Ty
	O7dI1uF3IebvVhyvjKgH/HuNiZIeTjH5kMZCyksvgT0xR18VZQWpoMOzsotoNTbQ9EM=
X-Gm-Gg: ASbGncviCO1zbjAH9PLZMH21g8mAqd04XAlTrshhIf9lXMSGNLeQ9akbD3TvW4c2Lwl
	uH+n6zRRWZDVqJz683SHjqtazYq9ZJ6dnzKA0mfynRcEWpbdeswABABtkZXXuMwsZW49svaYHRQ
	B/gn/TfI9Ugb94Kd6XWOqQfrD7Xu7icPqdBuZVRpCa9Du9FiHCwpeWi2Qi9JaAF+K7jfhWut6ux
	yuSu5RR5jeQXLjbZ5+HWMtbZlB/oHOkiefCn2tCeqLD4KKmbDXAvhCQSLRZE3OV91JbUfeoiW8i
	/bGvKavZWf9apDm23mTibCF8ZBthTDTFEUCpMKIsGSIPWlwy+Ggh9Fnl86oXH0TEagtL3epZQ4S
	kB4CNMPRH0RxGmA==
X-Google-Smtp-Source: AGHT+IHdDy9HaiyBHAWl1b2RTOZvmcqUOl/x5XI+mJD2ZIuIvNRG2stc5RkHbBIlxB8zAvuJ5iXn8Q==
X-Received: by 2002:a5d:584b:0:b0:3a3:6a1b:6885 with SMTP id ffacd0b85a97d-3a4cb486043mr6616468f8f.47.1748252180662;
        Mon, 26 May 2025 02:36:20 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4babec83csm13835277f8f.80.2025.05.26.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:36:20 -0700 (PDT)
Date: Mon, 26 May 2025 11:36:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, milena.olech@intel.com, corbet@lwn.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] dpll: add phase_offset_monitor_get/set
 callback ops
Message-ID: <3unqj7hiplrlcaaq56hf24d6vohi6rsxu6b5g75s6aypjwqgwk@hpewzyd77dhq>
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
 <20250523154224.1510987-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523154224.1510987-3-arkadiusz.kubalewski@intel.com>

Fri, May 23, 2025 at 05:42:23PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Add new callback operations for a dpll device:
>- phase_offset_monitor_get(..) - to obtain current state of phase offset
>  monitor feature from dpll device,
>- phase_offset_monitor_set(..) - to allow feature configuration.
>
>Obtain the feature state value using the get callback and provide it to
>the user if the device driver implements callbacks.
>
>Execute the set callback upon user requests.
>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

