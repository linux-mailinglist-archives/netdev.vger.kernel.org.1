Return-Path: <netdev+bounces-193403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37632AC3D14
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA184175F88
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77651F1301;
	Mon, 26 May 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ULKLb1Y0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF217A2FA
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252514; cv=none; b=BaBQ9FjxcJNKN2awltZ/eV8+sVdGexnys/aH+C7pB+ykYd5Y/kuQgXOMaoMMhWq45Qr47DowHR+ViZyha6ZJCcsnYjzF0k2iDq0sMVS0OcJU6OtaCDyXu/ygXfoGonGelDRch2Ss23csHsyXm1PVE/4ROt08BlSEsuz/mpsVq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252514; c=relaxed/simple;
	bh=lJmA+auFBQfr1DUILoMWF+XAhP7fsD7jdarK60rySkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6slaWMkOU+wDwKbT702YW3RbJ5Z5G4i+cFVv/J+iusg0S0tzADDens3BcMXoQXRxYq+b7Qzk0YR7Zln8Hi2HusVlD0YeRiX5F66Dee4FvmRebXdsLZ3pQyeKfViBlMb6qsF7Ck+5mwMNWrL6EsNhnbeV3DdTfPLyG/VTpYEVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ULKLb1Y0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a3798794d3so2069649f8f.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748252511; x=1748857311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJmA+auFBQfr1DUILoMWF+XAhP7fsD7jdarK60rySkY=;
        b=ULKLb1Y0ez7RS9jMxEVhsdBLdc0jTgRJGQhUdDJQCk0qrC3ApckvdWLtbZAUGYDk7T
         mo76WYDNhNbfk0Wpkgb+LOzaYgoadbFNRMn0tx8H7pOawpNnJI26UyED5Tr5jn+I9CpR
         nl5UTXtdp2L8sm6rYiC/GrTBXGoX9MUk3KAL9qU9BIeWOfICkgmMXeZtIW3unxgvm8VM
         ls+EFFKG+HhKcB88FJfI8y6Qy/thi8Ye5Le2Ud01UZgPTTIrr5w5RpLRxIMxScOFZIyL
         oprEQ9lP97H6vACxaiifE8TJEt0ElyOiQ5HfSsYXZdvASwYeIUvgmxXv0aTYR5dUwa84
         8bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252511; x=1748857311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJmA+auFBQfr1DUILoMWF+XAhP7fsD7jdarK60rySkY=;
        b=Jq1mgwq0C3Vw5hHA+alunfw44Dv0nov8e339SDvJ7K7tB9yvF3QDuDBovMV+VmJLaC
         xeW6MqN2xsqkRa9f7PcobkOegcF5AoUgC9T/oGhVaaiEFVUOiyoFDBEyWlWwWZwaPGsH
         uAqQhvbxcnr3UEZftSp6AyCGJ7KzO0vRe8QMJUe6xHCFJ3QrtPjw17hBuZ8Umv9x0Fyv
         nTiXtL9VBZTfp6UrOAV++fdDgULTIQJKJSrenUa7Ps9sA5nyqgfiEEQYfNh9wL9c3mmE
         2j+yM6rCKmiMcbKoVFJj0BvU7ZMNxJ9nf+zptQ77lQDaDO1BFcM7GmMwZzTdM253MvTZ
         KQoA==
X-Forwarded-Encrypted: i=1; AJvYcCVvrXSI3PMVQWkk6a2Q3+hvZtsYdDrDx+MCrTtoFhE/AGpE4wQyWCAXIiJX2gnDi++7encjQ94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsrAoQG42S/h1SyOGksZMzAcKtIenbgw6IM4P5mg68EwDdJiX
	+3/T7eGJZyHP8VAsAZv43HsnCi8uD02YUN++3SHhnhFomwZgtzVHXhA5gbFDrRuJVIk=
X-Gm-Gg: ASbGncu5Ih8pzDiGxhu8TJk8pG1on2tIJ6ElzTVXu2cQklYMMbU1eicbJASmt+Oleeh
	PLcKhoUTcCkthDbfJe6VVsJY7o4Thw9KRA9Azp2GO6kkCTzwf0wRHHAzP5baMOzOGS/d9dbkgJM
	xQH7WYgMuww3Qjkpn0zJe1s9IZbvxYEsmt4WjE6SLxG0FObKS12xY+vCxJUh725KN99gHdzDy1+
	HwcSBgLso6NkepWB2/tLCCCPIVT5md0BuO+H9KSF/RFTVHE/Eo8pwwUOh3aEwDBhqjbfJCKKPsg
	Nq5bo4MkyWFEJMglxtFPWbva9hnk4eWy49Ty6T8Q3Cim7bo20RYY39ayek3qOc7oiIgUTxC8zuG
	lWn0=
X-Google-Smtp-Source: AGHT+IG8qcPgCe6g3rQUfM8YImSTE9FHiPfLbOy9uip4wVp1I8BHWjPMZtQYgrJU5MVy0rx4F64Wvg==
X-Received: by 2002:a05:6000:25c8:b0:3a4:d0fe:42ae with SMTP id ffacd0b85a97d-3a4d0fe4e5emr6093907f8f.10.1748252511231;
        Mon, 26 May 2025 02:41:51 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d56641absm3767945f8f.4.2025.05.26.02.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:41:50 -0700 (PDT)
Date: Mon, 26 May 2025 11:41:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, corbet@lwn.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v4 2/3] dpll: add reference sync get/set
Message-ID: <3csutdtlt43m2jcfs5y6g7ih6hmfb5z63u3m5as2oi33cefkgl@dyk2ayd7anso>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
 <20250523172650.1517164-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172650.1517164-3-arkadiusz.kubalewski@intel.com>

Fri, May 23, 2025 at 07:26:49PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Define function for reference sync pin registration and callback ops to
>set/get current feature state.
>
>Implement netlink handler to fill netlink messages with reference sync
>pin configuration of capable pins (pin-get).
>
>Implement netlink handler to call proper ops and configure reference
>sync pin state (pin-set).
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

