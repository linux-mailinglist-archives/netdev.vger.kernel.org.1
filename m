Return-Path: <netdev+bounces-133094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53719948E8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BADB2375C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A81D9586;
	Tue,  8 Oct 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg5f1Sgs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD761DED43
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389864; cv=none; b=LDotWcllgw+dQdkjckpVN2TPn3TTRvdUkwhM99ybgDXDKn49UktIm0NiSvlw6cvAyWbEo/SriQNqwAbST8j3zohq8XFUKU4Y9AWbcZ6fW1LCU9WYivV5ELBoCF7WmyDjJR/gPLaxKGy+PG5wDrrniHaTer6akbVTj6CtMm60XNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389864; c=relaxed/simple;
	bh=QHD7QY8RoumWRwS/XQTrqgrye6bie3+hE4yLSYgIGVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1XlWXjrfacrmoPxNrj34giBqc2/nTeVJswUXCD6A3XDTKbEbBy0+cT9jEmLEnDc73i4HEHEzqfKXBuAePs00MwpzXDUUeiWaLo4mKShDm//P1SfdfQk5o7H0cShSKPGutwlZZ8oAeqToUKUQKBoVubS5wgPyyzFSiZLjO1cdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lg5f1Sgs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728389861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHD7QY8RoumWRwS/XQTrqgrye6bie3+hE4yLSYgIGVM=;
	b=Lg5f1SgsqmTmKcjUxF9aFfg0DFGeH/+53kQyn3gymn6sDLMa7Z9uXgVn+xsHIlxvDpLzMO
	Bh0wPcNUA1OwJlCMmc7z7OObJ7/3ntSNNqZf4PfZjDyvb2pVfqAVRcRDnK+5za8tbJGFIW
	hjwy2iLD9HLzuizyNSgZs2r9WffoRdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-_pOqYFnAOLavoz_iMuzOkg-1; Tue, 08 Oct 2024 08:17:40 -0400
X-MC-Unique: _pOqYFnAOLavoz_iMuzOkg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso35734245e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 05:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389859; x=1728994659;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHD7QY8RoumWRwS/XQTrqgrye6bie3+hE4yLSYgIGVM=;
        b=vXZc3v3tcrh2N61RhX8O2IoKSldIfmx8MXmkU2DRMvk+p4Vvy1u117VScu4zcRApOC
         rH95u5UEJ4UweAmEZ/PbIIINLH91SOvTEV1IbtULCfbWN6/obnHlOeDfiUua033ir7qZ
         i4Pw3IpcJ317PONisl03BXVZup3laAoACersE1K5zElgsEn3NofxHL0S4c4nhAIfxlMq
         E0iXqYPfQLV80szm7AKISg7OgtD0v3A4b5quW0s9q9I4CiEkcDhziqvhYusgHsrJW7Lz
         5o5RBu2+MjBr920uEwAZzPjcHG92IT1azPeFLA7BAc3prXZCPIMHN2I9dEAOEZ/XUo1w
         ObGw==
X-Forwarded-Encrypted: i=1; AJvYcCWqbZOlYb9QJ3YKa88PP6HOCZehnXpWlFzUpjULAInRcyViF4nN0taJOVL7vyEY5FiHQf+wXVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgpr+ap5kHGHSJnFx8/GNbZRTWMq+gNK5wg6ZT4zWdVbZ4fjG
	ynZ6jluTdtNtWymXJS4CCy/nW99eUowRxFLnw3wVZIxIEEVRlICSaXHS0ErNsPCD+7ShIgfMggW
	2tQck/QX6IQSkBFpsTbcThaXR+2/7rZ6FRarDxH3hl5Rq1bOA85MPpg==
X-Received: by 2002:a05:600c:4fcf:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42f85abeab0mr108625205e9.16.1728389859363;
        Tue, 08 Oct 2024 05:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRdYgvvEv8qsnzNPpi5TC4nFZj3GSarZnX9do8ZostbEqjsg9oTofT38d5Lakr9m0BZr6DAw==
X-Received: by 2002:a05:600c:4fcf:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42f85abeab0mr108624865e9.16.1728389858848;
        Tue, 08 Oct 2024 05:17:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972cd2sm7986202f8f.107.2024.10.08.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:17:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6933D15F3B60; Tue, 08 Oct 2024 14:17:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next] net_sched: sch_sfq: handle bigger packets
In-Reply-To: <20241008111603.653140-1-edumazet@google.com>
References: <20241008111603.653140-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Oct 2024 14:17:37 +0200
Message-ID: <87frp6u6u6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> SFQ has an assumption on dealing with packets smaller than 64KB.
>
> Even before BIG TCP, TCA_STAB can provide arbitrary big values
> in qdisc_pkt_len(skb)
>
> It is time to switch (struct sfq_slot)->allot to a 32bit field.
>
> sizeof(struct sfq_slot) is now 64 bytes, giving better cache locality.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Makes sense!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


