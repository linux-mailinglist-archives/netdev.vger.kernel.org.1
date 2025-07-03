Return-Path: <netdev+bounces-203827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA4AF75D4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CBD5675EE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425E29C33E;
	Thu,  3 Jul 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhGe50BY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F513DB9F
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549744; cv=none; b=Vj+caujrJt8Q3WMmwRGSxG2UhTt7RUD8vM8yMOnodZoLzkzAoz99TAsM43CZtLBE/vFH6KZuJxMeEjMbu/EmHqJ08zcD+o8lcYRpDu5rb2yX9mGZkQvgGcx1wMle3SbfAj++PcKZquW1b46ugaUN2YmmrNybEEW6lSBVxBwvKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549744; c=relaxed/simple;
	bh=a+w31SBzpx20AQVT5u5Pj5TY/qHbG3BfdlMP+1tjTIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWpjY5pS1rOjY2YSSYGAAD6NuwNhtUE/b6AmAwKw6z0b5iFyNILU9YIfJ7I2ge2G/nsvfZZTE4SkTmWeGMh2XNR5latObSzJq2Crg5JBEhaLJwhYmdDysVYQJWZIUntTRrMjnD1v/E+nimAFzuk1jcuM1/c/4340dicFrdeE76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhGe50BY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751549741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+w31SBzpx20AQVT5u5Pj5TY/qHbG3BfdlMP+1tjTIk=;
	b=GhGe50BYCvVlcDaVtr8EGY/r7NE/chU6iWxhE12eDO1MQJoeNGR+3FEfnks66ppmFQW6Og
	yIEk44cgk4QSWwAoVrxVtAv8Xe+nQzmm7qwlMGhDTJreEC9x6QfODFoDZwTAY4A7RfW6hf
	uLZ5fbhvdVaiC5LjcolozPPyMV0dsaM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-0PFNBEcsMuOE72wfF4N1Tw-1; Thu, 03 Jul 2025 09:35:40 -0400
X-MC-Unique: 0PFNBEcsMuOE72wfF4N1Tw-1
X-Mimecast-MFC-AGG-ID: 0PFNBEcsMuOE72wfF4N1Tw_1751549739
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b574cd23dso49428541fa.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 06:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751549739; x=1752154539;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+w31SBzpx20AQVT5u5Pj5TY/qHbG3BfdlMP+1tjTIk=;
        b=t0WV9MF+xS8ejKLMo8Dtt3RCRZQi3ElH/1fofUpg6dOjMHdmDqh9gbzqTqjrejqzLh
         scdjxxc2h1Dvm9UVJn1vA1l/V0aEvQoyR7XfEPAAKtNFp4iUenQk1MtQpV5EuqPDXG00
         0EapDNJiAmHZxgpja9KZH5mXIjKQlrCuiF33W/F0Ce71Pkxtfb7Au3+BUjxVJoqjSoKE
         qTtJsX9XHsgBD8z4lsiIl3wIafWX+8eG4wz3uYMLEdRkoe+3cPp+Wt+L3rO0aS1YUwHl
         /7+0hJieX9PYn2MhKDcaMf97ZuIqX3CS6o5pIrQFHQcbD7cQq7DlCj3i6DtVSqnyMP4c
         AnRA==
X-Forwarded-Encrypted: i=1; AJvYcCUVcToQT+hgNLyWVzY4iSAdOU8hDsX9MAkdyMzKcFB6kiBws/6DI871jxuM585YT6sfb9Ww5wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO9+HOmo3vit/JjhLrLFWowGdAwzKRxLvptk4kpO8IZRPjqtz
	LzhRNn6LWGBOiHg9X/lxvmDzusjfQKxo+SRULkHUqSXOugu8RDoRrGr6wJ7rFqIy7yngv5uaFAs
	p3KLMYjYKPcTuQkDdJz2zWeHQXgdoWLSYAgHaESltQm4Nzrptjrkmfg740g==
X-Gm-Gg: ASbGnctUD2VZir5ki3uI4QiMQH+8Ow5JZXlaEVmk4k95yBiwxdOOzJJyu3ffqJhxGDk
	IQq4A8DU6I8HmtoCAme4/j645xlEzQdkCHF8oxJQ1YeOFDww8ErYIoudcXlcMJ0Yw/hGs+MQbfZ
	cLa468iKKXOozBi8+GYIeGmbKgdoAaOKOEoxAKG68rI/ImvuOcp2LrGH2G0IyzHC4vmWhajKar0
	hysZjyAHVzJpwM+D1MKId7y/kkNZfYdUvZGlp71zVv+bIAQI2dNfIRcxKIB7mzT65pezHeYXGX2
	kmmAbhpuZgc6GbCsqmkDf4gysiPRXB2qpKJqdBIMzbVqDpc=
X-Received: by 2002:a2e:be89:0:b0:32b:7149:9396 with SMTP id 38308e7fff4ca-32e0fd18fe6mr8228081fa.41.1751549738988;
        Thu, 03 Jul 2025 06:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQaqzYM0ICxZ0BcYvjzIBIgaPPoPD7CoeNzD4IOdnJqDmOWKXFznuKZROMVSn5ZIRHwy1dDw==
X-Received: by 2002:a2e:be89:0:b0:32b:7149:9396 with SMTP id 38308e7fff4ca-32e0fd18fe6mr8227821fa.41.1751549738530;
        Thu, 03 Jul 2025 06:35:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2ec6592sm21550691fa.57.2025.07.03.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:35:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3747B1B383C6; Thu, 03 Jul 2025 15:35:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Fengyuan Gong <gfengyuan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 edumazet@google.com, "David S . Miller" <davem@davemloft.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cake@lists.bufferbloat.net,
 willemb@google.com, Fengyuan Gong <gfengyuan@google.com>
Subject: Re: [PATCH net-next] net: account for encap headers in qdisc pkt len
In-Reply-To: <20250702160741.1204919-1-gfengyuan@google.com>
References: <20250702160741.1204919-1-gfengyuan@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 03 Jul 2025 15:35:36 +0200
Message-ID: <87zfdl8kif.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fengyuan Gong <gfengyuan@google.com> writes:

> Refine qdisc_pkt_len_init to include headers up through
> the inner transport header when computing header size
> for encapsulations. Also refine net/sched/sch_cake.c
> borrowed from qdisc_pkt_len_init().
>
> Signed-off-by: Fengyuan Gong <gfengyuan@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


