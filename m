Return-Path: <netdev+bounces-55549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196680B3B5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725011C20A36
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4312134B4;
	Sat,  9 Dec 2023 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DK2Sul58"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4190610E0
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702118554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYXGvxRUfrhZD8ZKPprmEb3EjUd1OkMKc/tesKE8NYk=;
	b=DK2Sul58euJ9hRVyMs010HAVL4iSGtLRhLuztlZ5b35jRIE4y0TFFRO50HRgxi5iI3D1xp
	9/5b1WVECOnYTLqN3SWOHgfMExnffFHTWZNg8RBg3fGltNdqP8AlrXL4Ce9Bvw3BWazp59
	u6xLY5pIAhetj+r11JBjzL5E2gv1D08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-yb4t6welMiizQgOHn68GWw-1; Sat, 09 Dec 2023 05:42:30 -0500
X-MC-Unique: yb4t6welMiizQgOHn68GWw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3d81399dso17885895e9.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118549; x=1702723349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYXGvxRUfrhZD8ZKPprmEb3EjUd1OkMKc/tesKE8NYk=;
        b=P9hAvcPQ6ntvuS6nOWHksdIND+/35bV7Vq1/CmfSPDoFOeeb2tcUDVNZ2t7uJcsMoJ
         e3eovToQwheWSqqQG+Czt3jmxpr4QEUkp4OyD6adv90x/GCGxIEoOQu6TXu6UPZq9BlR
         cmVYUY7geQ2+pTmTXnd1YTAW46vnc6wcWjwlts+u7wGSjzCn/+dH+4mpPW49sgq91jYE
         c20EiC6iZEwx08VzerkshgD5DZty2F2TogrH3upxe9fp+bwGRAk74dqb22Xqe09yVaM3
         EMhrMVTGTxqQ88GhGOHs2tFWTJwj25LAJQvWs9uSfzYyje95CgYFKAz9/RWZkaOzOAnU
         mIOQ==
X-Gm-Message-State: AOJu0YyAI0DPDvA4IYJA5L/yz9pHs6LcAE1RIhSrtvgZ0moLJu/v4fqZ
	baeE3LPYoLdjTTrjtrKtLOOCs7xkkOJVMnhnU6qKnANwCxwUZ0BJnFZuD3CPDcOHB1cLBFydVJy
	0HkHbiti/N2c7v/pB
X-Received: by 2002:a05:600c:808:b0:40c:32df:da03 with SMTP id k8-20020a05600c080800b0040c32dfda03mr347245wmp.305.1702118549569;
        Sat, 09 Dec 2023 02:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdC86jKPcminvAV1YfnbyeFnlInlsAzYlkskejvPuH6o846ik+MKMa3TBW5xfIsAmcSOb+EA==
X-Received: by 2002:a05:600c:808:b0:40c:32df:da03 with SMTP id k8-20020a05600c080800b0040c32dfda03mr347239wmp.305.1702118549151;
        Sat, 09 Dec 2023 02:42:29 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c138f00b004060f0a0fd5sm6031663wmf.13.2023.12.09.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:42:28 -0800 (PST)
Date: Sat, 9 Dec 2023 05:42:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231209053443-mutt-send-email-mst@kernel.org>
References: <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53044.123120806415900549@us-mta-342.us.mimecast.lan>

On Fri, Dec 08, 2023 at 12:41:38PM +0100, Tobias Huschle wrote:
> On Fri, Dec 08, 2023 at 05:31:18AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 08, 2023 at 10:24:16AM +0100, Tobias Huschle wrote:
> > > On Thu, Dec 07, 2023 at 01:48:40AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> > > > > 3. vhost looping endlessly, waiting for kworker to be scheduled
> > > > > 
> > > > > I dug a little deeper on what the vhost is doing. I'm not an expert on
> > > > > virtio whatsoever, so these are just educated guesses that maybe
> > > > > someone can verify/correct. Please bear with me probably messing up 
> > > > > the terminology.
> > > > > 
> > > > > - vhost is looping through available queues.
> > > > > - vhost wants to wake up a kworker to process a found queue.
> > > > > - kworker does something with that queue and terminates quickly.
> > > > > 
> > > > > What I found by throwing in some very noisy trace statements was that,
> > > > > if the kworker is not woken up, the vhost just keeps looping accross
> > > > > all available queues (and seems to repeat itself). So it essentially
> > > > > relies on the scheduler to schedule the kworker fast enough. Otherwise
> > > > > it will just keep on looping until it is migrated off the CPU.
> > > > 
> > > > 
> > > > Normally it takes the buffers off the queue and is done with it.
> > > > I am guessing that at the same time guest is running on some other
> > > > CPU and keeps adding available buffers?
> > > > 
> > > 
> > > It seems to do just that, there are multiple other vhost instances
> > > involved which might keep filling up thoses queues. 
> > > 
> > 
> > No vhost is ever only draining queues. Guest is filling them.
> > 
> > > Unfortunately, this makes the problematic vhost instance to stay on
> > > the CPU and prevents said kworker to get scheduled. The kworker is
> > > explicitly woken up by vhost, so it wants it to do something.
> > > 
> > > At this point it seems that there is an assumption about the scheduler
> > > in place which is no longer fulfilled by EEVDF. From the discussion so
> > > far, it seems like EEVDF does what is intended to do.
> > > 
> > > Shouldn't there be a more explicit mechanism in use that allows the
> > > kworker to be scheduled in favor of the vhost?
> > > 
> > > It is also concerning that the vhost seems cannot be preempted by the
> > > scheduler while executing that loop.
> > 
> > 
> > Which loop is that, exactly?
> 
> The loop continously passes translate_desc in drivers/vhost/vhost.c
> That's where I put the trace statements.
> 
> The overall sequence seems to be (top to bottom):
> 
> handle_rx
> get_rx_bufs
> vhost_get_vq_desc
> vhost_get_avail_head
> vhost_get_avail
> __vhost_get_user_slow
> translate_desc               << trace statement in here
> vhost_iotlb_itree_first

I wonder why do you keep missing cache and re-translating.
Is pr_debug enabled for you? If not could you check if it
outputs anything?
Or you can tweak:

#define vq_err(vq, fmt, ...) do {                                  \
                pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
                if ((vq)->error_ctx)                               \
                                eventfd_signal((vq)->error_ctx, 1);\
        } while (0)

to do pr_err if you prefer.

> These functions show up as having increased overhead in perf.
> 
> There are multiple loops going on in there.
> Again the disclaimer though, I'm not familiar with that code at all.


So there's a limit there: vhost_exceeds_weight should requeue work:

        } while (likely(!vhost_exceeds_weight(vq, ++recv_pkts, total_len)));

then we invoke scheduler each time before re-executing it:


{       
        struct vhost_worker *worker = data;
        struct vhost_work *work, *work_next;
        struct llist_node *node;
        
        node = llist_del_all(&worker->work_list);
        if (node) {
                __set_current_state(TASK_RUNNING);

                node = llist_reverse_order(node);
                /* make sure flag is seen after deletion */
                smp_wmb();
                llist_for_each_entry_safe(work, work_next, node, node) {
                        clear_bit(VHOST_WORK_QUEUED, &work->flags);
                        kcov_remote_start_common(worker->kcov_handle);
                        work->fn(work);
                        kcov_remote_stop();
                        cond_resched();
                }
        }

        return !!node;
}       

These are the byte and packet limits:

/* Max number of bytes transferred before requeueing the job.
 * Using this limit prevents one virtqueue from starving others. */
#define VHOST_NET_WEIGHT 0x80000

/* Max number of packets transferred before requeueing the job.
 * Using this limit prevents one virtqueue from starving others with small
 * pkts.
 */
#define VHOST_NET_PKT_WEIGHT 256


Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?

-- 
MST


