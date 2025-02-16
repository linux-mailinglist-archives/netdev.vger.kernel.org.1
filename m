Return-Path: <netdev+bounces-166785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43883A374E9
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7978168F23
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9C7156F57;
	Sun, 16 Feb 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwREtN0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B512904
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718418; cv=none; b=k5s4m7RERKt/Ba2RSFBPK6zNsRlkotxJUhpBJEfzxGG2VD2kFVAbPn5o7Pu97U3IinpIZAGHUveqIRNX86T9xhOcYjV4HXsHZVKgJUWtSej7x0Z3AiQeKRrc9GeTfrfNTPU41180NSMaHgcVtMiTKXxRKpHJXPd9Kc3lo5b+rQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718418; c=relaxed/simple;
	bh=nxw8Nev6SqEYpTxQ8uBuOeCoWM3WvUQB7H/MC5U99kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZsHl1cHqs38nlLN+E4g25UDfR1aHUUoiLY6HkaVLLPkT8X+9vOsr6C4MQv82/CtfIjTtZDF/DNF/C58gZNF3fnqyVVIGzj64R2F1dj/URhSugjEr+hyejJnRNH+HWdfogjW1sttuX+jyycl7WF3zyKTfHvvLYNUYQCDKLyAZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwREtN0j; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so194737066b.1
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 07:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739718413; x=1740323213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2BVLff+bH8ac9wbzIHLSzMyCaDJG+zXJr3g0suTDBA=;
        b=iwREtN0jBddmSwT4SoAFokSsVUDczSQoi6faA/dM10kLt0CzFIRD+l1dWB7KU0XxzM
         syiiFBC4MiO9m9sFIbmE+foK3N78b+EjOCzxM+p1A6rkKtCiNaqlCaAPRiZGkk0+g0Ur
         eRG/RCb/1hLGsxhuqiwL3eiFoKXYOOu70rnoDgbbSMN6tHlT4E/4LPsaV7pgMgdAAIQY
         tH/DEyQ96WXU2zHxy8nIaCWhswdScIyYi1+D7BlCYQ2uiep4/Uh+v3LR6vptAkFFvtnP
         b/mk3qSU7f9f9S4BqzwXcm1dNGTyrz3bgOYRc3fEh1TzDG/gkNOXFyDsbEgr8JdZDBAq
         bK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718413; x=1740323213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2BVLff+bH8ac9wbzIHLSzMyCaDJG+zXJr3g0suTDBA=;
        b=lEsZc5VK5Af6RNFjgZfWD1Ndtyf5i+ezbnpX4g53oEIk4unQGtUU5S9UhP49bZtRVD
         Coa4/2uC9A9zK8x9G9xB+XWc5eQJ18D1I2dzXgeNGMF9ksnDLMPZm4mwylLjxMa0uR1p
         fMLk3X7bjx0AB13/4F0g0xEIjrWNxoW/DmVYplZWgoOx60Hd+VIXLjermcQnTR6ocSl2
         gvEMnQ+QveyI2ynt8L3zuDPbmQ70oaSecfFoLvj/azFTQyanHBWkyTMxkmQi20YBj8u7
         5ZXzPI0XudyDuC6VNLGitb/dEsuu0Eks6C0bS+SSmxsPscJA01r9HeOEIF8dqjbRcUm2
         l2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX8SZKVb22p8LShTYTWNJAucrgXd91+GUx9Y4czI0egKZlh5MrBrCi+/IQOeebHYtI2GweJ/Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpzktpQiGUDJWnegB5WHdItaFQsDykIRmAWnSuICBc/FUaD59
	LbjFNEJDGkfILEeujgHIW/VzpWCS8RFg9we9fhXf5Yax5+3ueA0P8gHmyyCs2Cs=
X-Gm-Gg: ASbGncsw4dac0UQtGwx4HPFsbrRCicPRbh/K609bMzse2K+9UfIH9x812vr0lkCDyA1
	DaRODwLpowy6DPFSG+QLRxGc99uEwmI91XLQWHmTNeb/mwEIDBJjHgq140o1E9tPg9XUgZndUB9
	bIamyNF6umZTt+orF0YWqrZhgOlzyvKkv8fWApxhxQLwqomoumPi9z+Alsdo07qK0+IUoZgiRKb
	SSSqsd59UIbxXWHU78FQB9ErhAUkzdBX6NgKCWuvVLgOgCnQO7IKRtxuUCBx5onlfiXkgI1irBW
	d719pYKbNRT528I0iqsr
X-Google-Smtp-Source: AGHT+IEjA8dBmVjqLtOxUvCyJ5+C3X850rmK5fS/NUpiGnloFuDE97wDeIc/uZbNo2FaFL28KFTb3Q==
X-Received: by 2002:a17:906:7312:b0:ab7:bcf1:264 with SMTP id a640c23a62f3a-abb70a7a559mr730846866b.5.1739718412531;
        Sun, 16 Feb 2025 07:06:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb961594absm86470166b.111.2025.02.16.07.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 07:06:52 -0800 (PST)
Date: Sun, 16 Feb 2025 18:06:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <64053332-cee0-49d8-a3ae-9ec0809882c0@stanley.mountain>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>

On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > devlink_rel_alloc().
> 
> If the same bug exists twice it might exist more times. Did you find
> this instance by searching the whole tree? Or just networking?
> 
> This is also something which would be good to have the static
> analysers check for. I wounder if smatch can check this?

That's a great idea, thanks!  I'll try a couple experiments and see what
works tomorrow.  I've add these lines to check_zero_to_err_ptr.c

   183          max = rl_max(estate_rl(sm->state));
   184          if (max.value > 0 && !sval_is_a_max(max))
   185                  sm_warning("passing non-max range '%s' to '%s'", sm->state->name, fn);
   186  

I'm hoping this one works.  It complains about any positive returns
except for when the return is "some non-zero value".

   194                  if (estate_get_single_value(tmp->state, &sval) &&
   195                      (sval.value < -4096 || sval.value > 0)) {
   196                          sm_warning("passing invalid error code %lld to '%s'", sval.value, fn);
   197                          return;
   198                  }

This one might miss some bugs but it should catch most stuff and have few
false positives.  Both of them work on this example.

net/devlink/core.c:122 devlink_rel_alloc() warn: passing non-max range '(-4095)-(-1),1' to 'ERR_PTR'
net/devlink/core.c:122 devlink_rel_alloc() warn: passing invalid error code 1 to 'ERR_PTR'

regards,
dan carpenter


