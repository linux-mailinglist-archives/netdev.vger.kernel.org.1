Return-Path: <netdev+bounces-158715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633EA130CF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2213A0428
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D42C859;
	Thu, 16 Jan 2025 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8e13j/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1C28E0F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736991216; cv=none; b=jr45zdoPeqIBcS+Z4NK0p5PuA7Zahbv5JO608n7rBZfbdrTvyxvHxdK3kgpf5MDwTQ9qO3wBAeNENAjRFgwNvOhB2Z1LEJcmmljFqCejj5sa1z6JUFdy2Os1xSqlPyG5Q8A4IjJG8mQKY8PdhfEdeDNPlSNyENNw3eJn8VIleqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736991216; c=relaxed/simple;
	bh=oJiYk/SVZP9Mc0v7acQyGA///+UksSJ7Y0un/QGVq9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2eeA+20cB2dr+55qaWeB3eyND8/mwsz2eivICIxQq9nb1TCDDk5sb+pgOnBbQpXfk0ONkvdf4VGRRKMAJmIJh/Xwa4h1nKHBojTx/J/MesUjT8pzMlZD+NaPYb4ZQX6ySAIYzQ5h2jYDxSXmYnPev7SkgRhRgSqtKsbaxsWtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8e13j/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF22C4CED1;
	Thu, 16 Jan 2025 01:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736991216;
	bh=oJiYk/SVZP9Mc0v7acQyGA///+UksSJ7Y0un/QGVq9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8e13j/CuC8xHed1iN03VI7crZ8SZevArOU7me5weVRNUQzYigob1OX0jvfRh9NGV
	 Xz8D4FDvfmp+cKgu3P0XxxhXDG4lZCXWMoVD1BvsNSX760IhW2nl9fiGPT8ozRFD0G
	 vbg9ge4OBVpDTMRlUDvgFOQ5XummwDCODnIGVU+I6T5kyyBjHUynKGrsM92R6YLYUu
	 kzapHdNPL3rd1qIka1HYAtaE1Ft++EqjMJtLRbA1wSXJNJnTdahIe+zVIZTEXOlb1F
	 hyG+/undae8DPZQixENzdVFyAw0HWpho551hJvbWw2mRi/oy6PcsEtC6PbxL/FOeke
	 OYa78ShMPHFNw==
Date: Wed, 15 Jan 2025 17:33:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250115173335.0f142a28@kernel.org>
In-Reply-To: <CAM0EoM=zzidXbUNYUfnV-P5vVU7KOYZJPw7bdfKt4+nSdyWCvw@mail.gmail.com>
References: <20250111151455.75480-1-jhs@mojatatu.com>
	<20250114172620.7e7e97b4@kernel.org>
	<CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
	<20250115063655.21be5c74@kernel.org>
	<CAM0EoMk0rKe=AqoD_vNZNj2dz9eKSQpgS0Cc7Bi+FQwqpyHXaw@mail.gmail.com>
	<20250115075154.528eee8a@kernel.org>
	<CAM0EoM=zzidXbUNYUfnV-P5vVU7KOYZJPw7bdfKt4+nSdyWCvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 15:39:43 -0500 Jamal Hadi Salim wrote:
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 300430b8c4d2..fac9c946a4c7 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1664,6 +1664,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
> >                                 q = qdisc_lookup(dev, tcm->tcm_handle);
> >                                 if (!q)
> >                                         goto create_n_graft;
> > +                               if (q->parent != tcm->tcm_parent) {
> > +                                       NL_SET_ERR_MSG(extack, "Cannot move an existing qdisc to a different parent");
> > +                                       return -EINVAL;
> > +                               }  
> 
> Yes, this should work as well - doesnt have to save the leaf_q, so more optimal.
> Please send the patch.

I'm gonna keep your commit and just post a v4, hope that's okay.

