Return-Path: <netdev+bounces-132788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353F89932F6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1721282C02
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75E1D9A59;
	Mon,  7 Oct 2024 16:20:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391522086;
	Mon,  7 Oct 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318020; cv=none; b=DUNgzc/5WN/tfd6yCXCnCcBLv18Nb2Spw5otTbOZ2Xg1BNdKZI2m4eJ3Su64EIATb391QYnFtViZkZVP0nwpY8iuc7d7psT7yhAgCormN2fD222dcgX1PMtKek5zWKM5Oze7HynVh0mTCZdb3+672S/ts6bJhs7PL2aC2sJYzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318020; c=relaxed/simple;
	bh=t7vC9PC4zJvaYTiJkSnCHnY2yzJGQXV0UyLw9N2ZBeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHMMIJ7QwKwcF3LR8Uj5IjTV1Ghf+VcLT6lTq53OeLNrdWAtivObjqpoeh7WtWPICglWyYV4b1y13N/n0k84QKNxfI+IawdEDtXUdU7ey4zCGNPFFr/MPY6LPUE242w/3DKyYHSDDgJ8NtVDV9rXBX2E96PX7ktXWe6ccI1cOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so6365024a12.3;
        Mon, 07 Oct 2024 09:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318017; x=1728922817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei8wLpkyvMKcvykxtKriHlZBL1OGliBEE4xkdqzdKZk=;
        b=UoI7WmIwlNIZV9/REgmDtSvykl9waMRlPHq+5Ho8fQY2/73D3WPUxYWx0yyUf5I+ud
         Wr1ggotG2SYS64rY7t6vk+TvQF3+RpIQukXbeuKsJTzBX+ffHQlNBuKegeh8vOy2WFDg
         fPlR9g/GwTysl23HonO3ECmjPvowMBwmY/E3JVxhHpi8OHhqHNcfDR3tKsxRsUNdkZ8f
         poUfvBJ6EQ5CiAboB+/+StpSWfN1k4THUVLvIpS6XTq9LDxhf6kCLPMPY6ga02iW9gEI
         NQmIKXvoW6yGU2TbVkFv1bHZuv/QGjPEtfbkBY21rz5SKrLqDCHyXMLzjJ0EOPhMXXy1
         iAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUxgFT/e/L5SWFr/naFolwN+8Ne8aH0yDgv7ILDC7EKSfryUZkhzXvjQYK0wUMqUY2bUPjR9eJz2/6ecKG3@vger.kernel.org, AJvYcCWQBhd18ezWZ8YBX7zFcoiq4t1QGzBilNnWh5fIIXucbg6cdHMLlmgs/l2tWrWMfbZ9C2onleOE@vger.kernel.org, AJvYcCXp/OX/w9r+PjXoVNBgGV8VhVbqGZVcfuAZZUsTiUwuAE4ynsVoeSrBS3+5t0HydsmuBB5rULrkkX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznG612Kfx6Q3dk6xywZNI5L+4L24Au9Ro6lrzJjI/JTQet8NV6
	RTrvJ3uMol/pNzZ5LAQxk2gLNSI71n2dIC3g41GLCjpUhX1mtLck
X-Google-Smtp-Source: AGHT+IHV9d9KXFM2IJDQlbbS87AXFGLCbkF2x+IJ/RFLoVqbdDta2pCk79gXR46aVX+WwqoK/yrmZQ==
X-Received: by 2002:a05:6402:1d4e:b0:5bf:1bd:adb3 with SMTP id 4fb4d7f45d1cf-5c8d2e5194fmr12906633a12.14.1728318017484;
        Mon, 07 Oct 2024 09:20:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f395esm3333118a12.84.2024.10.07.09.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:20:17 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:20:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Jonathan Corbet <corbet@lwn.net>,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241007-flat-steel-cuscus-9bffda@leitao>
References: <20241002113316.2527669-1-leitao@debian.org>
 <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>

On Sat, Oct 05, 2024 at 01:38:59PM +0900, Akinobu Mita wrote:
> 2024年10月2日(水) 20:37 Breno Leitao <leitao@debian.org>:
> >
> > Introduce a fault injection mechanism to force skb reallocation. The
> > primary goal is to catch bugs related to pointer invalidation after
> > potential skb reallocation.
> >
> > The fault injection mechanism aims to identify scenarios where callers
> > retain pointers to various headers in the skb but fail to reload these
> > pointers after calling a function that may reallocate the data. This
> > type of bug can lead to memory corruption or crashes if the old,
> > now-invalid pointers are used.
> >
> > By forcing reallocation through fault injection, we can stress-test code
> > paths and ensure proper pointer management after potential skb
> > reallocations.
> >
> > Add a hook for fault injection in the following functions:
> >
> >  * pskb_trim_rcsum()
> >  * pskb_may_pull_reason()
> >  * pskb_trim()
> >
> > As the other fault injection mechanism, protect it under a debug Kconfig
> > called CONFIG_FAIL_SKB_FORCE_REALLOC.
> >
> > This patch was *heavily* inspired by Jakub's proposal from:
> > https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
> >
> > CC: Akinobu Mita <akinobu.mita@gmail.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> This new addition seems sensible.  It might be more useful to have a filter
> that allows you to specify things like protocol family.

I think it might make more sense to be network interface specific. For
instance, only fault inject in interface `ethx`.

Let me spend some time and have this done.

Thanks for the feedback.
--breno

