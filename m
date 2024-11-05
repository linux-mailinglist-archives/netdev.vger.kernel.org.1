Return-Path: <netdev+bounces-142092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5457B9BD75D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867931C2217D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9004215F55;
	Tue,  5 Nov 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="facS9XCx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8521503D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840423; cv=none; b=LEwa2CyOvzHU+Mn/mevt+lcKd/5edEvvZl11KKXq3n51gKz3VsDRaW3+AnQKKk+Vg4grpSates7r0XE+idKBbU9CHKV72dJQeZFImxke3xaJ8UIOvbJpMwvk7JZjZeefutV75bwSR3L552Pe5AUpTUnYddhwhqqvDKPezqvhR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840423; c=relaxed/simple;
	bh=MN2ruZ0VOrI2i0kohnHZRuWwCeg2TRdQb6aoQx1dOs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBIXwN8CH4ZbxZgQsbYHtr8FiG9ODBrzFfuALhHgHR1QywTuS5an0NB/NlziV4Hbk+RHrTQw+k7KqkItj7dPm+uQFy4W326j9WaDUNY8zUwIPwKZzm8YFyhhYiHfMqHKjZRN5TiBT+gvlCpcJKe/bn/nlTdU07Ny8HTczSq8PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=facS9XCx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3110b964so49792451fa.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730840420; x=1731445220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN2ruZ0VOrI2i0kohnHZRuWwCeg2TRdQb6aoQx1dOs4=;
        b=facS9XCxnU62Ysu2QFAsSRYccKrjd8e0okW9XyP+sC5akqAG9LK1ykI6/F0DJOW2S3
         yS4H7AxwG9qMgkYDReZ01pnf+k4I1f70IRh3RJtyjBmDB+7V2qSdip3lkyuii7560l/4
         mn1cf29AiiUbuFqXTe9RyrGdQEX3okrtYvQ3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840420; x=1731445220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN2ruZ0VOrI2i0kohnHZRuWwCeg2TRdQb6aoQx1dOs4=;
        b=ENSeAdYRHcGMcq+LR2bAyAFYLSNY/Xyu0HYnyX1gndaN9nK9pSOAHGx7j2Lf0Am9qi
         pjSBLFhBc/7EiUCb1txPlXDbpKXyS7s26W8Dgo4Kq5K8JXsNxO5Tt3YaqPrkFoPh4Whj
         DVVm1XxdGM/1S58QNF/SRr8zsXfhkFjvS7zKQC4o7czLHQj1aFYuOlLGy1Vb45omJLVA
         B5ce+/Ng8M+WGzUmDgxBpqPI/bE6wvcA0rN05muHuH1A/EcN31RevTScXRBkMQE65zTe
         cSL/Q3DwuXCc2Ul0kYDv9GbDXqEuPp5kO1fBAtRGAmuZGQB6pCtoXH3oSSqybPwOLXSX
         PJdA==
X-Forwarded-Encrypted: i=1; AJvYcCWWaSFOgcSKYYzoF9OQ0ZMcnZO2sh9Fc2O9Z+RMIW3IPvS65GNyTPPSqRuiM5kMqmc+Qr0Pin4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLdKBPCVl+xC7OzJSoHDtA7IwLU7pJ8CZvVjtLlU/8s9jc3gH
	1pagWtmLJuKAont5YrFutA/4Hs1T9FeVmjoJrudgSQcGE+S9k46xnkAXZGijb6uHQ1Sb38yjvbH
	oVqjs6gKYKdiR579eoJjbaYdlYfI4HnY1RZMr
X-Google-Smtp-Source: AGHT+IEwGFHiCBaTGoA+RhTutEqPmNN7Op7UcTLhRMCVmMlUY3axoyobc/qPEt3uOSIq9yaCFJ6R9bssTX2h26huqb4=
X-Received: by 2002:a05:651c:98d:b0:2f7:53b8:ca57 with SMTP id
 38308e7fff4ca-2fedb790772mr88326231fa.19.1730840419827; Tue, 05 Nov 2024
 13:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031092504.840708-1-dualli@chromium.org> <20241031092504.840708-3-dualli@chromium.org>
 <20241103151554.5fc79ce1@kernel.org> <CANBPYPj4VCYuhOTxPSHBGNtpRyG5wRzuMxRB49eSDXXjrxb7TA@mail.gmail.com>
 <20241104081928.7e383c93@kernel.org> <CANBPYPjo0KKm3JbPk=E8Nuv05i=EeR93PHWjSU8fcH-GVWV94w@mail.gmail.com>
 <20241104184139.3eb03c69@kernel.org>
In-Reply-To: <20241104184139.3eb03c69@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Tue, 5 Nov 2024 13:00:08 -0800
Message-ID: <CANBPYPjq5BC3t-kF2Kcbs4tdCd=Zzd4Qk3mzRg-qyda3tEE3sA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com, 
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 4 Nov 2024 09:12:37 -0800 Li Li wrote:
> > That's why binder genl uses unicast instead of multicast. The administr=
ation
> > process of the OS (Android in this case) always runs before any other u=
ser
> > applications, which registers itself to the kernel binder driver and us=
es it
> > exclusively. With a unified family name, the same userspace admin proce=
ss
> > has access to all binder contexts. With separate family names, each dom=
ain
> > admin process can register itself to the corresponding binder context.
>
> Side note - it'd be useful for my understanding to know what the binder
> families would be. You register them in binderfs_binder_device_create(),
> what creates the devices and how many do we expect?

There are 2 ways to create a new binder device.
1. Provide a list of devices (as strings) in boot cmd;
2. Call an API provided by binderfs in the system init process.

There are 3 domains as mentioned at
https://source.android.com/docs/core/architecture/hidl/binder-ipc#ipc

>
> Back to answering - I don't know why the same process would have to bind
> to all domains. You record which portid is bound to the context, the port=
id
> identifies the socket.
>
> BTW portids can get reused, do you need to do something when the admin
> process dies? To prevent normal user from binding to the same portid?

When the admin process dies, the kernel driver automatically releases the
binder fd and resets the netlink. So a normal user won't be able to bind
to the same portid. The admin process will respawn itself and re-initialize
everything.

>
> > So, do you think the current implementation of registering multiple fam=
ilies
> > with different names acceptable? Or is there a better way to do it? Tha=
nk
> > you very much!
>
> I don't see what having the separate families buys you.
> The genl family ID is added to the netlink message in nlmsg_type.
> That's it, it doesn't do anything else.
> You can add an attribute to the message to carry context->name
> and you'll be able to demux the messages.

You're right. Even though my userspace code uses different sockets to talk
to different binder genl families, the generic netlink socket doesn't enfor=
ce
this. Other apps can still use one socket to talk to different families.

I'll add a new attribute to demux the message, which should be able to achi=
eve
the same functionality.

