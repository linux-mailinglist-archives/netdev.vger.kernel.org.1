Return-Path: <netdev+bounces-122368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E019A960D95
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947091F24B61
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE591C4EE2;
	Tue, 27 Aug 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTLFg2eD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DA1C4EC2
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768952; cv=none; b=ts9+SPhdgiXUOSM3zReDfH1KCSNiIBFp2qV1WL2nheJOIxlVrOq02vhXCZ7jalqCIp3999yFt5aNb+4WVPFnSx9DVC3dTsTrI6lqbkP4ALV6Ywfr6MnaQOPK12a1dxT6dPpjwvqPpV2tv68jwr3Za67emCgTZXJ8xmeabBVTGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768952; c=relaxed/simple;
	bh=XEDPr4WOAkirqSp12c15L6XcOtIYReNICHT5/RJr5y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF1YjJLLda4vSUwwiloot2RXB3DX7KPD52VrjZpFI3lMdAFMn/xApUvedSVPGGT0K15Lbs4ZveVZCA9GKcSCDIp8X1o3gQgoHzj4SRWXbipQfQqVVHREf6hRb2TK5e45Rn4zWDVg1QFp8pgUVMVz9C5L+b7XH3Ct52fxmXmaVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTLFg2eD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724768948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgVRezl+3Y13Dxo4oGt/1Z0OKjfZrBalmuo0EvD0nD4=;
	b=DTLFg2eDzLqRRpXvc+AjP55nE5/cVK5HKb5lfBtFKaVo71K8BB8WJnQrxs9aPKcsYaKdMW
	3FpfV45R9Jvlndrjsc+BRSJvJVLuPXaSnA0u1hbqdQQ+T9HIGxLcCtOne0igV2+r1FTucm
	HeZ0OGUpsmnm6CUwzVT4UDEwwP1zQCg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328--vJXI-neMBiQpHrna_4aYQ-1; Tue, 27 Aug 2024 10:29:07 -0400
X-MC-Unique: -vJXI-neMBiQpHrna_4aYQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-429e937ed39so52457435e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768946; x=1725373746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgVRezl+3Y13Dxo4oGt/1Z0OKjfZrBalmuo0EvD0nD4=;
        b=TLMceL7TlzUT10nSGkkhhLNOF1/sgRIHeJLeohtvT/G4KiQ7lprTLhl9f/P0IUd8DO
         f6nLV94rkTCff2yvmwAEjEPjcdtTt45JqybSOEj917ULkHpEGS0bo3DPEJNOD8LQzzlt
         dN9Rmgjd5lvIWd9OXjZn0Asjy8D4o2ICMzXUf0WmXbVvb+QzkrI1IAUTxksWBcuC1CNf
         Rk0fH2JYA45DWHB5CAP+eTRSm6IgZoFPkR5T7uSTIWuehHAdPuaEHXCr3OFzpxaVQBOh
         8hDUfpKc76PZiOqLRMMTgXK4LunnveHo7FD7hXTqxT71HCs/X9MhKxwK1LvhJ4EnFmf2
         BFzw==
X-Gm-Message-State: AOJu0YwKyFRPd7Hp695fkq9SefeArFe2TEQKvR0KVmPIyXzywJRc8Ab8
	JRi+vkfmnSpq8XnvcJVRv98fN+199nohxddvF3Pu0Mffr63GH9l7rCCz/hi8A3puwFnVj6hpZiA
	LtJ5dHJS63hW/9KuGl8ThVhUvL/UhpWtmw+hD5VhhsQY5RpGMexiKwg==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr19739995e9.35.1724768946185;
        Tue, 27 Aug 2024 07:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFJXBA+TgtLOFs5onkG6FkZIYtlBLDuS8EzKnHJ9mOfyqPrQoz0idm9IxP/FCAp77EJ8Tiww==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr19739695e9.35.1724768945275;
        Tue, 27 Aug 2024 07:29:05 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a68dsm190967095e9.33.2024.08.27.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:29:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:29:02 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] ipv4: Unmask upper DSCP bits in
 ip_sock_rt_tos()
Message-ID: <Zs3irqw8lmiPb0PJ@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-5-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:05PM +0300, Ido Schimmel wrote:
> The function is used to read the DS field that was stored in IPv4
> sockets via the IP_TOS socket option so that it could be used to
> initialize the flowi4_tos field before resolving an output route.
> 
> Unmask the upper DSCP bits so that in the future the output route lookup
> could be performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


