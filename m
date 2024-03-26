Return-Path: <netdev+bounces-82223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97488CBFD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B7E1F83703
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162108662C;
	Tue, 26 Mar 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISB0jyMT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4C53387
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477758; cv=none; b=tMcsHPSvFl11dwlU+PkXZzSPujbOlvXrBoFb/1RHJAqXlEbORSccRnwZHMmuAwI3wDahMIQdyrU8BNhyHEQ7EV5nLwplP7dMGIQPETXuNemuEozJdvJnQrB44dExpcAK7E/H7joEDy3QJlYeS7B/CatXn0lEgir2xmKdgtJToi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477758; c=relaxed/simple;
	bh=lfuOzSJMbB9qmGdebpJmJCCw2xjCLpe1okomkp6s8+s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxzlbcvToiqPJf4Vs5rYwf8+agG4GJNoscoivk++DwW4gtcdKQtFc8ckoS9zuVjNPR7JPJfG1fHnHL39TLUaPZvqxH0YsOByW0Prclaa372trIw1saklEnTyCGU1xI4l9ch911Rt+8zKTpBcPOw4unIxlBatvh/T41FZmbmCJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISB0jyMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711477755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aWFgiiWydJuIrRjsef8kQtkxE3sDrXNTbprmM0pc3QE=;
	b=ISB0jyMT7jqDNHK3wrF2R7rjJM/khhag29g7tMB6gU+Bqmr+2ef+bltWarj2QDSPhOSD8m
	Cw3JOXvEToKQcKvhR8HI1hYLp29/xp2huuxd5+HqinT00h7b7I6AiWM8tpOltv2Jf2+kdi
	wjrcIyAue8NbOeQaPO70Jcjl++J8xWM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-pbDeKdO1MDKcCElOZS-blA-1; Tue, 26 Mar 2024 14:29:13 -0400
X-MC-Unique: pbDeKdO1MDKcCElOZS-blA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso1129278f8f.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711477752; x=1712082552;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWFgiiWydJuIrRjsef8kQtkxE3sDrXNTbprmM0pc3QE=;
        b=M55ZB9QzcWQfRrMA6INnwu0kTO5J3tGxbywTf1OEwDg1Cqeyw7a7nBflQrTXdRShOi
         r23I4q7/C6pxc34wHvTxQFxtjDWsbkH6VgVLHZ1JEKbawbc1NoCh1jPz0lIX4cDV1iem
         RLms/lWjsqzohWGXyLLgNig3qrrimue5nMaKjqe/S9i/deljKB/L4pbbHcg59clHKZ68
         +vmTFZdJ7A3NdzfBPhk+zifTF7WmoDxc2Qo/ZbTzguTo2iyqSVdg96bOXqXpFU/M/VgN
         9FBHR3q+f5ALQe4PrG1MIcoxFWvcKcGFixXaqQUjV074aiCF9dZsP1Tw3aL6flkSu/nu
         dfsw==
X-Forwarded-Encrypted: i=1; AJvYcCWvim64JazBVEcbJ5fc1l3vVavn7SuVBSeFnbrNrVbfka96tIlr+vLDE5UFIWq+Jh55yr057I2duwX0FhytvY5G+cC+FwvG
X-Gm-Message-State: AOJu0Yzt1pvXrjTbKKmrsxJ8hU2Jq+ugQnH7dGDu1+qCAidzM0PZ8EO5
	3K0jx8md5Ml2nsgt9fFBpflxuUHBd28VH2zu6lVpYD2+o5hB2h8px0+fmLrG5uT5BuOUEHdXAmx
	uLZ+t0u8+wicnyf8vIF/ClnToCW7ZwEz3zcU6fUkinMSF7XRG440yw9JncrzA2g==
X-Received: by 2002:adf:a4d1:0:b0:33d:9e15:12bf with SMTP id h17-20020adfa4d1000000b0033d9e1512bfmr7532508wrb.3.1711477752071;
        Tue, 26 Mar 2024 11:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI4yFMUfLprIEZjUyrpFu496BsxlGIaBa9N7TMoHELMBTmiDo8FUR8QHJimD/76oC/qKpXaQ==
X-Received: by 2002:adf:a4d1:0:b0:33d:9e15:12bf with SMTP id h17-20020adfa4d1000000b0033d9e1512bfmr7532497wrb.3.1711477751685;
        Tue, 26 Mar 2024 11:29:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b00341bdd87fcasm10622402wrq.103.2024.03.26.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:29:11 -0700 (PDT)
Message-ID: <9f3509a7134f7e2dfd633ea62d24815e12b1f482.camel@redhat.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, Eric Dumazet
	 <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Tue, 26 Mar 2024 19:29:09 +0100
In-Reply-To: <57bf675d-c2f0-4022-845c-166891e336be@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
	 <20240325182543.87683-5-richardbgobert@gmail.com>
	 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
	 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
	 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
	 <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
	 <d60c6185b8394da02479100981fa3f1306d9c81f.camel@redhat.com>
	 <57bf675d-c2f0-4022-845c-166891e336be@gmail.com>
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

On Tue, 2024-03-26 at 18:25 +0100, Richard Gobert wrote:
> Paolo Abeni wrote:
> > Hi,
> >=20
> > On Tue, 2024-03-26 at 16:02 +0100, Richard Gobert wrote:
> > > This patch is meaningful by itself - removing checks against non-rele=
vant
> > > packets and making the flush/flush_id checks in a single place.
> >=20
> > I'm personally not sure this patch is a win. The code churn is
> > significant. I understand this is for performance's sake, but I don't
> > see the benefit???=20
> >=20
>=20
> Could you clarify what do you mean by code churn?

The diffstat of this patch is not negligible and touches very sensitive
areas.

> > he changelog shows that perf reports slightly lower figures for
> > inet_gro_receive(). That is expected, as this patch move code out of
> > such functio. What about inet_gro_flush()/tcp_gro_receive() where such
> > code is moved?
> >=20
>=20
> Please consider the following 2 common scenarios:
>=20
> 1) Multiple packets in the GRO bucket - the common case with multiple
>    packets in the bucket (i.e. running super_netperf TCP_STREAM) - each l=
ayer
>    executes a for loop - going over each packet in the bucket. Specifical=
ly,
>    L3 gro_receive loops over the bucket making flush,flush_id,is_atomic
>    checks.=C2=A0

Only for packets with the same rx hash.=20

> For most packets in the bucket, these checks are not
>    relevant. (possibly also dirtying cache lines with non-relevant p
>    packets). Removing code in the for loop for this case is significant.
>=20
> 2) UDP/TCP streams which do not coalesce in GRO. This is the common case
>    for regular UDP connections (i.e. running netperf UDP_STREAM). In this
>    case, GRO is just overhead. Removing any code from these layers
>    is good (shown in the first measurement of the commit message).

If UDP GRO is not enabled, there are no UDP packet staging in the UDP
gro engine, the bucket list is empty.

> > Additionally the reported deltas is within noise level according to my
> > personal experience with similar tests.
> >=20
>=20
> I've tested the difference between net-next and this patch repetitively,
> which showed stable results each time. Is there any specific test you
> think would be helpful to show the result?

Anything that show measurable gain.=C2=A0

Reporting the CPU utilization in the inet_gro_receive() function alone
is not enough, as part of the load has been moved into
gro_network_flush()/tcp_gro_receive().

Cheers,

Paolo


