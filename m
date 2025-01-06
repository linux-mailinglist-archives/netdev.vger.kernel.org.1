Return-Path: <netdev+bounces-155325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD98A01E50
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 04:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5594188506C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185719E7EB;
	Mon,  6 Jan 2025 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/AJ3eFm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995C78F52
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736135186; cv=none; b=sxx59deQxI0jsLRRYzWEextaTkeTN2PovtGG8/ZeDz3Ol3X4+ErDy/jNSHQCr4HhMsy51ReIJEu9FwWT6oq14HW+YNjISvZa/7KJY5QkCb02Jqaz79OapGWxoAWbGaBfmrjC6jnCRljHYL8ScEeKUNbJqwn6DkcYjdLCH8qe4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736135186; c=relaxed/simple;
	bh=ZGROLLPAtLEa1xGWUpWdXLOfg2bnDIz0Grkkn1pV+d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuKG1msitcmV/sr4NhtR7nQRgiaelL67NY8QIIMcz+zI4tUkimZwz9zKHGwxDDb9+y1vdbzuW20vPpBhI9YsrjYkxfp0DoP4iSaDqN3qHmakv6LTzCKhV4FZIWQavamIIy0GRKxES/J3RSKrf3kWyh8gMV8ie21L/cZ0cRiXWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/AJ3eFm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso195282575ad.0
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736135184; x=1736739984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpiiYSzmjVDZUL52FduhMHU9Nr2Bsb8xkty6pYx347o=;
        b=J/AJ3eFmpxYZhWucAZrXBRlV1aBilz5QkVJSSSPEx7poIm1lh25NsfwctwS0XVwz8p
         ssOC6fjFWpSOoneZsySoWg8aTtKIu3d3paQ/oXhMAJFzbmWdiPnXbwLe3myAWesTGOS1
         q9AXIBgleKIQcnxvvjxoZ5oL12x4ZKIXpizMY4qF8j3zChh9tkWcQJl9aPKbntrE+ZS9
         emhd80sXyR5CppxtALiTvZhOw2sHdgZhsWlWnGYVlEkemN/fcBJpZjf9lpAbmDigXX7J
         uuXm5Tajt/htljgLA1dm67nQ791pOZJQDWgkH9jBaSQUILISEgmfkP2KqboUdUo4SuL6
         /bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736135184; x=1736739984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpiiYSzmjVDZUL52FduhMHU9Nr2Bsb8xkty6pYx347o=;
        b=ZLvvNW1DXvMGxVZB18dvD4lPtpbvBsrzSjIUp8Cp+Vl7O8IulZf6x9yAVgy+n+gQyi
         SwUZCPLTkPR3WioBhaX1tCXAACZl4otw83/b3gTT8fGTsnsqZmciXdQ7+pgEuy7/TCaN
         c8OkduaaxW8nIs4AhlVlgKjUInxrhsvW1WGv2i3etKmPsnaPTwiki9vKpIdQWdYSJTsY
         0c/6+pLH/4QxPidqrbpAFP3XirHZvwS6C1ykSxAZ4lwR0kIBf1K/Y0hPeU1QV8ch1HsB
         9TASQSMsHiZ0AMiTQTZ8zjDrIY2/2wtrsSUHgUaYyMQdE0WtoNVjb1mNoqv+iq1r/o65
         3qBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWziYLNBcBsDVFuZAfTGur9j4rh/9JVQcLKtvnigGm1Kh9LVUPa+t+J8dFn1hOjWptz3oLd/+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFf/HnTQv2NcHVw1D+EOdcxaMIQvH88+qZjhhpX0AvKk/7fhKE
	oZYBAitgT22ehKBXx1BGlChDx/6cp6aMfuRQDl1tmQdhxZChLKC3
X-Gm-Gg: ASbGncupfb4TIKK8sMIxBLwwtuNt1YAQ4VnZXIaf2kkfDwP7SMU7k+VeqcGudfuqeDv
	GcGj6swA0PhXVfpaIn3uh4KDTJ7IJp/ivTInnujz78sdhFm1EM/ebTd0UGruFEq87620FaxYw3t
	m0UOa7KeI4jIdPZHh20AruqMYxeSIQu/O76QYdqGpySqEkXlfvdVPVrsROsqMUcBj1LUewbP5DS
	2NCiEvtG+XiFYxcsLdUslvQTctG+OMX75VMr9kCaz7Bll1wniCvqlKvOPMdNw==
X-Google-Smtp-Source: AGHT+IGelsDWaB4ZMpitxztfCsAPvJG/YINFavrv3RDrnTQF5NgClwHSfHW7p43jm3SvMiv/j80aNA==
X-Received: by 2002:a05:6a20:7288:b0:1e1:aa24:2e5c with SMTP id adf61e73a8af0-1e5e083f156mr81786185637.38.1736135183562;
        Sun, 05 Jan 2025 19:46:23 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad83033esm30343144b3a.48.2025.01.05.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 19:46:22 -0800 (PST)
Date: Mon, 6 Jan 2025 03:46:16 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Octavian Purdila <tavip@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] team: prevent adding a device which is already
 a team device lower
Message-ID: <Z3tSCOJH4fQ99cBe@fedora>
References: <20241230205647.1338900-1-tavip@google.com>
 <Z3ZTWxLe5Js1B-zp@fedora>
 <Z3ZUFq7dyiRHrdmi@fedora>
 <CAGWr4cQNhd2UQn33F_JJUE5tFrQgRHe0BZs-kGO4cno4uZ6HnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWr4cQNhd2UQn33F_JJUE5tFrQgRHe0BZs-kGO4cno4uZ6HnA@mail.gmail.com>

On Thu, Jan 02, 2025 at 11:50:25AM -0800, Octavian Purdila wrote:
> > I didn't test, what if enslave veth0 first and then add enslave veth0.1 later.
> >
> 
> Hi Hangbin,
> 
> Thanks for the review!
> 
> I was not able to reproduce the crash with this scenario. I think this
> is because adding veth0.1 does not affect the link state for veth0,
> while in the original scenario bringing up veth0 would also bring up
> veth0.1.
> 
> Regardless, allowing this setup seems risky and syzkaller may find
> other ways to trigger it, so maybe a more generic check like below
> would be better?
> 
>         list_for_each_entry(tmp, &team->port_list, list) {
>                 if (netdev_has_upper_dev(tmp->dev, port_dev) ||
>                         netdev_has_upper_dev(port_dev, tmp->dev)) {
>                         NL_SET_ERR_MSG(extack, "Device is a lower or
> upper of an enslaved device");
>                         netdev_err(dev, "Device %s is a lower or upper
> device of enslaved device %s\n",
>                                    portname, tmp->dev->name);
>                         return -EBUSY;
>                 }
>         }
> 
> Although I am not sure if there are legitimate use-cases that this may restrict?

The logic makes sense to me. Let's see if Jiri has any comments.

Thanks
Hangbin

