Return-Path: <netdev+bounces-48296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7D7EDF9B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B042280EF7
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483D2E3F8;
	Thu, 16 Nov 2023 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lokva/9Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545FC2
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700133823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brvh1BhIJ8KXHLR0fDM4ZkBOA834wM7cVUNTZ+vSCKA=;
	b=Lokva/9ZH4ZfF1ZzCc6TFdMJM9meCRIPvBu9RvIBxS6H3KFyGIEgaGOmRJFfeMDSDp6s2Y
	Bnsv02MkDLYV2o956NaHXQWstrXGhCaiGK84OkRaQD6TeVk7gMpm8NFX3sVR73DVjtTTnO
	gCdSJbjXZzUwe0jZi2kdwUZQAwrddCU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-EUksorlBN523OhuBhVf80g-1; Thu, 16 Nov 2023 06:23:42 -0500
X-MC-Unique: EUksorlBN523OhuBhVf80g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d7b75c854so1802166d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133822; x=1700738622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Brvh1BhIJ8KXHLR0fDM4ZkBOA834wM7cVUNTZ+vSCKA=;
        b=vN/Ava2hQw5pJPEx3F5O3iQ+NegrvAm/DPDGNZ8Q7D0vfXpc3IYBW5ARcHmuhdZ5vZ
         9Nww3MQQPSmyNycs495nkCFXLvTDlrGPHeeEYoj/Fss3xStjGvGL0W7lbIjXdXu8JQN8
         vLrQMiL3BbBdHeyZyU0sxZpLIhgQwCkejVKyr4vGbvOliy2lAjkrp3ZAeWyIkeQmjo/j
         /C3heOmTG4k2L39mEHvSekOPc0lT5Fu3aChp+P0xTp1ebkiDjzeWDAwJ4TQxOnWxjiLJ
         kH4yEj/yF/KTPOLfPda8VaYf05PfLrYiBpnQ82dpSFtJwPU3yGs+Pbau65yAOZfVS/mF
         doZg==
X-Gm-Message-State: AOJu0Yw+BdRZqe34t6JnFESq1+17hBWIKJv6mrKC59fZmZ6Vkio99evE
	iotuqsHAJLVPxsitPKBRlIUtOyCGr71//cMhABOayifscGnh2lmyNjUF9Di1yJBjcbnNhMDyFb4
	0KeKrHHYthyqgIPOV7mbdXJuC
X-Received: by 2002:a05:6214:4943:b0:66d:169a:a661 with SMTP id pe3-20020a056214494300b0066d169aa661mr8516429qvb.4.1700133821989;
        Thu, 16 Nov 2023 03:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoAyGrYwumHGr29A3fDD3Q+4eI4+1J9vhfHO2t8qPo9z83ClD9DEtrZfiEqtQNu893kZgNSg==
X-Received: by 2002:a05:6214:4943:b0:66d:169a:a661 with SMTP id pe3-20020a056214494300b0066d169aa661mr8516415qvb.4.1700133821618;
        Thu, 16 Nov 2023 03:23:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-98-67.dyn.eolo.it. [146.241.98.67])
        by smtp.gmail.com with ESMTPSA id l16-20020ad44d10000000b00656e2464719sm1305025qvl.92.2023.11.16.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:23:41 -0800 (PST)
Message-ID: <ef465a6bde6c2845e7e2537c12efbab9a6fb5157.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: reduce dma ring display
 code duplication
From: Paolo Abeni <pabeni@redhat.com>
To: Baruch Siach <baruch@tkos.co.il>, Alexandre Torgue
	 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org
Date: Thu, 16 Nov 2023 12:23:38 +0100
In-Reply-To: <27ad91b102bf9555e61bb1013672c2bc558e97b9.1699945390.git.baruch@tkos.co.il>
References: 
	<8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
	 <27ad91b102bf9555e61bb1013672c2bc558e97b9.1699945390.git.baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-14 at 09:03 +0200, Baruch Siach wrote:
> The code to show extended descriptor is identical to normal one.
> Consolidate the code to remove duplication.
>=20
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Fix extended descriptor case, and properly test both cases
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 39336fe5e89d..cf818a2bc9d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6182,26 +6182,19 @@ static void sysfs_display_ring(void *head, int si=
ze, int extend_desc,
>  	int i;
>  	struct dma_extended_desc *ep =3D (struct dma_extended_desc *)head;
>  	struct dma_desc *p =3D (struct dma_desc *)head;
> +	unsigned long desc_size =3D extend_desc ? sizeof(*ep) : sizeof(*p);
>  	dma_addr_t dma_addr;

Since this is a cleanup refactor, please reorganize the variables
declarations to respect the reverse xmas tree order.

WRT the ternary operator at initialization time, I also feel it should
be better move it out of the declaration.

Cheers,

Paolo


