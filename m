Return-Path: <netdev+bounces-57020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A187E8119A3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C098A1C20E41
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CF35F10;
	Wed, 13 Dec 2023 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjxhKkfs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A11EB40
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93109C433C8;
	Wed, 13 Dec 2023 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485403;
	bh=rMFLWr/JBmKImNb0z5sc2MFHWO/dCU5w368EVQR0wp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JjxhKkfsBzJHMapqpbFz2TrAjRoseuGHqjq0zmgVuprEWvHguR1S8iGgWewtPQzGF
	 SraChlPhiJ7PHG5OcFMc1ezkoRJOAyXRxYFa2ByTJOm/bB2u77h1+TrS4PYPxy0Ocv
	 FrXrCmWFCljImMln80WidUtk2pynb/37KZU+GUqtbW3zdGvl9Je1jUc/UJKXn/HBuc
	 j28PYTTLbZcpzv6S0teMxFgMZYa5aBlXQIGRc5bw2j5p5uYWv+wk+TH0qSF5FlzupK
	 73xB5TSFZEN0cIS3PNjVe8/YhCwYc+7bhYnGMqj3eMWpsdAIYtWyLHOupR3dIi7xpC
	 4HlEf0cmTlFFw==
Date: Wed, 13 Dec 2023 08:36:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 0/3] add YAML spec for team
Message-ID: <20231213083642.1872702f@kernel.org>
In-Reply-To: <20231213084502.4042718-1-liuhangbin@gmail.com>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 16:44:59 +0800 Hangbin Liu wrote:
> You suggested me to add yaml spec for bridge. Since I'm not familiar with
> writing the spec file, I choose to convert team as a start.

Nice work! If you write a spec you don't necessarily have to use
the spec for C code gen, but I will obviously not stop you from
going the extra mile :)

> There are still some questions I got during convertion.
> 
> 1. Is there a preference to use "-" instead of "_" for the names in spec file?
>    e.g. the attr-cnt-name in team.spec, should I use __team-attr-item-port-max
>    or --team-attr-item-port-max, or __team_attr_item_port_max?

Minor preference for using -, but it mostly matters for things which
will be visible outside of C. For instance in attr names when they are
used in python: 
  msg['port-index']
looks nicer to me than
  msg['port_index']
and is marginally easier to type. But cnt-name is a C thing, so up to
you. If I was writing it myself I'd probably go with
--team-attr-item-port-max, that's what MPTCP did.

> 2. I saw ynl-gen-c.py deals with unterminated-ok. But this policy is not shown
>    in the schemas. Is it a new feature that still working on?

I must have added it to the code gen when experimenting with a family 
I didn't end up supporting. I'm not actively working on that one, feel
free to take a stab at finishing it or LMK if you need help.

> 3. Do we have to hard code the string max-len? Is there a way to use
>    the name in definitions? e.g.
>    name: name
>    type: string
>    checks:
>      max-len: string-max-len

Yes, that's the intention, if codegen doesn't support that today it
should be improved.

> 4. The doc will be generate to rst file in future, so there will not have
>    other comments in the _nl.c or _nl.h files, right?

It already generates ReST:
https://docs.kernel.org/next/networking/netlink_spec/
We do still generate kdoc in the uAPI header, tho.

> 5. the genl_multicast_group is forced to use list. But the team use format
>    like { .name = TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME, }. Should we support
>    this legacy format?

Do you mean that we generate:

	[ID] = { "name", }

rather than:

	[ID] = { .name = "name", }

? I think the struct had only one member at the time, so I didn't
bother adding the .name, but you can change the code-gen.

> 6. The _UAPI_LINUX_IF_TEAM_H_ is rename to _UAPI_LINUX_IF_TEAM_H in uapi
>    header. Does that affects?

Hopefully it's fine. Let's try to make the change and deal with
problems if any get reported. Having the standardized guards
helps a little bit in our Makefile magic...

> 7. When build, I got error modpost: missing MODULE_LICENSE() in drivers/net/team/team_nl.o.
>    Should we add the MODULE_LICENSE support in ynl-gen-c.py?

Not sure if we can, the generated code should be linked with 
the implementation to form a full module. The manually written
part of the implementation should define the license. YAML specs
have a fairly odd / broadly open license because they are uAPI.
We don't want to start getting into licensing business.

> 8. When build, I also got errors like
>      ERROR: modpost: "team_nl_policy" [drivers/net/team/team.ko] undefined!
>      ERROR: modpost: "team_nl_ops" [drivers/net/team/team.ko] undefined!
>      ERROR: modpost: "team_nl_noop_doit" [drivers/net/team/team_nl.ko] undefined!
>      ERROR: modpost: "team_nl_options_set_doit" [drivers/net/team/team_nl.ko] undefined!
>      ERROR: modpost: "team_nl_options_get_doit" [drivers/net/team/team_nl.ko] undefined!
>      ERROR: modpost: "team_nl_port_list_get_doit" [drivers/net/team/team_nl.ko] undefined!
>      ERROR: modpost: "team_attr_option_nl_policy" [drivers/net/team/team.ko] undefined!
>   Do you know why include "team_nl.h" doesn't help?

Same reason as the reason you're getting the LICENSE warning.
kbuild is probably trying to build team_nl and team as separate modules.

I think you'll have to rename team.c, take a look at what I did around
commit 08d323234d10. I don't know a better way...

