Return-Path: <netdev+bounces-120587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D806A959E50
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1724A1C2251B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5648019995D;
	Wed, 21 Aug 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBjzAWFQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E819992C
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246019; cv=none; b=KXygAiwXIvWU2HTQQolT+5l92vVk8ZzSrNDd+bGiccNP9pMkF8x9iSWoonamB//w3s3/FwaDBdGNPpxdgeFH22Ry/ubp97E5yndbmhRwHT98IU05KU52/3QaRz16YL/I1l6sUNBRi5B5JEMJOwsl4JMR6MWgM8WM9yLiEY/fhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246019; c=relaxed/simple;
	bh=VxdnQRQ9RoJiHroH7aL12ZENbeWU8OgMK4PjHewMYIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY7LsiaE+DpUDCyBPhhCXJnKy9mplf+lWpRLJUZ8MYmSPXwP2JjIQhxmd7YIqw8OuGesrUo4mqTOipqEPsjpFSrOSaaluIcK6REmBgGEGhBXg1MH013V5J8ur3gc3ef1s0ZoVYsukPNMnmnFHHf1oVOqFIn+pKAcrPkFAprz0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBjzAWFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724246015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxdnQRQ9RoJiHroH7aL12ZENbeWU8OgMK4PjHewMYIM=;
	b=WBjzAWFQ6hBQlCziUepPZ9QZKcZqG7HvxykGJ4FOZElhFZvzfhnLN9LCWe2Qxk0NPB1AT0
	UkJNnrFCRIGCC1HLtn+0vETcA//+QTgGE6+g2evc/MVMILAG1A3MUS2yqhs/CtLVE4mNSs
	KKMj6ebLIH6j/g6C+Ds0nN96+qVXLmc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-GNIp6BE_MCme4u4mJY5bQw-1; Wed, 21 Aug 2024 09:13:34 -0400
X-MC-Unique: GNIp6BE_MCme4u4mJY5bQw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52f00bde210so7716917e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246013; x=1724850813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxdnQRQ9RoJiHroH7aL12ZENbeWU8OgMK4PjHewMYIM=;
        b=A0gEOFtht0NmkXxT4PguKpC6KzopAaAStoj/y3PGFmyf5ugw72/N3PhR6Xt2j48A/q
         PIT48zDMuSKMX7IQtxIVk4AKsGFsECKiKyz3m39ZtKVJda5tcKX+ypLf99rmvkhZcsvP
         R8RNxfpubyJKLkCvO6snhHpGt3N5QWXEVQKjW35ua4qsfaripTme/8tnn0+W7wRMUYqB
         sHPYxU4e+Bvg06xeSncmV9k93VXurIdwlOKnfC1oXqzc3e78OK9nAEkiaUa6r96NaI4q
         wCqVytmtExAUeeB6rUegEOp0CIDlU37Io6LFMuHSSY5wJf33vPzPEf4exjQ9RH51KnC0
         JjFw==
X-Forwarded-Encrypted: i=1; AJvYcCUFjgb+fTPNyms1Dx0sK6UuqDhzjgimq6iFdxOU+vYXqJlHrFzUBWHL07HKanvX8A5PUt+Wh8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDLa/x3psalh3l2f6ZM0rUmlATw+uASemrMTh1CI/ovJjbb9G
	5Qk6VKu2HzHhGHRlU04Ey+SWqQiswoUgDBpICLCqWDAbEg0VuIEYtl9LrI5ymUnxSvs0qp2naAe
	muuqDw0udTnhllu9ahmb1nk+ZkNVta8W9hqRSsXNUR3MHQtdzNgs3t5IHTKK0MODSwjmiTpsP2q
	liuDU5kFiOJOHn1bnVsA5FN335/VFf
X-Received: by 2002:a2e:e09:0:b0:2ee:88d8:e807 with SMTP id 38308e7fff4ca-2f3f88a6e99mr13197351fa.16.1724246013050;
        Wed, 21 Aug 2024 06:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbXz/zZNLpgYy914DPQE0G3jUIMMtBg2FW5l+r7EiJf3/VyOVgUXkDaaMO4gGanew6Bd0Rh41sjKlfIR/KxZc=
X-Received: by 2002:a2e:e09:0:b0:2ee:88d8:e807 with SMTP id
 38308e7fff4ca-2f3f88a6e99mr13196981fa.16.1724246012310; Wed, 21 Aug 2024
 06:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819183742.2263895-1-aahringo@redhat.com> <20240819183742.2263895-12-aahringo@redhat.com>
 <20240819151227.4d7f9e99@kernel.org>
In-Reply-To: <20240819151227.4d7f9e99@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 21 Aug 2024 09:13:21 -0400
Message-ID: <CAK-6q+hx8MNeZCc0T-sTPdMgXH=ZcpLVqc2-5+psMCoQ_W0FxA@mail.gmail.com>
Subject: Re: [PATCH dlm/next 11/12] dlm: add nldlm net-namespace aware UAPI
To: Jakub Kicinski <kuba@kernel.org>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	netdev@vger.kernel.org, vvidic@valentin-vidic.from.hr, heming.zhao@suse.com, 
	lucien.xin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakob,

On Mon, Aug 19, 2024 at 6:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Aug 2024 14:37:41 -0400 Alexander Aring wrote:
> > Recent patches introduced support to separate DLM lockspaces on a per
> > net-namespace basis. Currently the file based configfs mechanism is use=
d
> > to configure parts of DLM. Due the lack of namespace awareness (and it'=
s
> > probably complicated to add support for this) in configfs we introduce =
a
> > socket based UAPI using "netlink". As the DLM subsystem offers now a
> > config layer it can simultaneously being used with configfs, just that
> > nldlm is net-namespace aware.
> >
> > Most of the current configfs functionality that is necessary to
> > configure DLM is being adapted for now. The nldlm netlink interface
> > offers also a multicast group for lockspace events NLDLM_MCGRP_EVENT.
> > This event group can be used as alternative to the already existing ude=
v
> > event behaviour just it only contains DLM related subsystem events.
> >
> > Attributes e.g. nodeid, port, IP addresses are expected from the user
> > space to fill those numbers as they appear on the wire. In case of DLM
> > fields it is using little endian byte order.
> >
> > The dumps are being designed to scale in future with high numbers of
> > members in a lockspace. E.g. dump members require an unique lockspace
> > identifier (currently only the name) and nldlm is using a netlink dump
> > behaviour to be prepared if all entries may not fit into one netlink
> > message.
>
> Did you consider using the YAML spec stuff to code gen the policies
> and make user space easier?
>

I will try to take a look into that and prepare a spec for PATCHv2. I
saw that there is a documentation about it at [0].

I did a kind of "prototype" libnldlm [1] to have easy access to the
netlink api but if there are more common ways to generate code to
easily access it, I am happy to give it a try.

Thanks.

- Alex

[0] https://docs.kernel.org/userspace-api/netlink/specs.html
[1] https://gitlab.com/netcoder/nldlm/


