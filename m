Return-Path: <netdev+bounces-136078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 189949A040E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7D5B26BF0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613B1BBBC8;
	Wed, 16 Oct 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NG+/G/df"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EED1AF0AE
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066804; cv=none; b=mzF/KbdjcFerwz3w+tk6BlIX84oLRwWMYeva7eeOXEkYRur9Ag6ciezkHEKpdKNDdXeavB/boJbQS8FovXmAwe11xoVFxZhpcXlzgpR67sukZHWJPd25bnozAIkb+7ewbcOttSrPy4TEr0a1vQJciiEYnHA5cymMU4PLZlbI74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066804; c=relaxed/simple;
	bh=iD64WwwoqP32NeNQWXSY/4BTHt4rpI+w1EL7TUpEpVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmjvOkQPJ718D1cZNiYAbrcU9ujJMUszyt/qDCmEam1rXZrjwB/rqDHPyn9W3IlaKWM6HIMo0dkOxEhLZ97FthuN3QXRQNQOqC+R7mcT9C9wwrMdfAQRL14E6Nfcr1hX2LjTskzsQb2pOB6XeAk1YewYGljAtzngS55GCuYQVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NG+/G/df; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431137d12a5so59137525e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729066801; x=1729671601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNwkhSu26yuFIiMcBWeKleKwB7IDGfVFlS7NbT9YrDc=;
        b=NG+/G/dfg9USQve2N6gqeCblOs7ghvJdje8qVim0vlHHjKs3QNHhLo9wWHKDiWbL3/
         OyH1yJATbrSP0We4EcmSP/zUamKBRlEyYEUFx1B+5PhHOxqRcCoDYzroj/MeWf7zd7Z2
         zKqtc+2KcaM7Om7OcojgmWhpzU6uVF4HaXzDHKunXJmq5fAsyeWpnUsOgwjdutfVapk8
         UsixKK1Cgb6YqvO/We6YXLOdCHfcM/sf9NcHY/AiSumWWK9b2pD6d2XSWYOxEiUCbSji
         Yg3Ar4hhTUJnUFsMwaG6cR0Dv7OG0OgOnPLbn7GDviMsZf+0d1SwwbQQ6Zvvj86QZbIZ
         Hnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066801; x=1729671601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNwkhSu26yuFIiMcBWeKleKwB7IDGfVFlS7NbT9YrDc=;
        b=uuGkuhhdRHMldcVNj/otDCZsCSk4YSGLFQdJlGvRtGCI6OM8IVuborIFC7wY8p2ZPm
         dYb/7roE2IidBa9J0/7tGW09B20AYpefXlUl+VYxiW8je+Q9s9WjEwfLIOoUewy5qSjf
         F92zPqHT0LtHIzfKXd1b12ke4HM0JM+s3pZefO685n28cnJmVbP/zXt74tkeEGjfAG0M
         EsnRaAK7B+/QW9Tx+dGkCpdoFS0fArizQU0zfHijDNMCiRIzSTrc5hpvKX+AOnCB5aXA
         1DS8hxq6Bu1IAqzkJm7GgqghvEACR7mbcu5fyqwq4WWIKrytOj43S31zgGVxyNJdi9Lt
         3E1A==
X-Gm-Message-State: AOJu0YwI23HeeDWce58jNRuGxjsemg0A4UjvpneHL3Gjov6E4AdCMriT
	rS5nj2wXXPqz6vTzmfZZd3yDeJ79cf+DIAFE8MCdDJnsyJZwXvYcQcFOJprlRNA=
X-Google-Smtp-Source: AGHT+IFqZ82/qoO2XH6nq1UL5tSHMOpFncXsj7yax1WPlXGxXRcT12hzBUaKix0arPBOHJOcTLsB0g==
X-Received: by 2002:a5d:574e:0:b0:37d:518f:995d with SMTP id ffacd0b85a97d-37d552d92c7mr11550064f8f.56.1729066801035;
        Wed, 16 Oct 2024 01:20:01 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa882acsm3671133f8f.38.2024.10.16.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:20:00 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:19:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <Zw93LS5X5PXXgb8-@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
 <20241015080108.7ea119a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015080108.7ea119a6@kernel.org>

Tue, Oct 15, 2024 at 05:01:08PM CEST, kuba@kernel.org wrote:
>On Tue, 15 Oct 2024 16:38:52 +0200 Jiri Pirko wrote:
>> Tue, Oct 15, 2024 at 04:26:38PM CEST, kuba@kernel.org wrote:
>> >On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:  
>> >> +    type: enum
>> >> +    name: clock-quality-level
>> >> +    doc: |
>> >> +      level of quality of a clock device. This mainly applies when
>> >> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>> >> +      The current list is defined according to the table 11-7 contained
>> >> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>> >> +      by other ITU-T defined clock qualities, or different ones defined
>> >> +      by another standardization body (for those, please use
>> >> +      different prefix).  
>> >
>> >uAPI extensibility aside - doesn't this belong to clock info?
>> >I'm slightly worried we're stuffing this attr into DPLL because
>> >we have netlink for DPLL but no good way to extend clock info.  
>> 
>> Not sure what do you mean by "clock info". Dpll device and clock is kind
>> of the same thing. The dpll device is identified by clock-id. I see no
>> other attributes on the way this direction to more extend dpll attr
>> namespace.
>
>I'm not an expert but I think the standard definition of a DPLL
>does not include a built-in oscillator, if that's what you mean.

Okay. Then the clock-id we have also does not make much sense.
Anyway, what is your desire exactly? Do you want to have a nest attr
clock-info to contain this quality-level attr? Or something else?


>
>> >> +    entries:
>> >> +      -
>> >> +        name: itu-opt1-prc
>> >> +        value: 1
>> >> +      -
>> >> +        name: itu-opt1-ssu-a
>> >> +      -
>> >> +        name: itu-opt1-ssu-b
>> >> +      -
>> >> +        name: itu-opt1-eec1
>> >> +      -
>> >> +        name: itu-opt1-prtc
>> >> +      -
>> >> +        name: itu-opt1-eprtc
>> >> +      -
>> >> +        name: itu-opt1-eeec
>> >> +      -
>> >> +        name: itu-opt1-eprc
>> >> +    render-max: true  
>> >
>> >Why render max? Just to align with other unnecessary max defines in
>> >the file?  
>> 
>> Yeah, why not?
>
>If it wasn't pointless it would be the default for our code gen.
>Please remove it unless you can point at some code that will likely
>need it. We can always add it later, we can't remove it.

Ok


