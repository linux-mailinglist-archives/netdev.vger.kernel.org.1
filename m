Return-Path: <netdev+bounces-53041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33EA801254
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5618BB20925
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8954EB5B;
	Fri,  1 Dec 2023 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo8RwCHr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982AFE
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701454360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eo7xap0NBkXGgcofC7Izp1aCkyA3LViMyhdVJuT5nbs=;
	b=bo8RwCHrgc+qkIkV86gPA6yk50LPCec/poa2Zu+EsaRNhZxiAuZP2AxerhrZPZLRaozGMI
	XJzUCHeCTh98Jflb1ZAyy/iY/xIVIeBH6PvZnGgnGKEsTtd7bQfR2ef7J8pM7OiB4fxDl/
	EbX8bN7Ry0nsHRSwyO/kz4OuAoxN/mI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-rKdpOFvtPHOsG3_qNqahdw-1; Fri, 01 Dec 2023 13:12:37 -0500
X-MC-Unique: rKdpOFvtPHOsG3_qNqahdw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54b40eba4e0so3421311a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454356; x=1702059156;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eo7xap0NBkXGgcofC7Izp1aCkyA3LViMyhdVJuT5nbs=;
        b=SdyjQCA4HF8VDeiZQIZeT1C2NknYF3CA/Oz5dJVeo+1A3AuF6F4gQZzZtZYDFShcE/
         rKpqLeTP6dRYUauURl3HVTE1VyzdY7GwyFIJEbNoT+k8D2teMXC9JhhPEkGmzcvmL02z
         nHGctXhwXU4McUK+QzsAumMao57q8qPntlQ6B+nDhAnC8RIH9RV9WQ56XMl9zvYZuBoR
         FvRWZEHL0W7i/Z/eWC9Cg0InRVwFPwuKKYn+4ERHmRRqyyLr2fI7LuOStrSfMWSLGT/l
         mOm4KVi/umxoTpx98k8LQsaUJIGK6kKgYYtnoVTnwBYXX5sPB9i8/D1Xes91tDoRMJjc
         VBKw==
X-Gm-Message-State: AOJu0Yws6rRqSE6WSp2vDCpLVbgzCG1nlqD+AjGcPsBIDJDxvalMO4S5
	8VI0UrQMtTbTBmNu32ioj1wixrkay51I2AYC/cjv1cAlg6CQMYs9HCXGgqI9USX4XxUIX/QTw2q
	82X7VYjD1Ukt81WqIpCsYs0aMS28A10ip
X-Received: by 2002:aa7:c9d0:0:b0:54b:2760:d99a with SMTP id i16-20020aa7c9d0000000b0054b2760d99amr1985062edt.4.1701454355962;
        Fri, 01 Dec 2023 10:12:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIovzMkU9GGxm/lfiO9iFgkmLmHfKoGkE3JT3QTYZ4vsLfuDjE3meivBRZ+27lhp8Z91Wy1CPhL4dBwGQxqNE=
X-Received: by 2002:aa7:c9d0:0:b0:54b:2760:d99a with SMTP id
 i16-20020aa7c9d0000000b0054b2760d99amr1985049edt.4.1701454355701; Fri, 01 Dec
 2023 10:12:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 10:12:34 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com> <20231201175015.214214-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231201175015.214214-5-pctammela@mojatatu.com>
Date: Fri, 1 Dec 2023 10:12:34 -0800
Message-ID: <CALnP8Zaxp1D3gC8tqRwULdJVL1uSnpGUq43fyL-QRkVTjDFb1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] net/sched: act_api: use
 tcf_act_for_each_action in tcf_idr_insert_many
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 01, 2023 at 02:50:15PM -0300, Pedro Tammela wrote:
> The actions array is contiguous, so stop processing whenever a NULL
> is found. This is already the assumption for tcf_action_destroy[1],
> which is called from tcf_actions_init.
>
> [1] https://elixir.bootlin.com/linux/v6.7-rc3/source/net/sched/act_api.c#L1115
>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Patch could have been squashed with patch 1, btw.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


