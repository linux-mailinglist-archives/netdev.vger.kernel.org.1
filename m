Return-Path: <netdev+bounces-250502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19CD30004
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D4E6301057E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC693624B5;
	Fri, 16 Jan 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgXFXUMo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+jdHZr/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84A35FF54
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561209; cv=none; b=KxwHp1zjGnS3x/nEJ7nsp5PJwA3hQPm76aopzEcTY9XYwhbCWYyKW0862EDPYeHR4fzTk7qCximV7Kpf3ANgCK6t4fTtAFK5zub5Fq2IyH7oWt9NKzLtHM9mGkly7GbgdM8H1AuAREv81yg8MeL5Fb7gU+LnIvZZDlJoHhuWBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561209; c=relaxed/simple;
	bh=vksLTZkUWWrOReeJ5m+TZEyTyRNJeH3pyvTWA6g0a/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAt9MU5qR6gak582q43pcCs7dj6MYFtRDETLTOxhHNBTwfPHCzLinl14mrD3Qb8My3OKaDn2EcHbxOL6XGFemAXn7oCpGuZiVVLqEdCcoSafKUzmguRl8gE8bbcLS6olPmheBd4BFTI/HwR7j+NMCxZMXh0EUasghtc4ZC/79TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgXFXUMo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+jdHZr/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768561206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9DcHDZID0O5xO6b4wZGyRTdWKoELa3pTt4TtE2mtQ60=;
	b=FgXFXUMoQuk7jOEqM5rvEE3VfyKVeTu8+CaovjEnn2pg/L3a58qakVecP0qHNS28PZ3MV/
	viritmjaXVFX2REkg3Ib7OCGwm5MbSdU0bXAKjamVqCe7xgZfH++dXFPZ0qYzuQmUO5yF3
	7mgVF/5v826ly3gfecsrHEe1rHX/sMg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652--a1kCoyoObCm7bUFMkqrwA-1; Fri, 16 Jan 2026 06:00:05 -0500
X-MC-Unique: -a1kCoyoObCm7bUFMkqrwA-1
X-Mimecast-MFC-AGG-ID: -a1kCoyoObCm7bUFMkqrwA_1768561204
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b871d7ad66cso406741566b.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768561204; x=1769166004; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DcHDZID0O5xO6b4wZGyRTdWKoELa3pTt4TtE2mtQ60=;
        b=f+jdHZr/6KcG9Ptvcjn3/H1dJdOTbghHSHX5aXcNon/B6i0Z6yokuimjj8fYl4GApj
         m62VV0a5QtXfKL4aMx0R2e6Ziao0Uq0bsui10dN3pCszyEGwsvprMpoBEXnMQd+foTmb
         7fiqUxwYY8yKl/kz6cdhSGSi5b16ui71INjBxdr5Jlm7kimQYPdTVKzsgAopk6qLoITQ
         Xm1Hzl+MemMJuIAUr5qoDygxXe14nCrz/ce1LUQJQpcSJ1Ifm3lsGnu0j7WLy5Q479DJ
         3gK5EigDn3A1rOW7GeBeCwECOnE5W22WskFTeXyzJVyVeGclYQqTQKuWP2E/IYX4Z3bE
         8xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768561204; x=1769166004;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DcHDZID0O5xO6b4wZGyRTdWKoELa3pTt4TtE2mtQ60=;
        b=dbY6O7DLDG/tjhQwF2YEOww+VUG2qHd2yajwkdx9b3tZmQoZ2MZOb8yYfFpUpfjkUx
         ybMVcJcy3ERHKDc2IAqGp7PQbDSIXWAIuSwnHXRyqYQZyF8pnuoIBZluEp2TsBsiG8J5
         ePsn4lW3nDb6oasE1stKKb9oUlWHgmOcKe/GCiVPiqG0Y6c+JhXKwQ0wjczL3XCV/7dS
         fnCGLKK4OMrdPH2DetU3v2yhcEJPHbOSyW3+FRyBD/shGDaMn/fF0ox/axkkUgjfkj8i
         oSsIl+XwPOCXGaq/GIJCKI64Z3N/w9I9VVvxk9SyGrd9zByow+O8Xb+HK7mcGxjnmhxI
         CARA==
X-Forwarded-Encrypted: i=1; AJvYcCWn7YW00YU1RlIHb04SiLTtESOxrMtUSkDSjXOx9dQijPxOlZGdwgF5kwCPk4iFhAZgHqO/RnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vfLTYqRmFRaSWRlsVX6mA+oPX7DWcEiKje6VRDt7O/bbcfXy
	7eXRsWejpShw9NvWeRXvlCpFznERL7GX1dKKY+kVYifgXxqSQpK10ukXq2dJWdDFQZ27owFNZqb
	zqSodL7y/STRBsHkg73iBnwNUOTkY8qAI0uXwkFRJM4w5TnO9mtjzntiJSw==
X-Gm-Gg: AY/fxX72B2FZ8OhbBwioBT10J1rxJCfcrf8FVh8zbeX1zNcwB0Mk+Sb9pZ6W8hDT5mk
	j2ZkK3hdpRksDrkucsTxEXSF9JqAbxff4YJs5qEAy/IPTH8gw2NoxlzAmZvhQhou30ZRayeaFTb
	/dib2bzrjH/4TsmUcSewMwjXKS+9cVb/2gZ1aVu9UYSUt6Y8twJ20t7kVtAYKgXsjhq4z+nvwdN
	1fVyJf49Sb6Oku1fXLlpOQ8aR2JQLoXvBwwz4MHidaPjmpgZhr6lQVHT3b+ky9DRr9OYY+PfVXc
	QbTcVtvyvU/milAE+/VUQMSUIIX0Yu7a7mQfSTdrjzNHHqS6w8HhFPx6MSPKE2jbCbz7F3lbTiJ
	7P3rz/Uosv0Zk8UOS2kmDEru1CV5pn9KqIDSC
X-Received: by 2002:a17:907:a48:b0:b87:672c:4108 with SMTP id a640c23a62f3a-b879385870amr281458366b.4.1768561204266;
        Fri, 16 Jan 2026 03:00:04 -0800 (PST)
X-Received: by 2002:a17:907:a48:b0:b87:672c:4108 with SMTP id a640c23a62f3a-b879385870amr281454866b.4.1768561203767;
        Fri, 16 Jan 2026 03:00:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9b5bsm208337266b.44.2026.01.16.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 03:00:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AA04B408DF9; Fri, 16 Jan 2026 12:00:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, carges@cloudflare.com,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
In-Reply-To: <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
 <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Jan 2026 12:00:00 +0100
Message-ID: <87ms2dzutr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Hi Eric,
>
> I need an opinion on naming for drop_reasons below.
>
> On 15/01/2026 13.23, Jesper Dangaard Brouer wrote:
>> Add specific drop reasons to SFQ qdisc to improve packet drop observability
>> and monitoring capabilities. This change replaces generic qdisc_drop()
>> calls with qdisc_drop_reason() to provide granular metrics about different
>> drop scenarios in production environments.
>> 
>> Two new drop reasons are introduced:
>> 
>> - SKB_DROP_REASON_QDISC_MAXFLOWS: Used when a new flow cannot be created
>>    because the maximum number of flows (flows parameter) has been
>>    reached and no free flow slots are available.
>> 
>> - SKB_DROP_REASON_QDISC_MAXDEPTH: Used when a flow's queue length exceeds
>>    the per-flow depth limit (depth parameter), triggering either tail drop
>>    or head drop depending on headdrop configuration.
>
> I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three 
> drop_reason") (Author: Eric Dumazet).
>
>   SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
>   SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
>   SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded
>
> Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
> Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?
>
> Currently SKB_DROP_REASON_QDISC_MAXDEPTH is only used in SFQ, but it
> might be usable in other qdisc as well.  Except that I noticed the
> meaning of SKB_DROP_REASON_FQ_FLOW_LIMIT which is basically the same.
> This made me think that perhaps I should also make it qdisc specific.
> I'm considering adding a per-flow limit to fq_codel as I'm seeing prod
> issues with the global 10240 packet limit. This also need a similar flow
> depth limit drop reason. I'm undecided which way to go, please advice.

IMO, we should be reusing drop reasons where it makes sense (so
s/FQ/QDISC/ SKB_DROP_REASON_FQ_FLOW_LIMIT), but not sure if these are
considered UAPI (i.e., can we change the name of the existing one)?

-Toke


