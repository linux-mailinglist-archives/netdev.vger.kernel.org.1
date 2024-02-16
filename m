Return-Path: <netdev+bounces-72290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44485776F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5FFB23C3B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FE18E00;
	Fri, 16 Feb 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyDXuvc7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8218EB3
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071087; cv=none; b=bR7V2cGXML6hRhjJYLHwACQYygCFm5Bog4qwYMs35ilTuz6VKtmHsuu0a5jxfXfdogg6s1lB4AJUHXCrsr4hiHdhtCKzf9eSG/xU2jojQfBA3ABeLRBLV1AQ6Awess4nLYGZtO41EAGtTgWRsu0F7bnoYE2sj5heoBBxDx1/Scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071087; c=relaxed/simple;
	bh=vcmHS0zCKJ7YyW3XJSwu+65tSBOl8fFhiylq994dAdE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVPAcxp2FDXgqOrtcOxm2wB+1kWhGzvFjCngCYAxfdf0tPxxsU9I5QR7DtB/RpV+IHlbd5N1ks5ZHmAxZeab6ErJfYLPs2OnAt0vBjzWgTZRM7Z9atjADUnIDq+bz5aIuspbZ6I9VphuT53Z0zy1E/MPRVSH1+viH04nJ3Hybw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyDXuvc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708071084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8kjyktnfitwGpWxhTgapm/fs17YjxkqExi2ahxQxjRc=;
	b=QyDXuvc7+p4mscXs7b5wjV9KLm8L8Bk1oyDS1lrruzxBHen/sgbTytEs+j9wX8+qvg+xJ8
	hLxt761eNRUPpPgJIR4T4vJgCER5tBQvID+5znCR9Q4+QGmeyzNCDBXqzSv/wpYxgf7JXi
	UVS8VtC69cZrgCYv3ApUhU9dlO4v2O0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-de7GkWRLNNeDu4G98wj9Ug-1; Fri, 16 Feb 2024 03:11:22 -0500
X-MC-Unique: de7GkWRLNNeDu4G98wj9Ug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33cd063f475so137020f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 00:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071081; x=1708675881;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kjyktnfitwGpWxhTgapm/fs17YjxkqExi2ahxQxjRc=;
        b=XrmyqDmdFAXelpDm4XVLbuJJNhothLntlA89FiPd8DTE0TV0oa1HGAX4CM+hU8Vo0p
         ziAJPmE//AYM/vFOCQsY2V78rhOM7Nn2c63mTY9qxE1WmWNfKpo2AGs3AssaGjJ24xH0
         r/XMnUWsI4ewL/xAeIhixjdl+gGyI92VHlaibFLhpa8iO3nuz6bobWrP+R1Xhan6vuDo
         degRwjIsYO5LAwUAaW62Xxctqp4dyYRyFPhSRqE3OuwZ4lV2PzzqYUjrDw6GQZ2q8nbU
         cbXYsy0gG7XVdeJb2rrW0htTg5FMUWKggKVRjtsowlqvLLEjmpuA8A0Hf+30/WRf4AN0
         YdMA==
X-Forwarded-Encrypted: i=1; AJvYcCUWvw/n3sChVy0waZfa+cDNBJto6UDcPiFCh6VzGveTb/WVtxH8KQXLB9Mbj8ZvAVjTWDqk2TzfRn740GxXOuBN9i7NlVi1
X-Gm-Message-State: AOJu0YzC06L7SkTumluLZ6eAWHgcDY6rLiONyxFPUxGqjHmnazqENlaO
	Ob38U+eqp9L/D9WaT7ica3SSBUoW2RKc3Eu748q+sFBvRp7YEYsd0GIW0uUVtl0GEJJdBGcj0rQ
	mEgyrA9q8xKxRf5Kwtzc78wINbecioCz7Jii6E0n4tL3jwaz9EAtsAQ==
X-Received: by 2002:a05:600c:2258:b0:412:456e:636e with SMTP id a24-20020a05600c225800b00412456e636emr637253wmm.3.1708071080956;
        Fri, 16 Feb 2024 00:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmfzS/+SGxn2m7xcH2ILDdIP0X30jSSlxPD3KIxS/N5MvsSa8pYYB1uwG6HhEz3S4HQYGFTQ==
X-Received: by 2002:a05:600c:2258:b0:412:456e:636e with SMTP id a24-20020a05600c225800b00412456e636emr637246wmm.3.1708071080632;
        Fri, 16 Feb 2024 00:11:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c1d0800b00410c04e5455sm1556700wms.20.2024.02.16.00.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:11:20 -0800 (PST)
Message-ID: <396f9c38e2e2a14120e629cbc13353ec0aa15a62.camel@redhat.com>
Subject: Re: SO_RESERVE_MEM doesn't quite work, at least on UDP
From: Paolo Abeni <pabeni@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>, Wei Wang <weiwan@google.com>, 
 Network Development <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Date: Fri, 16 Feb 2024 09:11:19 +0100
In-Reply-To: <CALCETrWUtYmSWw9-K1To8UDHe5THqEiwVyeSRNFQBaGuHs4cgg@mail.gmail.com>
References: 
	<CALCETrWUtYmSWw9-K1To8UDHe5THqEiwVyeSRNFQBaGuHs4cgg@mail.gmail.com>
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

On Thu, 2024-02-15 at 13:17 -0800, Andy Lutomirski wrote:
> With SO_RESERVE_MEM, I can reserve memory, and it gets credited to
> sk_forward_alloc.  But, as far as I can tell, nothing keeps it from
> getting "reclaimed" (i.e. un-credited from sk_forward_alloc and
> uncharged).  So, for UDP at least, it basically doesn't work.

SO_RESERVE_MEM is basically not implemented (yet) for UDP. Patches are
welcome - even if I would be curious about the use-case.

Thanks,

Paolo


