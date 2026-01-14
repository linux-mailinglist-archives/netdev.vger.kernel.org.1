Return-Path: <netdev+bounces-249817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A7D1E82A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A599B30BF333
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55193395DA5;
	Wed, 14 Jan 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpRB2zxe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVI6bK2+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDE395DB8
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390745; cv=none; b=fnVLSIjflnnIVTHbKUUdMPcDsSv/yYBUPeYJmTfjpC52rI+yr/itzF5bVXyQJoGow7p6RemNQb8fzv6Ed24ROvbJIpa70z9HlipSOLiK0CCi0ZXjuu6JVptSQsffzmZu5HRWdR+RQKdtK5NZmJmdtM4G4Pc8WgSZ9KipVeZzeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390745; c=relaxed/simple;
	bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mjf2G8q5o7jv4DFr33ZfLMFA9YjfJOL3bEH/aCnDCCIjYUuWaJPHgohzxhZyFo7EtOmMBwrZDTqfqVJkKs6ddcNsAAuhjQi0kvIXII9CRk186Gn37iP1/YB1/oYWR1Mrpw/Y0sfCKRPMeZQ0mqxLgs42QbuBKg3z1rLvJZsPZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpRB2zxe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVI6bK2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768390742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
	b=cpRB2zxeOVjbia4qVAtvnUj1oPPGvGZEqluitrbKVBftlfjFBFgmBSddMjEWs+RU9eepup
	hghAyMsKbuAPczkC55VNuBe7PBty5RByRHqZIwmEMVHPH3CCpZ8x3mSWsxKZ7t3HW/ySlO
	uVP/wNu6KbspdVvBn/Vd4vkFsAgp/sA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-cYYq8n8GPTqda3LkAeUkHA-1; Wed, 14 Jan 2026 06:39:01 -0500
X-MC-Unique: cYYq8n8GPTqda3LkAeUkHA-1
X-Mimecast-MFC-AGG-ID: cYYq8n8GPTqda3LkAeUkHA_1768390740
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b872c88d115so313417166b.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768390740; x=1768995540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
        b=MVI6bK2+0y/iGml0eyQRqyFMvmjHqHTOTtU5ny4NL+hHFZnvnV64FCprkOvBJzjnfP
         2CfUMrpWjsbTrXwU0fuCT7sHbqGD7rBOV/cHi4oIQuZr7CKUCHlGVq9u2m02hqJ9AFkQ
         +pBPkbTt+pykaQXnkMeu+A8C4dt8IdOyYbBELMW6kt9DNwv+qCZk2b+ae3ExCo946GLP
         ojylqVqJ6mMt5hEvpi0CDdwHk8aZ9PzSlX4aJ8f1L7XqO/apjbIaWpLZUWKzmpv+rIqa
         WUhQEAaLrrkEBF8tQFsZ4Pc46+WmfJlAQf7ZvTw4HP6GtNUUooKgGvjCBRlHyWBme5po
         D42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390740; x=1768995540;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neLz2vil6IOQSSPgC08IfhmglUGv7J3nJx9uQlZaosM=;
        b=uNnOO9BWd+45eJyKF9rU98RXZGzl2mSHIrwkM/vIB8W2zVVb06fZITwF/49AOjSF2I
         iisT58EWUOzxnJhbmvxU8hcNQOZA2YqlkWq8/NWKY8gB4J234zYol9nScQzrrNOz2axB
         zHpAhSmfer9tVTetf0aecTzsmhJZqjPJk4C1jlsHgd5HiRy5teKClLt1XiWVcYYqsBnf
         pQM8itEe/8idjWE5wXkZecOpbUtlWQGmrw1w5YCq5aSd2glszk6wIh0TM+C4nyKZVglm
         i/vSPVJ9goqzLkln/tGKjP+8q4SbUrl1eGdD38XIeVcAg76eBZOvpK8b2nEoqb6AHALB
         buRA==
X-Forwarded-Encrypted: i=1; AJvYcCU7aGsBsxtWk9xUi2K9Z+NmffK9EJeXJrArAs5pnwUCTzQclvegPrRQticJih5QNxlF7bFJoOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwjmu5hXzrXaCyVDMiBruiw4EOpAMScR9jrq7Svwq4yGiCIGdw
	DbWuIy6p+MXAjGICtXn/gNN5rCyIxS3hkpCY9cCKBoKhVMPaTLYEWjD6dC7Baz5NIUXjDMxlLNK
	brrEqKS5B/bwyV/IYGUKiPYL8RYowE04MgW0DDs+8St/BblLcU26PYAAG7w==
X-Gm-Gg: AY/fxX6eKvK8vn+Vryw0E3pEV0pKlHjfUk9pmrqUZI96nJNDbKWtSajZw3y7YCADaDy
	Ephk8f+jrBLFkj9vlqdRCqcp6z/pzkcSrVmfez8UlnUzNZQtm4OxM4C8Ta9Qx8I/TGcbqMyms8b
	WXtnH/L947ibkTh6dgyg5Y9pr4W5ZhStioEOh2nciPhjD/5evSzKcQvh2W4P4DPN/sijB0wFkSW
	vh9rfarU3g3/oIgk32VE71tPfcgZkUMPJt/7/2x1kF6KN2/13iV+jH9krtqpv2MCD0dSqsI8cmu
	cXXVEEOxip0NqAse6UF31eJRxA5zYu7UUaIVHwzUitfRjDHEWmBPTav2kB4Tk7+AhqlrF7pxsSK
	oBQwy9lUM9erbG9N/xsCcWq1GVCFAWXJv4A==
X-Received: by 2002:a17:907:d16:b0:b86:f558:ecaa with SMTP id a640c23a62f3a-b87676caa70mr149165966b.27.1768390740400;
        Wed, 14 Jan 2026 03:39:00 -0800 (PST)
X-Received: by 2002:a17:907:d16:b0:b86:f558:ecaa with SMTP id a640c23a62f3a-b87676caa70mr149162866b.27.1768390739898;
        Wed, 14 Jan 2026 03:38:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871081b04bsm978445666b.53.2026.01.14.03.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:38:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6D7E8408B69; Wed, 14 Jan 2026 12:38:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org, Jesper Dangaard Brouer
 <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
In-Reply-To: <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk>
 <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 12:38:56 +0100
Message-ID: <87bjiw1l0v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com> writes:

> Sorry. I did not know it as this is my first time contribution, and
> did not check it.
>
> What about introducing a structured metadata extension area between
> xdp_frame and BPF metadata in packet headroom?
>
> Below is the example memory layout:
> Current (after redirect):
> [xdp_frame 32B][BPF metadata][unused headroom][data]=E2=86=92
>
> Proposed:
> [xdp_frame 32B][kernel_metadata 48B][BPF metadata][unused headroom][data]=
=E2=86=92
>
> But, the problem that comes to my mind while thinking about this
> solution is that
> additional 48 bytes of headroom beyond the 32-byte xdp_frame would be con=
sumed.
> WDYT?

Yeah, this has been discussed as well :)

See:
https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.html

Which has since evolved a bit to these series:

https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-=
a21e679b5afa@cloudflare.com

https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-v1=
-0-1047878ed1b0@cloudflare.com

(Also, please don't top-post on the mailing lists)

-Toke


