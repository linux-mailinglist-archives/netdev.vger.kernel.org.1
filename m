Return-Path: <netdev+bounces-26632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7541B778740
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2517281FA4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EB15D4;
	Fri, 11 Aug 2023 06:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C4EC6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:04:29 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE652722
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:04:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e29b058cso1273905b3a.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691733868; x=1692338668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+xbAuMaSiM/UeyQGlzbx43nM6gU5cnHUqf9OqajJr8=;
        b=ndpoS56WQkRs2Hi1mVbfgpEHjT72SYJY6bLLudqbgflzVW+LJFgmrvF6Am/Ph/WM2F
         cylgat7IXlDLluQos3fL7DPGe1fQ2WfNHiXB4x9i1+5e34gsvfWPSSGY8riVimhtZ2Q1
         01ptAEXGcDrEs7j079nFYq6U+vGy8k9p6SZ1dIGsufHDnQPVpXf1c31tNuLqEP82PkBx
         1fE//BNv92SOUSHz0jrftVsbvyU+mUIxEb1Dai8lIR5hwFNlm0mJiOA3wloHhWddG73L
         9yfNJO9qXHj0Do9nNDsh7E/NX7GFZlLFTEQAilXwWHF75JEDJRBxaLNSbxRr9Faqouw+
         2I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733868; x=1692338668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+xbAuMaSiM/UeyQGlzbx43nM6gU5cnHUqf9OqajJr8=;
        b=bP5JcSMmbqS0UO2Wa70J+cGont99k73JPPbYaNebmJjb6hHKpu3Bw2pteoht/5oddz
         anGWXdppBM0kpkE4Zhn8BnyjZEPBg63wF+FUpb1a3AK3gOYrhV+yvRErReWVxozf3VdK
         fWA+2PlPPC1LbAzXa/BU306SaipZQbFAweuPKAXkLGHJUxb0B1wXNHqb9mKRQA/vHOEA
         zQUEvQjAH5Mjdo+l0WOOIo49jUC6KEnCeXmzxAeUu3Y60sy2jpalTTZLkQMsM9uN/hkH
         umefAHpioCJr84RA0lCGLqN88aCpJv6e/9zdrCACeQ8+uPBrxWyzE+9lUI6hMUooUMHB
         RYQw==
X-Gm-Message-State: AOJu0Yxaf87kEVf+FLNY8zFjqfHqt8mipvFh+Xty1FDmGn+m++LB16AT
	yg0Xz8zwHrpOnzCpxbVQBMk=
X-Google-Smtp-Source: AGHT+IFjf2gReHa19cQCWU3vo13G1EjftzLGUIeJKMCrYZOPd9VWvQj0c9l8KLs35+Z5Gdg2MJK+Eg==
X-Received: by 2002:a05:6a00:1a05:b0:66d:514c:cb33 with SMTP id g5-20020a056a001a0500b0066d514ccb33mr823586pfv.6.1691733868219;
        Thu, 10 Aug 2023 23:04:28 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b00687cb400f4asm2485798pfe.24.2023.08.10.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:04:27 -0700 (PDT)
Date: Fri, 11 Aug 2023 14:04:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next,v2 0/5] bonding: do some cleanups in bond driver
Message-ID: <ZNXPZunMa51A5ZHY@Laptop-X1>
References: <20230810135007.3834770-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810135007.3834770-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 09:50:02PM +0800, Zhengchao Shao wrote:
> Do some cleanups in bond driver.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> ---
> v2: use IS_ERR instead of NULL check in patch 2/5, update commit 
>     information in patch 3/5, remove inline modifier in patch 4/5
> ---
> Zhengchao Shao (5):
>   bonding: add modifier to initialization function and exit function
>   bonding: use IS_ERR instead of NULL check in bond_create_debugfs
>   bonding: remove redundant NULL check in debugfs function
>   bonding: use bond_set_slave_arr to simplify code
>   bonding: remove unnecessary NULL check in bond_destructor
> 
>  drivers/net/bonding/bond_debugfs.c | 15 +++-----------
>  drivers/net/bonding/bond_main.c    | 32 ++++--------------------------
>  drivers/net/bonding/bond_sysfs.c   |  4 ++--
>  3 files changed, 9 insertions(+), 42 deletions(-)
> 
> -- 
> 2.34.1
> 

