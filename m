Return-Path: <netdev+bounces-73374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85085C304
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D951F22E81
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B277652;
	Tue, 20 Feb 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+uJkQ4r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EC7763C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451602; cv=none; b=lG7sLsFSqY5EpEtGda08D7XJGSjXhOkr5ehnuoaN4b+n3gBv26s4etC6hDXLhkPqYhXb/9EKvnu6UaOwbuszPFQFBmlWwXci02gNMXAtImQoM/TchvPzbIdGWWuTPrFCxRpPxwOgbzBYUmVkpWX5w/Fzixbm0jUh3vuITNiu8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451602; c=relaxed/simple;
	bh=8lOpISbF7Wuoti9j/NdRPNCy+dmXYmVI0vsQgTL8ra8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KU4s2QhuX3I9QoXselmoL3E7JxzZZsg4rh8GHuPU+iPvvxqjqRKmDBFxVT/2ifIWEf1PCvNN96sguBhl60zKJzQsbMX6amlHVF2GyT22rLA5JO8nLlTQtpYHyclH4eefEPlWdH+m2rfOdglTD7JeYOuCI+Xkax7Nwro3GLvcMcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+uJkQ4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708451599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ajcT8P64+nblmC0BEp08NPePIGNo7YCHq2bpWkQVpKs=;
	b=E+uJkQ4rRMd+t/5b/3k+hZw3A/jhhEO6cAFVPgt89+0U8BZ89+Zt/XoUk1goiN61uFSpy0
	LdBQt75SAmDSu3oWkoD/Cpg5rwi9UVRjJt24BosTiJxhni4vuu7vAkyxYrobEhzowDCZep
	CM7skm8TAwlf5X+MFCssMcyh4wYpCqM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-obtLNM4lP967LQ7ULEyqPw-1; Tue, 20 Feb 2024 12:53:17 -0500
X-MC-Unique: obtLNM4lP967LQ7ULEyqPw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d1896e0d5so503727f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708451596; x=1709056396;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajcT8P64+nblmC0BEp08NPePIGNo7YCHq2bpWkQVpKs=;
        b=CxE/0rjWUqwVj5o5HN0cf8e+SPZhc74MaRSQFA4vUZgn1iKjuyr0P0ht1IwITVqtRb
         5KSQQetsRjv0huavvGTi4OGqkY3w2b6KvsMQfSYLakbczjUELTdxbHnnwYgJkyEpshdO
         DRAkUYWd2+O19rHpyieRwk7OGmpBIBRmYmj4D7xNPYfbOULaAInDL2fEiSxDKty+egkk
         wm3vJTQIlN61DghO5mci/9u/MiYAr8PUhIhDZ+LoqlA+rGWx+ELpjciH4ijoSy8aRO1D
         i4eq85wvPNx2zK8ia/NlHbwe855nQIj6Ik78gVX61/8psTjMRYUKeXgyzpgVe7RWxVD9
         tHuw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5S+jNZXKYUCPDskQGkiB87NmZhA+ORGyzj2omaJIDs7KSIohHmhszVPT+SYuZ1JBoO/07ZkxYVML5zZtg8RZymj5kwlK
X-Gm-Message-State: AOJu0YyMyOqMz5NtK6ZxoiyqC1wib/dmoXkREzR4yQgPYlRf1BbKLYWR
	jzMHerqR/yBVzXNc1TbrX3umcqCJhuf9xPAglkx6fLWy8o2fxarNdt8Lv/YZx7cCgmLp0WaAB8/
	/mLPRkQ36QGMZTrWO3y8d5eno3wpCr3RKy9N22jdInXhtipemcXhWCw==
X-Received: by 2002:a05:600c:1587:b0:412:5670:ef62 with SMTP id r7-20020a05600c158700b004125670ef62mr7259688wmf.1.1708451596711;
        Tue, 20 Feb 2024 09:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZqZTdW6K3YTGZSj4dUys5R83Z+IWN16lvC08N+cJzv7pNNlTgJEoqD/bITUPGB7SkgY0QKQ==
X-Received: by 2002:a05:600c:1587:b0:412:5670:ef62 with SMTP id r7-20020a05600c158700b004125670ef62mr7259676wmf.1.1708451596428;
        Tue, 20 Feb 2024 09:53:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b004124219a8c9sm15138264wmq.32.2024.02.20.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:53:15 -0800 (PST)
Message-ID: <778159a764a93074ee5357ea37216183a185a390.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 03/14] af_unix: Link struct unix_edge when
 queuing skb.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Tue, 20 Feb 2024 18:53:14 +0100
In-Reply-To: <20240220174437.47356-1-kuniyu@amazon.com>
References: <6aa8669ebc0b5a9b17f0a3256820560f8ba8e73a.camel@redhat.com>
	 <20240220174437.47356-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 09:44 -0800, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Tue, 20 Feb 2024 13:06:18 +0100
> > Here  'edge->predecessor->entry' and 'edge->entry' refer to different
> > object types right ? edge vs vertices. Perhaps using different field
> > names could clarify the code a bit?=20
>=20
> Regarding the name of edge->entry, I agree a diffrent name would be
> easy to understand.  I'll rename it to edge->vertex_entry unless there
> is a better name :)

[side note: thanks for copying with my reply mistake!]=20

vertex_entry WFM! but please note that I'm quite bad ad peeking
variables names ;)

Cheers,

Paolo


