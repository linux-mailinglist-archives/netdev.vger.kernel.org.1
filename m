Return-Path: <netdev+bounces-182886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B660A8A45F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BE03B5BEC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387B2918E9;
	Tue, 15 Apr 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T5TbKE6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AF1E1DE9
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735319; cv=none; b=TeJWfINRS1CRzfrakQBTV5mehwElDjYt4B4h10sDzQmJDhJvZH+YJUIp/1RzQCPSuLcQSRHfnNMWMSoi6yUx0Lw/d7nm0kt5AmTynjOrHyQlSL7n/eJg+fe2V7v2XwnApkxOw21kdliynL0oDyb9j1PsR/scZoNclnZSnvCfaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735319; c=relaxed/simple;
	bh=6X08oSjHVxg0ay21RO4FYzf8ovK9mj9m6qaYm1Wh5Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUCPLf343ktiVQaGAnFNSCjPlpr8gZG3olWe3cQ5bF71g0LgvP7O+dJHjN45RLHDZ75LYvPpf3mE8WLIzZuPxBM5B5pZA64W3MkKk2JASDv0s5kpCdsFJk2X/AIpNzuqvvtOKPpoiBwT9sU5XrKO9lElW8OVSfsfQDs3Rgw2SXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T5TbKE6b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so57955635e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744735312; x=1745340112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cs0vOMD0XLH3qHqhiDlgbAj78QDdnIWArNDzFriW1/s=;
        b=T5TbKE6bKYwsIyVqPasi3I84MTOMrs6iPLgWDHzf0wDASDcfCk/G/uy67WdyFGc3HO
         frxJU2EfU21A39BGTNu3dF9E216JsoDik6yF6R/oXkhJRmzn6c+2CFSaAlUECKeK0bKW
         dBXKYB8Ygzn0jIY37zddt78yXtlPvwO628rsAbQr9oyF96eXMr37Ai5Sdo4Eyr7kSy+t
         t3Zm9yBlqUdDsfHjVcitmIoDTCPPPB82b8Ym276iqLs6tBouEKfanAiY1AHxp+3DLYvM
         F6r2hxJyZ1cRN9A2XM7oPwgjPP2NwOfIg3FHY6LgOglWxxbNdW5KY/KGDUScrHuIiBLA
         wYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744735312; x=1745340112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs0vOMD0XLH3qHqhiDlgbAj78QDdnIWArNDzFriW1/s=;
        b=pgUrg2NgOcQXfh22U4C/pHRYsJkcX5c+D84kA8f8RrfYOGhAynqP98sCNc9MZ/YUH3
         dbl4Zys2LC93NpocqKmTljKWso2D/dBVprQakjVYTLXQ9OsD5ssgbGLbvkO6nKd8FMEn
         ac035HvzWSzV76ijpSUrx9ucOS3HdLvNfRoktolnBDCnMpTXQCcZ2YrSXqGm4EfyZgbf
         zxuvFLwEo5J3hTR6r6FHuABxWu4vBenqvElmgKngH8Kv/PAAc2fkiO1YnK0cXPF9SeUC
         0dyyyD+nS0cr31B3aze9ajPGXmk9qSM0ZPKafIDK4EVK9WAE5yluAG2AXPP2EoRktLvN
         Rb2w==
X-Gm-Message-State: AOJu0YwGEhbvyVgoJU4IAfptfC8vae503L+jSVAVmQvT3EZuLUZ5zFPC
	FYgO77NtpsftOdAFUBZVyfvLWVv8SZv2Fj5REMhcgIo6SapOnlWc6bDTrPFb928=
X-Gm-Gg: ASbGncsXZ/NjoarYSSNJmEiS7nu8AcITjAb7duy68PIxKrjBABcK5rWWYdwqESAou5j
	eJ4Idfcz5Q45epUo+s1cH7CP1/8PfYg6o0xrrMtoEf0P5kPVTY6S66dSGs+ySVjF07oS8+T/bgQ
	EOUAutZfAeJOxvXDXrUlJTjiYM/sdfp07blCon1xqHYJsW9UMsIbBEmBlrrn4+/i2qlyXTWvkkg
	XbdBinL0b/oWfCiCjCUr3uVZC5paDU9YHQp7IY7QoQ15J9iuZS5ZsOvyP8oAnF7w1sts0I80mWF
	SlVUbkXEH+8qQtqih4QjRGeMenne1JkMiX/NmZ1sFwfaG790+Ory7Oiwb0g=
X-Google-Smtp-Source: AGHT+IH8lIwCquZ3x8twjDlLrk5VOW4PH8Mwi0Py5RmPDbQcRRaTguKXREVGfgIVQhgZwE6E3UO78A==
X-Received: by 2002:a05:6000:1847:b0:39c:1424:1cb3 with SMTP id ffacd0b85a97d-39ee27374f5mr172133f8f.5.1744735312552;
        Tue, 15 Apr 2025 09:41:52 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db0dsm220067355e9.7.2025.04.15.09.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 09:41:52 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:41:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFG] sfc: nvlog and devlink health
Message-ID: <e3acvyonpwd6eejk6ka2vmkorggtnohc6vfagzix5xkx4jru6o@kf3q3hvasgtx>
References: <7ec94666-791a-39b2-fffd-eed8b23a869a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ec94666-791a-39b2-fffd-eed8b23a869a@gmail.com>

Tue, Apr 15, 2025 at 04:51:39PM +0200, ecree.xilinx@gmail.com wrote:
>Solarflare NICs have a flash partition to which the MCPU logs various
> errors, warnings, and other diagnostic info.  We want to expose this
> 'nvlog' data, and the best fit we've found so far is devlink health.
>Reading it is simple enough — plan is to have a reporter whose diagnose
> method reads the partition and returns the contents (could potentially
> use dump instead but the extra layer of triggering and saving seems
> unnecessary).
>The problem is how to clear it (since it fills up after comparatively
> few boots, so when debugging field issues you'll usually need to clear
> it first and then reproduce the issue).
> DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR is no use here, because it only
> clears the kernel-saved copy; it doesn't call any driver method.

Can't it be extended to actually call an optional driver method?
That would sound fine to me and will solve your problem.


>The code we've developed internally, that I'm now preparing to submit
> upstream, handles this by having *two* reporters, 'nvlog' and
> 'nvlog-clear'; both read the flash in their diagnose method but
> nvlog-clear additionally clears it afterwards.  It works, but it
> doesn't feel very clean.
>Is this approach acceptable?  Is there a better way?
>
>-ed
>

