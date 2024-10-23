Return-Path: <netdev+bounces-138206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D89AC9A4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175771C21361
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623C1AB6E9;
	Wed, 23 Oct 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzPsRNWB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C11AAE01;
	Wed, 23 Oct 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685109; cv=none; b=Ph+wbW+/grSd4VMtqIqga/z81iqvHJeS5wlCrZUUfkIunS6uEioImK3m61CavTnmx6vOmGgtOsq/3hlYYok/PwtH0V/2eqYQz7LyUIMnGyP7Y6s4i0Py4QT1dIljTuBJs0HqPRD4uGfWqzViuTC/tm1e/9egOJi94xNkwLSzjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685109; c=relaxed/simple;
	bh=Ci6PdjA9tbbKbndpx4ZCnrhRfbmwMX6ImZtphHsmDOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+5Z88ZGEyqmW2hKll8bh/B4vBURvrok95kZH2TFQRXOEjzUyaY8hXLIpt2DHvm4nn2CS2ZEPIryp/Hfkok7IFuFVik/pmDSmwLj7IbRpXRHs+UPW83Ll6HUWObxjACZR38gZq9Kr1BNJRw/EBXEYq2nphESziu5bxvXnBIquHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzPsRNWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E6FC4CECD;
	Wed, 23 Oct 2024 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685108;
	bh=Ci6PdjA9tbbKbndpx4ZCnrhRfbmwMX6ImZtphHsmDOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzPsRNWBek8H9wx0PTe0A+ZoHqgbFGPFJxAktezWPoFS7qdepMTO6wQcELxPzdTNC
	 tEiKE8Av5bUlKrGv4eV9PRnWXAg4LAtEBVIWvVnYKKd/ZVaQC342cpCGTzfnMj14VM
	 0xWmRzalioM0jbOqXfzX617awb5xIV8CZYiQcj3hJe+xoi2ZDJWBwYu10osCyWWOWL
	 YNwjFfviWrxu8wjkYS2LTL077kXvEWfya64FMCd7BvQs/Z+U7VujlKtLjQBNWw5Z2/
	 tgyg31CWMnL1NBL7bLNj1+GEmuQLej8SbmGl94qdsA9t6/OAN8EFpT7WBPv/QMCNiJ
	 5F2D6utPUNhrA==
Date: Wed, 23 Oct 2024 13:05:02 +0100
From: Simon Horman <horms@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
	kernel-team@android.com
Subject: Re: [PATCH v4 1/1] binder: report txn errors via generic netlink
 (genl)
Message-ID: <20241023120502.GQ402847@kernel.org>
References: <20241021191233.1334897-1-dualli@chromium.org>
 <20241021191233.1334897-2-dualli@chromium.org>
 <20241022170625.GJ402847@kernel.org>
 <CANBPYPh97difTKrD=a6A-0sOVwZS28K=BvH37-62Z5FUO+kNUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBPYPh97difTKrD=a6A-0sOVwZS28K=BvH37-62Z5FUO+kNUg@mail.gmail.com>

On Tue, Oct 22, 2024 at 11:11:13AM -0700, Li Li wrote:
> On Tue, Oct 22, 2024 at 10:06 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Oct 21, 2024 at 12:12:33PM -0700, Li Li wrote:
> > > + * @pid:     the target process
> > > + * @flags:   the flags to set
> > > + *
> > > + * If pid is 0, the flags are applied to the whole binder context.
> > > + * Otherwise, the flags are applied to the specific process only.
> > > + */
> > > +static int binder_genl_set_report(struct binder_context *context, u32 pid, u32 flags)
> >
> > ...
> >
> > >  static int __init init_binder_device(const char *name)
> > >  {
> > >       int ret;
> > > @@ -6920,6 +7196,11 @@ static int __init init_binder_device(const char *name)
> >
> > The code above this hunk looks like this:
> >
> >
> >         ret = misc_register(&binder_device->miscdev);
> >         if (ret < 0) {
> >                 kfree(binder_device);
> >                 return ret;
> >         }
> >
> > >
> > >       hlist_add_head(&binder_device->hlist, &binder_devices);
> > >
> > > +     binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
> > > +     ret = binder_genl_init(&binder_device->context.genl_family, name);
> > > +     if (ret < 0)
> > > +             kfree(binder_device);
> >
> > So I think that binder_device->miscdev needs to be misc_deregister'ed
> > if we hit this error condition.
> >
> > > +
> > >       return ret;
> >
> > Probably adding an unwind ladder like this makes sense (completely untested!):
> >
> >         ret = misc_register(&binder_device->miscdev);
> >         if (ret < 0)
> >                 goto err_misc_deregister;

This should be:

		goto err_free_dev;

> >
> >         hlist_add_head(&binder_device->hlist, &binder_devices);
> >
> >         binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
> >         ret = binder_genl_init(&binder_device->context.genl_family, name);
> >         if (ret < 0);
> >                 goto err_misc_deregister;
> >
> >         return 0;
> >
> > err_misc_deregister:
> >         misc_deregister(&binder_device->miscdev);
> > err_free_dev:
> >         kfree(binder_device);
> >         return ret;
> >
> 
> Good catch! Will fix it in the next revision.

Thanks.

> 
> > ...
> >
> > > diff --git a/drivers/android/binder_genl.h b/drivers/android/binder_genl.h
> >
> > Perhaps it is because of a different version of net-next,
> > but with this patch applied on top of the current head commit
> > 13feb6074a9f ("binder: report txn errors via generic netlink (genl)")
> > I see:
> >
> > $ ./tools/net/ynl/ynl-regen.sh -f
> > $ git diff
> >
> > diff --git a/include/uapi/linux/android/binder_genl.h b/include/uapi/linux/android/binder_genl.h
> > index ef5289133be5..93e58b370420 100644
> > --- a/include/uapi/linux/android/binder_genl.h
> > +++ b/include/uapi/linux/android/binder_genl.h
> > @@ -3,12 +3,17 @@
> >  /*     Documentation/netlink/specs/binder_genl.yaml */
> >  /* YNL-GEN uapi header */
> >
> > -#ifndef _UAPI_LINUX_BINDER_GENL_H
> > -#define _UAPI_LINUX_BINDER_GENL_H
> > +#ifndef _UAPI_LINUX_ANDROID/BINDER_GENL_H
> > +#define _UAPI_LINUX_ANDROID/BINDER_GENL_H
> >
> >  #define BINDER_GENL_FAMILY_NAME                "binder_genl"
> >  #define BINDER_GENL_FAMILY_VERSION     1
> >
> > +/**
> > + * enum binder_genl_flag - Used with "set" and "reply" command below, defining
> > + *   what kind \ of binder transactions should be reported to the user space \
> > + *   administration process.
> > + */
> >  enum binder_genl_flag {
> >         BINDER_GENL_FLAG_FAILED = 1,
> >         BINDER_GENL_FLAG_DELAYED = 2,
> > @@ -34,4 +39,4 @@ enum {
> >         BINDER_GENL_CMD_MAX = (__BINDER_GENL_CMD_MAX - 1)
> >  };
> >
> > -#endif /* _UAPI_LINUX_BINDER_GENL_H */
> > +#endif /* _UAPI_LINUX_ANDROID/BINDER_GENL_H */
> 
> The patch was based on the top of Linus's tree instead of net-next.
> I'll investigate this difference.

Likewise, thanks.
If this patch is targeted at net-next you should base it on that tree.

Also, on that topic, if so the target should be noted in the subject.

	Subject: [PATCH net-next vX] ...

