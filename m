Return-Path: <netdev+bounces-79807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4487B970
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3019C282AC7
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CC6BB45;
	Thu, 14 Mar 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="L0W9h3LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410E6BB44
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405779; cv=none; b=MP5Ip/TcsT4gBeI18uF+K/1aOXcULc+6kcgR6Q8l3w9BVG5zPP9T3o/O0ouRLlFGnWP1x62wXUgqsKh/+1wYYiDYZguXv28tjVbBnmPGltLkwaqrIWQgeU7SivJU6u0xKCs0a4pm5bHZ5Ppy8CCloq8l80ao7doiQxa9V2snuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405779; c=relaxed/simple;
	bh=5Qy7A+3yh/jxzhgiI9waCD4izE6h56xvnNMXv5MW2Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF0tpJDQPaflWoeIJHAD4EH5kVONo7ajC709SIRk/a0PLfCZZw3JxWeOi1rniXnAc8d3XWxWIlSe8HH3bioulkgDs715UHzNfb4Cd2haw6LW0hGdN6QDd05STymsRGwl5f2nLzRRK3SS0i8EWu12lutckN66Mhxvm7YqW7h3yCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=L0W9h3LX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so89284766b.0
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710405776; x=1711010576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUGWohgtqFW6KZor37VjPpP8lG9O6dkSe/Pklw0cTyw=;
        b=L0W9h3LXhrekCIA84KnaOwW5F4lE7h2NJ7C7Ea9PWYflKWvd8e2qL69C1CawKcT+zW
         RTQjf4hGVtBfsvbU0pjKIang2HUUq4Eltudbb+tBFY+ojPj0J0gsfbhjrtd6bAj3pS1x
         ly6fnFLcYMkIIp7T5rVQeoguqbSJqZQPpHFC4Rd12ytCqu5+JdV4uGTWdZYubS1HqECM
         lpGZw/AjX33PYCAwaVlzZJX0zsC0H5vdJGQB8Yu6OZlgJ/ynbLtiEAOzUZdrOA7hOSWr
         veLP6LbAsPzD+Q+6O0nHua9sXuMVHLgnWIKlnkDC0TpPHFbAdbuttfMKQJTMnB6kU5Hu
         d2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710405776; x=1711010576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUGWohgtqFW6KZor37VjPpP8lG9O6dkSe/Pklw0cTyw=;
        b=jWaRMd04Z2qUxLpLc+iMaYSwDf4W23XK30+YY7It+MjOzqWxjvfisEYKXC/HNbRDMW
         Ium0/ef2k9lvm8/TRA7uyZZF1Y1sf+7BAWiP2dNINcJsTuRxL5kaueYL7A+f8h3vZQ+l
         wLjTV05b//Qb6w7YCObUfvDNC6GA814PZyXabj/FNXH9Y9KAKhK9XaYBpNE6/LNM7izN
         Fv6NHGfdiaBFPO0TRVVO27wh3TBjff23NWR3O3jMBPntc0XeaqY/ybtMGQxrzQvJ7i/o
         tLlNnyQ5BSNHQQqS2/5a3NJyDx6SDh/uCFAfyOo/c412zG/hCo1ee5C0cgu0gcafccpl
         HXqg==
X-Gm-Message-State: AOJu0Yzd95Ovr9G+5MCPRXXDwpt7BRZuiGIkc2ZyGKGEoTMGbAUcy7ie
	E0LHBH0rnR7+4j/tcPqZkGy8Fxm9zSK+f0mF5jZ1XN2sTaorqdQtVkZgptZLzOw=
X-Google-Smtp-Source: AGHT+IGttEkLQqtfi68Ei/o0QxqRMpSTNkML0l1pApWsLGsz6Q4bBeChny5p6LkBXe0qlDjiBHBvDQ==
X-Received: by 2002:a17:907:c205:b0:a3d:ed30:11c8 with SMTP id ti5-20020a170907c20500b00a3ded3011c8mr825202ejc.15.1710405775338;
        Thu, 14 Mar 2024 01:42:55 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906051600b00a441a7a75b5sm476218eja.209.2024.03.14.01.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:42:54 -0700 (PDT)
Date: Thu, 14 Mar 2024 09:42:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <ZfK4jdJCyVzKLTq4@nanopsycho>
References: <20240306120739.1447621-1-jiri@resnulli.us>
 <ZeiK7gDRUZYA8378@nanopsycho>
 <20240306073419.4557bd37@kernel.org>
 <20240313072608.1dc45382@kernel.org>
 <ZfG_C6wi4EeBj9l3@nanopsycho>
 <20240313083111.4591590d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313083111.4591590d@kernel.org>

Wed, Mar 13, 2024 at 04:31:11PM CET, kuba@kernel.org wrote:
>On Wed, 13 Mar 2024 15:58:19 +0100 Jiri Pirko wrote:
>> >> I think I have his private email, let me follow up off list and either
>> >> put his @intel.com address in the mailmap or the ignore list.  
>> >
>> >Hi Jiri! Do you still want to add him to the ignore list?  
>> 
>> If we are going to start to use .get_maintainer.ignore for this purpose,
>> yes please. Should I send the patch? net-next is closed anyway...
>
>With the current tooling I think it's the best we can do.
>If someone disagrees let them shout at us.
>And we'll shout back that LF should take care of creating
>appropriate tooling.
>But shouting seems unlikely, I sent a patch to add Jeff K 
>and nobody batted an eyelid so far.
>
>Send it for net, it's like a MAINTAINERS update.

Interesting, his email gets no longer returned by get_maintainers.
perhaps there is some timeout there (I was looking but got a bit
Perlsick :)

