Return-Path: <netdev+bounces-187749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65EAA96F3
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0077A3B3EDC
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480F202F9A;
	Mon,  5 May 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8RPk7yW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417717B425
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457627; cv=none; b=mdG+cZF4N/ogkBm/VSviJhwQcOUXs9J9mX0iw/il+JULeHYlcFS3a1CPxy/Fucck/Vyhp5XfwmFksncFRFzoAQxLbEyJ0DiEp0kjE/GRT26jJhv/g4yF4OOBfp9lk3pAW/M9T63979sTUh4CvGdkg6xW1Bax+PmSA3jPG20jycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457627; c=relaxed/simple;
	bh=Dbg/Fa0HDK1ILZBNN5MQHFENmCrUlpwdSF4pSvsoKtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLHk6ap8esCZ6nvEi7xJuQbl0c0XqNIgO+hVj58kzB1JaaoLu/nE4sqfUss9M+1EAswgAvfv2mepj7qea4JoPm+1yAIJQFePY1WGvh88B2KCdOpcTZkJ6jClYD+TLHcvBUqKuC0CRHErKdr6+s2ELGbr50+o2/fB+umrUII/AUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8RPk7yW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2254e0b4b79so67610635ad.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746457625; x=1747062425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRTVa7w1pKrjyFRByPk5rdwoOGs5IlgoC5vaLNgttwE=;
        b=e8RPk7yW4dribFSCbxGaZa9bKQC/1MrCKytiSvBP1Qz1nj+PJxUdhjutkOvBXL0XjV
         XJnPRz9vJMZt6btjhxxISbIeIx7BjS5nIj3yI+GJDT96gcCl46yjdcbIPesE296BAG3s
         z5WDKmhOgKZB2ZOttGhiTpsy/ESjdmOTlLVIKN/liTwmyZde10E+KoeOOZK9i1y7e1+8
         oZCYWQ0cBaSFnERfelvJ0nY32/gYbvstfHs50yUixWMA63nLlTnX399BQmlD6/nb7DKh
         jOaDRAvebt9Bi9T1vwi/YLaeARlrGGQnLAe3SIsqh9yEIsgNsdr2M7QrWotmYEtOu4MO
         RVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457625; x=1747062425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRTVa7w1pKrjyFRByPk5rdwoOGs5IlgoC5vaLNgttwE=;
        b=mmUtOwspKSw2GngObNjjdlQBc+t+L+KPpB9fNK+Pi3NtDehhJkPJadaOEjDGqvbQ5L
         7tdK49x14UH44rb/Yvcj7fmwg4+SbCgVk8YSzuXa0S4QfnXrihFd+7N1pUccVNIwW8QV
         9o2s3soO1GfuGrNWlti3VWZOcTjJi34Cx0o/V5s4Gavimrxs8l9TPMgPF+pgwOfOz+9a
         JfonHYxEA9fxQiOJMB88eMx2mIZGSbXJw7rogcr3OUCDDW0htCjHQZgvFj1ig1hdhnLE
         WjgEzGOUItYE+82IUL2x1PPevXC9vHoXEjA8rmMRqtDvbMWklEyZDeJ/4uGTjSnjgVhQ
         uOLA==
X-Gm-Message-State: AOJu0YxBn+/s+MeWfyhum/U0U7f3+uv/+onLHnHVf2wVLDk5uE9rg7Hi
	DTgqOYfvTZ5bNslNajaO057ktvTZ6m1XCzbWE6ZXiXwX3ewB7pFpIQ+C
X-Gm-Gg: ASbGncseTJ6gESdrhJfKiJfKnCZB4Zjb3V1madkYlyjfkTtIhrsSRLG4XnP7sbXAqmc
	GiO6YZTPDjLbn5aguXLVXExOJ3ggDYZPCY+jdbIe3KBYNPOmXdpDLRY0d7CpRB+YQTYPZ+vh8Br
	Q7mCf0mhSc5sXue3g7eLYoPJx89u1qotuWG84Y9QyrkoXGj12kbalfkYavHpndN1I8/3IXsMD/0
	zJCXvAF2GQiFae9JtKjnt/11nF0CcxPi+09cqhSoF7augzEgb80Cw95KvPV2k5ylJ+Q2Lt+4yUj
	1Sn5B/crtvFDEsOaZMajYj+VLx4ac85s9DfH5jNnLdbGWGaPytFiua9pHfHspS0Z5+alr9+1sow
	=
X-Google-Smtp-Source: AGHT+IGhyZQoTbMdCKNew98+MH67EJsh+k+eZ0Gi/kfOKNyM0eTj3oyz0DsL7WhvlPFARQh5lPgBrg==
X-Received: by 2002:a17:902:ce02:b0:223:536d:f67b with SMTP id d9443c01a7336-22e1eaaf8ccmr145082385ad.38.1746457624987;
        Mon, 05 May 2025 08:07:04 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e150ead69sm56065775ad.24.2025.05.05.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:07:04 -0700 (PDT)
Date: Mon, 5 May 2025 08:07:03 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"saeed@kernel.org" <saeed@kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Message-ID: <aBjUFyaiZ9UHpvze@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
 <20250305163732.2766420-5-sdf@fomichev.me>
 <eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eba9def750047f1789b708b97e376f453f09bfa4.camel@nvidia.com>

On 05/05, Cosmin Ratiu wrote:
> On Wed, 2025-03-05 at 08:37 -0800, Stanislav Fomichev wrote:
> > Qdisc operations that can lead to ndo_setup_tc might need
> > to have an instance lock. Add netdev_lock_ops/netdev_unlock_ops
> > invocations for all psched_rtnl_msg_handlers operations.
> 
> Sorry for resurrecting this thread, but it seems like a good place to
> ask a related question.
> 
> If qdisc operations that lead to .ndo_setup_tc() need to hold an
> instance lock, shouldn't all such callers acquire it?
> 
> In my testing, I found out that e.g., when unloading a device, there's
> this call path which ends up calling .ndo_setup_tc() unlocked:
> 
> devlink_reload -...-> device_del -...-> unregister_netdev -...->
> unregister_netdevice_many_notify -> dev_shutdown -> qdisc_put ->
> __qdisc_destroy -> mqprio_disable_offload -> .ndo_setup_tc
> 
> Many other qdiscs (other than mqprio) call .ndo_setup_tc() and would be
> in a similar situation.
> 
> Does it make sense to extend the netdev lock for dev_shutdown like in
> the patch below? After some basic testing, it seems safe but I haven't
> looked too deep into all possibilities.
> 
> Cosmin.
> 
> From e8b613dfd2b241a6c19bb89a829d598d6640b6f9 Mon Sep 17 00:00:00 2001
> From: Cosmin Ratiu <cratiu@nvidia.com>
> Date: Mon, 5 May 2025 15:34:53 +0300
> Subject: [PATCH 01/20] net/sched: Lock netdevices during dev_shutdown
> 
> Various qdiscs can end up calling into .ndo_setup_tc() and as such,
> might need the netdev instance lock.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  net/core/dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d1a8cad0c99c..134ceddf7fa5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12020,9 +12020,9 @@ void unregister_netdevice_many_notify(struct
> list_head *head,
>                 struct sk_buff *skb = NULL;
>  
>                 /* Shutdown queueing discipline. */
> +               netdev_lock_ops(dev);
>                 dev_shutdown(dev);
>                 dev_tcx_uninstall(dev);

There is a synchronize_net hidden inside of dev_tcx_uninstall, so
let's ops-lock only dev_shutdown here? Other than that, don't see
anything wrong. Can you send this separately and target net tree?

