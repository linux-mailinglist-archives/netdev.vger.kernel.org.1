Return-Path: <netdev+bounces-22195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20298766694
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF963282182
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4C0D300;
	Fri, 28 Jul 2023 08:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59FC8E2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:12:19 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050544AF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:12:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686c06b806cso1350004b3a.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1690531925; x=1691136725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijh/EYSmvvaUJsC6zPW7sGDRmrtIxgRp4XoQpcGoRi0=;
        b=cQWP+gYhk7Ds94vBxVvxGYh0eid058nW6vxxAI9c5KopeQgx/7m6tIDRN/WIYCtdwj
         wleBDa7uxAEPWYOTu52hPrfAdNU5dbvx4rTN+Bw4JG0IRTuf6fbQ3KuwFyWQaajKolIs
         BZamekNlPDMHhyo0mhrlPpLGu2qrWDHBsfz0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690531925; x=1691136725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ijh/EYSmvvaUJsC6zPW7sGDRmrtIxgRp4XoQpcGoRi0=;
        b=d0iTHCMBsCZgA7AuvlCRTM4jsgOv8YNQcVcobZ9ci6ed+Q4+Ye0DClO8BXPuxXqp3W
         s2tNJtvaWUzzamqYDoUNVSK0c0gX5KsRwBPoZT+U14Y5w/reys4C0uYdNoDBhv9KFQu2
         euPFfuGP0cXScegXh0duPEPM26sP2VzXhE8YxPhcn6InZow88RRYM7dO8fEw/stOYQdJ
         dJ6uHfPnrG46ac4K9XjKFSqApAgmEkxIE+0m1jzKDUT+WbvM/jE/XbGJcHoPYDWkLMra
         1TEbYUwj9ByCtvqHAGEmi4sousWV6SqbOFl6g+oRvJGnz2hoHxKwlGfpBESq9RmI2po9
         oZNQ==
X-Gm-Message-State: ABy/qLaHhJc/lkQyYqxOGxvOA78SobqwgWEYuD+lnuJd8SGDt/718qTA
	W3ETl32iWqk0E5HaYjMLvIPw0A==
X-Google-Smtp-Source: APBJJlGScxUKPAzCZ4SQOlTybopfJrVCl6b78A/lB0StAKGeNKAnwZWxOeh7SO7+6tUki74d7YlaFA==
X-Received: by 2002:a05:6a00:15d3:b0:686:6166:3738 with SMTP id o19-20020a056a0015d300b0068661663738mr995236pfu.28.1690531925116;
        Fri, 28 Jul 2023 01:12:05 -0700 (PDT)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b00682a27905b9sm2771969pfm.13.2023.07.28.01.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:12:04 -0700 (PDT)
Date: Fri, 28 Jul 2023 01:12:00 -0700
From: Hyunwoo Kim <v4bel@theori.io>
To: sam@mendozajonas.com
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
	netdev@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [report?] A race condition is suspected.
Message-ID: <20230728081200.GA30175@ubuntu>
References: <20230704060734.GA38702@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704060734.GA38702@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 11:07:34PM -0700, Hyunwoo Kim wrote:
> Dear all,
> 
> From the code, it looks like a use-after-free due to a race condition 
> could be caused by the lack of a proper lock between the ncsi_dev_work() 
> worker and the vlan ioctl:
> ```
>                   cpu0                                          cpu1
> 
>          ncsi_dev_work()
>            ncsi_configure_channel()
>              set_one_vid()
>                rcu_read_lock()
>                                                             sock_ioctl()
>                                                               vlan_ioctl_handler()
>                                                                 unregister_vlan_dev()
>                                                                   vlan_vid_del()
>                                                                     __vlan_vid_del()
>                                                                       vlan_kill_rx_filter_info()
>                                                                         ncsi_vlan_rx_kill_vid()
>                                                                           list_del_rcu(&vlan->list);
>                                                                           kfree(vlan);
>                vid = vlan->vid;    // use-after-free?
>                rcu_read_unlock()
> ```
> 
> However, I do not have a device that uses the ncsi_dev_work() worker, 
> so I have not been able to debug this.
> 
> Can a race condition like this actually happen, and if so, it seems 
> like we need to change `kfree(vlan);` to `kfree_rcu(vlan)`, or add 
> an appropriate lock to the worker.
> 
> 
> Regards,
> Hyunwoo Kim

Hi,

Can I get a review of this report?
Should I submit a patch to replace kfree_rcu()?


Regards,
Hyunwoo Kim

