Return-Path: <netdev+bounces-119023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8D953DD5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88F528B0EE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86768155385;
	Thu, 15 Aug 2024 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ+tHLEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13C14D708;
	Thu, 15 Aug 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763172; cv=none; b=sFSD9AMexrlAliPupFJJbKuIQJvLxl7VXxP9PKlJ9H1d6HzwSHFNCsIIrN6J7MNgGNQuuvp2Fa3/2MgHKOVXsu1pIqFjTQTB4BdCRuPPPTwY3r54ejbhDb8UsbQmO05kIPtJVxEuf4m8TdjxSw0NxKIVcy0TJLOO3jT0vO0EO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763172; c=relaxed/simple;
	bh=bvTlhlXNaVe0JPjLpRuKFXfFp3CAjwWT83vZcv58etE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvXJmSSzqrOmQNYw0ukL3eR5YQ8Cad3Q0FOaG/P+i+STkccGJHAM+M7q3eRRbtMeBzra438sM7hAwTymUgIkRCKElT1AyVHd1p5mmOJgExuygNzZ8qV5xRBasGeqWJxLW95wtZ4NOexesRpRGpL0936PxWZ+KDa3VDj2M2/+P70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ+tHLEx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a115c427f1so1081923a12.0;
        Thu, 15 Aug 2024 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723763170; x=1724367970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r2MVp98bZo761S4wGmdjk4zKZB2eYXUc53AD4ygWeNY=;
        b=RQ+tHLExtDFgEIvQB38drETN4qTFmF4hu1SoVfvd+SBfR5rL3eQOBrUHSoxJYu/Imz
         WIYeBcgmiz2j08qxos4TKiZCXgLQVxnoRzhx4FiEdInd+Qle2jild4Vhsfo2swZ0K2lW
         MB/OPhjZc3cUb2mLi2AAF9ffjYJmtScBIaAMc1Cpwr6o0a0/Hx0aRujSn8TJSLcc4t8u
         ClhOYJ0bpoFd46ifg7yrkoGXpQYp257trt2AYNhrzdZJ7zG7QcdbJUKe4PZfj459ZO3m
         /BXZ1NiJUdBnMsLXr37D1kCA3O/FWDPzo9HcddQ7wNzBEFQBfm7thLRg8x4G/1iejB8/
         fmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763170; x=1724367970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2MVp98bZo761S4wGmdjk4zKZB2eYXUc53AD4ygWeNY=;
        b=qHuKSLIlzs/3yaiX+wSubDipZ0ax7vEoPu5yDzY1rGBF3L6VDhvfEgxHLmX4zTR9Ss
         E3bvpDlidXjHDntkj3Q/RqK6ZSsCEkOwZ27oHhZxxOMDVN4i6do3R4UCXzv0a2BLUXcg
         AGj4QExoguE2slcmlhQzhcOH8BcSUuEykTM17CX7traJGbIEk23dyytC/iNgNWlPWoMJ
         vkC8JElzJFI5q01xP62W5UyNWzjrpjfRBOPty5MCyxfRxaQp60H4hXHcjuJ+FJ+2TrrP
         58B3Dtb8olPY0bJYYwZ7nzh/vUPPmjTjOBQjzw9venoiW4H6Kf7P09pY6m28yu/WqT6k
         kv6g==
X-Forwarded-Encrypted: i=1; AJvYcCXdsc/yj17EvWbQ5G/bJw53fK2IS2F6wxkr6XxVUTvOCoRCi2JGWHPz04N70qptLH3bblqCmZF2qF7eWLAOYX08U8tmQxQTU58HCTdK8ACo24Pojm9tzL52t6K/he1YaVN1KU+4zeAirLfL/XHhMMDUxIo63ynhIWwd/qZrQcwqlRo2IkvlaMybWewK
X-Gm-Message-State: AOJu0YxYwO6a9ns+sow12OQpfSqTyAUWzIzzA48s+mH/92BFODqlXJgU
	8nshlbPzPoEsfhOBuiMqavY+3izwcLZ1c+VH6P/wA23a3PRD3rKx
X-Google-Smtp-Source: AGHT+IGXM/Mqg9qSgfOA6fMJ1xt6FPn83RQRVebx68PrCIT9+I7807vn1nG8ky9ebKzf39dbjaw4Wg==
X-Received: by 2002:a05:6a20:c88a:b0:1c8:95c9:307c with SMTP id adf61e73a8af0-1c904fb6489mr1756065637.28.1723763170085;
        Thu, 15 Aug 2024 16:06:10 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0756dsm1508384b3a.47.2024.08.15.16.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:06:09 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:06:07 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/6] Landlock: Adding file_send_sigiotask signal
 scoping support
Message-ID: <Zr6J31ewINPtPtTD@tahera-OptiPlex-5000>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
 <CAG48ez2Sw0Cy3RYrgrsEDKyWoxMmMbzX6yY-OEfZqeyGDQhy9w@mail.gmail.com>
 <Zr5y53Bl6cgdLKjj@tahera-OptiPlex-5000>
 <CAG48ez1PcHRDhRjtsq_JAr5e6z=XNjB1Mi_jjtr8EsRphnnb2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1PcHRDhRjtsq_JAr5e6z=XNjB1Mi_jjtr8EsRphnnb2g@mail.gmail.com>

On Fri, Aug 16, 2024 at 12:10:44AM +0200, Jann Horn wrote:
> On Thu, Aug 15, 2024 at 11:28 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> >
> > On Thu, Aug 15, 2024 at 10:25:15PM +0200, Jann Horn wrote:
> > > On Thu, Aug 15, 2024 at 8:29 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > This patch adds two new hooks "hook_file_set_fowner" and
> > > > "hook_file_free_security" to set and release a pointer to the
> > > > domain of the file owner. This pointer "fown_domain" in
> > > > "landlock_file_security" will be used in "file_send_sigiotask"
> > > > to check if the process can send a signal.
> > > >
> > > > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > > > ---
> > > >  security/landlock/fs.c   | 18 ++++++++++++++++++
> > > >  security/landlock/fs.h   |  6 ++++++
> > > >  security/landlock/task.c | 27 +++++++++++++++++++++++++++
> > > >  3 files changed, 51 insertions(+)
> > > >
> > > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > > index 7877a64cc6b8..d05f0e9c5e54 100644
> > > > --- a/security/landlock/fs.c
> > > > +++ b/security/landlock/fs.c
> > > > @@ -1636,6 +1636,21 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
> > > >         return -EACCES;
> > > >  }
> > > >
> > > > +static void hook_file_set_fowner(struct file *file)
> > > > +{
> > > > +       write_lock_irq(&file->f_owner.lock);
> > >
> > > Before updating landlock_file(file)->fown_domain, this hook must also
> > > drop a reference on the old domain - maybe by just calling
> > > landlock_put_ruleset_deferred(landlock_file(file)->fown_domain) here.
> > Hi Jann,
> >
> > Thanks for the feedback :)
> > It totally make sense.
> > > > +       landlock_file(file)->fown_domain = landlock_get_current_domain();
> > > > +       landlock_get_ruleset(landlock_file(file)->fown_domain);
> > > > +       write_unlock_irq(&file->f_owner.lock);
> > > > +}
> > > > +
> > > > +static void hook_file_free_security(struct file *file)
> > > > +{
> > > > +       write_lock_irq(&file->f_owner.lock);
> > > > +       landlock_put_ruleset(landlock_file(file)->fown_domain);
> > I was thinking of if we can replace this landlock_put_ruleset with
> > landlock_put_ruleset_deferred. In this case, it would be better use of
> > handling the lock?
> 
> I don't think you have to take the "file->f_owner.lock" in this hook -
> the file has already been torn down pretty far, nothing is going to be
> able to trigger the file_set_fowner hook anymore.
That's right. Thanks.

> But either way, you're right that we can't just use
> landlock_put_ruleset() here because landlock_put_ruleset() can sleep
> and the file_free_security hook can be invoked from non-sleepable
> context. (This only happens when fput() directly calls file_free(),
> and I think that only happens with ->fown_domain==NULL, so technically
> it would also be fine to do something like "if (domain)
> landlock_put_ruleset(domain);".)
> If you test your current code in a kernel that was built with
> CONFIG_DEBUG_ATOMIC_SLEEP=y, this will probably print an warning
> message in the kernel log (dmesg). You're right that using
> landlock_put_ruleset_deferred() instead would fix that.
> 
> I think the right solution here is probably just to do:
> 
> static void hook_file_free_security(struct file *file)
> {
>   landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
> }
I think I will stick to this one since it is easier to understand. 
> Alternatively it would also work to do this - this code is probably a
> bit more efficient but also a little less clear:
> 
> static void hook_file_free_security(struct file *file)
> {
>   /* don't trigger might_sleep() for tearing down unopened file */
>   if (landlock_file(file)->fown_domain)
>     landlock_put_ruleset(landlock_file(file)->fown_domain);
> }
> 
> >
> > > > +       write_unlock_irq(&file->f_owner.lock);
> > > > +}

