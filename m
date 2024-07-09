Return-Path: <netdev+bounces-110216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6B92B588
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4511F22B82
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD7156F20;
	Tue,  9 Jul 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUyfbcmq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EF156883
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521630; cv=none; b=CGP6Sta3ImA9V8kiHRqda30V2pyUeRuAMMwMTZOAhLAh+8jvrc21K4/MYLDu4hQon5oPEwlYZjXx6Oa3T5+FpDqHfuKTXbCBc5zcuSoJwjUYrTn21b3VKSVCYIiS1EGPH9zJd1FEFzxhs0mrdAvDnCq6fXj0Iqo7lqE6z4cyQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521630; c=relaxed/simple;
	bh=6OlBGMZfwdHm2rXl7oNRloLQl3kO9ks+lodaOuu87fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIFjVF5O4LGNZq8gBTg4MRs1oDYWzh+ifl1TwU+jh5/ph4y3PoESISfrqyYBbsjQipc/djL7xNHbFBqr8JIL3Ouh5c81FDmCFV/mDEw1EcoxF9DcgJalhZ0mr7NQfg/7x+V3M5H2yPbHcH/b61T+ny1pTRChVr3zrx8H+n9Aorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUyfbcmq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720521627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6OlBGMZfwdHm2rXl7oNRloLQl3kO9ks+lodaOuu87fg=;
	b=cUyfbcmqKno/pPBjnaaKBh+hpXE8NJWKHYHtebdepzrznhdMMUlOuFTcnLsZHq5aGCLwwv
	Am/JbGeKKris7/I65QkjL+R7yi8l7gF/bbd+FpbcV5HnzaEO4txviZ0RUZuiCnsIys8hog
	27ypE99JZ6TSpmVaVBeUmBeltTa+c3c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-99eURRiFN1S_xsI-MxhV-g-1; Tue, 09 Jul 2024 06:40:26 -0400
X-MC-Unique: 99eURRiFN1S_xsI-MxhV-g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36794d92c46so171597f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521625; x=1721126425;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OlBGMZfwdHm2rXl7oNRloLQl3kO9ks+lodaOuu87fg=;
        b=olLwOGcQM05hTriaZAZ2rlMR7ozeTkw1lFOdiYF8/xYzTW8iRBKbs17dg/tDOLidaC
         z+5T6jNjcH5krdmE/2zuzpiJE3T3G3Nn/8f9Sllr8OozpAQ/0b+SkWUntO5ETPYTkyF8
         KQ8Ww4HeY2L+l0nIbX23LT5t+BID/bSJZB0YMskRxcr+cg0+/3RKeKcii6rJoP0KQ1ZI
         mhAyv0Q3CJIuATxSDBdWVX4xNIdpF7DR6MH4qkbNah54C5JGjhksO2Nas8uxQFVrtygs
         nuinKhWd1IEItWOP2p6GQHakhBQVKLV6S+xfPfuIgfb3kP6d2DUqyOHJnUkA/qpLFNsJ
         x7lw==
X-Forwarded-Encrypted: i=1; AJvYcCXjnylSF818fNej9HlHj69/sFqSDSD5fRzCH7bOniNPa26aNjiv6ZL9K07NALQDCYse1sySQzIKeSQw7JP8rusRBpqjh9vA
X-Gm-Message-State: AOJu0YycAyKGtwnGw2QgkWiqIb3XpjnnaSuXPk2OWNPWyYoOfMDxxrrp
	SUJtLpk7/zTfchymeeJYYz+ecMLmfeBY8LY+2YAG1SZ4Qmbu7a9ODYdROeziORGfXK/9ycFzJQt
	RQrJnRfa6Nv4htLs8++/1XxXlbuZGPXI8K+7tvd4j9uAJDDTMcfbuEg==
X-Received: by 2002:a05:6000:2ad:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-367cea452damr1529349f8f.1.1720521625097;
        Tue, 09 Jul 2024 03:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNCKJ0T7kZ55W4np4jEaOXrU3VVZKHqlYR3BXWtqZzKQ7qSmz5O3yTc2H9GGMw6jEQR7/Y5Q==
X-Received: by 2002:a05:6000:2ad:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-367cea452damr1529322f8f.1.1720521624681;
        Tue, 09 Jul 2024 03:40:24 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810:1180:8096:5705:abe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab09esm2161820f8f.101.2024.07.09.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:40:24 -0700 (PDT)
Message-ID: <16e61611ecc9209bdf7de68f77804793386850dd.camel@redhat.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
From: Paolo Abeni <pabeni@redhat.com>
To: Chengen Du <chengen.du@canonical.com>, Michal Kubiak
	 <michal.kubiak@intel.com>
Cc: Florian Westphal <fw@strlen.de>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com,  jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org,  ozsh@nvidia.com, paulb@nvidia.com,
 marcelo.leitner@gmail.com,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Date: Tue, 09 Jul 2024 12:40:22 +0200
In-Reply-To: <CAPza5qc0J7QaEjxJBW=AyHOpiSUN9nkhOor_K2dMcpC_kg0cPg@mail.gmail.com>
References: <20240705025056.12712-1-chengen.du@canonical.com>
	 <ZoetDiKtWnPT8VTD@localhost.localdomain>
	 <20240705093525.GA30758@breakpoint.cc>
	 <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
	 <ZoukPaoTJKefF1g+@localhost.localdomain>
	 <CAPza5qc0J7QaEjxJBW=AyHOpiSUN9nkhOor_K2dMcpC_kg0cPg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 17:39 +0800, Chengen Du wrote:
> On Mon, Jul 8, 2024 at 4:33=E2=80=AFPM Michal Kubiak <michal.kubiak@intel=
.com> wrote:
> > For example, if "nf_conntrack_confirm()" returns NF_ACCEPT, (even after
> > the clash resolving), I would not expect calling "goto drop".
> > That is why I suggested a less invasive solution which is just blocking
> > calling "tcf_ct_flow_table_process_conn()" where there is a risk of UAF=
.
> > So, I asked if such solution would work in case of this function.
>=20
> Thank you for expressing your concerns in detail.
>=20
> In my humble opinion, skipping the addition of an entry in the flow
> table is controlled by other logic and may not be suitable to mix with
> error handling. If nf_conntrack_confirm returns NF_ACCEPT, I believe
> there is no reason for nf_ct_get to fail. The nf_ct_get function
> simply converts skb->_nfct into a struct nf_conn type. The only
> instance it might fail is when CONFIG_NF_CONNTRACK is disabled. The
> CONFIG_NET_ACT_CT depends on this configuration and determines whether
> act_ct.c needs to be compiled. Actually, the "goto drop" logic is
> included for completeness and might only be relevant if the memory is
> corrupted. Perhaps we could wrap the judgment with "unlikely" to
> emphasize this point?

I agree with Michal, I think it should be better to just skip
tcf_ct_flow_table_process_conn() in case of clash to avoid potential
behavior changes.

Thanks,

Paolo


