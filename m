Return-Path: <netdev+bounces-135755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C8F99F19A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDD2804DE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE71F668D;
	Tue, 15 Oct 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIdpcFt0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48E1DD0D0
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006824; cv=none; b=OJ2sRYstGQFQXx/780u7M+LTjqtFxijSXSe/zddOD01nujLYlxhqsbAc8Z9zO3P0XBGKKgUT9lqMP6MEUjOyIq6pu5BMe24NrE9B9Fso28UlIqtK6fOYQT2++zjW8/NW5AOWIOnA97rEwFcumDUOMUGe0t6VoR9sflIyRvZ0zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006824; c=relaxed/simple;
	bh=7HJBfRMvDXoCs3BRYXjtyz9D5sYKjPX4SHKeFCt5SU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co1zCg45hFPR27VLdCKNymUWuWy4vlpNz1OqMLCH+1D2x0qzO0RdWJQv6sE1w2W4OjMayHgZSl1KUj2NeMciFmcoUUjfv0Fgi5m9/eo921umVgFMxyKxDx55d9uz4IOhLbzkj8XTasfZTH64UW7cSGmyX/Jvd3iJgDargbA04dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIdpcFt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ED7C4CED1;
	Tue, 15 Oct 2024 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006823;
	bh=7HJBfRMvDXoCs3BRYXjtyz9D5sYKjPX4SHKeFCt5SU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hIdpcFt0eVE/YyWIorZBTvdwp3rtyYvuNbZkLy6yoCZee5enc892FaAixk8EKr5Vr
	 hwH5UKFmQ6864t5GDvMoQZUE38g2IoVw7eTC6tWC7YSGr7g2RANT6EEn+AAcX+f3fU
	 b4RqT9ofrk6TD/lfassqnjNur6B/qld6B63fFvjc/f4BjQZi5gXZixqu+WM19EG3Q2
	 O4Dk5M1TkhJNdp/76wR8jb2ejS10nf1uxh2tywnL2NdaxSGZKpPL/lJTvhqvuriLRX
	 ieXfL1N13Xjt+IbpGmys/qfaUiXWtwcvrCGTlMUGU9+qDiKVGBzLT7r1R6J5cABFyd
	 P76kVy8pLDPsQ==
Date: Tue, 15 Oct 2024 08:40:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>, chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Olivier Tilmans
 <olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob
 Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH net-next 01/44] sched: Add dualpi2 qdisc
Message-ID: <20241015084021.377104e2@kernel.org>
In-Reply-To: <CAM0EoMk4Uddc+T-akmMweF9mPC25Amq4+XnAn9fiVEUhmQ_Qbg@mail.gmail.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
	<20241015102940.26157-2-chia-yu.chang@nokia-bell-labs.com>
	<CAM0EoMk4Uddc+T-akmMweF9mPC25Amq4+XnAn9fiVEUhmQ_Qbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 11:30:01 -0400 Jamal Hadi Salim wrote:
> > +       if (tb[TCA_DUALPI2_ALPHA]) {
> > +               u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> > +
> > +               if (alpha > ALPHA_BETA_MAX) {
> > +                       NL_SET_ERR_MSG_ATTR(extack, tb[TCA_DUALPI2_ALPHA],
> > +                                           "alpha is too large.");
> > +                       sch_tree_unlock(sch);
> > +                       return -EINVAL;
> > +               }
> > +               q->pi2.alpha = dualpi2_scale_alpha_beta(alpha);
> > +       }  
> 
> You should consider using netlink policies for these checks (for
> example, you can check for min/max without replicating code as above).
> Applies in quiet a few places (and not just for max/min validation)

In fact I think we should also start asking for YAML specs.
Donald already added most of the existing TC stuff.
Please extend Documentation/netlink/specs/tc.yaml

