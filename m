Return-Path: <netdev+bounces-73999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811485F972
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5DF1F21D8A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6673812F381;
	Thu, 22 Feb 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YEnmWtse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0644C87
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607859; cv=none; b=EfZ6r96r8YHKGcmsO+6TfwScl1xZXLyHLhPCCnfVZGH0n7nb92qTA1xIIYA7yrgCJH8kgHS5g1QcMBueQCcRyOgGf+q8MRDpIs+EUCDzJ8AsowRqaEar3y6JzbGYGh5Zh4WJD6NIfWUCWoQzAlhr9/f+aoirU1gBLpB4EjhsSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607859; c=relaxed/simple;
	bh=KJ9wDekgYJ3rWp+KkJuwbssTigMt1QYaIyxiccwnmOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP/44htoyRcvL8HgtAj6GlL9lIpcDaigMxKh7MN4t/iljDfHP/zlWIXz4X+XU5shCC3iojdP2PYE/gf62BpYqNrRh0HL4QY9w/MbzpEDt2iXiZMK9WN5/YGKQLZn7nfUJtvX9Ist624+YjaLvE28V3JEVIyLXfPRdmRLMXkvH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YEnmWtse; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0e520362cso79159581fa.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708607856; x=1709212656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyRrraFN7IOnJ6e/togon1KMLq6ddA6cs+A4PIdPyhs=;
        b=YEnmWtseIW57MMoVM2/wRJEZqfNCNa0DFzqYQc1w5Oj3saEzHMMtk2aXaD7YbqITBR
         jQ4aQCj4gbtcgS1j1MygnhaZpWVlYa5biRAW2bKWyYUKF/yd7y6JKXItJuQUSdEAC/nT
         AccwjjEHgXDxkaVsWPwFfx1MH1q8hHlGaGK0Kv2R8AhxKSjaaQX6Lw8re5w74r6ERgz+
         ggUHztpNq0a5aNdZoKoQjLN6QbnrjB8LOzU7LyPhchIVvKP44Mqs5UjZagG/kqeCVp8w
         rQbKTLfXbcXsGY7bolwSplxRc6TwQXt+MfOa5wKlbmLhpaE52w8bVzRNKKB4BaJvCfb2
         VuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708607856; x=1709212656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyRrraFN7IOnJ6e/togon1KMLq6ddA6cs+A4PIdPyhs=;
        b=WYITSA5ze8i5535yyYThorNKNeS3lmVVKZKEAZtUs8npRv83866oDshZTbi7vFMiCV
         y1TMjCUqJXjRRXPdxPm2KisYpX4r9QiquczjA6fY+fBboXE/GrTCgqD3QOQlAY7iXPRX
         cEC6dFOLVG5A4ENZpEIklZstvbtE0bIT+q7BcK6TjbTrS5KLyKVa0278Rv/TAHFS3pc+
         ZVGpiMqv/w+EcBKykJU5etIpex77i2u6DySfBZwJBZmHRoF/02phII9jkn76RKoIPKKf
         Ztu+kjEBrDbkwHG6Jirjd4OhLG5i83zyEqajNjIrtSCzZunk7mOhztXOvFQx6fcOiQ9M
         W9yg==
X-Gm-Message-State: AOJu0Yy5QM30bdEogu2JsPsDi36XEkDL5vnxSyRDHDZcxBSBrfr6OfqR
	+TSsqB/sWqZA01vnF8hu85BMBSaR2q4+BpE3YmRnmY4FxWJnim3m9JfBY4P6H8k=
X-Google-Smtp-Source: AGHT+IGoAUv7lk/gEdMOGlvsrtsDOzrhwRNBg+C/Looof9t+cNnqCWmd2rVh7ny/yZKZPmOYLYtbFw==
X-Received: by 2002:a2e:b6d4:0:b0:2d2:56d8:3dd4 with SMTP id m20-20020a2eb6d4000000b002d256d83dd4mr2959506ljo.23.1708607855629;
        Thu, 22 Feb 2024 05:17:35 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bd8-20020a05600c1f0800b00410b0ce91b1sm1131075wmb.25.2024.02.22.05.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:17:35 -0800 (PST)
Date: Thu, 22 Feb 2024 14:17:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, sdf@google.com, lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: Re: [patch net-next v2 1/3] tools: ynl: allow user to specify flag
 attr with bool values
Message-ID: <ZddJbO095_h-2bn9@nanopsycho>
References: <20240221155415.158174-1-jiri@resnulli.us>
 <20240221155415.158174-2-jiri@resnulli.us>
 <CAD4GDZxn7bq0t59=V7AJ_aFsJNvkdK_CJmnaPV2W_7uiEUozKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4GDZxn7bq0t59=V7AJ_aFsJNvkdK_CJmnaPV2W_7uiEUozKQ@mail.gmail.com>

Wed, Feb 21, 2024 at 07:07:40PM CET, donald.hunter@gmail.com wrote:
>On Wed, 21 Feb 2024 at 15:54, Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> The flag attr presence in Netlink message indicates value "true",
>> if it is missing in the message it means "false".
>>
>> Allow user to specify attrname with value "true"/"false"
>> in json for flag attrs, treat "false" value properly.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - accept other values than "False"
>> ---
>>  tools/net/ynl/lib/ynl.py | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
>> index f45ee5f29bed..4a44840bab68 100644
>> --- a/tools/net/ynl/lib/ynl.py
>> +++ b/tools/net/ynl/lib/ynl.py
>> @@ -459,6 +459,8 @@ class YnlFamily(SpecFamily):
>>                  attr_payload += self._add_attr(attr['nested-attributes'],
>>                                                 subname, subvalue, sub_attrs)
>>          elif attr["type"] == 'flag':
>> +            if not value:
>> +                return b''
>
>Minor nit: It took me a moment to realise that by returning here, this
>skips attribute creation. A comment to this effect would be helpful:
>
># If value is absent or false then skip attribute creation.

Sure, will add.

>
>>              attr_payload = b''
>>          elif attr["type"] == 'string':
>>              attr_payload = str(value).encode('ascii') + b'\x00'
>> --
>> 2.43.2
>>

