Return-Path: <netdev+bounces-133843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0AE997305
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096E91C21791
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36931D318A;
	Wed,  9 Oct 2024 17:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1A1A2630;
	Wed,  9 Oct 2024 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494985; cv=none; b=iM7zd44+nQPn0WL82gA8KCtjRjBOf/mNd+KSM277pK4qvc/jhggyuQ8ZZOHUIqvxCxkR7PPrXI4dOrYUjzIXybjF/Wviquv5CRr3Wlk+c6B0ej7DGqwuopfC5AtBveI4lGmHVN8SFUEvbAEjbH3tw4hIwrD39xxQkpOPUKR+s68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494985; c=relaxed/simple;
	bh=H5Y/vdF9w0zcs3yfYi+U1ozQa6mSZk+BtYQMChsKEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZNJsKA4QWbO3SpeL2f7uMEOXp4pKwcxfhDWziBfMBt4jPGLXIx4XFPAatgwiR/o8zjknUT425CmkgCwShPqX9qAT2uh028fXAZV/uA2T+Gc+KNv0rcv+LGnVJPORL+4QfFbmvtv7CLCNHIjhP5TVD3Muzg7rXGYr/5u99ELNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso219025e9.0;
        Wed, 09 Oct 2024 10:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494982; x=1729099782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph4dHmwwGNUtPR7csyoZqdOsKA9zJtXDkHwHqPNDsrU=;
        b=kUzNqr2z9dcn+/FsgvEAwfpRppdTVBMySvnLhFCfMiAMYWWQ4Mhwdx5xtaz9HfXHGY
         mMNTfpKa4Qs8hlngkNqlMadResHLoT1hf1QaG5fPrUJ5Z3Kvuz87a7LSG4pE29G4dnF+
         fwpnLitkbuhLBcxKzwZ4jaiMrdTmFJA/A/jyrILzwvpmYQ7Cm5M0HStem4mNWnJpoHxV
         Oa8gLML9auEhefQGxTgrXhBas8Ml/I16mC872+rDhT8JT2LCXxv4uPkj2Q9/o21rCuSX
         oT0zyy7QjpsE5szWfaekc19G/ij2KC5A6z5rHWauzCSIGbjiE1nqZaipWf9uWsaqH+Lw
         soog==
X-Forwarded-Encrypted: i=1; AJvYcCV++4H2G3DxVvzEGnyMrlWMox+iWodQmjnI+CXy3pfg2iYPIPT0weXwwbU4C7KIQZ65U3WRFy0l@vger.kernel.org, AJvYcCWkzX9meJ0M2/TwY9+H4FIjyYr8Ua12Q9fNxb2AEUP+D77KmkTCDc1tYYjCU8BFbxB7m6jNryFYZzye9iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQM5cmzDAcLomZm8duwNglvig9boDXC0gd2kL15sPzNb9N8eG+
	umYBRMMEQunZhh7tBcPUmWDivsm+wmZeemPx0dIq6r5INABAa3Z1
X-Google-Smtp-Source: AGHT+IFNQl26Yi9sJ60W1L0+ivvA50jgr/dBp9oX5oLvkywajWxtJLgg0Ahqel0Alu1BiDwdLhJF5Q==
X-Received: by 2002:a05:600c:2149:b0:431:11e6:d540 with SMTP id 5b1f17b1804b1-43111e6d828mr25137035e9.17.1728494982289;
        Wed, 09 Oct 2024 10:29:42 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b42d8sm26789015e9.31.2024.10.09.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:29:41 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:29:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Pavel Begunkov <asml.silence@gmail.com>, kuba@kernel.org
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	vschneid@redhat.com, axboe@kernel.dk,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241009-ultramarine-bison-of-abundance-2bfcdd@leitao>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
 <20241003153231.GV5594@noisy.programming.kicks-ass.net>
 <20241003-mahogany-quail-of-reading-eeee7e@leitao>
 <20241004-blazing-rousing-lynx-8c4dc9@leitao>
 <Zv_IR9LAecB2FKNz@pathway.suse.cz>
 <8434l6sjwz.fsf@jogness.linutronix.de>
 <f88adb83-618b-4be3-8357-0aabcf3a2db8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88adb83-618b-4be3-8357-0aabcf3a2db8@gmail.com>

On Wed, Oct 09, 2024 at 04:44:24PM +0100, Pavel Begunkov wrote:
> On 10/8/24 16:18, John Ogness wrote:
> > On 2024-10-04, Petr Mladek <pmladek@suse.com> wrote:
> > > On Fri 2024-10-04 02:08:52, Breno Leitao wrote:
> > > > 	 =====================================================
> > > > 	 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> > > > 	 6.12.0-rc1-kbuilder-virtme-00033-gd4ac164bde7a #50 Not tainted
> > > > 	 -----------------------------------------------------
> > > > 	 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > > > 	 ff1100010a260518 (_xmit_ETHER#2){+.-.}-{2:2}, at: virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969)
> > > > 
> > > > 	and this task is already holding:
> > > > 	 ffffffff86f2b5b8 (target_list_lock){....}-{2:2}, at: write_ext_msg (drivers/net/netconsole.c:?)
> > > > 	 which would create a new lock dependency:
> > > > 	  (target_list_lock){....}-{2:2} -> (_xmit_ETHER#2){+.-.}-{2:2}
> > > > 
> > > > 	but this new dependency connects a HARDIRQ-irq-safe lock:
> > > > 	  (console_owner){-...}-{0:0}
> > 
> > ...
> > 
> > > > 	to a HARDIRQ-irq-unsafe lock:
> > > > 	  (_xmit_ETHER#2){+.-.}-{2:2}
> > 
> > ...
> > 
> > > > 	other info that might help us debug this:
> > > > 
> > > > 	 Chain exists of:
> > > > 	console_owner --> target_list_lock --> _xmit_ETHER#2
> > > > 
> > > > 	  Possible interrupt unsafe locking scenario:
> > > > 
> > > > 		CPU0                    CPU1
> > > > 		----                    ----
> > > > 	   lock(_xmit_ETHER#2);
> > > > 					local_irq_disable();
> > > > 					lock(console_owner);
> > > > 					lock(target_list_lock);
> > > > 	   <Interrupt>
> > > > 	     lock(console_owner);
> > 
> > I can trigger this lockdep splat on v6.11 as well.
> > 
> > It only requires a printk() call within any interrupt handler, sometime
> > after the netconsole is initialized and has had at least one run from
> > softirq context.
> > 
> > > My understanding is that the fix is to always take "_xmit_ETHER#2"
> > > lock with interrupts disabled.
> > 
> > That seems to be one possible solution. But maybe there is reasoning why
> > that should not be done. (??) Right now it is clearly a spinlock that is
> 
> It's expensive, and it's a hot path if I understand correctly which
> lock that is. And, IIRC the driver might spend there some time, it's
> always nicer to keep irqs enabled if possible.

This also seems a broad network lock, which might have so many other
impacts beyond performance.

That said, I am running out of ideas on how to get this fixed,
unfortunately.

--breno

