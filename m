Return-Path: <netdev+bounces-44147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327817D6A24
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC841C20C55
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A90273EE;
	Wed, 25 Oct 2023 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="T0O3I08c"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76226E34
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:29:35 +0000 (UTC)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B56196
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 04:29:31 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SFmsy0xz2zMpvff;
	Wed, 25 Oct 2023 11:29:26 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SFmsx3n9DzMpnPn;
	Wed, 25 Oct 2023 13:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1698233366;
	bh=Q3GfLm/wl5qsxpCx/PoVD6qiO8tOiUfUm2gWs7I37eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0O3I08cZdyn7fpbFy+ubIqzNnrV0et33RTLvJWq97INMsOaII5Eplx3MCJ1f1UWQ
	 C1tG7o4N6c14uH0rN2WRsleIWPoP3O125Mg7dF9g2Z1IpvL1i0vIH7nZkkk4+z5wLv
	 DA+yqiG0cgmwZ9gxuaz0rlgA24WM5tGd8Todi9XM=
Date: Wed, 25 Oct 2023 13:29:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v13 08/12] landlock: Add network rules and TCP hooks
 support
Message-ID: <20231025.ooG0Uach9aes@digikod.net>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-9-konstantin.meskhidze@huawei.com>
 <20231017.xahKoo9Koo8v@digikod.net>
 <57f150b2-0920-8567-8351-1bdb74684cfa@huawei.com>
 <20231020.ido6Aih0eiGh@digikod.net>
 <ea02392e-4460-9695-050f-7519aecebec2@huawei.com>
 <20231024.Ahdeepoh7wos@digikod.net>
 <bc4699d7-ab54-a3b8-06a0-1724a63c6076@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc4699d7-ab54-a3b8-06a0-1724a63c6076@huawei.com>
X-Infomaniak-Routing: alpha

On Tue, Oct 24, 2023 at 12:12:01PM +0300, Konstantin Meskhidze (A) wrote:
> 
> 
> 10/24/2023 12:03 PM, Mickaël Salaün пишет:
> > On Tue, Oct 24, 2023 at 06:18:54AM +0300, Konstantin Meskhidze (A) wrote:
> > > 
> > > 
> > > 10/20/2023 12:49 PM, Mickaël Salaün пишет:
> > > > On Fri, Oct 20, 2023 at 07:08:33AM +0300, Konstantin Meskhidze (A) wrote:
> > > > > > > > > 10/18/2023 3:29 PM, Mickaël Salaün пишет:
> > > > > > On Mon, Oct 16, 2023 at 09:50:26AM +0800, Konstantin Meskhidze wrote:
> > 
> > > > > > > diff --git a/security/landlock/net.h b/security/landlock/net.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..588a49fd6907
> > > > > > > --- /dev/null
> > > > > > > +++ b/security/landlock/net.h
> > > > > > > @@ -0,0 +1,33 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > > > +/*
> > > > > > > + * Landlock LSM - Network management and hooks
> > > > > > > + *
> > > > > > > + * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#ifndef _SECURITY_LANDLOCK_NET_H
> > > > > > > +#define _SECURITY_LANDLOCK_NET_H
> > > > > > > +
> > > > > > > +#include "common.h"
> > > > > > > +#include "ruleset.h"
> > > > > > > +#include "setup.h"
> > > > > > > +
> > > > > > > +#if IS_ENABLED(CONFIG_INET)
> > > > > > > +__init void landlock_add_net_hooks(void);
> > > > > > > +
> > > > > > > +int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
> > > > > > > +			     const u16 port, access_mask_t access_rights);
> > > > > > > +#else /* IS_ENABLED(CONFIG_INET) */
> > > > > > > +static inline void landlock_add_net_hooks(void)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline int
> > > > > > > +landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
> > > > > > > +			 access_mask_t access_rights);
> > > > > > > +{
> > > > > > > +	return -EAFNOSUPPORT;
> > > > > > > +}
> > > > > > > +#endif /* IS_ENABLED(CONFIG_INET) */
> > > > > > > +
> > > > > > > +#endif /* _SECURITY_LANDLOCK_NET_H */
> > > > > > > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > > > > > > index 4c209acee01e..1fe4298ff4a7 100644
> > > > > > > --- a/security/landlock/ruleset.c
> > > > > > > +++ b/security/landlock/ruleset.c
> > > > > > > @@ -36,6 +36,11 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
> > > > > > >  	refcount_set(&new_ruleset->usage, 1);
> > > > > > >  	mutex_init(&new_ruleset->lock);
> > > > > > >  	new_ruleset->root_inode = RB_ROOT;
> > > > > > > +
> > > > > > > +#if IS_ENABLED(CONFIG_INET)
> > > > > > > +	new_ruleset->root_net_port = RB_ROOT;
> > > > > > > +#endif /* IS_ENABLED(CONFIG_INET) */
> > > > > > > +
> > > > > > >  	new_ruleset->num_layers = num_layers;
> > > > > > >  	/*
> > > > > > >  	 * hierarchy = NULL
> > > > > > > @@ -46,16 +51,21 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
> > > > > > >  }
> > > > > > > > >  struct landlock_ruleset *
> > > > > > > -landlock_create_ruleset(const access_mask_t fs_access_mask)
> > > > > > > +landlock_create_ruleset(const access_mask_t fs_access_mask,
> > > > > > > +			const access_mask_t net_access_mask)
> > > > > > >  {
> > > > > > >  	struct landlock_ruleset *new_ruleset;
> > > > > > > > >  	/* Informs about useless ruleset. */
> > > > > > > -	if (!fs_access_mask)
> > > > > > > +	if (!fs_access_mask && !net_access_mask)
> > > > > > >  		return ERR_PTR(-ENOMSG);
> > > > > > >  	new_ruleset = create_ruleset(1);
> > > > > > > -	if (!IS_ERR(new_ruleset))
> > > > > > > +	if (IS_ERR(new_ruleset))
> > > > > > > +		return new_ruleset;
> > > > > > > +	if (fs_access_mask)
> > > > > > >  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
> > > > > > > +	if (net_access_mask)
> > > > > > > +		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> > > > > > > This is good, but it is not tested: we need to add a test that
> > > > > both
> > > > > > handle FS and net restrictions. You can add one in net.c, just handling
> > > > > > LANDLOCK_ACCESS_FS_READ_DIR and LANDLOCK_ACCESS_NET_BIND_TCP, add one
> > > > > > rule with path_beneath (e.g. /dev) and another with net_port, and check
> > > > > > that open("/") is denied, open("/dev") is allowed, and and only the
> > > > > > allowed port is allowed with bind(). This test should be simple and can
> > > > > > only check against an IPv4 socket, i.e. using ipv4_tcp fixture, just
> > > > > > after port_endianness. fcntl.h should then be included by net.c
> > > > > > >   Ok.
> > > > > > > I guess that was the purpose of layout1.with_net (in fs_test.c)
> > > > > but it
> > > > > > >   Yep. I added this kind of nest in fs_test.c to test both
> > > fs and network
> > > > > rules together.
> > > > > > is not complete. You can revamp this test and move it to net.c
> > > > > > following the above suggestions, keeping it consistent with other tests
> > > > > > in net.c . You don't need the test_open() nor create_ruleset() helpers.
> > > > > > > This test must failed if we change
> > > > > "ruleset->access_masks[layer_level] |="
> > > > > > to "ruleset->access_masks[layer_level] =" in
> > > > > > landlock_add_fs_access_mask() or landlock_add_net_access_mask().
> > > > > > >   Do you want to change it? Why?
> > > > > The kernel code is correct and must not be changed. However, if
> > > by
> > > > mistake we change it and remove the OR, a test should catch that. We
> > > > need a test to assert this assumption.
> > > > > >   Fs and network masks are ORed to not intersect with each
> > > other.
> > > > > Yes, they are ORed, and we need a test to check that. Noting is
> > > > currently testing this OR (and the different rule type consistency).
> > > > I'm suggesting to revamp the layout1.with_net test into
> > > > ipv4_tcp.with_fs and make it check ruleset->access_masks[] and rule
> > > > addition of different types.
> > 
> > > From the other email:
> > > Thinking about this test. We don't need to add any additional ASSERT here.
> > > Anyway if we accidentally change "ruleset->access_masks[layer_level] |=" to
> > > "ruleset->access_masks[layer_level] =" we will fail either in opening
> > > directory or in port binding, cause adding a second rule (fs or net) will
> > > overwrite a first one's mask. it does not matter which one goes first. I
> > > will check it and send you a message.
> > > What do you think?
> > 
> > > 
> > >   About my previous comment.
> > > 
> > >   Checking the code we can  notice that adding fs mask goes first:
> > > 
> > > ...
> > > if (fs_access_mask)
> > > 		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
> > > if (net_access_mask)
> > > 		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> > > ....
> > > 
> > > So with we change "ruleset->access_masks[layer_level] |="
> > > >> > to "ruleset->access_masks[layer_level] =" in
> > > landlock_add_fs_access_mask() nothing bad will happen.
> > > But if we do that in landlock_add_net_access_mask()
> > > fs mask will be overwritten and adding fs rule will fail
> > > (as unhandled allowed_accesss).
> > 
> > Right. What is the conclusion here? Are you OK with my test proposal?
> 
>   So we just check if landlock_add_net_access_mask() would be changed by
> mistake?

With the current kernel code, yes.

> Changing landlock_add_fs_access_mask() does not break the logic. Am
> I correct here?

Yes, only landlock_add_net_access_mask() changes would be detected with
the current kernel code, but the test checks the whole semantic, so even
the following code with a buggy landlock_add_fs_access_mask() would be
detected:

if (net_access_mask)
	landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
if (fs_access_mask)
	landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);

