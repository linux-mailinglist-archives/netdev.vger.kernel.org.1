Return-Path: <netdev+bounces-24170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DD76F170
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167382822EE
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E2C25179;
	Thu,  3 Aug 2023 18:07:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6E18B17
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:07:16 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26524687;
	Thu,  3 Aug 2023 11:06:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703a0453fso19943361fa.3;
        Thu, 03 Aug 2023 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691085970; x=1691690770;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rwNzRqjsrLX7WFu9uVGqEYEvQpQsX92GbYXkGO6oQUM=;
        b=AslnQeH8eJzuq/VVUImwQu7TOUfyV14+eujAZVLjLqGh/+0SMz+Lh6qHSjMIUFrkCc
         pZCx1XsYT2n7OamDWbeT3SVdzhLG4LEoC6jbvBi5cb9pzf1aK0iUX6AK/KSy2icXOneH
         PEu3E+PReDyGib4cSZ7OPbzwqLC8Nqpf3GVvxg4XR3Yu+22khOTMRw5lPq9nPIvEqAhu
         fWQ7B2Q6tj/nMbxXVgWWt8Fzh1N3+Drrj9r5fNaaBtsEIfO92aqDVaASfLaL2vzNz2S6
         bQSwhjFiCcJ6LVJCDb7yM3PaZYnUoaznR6mciWfM+P9Vc77+1gsPiFKSLNYSJha2MX/o
         auWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085970; x=1691690770;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwNzRqjsrLX7WFu9uVGqEYEvQpQsX92GbYXkGO6oQUM=;
        b=c+nqUFv2wQfW2/IQni5f/9soiiBABgkt3zGBNbp0fquRTw+5hEWkjKe0rjEnwp86Fz
         xFDATtFfNQm85WE7AWZy4DHBDjQK2TnxHBWXhS6rjZeWAiwYWYASLz5sflgaCs3Sgxbp
         Ag/LVYWDNn322nBQWGO2S6US8RaHX/j/Rf9Vej9VRlrJEPqWo8eO1bO4oy3bmhSHSYCt
         aos4EcxexHiJK5WnT/3BTwF7fev6ZsC9+aRMyLAx5XzQ/l8STbGoRdV0Ddi0vgNHdlK7
         FmUrReUyHTaWfQdvr9KgTvUXPEX384DGjX/LCo04kPk6+iELfGCbA9oyD6nadGEC5UJX
         c7Lg==
X-Gm-Message-State: ABy/qLaZvAoiNZpUWta09gCZrXxi4PVKkrXHDfRe8U3AAX63cIFVQ2PB
	CpZr0VZvbMsP/Fo4s3doy4E=
X-Google-Smtp-Source: APBJJlGbCy5C9fzMhHjjvo0tgtF2IkFwdRgCZxb3iJwwrsH/cch2pmhWpr6yZtVvcdlAt7ENP5rkXw==
X-Received: by 2002:a2e:870a:0:b0:2b9:4821:22b6 with SMTP id m10-20020a2e870a000000b002b9482122b6mr8678156lji.10.1691085970211;
        Thu, 03 Aug 2023 11:06:10 -0700 (PDT)
Received: from akanner-r14. ([77.222.27.58])
        by smtp.gmail.com with ESMTPSA id p3-20020a2ea403000000b002b9db7df0dasm66225ljn.8.2023.08.03.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:06:09 -0700 (PDT)
Message-ID: <64cbec91.2e0a0220.d8b3d.0706@mx.google.com>
X-Google-Original-Message-ID: <ZMvsjUfeVm+y8lpk@akanner-r14.>
Date: Thu, 3 Aug 2023 21:06:05 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
	dsahern@gmail.com, jbrouer@redhat.com, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/2] net: core: remove unnecessary frame_sz check in
 bpf_xdp_adjust_tail()
References: <20230801220710.464-1-andrew.kanner@gmail.com>
 <20230801220710.464-2-andrew.kanner@gmail.com>
 <CACGkMEtRyEkpRetANvU1L97gLtVVT+vaBV1Hmh2QqZu9c9tvYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtRyEkpRetANvU1L97gLtVVT+vaBV1Hmh2QqZu9c9tvYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 11:20:20AM +0800, Jason Wang wrote:
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thanks
> 

Thanks, Jason.
I will use this tag in v5, if you don't mind.
PATCH 2/2 will be the same but with more recipients.

-- 
Andrew Kanner

