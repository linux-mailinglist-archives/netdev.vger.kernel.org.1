Return-Path: <netdev+bounces-70329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF1884E64C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62651C25D65
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83482D8C;
	Thu,  8 Feb 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FQe3jUWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD37EEFA
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411944; cv=none; b=W39w0bPb+9pzLZxVjLAPlYQ69RkNkvTvfewV3bzsUG8MeZ09c/59plulLqv1QNaBc2blzv2tqCpxXevsz9SS0Ol2CXRU4wuA0RL73dluezqjXOaF6+5pUTHxyaCzI5uJJwr1iI5VoCuUsKy8dvJM8PwdOh+fgtsA/tWbyuIaaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411944; c=relaxed/simple;
	bh=OVIDrB6VHgOle7ZfLg0ablrWKeD3aXag6zTPYy2udMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ivbm3lzfR4khmpEEvVVdW2jzdUCiPEXciigmRlJijTfR6AVg4Kvo8YXnierjVnTSISA1zZYRAd/PPdXTyGCEL8KKXbv9fpGP6gQtWHbNfZqK/kg/zH2XdSutZ+SIhaPhqfJCXNYcU2OjL9QcIkOsxE86OUVv4wJ9V8RBO/s20lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FQe3jUWC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93f2c3701so12572335ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707411942; x=1708016742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7P91LhvlJrxhzmsqsboYwMUgYjJnDsvrHFinzVCt7I=;
        b=FQe3jUWCcSo3J/nEzgPyvDTwlybh4g4FO5wCXO95814Hu3ryL4ef0XFxdivF9TkksU
         qX1072MvxMXGRf49TRfY7RTkULro7ZUQ4FXsg2LyjZAJRoVktrdW+3DQ1KwPnlNwEfva
         w4fWAc76Pmjlt3LDBOsb0pId2bEM4waYMpo90Z4SE8nRBswfJLLjnAnD22MrZsRRAbG9
         mqtoDMJVRxy+dTpZTgkTQT5X8fzgAbrTcBnd7AxE8I0+/XRMoDF6rHoBM0IP0qqBpBa9
         oQEvE0CetwlBu7qVh2ive7XfsMHBRAH5m0CG1aHiP3FCdvWFI5CAGtCsLqvWOd93rO01
         6DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411942; x=1708016742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7P91LhvlJrxhzmsqsboYwMUgYjJnDsvrHFinzVCt7I=;
        b=wuyTN36sJHjqi1sPsck7luEVE9I0a/hyJJKazFxNlkeXRc9B13VMtjgYz9ojVxJNOl
         ocwGOqbBLZI3+ZjWhK86/vx1K/1exyXt4G81BLp9a0KkRS1lHVoAsHA2SoxPLb7GVJaD
         qb+j7jggRdZxSifDKKcUVGVZhiHZPVTvn0WqMmi6Ao+y4E1Np+olN+uOk73Z088fpMrl
         lax93CQqCmojzCkIMAsXHF/3jx49BhlFOP8jIIy8NMnJ2xNEa8D64eHORIilYkqu0DoD
         3EtDMsijGIMCQmrylHyNyuYTpjSDctoD3aGiE90N2Oah3bX0NgVezbCUiOUECKW3AZ/T
         eCCA==
X-Gm-Message-State: AOJu0YxsMIo6GmcZsJfLfgIhTl4zRE4BQBfg3eCCycydVHWzsMeUt+DL
	ZKzcXeNutCnTffmi8x47xMOpKyIFu78CVfUMcu7YhHmIM+TsGYhkG5xTmNQBz0A=
X-Google-Smtp-Source: AGHT+IGneor2OC0WMG+qjGBEKQ/U0WS57Dt+HtN+GIOHNDMf9UJ/itWIgwqHz+D7GqZpigPWvV0ecw==
X-Received: by 2002:a17:902:6503:b0:1d9:63d1:e619 with SMTP id b3-20020a170902650300b001d963d1e619mr7913986plk.29.1707411942582;
        Thu, 08 Feb 2024 09:05:42 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id rm14-20020a17090b3ece00b00296c9971348sm1804502pjb.17.2024.02.08.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:05:42 -0800 (PST)
Date: Thu, 8 Feb 2024 09:05:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] m_action: Fix descriptor leak in get_action_kind()
Message-ID: <20240208090540.08537135@hermes.local>
In-Reply-To: <20240207211632.15660-1-maks.mishinFZ@gmail.com>
References: <20240207211632.15660-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 00:16:32 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tc/m_action.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tc/m_action.c b/tc/m_action.c
> index 16474c56..7d18f7fa 100644
> --- a/tc/m_action.c
> +++ b/tc/m_action.c
> @@ -111,6 +111,9 @@ restart_s:
>  
>  	snprintf(buf, sizeof(buf), "%s_action_util", str);
>  	a = dlsym(dlh, buf);
> +	if (dlh != NULL)
> +		dlclose(dlh);
> +
>  	if (a == NULL)
>  		goto noexist;
>  

NAK again, this will break the caching

