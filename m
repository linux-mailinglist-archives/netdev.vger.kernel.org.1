Return-Path: <netdev+bounces-37105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E67B3A3E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 740FBB20B64
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAF42C0B;
	Fri, 29 Sep 2023 18:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15E849C
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:51:53 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE032199
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5kGS2lI6FP00vz5q3k6trMEBNeRpc2K7yINUitCt/fs=; b=FJPd3P64bjn/5p2oD7m2uNawOX
	OY12tuDE+6NuEFKV6wNCrNNE/7DKViJDMw6zGLPeBOj4toO9M5LeITz+FKKKUxMX+lKvt7p4ZDH6+
	FhaTSA44wnsnOezep4RamEhy0L/PP7+yWf1IfXkxAVHWvDXc2/PqM2KKYJGyWLbIpSY8vqqy2JfbH
	VAfEvath0iU9Ti/LSU72VVaGAe2rNRTD5jmbT538z7UZCRQg/84VTVq0XIHfLqKTVohY27h7IoEBl
	qcbXAiYmTajCVkGIyD9r18E+spiWXjuUlAjFg4/eh875mSsAFALBB0ZxxEJpKNbLIeX2X04F1yErj
	huYGwNVg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qmIaY-00DSv9-2Q;
	Fri, 29 Sep 2023 18:51:46 +0000
Date: Fri, 29 Sep 2023 11:51:43 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: hch@lst.de, netdev@vger.kernel.org
Subject: Re: configfs: Create config_item from netconsole
Message-ID: <ZRccv2H3wK6PL5Rb@google.com>
References: <ZRWRal5bW93px4km@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRWRal5bW93px4km@gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 07:44:58AM -0700, Breno Leitao wrote:
> Right now there is a limitation in netconsole, where it is impossible to
> disable or modify the target created from the command line parameter.
> (netconsole=...).
> 
> "netconsole" cmdline parameter sets the remote IP, and if the remote IP
> changes, the machine needs to be rebooted (with the new remote IP set in
> the command line parameter).
> 
> I am planning to reuse the dynamic netconsole mechanism for
> the 'command line' target, i.e., create a `cmdline` configfs_item for
> the "command line" target, so, the user can modify the "command line"
> target in configfs in runtime. Something as :
> 
> 	echo 0 > /sys/kernel/config/netconsole/cmdline/enabled
> 	echo <new-IP> > /sys/kernel/config/netconsole/cmdline/remote_ip
> 	echo 1 > /sys/kernel/config/netconsole/cmdline/enabled

Note that the `netconsole=` command line parameter can specify more than
one network console, split by semicolons.  Anything you do here has to be
responsive to this.  So you can't create a single `cmdline` entry.

> I didn't find a configfs API to register a configfs_item into a
> config_group. Basically the make_item() callbacks are called once the
> inode is created by the user at mkdir(2) time, but now I need to create
> it at the driver initialization.
>
> Should I create a configfs_register_item() to solve this problem?

It's an express philosophy of configfs that all lifetimes are controlled
by userspace, which is why we don't have such a facility.  If hch wants
to change this, I defer to his judgement.  But I don't think it is
necessary.

What I would do instead is check whether a mkdir(2) call is
trying to reference a command line entry.  If so, attach it to the
existing entry rather than creating a new one.

Currently, `alloc_param_target()` initializes `netconsole_target.item`
to zeros.  The item is never used by parameter-created targets.  Step
one would be to give it a name.  So in `init_netconsole()`, right after
`alloc_param_target()`, initialize `nt->item` just like we do in
`make_netconsole_target()`.  So something like:

```
+ #ifdef CONFIG_NETCONOLE_DYNAMIC
+       char target_name[16];
+       int target_count = 0;
+ #endif
	while ((target_config = strsep(&input, ";"))) {
			nt = alloc_param_target(target_config);
			if (IS_ERR(nt)) {
				err = PTR_ERR(nt);
				goto fail;
			}
+ #ifdef CONFIG_NETCONSOLE_DYNAMIC
+                       snprintf(target_name, 16, "cmdline", target_count);
+                       config_item_init_type_name(&nt->item, target_name,
+                                                  &netconsole_target_type);
+                       target_count++;
+ #endif
+
			/* Dump existing printks when we register */
			if (nt->extended) {
				extended = true;
```

Then, later in `make_netconsole_target()`, rather than blindly inserting
the new `netconsole_target` in the list, you can check if the name is
already present and use that.  Here's some ugly pseudocode:

```
	spin_lock_irqsave(&target_list_lock, flags);
	list_for_each_entry(tmp, &target_list, list) {
		if (!strcmp(tmp->item.name, nt->item.name)) {
			existing = tmp;
			break;
		}
	}
	if (existing) {
		to_free = nt;
		nt = existing;
	} else {
		list_add(&nt->list, &target_list);
	}
	spin_unlock_irqrestore(&target_list_lock, flags);

	if (to_free)
		kfree(to_free);

	return &nt->item;
}
```

In this fashion, each console created on the command line will get a
name of `cmdline0`, `cmdline1`, etc.  They will not be part of the
configfs tree.  If the user comes along later and says `mkdir
/sys/kernel/config/netconsole/cmdline1`, the existing `cmdline1` console
will be attached to the configfs tree.  The user is then free to disable
and reconfigure the device.

Note that this behavior cannot be triggered for netconsoles already
created by configfs.  If I try to `mkdir
/sys/kernel/config/netconsole/mydev` twice, the second command will get
`-EEXISTS` in filesystem code long before it reaches the netconsole
code.  Only when someone makes a config item that matches the console
names can we traverse this code.  Thus, matching the name is safe.

There would, of course, be some other corner cases to handle.  Do we
allow dynamic names that look like command-line names if no command-line
parameter exists?  Does `rmdir /sys/kernel/config/netconsole/cmdline0`
actually delete the command-line console entry, or does it return
-EBUSY?  And so on.

Thanks,
Joel

-- 

"When ideas fail, words come in very handy." 
         - Goethe

			http://www.jlbec.org/
			jlbec@evilplan.org

