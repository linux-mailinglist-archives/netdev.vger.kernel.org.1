Return-Path: <netdev+bounces-51267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042867F9E14
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99057B20DF9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BFD18C1B;
	Mon, 27 Nov 2023 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7xFXIBX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB7910F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701082875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq7pI9fZh0NEGoCuTDnVlND1Map4zT3CRN8lQfsGvfI=;
	b=f7xFXIBXrZCwIZWta0kYo/pTlbzCtFcHTK8qoIdwH8tvvNPfk1TByn8rOWgNWtJbGUs8Mv
	fi9FqohfjTY/A/9vVloS0wVkQqcl2Rrw3qOgK1ebbiHG0EHvPd3p3FLMrqfOo+mkPBd5Jx
	T1FFMQByPprrkgBmbe94gOTDSi4NjyY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-EZdMBShYOi26AqK2q9kMBw-1; Mon, 27 Nov 2023 06:01:13 -0500
X-MC-Unique: EZdMBShYOi26AqK2q9kMBw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-544f174ccccso302213a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701082872; x=1701687672;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dq7pI9fZh0NEGoCuTDnVlND1Map4zT3CRN8lQfsGvfI=;
        b=ag0VboElIqCracO7/u5TJxn3sXLdLWjqg8OAZ5ac0lVn8nlY4mFPItGtwiJ6NRFdvL
         NnNeLJxWJJSGQKhuHKDnu+erMVAkS2TJBpYNyIB6Zsy6mdUoOVSvpKsnbQAeJX4wRTTL
         S9qICmazbtj/kpFV5BzFOsfaJZbwAd7xuBDql0XrbYGVqwt+UtE78/f5RvvSP1eLYrbY
         /MKkRzVGO/Mwr3XAmCNFtrqifsnWd39RQmRlqFhZotj9/vr/576wTZR1Ay9H7jgew3j6
         CyZYLhqS0vWEQsC0/+rahzP8vxk8nHBwNtwqxfut1Mx54DqRRqYa+P7HRvxc8yWY3AJJ
         08rQ==
X-Gm-Message-State: AOJu0YyxZuzqYuvg1hAebmSciIkfLD3t54+nGxHMRzBFtTJKA5zeJWnz
	4s+Q3TkinCebZayKsjU1vcRjspUhp+fIfrHstvoaqDCwYqxzqDIKMRRStbfnMUESIxc4LxR1Shc
	TYQG+HTUxZH1dEZUh
X-Received: by 2002:a05:6402:1d4b:b0:546:efd8:7f05 with SMTP id dz11-20020a0564021d4b00b00546efd87f05mr8513961edb.1.1701082872461;
        Mon, 27 Nov 2023 03:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdU6DSXvBp7oolrPHkfzFj26sWiezV8a1zQ0ExyvpqV3tJIxNmY3LgDbMRZECV0JxpujJh/A==
X-Received: by 2002:a05:6402:1d4b:b0:546:efd8:7f05 with SMTP id dz11-20020a0564021d4b00b00546efd87f05mr8513944edb.1.1701082872106;
        Mon, 27 Nov 2023 03:01:12 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7cb8c000000b0053deb97e8e6sm5046305edt.28.2023.11.27.03.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:01:11 -0800 (PST)
Message-ID: <91870cef611bf924ab36dab5d26abecb4b673b76.camel@redhat.com>
Subject: Re: [patch net-next v4 3/9] devlink: send notifications only if
 there are listeners
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
 jacob.e.keller@intel.com, jhs@mojatatu.com, johannes@sipsolutions.net, 
 andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com,
 sdf@google.com,  horms@kernel.org
Date: Mon, 27 Nov 2023 12:01:10 +0100
In-Reply-To: <20231123181546.521488-4-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
	 <20231123181546.521488-4-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-23 at 19:15 +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Introduce devlink_nl_notify_need() helper and using it to check at the
> beginning of notification functions to avoid overhead of composing
> notification messages in case nobody listens.
>=20
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  net/devlink/dev.c           | 5 ++++-
>  net/devlink/devl_internal.h | 6 ++++++
>  net/devlink/health.c        | 3 +++
>  net/devlink/linecard.c      | 2 +-
>  net/devlink/param.c         | 2 +-
>  net/devlink/port.c          | 2 +-
>  net/devlink/rate.c          | 2 +-
>  net/devlink/region.c        | 2 +-
>  net/devlink/trap.c          | 6 +++---
>  9 files changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
> index 7c7517e26862..46407689ef70 100644
> --- a/net/devlink/dev.c
> +++ b/net/devlink/dev.c
> @@ -204,6 +204,9 @@ static void devlink_notify(struct devlink *devlink, e=
num devlink_command cmd)
>  	WARN_ON(cmd !=3D DEVLINK_CMD_NEW && cmd !=3D DEVLINK_CMD_DEL);
>  	WARN_ON(!devl_is_registered(devlink));

minor nit: possibly use ASSERT_DEVLINK_REGISTERED(devlink) above?

> =20
> +	if (!devlink_nl_notify_need(devlink))
> +		return;
> +
>  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg)
>  		return;
> @@ -985,7 +988,7 @@ static void __devlink_flash_update_notify(struct devl=
ink *devlink,
>  		cmd !=3D DEVLINK_CMD_FLASH_UPDATE_END &&
>  		cmd !=3D DEVLINK_CMD_FLASH_UPDATE_STATUS);
> =20
> -	if (!devl_is_registered(devlink))
> +	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>  		return;
> =20
>  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
> index 59ae4761d10a..510990de094e 100644
> --- a/net/devlink/devl_internal.h
> +++ b/net/devlink/devl_internal.h
> @@ -185,6 +185,12 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg=
, struct net *net,
>  				 struct devlink *devlink, int attrtype);
>  int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info =
*info);
> =20
> +static inline bool devlink_nl_notify_need(struct devlink *devlink)
> +{
> +	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
> +				  DEVLINK_MCGRP_CONFIG);
> +}
> +
>  /* Notify */
>  void devlink_notify_register(struct devlink *devlink);
>  void devlink_notify_unregister(struct devlink *devlink);
> diff --git a/net/devlink/health.c b/net/devlink/health.c
> index 71ae121dc739..0795dcf22ca8 100644
> --- a/net/devlink/health.c
> +++ b/net/devlink/health.c
> @@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_hea=
lth_reporter *reporter,
>  	WARN_ON(cmd !=3D DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>  	ASSERT_DEVLINK_REGISTERED(devlink);
> =20
> +	if (!devlink_nl_notify_need(devlink))
> +		return;
> +
>  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg)
>  		return;
> diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
> index 9d080ac1734b..45b36975ee6f 100644
> --- a/net/devlink/linecard.c
> +++ b/net/devlink/linecard.c
> @@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_li=
necard *linecard,
>  	WARN_ON(cmd !=3D DEVLINK_CMD_LINECARD_NEW &&
>  		cmd !=3D DEVLINK_CMD_LINECARD_DEL);
> =20
> -	if (!__devl_is_registered(devlink))
> +	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>  		return;
> =20
>  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index d74df09311a9..6bb6aee5d937 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *devl=
ink,
>  	 * will replay the notifications if the params are added/removed
>  	 * outside of the lifetime of the instance.
>  	 */
> -	if (!devl_is_registered(devlink))
> +	if (!devlink_nl_notify_need(devlink) || !devl_is_registered(devlink))

Minor nit: this is the only statement using this order, perhaps swap
the tests for consistency?

Also possibly add the devlink_nl_notify_need() check in
devl_is_registered to reduce code duplication? plus a
__devl_is_registered() variant for the 2 cases above not requiring the
additional check.

No need to repost for the above.

Cheers,

Paolo


