Return-Path: <netdev+bounces-80546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3100187FBCC
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4D2282561
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4B7E101;
	Tue, 19 Mar 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5VJ/p6E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD47E0F1
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844070; cv=none; b=uUJn4kMJqSkFDIB/nxbd3JOHQcZ1uiWziJS51cMtrwEgkpZ++R6V6hdLRI3CLsDw7Q6vOF4uLzdziosy/J6nT8HwQTkDelrnlReM6jORGSinSrfDflW8APJ9SIn59TuhW3SU/lGRH7sLMFXdGfii5Ll/L61zeLpf7vQo7L7vrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844070; c=relaxed/simple;
	bh=UqMkOZTravtCxbKGrvA7NFEBYdOL3KsutyvLNbCpaeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chM2ZzXu7V+xyzxOhQpHQgNAskM0DmeiXydd58jXO+GF2dGTH020m2s13ZtUl+4zu4bWKVCmqL0BZUmK8RB3kD+1hF2/YnyfRtJ8rdj8Pet3LHrKCQDWI6jEOTyOkRjcOAbNbfyFNKOuch04cNSGRoFLtchBuchIvKfE8VVDapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5VJ/p6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710844068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UqMkOZTravtCxbKGrvA7NFEBYdOL3KsutyvLNbCpaeE=;
	b=O5VJ/p6EBYHZxQ7M481ta3H+3fzeOOSRWpWrnpdekIcHlMYg7U0uHAaPnyhwhG7Lk0v/TT
	waZ6Dhjtqv7iH1GHvaVu0cLmrq5ryQzmDoeBsAf/Ra3WdrkOVRsKpZBYCutEilyl2goRe0
	hGoX5Y8eshvoG4dtVBlUfWfGTbkKiYc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-oeZyM022PQ6KCCUkfn0Zig-1; Tue, 19 Mar 2024 06:27:46 -0400
X-MC-Unique: oeZyM022PQ6KCCUkfn0Zig-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412e83f6349so5586595e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 03:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710844065; x=1711448865;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqMkOZTravtCxbKGrvA7NFEBYdOL3KsutyvLNbCpaeE=;
        b=btmtPlH8XtvczWujvuOb86MEXplY+8p530dPk+DaDyb95eAbE9ESt1XsjADebByS3f
         3mPpTat/aQ7wGpsxXogm3qMu2SZVYxvgZDjY068z9gdA17Awz9yGtmNSdli00zbCWyKF
         n7ovpAoL5iS2xDaa8bOWdm34o70vm9HcifX6PRnId2DkP4vEnovkFlOT0UVEzAvDd6xx
         ORFTWoOAig1vbhLWMG7wvMocLz86sW7qdBpFfHtSXHSZeSBz2AcKkRPBP5HrFLAzzrFq
         h/cL2/PcXu281JfCaaV3GMIToAZh7lzjkSWda8H029hax9HxWZ73nMOwSXRVGhnS0Gd3
         DbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXCMJ2yGiy+CfDn8npO5zQLN1eKzvuXM/Dtk1n8fQGAkvF2YpvcAwbFvZPerC2lKkXPPJuGfj7GY+IwXdL91s2sJppGRjd2
X-Gm-Message-State: AOJu0YwHXugDxw3//sDMheqmXgDxpOAzGUAzNsWXhk8I+VksLKpwX+uU
	WalHtC1l/U4+YA8Sa7AnQbETkIDT54F461QIKLiUpzonzM2AJQmFP/cqHT+Bf52qhsMllv+CX+F
	gq0xMRJrkoqx4ecRlW8w6PSUCKpbZUSenEKWaq6KRQjCv1kGnraYknA==
X-Received: by 2002:a05:600c:1d13:b0:413:f58f:2f68 with SMTP id l19-20020a05600c1d1300b00413f58f2f68mr1507027wms.1.1710844065285;
        Tue, 19 Mar 2024 03:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBVefldqHskvZUOUS8H1TB+AoM0+76FsbAO7j6op2q43g/zP53Brf5utVnxbQVtWXz3U7hwA==
X-Received: by 2002:a05:600c:1d13:b0:413:f58f:2f68 with SMTP id l19-20020a05600c1d1300b00413f58f2f68mr1507017wms.1.1710844064953;
        Tue, 19 Mar 2024 03:27:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-202.dyn.eolo.it. [146.241.224.202])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041408af4b34sm10293751wmo.10.2024.03.19.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:27:44 -0700 (PDT)
Message-ID: <235d1abeb92efc486cbecc7ef3b07a53671b506b.camel@redhat.com>
Subject: Re: [PATCH xfrm] xfrm: Allow UDP encapsulation only in offload modes
From: Paolo Abeni <pabeni@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Leon Romanovsky
	 <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Date: Tue, 19 Mar 2024 11:27:43 +0100
In-Reply-To: <Zfk6AcOGMDxOJCd+@gauss3.secunet.de>
References: 
	<3d3a34ffce4f66b8242791d1e6b3091aec8a2c25.1710244420.git.leonro@nvidia.com>
	 <Zfk6AcOGMDxOJCd+@gauss3.secunet.de>
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

On Tue, 2024-03-19 at 08:08 +0100, Steffen Klassert wrote:
> On Tue, Mar 12, 2024 at 01:55:22PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >=20
> > The missing check of x->encap caused to the situation where GSO packets
> > were created with UDP encapsulation.
> >=20
> > As a solution return the encap check for non-offloaded SA.
> >=20
> > Fixes: 9f2b55961a80 ("xfrm: Pass UDP encapsulation in TX packet offload=
")
> > Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dc=
b6f67.camel@redhat.com
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>=20
> Applied, thanks Leon!

Steffen, as the issue addressed here is causing self-test failures in
our CI, could you please send the PR including this change somewhat
soonish?=20

Many thanks,

Paolo


