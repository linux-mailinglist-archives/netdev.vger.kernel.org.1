Return-Path: <netdev+bounces-130592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4498AE2A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D711F22896
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32B1A256C;
	Mon, 30 Sep 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGpW3wqZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AF1A2567
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727772; cv=none; b=rY0l6i/DRcgD1tVf7g5b+WpzJpjRlHxY19hcbcixFqL+p3iIedzF4rW7YSA+2bPbgSWjR7ajXZJujMR3s8swrgz1sME3ftCEIF7Gwn1KdhCBcM1ROFA+wlwiVkftkF3JcUm2mjTQ2dV6J0XSpPpDs+NZjkmhvMvIy1syJQzKgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727772; c=relaxed/simple;
	bh=kMZH+xLU9w/w+jErL7nAUzTIjTaixU+hbZdI5UMjEAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlAC2AAabhcN2w6TFTBSmdd97BE/znVDo6phi5RNT8hDCXKeTw7QStkijko4+hoGktZXF6QuLf3aWsP35QEYDqmJKfOTEwwHigddixR2E5PB1dC6xyoxYrscgM0Ra0jnn5wLK6w2NGljcjHUY8zypudBJgN+AAqJxWjt8xLuLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGpW3wqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVaqJm7tLoF1HWWT2ray8rPf/j7gC0aKBR8MDdz/TH4=;
	b=MGpW3wqZraBFuul1MtMDJThpJNLdF0TQbnX4rZPU5zmFMKKuhrXqXYz+mQ3atnFypJamnv
	GP5R2l/GIVnNto8MVZzDC7Pt8dq/a8ujYXe4dKD0r1SKQO8obHcfzX8oxm6DtE9CB7US9g
	mOxJWvhTcYwASEvsbtX8Yjg1atOUR14=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-TOyj7dyoMYC08SelAEGPUw-1; Mon, 30 Sep 2024 16:22:48 -0400
X-MC-Unique: TOyj7dyoMYC08SelAEGPUw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fac57a3f02so13479051fa.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727767; x=1728332567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVaqJm7tLoF1HWWT2ray8rPf/j7gC0aKBR8MDdz/TH4=;
        b=wYB6rpoXku4RVuvPO3vbFP/L+2yYJi3HlSlfLgm8CANR9hFXac9OJOW9JGgBYfXWrR
         ftSWS/fpuNMuzvCTHhMzFiFipgL/+/+zy2ZZEec776Np+hFcNTcMlt9u2e2IRl8ko6pb
         zmqo9EmJ3Lm9XLWvl4C5sE0e5/WYoIdlC80DZS+vXeLYw016S9phluHbdh2Vr4ITyZjq
         C+Sb183zZFo0lf4eMKR/kGEMCVApYpzH+RkBdnO7wIbPvZcLyzdFVaA98ETqoeXjY0Gl
         yjarfCSolSQRxdHF5qk8HblJxzbSG1ogc9VCSE35XmhCHXjRODXNkRrfWm1En4YPKcdG
         LjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqkf+cf/3RJBA01R5ahLUXDODmfD+P3Ywxbu33+9deyFoBhzktv0UD8kn5GslBow6w4YOfb4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8coUYfksDzNfgqxIPwHNg+4zH0iF+rwnS+f9TOkUjFtHdjj1
	8x8gavRI4THGMWX2cZepfWdlPY05NMKK/TRb+QWCQJhWPADeIjnBs/Nmr9ZV/BV2n5HaCrF/Yg/
	DS7mEu3ITH6RtzeZz76Bmaw7pg7r4ESwuS/o7YB7dp0bF/VYZp81DdIvnzOFBwEHTZ2CIxG3n8w
	MYzpgsXQkDNg89P2GrK5ztbOWhzp/X
X-Received: by 2002:a2e:a58d:0:b0:2ef:2cdb:5055 with SMTP id 38308e7fff4ca-2f9d3e56140mr78848831fa.20.1727727766773;
        Mon, 30 Sep 2024 13:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOED+J7NIK671EAM5WNjgF/ITexh9huIebyGUKOqbFC6PtuFqTW3MFJhR+aLaTHS/W0tzN6SptNXddUS+y8JA=
X-Received: by 2002:a2e:a58d:0:b0:2ef:2cdb:5055 with SMTP id
 38308e7fff4ca-2f9d3e56140mr78848661fa.20.1727727766316; Mon, 30 Sep 2024
 13:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930201358.2638665-1-aahringo@redhat.com> <20240930201358.2638665-12-aahringo@redhat.com>
In-Reply-To: <20240930201358.2638665-12-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 30 Sep 2024 16:22:34 -0400
Message-ID: <CAK-6q+h2-APvPUUDYgjGx2FzeJVkeAzH5Br+27A6bZyztfD5mA@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next 11/12] dlm: add nldlm net-namespace aware UAPI
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev, song@kernel.org, yukuai3@huawei.com, 
	agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	netdev@vger.kernel.org, vvidic@valentin-vidic.from.hr, heming.zhao@suse.com, 
	lucien.xin@gmail.com, donald.hunter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2024 at 4:14=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Recent patches introduced support to separate DLM lockspaces on a per
> net-namespace basis. Currently the file based configfs mechanism is used
> to configure parts of DLM. Due the lack of namespace awareness (and it's
> probably complicated to add support for this) in configfs we introduce a
> socket based UAPI using "netlink". As the DLM subsystem offers now a
> config layer it can simultaneously being used with configfs, just that
> nldlm is net-namespace aware.
>
> Most of the current configfs functionality that is necessary to
> configure DLM is being adapted for now. The nldlm netlink interface
> offers also a multicast group for lockspace events NLDLM_MCGRP_EVENT.
> This event group can be used as alternative to the already existing udev
> event behaviour just it only contains DLM related subsystem events.
>
> Attributes e.g. nodeid, port, IP addresses are expected from the user
> space to fill those numbers as they appear on the wire. In case of DLM
> fields it is using little endian byte order.
>
> The dumps are being designed to scale in future with high numbers of
> members in a lockspace. E.g. dump members require an unique lockspace
> identifier (currently only the name) and nldlm is using a netlink dump
> behaviour to be prepared if all entries may not fit into one netlink
> message.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  Documentation/netlink/specs/nldlm.yaml |  438 ++++++++
>  fs/dlm/Makefile                        |    2 +
>  fs/dlm/config.c                        |   20 +-
>  fs/dlm/dlm_internal.h                  |    4 +
>  fs/dlm/lockspace.c                     |   13 +-
>  fs/dlm/netlink2.c                      | 1330 ++++++++++++++++++++++++

and this file shouldn't be there anymore. Will be dropped in v3.

- Alex


