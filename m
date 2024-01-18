Return-Path: <netdev+bounces-64168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139C831899
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B31C286D6D
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B4241E2;
	Thu, 18 Jan 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2erxiN+a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F624A18
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578252; cv=none; b=KHYoU4O988GbXyTgrTclX2xmLR8M8r3T7jLYtEsM3fofgexXH3TfiWGfQUMMVStVgBfwZzzk1S5WWLNGcCrJh6CNm66qcCaA8kg5VJnUFE2+RLayDiaB1rtbnCitu3R/gwM7nPQcZEVU1B6HAjgSyao66VbD6bEVtmxZ+Drq6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578252; c=relaxed/simple;
	bh=TXhzczoo35a+K5387LOUu85eARm780theDy+utDYSSc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XAkhBryRAS859KrXinId7Y695tSepRPoUrm6oHAvcLxvEJVsFLYBStNGkaRrSGEJ2cEIK9YFx2BlzoOB6JR+UfIPlg9bU86aIw+RM+CwJn61s5fsZV6XS6o0LY7KCFU95jDvbK6KcJcbO5ECQmuFZLvhLRaNnOQb05610EDmVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2erxiN+a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e775695c6so34878835e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705578248; x=1706183048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DkW5uoEoUxrAMeFqmakm3WJjGOpUAJrCM6+jSD1194=;
        b=2erxiN+a7JjJ7kproTTBLEPXwarsPSlUTBfFZj0GjVpp9FWYeJe2viziLTPuVMQLvi
         dP6lXKRGYwXgS5yLxU2exjMoDfBVtaOJUas52U55jZoLwi6D8bEdwtX82i+BEeNin4o0
         Ujv/if/kir0tBZoUGqJPQISeoxJNx8VN/bJNQ9Fd6+tPsJh3v+jDCcdxdmpes8ig0bbz
         f6mIqmZaEGMr9OhLD4RXNnWUFm/3Xf3bGuE4GlP0i4d2ZvV+MsxDcfZWtM/pWVspy/T3
         boUg30NcI4zZxGv/aSEJEwC1d7JOcHhkgmmATTc3gOB6kw+FrH67yOX76JnXiJ0bDzwo
         TmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578248; x=1706183048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DkW5uoEoUxrAMeFqmakm3WJjGOpUAJrCM6+jSD1194=;
        b=iSqtZspax1NPsjMxAI04nKl4br3UIanJQgfzMkNAXC/m6sBKr635mrq+WryfSVddGU
         42NVAmBjH+UFVlCpChcgcstHkssSwgbcrPyZd5zcMCDOgHhmCoQ+NpR80xxEe9hAaFW5
         bglthvPsZ4TDZvSoE+ZC0ka3WXffOLckO6iGISkHOFzXUCupzCo4dxHhNrEh9B/sm/14
         N7OhACpNJSTlTS43MrH+31qmse0pVaYY4OksyiZbMDaY0y4xKMJID+yPPFrLSklEAUOT
         KYfJkairW5df9I7p8ZqozY6hN66jUMndcx1omoce+2L1Tb/ERqXyWrgZ0+l2JGIl8huQ
         SIFA==
X-Gm-Message-State: AOJu0YyWSZLQzZQPlsISwr839OmJ5fqX4Zv2c6VsEW4OORHy1G1eH/xY
	dg0Fk1SwvFO+YkbZjfAeKf+OQdawv3QegmzYy75Xxm2fPrPLjF9LNhsLYte817c=
X-Google-Smtp-Source: AGHT+IE3kgrKcFo10agh5B8BtEjSfObTeRYqoqAXsWfdjxOX7R8rTE30te4cQgydhlEGgLacjZkyUQ==
X-Received: by 2002:a1c:7c0a:0:b0:40e:66cf:81a9 with SMTP id x10-20020a1c7c0a000000b0040e66cf81a9mr477315wmc.111.1705578247918;
        Thu, 18 Jan 2024 03:44:07 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm25610137wmf.43.2024.01.18.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:44:07 -0800 (PST)
Date: Thu, 18 Jan 2024 12:44:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Jan Glaza <jan.glaza@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v5 2/4] dpll: fix pin dump crash for rebound module
Message-ID: <ZakPBmakH8BTv8Cz@nanopsycho>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
 <20240118110719.567117-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118110719.567117-3-arkadiusz.kubalewski@intel.com>

Thu, Jan 18, 2024 at 12:07:17PM CET, arkadiusz.kubalewski@intel.com wrote:

[...]

>@@ -443,7 +490,9 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 		ret = -EINVAL;
> 		goto err_pin_prop;
> 	}
>-	pin->prop = prop;
>+	ret = dpll_pin_prop_dup(prop, &pin->prop);
>+	if (ret)
>+		goto err_pin_prop;
> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);

You are missing dpll_pin_prop_free() call on error path. It should go
right above "err_pin_prop:" line.

Haste makes waste..

pw-bot: cr



>@@ -515,6 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_destroy(&pin->dpll_refs);
> 		xa_destroy(&pin->parent_refs);
> 		xa_erase(&dpll_pin_xa, pin->id);
>+		dpll_pin_prop_free(&pin->prop);

To be symmetric with dpll_pin_alloc() order, xa_erase() should be called
first here and xa_destroys() in different order. But that is a material
for net-next.



> 		kfree(pin);
> 	}
> 	mutex_unlock(&dpll_lock);

[...]

