Return-Path: <netdev+bounces-53836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F5D804D06
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610E72814E5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB93C699;
	Tue,  5 Dec 2023 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv68xgT0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BDF1B2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701766838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VZS95IaK4r6XsUz1E0q2PUldohLpiP4RGb9owLqvas=;
	b=gv68xgT0KBR8X3nLKc4yx9/QOoQYJjCOQGia9+MD6uDvzcg0PyPSyoA43eW/3aBX95/1bU
	Scnv37tE8D+p4jWX3XOor6Ec3Bc6m+xJGNlZelHhXeAEnteNu0AWTGz5YslzITG5+srY0B
	chsISjqVbeAhPnFSmtLLYpuZ1URT+fM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-5ODhifheMlyVW3tNzgnaQg-1; Tue, 05 Dec 2023 04:00:37 -0500
X-MC-Unique: 5ODhifheMlyVW3tNzgnaQg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54aa99b8e4dso3890370a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 01:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766836; x=1702371636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VZS95IaK4r6XsUz1E0q2PUldohLpiP4RGb9owLqvas=;
        b=JIcrYND54B0loR+ZI6sYz1hBgU2IjkgWUxTRmtib0Nqmnq3fxR4fkqSdJUOtsXDbw7
         6/A7AlyJSVQsvutn0c/kJIey1+6yk5Df9pb6ZQtDkn8jXCyUnR8XF2SZ2PIk8HgpSt7W
         Pw2ua89J+mqT8ghtKe7Lex2zqp0j3gN0+eDcJbF06bOBaAe8U53kVo9343ckX1kE1Cz/
         tvgA1rvyq/BcgM7GCdU0hZHqo8Ml1lJupLTgGTjxb4xfBhW89kTl9B/07O6RRRTBhh9a
         04ldiP7jW2yMqqT7Lb07LRrMRa4AcK9aSRc4jbD0ARpvL0WIKM1uAAti07rcAmSxL6IV
         CoRw==
X-Gm-Message-State: AOJu0YyLat121j3n+akEXG6/jcJ0RWvMl00YFSMpKqoBKRSTXOx9STVX
	G6nAupmSCDOEf5NEOs26wvr5OHV351CqN//QfhqEX+aDOe+7FHkr3Ko7rsDbiAatC/i7VRsEwzR
	Epi18jHymwl+VFuC8ehhU7zs8a4iuPg8e
X-Received: by 2002:a50:cd4c:0:b0:54a:f1db:c290 with SMTP id d12-20020a50cd4c000000b0054af1dbc290mr4888956edj.9.1701766836040;
        Tue, 05 Dec 2023 01:00:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh2TKjelIK/xQGoRVMKwsH4kMIEu1VeGAyx5RhXDvxBars21w6KtujrtA6OrR9/wZyU8ce/FVMPTEFLjqsBv8=
X-Received: by 2002:a50:cd4c:0:b0:54a:f1db:c290 with SMTP id
 d12-20020a50cd4c000000b0054af1dbc290mr4888935edj.9.1701766835720; Tue, 05 Dec
 2023 01:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202150807.2571103-1-srasheed@marvell.com>
 <CADEbmW12OWS6et2wp3skicUM=V81x8dS4_aySYP1Ok0kEc2M9Q@mail.gmail.com>
 <CADEbmW3K7QkfniBtmMt=SZtwZWez30F+sM=656wqmZR8=ig1jQ@mail.gmail.com> <PH0PR18MB47342E45E84C86A274F78074C785A@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB47342E45E84C86A274F78074C785A@PH0PR18MB4734.namprd18.prod.outlook.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 5 Dec 2023 10:00:24 +0100
Message-ID: <CADEbmW3WjQFQk=g5ESAdMWjoQGHzr3ndL_0AQ8O7-QE2XRVS9w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net v1] octeon_ep: initialise control mbox tasks
 before using APIs
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, 
	Vimlesh Kumar <vimleshk@marvell.com>, "egallen@redhat.com" <egallen@redhat.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"wizhao@redhat.com" <wizhao@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh B Edara <sedara@marvell.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:50=E2=80=AFAM Shinas Rasheed <srasheed@marvell.com=
> wrote:
> > -----Original Message-----
> > > On Sat, Dec 2, 2023 at 4:08=E2=80=AFPM Shinas Rasheed <srasheed@marve=
ll.com>
> > wrote:
> > > > Do INIT_WORK for the various workqueue tasks before the first
> > > > invocation of any control net APIs. Since octep_ctrl_net_get_info
> > > > was called before the control net receive work task was even
> > > > initialised, the function call wasn't returning actual firmware
> > > > info queried from Octeon.
> > >
> > > It might be more accurate to say that octep_ctrl_net_get_info depends
> > > on the processing of OEI events. This happens in intr_poll_task.
> > > That's why intr_poll_task needs to be queued earlier.
>
> Intr_poll_task is queued only when the interface is down and the PF canno=
t catch IRQs as they have been torn down.
> Elsewise, OEI events will trigger the OEI IRQ and consequently its handle=
r.

Right. octep_ctrl_net_get_info is called from the probe function, and
at this point the netdev is not even registered yet. Hence the need
for intr_poll_task.
The reason I started wondering about intr_poll_task is that the commit
message talks about the INIT_WORK, but the patch also moves the
queue_delayed_work call and the reasoning for that move was missing in
the message.
I think the move is correct, but please expand the description.

> Nevertheless, your point is correct in that it
> needs to be queued earlier, but I think subsequently since it calls the c=
ontrol mbox task, that is more relevant and necessary as if it
> is not initialized, it cannot be scheduled even if OEI interrupts have be=
en caught.

OK.

> > > Did octep_send_mbox_req previously always fail with EAGAIN after
> >           ^^^^^^^^^^^^^^^^^^^^^
> > I meant octep_ctrl_net_get_info here.
> >
> > > running into the 500 ms timeout in octep_send_mbox_req?
>
> Yes it did, but as it was silent (note that we're not checking any error =
value), it didn't stop operation. I think I might have to update this patch
> to catch the error values as well (This was a relic from the original cod=
e which spawned an extra thread to setup device and hence couldn't give bac=
k
> an error value. That implementation was discouraged and we setup things a=
t probe itself in the upstreamed code and can check error values)

Yes, please, catch that error value.

> > > Apropos octep_send_mbox_req... I think it has a race. "d" is put on
> > > the ctrl_req_wait_list after sending the request to the hardware. If
> > > the response arrives quickly, "d" might not yet be on the list when
> > > process_mbox_resp looks for it.
> > > Also, what protects ctrl_req_wait_list from concurrent access?
>
> Such a race condition is, I also think, valid, but is not currently occur=
ring as response, after due processing from Octeon application,
> wouldn't arrive that quickly. Regarding concurrent access, there is curre=
ntly no protection for ctrl_req_wait_list. Concurrent access here,
> can only happen if either two requests manage to get hold of the ctrl_req=
_wait_list or a request and a response manages to get hold of the
> ctrl_req_wait_list (the case you stated above).
>
> In the first case, since locks are implemented atop the control mbox itse=
lf, requests would have to in effect wait for their chance to
> queue their wait data "d" to ctrl_req_wait_list, avoiding concurrent acce=
ss.
>
> The second case is valid, but as I stated, wouldn't happen practically. B=
ut I suppose we do have to handle all theoretical cases and perhaps
> locking can be done. I suppose a separate patch for it might be better.

Yes, fixing this should be a separate patch.

Thanks,
Michal


