Return-Path: <netdev+bounces-106825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12047917D1F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE3D28A67F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62DF16D4EB;
	Wed, 26 Jun 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTslY9/C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66423BF
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396123; cv=none; b=L+i7+g8XHmnYF8Dibfpu0BoA3nCjhOTnkCrd+0Xvwz5QlWc8DaX6mZgYaNfRLFEnqr8HCPmS293IOy2V0Dx4lpYTccEEtj7OHzVNSNlKmEDvU0HrosSZJXM+b11K9YbtTfWTm8mk7HbA7wDKN9ej/US9USMAQbMnTr/SauGFs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396123; c=relaxed/simple;
	bh=gdrItU7Ucw4I2XnC8bz1GVIEN51yJvk0w7JU+tNIQTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho9zepAeiOmXnaMrF/jBRUHoIaklNN+5/WF7DFiouu6t8HHm6hZ22ajlV1NCfm2d6ZbilfIngL4YjkqRXdWVU/+AJen9hUi3fIH4Fd/6pgYxMhrOnIqbqhfLkFFIi0qMqphlFpLpQQJrGOXXkC8KljQfGLhSCOWd4AJjpld/4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTslY9/C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719396120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdrItU7Ucw4I2XnC8bz1GVIEN51yJvk0w7JU+tNIQTY=;
	b=fTslY9/C8EOb7KMZW8NgC5HYpZKif5hJTnyC0x2r8jBeY01TpDuoOAkbmFiJfTrYR0oGzK
	4hA9hReaThqsedmYwj0lyLyAYlWnwJxdi36OP7RXgtF63gWCI537M/LZ8UC0fnley7+9kV
	txchpoXN+antj744JzANDvutvuwmu/A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-20h0WLOfOjalhUOQFjsVew-1; Wed, 26 Jun 2024 06:01:58 -0400
X-MC-Unique: 20h0WLOfOjalhUOQFjsVew-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7a8fa8013so8251283a91.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396117; x=1720000917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdrItU7Ucw4I2XnC8bz1GVIEN51yJvk0w7JU+tNIQTY=;
        b=tsTG/qopzLbSvpTFd8gjylSqGYWYlp7G7S1QTATLywyd5RexVwzaQwcoPN0k0YJevl
         g/tBLHQUjX6eQjtMB9nI86FTHuu9s6HS0Uqe2nU0F9KT/aHx4MH4GONkvm6prpCuzMy+
         a0jt4K0XNXSNKbrYFmBNqUTvjxWm1WxBI7vtA+dV5XyVnKPeUX2emI5kvYgD6Aq3SFlN
         0tS7h4bnhhp+TsgmqmfdNMAwGVXeKwOBYfZOoZZT5gRRzpToiH0uG9BvXWIL0uqAMcqe
         7UzVVKdMWk8Lfvrin3qRwXgV4AWeHWcyMw7EVHEPybQVD9ku5yyhvyBqEEAVN7XbFm1I
         D8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXOiUpa1Qx27DLLSPmb8hqpQIUOZS+7awAFKNxI9V7/ZvsONROLQpid0p0lt3OYlG8FePJj/keStWRtBCp0RlQXPr34VUSc
X-Gm-Message-State: AOJu0Yxrm//Do/FolxOsiNwaUlm1Kr64krgrh96G93xy45lS8HNuBIM0
	IDdymMsKogT2xSiKgW9BbnQ1ZoYSAO4xgS0HgcWal4zo+aOO89Y6F5nU1ZKrocCGEKo0BysJFea
	PzXHplLJO13Nw2GQqrRX5xLqTeu90zvMG2AKE5p//1omn9mJ1Y/mfKq7bpDo2ADXki79DDSX021
	32BghPjAlWT+ObAh1Sx5bTOef7ndOr
X-Received: by 2002:a17:90a:17a5:b0:2c2:41cf:b0f0 with SMTP id 98e67ed59e1d1-2c858297582mr9204895a91.43.1719396117073;
        Wed, 26 Jun 2024 03:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP5pWyEB+/l3J6qcO21zK7BoGGmi0UDpkfJ7f4rzYXNXczhdeTMPXJZJp+/qspBHnJ6tS4vqXrd+ILXABKKY4=
X-Received: by 2002:a17:90a:17a5:b0:2c2:41cf:b0f0 with SMTP id
 98e67ed59e1d1-2c858297582mr9204863a91.43.1719396116441; Wed, 26 Jun 2024
 03:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611235355.177667-1-ast@fiberby.net> <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com> <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
 <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 26 Jun 2024 12:01:45 +0200
Message-ID: <CAKa-r6uqO20RB-fEVRifAEE_hLA50Zch=wbKtX8vNt5m6kE5_Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:49=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> So, we must htonl() the policy mask in the second hunk in patch 7,somethi=
ng like:
>

or maybe better (but still untested), use NLA_BE32, like netfilter does in =
[1]

[1] https://elixir.bootlin.com/linux/latest/A/ident/NF_NAT_RANGE_MASK

--=20
davide


