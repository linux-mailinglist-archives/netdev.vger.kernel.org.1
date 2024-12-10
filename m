Return-Path: <netdev+bounces-150448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAEE9EA443
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98CC28167B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E769D2B;
	Tue, 10 Dec 2024 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rt1Zf/92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C713AC1
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793990; cv=none; b=B2YI4tPNJb2Kr7adojE+4GV9WNHk7JmO/cohwv7VNl/n3wfGSUJR5x0H1n6c/akI3B1j1DTNP906re76ub2PVrv4FcHFE97JvC7N/lD85jzOUA95b7vQNkalzt9Y4CzT2AxLw7TPuM0bXFY+tD5n8fdN8IHEtRkRyGs5ieXsW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793990; c=relaxed/simple;
	bh=ixF0VPIzHuVDbPXcy21RqGz9blPuTk29DS13qIWNBj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9P3U1Te9gwWRGwj64UlsBMt5ShheDsAAxNeM7XZULX4tAD7Z33z9ozxdhdT+OpjGhRnssHP9pwvbrfwmAYlIjEJLm1MSFhDQFlY97dfD3T9NTOcahtdiCkq0X3CgEgITXwLP0j/xclbTqm21/6ZCYsap9sp0PkOwEccmKrul4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rt1Zf/92; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401e6efffcso1799170e87.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 17:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733793985; x=1734398785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYoNJjutLDL8bWYofjQjJsDnCJogChOFyv9WviJQg9s=;
        b=Rt1Zf/92lmkIJUyAR4GrRWL8sg1VYSg3kSDbqOhlw+zzIW8o8ipGrVMVYGRL2bIp7k
         KnvBHIyuULCmTeL+EQA4RV8kCIE4Gq2g1YxbsLGmzUk/ycn74uY+cWm6Selpgd/JyNNF
         gnQVsHhq/fd7PZLZykyPQCC5ZHfBPEcEUK084=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793985; x=1734398785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYoNJjutLDL8bWYofjQjJsDnCJogChOFyv9WviJQg9s=;
        b=NSDWrKzAzC/p3Kf7vL9w9t+MJ/GEmYJWbvUObcx7VLPbeOg4nxgCt9PVXw6aG3VP2Y
         Ab4zU4lfdDeVGLJ8yoSc8boPccRWD1waJOJyP3yyF+UGXCh7k6kc+ct0fPHMsNHBzpS6
         Bgg5rLMD5Lm7TDrpMRFoM48GPxT7aYi43YgAKKd3nVTGyLqetzkQ/TrZuJ2KPBpQu/Gi
         QV6zw2GAUZ1kTDyPvzqvNL9lIPQKusPubBllWmdxbb/3s2rmtNBKpKUaYJla0kW4Y7GN
         jbnvN7NXASDbTZ1mcr7xRt/UHEJV/fOGlnGlkfo5GoPIZA9jtG3H4/OKEVrOMXCNy28Z
         4WVw==
X-Forwarded-Encrypted: i=1; AJvYcCVO3wPN6liK7wO/mgUiluqzbxK5Ol6w+F2+wIOkwt5+M6REwuLDVVOeq5RmPLvGonGX6RgMnmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1HCw1vdQ4AqusHm6Iwoq2bkv2ENZNc6KnAPyzq5GbSaov4BY
	mgblu364G9CDEY/F7Ib9AP8K88QH1SrzdXTZk4T7U5gxFqDps8xZ1OjU7ndF/07gozXKhhw7R+y
	5cqwyn5S/jUai3RvcdDQ5AzR8qn/UEpzoJN1w
X-Gm-Gg: ASbGncscJ3BJGrNS4ZEa1qx8mmjokjIpeobbbIF9zLD6n0ZtZ8aaxvpMqftGMEu4Seh
	d3r3XGkNofzErLWspYZQjheSeF44KWTiufW0=
X-Google-Smtp-Source: AGHT+IHyN7pTZ9u28W97gA3Nbf8uzvSQca6fKB7G14fCrZ91carrQGgix67OESSQuW+D9/drXbyeNSBcsOanKiZgBD4=
X-Received: by 2002:a05:6512:39c4:b0:53e:2ed9:8122 with SMTP id
 2adb3069b0e04-540240bd4cfmr1082700e87.22.1733793985506; Mon, 09 Dec 2024
 17:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209192247.3371436-1-dualli@chromium.org> <20241209192247.3371436-2-dualli@chromium.org>
 <Z1eO-Nu0aowZnv6t@google.com>
In-Reply-To: <Z1eO-Nu0aowZnv6t@google.com>
From: Li Li <dualli@chromium.org>
Date: Mon, 9 Dec 2024 17:26:14 -0800
Message-ID: <CANBPYPgU9uL9jdxqsri=NwLTJcFpzdB313QsYjSQAuopRppTDw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/1] binder: report txn errors via generic netlink
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

On Mon, Dec 9, 2024 at 4:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Mon, Dec 09, 2024 at 11:22:47AM -0800, Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > Frozen tasks can't process binder transactions, so sync binder
> > transactions will fail with BR_FROZEN_REPLY and async binder
> > transactions will be queued in the kernel async binder buffer.
> > As these queued async transactions accumulates over time, the async
> > buffer will eventually be running out, denying all new transactions
> > after that with BR_FAILED_REPLY.
> >
> > In addition to the above cases, different kinds of binder error codes
> > might be returned to the sender. However, the core Linux, or Android,
> > system administration process never knows what's actually happening.
>
> I don't think the previous two paragraphs provide anything meaninful
> and the explanation below looks enough IMO. I would just drop the noise.

That makes sense. I'll remove them. Thanks!

>
> >
> > Introduce generic netlink messages into the binder driver so that the
> > Linux/Android system administration process can listen to important
> > events and take corresponding actions, like stopping a broken app from
> > attacking the OS by sending huge amount of spamming binder transactions=
.
> >
> > The new binder genl sources and headers are automatically generated fro=
m
> > the corresponding binder_genl YAML spec. Don't modify them directly.
>
> I assume "genl" comes from "generic netlink". Did you think about using
> just "netlink". IMO it provides better context about what this is about.
>

Yes, "genl" has been widely used in the Linux kernel. But I'm fine to renam=
e
it to just "netlink". I'll change it in v10 unless there's other opinions.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=
=3Dgrep&q=3Dgenl
https://man7.org/linux/man-pages/man8/genl.8.html

> >
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  Documentation/admin-guide/binder_genl.rst    |  96 +++++++
>
> We already have a "binderfs" entry. Perhaps, we should just merge your
> Documentation with that one and call it "binder" instead?
> You might want to run this by Christian Brauner though.
>

I'm happy to merge it if the doc maintainers like this idea. Or we can do
it in a separate patch later.

> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Generic Netlink for the Android Binder Driver (Binder Genl)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The Generic Netlink subsystem in the Linux kernel provides a generic w=
ay for
> > +the Linux kernel to communicate to the user space applications via bin=
der
>
> nit: s/communicate to/communicate with/

Would fix it. Thanks!

>
> > +driver. It is used to report various kinds of binder transactions to u=
ser
> > +space administration process. The driver allows multiple binder device=
s and
>
> The transactions types that I'm familiar with are sync/async. I think
> you want to say "report transaction errors" or something like that
> instead?
>

Yes, it means the transaction error code. I'll make it clearer.

> > +their corresponding binder contexts. Each context has an independent G=
eneric
> > +Netlink for security reason. To prevent untrusted user applications fr=
om
> > +accessing the netlink data, the kernel driver uses unicast mode instea=
d of
> > +multicast.
> > +
> > +Basically, the user space code uses the "set" command to request what =
kind
>
> Can you use the actual command? e.g. BINDER_GENL_CMD_SET
>
> BTW, why set? what are we setting? Would *_REPORT_SETUP be more
> appropriate?
>

Hmm, I intentionally make them short in the netlink YAML file.
Otherwise the generated code/name is quite long. But if this is
causing confusion, I'm happy to use a more descriptive (and longer)
name.

> > +of binder transactions should be reported by the kernel binder driver.=
 The
> > +driver then echoes the attributes in a reply message to acknowledge th=
e
> > +request. The "set" command also registers the current user space proce=
ss to
> > +receive the reports. When the user space process exits, the previous r=
equest
> > +will be reset to prevent any potential leaks.
> > +
> > +Currently the driver can report binder transactions that "failed" to r=
each
> > +the target process, or that are "delayed" due to the target process be=
ing
>
> "Delayed" transaction is an entirely new concept. I suppose it means
> async + frozen. Why not use that?
>
> Also, per this logic it seems that a "delayed" transaction could also be
> "spam" correct? e.g. the flags are not mutually exclusive.

It depends on the actual implementation. Currently each binder
transaction only returns one single error code. A "spam" one also
indicates it's a "delayed" one.

>
> > +frozen by cgroup freezer, or that are considered "spam" according to e=
xisting
> > +logic in binder_alloc.c.
> > +
> > +When the specified binder transactions happen, the driver uses the "re=
port"
> > +command to send a generic netlink message to the registered process,
> > +containing the payload struct binder_report.
> > +
> > +More details about the flags, attributes and operations can be found a=
t the
> > +the doc sections in Documentations/netlink/specs/binder_genl.yaml and =
the
> > +kernel-doc comments of the new source code in binder.{h|c}.
> > +
> > +Using Binder Genl
> > +-----------------
> > +
> > +The Binder Genl can be used in the same way as any other generic netli=
nk
> > +drivers. Userspace application uses a raw netlink socket to send comma=
nds
> > +to and receive packets from the kernel driver.
> > +
> > +.. note::
> > +    If the userspace application that talks to the driver exits, the k=
ernel
> > +    driver will automatically reset the configuration to the default a=
nd
> > +    stop sending more reports to prevent leaking memory.
>
> I'm not sure what you mean by preventing memory leaks. What happens when
> userspace setups the report and doesn't call "recv()"? Is that what we
> are worried about?
>

Probably "leaking memory" isn't accurate here. If the user app
doesn't call recv(), the netlink message would just fail to send.
There's no memleak. But I think it's a good idea to reset the
configuration. Let me describe it in a better way.

> > +
> > +Usage example (user space pseudo code):
> > +
> > +::
> > +
> > +    // open netlink socket
> > +    int fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> > +
> > +    // bind netlink socket
> > +    bind(fd, struct socketaddr);
> > +
> > +    // get the family id of the binder genl
> > +    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME,
> > +            BINDER_GENL_FAMILY_NAME);
>
> ok, what is happening here? this is not a regular send(). Is this
> somehow an overloaded send()? If so, I had a really hard time trying to
> figuring that out so might be best to rename this.
>

This pseudo code means a few attributes are sent by a single send().

> > +     if (flags !=3D (flags & (BINDER_GENL_FLAG_OVERRIDE
> > +                     | BINDER_GENL_FLAG_FAILED
> > +                     | BINDER_GENL_FLAG_DELAYED
> > +                     | BINDER_GENL_FLAG_SPAM))) {
> > +             pr_err("Invalid binder report flags: %u\n", flags);
> > +             return -EINVAL;
> > +     }
>
> didn't Jakub mentioned this part wasn't needed?
>

Good catch! I removed them but somehow didn't commit the change.


> > +int binder_genl_nl_set_doit(struct sk_buff *skb, struct genl_info *inf=
o)
> > +{
> > +     int portid;
> > +     u32 pid;
> > +     u32 flags;
> > +     void *hdr;
> > +     struct binder_device *device;
> > +     struct binder_context *context =3D NULL;
>
> nit: would you mind using reverse christmas tree for this variables
> and also in other functions too?
>

Sure.

> > +
> > +     hlist_for_each_entry(device, &binder_devices, hlist) {
> > +             if (!nla_strcmp(info->attrs[BINDER_GENL_A_CMD_CONTEXT],
> > +                             device->context.name)) {
> > +                     context =3D &device->context;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!context) {
> > +             NL_SET_ERR_MSG(info->extack, "Unknown binder context\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     portid =3D nlmsg_hdr(skb)->nlmsg_pid;
> > +     pid =3D nla_get_u32(info->attrs[BINDER_GENL_A_CMD_PID]);
> > +     flags =3D nla_get_u32(info->attrs[BINDER_GENL_A_CMD_FLAGS]);
> > +
> > +     if (context->report_portid && context->report_portid !=3D portid)=
 {
> > +             NL_SET_ERR_MSG_FMT(info->extack,
> > +                                "No permission to set flags from %d\n"=
,
> > +                                portid);
> > +             return -EPERM;
> > +     }
> > +
> > +     if (binder_genl_set_report(context, pid, flags) < 0) {
> > +             pr_err("Failed to set report flags %u for %u\n", flags, p=
id);
> > +             return -EINVAL;
> > +     }
>
> With the flags check being unnecessary you probably want to fold
> binder_genl_set_report() here instead.
>

Sorry, I don't quite understand this request. Can you please explain it?

> > +/**
> > + * Add a binder device to binder_devices
> > + * @device: the new binder device to add to the global list
> > + *
> > + * Not reentrant as the list is not protected by any locks
> > + */
> > +void binder_add_device(struct binder_device *device)
> > +{
> > +     hlist_add_head(&device->hlist, &binder_devices);
> > +}
>
> nit: would you mind separating the binder_add_device() logic into a
> separate "prep" commit?
>

Sure.

> > +
> >  static int __init init_binder_device(const char *name)
> >  {
> >       int ret;
> > @@ -6953,6 +7217,7 @@ static int __init init_binder_device(const char *=
name)
> >       }
> >
> >       hlist_add_head(&binder_device->hlist, &binder_devices);
> > +     binder_device->context.report_seq =3D (atomic_t)ATOMIC_INIT(0);
>
> I don't think this is meant to be used like this.
>
> Also, binder_device is kzalloc'ed so no need to init report_seq at all.
>

I'll remove this unnecessary code.

> >
>
>
> Also, how is userspace going to determine that this new interface is
> available? Do we need a new entry under binder features? Or is this not
> a problem?

It's not a problem. The generic netlink command "getfamily" will fail.

>
> Regards,
> --
> Carlos Llamas

