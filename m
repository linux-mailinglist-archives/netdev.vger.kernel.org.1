Return-Path: <netdev+bounces-51808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DC7FC43F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85571F20F66
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A346BAE;
	Tue, 28 Nov 2023 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgOfmyA3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB319A6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701199628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rB3L8l5l9FR9JfGIti32cmRKxP1LOBDg+O8vN5tWC0=;
	b=VgOfmyA3Zmm6NCvs/UGHB+6xp5B9qnVA/j7AFC51u6hCUNqn0pCZIVW28EAgN29wDwRO1t
	sWl4LFUeqA0AoECNAVF1pTXRNZfwqzo0e52Gewpw9OF9mn97uAPjOLUJ6CzfQwYYqnz4ux
	8Oc259B9OHZ66YG2taQsZqry6bMlSM4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-Qb1rLaw6O72PPcCLCr2Y6w-1; Tue, 28 Nov 2023 14:27:06 -0500
X-MC-Unique: Qb1rLaw6O72PPcCLCr2Y6w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54af782f653so2968204a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701199625; x=1701804425;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rB3L8l5l9FR9JfGIti32cmRKxP1LOBDg+O8vN5tWC0=;
        b=bfGBSxzA5WtPJcZ5heWDX2lWA4wlVyC3T0AQ+W6j8QR53D4+3n9SIdMOtJrMsTLeiE
         jDO5SaE3b/U5rbowh7Fk5v0EGY5BC8X5flxsbMERaB/H8KR9Jk60YsYe4r1zzXAa8WWv
         pfQiNYXzOSMw5+K1XlFbQsudvW+UES88aTT0k0176p35KNNAJOUCQ5wuJYK2swjFihdh
         QF6VLP1OPG07Z72aJUL87ZKRtZ7WohO5RyfM2QSerejUREe8aLvC93MtEbZmirzW9/VU
         J1abTIANlGOPtri5L6lnJa6tGGzJ9iKjWygh2Z4vgU7BBNS6lRQrrYTwwyFyVhRpdcEM
         pRZQ==
X-Gm-Message-State: AOJu0YxftwR9LCbZvy+NNEhZEZ7uFgHHDoUVtJ2Ph0e5OXRGO1USWq3V
	kj85aTk8i6u7q69fxWezvuWRUK7Wu5DFHdQ64fApV19ZxBVnPj3B37bK4spwVXqIlDZEJSAiaZe
	9IDcEIvTZ/bdpWO/fRXPYV053JCrfTzXY
X-Received: by 2002:a50:8a85:0:b0:54b:bb7a:d6fb with SMTP id j5-20020a508a85000000b0054bbb7ad6fbmr1322095edj.16.1701199625841;
        Tue, 28 Nov 2023 11:27:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYVFkt2s5l3Ee8VCXIYdecpMrMNyNxVD0tkeA+yyXcY/1VNaZWAI8sr+kyRrM6ZDE5cg8hNskX/ygf4F0hOe8=
X-Received: by 2002:a50:8a85:0:b0:54b:bb7a:d6fb with SMTP id
 j5-20020a508a85000000b0054bbb7ad6fbmr1322077edj.16.1701199625509; Tue, 28 Nov
 2023 11:27:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 11:27:04 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231128160631.663351-1-pctammela@mojatatu.com> <20231128160631.663351-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231128160631.663351-2-pctammela@mojatatu.com>
Date: Tue, 28 Nov 2023 11:27:04 -0800
Message-ID: <CALnP8ZZWua5iodkML7v02yOLtoCzBmkG8POig577M7m=fy7+Tg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/4] net/sched: act_api: rely on rcu in tcf_idr_check_alloc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, vladbu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 28, 2023 at 01:06:28PM -0300, Pedro Tammela wrote:
> Instead of relying only on the idrinfo->lock mutex for
> bind/alloc logic, rely on a combination of rcu + mutex + atomics
> to better scale the case where multiple rtnl-less filters are
> binding to the same action object.

LGTM


