Return-Path: <netdev+bounces-156853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC164A08030
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12683A3E4E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E819DF6A;
	Thu,  9 Jan 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToL8ljCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBB199FB0
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448725; cv=none; b=L7DAAUsB/ZHhqniNh7PIZ5XA2/0hHUXcOE+AsnYcKeC0SIZIVncuS65lTusc2S4LF5/bWqwwd78WfDvLmrEi7wHPMjilVC/PcldlTxYqYab9LP82ApbE3IBvyDoCM9DsTDVR9GNClIi50xJVh2IC5Em8vkxrSTkScitoyMXX83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448725; c=relaxed/simple;
	bh=nK0/2Y3vHYxFDzU0fGt9iZboYWU0PmjHEd+H/QwUl+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=munIkf77dLUMJ34Qv73W+vMgVhoXOd2ed812T2QId8vCWbJkX50QkrafKVvcOWMwbTYoCSd9dDcLhe0Lj+0O9AKM97IrRXqRh2HHjZ8nnLRR0gcLdk7iTgXoNcXzDXChMIAkjTOqdU2FFam97jbYlGBiFaZhDkoli6mW8Aa3mQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToL8ljCY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f6ca9a81so10325ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448723; x=1737053523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyaoWSwPC0Zu+EGXJyxxL+6bVmHYUqZLMJYfZEnGh1A=;
        b=ToL8ljCYIlVv2XC5MY+tK0JJ2zU+C6a93orUYxRKqbOmHbdwY5BKWx5DUyvw3HowLR
         /RFg3eZzAsbJr5iYMXykOlU201pAkQak8vEczM5KGIAFKqxdN8eOD4LSeksg97JYOz9g
         1h9Msxotw6iikLNmuPj1dIbXJDJD/dPKIfQBdx4viFefxesJYNY7DbBXSkJc2fXCqHvO
         ylt7s7LbcwxBKxUoKtNmILb88qRFqBBhkHzYVHp/KXC4vGOMNRgSK8TdXo5xNfFi+Urj
         Zquu6KTU7xdbGrfeFwa3PLyd4X+UJSXWK3Am/Jn4yFKNWqj1gsfyoR5NxX0pMXwu06In
         +jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448723; x=1737053523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyaoWSwPC0Zu+EGXJyxxL+6bVmHYUqZLMJYfZEnGh1A=;
        b=Aoh/L/Ja3wUHnW/GIir9pYdgRCt6jI7ePNztLVaYDt6DhXluboFLdLOmAvcSI5g+n/
         Yb/LEXNdUkIEaesFntQZjKNfL5QZIoOsoqY3SSVpcaerJJkcluSDixbtsKhbAoeFrgzQ
         5VuTirfqD7NhbqdRfcUz9bXJLUGFujB9QDzJY8BfaDr9irO4ffjKZnBWMpTGgwpr6CPk
         Ee1CeHYmo0mX8w3iXLZu0XjYlGGiwycVv+q77ErzAa9CgXVgeXClCZo8egrvxeGs7a0F
         kj1bzkk7TPbMpysaCkjq9LAkbJna5t1BDGgOEXdCWXQpy2g05IciKhhNlCogBSKz43RA
         X6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuKHLqvaBGyUGom/d6rtcWF4GUDuP40+jo303JmC38QgurE+3xY6rq5LvVFcl7Le5E6fxgYbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSUnsY3spjA1Fp3Ew+zKanT+eUJIId7tJ/5AtKHszEVq4Rgf7
	nldXXUOfy868FFXb3XXmcA5MCjpvb+jDdFctIfY1IR4eFVqMepXqimWu/+RUUw==
X-Gm-Gg: ASbGncukX1/c/9nPX7cqHtdnN3Xc24R3vr0BYELGjSCVISakdu8FTj6Wq30Br+wfCa7
	sRzf8pTzwt3BcGFWvY1xIU/1+qJ+lT7dEMPTcWjnp0nbWP6621yMRsKjzKfPT6JjZsS/JkD21cH
	Vx41G3hzVn8v2aWyHtzmaXdlkJcKLWxaj7H2MsBMcNcuBYxUxJX9VimB1/9sTfYjPW4Mc3/JRxK
	Ip4M6UpjJkXcGi8WjUbMf2w6ndpK91PWr3nYb/NFxnH9wsqfHfC34fvhzRb9EYkuD6f4aqqh4fd
	q+tOTD3xrt8TzVsZ++g=
X-Google-Smtp-Source: AGHT+IHMmONjzAo9BqIQe7XqdyQWzW64sGl6Iou/pft83SRCuwhvbUokrsleTsR7Z7WKFgogy+MG+Q==
X-Received: by 2002:a17:903:3281:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-21aa0821c58mr99825ad.16.1736448723450;
        Thu, 09 Jan 2025 10:52:03 -0800 (PST)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219e44sm1111895ad.120.2025.01.09.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 10:52:02 -0800 (PST)
Date: Thu, 9 Jan 2025 18:51:59 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <Z4Aaz4F_oS-rJ4ij@google.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
 <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com>
 <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>

On Tue, Jan 07, 2025 at 04:00:39PM -0800, Li Li wrote:
> On Tue, Jan 7, 2025 at 1:41 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Tue, Jan 07, 2025 at 09:29:08PM +0000, Carlos Llamas wrote:
> > > On Wed, Dec 18, 2024 at 12:37:40PM -0800, Li Li wrote:
> > > > From: Li Li <dualli@google.com>
> > >
> > > > @@ -6137,6 +6264,11 @@ static int binder_release(struct inode *nodp, struct file *filp)
> > > >
> > > >     binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
> > > >
> > > > +   if (proc->pid == proc->context->report_portid) {
> > > > +           proc->context->report_portid = 0;
> > > > +           proc->context->report_flags = 0;
> > >
> > > Isn't ->portid the pid from the netlink report manager? How is this ever
> > > going to match a certain proc->pid here? Is this manager supposed to
> > > _also_ open a regular binder fd?
> > >
> > > It seems we are tying the cleanup of the netlink interface to the exit
> > > of the regular binder device, correct? This seems unfortunate as using
> > > the netlink interface should be independent.
> > >
> > > I was playing around with this patch with my own PoC and now I'm stuck:
> > >   root@debian:~# ./binder-netlink
> > >   ./binder-netlink: nlmsgerr No permission to set flags from 1301: Unknown error -1
> > >
> > > Is there a different way to reset the protid?
> > >
> >
> > Furthermore, this seems to be a problem when the report manager exits
> > without a binder instance, we still think the report is enabled:
> >
> > [  202.821346] binder: Failed to send binder netlink message to 597: -111
> > [  202.821421] binder: Failed to send binder netlink message to 597: -111
> > [  202.821304] binder: Failed to send binder netlink message to 597: -111
> > [  202.821306] binder: Failed to send binder netlink message to 597: -111
> > [  202.821387] binder: Failed to send binder netlink message to 597: -111
> > [  202.821464] binder: Failed to send binder netlink message to 597: -111
> > [  202.821467] binder: Failed to send binder netlink message to 597: -111
> > [  202.821344] binder: Failed to send binder netlink message to 597: -111
> > [  202.822513] binder: Failed to send binder netlink message to 597: -111
> > [  202.822152] binder: Failed to send binder netlink message to 597: -111
> > [  202.822683] binder: Failed to send binder netlink message to 597: -111
> > [  202.822629] binder: Failed to send binder netlink message to 597: -111
> 
> As the file path (linux/drivers/android/binder.c) suggested,
> binder driver is designed to work as the essential IPC in the
> Android OS, where binder is used by all system and user apps.
> 
> So the binder netlink is designed to be used with binder IPC.
> 
> The manager service also uses the binder interface to communicate
> to all other processes. When it exits, the binder file is closed,
> where the netlink interface is reset.

Did you happen to look into netlink_register_notifier()? That seems like
an option to keep the device vs netlink socket interface from mixing up.
I believe we could check for NETLINK_URELEASE events and do the cleanup
then. I'll do a quick try.

