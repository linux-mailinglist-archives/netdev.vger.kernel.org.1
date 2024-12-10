Return-Path: <netdev+bounces-150480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E634E9EA67B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA30E1664DF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89982248B3;
	Tue, 10 Dec 2024 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hC9n1dz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF091F63FF
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800616; cv=none; b=HkIQm0xWDcdlxOoMiu/biwcrsP/Ol+uSBHpbcD1iJF7mjdQMU+CHgt5Qve6GHASFjH4+3kT5VS7GmNLz24nD58ICMEWb46Sl7NsaI02c0Xx6pJhJcrQwiyvWwtA9NU+aOVYoDhHKgL/ska6St8cW76OcD1RtwZzjNN27QuPpjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800616; c=relaxed/simple;
	bh=/GoLVPdegz5WfgN44hKf4e74doRXqzMfX0EgQ4Latjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPmFvEEM3QN/D1DWrJumvY9yee6fEZCjPmsgX7Uy3UnxMOyyrQ+SGaXkKwYd+mHJVy/h3XuydV5gmSZkDcRDxVX+p8+JMFTf1PlRLjAqNkXz9dy05I2KejhKbuPI/7jcTJYFEmBKbBZXD0rJI2gdO7ThiCRuKr6GLyjXQzTqrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hC9n1dz0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215740b7fb8so30375ad.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 19:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733800612; x=1734405412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyZAZM+03wgjRqyQcrmh3VsxU1GwZ8Ve990auQ8WFdE=;
        b=hC9n1dz0GbisN9Qehiq0MltbEuHEzPH2LQvmmgQAUPhaCYoTisjHVJN5IcxPEQrvk9
         9gE1zWBZQ+tcdWQk3EaLU7xm2y5sBflfhHU+TCSZ3cKyJT9Hqfs+tfaD7Q1lTbTQVgEt
         WLz0/nHS5u7rp0n0Sb1xPKzQV66+dKPchDQwHP9c/ZVyIYeorbJ5dmdLL2iHZ3Kn/svd
         rKUEVLUOsYtFegIqCr7/VvXmCaMdFRjerrdCIt65VHoCff8puywX4qmA6SzrzHchUriy
         nGSVe9HuU38De8npxIMWM/SEYLa0HfXUUNp4YivtnaIlcPsCofbu8XMtt0QfDkKp6d8n
         5raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733800612; x=1734405412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyZAZM+03wgjRqyQcrmh3VsxU1GwZ8Ve990auQ8WFdE=;
        b=GD6hOrjtk+Om/+tIhzGV0aRdWw/a93FVNnkbDsz7/gdEqBKSy5N/WlNxLNezuRoATg
         WTwc8sXsSM7XoAqCXw6NyO/HsIkid3lfbjnoa4gPtiD48epb2upW1/wW55qgRynnTEyY
         OdjJDSc5yPnLecRXU7m/hTqzeMwcdrO3jlVWAgsJ878zoaxg/JcuKAIDlF9bPU17pOcH
         Ji5w95eqYHfH56z8qKiP1Kb9pyVZW7ej7rd1wfFIHvZ/6LRj5jJ498zvV/B44Z2AxT+S
         +Tf1N3scHS6PHiTfvyB7bNY5+3OxFn088F1rqKTameK3kcnC/9ezc8QKy+gPKuJfxluv
         I32A==
X-Forwarded-Encrypted: i=1; AJvYcCV85EAj0kCag80UWJ/q9HWpdvxXMs7ZUSKJJekqY5EsOEU9r02+OXXHm2pPdjARmEzSR0ue7ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KO1gZbcYd05m+jRQQNfwvd+cjGtd6nX8+5fQ3udKsdHbUciK
	DFPC2Q4V61CsJS10TZfiluf0y9ZyHXzIPBa5dB8dwIPbVa/RKhM1L8KoHHHLTA==
X-Gm-Gg: ASbGncsFd2dr73q9IcGUFt9V9T4JhIdW2yWpy1kmoucl/hBxiONgVELvzDu0sqPwpkv
	WlgMRJaPsgi2omsXTTMvGXil5p7C69RElbcU3Dfs6tF8NHhqH5w5YKdnmnsGZySRutDrHN3Qmn1
	FUJmKr0siZ667wXHwFXOtOySVXJtOffo5da4PfqBYzg7aQlgRouTTZ2d8uUnvFGUULsnYql+xjE
	0QItkp0FImhloFM9Njx2HYF5kfE23m0IJHdsEEJjimSMUjyn+TVlUUCSKN7N9C3hGXeJqn2iqq/
	wrpSjnGOI0MXoch6
X-Google-Smtp-Source: AGHT+IEHk3w35020sNJLvd1ZnWmGKVbCkDvXLIQL62Q4tuEbdvHsGeLIjwgwfhwf2ynqVl+wiEkXNQ==
X-Received: by 2002:a17:902:ccc9:b0:216:27f5:9dd7 with SMTP id d9443c01a7336-21674d4b288mr853415ad.11.1733800612329;
        Mon, 09 Dec 2024 19:16:52 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff97f2sm10676027a91.11.2024.12.09.19.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 19:16:51 -0800 (PST)
Date: Tue, 10 Dec 2024 03:16:48 +0000
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
Subject: Re: [PATCH net-next v9 1/1] binder: report txn errors via generic
 netlink
Message-ID: <Z1eyoA-8-XduIEJj@google.com>
References: <20241209192247.3371436-1-dualli@chromium.org>
 <20241209192247.3371436-2-dualli@chromium.org>
 <Z1eO-Nu0aowZnv6t@google.com>
 <CANBPYPgU9uL9jdxqsri=NwLTJcFpzdB313QsYjSQAuopRppTDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBPYPgU9uL9jdxqsri=NwLTJcFpzdB313QsYjSQAuopRppTDw@mail.gmail.com>

On Mon, Dec 09, 2024 at 05:26:14PM -0800, Li Li wrote:
> On Mon, Dec 9, 2024 at 4:44 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 11:22:47AM -0800, Li Li wrote:
> > > From: Li Li <dualli@google.com>
> > >
> > > Frozen tasks can't process binder transactions, so sync binder
> > > transactions will fail with BR_FROZEN_REPLY and async binder
> > > transactions will be queued in the kernel async binder buffer.
> > > As these queued async transactions accumulates over time, the async
> > > buffer will eventually be running out, denying all new transactions
> > > after that with BR_FAILED_REPLY.
> > >
> > > In addition to the above cases, different kinds of binder error codes
> > > might be returned to the sender. However, the core Linux, or Android,
> > > system administration process never knows what's actually happening.
> >
> > I don't think the previous two paragraphs provide anything meaninful
> > and the explanation below looks enough IMO. I would just drop the noise.
> 
> That makes sense. I'll remove them. Thanks!
> 
> >
> > >
> > > Introduce generic netlink messages into the binder driver so that the
> > > Linux/Android system administration process can listen to important
> > > events and take corresponding actions, like stopping a broken app from
> > > attacking the OS by sending huge amount of spamming binder transactions.
> > >
> > > The new binder genl sources and headers are automatically generated from
> > > the corresponding binder_genl YAML spec. Don't modify them directly.
> >
> > I assume "genl" comes from "generic netlink". Did you think about using
> > just "netlink". IMO it provides better context about what this is about.
> >
> 
> Yes, "genl" has been widely used in the Linux kernel. But I'm fine to rename
> it to just "netlink". I'll change it in v10 unless there's other opinions.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=genl
> https://man7.org/linux/man-pages/man8/genl.8.html

I am familiar with the "genl" e.g. as in genlmsghdr. However, it wasn't
immediately straight-forward to me the connection as it would have been
with "netlink".

I don't know what the convention is for this type of generic netlink
interfaces. Perhaps "genl" is more appropriate, I just know that using
"netlink" would have been more straight-forward (at least to me).

Maybe most others that are new to this binder interface will go through
the same "discovery" process I went through.

> 
> > >
> > > Signed-off-by: Li Li <dualli@google.com>
> > > ---
> > >  Documentation/admin-guide/binder_genl.rst    |  96 +++++++
> >
> > We already have a "binderfs" entry. Perhaps, we should just merge your
> > Documentation with that one and call it "binder" instead?
> > You might want to run this by Christian Brauner though.
> >
> 
> I'm happy to merge it if the doc maintainers like this idea. Or we can do
> it in a separate patch later.
> 
> > > +===========================================================
> > > +Generic Netlink for the Android Binder Driver (Binder Genl)
> > > +===========================================================
> > > +
> > > +The Generic Netlink subsystem in the Linux kernel provides a generic way for
> > > +the Linux kernel to communicate to the user space applications via binder
> >
> > nit: s/communicate to/communicate with/
> 
> Would fix it. Thanks!
> 
> >
> > > +driver. It is used to report various kinds of binder transactions to user
> > > +space administration process. The driver allows multiple binder devices and
> >
> > The transactions types that I'm familiar with are sync/async. I think
> > you want to say "report transaction errors" or something like that
> > instead?
> >
> 
> Yes, it means the transaction error code. I'll make it clearer.
> 
> > > +their corresponding binder contexts. Each context has an independent Generic
> > > +Netlink for security reason. To prevent untrusted user applications from
> > > +accessing the netlink data, the kernel driver uses unicast mode instead of
> > > +multicast.
> > > +
> > > +Basically, the user space code uses the "set" command to request what kind
> >
> > Can you use the actual command? e.g. BINDER_GENL_CMD_SET
> >
> > BTW, why set? what are we setting? Would *_REPORT_SETUP be more
> > appropriate?
> >
> 
> Hmm, I intentionally make them short in the netlink YAML file.
> Otherwise the generated code/name is quite long. But if this is
> causing confusion, I'm happy to use a more descriptive (and longer)
> name.

Short is fine. However, what is "SET"? In the future we might add more
commands to this interface and I can see this name being a problem at
that point.

> 
> > > +of binder transactions should be reported by the kernel binder driver. The
> > > +driver then echoes the attributes in a reply message to acknowledge the
> > > +request. The "set" command also registers the current user space process to
> > > +receive the reports. When the user space process exits, the previous request
> > > +will be reset to prevent any potential leaks.
> > > +
> > > +Currently the driver can report binder transactions that "failed" to reach
> > > +the target process, or that are "delayed" due to the target process being
> >
> > "Delayed" transaction is an entirely new concept. I suppose it means
> > async + frozen. Why not use that?
> >
> > Also, per this logic it seems that a "delayed" transaction could also be
> > "spam" correct? e.g. the flags are not mutually exclusive.
> 
> It depends on the actual implementation. Currently each binder
> transaction only returns one single error code. A "spam" one also
> indicates it's a "delayed" one.

I'm absolutely confused as to what is "delayed" then? Isn't it async &&
frozen?

A spam transaction can be if the caller has >=25% of the target's buffer
capacity or over 50 transactions, regardless of whether the target is
frozen or not.

It seems to me these are two independent scenarios and a transaction can
be either one or both.

> 
> >
> > > +frozen by cgroup freezer, or that are considered "spam" according to existing
> > > +logic in binder_alloc.c.
> > > +
> > > +When the specified binder transactions happen, the driver uses the "report"
> > > +command to send a generic netlink message to the registered process,
> > > +containing the payload struct binder_report.
> > > +
> > > +More details about the flags, attributes and operations can be found at the
> > > +the doc sections in Documentations/netlink/specs/binder_genl.yaml and the
> > > +kernel-doc comments of the new source code in binder.{h|c}.
> > > +
> > > +Using Binder Genl
> > > +-----------------
> > > +
> > > +The Binder Genl can be used in the same way as any other generic netlink
> > > +drivers. Userspace application uses a raw netlink socket to send commands
> > > +to and receive packets from the kernel driver.
> > > +
> > > +.. note::
> > > +    If the userspace application that talks to the driver exits, the kernel
> > > +    driver will automatically reset the configuration to the default and
> > > +    stop sending more reports to prevent leaking memory.
> >
> > I'm not sure what you mean by preventing memory leaks. What happens when
> > userspace setups the report and doesn't call "recv()"? Is that what we
> > are worried about?
> >
> 
> Probably "leaking memory" isn't accurate here. If the user app
> doesn't call recv(), the netlink message would just fail to send.
> There's no memleak. But I think it's a good idea to reset the
> configuration. Let me describe it in a better way.
> 
> > > +
> > > +Usage example (user space pseudo code):
> > > +
> > > +::
> > > +
> > > +    // open netlink socket
> > > +    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> > > +
> > > +    // bind netlink socket
> > > +    bind(fd, struct socketaddr);
> > > +
> > > +    // get the family id of the binder genl
> > > +    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME,
> > > +            BINDER_GENL_FAMILY_NAME);
> >
> > ok, what is happening here? this is not a regular send(). Is this
> > somehow an overloaded send()? If so, I had a really hard time trying to
> > figuring that out so might be best to rename this.
> >
> 
> This pseudo code means a few attributes are sent by a single send().
> 
> > > +     if (flags != (flags & (BINDER_GENL_FLAG_OVERRIDE
> > > +                     | BINDER_GENL_FLAG_FAILED
> > > +                     | BINDER_GENL_FLAG_DELAYED
> > > +                     | BINDER_GENL_FLAG_SPAM))) {
> > > +             pr_err("Invalid binder report flags: %u\n", flags);
> > > +             return -EINVAL;
> > > +     }
> >
> > didn't Jakub mentioned this part wasn't needed?
> >
> 
> Good catch! I removed them but somehow didn't commit the change.
> 
> 
> > > +int binder_genl_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
> > > +{
> > > +     int portid;
> > > +     u32 pid;
> > > +     u32 flags;
> > > +     void *hdr;
> > > +     struct binder_device *device;
> > > +     struct binder_context *context = NULL;
> >
> > nit: would you mind using reverse christmas tree for this variables
> > and also in other functions too?
> >
> 
> Sure.
> 
> > > +
> > > +     hlist_for_each_entry(device, &binder_devices, hlist) {
> > > +             if (!nla_strcmp(info->attrs[BINDER_GENL_A_CMD_CONTEXT],
> > > +                             device->context.name)) {
> > > +                     context = &device->context;
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     if (!context) {
> > > +             NL_SET_ERR_MSG(info->extack, "Unknown binder context\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     portid = nlmsg_hdr(skb)->nlmsg_pid;
> > > +     pid = nla_get_u32(info->attrs[BINDER_GENL_A_CMD_PID]);
> > > +     flags = nla_get_u32(info->attrs[BINDER_GENL_A_CMD_FLAGS]);
> > > +
> > > +     if (context->report_portid && context->report_portid != portid) {
> > > +             NL_SET_ERR_MSG_FMT(info->extack,
> > > +                                "No permission to set flags from %d\n",
> > > +                                portid);
> > > +             return -EPERM;
> > > +     }
> > > +
> > > +     if (binder_genl_set_report(context, pid, flags) < 0) {
> > > +             pr_err("Failed to set report flags %u for %u\n", flags, pid);
> > > +             return -EINVAL;
> > > +     }
> >
> > With the flags check being unnecessary you probably want to fold
> > binder_genl_set_report() here instead.
> >
> 
> Sorry, I don't quite understand this request. Can you please explain it?

I mean that without the flags check binder_genl_set_report() is small
enough and the only caller is this. So you could just delete that
function and write the code here in binder_genl_nl_set_doit().

> 
> > > +/**
> > > + * Add a binder device to binder_devices
> > > + * @device: the new binder device to add to the global list
> > > + *
> > > + * Not reentrant as the list is not protected by any locks
> > > + */
> > > +void binder_add_device(struct binder_device *device)
> > > +{
> > > +     hlist_add_head(&device->hlist, &binder_devices);
> > > +}
> >
> > nit: would you mind separating the binder_add_device() logic into a
> > separate "prep" commit?
> >
> 
> Sure.
> 
> > > +
> > >  static int __init init_binder_device(const char *name)
> > >  {
> > >       int ret;
> > > @@ -6953,6 +7217,7 @@ static int __init init_binder_device(const char *name)
> > >       }
> > >
> > >       hlist_add_head(&binder_device->hlist, &binder_devices);
> > > +     binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
> >
> > I don't think this is meant to be used like this.
> >
> > Also, binder_device is kzalloc'ed so no need to init report_seq at all.
> >
> 
> I'll remove this unnecessary code.
> 
> > >
> >
> >
> > Also, how is userspace going to determine that this new interface is
> > available? Do we need a new entry under binder features? Or is this not
> > a problem?
> 
> It's not a problem. The generic netlink command "getfamily" will fail.

Cool, and this wouldn't be retried after it has failed right?

