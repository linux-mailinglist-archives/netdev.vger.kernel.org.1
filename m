Return-Path: <netdev+bounces-200097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75246AE32CF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 00:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF423B01BA
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D33E18C322;
	Sun, 22 Jun 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqClxxjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5B126BFF
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631630; cv=none; b=eX8hkhfFfR0LTw6mwok0BSgqE+US5nO9O/gZpyay/zQjKO1An+Sk6bVCLnJ24Mcp8Zl8V8Qz53DOvLEBn6nyORMLvOBIILyVpzkGhLsK2+FWxJh9ZCwHAWwrw8HQDBgqfZSdu6CNu05FmPe3s5gAqyaMlWWv16U3G8juoyz3nQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631630; c=relaxed/simple;
	bh=37MdDVxEMlrb1hmMShSlJadVXlM6cmOuuyC6uLm3710=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMpYQ9L6zoDWONIRXAWk9DXFwodmeqFgMZLNFteWD/PA7MBb738Y5ok6WJwGY0SMdqxKX/feDD91fkmzaY7rCUFCjvahqwyMQK209B9MDfhv7rqixPo8Yvw0lvmwKIjnFJkzKyT/M9qOOPJN45hGdfUXpYGEOYJryY4joTR+9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqClxxjl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f270513bso55495ad.1
        for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750631628; x=1751236428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Exm32Vn/9M523DHU3yO5hjCuZEmkoX/XmI14WWf0SA=;
        b=VqClxxjl6i0KMnepuRYAb/+Yy4VaNWGdfg9syFOTAJW/gvSSPk8gWgMfmAnmsTyQ37
         pKQdqjsLo3IrFlixFaX/ZDYKBJ8zTLzH/SRtt5StIDuqaxYqVUfz/Ese6BAkxdUF6owk
         /SxvVD2lzpyYyMjUTkINRUyv4c1XIkYnpnrlW2n4alg0v0zMFt271I3xhjJf8zhZnzDN
         +rRrjfAJxh41RRyNpuzyjeDM+XBM7dI5m7vByVH8D7rOjwzhyL7nbOK4cDaFdgeRvz9n
         5NLu7CaYynnOL3elxDjxVA9/o7j78F4U+bLTdGWmk97WIhKN4p3jkgLeQVWYP2x+mw8p
         5+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750631628; x=1751236428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Exm32Vn/9M523DHU3yO5hjCuZEmkoX/XmI14WWf0SA=;
        b=ovmnRz9mtgsckJL3jr6WpmuSsN16wnkF/i9G2yNBFMx5ONr2eXpm3RkUKWzffIHXK8
         B0hM8ACENUdEIdCshlscuoyNSBiCVWiJ6y40o5NIuorgIgInk321ViezaHSqjSvdji8a
         c9YKXnYPhb8sQY+/EQkRLxG83t7dTFa5/nF6C3M4VK0eZ8rELNW007ngfYddHQDmqNOU
         3QW/xC3HEQnEb0DziPUdy1MITTfyO3Xpn6SneXsuSqfopu9yUCDNLd0OLB5QwVek1v1X
         ylBPZbfORCSm51KgpDS5N+LX12Ila8tBzz+mxVhnNk0MAs0V7+mfudQ/nV7LILEsQ2+w
         iKGw==
X-Forwarded-Encrypted: i=1; AJvYcCWVzwR7TeSCoEJIX0VepJ7HrZmkjCdkvCj0uQTw5xe3OVJcozGfKMHqGbfqyAS/UHY1P4PSQW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7A4zBSbpCmA4BCuCwWi/Q82IKBtGVo7232cVmxlW/3KTKe0Q
	thVLmjQ4SAgSRFlTkjpf4nHOvoFt5EGf1ETU/mjQtiaQ/w+cjKwN/dsG3YFnUz6zolh6mXXcDW1
	eK8ipDTfXpsofgBoWX6UT/VpVCGbJRk2bfj67LsD8
X-Gm-Gg: ASbGncvwxHDJgaqqabAX+OKePvqEaFNrxpJwUhdTjJbCkznMHcu7uP9zLrWMbWxA3oe
	8KHS2TUT+X8jpwd6dIoTQFTxRtp6Dd8duuAy2guLUQk3R2ja95lylIUfsmsXaCwHUkpUfyCO9eQ
	wQ77becHfBZ2N7x7KG5CF6Rj+UWKiO0zW1VBDLqs42HNT7BiKkxESobmvCMwqfvLbOm2bbSvGHQ
	VL4
X-Google-Smtp-Source: AGHT+IE7odmArm07PKtquv92skAQZthYDqCcGk7abkznLF7Wp3XbXVavX3dJ1M/bZSgpNSuc2qLhSG+peqM+p7jDo+Q=
X-Received: by 2002:a17:903:1987:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-237e4731082mr3279735ad.12.1750631627334; Sun, 22 Jun 2025
 15:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616165706.994319-1-skhawaja@google.com> <20250618182803.2e367473@kernel.org>
In-Reply-To: <20250618182803.2e367473@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Sun, 22 Jun 2025 15:33:34 -0700
X-Gm-Features: AX0GCFtrAal6rAj_D1hNzFygwGP2JF2BHVqzryhvSIwA9-7U6R-VBV2OPlCQoOo
Message-ID: <CAAywjhTV-N5fASNy708sPWn24isyeROqCezeS6qannotJk97hQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8] Add support to set napi threaded for
 individual napi
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	jdamato@fastly.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 6:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Jun 2025 16:57:06 +0000 Samiullah Khawaja wrote:
> > A net device has a threaded sysctl that can be used to enable threaded
> > napi polling on all of the NAPI contexts under that device. Allow
> > enabling threaded napi polling at individual napi level using netlink.
> >
> > Extend the netlink operation `napi-set` and allow setting the threaded
> > attribute of a NAPI. This will enable the threaded polling on a napi
> > context.
> >
> > Add a test in `nl_netdev.py` that verifies various cases of threaded
> > napi being set at napi and at device level.
> >
> > Tested
> >  ./tools/testing/selftests/net/nl_netdev.py
> >  TAP version 13
> >  1..7
> >  ok 1 nl_netdev.empty_check
> >  ok 2 nl_netdev.lo_check
> >  ok 3 nl_netdev.page_pool_check
> >  ok 4 nl_netdev.napi_list_check
> >  ok 5 nl_netdev.dev_set_threaded
> >  ok 6 nl_netdev.napi_set_threaded
> >  ok 7 nl_netdev.nsim_rxq_reset_down
> >  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index ce4cfec82100..ec2c9d66519b 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -283,6 +283,14 @@ attribute-sets:
> >          doc: The timeout, in nanoseconds, of how long to suspend irq
> >               processing, if event polling finds events
> >          type: uint
> > +      -
> > +        name: threaded
> > +        doc: Whether the napi is configured to operate in threaded pol=
ling
>
> lower case napi here
>
> > +             mode. If this is set to `1` then the NAPI context operate=
s
>
> upper case here, let's pick one form
+1
>
> This is technically a form of kernel documentation, fed into Sphinx
> I'm a bit unclear on Sphinx and backticks, but IIUC it wants double
> backticks? ``1`` ? Or none at all
Will remove backticks.
>
> > +             in threaded polling mode.
> > +        type: uint
> > +        checks:
> > +          max: 1
> >    -
> >      name: xsk-info
> >      attributes: []
>
> >  Threaded NAPI is controlled by writing 0/1 to the ``threaded`` file in
> > -netdev's sysfs directory.
> > +netdev's sysfs directory. It can also be enabled for a specific napi u=
sing
> > +netlink interface.
> > +
> > +For example, using the script:
> > +
> > +.. code-block:: bash
> > +
> > +  $ kernel-source/tools/net/ynl/pyynl/cli.py \
> > +            --spec Documentation/netlink/specs/netdev.yaml \
> > +            --do napi-set \
> > +            --json=3D'{"id": 66,
> > +                     "threaded": 1}'
>
> I wonder if it's okay now to use ynl CLI in the form that is packaged
> for Fedora and RHEL ? It's much more concise, tho not sure if / when
> other distros will catch up:
>
>   $ ynl --family netdev --do napi-set --json=3D'{"id": 66, "threaded": 1}=
'
+1

Will update
>
> > +/**
> > + * napi_set_threaded - set napi threaded state
> > + * @n: napi struct to set the threaded state on
> > + * @threaded: whether this napi does threaded polling
> > + *
> > + * Return: 0 on success and negative errno on failure.
> > + */
> > +int napi_set_threaded(struct napi_struct *n, bool threaded);
>
> IIRC by the kernel coding standards the kdoc if necessary should
> be on the definition.
Will move
>
> > @@ -322,8 +326,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi=
, struct genl_info *info)
> >  {
> >       u64 irq_suspend_timeout =3D 0;
> >       u64 gro_flush_timeout =3D 0;
> > +     u8 threaded =3D 0;
> >       u32 defer =3D 0;
> >
> > +     if (info->attrs[NETDEV_A_NAPI_THREADED]) {
> > +             threaded =3D nla_get_u8(info->attrs[NETDEV_A_NAPI_THREADE=
D]);
>
> nla_get_uint(), nla_get_u8 will not work on big endian
>
> > +             napi_set_threaded(napi, !!threaded);
>
> why ignore the error?
Will update

> --
> pw-bot: cr

