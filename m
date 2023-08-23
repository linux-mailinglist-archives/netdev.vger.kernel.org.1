Return-Path: <netdev+bounces-29911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08C7852CB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6011C20C2E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47B79D8;
	Wed, 23 Aug 2023 08:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84620F00
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:36:37 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F71BEC
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 01:36:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id AD3D71F8AA;
	Wed, 23 Aug 2023 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692779783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jFyBx2epXYu7DotVhPP5C9qSQ7rCcs+7SBAno822RA=;
	b=ii0bC70LOQ4JdWEx5vOGi1l0y8ub9SMX8+WwuPL1e5VgecYuvc9n3Ym9JB9WUm2FKN1BDV
	qN5cVm2XN8MKo82ucbkPc55rwnWohDq5wNrJDFr81c6HwdmGLojm1uOtRDGJudmlDniWYP
	ED8dtWoSMa7z4dLmPwz9c33CBR3kaRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692779783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jFyBx2epXYu7DotVhPP5C9qSQ7rCcs+7SBAno822RA=;
	b=m8z/yhRIQQ5Fuqb6jzo8wWIwkBWgdZuq0K52WlhGdxTCvKcv6c1kGE5WC7lvz1FIuca881
	cXuaWsXFGmB5eyDA==
Received: from localhost (dwarf.suse.cz [10.100.12.32])
	by relay2.suse.de (Postfix) with ESMTP id 5F8A52C142;
	Wed, 23 Aug 2023 08:36:23 +0000 (UTC)
Date: Wed, 23 Aug 2023 10:36:23 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	benoit.boissinot@ens-lyon.org, davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org
Subject: Re: [PATCH] ipv6/addrconf: clamp preferred_lft to the minimum
 instead of erroring
Message-ID: <ZOXFBzRO98sL5xeV@dwarf.suse.cz>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
 <e0e8e74a65ae24580d3ab742a8e76ca82bf26ff8.camel@redhat.com>
 <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 09:41:37PM -0600, Alex Henrie wrote:
> "Fixes: eac55bf97094f6b64116426864cf4666ef7587bc", correct?
> 
> > On Sun, 2023-08-20 at 19:11 -0600, Alex Henrie wrote:
> 
> > > @@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
> > >        * idev->desync_factor if it's larger
> > >        */
> > >       cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
> > > -     max_desync_factor = min_t(__u32,
> > > +     max_desync_factor = min_t(__s64,
> > >                                 idev->cnf.max_desync_factor,
> > >                                 cnf_temp_preferred_lft - regen_advance);
> >
> > It would be better if you describe in the commit message your above
> > fix.
> 
> I did mention the underflow problem in the commit message. When I
> split the patch into two patches, it will be even more prominent. What
> more would you like the commit message to say?
> 
> > Also possibly using 'long' as the target type (same as
> > 'max_desync_factor') would be more clear.
> 
> OK, will change in v2.

This part looks good to me. Sorry for introducing the bug and
thanks for finding it!

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


