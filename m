Return-Path: <netdev+bounces-127632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD57975EAF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE8F1C2298D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A892A1CF;
	Thu, 12 Sep 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E2TOlzz8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E21DA3D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106432; cv=none; b=IZYw+E/VA6SkHEcluL83eTdny2wB58KhLebMma8+p2WLauA3QQvDNfNLTCHojR+dMkCMOKY+zfFtQWuXpgfz9zaC8SIp+o1onzGKlrBmkYL0rvRDVxQRJbC6Q09yMm7MuRKgxvdAHsHW3wei7S1hrTEocCMoybmuqBOfgrl/VOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106432; c=relaxed/simple;
	bh=RyfVw4JlB9dX3F6lBs7Z0O6/mcYHQlGC2ZnZAUdz/h0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EqgWTTFI8CcnJc0sHcVD4GaQ78EGtlKBiHkV3BOWYqnKm4b5RjAspBXFAVa8nck+N5m2v5886bJvb07npAcShfgSISEgwEEHzcauckyFVutO0KNJF+YLxK4HOETJv9ev3tlHdNLuGITptHcnm8ypmH4tWcC4P06t/zmZKBWpORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E2TOlzz8; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726106421; h=Message-ID:Subject:Date:From:To;
	bh=vzkNLYPu+Av9SBxAfLReDSvS44iM2OzibjEnsrfCDEc=;
	b=E2TOlzz8WeUcAzfCSgjUCJPmVfmd3rLJ0iPXOE8pHq0SfBE8bL49cyW0b1L7BohZ2NKWyklToA2+uQE3Hey/6oBfZ96w34BzsutzKqByHiloqc7JvMRRDJzYrKNpb/Vndni9vJmWPp7Le8hBWOIRX9jXjz8XCc2BtKycXtwJcfk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEpaJDd_1726106419)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 10:00:20 +0800
Message-ID: <1726105750.1529129-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
Date: Thu, 12 Sep 2024 09:49:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Si-Wei Liu" <si-wei.liu@oracle.com>
Cc: virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20240910081147-mutt-send-email-mst@kernel.org>
 <m2ed5qnui8.fsf@oracle.com>
 <20240911102106-mutt-send-email-mst@kernel.org>
 <29017a97-7a5c-49eb-b866-e6b22fd8baea@oracle.com>
In-Reply-To: <29017a97-7a5c-49eb-b866-e6b22fd8baea@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 11 Sep 2024 12:30:49 -0700, "Si-Wei Liu" <si-wei.liu@oracle.com> wrote:
>
>
> On 9/11/2024 7:22 AM, Michael S. Tsirkin wrote:
> > Thanks a lot!
> > Could you retest Xuan Zhuo original patch
> Which one? I thought Darren already did so?


This one[1].

Now, we revert these patches to disable premapped mode by default.
But the bug still exists, if we enable the premapped mode manually,
the bug works again.

[1] was attempted to correct the bug. However, Darren reported that it did not
work. On the other hand, Jason, Takero, and me tested it and found that
it worked for we.

So I ask Darren to retest [1] if he has the time.

 [1].http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

Thanks.


>
> -Siwei
> >   just to make sure it does
> > not fix the issue?
> >
> > On Wed, Sep 11, 2024 at 03:18:55PM +0100, Darren Kenny wrote:
> >> For the record, I got a chance to test these changes and confirmed that
> >> they resolved the issue for me when applied on 6.11-rc7.
> >>
> >> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> >>
> >> Thanks,
> >>
> >> Darren.
> >>
> >> PS - I'll try get to looking at the other potential fix when I have time.
> >>
> >> On Tuesday, 2024-09-10 at 08:12:06 -04, Michael S. Tsirkin wrote:
> >>> On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> >>>> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >>>>
> >>>> I still think that the patch can fix the problem, I hope Darren can re-test it
> >>>> or give me more info.
> >>>>
> >>>>      http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >>>>
> >>>> If that can not work or Darren can not reply in time, Michael you can try this
> >>>> patch set.
> >>> Just making sure netdev maintainers see this, this patch is for net.
> >>>
> >>>> Thanks.
> >>>>
> >>>> Xuan Zhuo (3):
> >>>>    Revert "virtio_net: rx remove premapped failover code"
> >>>>    Revert "virtio_net: big mode skip the unmap check"
> >>>>    virtio_net: disable premapped mode by default
> >>>>
> >>>>   drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> >>>>   1 file changed, 46 insertions(+), 49 deletions(-)
> >>>>
> >>>> --
> >>>> 2.32.0.3.g01195cf9f
>

