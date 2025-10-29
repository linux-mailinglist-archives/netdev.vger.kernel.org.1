Return-Path: <netdev+bounces-233857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E882CC1948F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FD1AA3C0A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D32DC355;
	Wed, 29 Oct 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzQ19/Tk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3502E2663
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728518; cv=none; b=X8G6cboeiXrVSYlB0kP80IiiDZvqZgijBoLoPXLJQF8gp0dpLblNs0sszUjQ3TEgnio+c76Fpjpv2sMylhTyQ3CmXcJQNOS4YlQMK464bIkRMXw0jt0KC8qxr6P2Yy3n8HeH0X83H0hZI0OXLVJG6d5pE3nncVYgTebJiBaSoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728518; c=relaxed/simple;
	bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mo79OqARUrlfaCK2QFY5rel1O6ZWOVvu6FrXXbyEaFRfNfz8J/3TD8tCBcpxnsznfV7hkyG3Ltgz1whLhNnJtLiYx7GI6ZiIpNSveVW0sm8cHaejXR063VyEy0RXFkBy52NR1SATrB5JDX0lb0/j+huWXlNRk87AcOiU8VKukW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzQ19/Tk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761728516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
	b=WzQ19/TkYND7jhNUeVENLQnaScwLJamnqRbgUmcsv2M9qYWhW8cDWvJEemed6eudZIWvHm
	wCW8rjUvnLgdhmlZq+mXjBCU03t0pspBVAUVEAoE3KuXLCPWCW1z9OLxgKcIEvZlRgAxfr
	wiQk+ONKtYjwBGvaxOh/peSSpijwGkg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-hamXRya4NAGKj1rem8jcWg-1; Wed, 29 Oct 2025 05:01:53 -0400
X-MC-Unique: hamXRya4NAGKj1rem8jcWg-1
X-Mimecast-MFC-AGG-ID: hamXRya4NAGKj1rem8jcWg_1761728512
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b6d546f68a0so648464766b.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728512; x=1762333312;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
        b=M8GibEpz5m9LOyyuzrczZdPsRtAd+m7ttyWs8lHCxsdrsivvNNDs0n5Ws5VKW3VSS2
         uvnjzf6ppcg/BOgWXJZiP3s0MuPRDWj8zWfoci7312SkSRsT+Tew6/6px6upy64Y8sWx
         vBGSbpsOviYHV+RFtj4zugaUJIUyYH3cUrc7lfFdBAa8hh0xdHQpBxH9fHeHVVCyG0rM
         YUbdOKCD+BvK8zAaKC/kwn++lJD5VtYKSEj35BfEqR9cRwXg8cASSaulp9P7Qd4qN97R
         ryHQMx4LsOGwwMhAcSwP7setfECv2+v/MCuuSsijzEbi9YOHKeeYRUzjGfCp2ZxSPM9I
         D+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUx/FCzyVYVc2eoZsJlWJO3GLLbAenjCi2W8S6+PTNtzPDPQAY4GH9LY1abBlD4X0G7Cn2E65o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEXFrmv9tBcR0DbvIvN5/H2RjP9ELd6QIR7wX8r3VKiQ2P1X3
	9DJCLF8lFd8VSoBN7Od36peroNYqxuDFWS3abIQjCQHvnaTy9v63nt3dZt20D/kE9cBjpuaXVSE
	ZjAi5/1HWwNBwQXPaOQkfaDi98VkciIyoGZHrhdZHoxWI8+P6aHnhUI0Wxw==
X-Gm-Gg: ASbGncviUZJ/Nihkn8jp7gYvp5V3u2tsPR13ZZyV/5/8WxxfiVmXUeoljQQXpUlyKlK
	ybV0q4JXX7xMLT0RyGkXn4PCSzUqlgpomgwEWU0+laEfmqjiNXeo0fHEFmbLn6+fKDpxOQxBh3/
	t13pkuSScXxBrHCIsetVAoixSZaQHlUD5FhODLqzLqZy1rVPMsSXI6TDnpSUwrowdOZlbpicBcB
	D+mW0GhIASevrBaVMKq0ZMMo41WdfOz91q35sHubOwNn708hK9FYORR608qh3cEYJF1gaH2VPMC
	bHtbqDtrxrePkQJpN/SfwOtNOW1AYLEClZJ1QZ8Z2YHOtX7IklSfnC0BSkc8aeqe5OQahZ4O2SJ
	tE82EW3e6gNHKtk6BWRUH7ew=
X-Received: by 2002:a17:907:74e:b0:b6d:961e:fbcd with SMTP id a640c23a62f3a-b703d55d4aamr202755566b.50.1761728512239;
        Wed, 29 Oct 2025 02:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMkTxdQ+/5aKXOuyyh5AS0UFPHYZnXvO/Q6mw+JBd9i8Az/ovnrbFoR0xn/NRL22/zzcs1Fw==
X-Received: by 2002:a17:907:74e:b0:b6d:961e:fbcd with SMTP id a640c23a62f3a-b703d55d4aamr202751666b.50.1761728511716;
        Wed, 29 Oct 2025 02:01:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853eeea7sm1373575066b.47.2025.10.29.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:01:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 623092EAE5D; Wed, 29 Oct 2025 10:01:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, nicolas.dichtel@6wind.com, Adrian Moreno
 <amorenoz@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
In-Reply-To: <20251029080154.3794720-1-amorenoz@redhat.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 29 Oct 2025 10:01:48 +0100
Message-ID: <875xbydqtf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adrian Moreno <amorenoz@redhat.com> writes:

> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
>
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
>
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
>
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


