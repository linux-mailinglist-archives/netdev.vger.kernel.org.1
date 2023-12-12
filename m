Return-Path: <netdev+bounces-56354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B869D80E95C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588D6B20AD3
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78005C09C;
	Tue, 12 Dec 2023 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vn0wV1v9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B6A0
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702377712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DWK45GoJ3o3neJkE8k8psUZB49AFs+VfTYfbUwjfVs=;
	b=Vn0wV1v9nBIb5MlkZBLZLwnX13LCqR1OJvkvRfP/7t6MJf/PO/5OjMVDkLnhfrNPrrowAn
	7gtZMBr+nKHr47AFCZLvJX2DZL3a7QotSQeUobTE2fvD4EY05rrCADaDZfeACBEJ1yEg+C
	4E/DoVltt2Sn+5Ef+1QeEJFBa9Osg5s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-HH-S5yRiM6W79WOi9L6Xyg-1; Tue, 12 Dec 2023 05:41:50 -0500
X-MC-Unique: HH-S5yRiM6W79WOi9L6Xyg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso117186066b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377709; x=1702982509;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DWK45GoJ3o3neJkE8k8psUZB49AFs+VfTYfbUwjfVs=;
        b=HrPCSrjYvw6m05AumaHFnDKKObbyLvGkxIQOxrVRBUHBcO2F188D3RKgcxKMfJ/kbF
         NmY9+PiTjQHackyuwnWWcMvQyCR7exqBYGshwe9asxdI3BNxomzpcaVoDXoQnpeiQRHw
         A5aFDKjODTmWPYhRfD3VC97kZZNSitcZyVC6Y56pXB9abIoKQgD4SG/Xagj49jfGGNth
         5WWm44xFOzgs2gXLDx3VIJc74UQkFJBtLdNY0wZxxfGYERWytPyWZJ60pJWcfqnVUf61
         ZFp3HRGh3lCegkw3m/JqQJK+Jb9hYTytqW7dmYT56gq2g+HWbKXhT8LuAzamXP+siveU
         sfpA==
X-Gm-Message-State: AOJu0YzGiEp8R9R94a7MlYO4oo0Q9MwzLK1f3srNVn6oiT10J41kgSTd
	ySccRegIEDReyDnYpnyssVEEhJF/tunsu7rWgSSujIefqoxMWGHihBLGTM1ZIM91Q/FYdLIs3Ck
	xJr1ky3Gu4g9KKzbA
X-Received: by 2002:a17:907:1602:b0:a1e:75f2:a2f3 with SMTP id cw2-20020a170907160200b00a1e75f2a2f3mr6151900ejd.4.1702377709687;
        Tue, 12 Dec 2023 02:41:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgNR+hQdnHZxLpaK5TA8+wtUH+R1OrJ/MQQBJEqu7buQzqj1fwiifVchQBKdrFzgWF5rcf3g==
X-Received: by 2002:a17:907:1602:b0:a1e:75f2:a2f3 with SMTP id cw2-20020a170907160200b00a1e75f2a2f3mr6151886ejd.4.1702377709398;
        Tue, 12 Dec 2023 02:41:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id st6-20020a170907c08600b00a1ddf143020sm6059419ejc.54.2023.12.12.02.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:41:49 -0800 (PST)
Message-ID: <d003752ef45da9401ba6e044aa0e180f3dc46228.camel@redhat.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when
 TCP_NODELAY flag is set
From: Paolo Abeni <pabeni@redhat.com>
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: alisaidi@amazon.com, benh@amazon.com, blakgeof@amazon.com, 
 davem@davemloft.net, dipietro.salvatore@gmail.com, dipiets@amazon.com, 
 dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com
Date: Tue, 12 Dec 2023 11:41:47 +0100
In-Reply-To: <20231211155808.14804-1-abuehaze@amazon.com>
References: 
	<CANn89i+BNkkg1nauBiKH-CfjFHOaR_56Fq6d1PiQ1TSXdFUCAw@mail.gmail.com>
	 <20231211155808.14804-1-abuehaze@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-11 at 15:58 +0000, Hazem Mohamed Abuelfotoh wrote:
> It will be good to submit another version changing the documentation
> https://docs.kernel.org/networking/timestamping.html editing "It can
> prevent the situation by always flushing the TCP stack in between
> requests, for instance by enabling TCP_NODELAY and disabling TCP_CORK
> and autocork." to "It can prevent the situation by always flushing
> the TCP stack in between requests, for instance by enabling
> TCP_NODELAY and disabling TCP_CORK."

The documentation update could be a follow-up.

Please fix your email client, the message you sent was not properly
trimmed.

Cheers,

Paolo


