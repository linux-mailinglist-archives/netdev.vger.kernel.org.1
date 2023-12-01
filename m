Return-Path: <netdev+bounces-53040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA06801251
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98DE1C2088C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C084EB51;
	Fri,  1 Dec 2023 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHR68Fne"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912B1B3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701454260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkTN2703t/eUmx/8vWbVZhfgES0d7W84kF2zC25fiao=;
	b=MHR68FneEdfUiicPyejHoeS+qhspi1t6nT+j2TEBBhXY2NV8TPSKcz6NgbnNLI3RAXwp3F
	TDxoBHTGxamNxMjQGvF2fBX8RKnZEtFDftK19Qb5nxwExOSXCJh9NcLCmEsOwB3eKRJJYj
	P2W4dldfBMv5hHPp1zyaUKfkiDcdZW4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Ew5xU-GmMHO_E5ZnUHy_xw-1; Fri, 01 Dec 2023 13:10:58 -0500
X-MC-Unique: Ew5xU-GmMHO_E5ZnUHy_xw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54c77bd5f84so28673a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454257; x=1702059057;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkTN2703t/eUmx/8vWbVZhfgES0d7W84kF2zC25fiao=;
        b=TsdRGR2v3g1ZC6RaKZ6jxm6PiCF4c/vAwY0rWQRHuJC17E/Exqnfy7rI5lO6wm+Is1
         VivVO1q1hTg93oRklBE01Jrq39qs7bzwxhv7kyJmeA0NIzXtvo8Q99YWrYzmUFBpdEXj
         M7gOGPMKm7Loc5QcrYcQQca5VTWGKh47dBkFtP0sAZjz9pf5SJt6MYVUw2tOjPNExD7W
         AeHcKruiX+fpmPYPtl3HSdMz4ZkcWzidPElLDHZxV70jIceF9lJsnsXO8aXt1onZIzZL
         RcpUJtRX2Hwy5FTrFtbpCpvQ7CU7xFGCMV3CsAt7QjjYBpFPJfEX5GmlAUtSkXnpQfjI
         dNrQ==
X-Gm-Message-State: AOJu0YyMW+4MWmqtfl7Q/CFWnqq8szSZQGr83yIZGYmL4nw1Bl2WNJbf
	pjoGs8engHofq1ePDlMbIReE/50rCF1ZgzGqn2TqOn+lutBaqadLYZngmUmU+vu4586SnYR3PXY
	u3Q7qFYlvT7nJQzGM5QUGp0B15hUO6Xiq
X-Received: by 2002:a50:d7c7:0:b0:54c:47cc:cae6 with SMTP id m7-20020a50d7c7000000b0054c47cccae6mr688437edj.44.1701454257489;
        Fri, 01 Dec 2023 10:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/nPR1BodQYkV956OcNT9Vt5Na7EuznDKdH1eCRfjok7KvRseV3CZXL8yGUtY5dRcAE30AVX5aoRUCBwZoNRo=
X-Received: by 2002:a50:d7c7:0:b0:54c:47cc:cae6 with SMTP id
 m7-20020a50d7c7000000b0054c47cccae6mr688423edj.44.1701454257181; Fri, 01 Dec
 2023 10:10:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 10:10:56 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com>
 <20231201175015.214214-4-pctammela@mojatatu.com> <CALnP8ZaVt6swzFY_aa_FTigA=SHKQDMERDS4398yDcUjYBTYKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALnP8ZaVt6swzFY_aa_FTigA=SHKQDMERDS4398yDcUjYBTYKA@mail.gmail.com>
Date: Fri, 1 Dec 2023 10:10:56 -0800
Message-ID: <CALnP8ZZM5qTEXrF=qQ+7N2THcskPCp1f9m2UohQYgUA4=qE_vQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net/sched: act_api: stop loop over ops
 array on NULL in tcf_action_init
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 01, 2023 at 10:05:12AM -0800, Marcelo Ricardo Leitner wrote:
> On Fri, Dec 01, 2023 at 02:50:14PM -0300, Pedro Tammela wrote:
> > -	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
> > -		if (ops[i])
> > -			module_put(ops[i]->owner);
> > -	}
> > +	for (i = 0; i < TCA_ACT_MAX_PRIO && ops[i]; i++)
> > +		module_put(ops[i]->owner);
> >  	return err;
>
> Seems you thought it would have been an abuse to use
> tcf_act_for_each_action() here as well, which I can understand.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


