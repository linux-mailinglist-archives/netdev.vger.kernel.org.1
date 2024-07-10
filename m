Return-Path: <netdev+bounces-110498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F992CA18
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6B41C20DE1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80A37708;
	Wed, 10 Jul 2024 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vCwsDKZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC341EB39
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588557; cv=none; b=MuGZuinnfZQQ45Z5qYMZdkTZrlSobjEgZdFaV9MajGgv1nLqumNSrgLm/xTVuYVX5/vt3qxc7FECaHlIMfNdHWxUQgzi9Yz8G2GnFzj/tAvfA3bHFsrmIdYGdKgYXcNmEs4Jps6x5OAmgiCKoOuP7CcJ6QoxzRlzc2A3eQw3KLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588557; c=relaxed/simple;
	bh=TF4Nl2dxPIhe4X4B9P9hGydA3Smed8+uIFh3AvT2JOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC8lbSxsdgqHQd/+U59Dswvbcb17W3dHmDjRHqbJhdK7H5OtHSKQGJxq+5AOlNzcmy+84JtZQgSrPgzYPW195502Rdi3yn+7ZusUHJsjrK8M/WmSgmCRk+gUHpZ8gNP5Msf6f4nKXDurMO7to91tmftp4lXVspJKV69PzZozwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vCwsDKZW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E77903F63C
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 05:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720588546;
	bh=TF4Nl2dxPIhe4X4B9P9hGydA3Smed8+uIFh3AvT2JOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=vCwsDKZW7E4nd+6q8vVOCkY6MbJq1ERSFzCLxVAK5IYj2oFyFRa4IxuirS82DGP8L
	 tx7inPRZwtdo6nTc+aOsjXHjSf5D0kuSDTCRvOvZnxWOSmjawFoSThojzUBB4otTVC
	 lO7cpMKrXoEdqGLE1NzaXG3hk/tSZIel6RW6EWDNsOZevHAYub9QD/OJzNOvc7n+uL
	 ofLbzYD6RAPCfJBMCP8TWD4bcNghvZqT2id8xPi5P/AAZujL/LbuJA1RlhVXZ7cQjj
	 LIuahTTCyDDcYjsALsrWoq6Y/Da+LMe1LLPuxL652ndGONdjDgEIexqCXUiKt9RinC
	 MrKFZaw/wGPjQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77c5dfbd16so429605966b.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 22:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720588546; x=1721193346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF4Nl2dxPIhe4X4B9P9hGydA3Smed8+uIFh3AvT2JOQ=;
        b=wAWpnBoAMIE4sqmbBDJWAyZ3+SpFvX/J5ShGJeCxjyBdMjovojqCkPi5oTMf4cNsvl
         1LywC0ENX4i3YwN0k/G+Kyh76tLF7syBGpD40/t0yEhqm2WMMJ647PfsIw3/rEWX7QG+
         vRNPcneCMSA29avjFXi1IwtzJ1rqpKrhqHJRzRVWh2reG+1VnlwqGqOvPAjq+nHBcFWM
         I+YqKOwjAJBvUqFqriYuENMxPedAWML5WhjcRzO50MbQV1Xvy6tFFbxFLslzVaDBnX1H
         6sS5a3WPxzOhxX8fIA9k/GUKuvKJ+tJD1JUMJgSwCkEvOtQy70bv87ysgbMJlmREwQHH
         n3qw==
X-Forwarded-Encrypted: i=1; AJvYcCXShojYuLj8RrTAF4vULouuYSWbJm368+AtKFVJxxR2zm0YX/YYl79jDtl1J8IY4Y+0zAZSgZLyvRl8+H8ehDnI8y5Ce8tK
X-Gm-Message-State: AOJu0Yx67gNqWywux2sxJD2e8We3SP8bo2lmK180HW1edQs9Ql4hxkBz
	NiiZ7DLFjKP95uEyl4EKAgEn8irtSXdXEMU5djTnOsCKIgQYQ1LQf/msxhsX7zXx18nwyEJd7VX
	wNS5KHX/gK3L7iarRXaTXyaMZT6l4zQ5x9rZPAVlK1UWCW6SLWzcLwq1u4wvYjOvwNBXl8Q3LbF
	oDNpEZt+HHmoaJCciOk1wM4itz4UNzOC5jcLSASGgASu/+
X-Received: by 2002:a17:906:714e:b0:a77:cd6c:74e1 with SMTP id a640c23a62f3a-a780b89cc91mr305241066b.69.1720588546422;
        Tue, 09 Jul 2024 22:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP7SESNVVCpvQMasACgsvcr86RJx9MBlUgc7j+w196eILbvXyXE0m0sVsYPOnB5vYVbhVbHZN96/g8O3ly+mU=
X-Received: by 2002:a17:906:714e:b0:a77:cd6c:74e1 with SMTP id
 a640c23a62f3a-a780b89cc91mr305238266b.69.1720588546094; Tue, 09 Jul 2024
 22:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain> <20240705093525.GA30758@breakpoint.cc>
 <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
 <ZoukPaoTJKefF1g+@localhost.localdomain> <CAPza5qc0J7QaEjxJBW=AyHOpiSUN9nkhOor_K2dMcpC_kg0cPg@mail.gmail.com>
 <16e61611ecc9209bdf7de68f77804793386850dd.camel@redhat.com>
In-Reply-To: <16e61611ecc9209bdf7de68f77804793386850dd.camel@redhat.com>
From: Chengen Du <chengen.du@canonical.com>
Date: Wed, 10 Jul 2024 13:15:34 +0800
Message-ID: <CAPza5qdn=5zOAjHdyK-iHrmP=sEL150Mrgz=w_wgEcL5MBWZRw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michal Kubiak <michal.kubiak@intel.com>, Florian Westphal <fw@strlen.de>, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, ozsh@nvidia.com, paulb@nvidia.com, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Mon, 2024-07-08 at 17:39 +0800, Chengen Du wrote:
> > On Mon, Jul 8, 2024 at 4:33=E2=80=AFPM Michal Kubiak <michal.kubiak@int=
el.com> wrote:
> > > For example, if "nf_conntrack_confirm()" returns NF_ACCEPT, (even aft=
er
> > > the clash resolving), I would not expect calling "goto drop".
> > > That is why I suggested a less invasive solution which is just blocki=
ng
> > > calling "tcf_ct_flow_table_process_conn()" where there is a risk of U=
AF.
> > > So, I asked if such solution would work in case of this function.
> >
> > Thank you for expressing your concerns in detail.
> >
> > In my humble opinion, skipping the addition of an entry in the flow
> > table is controlled by other logic and may not be suitable to mix with
> > error handling. If nf_conntrack_confirm returns NF_ACCEPT, I believe
> > there is no reason for nf_ct_get to fail. The nf_ct_get function
> > simply converts skb->_nfct into a struct nf_conn type. The only
> > instance it might fail is when CONFIG_NF_CONNTRACK is disabled. The
> > CONFIG_NET_ACT_CT depends on this configuration and determines whether
> > act_ct.c needs to be compiled. Actually, the "goto drop" logic is
> > included for completeness and might only be relevant if the memory is
> > corrupted. Perhaps we could wrap the judgment with "unlikely" to
> > emphasize this point?
>
> I agree with Michal, I think it should be better to just skip
> tcf_ct_flow_table_process_conn() in case of clash to avoid potential
> behavior changes.

Based on your suggestions, I took a deeper look at the code and found
that the drop logic simply adds a count to qstats->drops. It did not
work as I expected in terms of dropping the packet. I apologize for
any confusion this may have caused in our discussion. I will send a v3
to modify the error handling. Thank you for your advice.

>
> Thanks,
>
> Paolo
>

