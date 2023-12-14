Return-Path: <netdev+bounces-57224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D65812650
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 05:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B282815BF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B317E4;
	Thu, 14 Dec 2023 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br9llnfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44103CF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:15:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso8064735a91.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 20:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702527312; x=1703132112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iM7zWVa0XHAy6wGlOZW+2wt/022FKMl4RKM94PMESHs=;
        b=Br9llnfaKjlvN2uewWMiuaBMaxLSeGpKw0wnQxqUer33KhGsII9GmKSApQp/fYygCV
         7fIe07735zT4tAHhwfPV9Lt03/+ixbYPI3d/d1A/+qmf7zuPlQxqYlAWJ9V9WKT32UhN
         nYJwXd9K4K7qC+yCv8k3MrB9p8VFsiqPfMEbHAKDeZ/IrD8muqaq7JrVFHLd/SL8WxFH
         YIMCCAJd9QzS1nZDSNEWXQAT7ju0F3x6i/i+vwAOWN9aEEr7lPDErW5qKMNoEOTvZfxZ
         1WnkKnnykMqSJccOSqd+XPJQBz1w8yUl0aV5x899F5re25ND6p4flKHFsM+S0GupHFV+
         Is+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702527312; x=1703132112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM7zWVa0XHAy6wGlOZW+2wt/022FKMl4RKM94PMESHs=;
        b=bsRwAVOyMiUJdLRzQoLgb/fQSGMLdkYtPCxBfsmnCQXxrGcrktP8F0vBSI7idNs8yW
         dsvhuvVjD3TT/+4sCuqpikzsGNqVYbA/pcA3XTjPQjr2neASDNG3jwFAu+f3tCpSw4sy
         yM5jjucqPhzh19iBnOdfZIagnWXg358dzfkA380dfuShU5thAwlSaGt/bM5OLt4offBK
         8cPCQ4KZBnUmmMf1JIqUm2iZekbyiKl0kjxGHR8tUwUg3xyB+Nj10Z61ySJCoOfBz54V
         Gk/V/KstJClZSB6MLpAn1JUp5+aIyo65F52aTJgBYdtza7WYRbvW4sQG7NRayW/l1HV9
         eC9A==
X-Gm-Message-State: AOJu0YxhCQJWgcDZBBfM07D3Lp5l30nmi8sl9oqw307rqLE1Jz2Mj2/B
	u+Qx3/trYRxIQzlTmlTpF+M=
X-Google-Smtp-Source: AGHT+IHJ6/7WUENXF5cNYE8RlUnI8re5akNYE5zdoKPs7BdD5qN6ZJ+PsLMtTEKEzbRHJhJSJAg4ig==
X-Received: by 2002:a17:902:e789:b0:1d0:6ffe:9f5 with SMTP id cp9-20020a170902e78900b001d06ffe09f5mr10592514plb.83.1702527311568;
        Wed, 13 Dec 2023 20:15:11 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b001d051725d09sm2371500plb.241.2023.12.13.20.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:15:11 -0800 (PST)
Date: Thu, 14 Dec 2023 12:15:07 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 0/3] add YAML spec for team
Message-ID: <ZXqBSyBt7xiv7YyA@Laptop-X1>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
 <20231213083642.1872702f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213083642.1872702f@kernel.org>

Hi Jakub,
On Wed, Dec 13, 2023 at 08:36:42AM -0800, Jakub Kicinski wrote:
> > There are still some questions I got during convertion.
> > 
> > 1. Is there a preference to use "-" instead of "_" for the names in spec file?
> >    e.g. the attr-cnt-name in team.spec, should I use __team-attr-item-port-max
> >    or --team-attr-item-port-max, or __team_attr_item_port_max?
> 
> Minor preference for using -, but it mostly matters for things which
> will be visible outside of C. For instance in attr names when they are
> used in python: 
>   msg['port-index']
> looks nicer to me than
>   msg['port_index']
> and is marginally easier to type. But cnt-name is a C thing, so up to
> you. If I was writing it myself I'd probably go with
> --team-attr-item-port-max, that's what MPTCP did.

Thanks, I will do as what else do

> 
> > 2. I saw ynl-gen-c.py deals with unterminated-ok. But this policy is not shown
> >    in the schemas. Is it a new feature that still working on?
> 
> I must have added it to the code gen when experimenting with a family 
> I didn't end up supporting. I'm not actively working on that one, feel
> free to take a stab at finishing it or LMK if you need help.

OK, I will do it.

> 
> > 3. Do we have to hard code the string max-len? Is there a way to use
> >    the name in definitions? e.g.
> >    name: name
> >    type: string
> >    checks:
> >      max-len: string-max-len
> 
> Yes, that's the intention, if codegen doesn't support that today it
> should be improved.

I can try improve this. But may a little late (should go next year).
If you have time you can improve this directly.

> 
> > 4. The doc will be generate to rst file in future, so there will not have
> >    other comments in the _nl.c or _nl.h files, right?
> 
> It already generates ReST:
> https://docs.kernel.org/next/networking/netlink_spec/
> We do still generate kdoc in the uAPI header, tho.

How to generate the doc in uAPI header?

> 
> > 5. the genl_multicast_group is forced to use list. But the team use format
> >    like { .name = TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME, }. Should we support
> >    this legacy format?
> 
> Do you mean that we generate:
> 
> 	[ID] = { "name", }
> 
> rather than:
> 
> 	[ID] = { .name = "name", }
> 
> ? I think the struct had only one member at the time, so I didn't
> bother adding the .name, but you can change the code-gen.

No, the current team just do like

static const struct genl_multicast_group team_nl_mcgrps[] = {
        { .name = TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME, },
};

So there is new ID was defined. Looks the group id is not a must.

> > 7. When build, I got error modpost: missing MODULE_LICENSE() in drivers/net/team/team_nl.o.
> >    Should we add the MODULE_LICENSE support in ynl-gen-c.py?
> 
> Not sure if we can, the generated code should be linked with 
> the implementation to form a full module. The manually written
> part of the implementation should define the license. YAML specs
> have a fairly odd / broadly open license because they are uAPI.
> We don't want to start getting into licensing business.
> 
> > 8. When build, I also got errors like
> >      ERROR: modpost: "team_nl_policy" [drivers/net/team/team.ko] undefined!
> >      ERROR: modpost: "team_nl_ops" [drivers/net/team/team.ko] undefined!
> >      ERROR: modpost: "team_nl_noop_doit" [drivers/net/team/team_nl.ko] undefined!
> >      ERROR: modpost: "team_nl_options_set_doit" [drivers/net/team/team_nl.ko] undefined!
> >      ERROR: modpost: "team_nl_options_get_doit" [drivers/net/team/team_nl.ko] undefined!
> >      ERROR: modpost: "team_nl_port_list_get_doit" [drivers/net/team/team_nl.ko] undefined!
> >      ERROR: modpost: "team_attr_option_nl_policy" [drivers/net/team/team.ko] undefined!
> >   Do you know why include "team_nl.h" doesn't help?
> 
> Same reason as the reason you're getting the LICENSE warning.
> kbuild is probably trying to build team_nl and team as separate modules.
> 
> I think you'll have to rename team.c, take a look at what I did around
> commit 08d323234d10. I don't know a better way...

Thanks, this works for me.

Cheers
Hangbin

