Return-Path: <netdev+bounces-156076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E841FA04DF9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF63A5B80
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E75185B72;
	Wed,  8 Jan 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ty5yIueI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1D71747
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294454; cv=none; b=eGn1v2JRmeGb/vK6zEoPDQQKr7oU62zwiqMx0vOo0ChMdFvZUAzEWT3kzOWeeNSxU+yWshseqQXbANCQwLMzAozur29DKF5auTSTGynKWIclZlsuIMipRk5x92JnS1lozs5gt7OFYTxTy3hgN2jgFtHAqw+1izkBcp9SERgOAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294454; c=relaxed/simple;
	bh=efeb6IKA6CWFmplhQRqI1GLfqgWUAOJHHG/zTYrSz4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MunTXpqlp0KsItqoa6cgugqUm8OOeaUFMwv01hUeFMKXSnHGaC0lm7KvpG7SIR2FE0lnvOWmUTek5vicD9Y+EKvn20wEo4wdK/XUmSqDHCPEzWodndajyTPxAy+d6A8GmCqp+SnslFKHnY2XqAAKLBYTCtHkQAbtaE7Azqzys/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ty5yIueI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso213426541fa.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736294451; x=1736899251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs5r7qruNqdlPjkv1LKSj9EfkEYQzhLuEJDyGwUeSNc=;
        b=Ty5yIueI2DOc4uvVTHhjzNlu0MQPUswzqNiZGn9CgmlkzcrOBjTDsA2HUJjhfa/vZw
         64H6/7DQtxvzS5GXIhO7ZuKyDoQagrkv50/GRUiFXa9EACZXMqgEnpZv47WqQ4+VQFH3
         5fmT0XT0gdtA2wmbGHuci3KRs4OazB4gHnBtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736294451; x=1736899251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs5r7qruNqdlPjkv1LKSj9EfkEYQzhLuEJDyGwUeSNc=;
        b=OzF7syjwoNCK+A7Tvj8XvLl+Um46ZFjwS05bK0oah3hezoLaX1eBg7NjLYeY5AAR+X
         OJJfhAfRgpf38rh3qr4PFyf4ZJfPFkeE58r9Zjt58/fuLp2uCu5IO9g85h8NDW0fKylv
         ztLZ8MYqGL8Jqe7xdz6pLLmXiZ1U6jwTIhKpCay+Zc+7qMnP8iKtxoIuV7gkVZJSRYVI
         jly2XVTJkHh09YIXSVCNFZAG757X7d90y36iU/XtOhquLmPDkMalL2uu6kbyEDpm+Wxl
         TXMhGlijYneFqNnJSZf+T73HGOmxZZ0jqHRm74dr2vDzbNxsHl0FSsOUEIMMt5+TVr/W
         tAbw==
X-Forwarded-Encrypted: i=1; AJvYcCV4KFMQ/4qOVvs12eCCg/+OIP1AwVc5Zel590/A6j+sI9dnUoXU6DM4LWpUNs6XvyA5aKQzNy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyorA4/3NyHXEaWEtTI3AhQ4iNU+GIBmKh9G2BMB4rX8XMfIyZM
	rmCCb858N2W/IV6ms98np+Zayej+shWcr4y4z5/0Ls4RLoM1FQhkeE9afsPFcpAdAmL7mIFY2VY
	uhswpp447668Ws3i31F0wA0B1yg2mAnfsTgJB
X-Gm-Gg: ASbGnctHZxrPMwIXY/H+fWJs33dhML3cZFrijsXzVLs+HdhQ7RGqIoKc5Cv2oiHIrYT
	C0busVjyXUn6i6PVUtlsVBfugbY7JpM58dLKTVw==
X-Google-Smtp-Source: AGHT+IEzt4RO1hjklyS4P2xNYgMYFSv62RrtHXsH914HaAhXfGN8GKeW1sucVBIxF5pCXFzHcVV/aFcMZ3ILduo+RZk=
X-Received: by 2002:a2e:b8c9:0:b0:2fb:5f9d:c284 with SMTP id
 38308e7fff4ca-305f45746d2mr1777441fa.16.1736294450704; Tue, 07 Jan 2025
 16:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218203740.4081865-1-dualli@chromium.org> <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com> <Z32fhN6yq673YwmO@google.com>
In-Reply-To: <Z32fhN6yq673YwmO@google.com>
From: Li Li <dualli@chromium.org>
Date: Tue, 7 Jan 2025 16:00:39 -0800
X-Gm-Features: AbW1kvaeaKJkuflGdQcFNu4DOYzONz1D1PKxkOmRi2aC1Rq57aObwWksP1EbGMA
Message-ID: <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
To: Carlos Llamas <cmllamas@google.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 1:41=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Tue, Jan 07, 2025 at 09:29:08PM +0000, Carlos Llamas wrote:
> > On Wed, Dec 18, 2024 at 12:37:40PM -0800, Li Li wrote:
> > > From: Li Li <dualli@google.com>
> >
> > > @@ -6137,6 +6264,11 @@ static int binder_release(struct inode *nodp, =
struct file *filp)
> > >
> > >     binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
> > >
> > > +   if (proc->pid =3D=3D proc->context->report_portid) {
> > > +           proc->context->report_portid =3D 0;
> > > +           proc->context->report_flags =3D 0;
> >
> > Isn't ->portid the pid from the netlink report manager? How is this eve=
r
> > going to match a certain proc->pid here? Is this manager supposed to
> > _also_ open a regular binder fd?
> >
> > It seems we are tying the cleanup of the netlink interface to the exit
> > of the regular binder device, correct? This seems unfortunate as using
> > the netlink interface should be independent.
> >
> > I was playing around with this patch with my own PoC and now I'm stuck:
> >   root@debian:~# ./binder-netlink
> >   ./binder-netlink: nlmsgerr No permission to set flags from 1301: Unkn=
own error -1
> >
> > Is there a different way to reset the protid?
> >
>
> Furthermore, this seems to be a problem when the report manager exits
> without a binder instance, we still think the report is enabled:
>
> [  202.821346] binder: Failed to send binder netlink message to 597: -111
> [  202.821421] binder: Failed to send binder netlink message to 597: -111
> [  202.821304] binder: Failed to send binder netlink message to 597: -111
> [  202.821306] binder: Failed to send binder netlink message to 597: -111
> [  202.821387] binder: Failed to send binder netlink message to 597: -111
> [  202.821464] binder: Failed to send binder netlink message to 597: -111
> [  202.821467] binder: Failed to send binder netlink message to 597: -111
> [  202.821344] binder: Failed to send binder netlink message to 597: -111
> [  202.822513] binder: Failed to send binder netlink message to 597: -111
> [  202.822152] binder: Failed to send binder netlink message to 597: -111
> [  202.822683] binder: Failed to send binder netlink message to 597: -111
> [  202.822629] binder: Failed to send binder netlink message to 597: -111

As the file path (linux/drivers/android/binder.c) suggested,
binder driver is designed to work as the essential IPC in the
Android OS, where binder is used by all system and user apps.

So the binder netlink is designed to be used with binder IPC.

The manager service also uses the binder interface to communicate
to all other processes. When it exits, the binder file is closed,
where the netlink interface is reset.

