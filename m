Return-Path: <netdev+bounces-204374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC8AFA2D3
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 05:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D683B629A
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC791547C0;
	Sun,  6 Jul 2025 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm7ywA5o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553B2E36F6
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751771258; cv=none; b=B/+VMSiOm6vFipm5noScMI596w+MCy/CoycpaKOUS07f3uDBacCOT1Yamk+Iv2Ug70UWQAvIWrW0aM4HihaoMHhJ9TPt67Ysi1EJ0WKhcKt9I85eIQQzXesc629OKVPKvF4j1lq7PpBBpdVVEXOFk67wSb9yAboOo9xvINUiFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751771258; c=relaxed/simple;
	bh=VuCjj2MQ8sgmbGuNT+dkYL0J5A5635INk2QkQBk3D2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOWP/PwT0r8aArqi3h9rsW7M5EvvhRr8za3IQgK3u20zI03u3bTsGVfGAK+TNGEIrkXGw+u2tKGnbJXGMx0GScoySgJClH1e3AWFlOvLh3/CTozgcP7c8zezaANGDNThJ4lF3+gujqQf825ZsxfpRfzs/QBu06juL/F8ztADdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm7ywA5o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1632481b3a.2
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 20:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751771254; x=1752376054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qixshjKfFwR3v8v4HXHEgmY8rQMmYay7ALz0do5olqs=;
        b=Gm7ywA5oF/mGE7H0AdhJg5hwy315Xu9wkJALEgQxBD2mSNurqj+5LJ9XCNa8Eo6nR0
         tzqfHKG8NAl6NihZ3pJcNCgQvdOfYXdn4lB6OsU/0VIkrlh5VfyBtmVOmPz++Cs9JnPn
         UpMoH6+KymOAAM+fWO1zmZrBgjz/cN1WC7qioSI4xWUqnP2fngRIVWBuWIXA6/+fUmCS
         le9OIjomTCCGH/RMiKoYUHZxGsPzkRzr1+3LgHzvDAi/TL/xL/Ngl75KIgITZ7tAM5hG
         Z7qCm9aDbwS+5gScgV5FYjhv6y9dL+UVa17GTjzfjDbQHUklexrECCYIeGdZ2XrqDmaM
         WbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751771254; x=1752376054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qixshjKfFwR3v8v4HXHEgmY8rQMmYay7ALz0do5olqs=;
        b=YfMkk8l/GjqKtmHzpNdqpLTADVqZYqlCEbOR7bBf5JVT73ByO4ZcQt1UcroSt+oQBO
         pB7U1BtkrEATLdHPiQS2fcxWmBVoqSq0Ws2QID54k+ZhSF9+qjmmAo/0pauLl2BTeo1c
         k86IWcMaXHcEFvoM7qBJ35m8yalkNSlLyNpsKH2HaK6qNOOB4EWuBOBQ2hc/qePzXqo9
         HHiR0Q2BHWsL7BcuUK/PYJiiztZxA71l2cRj2TgbmNVIIINsBJ3H9nXrojrednU6OD8d
         EMIWu2jmKMh5aZa0lEtnwam8EycQlce0tkUArL6CplYempZjrvXKZhY5TgBdJCZSXJeb
         S5dg==
X-Gm-Message-State: AOJu0YyXNMbQ2bSMYD/b1sgKuDNYrNPzBCqiK7uU8VVWaJrrCcfPigLm
	Dpc+c3qBc1aFM3la715JwqSlwXKLCtLIG85xl2CoTz3mgfua+SRjmSYt
X-Gm-Gg: ASbGncuGUb1RIAIT1ePrIN7EA4MDVEhug5Wwf30IaAc5IYo1g3mcCPc+8uprIUnEQhp
	qQYO2JB90SRb3zMZOl5/LZ2iGnfuNwpfmyacfnTbFn+R11zMIDe7PCtytf9zWoFnCqFVxYypT9Q
	VAN3sDj+C4Fg7faFy7UPp9tBOegxviSywwjXvSs6K2cpIONHW0JFuxIeeAk+i6mglDS/gjbPtdd
	mLrEDo2pkcefEGcQ1cp35ROhY2dZzPbBsllYkxQYvbNdDF1F8nK5nY3SkHTUwnW17SzQ4W3P3FA
	NNeNdZukBRy6pQtNN02yESmRWTKMSXVUcVA3ENsS/ZXuIbEyN4p6AgRyNrdzrIiKRlLsfICcRpM
	5P9s=
X-Google-Smtp-Source: AGHT+IHWz9EiQWYyvcieAMgw3vPvzYZ7Xo8CrNN19UVvREpHm4ggUMsntvB548/LvpCFNQCCcVJFhQ==
X-Received: by 2002:aa7:88c7:0:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-74ce8aa58bfmr9605193b3a.13.1751771253831;
        Sat, 05 Jul 2025 20:07:33 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:357d:7cd8:b68f:6a2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cba78sm5919529b3a.57.2025.07.05.20.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 20:07:33 -0700 (PDT)
Date: Sat, 5 Jul 2025 20:07:32 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Message-ID: <aGnodC+JgY8wI9xc@pop-os.localdomain>
References: <aGdceCwEZ/cwzKq9@pop-os.localdomain>
 <20250705212143.3982664-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705212143.3982664-1-xmei5@asu.edu>

On Sat, Jul 05, 2025 at 02:21:43PM -0700, Xiang Mei wrote:
> To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
> when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
> value before using it, similar to the existing approach in sch_hfsc.c.
> 
> To avoid code duplication, the following changes are made:
> 
> 1. Changed qdisc_warn_nonwc(include/net/pkt_sched.h) into a static
> inline function.
> 
> 2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
> include/net/pkt_sched.h so that sch_qfq can reuse it.
> 
> 3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

