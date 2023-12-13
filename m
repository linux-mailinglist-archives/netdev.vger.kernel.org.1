Return-Path: <netdev+bounces-56913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D901B811532
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A47C1F21569
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A52EB07;
	Wed, 13 Dec 2023 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP8muHC8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDAE99
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702478874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jKzahdW3Z8DiMF4k91DJLvHn4lH9K58mF9LO/614r8=;
	b=TP8muHC81kX6Q2ehx9md1hzw2b5sZ8zDdc5XfupTYJJg0PS7d4Hnns9x329JgF9xmpmz/+
	EEoxIor4Y6s2YTEVVSBHkj2qF4gPuBsgqCiI4H4w5TyWEBhUwdYj7X/9QW4R0wZc4Myis2
	LF2607Mei0RMMIntZQxuY1EZCO/OhJk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-IL2U2bcqPUabnpY8zv4RYA-1; Wed, 13 Dec 2023 09:47:53 -0500
X-MC-Unique: IL2U2bcqPUabnpY8zv4RYA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d38492da7so425581666b.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 06:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478872; x=1703083672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jKzahdW3Z8DiMF4k91DJLvHn4lH9K58mF9LO/614r8=;
        b=cj9iBDhPhyEPYEMM9RFSXTLvkUGK6rBXWh4Noh3E5s2TWOl+oEmUeeNF+IrT23Ab8P
         s9BlxradUu1VetsW+2iWfyec22fVVWXH2f2OJdMdoi7MQyPUoGJupLij1dk2qSwbNwvH
         ODz+7GYVw+pl7iquH5kUxFhwr2VhJZALww+XZKfnddPo7qPKxxEFxMYkfT2Iy2ji1SRz
         Cw3Hicch1XEkWutIyVFlSTbgQBHUKtzzlzfOJ+3D9sJwjrI0Qb1g45YQw52RaOd6YIlV
         BQvaUi9+GNOUmcF4SvkGgShovkb+aHTBC8Xm/Awd+8q/zcRqhVaw4U/B8wmgqU8AWFjr
         G0WQ==
X-Gm-Message-State: AOJu0YxLkhxCVmN9slI/N4LEEK8bYTjfNfxXnZxWMqAiijOjdNr3Wu4T
	ScPaDc5UDVtQ/4f476MqAC0H32KecowzZ9MWpMzbhIRrTY43PpxagZiRjXkrfVIzCbFNb8vS8Bx
	W64HYPdt5is2tM8AO
X-Received: by 2002:a17:907:72cb:b0:a1d:9d7b:f2cf with SMTP id du11-20020a17090772cb00b00a1d9d7bf2cfmr2746757ejc.15.1702478872432;
        Wed, 13 Dec 2023 06:47:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH225M+fWShUJGXunG1g7mFoAwsjGf+FIVoxeFbFwopVnE+cUOXBfhM3binQy7H2O/ZZGcAw==
X-Received: by 2002:a17:907:72cb:b0:a1d:9d7b:f2cf with SMTP id du11-20020a17090772cb00b00a1d9d7bf2cfmr2746745ejc.15.1702478872109;
        Wed, 13 Dec 2023 06:47:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id tb19-20020a1709078b9300b00a1cd30d06d1sm8049662ejc.14.2023.12.13.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:47:51 -0800 (PST)
Date: Wed, 13 Dec 2023 09:47:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231213093627-mutt-send-email-mst@kernel.org>
References: <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25485.123121307454100283@us-mta-18.us.mimecast.lan>

On Wed, Dec 13, 2023 at 01:45:35PM +0100, Tobias Huschle wrote:
> On Wed, Dec 13, 2023 at 07:00:53AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 13, 2023 at 11:37:23AM +0100, Tobias Huschle wrote:
> > > On Tue, Dec 12, 2023 at 11:15:01AM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> > > > > On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> [...]
> > 
> > Apparently schedule is already called?
> > 
> 
> What about this: 
> 
> static int vhost_task_fn(void *data)
> {
> 	<...>
> 	did_work = vtsk->fn(vtsk->data);  --> this calls vhost_worker if I'm not mistaken
> 	if (!did_work)
> 		schedule();
> 	<...>
> }
> 
> static bool vhost_worker(void *data)
> {
> 	struct vhost_worker *worker = data;
> 	struct vhost_work *work, *work_next;
> 	struct llist_node *node;
> 
> 	node = llist_del_all(&worker->work_list);
> 	if (node) {
> 		<...>
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			<...>
> 		}
> 	}
> 
> 	return !!node;
> }
> 
> The llist_for_each_entry_safe does not actually change the node value, doesn't it?
> 
> If it does not change it, !!node would return 1.
> Thereby skipping the schedule.
> 
> This was changed recently with:
> f9010dbdce91 fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
> 
> It returned a hardcoded 0 before. The commit message explicitly mentions this
> change to make vhost_worker return 1 if it did something.
> 
> Seems indeed like a nasty little side effect caused by EEVDF not scheduling
> the woken up kworker right away.

Indeed, but previously vhost_worker was looping itself.
And it did:
-               node = llist_del_all(&worker->work_list);
-               if (!node)
-                       schedule();

so I don't think this was changed at all.






-- 
MST


