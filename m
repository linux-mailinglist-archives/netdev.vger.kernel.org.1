Return-Path: <netdev+bounces-74279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8615D860B42
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259A71F238E9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4412B98;
	Fri, 23 Feb 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LmonniE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B613FFC
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672774; cv=none; b=rjc0cvojpDAoNDIiG78wSQTsGXjdj9n65kO4drSKKA/Pkt+7AbTkbOPPrJ62biRWpjcZ5Xbb/e5Lftm35U6aE5DpEo/ryXYJL00A3D19elbmcR5R7Y8f/MAlgeij2KZKouM96oj5L2QK+uY0dfMokIvOJVmNaG16kBQ1sHe6GZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672774; c=relaxed/simple;
	bh=48wrs8qBiIU8yWIXIMputZVcP04zYCypsbcxPNNm2Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeEIyf4cGBrHHmJ4RiZ7xD0N/nMeIm0nwYf1QIq8gbAdiJoKAH3Ho9IpDdE83plHZECjnclnqUt4IYFw7uRlVv6QfHTG2tmGTtzGJvvx8eMyiMAXKPsaxqEbN05GPMGUWdfICn9C1Ul+NnIenIrqEmv0zzrlwgo6tdqsUcjHrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LmonniE4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d244b28b95so469401fa.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708672771; x=1709277571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=48wrs8qBiIU8yWIXIMputZVcP04zYCypsbcxPNNm2Og=;
        b=LmonniE4p89A7Yrt6XgEeUBtg/nbdGGhDUdpiki/uexwyZDPPI1WgnjlDFB4WVBmp0
         Azl1iH5xXQP/1enUzP/QXCidteEJFab9Jo5slMScw1AR1qAjz4Mt/NHhhcweBVW94GVt
         LmzQvD7L/R6/Dy0C3wDN2Qvpxck+tf4xOYObzM70zXtJ7Ns1EcAGiJT6QLYTUKDbD5UM
         qsqPNglHbvZRStxJMhU3RPgGxq20vrBNrdafZrtS0vAH2GmNEYf0dvZKMPxN+0UQLVqi
         wfNIf1gfCMxuaTlsYq5nwdVLllLIck7NxCfazbaUi7FZ4Q4RatiMzrmUSc8TRitgBMD5
         KTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708672771; x=1709277571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48wrs8qBiIU8yWIXIMputZVcP04zYCypsbcxPNNm2Og=;
        b=JqKD1Ru8p0luLpSyn2UWeodWQlmrL1PaFwBw7Zj6SA7y7QbX3VZg4LbkzF/N1PFsjP
         ieO+gdXc4xlCzZVNkCD9Pu8eqIi1L+wBdnUkdCu3NaS9nrFw14LSR3CaYDUf+eXcrbFP
         IGCqIJT/h+vZM09/9I15V/DtfMg+F7KW74/OO28A5roHfylVBLF+a30Oiws61kxn4oxm
         e3M3++CvoDy8JjPvvcytFEeCkhlE5uSy6y7eSyBlynh0ozY4KptSZlj2Vfgn++g9mYip
         dkJipXl2rWrXVvTR1B0Ofk9VLXQQpnjW5g3YPzdWn7zizsXWlhmDSDovH0PXtWpKu0cD
         9Ckg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/CTgan0Cy0SgPOZ26aYlmbpWNsm9OJvN3SnumFo8852ZJ9DLG87ud9oq2AHPl2G8YNEM/HJCxL8CJTyPYunxAS+kFaKE
X-Gm-Message-State: AOJu0YzSmMI6QDDnJasA5NhYgQW/gfdiArGjCNMAUfsPGO9qarhgof1R
	er+2+phOFAyv9exFKMd2FZUyqHbYtHZ+EV+5UXYrkA3HBo08XFOY2hO9M0tMyoA=
X-Google-Smtp-Source: AGHT+IH92hf04pmTGtj8lOR490glLpS7wLCQbfPSIK2h8HHxJEsfZ3SB5P8kp4cbtLVtscrui2G9kw==
X-Received: by 2002:a2e:9252:0:b0:2d2:3aea:bc78 with SMTP id v18-20020a2e9252000000b002d23aeabc78mr852448ljg.38.1708672770843;
        Thu, 22 Feb 2024 23:19:30 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b004122aba0008sm1248479wmo.11.2024.02.22.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 23:19:30 -0800 (PST)
Date: Fri, 23 Feb 2024 08:19:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 03/14] ipv6: prepare inet6_fill_ifinfo() for
 RCU protection
Message-ID: <ZdhG_xjZwL4PSrIu@nanopsycho>
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-4-edumazet@google.com>
 <Zdd4HbfO2Bn9dfuz@nanopsycho>
 <CANn89iJb0qCSb4oxEngT0Q60cyAGgr7+VOMyG6r82qeqUMdReg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJb0qCSb4oxEngT0Q60cyAGgr7+VOMyG6r82qeqUMdReg@mail.gmail.com>

Thu, Feb 22, 2024 at 05:43:17PM CET, edumazet@google.com wrote:
>On Thu, Feb 22, 2024 at 5:36 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Feb 22, 2024 at 11:50:10AM CET, edumazet@google.com wrote:
>> >We want to use RCU protection instead of RTNL
>>
>> Is this a royal "We"? :)
>>
>>
>> >for inet6_fill_ifinfo().
>>
>> This is a motivation for this patch, not what the patch does.
>>
>> Would it be possible to maintain some sort of culture for the patch
>> descriptions, even of the patches which are small and simple?
>>
>> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>>
>> Your patch descriptions are usually hard to follow for me to understand
>> what the patch does :( Yes, I know you do it "to displease me" as you
>> wrote couple of months ago but maybe think about the others too, also
>> the ones looking in a git log/show and guessing.
>>
>> Don't beat me.
>>
>
>I dunno.
>
>Do I need to explain why we need READ_ONCE()/WRITE_ONCE() on RCU for
>all the patches ?

I don't think so. If the motivation is described in the cover letter
properly, then in the incremental patches you just tell the codebase
what to change clearly, that describes the matter of changes. No
redundancy, clear motivation, clear patch description, easy to
understand for everyone.


>
>Documentation/RCU has already 36000 lines...

