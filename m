Return-Path: <netdev+bounces-194279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5DAC8503
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A399E5842
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B221B9E7;
	Thu, 29 May 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGgeUpF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272011519A6;
	Thu, 29 May 2025 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748561636; cv=none; b=SmAELlGkXoHKyJ2koNOW9Xggcda5OkWXZX9TWTNEr0wRs8hOYsH1lGn2O+vq/IQB4zedEbEHafgxtqNtxqappbCRBssONl9nRpcCmAzh1Y/tCbTH2yphFufRYTZ7mRm0TpW29Zv7oz4IKsAJd5XUj+SufZnlOzUsvcbS375DHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748561636; c=relaxed/simple;
	bh=JGOvHR0zbWV6fGzH/RkKspAF8MTXBQDEvWWJNWuU4Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MftzgHTrs8E8vIuvG3aPJIleWpIn7njC9BW9dPbgTO5fiW3r28VRFeWfzMtAglrw6WTZuVQ+/fH1vkNwN7cGteSbZtCgUTfOpSjhKv34kwFrhpNeNIg/4X6C06FN6NvzcGqU2kpTe/FokLcbPO7nu1Beo/yfI3q0dmMGMZV3wTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGgeUpF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A514C4CEE7;
	Thu, 29 May 2025 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748561635;
	bh=JGOvHR0zbWV6fGzH/RkKspAF8MTXBQDEvWWJNWuU4Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZGgeUpF6NBC7E+6PlDXKBAgOwv82Qn+dbT3nZJPZiBZFJ6ekgwY+zh/huYqOYDM4A
	 BclEgDTmG6B9TC5MyySWSxk7yuCd+fncY/QvlLZrKBIDZGHv61pDkqQhtsggNHIuUo
	 0aKT1QstV+CU7iEj2eboFyXA2ESM6k6gvMaYZwzGv6eqDAwyR/G9SIkhPaD7GcQIA4
	 qnz4H+k/110H19SiYVb5LkXJ661+JQXiu5qht5e1OErz2By9YFqjvv4sH4xb5hJsBt
	 3ZSJrY51Ay4InehQRaYf1S+smDalCwdxOFVOJKlbVlM0Xx8DCihWkQ9Z6t7EWs5q4s
	 hKF9XsJHXBmmw==
Date: Thu, 29 May 2025 16:33:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Guolin Yang
 <guolin.yang@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
Message-ID: <20250529163354.1d85c025@kernel.org>
In-Reply-To: <CAP1Q3XQcYD3nGdojPWS7K4fczNYsNzv0S0O4P8DJvQtRM9Ef1g@mail.gmail.com>
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
	<20250515070250.7c277988@kernel.org>
	<71d0fbf8-00f7-4e0b-819d-d0b6efb01f03@redhat.com>
	<CAP1Q3XTLbk0XgAJOUSGv03dXfPxcUR=VFt=mXiqP9rjc9yhVrw@mail.gmail.com>
	<CAP1Q3XQcYD3nGdojPWS7K4fczNYsNzv0S0O4P8DJvQtRM9Ef1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 May 2025 14:55:20 -0700 Ronak Doshi wrote:
> On Tue, May 27, 2025 at 9:10=E2=80=AFAM Ronak Doshi <ronak.doshi@broadcom=
.com> wrote:
> > On Mon, May 19, 2025 at 12:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote: =20
> > >
> > > If otherwise the traffic goes into the UDP tunnel rx path, such
> > > processing will set the needed field correctly and no issue could/sho=
uld
> > > be observed AFAICS.
> > >
> > > @Ronak: I think the problem pre-exists this specific patch, but since
> > > you are fixing the relevant offload, I think it should be better to
> > > address the problem now.
> > > =20
> > Can we apply this fix which unblocks one of our customer case and addre=
ss this
> > concern as a separate patch as it has been there for a while and it
> > has a workaround
> > of enabling tnl segmentation on the redirected interface? I think it
> > might require quite
> > some change in vmxnet3 to address this concern and can be done as a
> > different patch.
> > Meanwhile, I will raise an internal (broadcom) PR for recreating this
> > specific issue.
> > =20
> Hello Jakub,
> Any update on this? Can you help apply this patch?

You put Paolo in the To: field, so I assumed your messages are directed
to him. I'm not entirely sure what you're proposing, to apply this
patch as is? Whether your driver supports segmentation or not - it
should not send mangled skbs into the stack. Maybe send a v2 and
explain next steps in the commit message, less guessing the better..

