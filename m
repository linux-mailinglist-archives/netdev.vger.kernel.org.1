Return-Path: <netdev+bounces-90963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F3E8B0CE4
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1C1C231AA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DC15ECCB;
	Wed, 24 Apr 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="plxLhGtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF21E501
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969848; cv=none; b=rKGyXqBWCmhDzlp9vbihxirbApOXclQKf/hUOiKlHeMAaUsqLyN+dE/5FrpaejjtyMSJaUEtZygoomNGOyzkL2Hk7RrjvsuH4FIl4uLCGPJqD26tIMXRGLsaAA+Auj0QcCcG9gxKyQFn7NOEB6U7tF68u6UUTU8xY1MKTj9wCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969848; c=relaxed/simple;
	bh=7HvyDwLrdYlbXszT68jijcl5zFtZUsqyFmYOqjxqKKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0hu6rV6XNwluYQ7GgUGJLRhjDxu+VyikounIE1ORhFVl0KrR5DMRL1zePclpFJI68ivuary8V0mhWwO5TnRkhGOu6Uzhw9wJasDO9nWdk1/ggVjibSS6ZuRcnaoqMXJbCFUURsKvc8Pna2oVNKYKdKSz/EaluZIxXcwHALVbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=plxLhGtM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-349c4505058so5449135f8f.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713969845; x=1714574645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HvyDwLrdYlbXszT68jijcl5zFtZUsqyFmYOqjxqKKs=;
        b=plxLhGtMNAD5+qqCbAwZNOGE75DajRqdHa0LB2Cs9OjsDp5EOzPjUux0V6xpYlBw4o
         xcMqonqDMrBAv3EAH4iY5vobxMuv6aORoQ/edaEf2/tgjE0erLDri0Sx3+YpbyFClSxx
         tuhbS81qkv7MnVbqUEOZx9gNOsbvcFJ6Oqt8hl6DGU+epuRZeLPY4MIB6TM/nIT6ogZM
         xxMQnoo+g0Ipam8/2D3woA5egTd9h6h+cE3fYitOoB7662Vml901LXHi5VbBB9723DCB
         T0IoBXLl/z+NkI3GvDgAQYz7DBVlKshVzeX09YnezTh72iAv1PWs78r8EAJAr7QOR8ps
         0DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969845; x=1714574645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HvyDwLrdYlbXszT68jijcl5zFtZUsqyFmYOqjxqKKs=;
        b=fHipjiBbedRMaqmiQrD9yXJt5ywmWDpaerlEsrtvxEdYGVsWig2SVRx2VjKrdcJ9F4
         k6pIEruYLmqRmahUrBsxfvjoPH6RqURsdRj9tYw+Qoe6mX9kbSt4gMEUHmfAfQrkaL3G
         DHuJC9A6q8KvxJbU5QDHMG0HoF2A/27DbjBm80Vl7Ce9j0ShDfpgZgRqjDgDzveIwwVb
         rOYx3TKtjuzw9WOzH8kSAFdhJ+SGRvkeHnaOoEyAqK2Yycow/uqxrz2K+iKLovHnWCdR
         k5iGCTsmO+q9vPPmsdfytGXkQOtAl921z6Ty/WbzyWKkY2edis1tStFS4DsWVNmokHeO
         Mt7A==
X-Gm-Message-State: AOJu0Yz9u3xbRV76litrWrmrK8ZPgecBOwGcd8YJYy9MDn/Gqlhtt87T
	ddr2Z3ox77+K8J8GxljeF8TyVPI2MZ4Sgc4A9Hv4nKVie6sEtRWykrx/HNVJ02I=
X-Google-Smtp-Source: AGHT+IH2VTBH7CNe6dO53DMAmif/ek3i4eezeAzomorhBDaHF+8IWnTBhvlFXlBR6iLGk6NU25jHhw==
X-Received: by 2002:a05:6000:e42:b0:343:ab0f:4dd6 with SMTP id dy2-20020a0560000e4200b00343ab0f4dd6mr1819768wrb.33.1713969844797;
        Wed, 24 Apr 2024 07:44:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d6891000000b0034a51f86086sm14709553wru.63.2024.04.24.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:44:04 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:44:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	rrameshbabu@nvidia.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com
Subject: Re: [PATCH net v2] dpll: fix dpll_pin_on_pin_register() for multiple
 parent pins
Message-ID: <ZikasF4nwa5lhuDN@nanopsycho>
References: <20240424101636.1491424-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424101636.1491424-1-arkadiusz.kubalewski@intel.com>

Wed, Apr 24, 2024 at 12:16:36PM CEST, arkadiusz.kubalewski@intel.com wrote:
>In scenario where pin is registered with multiple parent pins via
>dpll_pin_on_pin_register(..), all belonging to the same dpll device.
>A second call to dpll_pin_on_pin_unregister(..) would cause a call trace,
>as it tries to use already released registration resources (due to fix
>introduced in b446631f355e). In this scenario pin was registered twice,
>so resources are not yet expected to be release until each registered
>pin/pin pair is unregistered.
>
>Currently, the following crash/call trace is produced when ice driver is
>removed on the system with installed E810T NIC which includes dpll device:
>
>WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809 dpll_pin_ops+0x20/0x30
>RIP: 0010:dpll_pin_ops+0x20/0x30
>Call Trace:
> ? __warn+0x7f/0x130
> ? dpll_pin_ops+0x20/0x30
> dpll_msg_add_pin_freq+0x37/0x1d0
> dpll_cmd_pin_get_one+0x1c0/0x400
> ? __nlmsg_put+0x63/0x80
> dpll_pin_event_send+0x93/0x140
> dpll_pin_on_pin_unregister+0x3f/0x100
> ice_dpll_deinit_pins+0xa1/0x230 [ice]
> ice_remove+0xf1/0x210 [ice]
>
>Fix by adding a parent pointer as a cookie when creating a registration,
>also when searching for it. For the regular pins pass NULL, this allows to
>create separated registration for each parent the pin is registered with.
>
>Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple registrations")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

