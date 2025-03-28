Return-Path: <netdev+bounces-178128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB5A74D4C
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898A3189A203
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1D1BBBD4;
	Fri, 28 Mar 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqlu25Bl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF715CD52
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174216; cv=none; b=dk6K2DnpuIWoh4ZLeTBCzbxLXhjQvksZFlOuy8umubVQA4R005wVn8QmflYlCsEkHTxbGwICupGE/NjAVIBAvC09CkyJ1mReHwJo/01fknWGOGflJ6tKjbKSaSLRVR3DU3Mx6fei6NPoWVQiMRb0AQXeC+/E69MHzdZhjJawGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174216; c=relaxed/simple;
	bh=aiGA8/dpAkmsgxCaA6/Lm9OTHInyqcTE4PqvP/rYgXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJMoRjSziTQHMzylDxp0Yf/fhP8Y0hP3mmHoeXvp6cfhkXlOoI5kV5d2DV1itXsySOhaFp8l98bS1gPn1f8aYCJjiHawBHhT8M9pxIG78zWtfpFgTRY9BLdH4nS/EquIr40JYWaCjiPum5oalqUz0LzfhFUZxJwEvYGBHdG9N+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqlu25Bl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso45685785ad.2
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174214; x=1743779014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ55D7S4vOoFxo3VI4sgduugqtRKY14jSAb6mHya/2I=;
        b=Rqlu25BlXkerKt1SZOAHN68ZwOMscmYor4aDaEJnsHnzWdJ7319NRX2x93I8pOuxoB
         +PY40/Q/L0Z0zcfFuK0e5imnXxq4oETAnkYj1tkL+IwybIawDvGLGxMn3kBghBnRbWPM
         ABtzjQBImYpMs6mSTlbSCOEt4gkBRFl0+EWZnMucxEd3rIqyeu1QeMzW+VZWbc/2wor3
         IdnDvbdpe4kZtfhfRMwZhII6KzeR1DMJUUddvrRVgNonvKFYbvl2RxfoWz1eRYsCk8/V
         OX2kms4Bh4asobNJoCmFqt+QwWvAEedatImg6rZk1OvK46WlIfDlxHBUPgBxfmk0nBG7
         6tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174214; x=1743779014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ55D7S4vOoFxo3VI4sgduugqtRKY14jSAb6mHya/2I=;
        b=n7gc1gblvFUbd8GyvJIHMf3CpIyoIHjY0f59OEYZzbSi0Io5pXsuSv5scOrz/yYGe3
         E8tIOD1Je5v25KuhzDMxZWXypDjLK0T9BJG6xLEG27eQjkF5VD+hTEKd7xu6GdVsvTTK
         d+18rDLpER0t2kJoyW7UautRfTQ4AYW023wsT9LhzJ51GEjPY0B/j/4VQt8UrtQYbffU
         qLbkL/yhb9pt53a6Dt0nigrLaruUFdZcjSC6e4OI212KkIcU8r6JV8cYl0B0CQXNR+JH
         6qm/bIBjAjitU08VOM3kqQP3W0UuV/MnCB6Qd3YuOQeHZriLx2h8ECsOTBwF8XakFe3Y
         pnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2xv3QF3U4//fWdJcGUGCDxoT1GfY/zHSJf2RtjQt8acMMAv3BbO9hF4PPzAoIzq55gV/fmGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9+k9Gxm52INS5jsh1Jh+6+09p0rUW2Z3hHyBFUuvqDMkz0V3
	MKxYw0K0aGxsbd7cfwldHE3xEcUs1puAvkZ0jld1yzERucssPjg=
X-Gm-Gg: ASbGncvwCZ5Z2p4+vV2YFNDXNvjYzzgoccLRP8f6Ht4nl+p0UrRtzdtpvyZuURD4VJ7
	f9SiC12YzkpVytoi+YRBZbAwd0gDfrBKRJnsPBIftrAK5I9W3jlC3zMaKYU5WabCbr3fqqA7bpY
	aGWKzEMqYmFEXY5eSEtbnYY6zPgKyEdfSfEttf/OB59jv8E4dryDFuBQ+I+IhjGJby8+HG70LyG
	WP0R6raycMc/vLBlQD9xKAwaHLlvYvU+7qwLAqb3DeZWiiEYohJfFByA5575y34m1TtGRd/RmWr
	TPrp3ft2J7koDlt7YwguRYJJqDnAJ4bnt40x1P42O5EY
X-Google-Smtp-Source: AGHT+IFoQq/DXd5cn6725qnrkfynaolifBJ8Gm1R4IGtrfmOMKTHHGQ0g7ZyrXd4ESXpdSRGGDhS0Q==
X-Received: by 2002:a17:902:e786:b0:220:e63c:5aff with SMTP id d9443c01a7336-2280491c3c7mr100035105ad.47.1743174213903;
        Fri, 28 Mar 2025 08:03:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec71dbsm19170705ad.1.2025.03.28.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:03:33 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:03:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 08/11] docs: net: document netdev notifier
 expectations
Message-ID: <Z-a6RCuLQsEVBQuf@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-9-sdf@fomichev.me>
 <20250327121613.4d4f36ea@kernel.org>
 <20250327123403.6147088d@kernel.org>
 <Z-W7nfFdv8u-SZTY@mini-arch>
 <20250327145043.0d852f86@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327145043.0d852f86@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 13:57:01 -0700 Stanislav Fomichev wrote:
> > That sounds very sensible, let me try it out and run the tests.
> > I'll have to drop the lock twice, once for NETDEV_UNREGISTER
> > and another time for move_netdevice_notifiers_dev_net, but since
> > the device is unlisted, nothing should touch it (in theory)?
> 
> Yup, and/or we can adjust if we find a reason to, I don't think 
> the ordering of the actions in netns changes is precisely intentional.
> 
> > netif_change_net_namespace is already the first thing that happens
> > in do_setlink, so I won't be converting it to dev_xxx (lmk if I
> > miss something here).
> 
> I thought you could move it outside the lock in do_setlink() 
> and have [netif -> dev]_change_net_namespace take the lock.
> Dropping and taking the lock in a callee is a bit bad, so
> I'd prefer if the netif_ / "I want to switch netns but I'm already
> holding the lock" version of _change_net_namespace didn't exist 
> at all.

Looks like I also accidentally killed extack argument of
netif_change_net_namespace (by always passing NULL). Will bring
__dev_change_net_namespace, with proper locking and extack and will
call it before grabbing a lock in the do_setlink as you suggest (with
proper locking inside).

