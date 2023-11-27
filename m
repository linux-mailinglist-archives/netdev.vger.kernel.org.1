Return-Path: <netdev+bounces-51343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14D7FA3EB
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9210E2811E9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322341EA7F;
	Mon, 27 Nov 2023 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlFi/65q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFEA8
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701097251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIkW/2oCd6F2ddw+xb74oMb+vezmHC5Vpopj/YFsYfI=;
	b=JlFi/65qRhZiiYGxlX+sR641rbCBeS1YOOzVydMmniaqbzjOzEtjf0deUFKw8w0AeXd2Hy
	2fvnSJ+W8g61/FOgcADZE/J49C/enfzsfjTCcCkTDcUpkLkZ87rFqh1AtVd7bj1oRjPNfg
	Sk3FAYc13Y0vzDKfRkUGLQZiFQFPXyY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-B6mw5TQrPwK8uwmuca4Erg-1; Mon, 27 Nov 2023 10:00:48 -0500
X-MC-Unique: B6mw5TQrPwK8uwmuca4Erg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50ba7340352so506760e87.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097246; x=1701702046;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIkW/2oCd6F2ddw+xb74oMb+vezmHC5Vpopj/YFsYfI=;
        b=bdqlJfj43qQT4nG/KBkEzyV4oT8B4UoBXSTopiEAC+YYrcN/rbRMbHTQCTQWMsTq+O
         lVI6V5DulECWd8d0T1HiT7fIPE6NaGqqBkfM2pSQzMkwMrtx5/RYaYL7+QABofLW0qGG
         C0FEaINTu1+yJbIBPFyKJXhnEAlQuZgq+bLwaRgmlVcxvngMCLLVEAS2xuEz4MhB/R4h
         xTVt0X7ogWl4CoJpfD5riGug981TCHe1neSgUTde8zU6DJ1Wp5BAh8oXQjnGR52S8myp
         gT2Qt0cLL/2PPngnujYiK8DdgL/+21f0rzyudxdZySH1koGdvh7e0bhkJHp7gxnrYvKE
         jjuQ==
X-Gm-Message-State: AOJu0Yx33+SLCIWoZqzAczfWQOf5piWOpZdHk+FnT593UWJgIdVkBQr8
	/pz7xgC4TZ/C4A/01RnPe2RFTv5VWxkz+kv3jqopgALopb05JHGctQHCng+I4ezil59f++jAGRN
	SZuMrWF/SIXZYsnEi
X-Received: by 2002:a05:6512:3e02:b0:509:ffe5:e3e6 with SMTP id i2-20020a0565123e0200b00509ffe5e3e6mr7956184lfv.0.1701097246085;
        Mon, 27 Nov 2023 07:00:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETcrZFpJSG0vUgcE2lTsxxrMtqIV5sXseZBc+XWvce5Fc2gpGHVyJMkT+utvePiiyZod90tQ==
X-Received: by 2002:a05:6512:3e02:b0:509:ffe5:e3e6 with SMTP id i2-20020a0565123e0200b00509ffe5e3e6mr7956084lfv.0.1701097244219;
        Mon, 27 Nov 2023 07:00:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7dc0e000000b00548a258227asm5357394edu.30.2023.11.27.07.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:00:43 -0800 (PST)
Message-ID: <0455b0ed46dbac54feb13a27b8fede80980b9426.camel@redhat.com>
Subject: Re: [patch net-next v4 3/9] devlink: send notifications only if
 there are listeners
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com, 
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com, 
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Date: Mon, 27 Nov 2023 16:00:42 +0100
In-Reply-To: <ZWSFw7cbv64UB4bk@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
	 <20231123181546.521488-4-jiri@resnulli.us>
	 <91870cef611bf924ab36dab5d26abecb4b673b76.camel@redhat.com>
	 <ZWSFw7cbv64UB4bk@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 13:04 +0100, Jiri Pirko wrote:
> Mon, Nov 27, 2023 at 12:01:10PM CET, pabeni@redhat.com wrote:
> > On Thu, 2023-11-23 at 19:15 +0100, Jiri Pirko wrote:
> > > From: Jiri Pirko <jiri@nvidia.com>
> > >=20
> > > Introduce devlink_nl_notify_need() helper and using it to check at th=
e
> > > beginning of notification functions to avoid overhead of composing
> > > notification messages in case nobody listens.
> > >=20
> > > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> > > ---
> > >  net/devlink/dev.c           | 5 ++++-
> > >  net/devlink/devl_internal.h | 6 ++++++
> > >  net/devlink/health.c        | 3 +++
> > >  net/devlink/linecard.c      | 2 +-
> > >  net/devlink/param.c         | 2 +-
> > >  net/devlink/port.c          | 2 +-
> > >  net/devlink/rate.c          | 2 +-
> > >  net/devlink/region.c        | 2 +-
> > >  net/devlink/trap.c          | 6 +++---
> > >  9 files changed, 21 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/net/devlink/dev.c b/net/devlink/dev.c
> > > index 7c7517e26862..46407689ef70 100644
> > > --- a/net/devlink/dev.c
> > > +++ b/net/devlink/dev.c
> > > @@ -204,6 +204,9 @@ static void devlink_notify(struct devlink *devlin=
k, enum devlink_command cmd)
> > >  	WARN_ON(cmd !=3D DEVLINK_CMD_NEW && cmd !=3D DEVLINK_CMD_DEL);
> > >  	WARN_ON(!devl_is_registered(devlink));
> >=20
> > minor nit: possibly use ASSERT_DEVLINK_REGISTERED(devlink) above?
>=20
> Sure, but unrelated to this patch.
>=20
>=20
> >=20
> > > =20
> > > +	if (!devlink_nl_notify_need(devlink))
> > > +		return;
> > > +
> > >  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > >  	if (!msg)
> > >  		return;
> > > @@ -985,7 +988,7 @@ static void __devlink_flash_update_notify(struct =
devlink *devlink,
> > >  		cmd !=3D DEVLINK_CMD_FLASH_UPDATE_END &&
> > >  		cmd !=3D DEVLINK_CMD_FLASH_UPDATE_STATUS);
> > > =20
> > > -	if (!devl_is_registered(devlink))
> > > +	if (!devl_is_registered(devlink) || !devlink_nl_notify_need(devlink=
))
> > >  		return;
> > > =20
> > >  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.=
h
> > > index 59ae4761d10a..510990de094e 100644
> > > --- a/net/devlink/devl_internal.h
> > > +++ b/net/devlink/devl_internal.h
> > > @@ -185,6 +185,12 @@ int devlink_nl_put_nested_handle(struct sk_buff =
*msg, struct net *net,
> > >  				 struct devlink *devlink, int attrtype);
> > >  int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_i=
nfo *info);
> > > =20
> > > +static inline bool devlink_nl_notify_need(struct devlink *devlink)
> > > +{
> > > +	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
> > > +				  DEVLINK_MCGRP_CONFIG);
> > > +}
> > > +
> > >  /* Notify */
> > >  void devlink_notify_register(struct devlink *devlink);
> > >  void devlink_notify_unregister(struct devlink *devlink);
> > > diff --git a/net/devlink/health.c b/net/devlink/health.c
> > > index 71ae121dc739..0795dcf22ca8 100644
> > > --- a/net/devlink/health.c
> > > +++ b/net/devlink/health.c
> > > @@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink=
_health_reporter *reporter,
> > >  	WARN_ON(cmd !=3D DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
> > >  	ASSERT_DEVLINK_REGISTERED(devlink);
> > > =20
> > > +	if (!devlink_nl_notify_need(devlink))
> > > +		return;
> > > +
> > >  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > >  	if (!msg)
> > >  		return;
> > > diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
> > > index 9d080ac1734b..45b36975ee6f 100644
> > > --- a/net/devlink/linecard.c
> > > +++ b/net/devlink/linecard.c
> > > @@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlin=
k_linecard *linecard,
> > >  	WARN_ON(cmd !=3D DEVLINK_CMD_LINECARD_NEW &&
> > >  		cmd !=3D DEVLINK_CMD_LINECARD_DEL);
> > > =20
> > > -	if (!__devl_is_registered(devlink))
> > > +	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devli=
nk))
> > >  		return;
> > > =20
> > >  	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > diff --git a/net/devlink/param.c b/net/devlink/param.c
> > > index d74df09311a9..6bb6aee5d937 100644
> > > --- a/net/devlink/param.c
> > > +++ b/net/devlink/param.c
> > > @@ -343,7 +343,7 @@ static void devlink_param_notify(struct devlink *=
devlink,
> > >  	 * will replay the notifications if the params are added/removed
> > >  	 * outside of the lifetime of the instance.
> > >  	 */
> > > -	if (!devl_is_registered(devlink))
> > > +	if (!devlink_nl_notify_need(devlink) || !devl_is_registered(devlink=
))
> >=20
> > Minor nit: this is the only statement using this order, perhaps swap
> > the tests for consistency?
>=20
> Right. If respin is needed, I'll swap.
>=20
>=20
> >=20
> > Also possibly add the devlink_nl_notify_need() check in
> > devl_is_registered to reduce code duplication? plus a
>=20
> It would be odd to have devlink_nl_notify_need() called from
> devl_is_registered().=C2=A0

Sorry for the confusion, out-of-order on my side. What I really mean
is: add __devl_is_registered() in devlink_nl_notify_need().=20

> Also, it is non only used on notification paths.
> I thought about putting the checks in one function, but those are 2
> separate and unrelated checks, so better to keep them separate.

It looks like devlink_nl_notify_need() implies/requires
__devl_is_registered() ?

Cheers,

Paolo


