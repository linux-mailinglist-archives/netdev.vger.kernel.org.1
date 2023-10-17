Return-Path: <netdev+bounces-41633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65E7CB7EC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21AF280F57
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8417D5;
	Tue, 17 Oct 2023 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85A17D2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:20:54 +0000 (UTC)
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BEA7
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:20:51 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 17 Oct 2023 03:20:36 +0200
Date: Tue, 17 Oct 2023 03:20:24 +0200
From: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Serge Hallyn <serge.hallyn@canonical.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231017012024.pp2riikutr54ini4@House.clients.dxld.at>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
 <20231013153605.487f5a74@kernel.org>
 <20231013154302.44cc197d@kernel.org>
 <2023101408-matador-stagnant-7cab@gregkh>
 <20231016073251.0f47d42b@kernel.org>
 <2023101632-circle-delegate-39dd@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023101632-circle-delegate-39dd@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Greg, Jackub,

On Mon, Oct 16, 2023 at 07:20:26PM +0200, Greg Kroah-Hartman wrote:
> > IIUC what happens is:
> > 
> >  - systemd controls "real" eth0
> >  - we move a "to be renamed" eth0 from a container into main ns
> >  - we rename "to be renamed" eth0 to something else
> >  - seeing the rename of eth0 system thinks it's the "real" one
> >    that is being renamed, ergo there's no eth0 any more,
> >    so it shuts down its "unit" for eth0
> > 
> > I don't think anything changed. Sounds more like someone finally tried
> > to use this in anger.
> 
> Then they get to keep the broken pieces that they created here.
> "moving" a network connection to a container needs to either be added to
> systemd if it is going to manage the network connections, or just stop
> using systemd to handle the connection entirely as they want to do
> something that systemd doesn't support.

I think you've not entirely understood the problem, let me try to explain
it better. The buggy scenario is this: we have a netdev "eth0" in main-ns
(call it eth0-main to avoid confusion), managed by a systemd service (with
BoundTo=*-eth0.device) but also a different netdev called eth0 in a
container (call it eth0-netns).

Now the container is being shut down so the container manager dutifully
moves eth0-netns back to the main-ns while simultaniously renaming it so as
to not cash with eth0-main.

Systemd in main-ns now sees a MOVE event (eth0 -> eth123) and handles this
as the removal of eth0-main. This stops the corresponding device unit and
subsequently the service managing eth0-main via BoundTo.

Problem is the real eth0-main wasn't actually moved, removed or
otherwise. eth0-netns being rename+moved just caused a nonsense MOVE event
to be sent to main-ns (and an incorrect ADD with the old name).

You can imagine how this bug might bring down an entire container
hypervisor's network uplink.



On Fri, Oct 13, 2023 at 03:36:05PM -0700, Jakub Kicinski wrote:
> FTR I don't see the move on current net-next, I see two adds 
> and one move.

Where's the second add? I see only one. Note: I only look at what happens
after the move+rename ip link set call.

>  [ ~]# ip -netns test link set dev eth0 netns 1 name eth123
>  KERNEL[135.598907] add      /devices/virtual/net/eth0 (net)
>  KERNEL[135.600425] move     /devices/virtual/net/eth123 (net)

Testing again now my output matches yours above. Odd, but I probably did a
kernel upgrade since then. Let me know if it matters and I'll go digging
thought apt logs.

Now I have uname -a:
Linux 6.5.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1 (2023-10-07) x86_64

> I don't think it matters for the problem you're describing, tho.

I thought the two move lines I was seeing were one move event being printed
as two lines, with the old/new device names. If what's being printed is the
new name the bug root cause stays the same.

> > Looking at the code in __rtnl_newlink I see do_setlink first calls
> > __dev_change_net_namespace and then dev_change_name. My guess is the order
> > is just wrong here.
> 
> Interesting. My analysis is slightly different but only in low level
> aspects.. tell me if I'm wrong:

I only looked at the high level flow of the code.

> 1. we have tb[IFLA_IFNAME] set, so do_setlink() will populate ifname
> 
> 2. Because of #1, __dev_change_net_namespace() gets called with 
>    new name provide (pat = eth123)
> 
> 3. It will do netdev_name_in_use(), which returns true.

At this point we're still looking at the old netns, right?

> 4. It will then call dev_get_valid_name() which, (confusingly?) already
>    sets the new name on the netdevice itself.

I wouldn't have guessed a "get" function will actually set something, no,
but then again I know not of the kernel's arcane ways :)

> Picking back up after the shutdown in old netns.
> 
> 6. We call:
> 
>    kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
>    dev_net_set(dev, net);
>    kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
> 
> Those are the calls you see in udev, recall that device core has
> its own naming, so both of those calls will use the _old_ name.
> REMOVE in the source netns and ADD in the destination netns.
>
> The kobject calls were added by Serge in 4e66ae2ea371c, in 2012,
> curiously it states:
> 
>     v2: also send KOBJ_ADD to new netns.  There will then be a
>     _MOVE event from the device_rename() call, but that should
>     be innocuous.
>
> Which was based on this conversation:
> https://lore.kernel.org/all/20121012031328.GA5472@sergelap/

Seems to me what main-ns might do with this MOVE event was simply not
considered in detail, innocuous it is not ;)

> 7. Now we finally call:
> 
>    err = device_rename(&dev->dev, dev->name);
> 
> Which tells device core that the name has changed, and gives you 
> the (second) MOVE event. This time with the correct name.

I don't like loose ends. Any idea why we only see the one MOVE now?

> Which is what you're seeing, Bug#3, the ADD event should be after
> the call to device_rename()...

All tracks AFAICT.

Thanks,
--Daniel

