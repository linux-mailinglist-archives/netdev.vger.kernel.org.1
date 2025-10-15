Return-Path: <netdev+bounces-229517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82923BDD56F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5473A59F0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280F2D63F6;
	Wed, 15 Oct 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flB5ivjF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8EA2D5C9E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516277; cv=none; b=WT6qem3de2EWRAlgHJOtAgfsuvZD6HE7FhvH71dq3XFvSyBbwjorKGPdv+/taSGFGClNDInSrbl+chddPInciGVQuI/yhLX/W7dcVbJzaPaRQOCu9hYwcTh5eyT+81m6x2j3/eYYnqwL6EH8Us3+QgJ3JfsUimjcMenKgMSnSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516277; c=relaxed/simple;
	bh=bfRQ8lqcd2YFYlwBxx6QijKzWaGKU4WQn1XIi0NM+5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8F5MeeakiVkHzkr9yryjcBhRrCtD6gFW1CcZ+ajqVxiABWlvUwDI4JfnlmuDMJly37pqh5sm57hf/bse0HtdI2BUR0SFzPjEmeWf2P0N5vTPtIWUMj0L0eQcdFqp7Z+ltjlRichWy2ENlDYyKSUME4/O0/lxcqbK6lYvQXqZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flB5ivjF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760516275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfRQ8lqcd2YFYlwBxx6QijKzWaGKU4WQn1XIi0NM+5c=;
	b=flB5ivjFVFf5YiFm2c2mCgmwWqsag6cLTLHzdpWuGqEHwOyiRgkFcvJ5l6O6GZeT8LoGAa
	XGdToAM9OUhDNy/DtqssNZGod53EMm7qro4lT8SYSJjc8NKpu7M8T2gWFm4dsnxQAbNYP7
	sGdCDpuZPs+yck/LUx8B0GhQUAqlAUk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-QThT10I5OUuoiyHBkA47Lw-1; Wed, 15 Oct 2025 04:17:54 -0400
X-MC-Unique: QThT10I5OUuoiyHBkA47Lw-1
X-Mimecast-MFC-AGG-ID: QThT10I5OUuoiyHBkA47Lw_1760516273
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2ef8e0133fso580614766b.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516273; x=1761121073;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfRQ8lqcd2YFYlwBxx6QijKzWaGKU4WQn1XIi0NM+5c=;
        b=dQgpEE+xu6NRlLk4t5OTf4NiABG0MhK6Gg9EY4+ktrY6L+q4I/3XUeEFSFh/6MN817
         Wg+ElO2fCdVHUxAQYVMKyAwv299suLiv5n8YGXMQdEh5MM1ZJEv2WNfFMf01B42TShWz
         1bGOcF2cZ6eAFbpPuOkcGGaFYMdnXxzcL50kVn0aMszYJavEHlD/AaSPVNWfGc3laNzP
         vhpICNSdkVGPYFiLf+vCoC2xgsWcoXgzLzP1kgxqEPLz9tv8aRSI3E+Lk3rkNUze4yf9
         Azo87fcsW8zamACm2AhuG2L6lHxth4tngWwFlqAVxpwgPchT2c8H60+OhWh7Lq/lmqhu
         aaGw==
X-Forwarded-Encrypted: i=1; AJvYcCXqJAJOGQENYezMS6S+QsU3wjnPkK32/SNSkgch3KueIu0xb8Z6npA+WKAJGNZemKjyKkAxsI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzthd2sQ3h7J3YZCpuwIsM6eEM0AmH86WD+7wktZ0hhCFxhfcqM
	RYfGNFc2rs3QhNj7lEqrbTC/zvLDqQ2CrXqg8eTQdYZOSSaFXhMaqoYkEwHqsnMj+qBP1cyjz5F
	eRWWi+cSG85CwnWKF915hUY3LZZUBpb7Th5/Bce8WxxegnPNo//u8Ff6MfQ==
X-Gm-Gg: ASbGncsFEtWot7MSRW9WjAz9q8LJr/Rnio2IRF64KbRsLCLkez/UYJnbDE5AnyNnhXj
	UklJUaHtxMyERFAjt6BFxFR34CEOeSNTnUoiXRN/XtwHbwAbEC8pC0eMo2+/mPpgT7qrEMbtKlv
	HJk6YBEyJjmPWioN6WiJsWp1bwmsDCb9sx3EvK5MBut86tbiTT35KOPRLzxRzM9ccAmjNg6Ykgn
	03r5w/nTHH2SNRCm4EkepPPJHdUD5wk8ljIw9WGx+yNd/u+oZC2/zPnbkfKfifbyaaTf/0KA2gV
	QpN4VhEeMe4eqKcxJot435OQv9iKsU9dYDV410AwB7VL9YCcP7Eh5pifengvvjPFjJY=
X-Received: by 2002:a17:906:289b:b0:b57:43c1:d9e0 with SMTP id a640c23a62f3a-b5743c1eac1mr1334745666b.53.1760516272994;
        Wed, 15 Oct 2025 01:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPR7PSdk0b8qmojXKgBMQ/PUTaZ0eWx1kiQec33HMzp+Zjo9ilxcRXlF/8dOg9iLzbz6smtg==
X-Received: by 2002:a17:906:289b:b0:b57:43c1:d9e0 with SMTP id a640c23a62f3a-b5743c1eac1mr1334743366b.53.1760516272541;
        Wed, 15 Oct 2025 01:17:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965c3a9sm167947266b.16.2025.10.15.01.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:17:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 786502E0420; Wed, 15 Oct 2025 10:17:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 5/6] net: sched: claim one cache line in Qdisc
In-Reply-To: <20251014171907.3554413-6-edumazet@google.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-6-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 15 Oct 2025 10:17:51 +0200
Message-ID: <87ms5sfuj4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Replace state2 field with a boolean.
>
> Move it to a hole between qstats and state so that
> we shrink Qdisc by a full cache line.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


