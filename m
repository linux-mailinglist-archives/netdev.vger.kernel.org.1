Return-Path: <netdev+bounces-56283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB980E652
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9EC282673
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F31A715;
	Tue, 12 Dec 2023 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju2UB2wZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90643D5B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702370198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3REzlhxyjwr+W04GrphHu6w+MUbdp4P7YLZ0oCePgOg=;
	b=Ju2UB2wZSBuzkepdPB/rT/OKQcuEib+sjQlv5qXky9ySxMQWvDlaOmAPLIEbNLWaRjwHP8
	t1Z7dZmBMIysWMb+z7gepFWuXQ+vm84ktrfY0OktXxCne55O3I5+ve4uJ+HARE9IV9oGZV
	PFB/NLt+rLep3sVJN34CyxzfrHj/09s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-KB6a66q0NQ-jBoKbjON5Fw-1; Tue, 12 Dec 2023 03:36:35 -0500
X-MC-Unique: KB6a66q0NQ-jBoKbjON5Fw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1e27c6de0eso114301666b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370193; x=1702974993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3REzlhxyjwr+W04GrphHu6w+MUbdp4P7YLZ0oCePgOg=;
        b=n7fz0IHrk2+R70fzF1VE/MCSViY6h8l1dAsVvSV4u7ddfOcz6Qx/dQ4bm/Ci1oTIHy
         0TSWreT3dhFdvWDhLhe5HnB2r9D9sui59AFQzsj/nk6PvIcZaMurWkNpzrXo5DRHj3HU
         VVY6r4a+mGivI/ixHPwij1p4axLXG+eOxwLjCBAkkDI6AUJQKhvbkVCbPYJvC8/GBPcH
         wu2b7bd5BJhKHtKPbvxIfhjXzcDwLmVDofeJrtCGHMYca87pO2vDyw8KnEks/oZAtrMa
         NOLoEnxufK2BmIaL2Z2+7EAH3PawHtv4/XHXMHTm6w1mW8wqsO+/QHsqBp5rjQETMGC8
         bfVQ==
X-Gm-Message-State: AOJu0Ywrk7EViQAWPaoGEncmLtINVX0Z6ZCO5yHHK7spbxati9BTDBpe
	GrV6Se+WJBE1RPHVqJYFnuzm+tAkI0D66fBCqu0m3RjiHftRerx5EEJDbimzLlcY7SakRakHeui
	AmhUdAYMcJY5IKZZM
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr5927147ejn.7.1702370193656;
        Tue, 12 Dec 2023 00:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE56gsZlumMYJ8ZvJvJsPBUsttFzbD+4XIetl4XyQ6yIHMOZjuwdspXl6TBvDz7dMtZ3/Ei1w==
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr5927130ejn.7.1702370193346;
        Tue, 12 Dec 2023 00:36:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm5838645ejd.28.2023.12.12.00.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:36:32 -0800 (PST)
Message-ID: <cb11852022d84740b417a93b9acada852d496d3e.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, toke@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com
Date: Tue, 12 Dec 2023 09:36:31 +0100
In-Reply-To: <20231211090053.21cb357d@kernel.org>
References: <cover.1701437961.git.lorenzo@kernel.org>
	 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
	 <20231201194829.428a96da@kernel.org> <ZW3zvEbI6o4ydM_N@lore-desk>
	 <20231204120153.0d51729a@kernel.org> <ZW-tX9EAnbw9a2lF@lore-desk>
	 <20231205155849.49af176c@kernel.org>
	 <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
	 <20231206080333.0aa23754@kernel.org> <ZXS-naeBjoVrGTY9@lore-desk>
	 <20231211090053.21cb357d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-11 at 09:00 -0800, Jakub Kicinski wrote:
> On Sat, 9 Dec 2023 20:23:09 +0100 Lorenzo Bianconi wrote:
> > Are we going to use these page_pools just for virtual devices (e.g. vet=
h) or
> > even for hw NICs? If we do not bound the page_pool to a netdevice I thi=
nk we
> > can't rely on it to DMA map/unmap the buffer, right?
>=20
> Right, I don't think it's particularly useful for HW NICs.
> Maybe for allocating skb heads? We could possibly kill
> struct page_frag_1k and use PP page / frag instead.
> But not sure how Eric would react :)

Side note here: we have a dedicated kmem_cache for typical skb head
allocation since commit bf9f1baa279f0758dc2297080360c5a616843927 -
where Eric mentioned we could possibly remove the page_frag_1k after
that (on my todo list since forever, sorry).=20

Cheers,

Paolo
>=20


