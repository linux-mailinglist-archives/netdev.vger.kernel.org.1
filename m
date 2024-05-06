Return-Path: <netdev+bounces-93748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D88BD0B5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8334D28D305
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4207615533A;
	Mon,  6 May 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNa4ulzo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA2155328
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006990; cv=none; b=go65FcjJmyV2SFzV9NtMA8aVdKjmj1I2icROJ1YkthWM9lXMz+9w0gawVbz/xWDO5sFZUd2+WxyjhMF9HymsgElEOgd4L77kVhNySagcIJfrOUxDpwpWlFbCLJRgNxY1mHL9FFWsCwvo9VOXZ+C0l9YGPcDkIrrITwUxk8GsasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006990; c=relaxed/simple;
	bh=wFEAgz9DoEMtNEfhF2whHUgl+SQ1hbYNvw0LVwBJMHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy+Zl+7GiB+5s/Jsx9V98ORoB535uG6XBM860WW69+ohbN+1KWZu17IZtjgTTiA4K9dgBbj4P+Aei4jXNCxyDw1oiswDgZnoPdHkneKib/LdOE+izimieqYC3S0783G3Yw9rhS6zMKYnUdY32Z72sC6mPG8clrGeMzDBifr4TTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNa4ulzo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715006986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouwyK0typuZ1ow/pNC/Gp96v2+HGSiLFxZMM2D2vdpo=;
	b=CNa4ulzob4zGYAef+WUviR82ooP2GI3SAAlGLeumVxP8iVsgZo0PnH6qclcQytIG3d2iVL
	Kk0JBwo7OuBOCxO+8x7dY7WN9FO8Q5ltmz6p0VazMMo9YkbOLp+tUQU3vnFYocoS5SxxZR
	FBkaZ8j1P8y+4EU0/iLRvzwE1Cjhx98=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-kXZFN4ONP4q1a8bX-L5DIQ-1; Mon, 06 May 2024 10:49:45 -0400
X-MC-Unique: kXZFN4ONP4q1a8bX-L5DIQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41e9feb655eso4831525e9.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006984; x=1715611784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouwyK0typuZ1ow/pNC/Gp96v2+HGSiLFxZMM2D2vdpo=;
        b=qrQmbYYx3hnRwL0OHSdeVx1B3j3QzDsuvW3SH2KfwBRRy5wVmLRDLwDSA/uvnUQMkW
         K2njpw8Ssbg3k7KRiGE93+9z1GGxkGaZYMRVDaACarGQV57Ii5YEyHPhg1M4yk+jQOW4
         i9pFyRPsk6p0WPCTtFaALN7Opg6I0lg5f2KxpLvSIY1/c4P0OctaO35j9IYoqJwQHztT
         yJFdf8y/vpeRmgS8jjKtmqxjhLJwhED0rvhnUAXZV7QlbJj4JH1A3Y+ezSZ/CbcxXMwX
         Y6nkLSz1U15C1Gq8BnExlm8OaDy4WPGOhoNtNExyDzYaewX+kZNpv/y0d5Wx5VDfJBaV
         dVSA==
X-Forwarded-Encrypted: i=1; AJvYcCXOuDKQ29PwpuODfJiWdkF18hGC5CFOap5ItDpY/Z3k69YoXV3GaaPLO6uu2DQWzNJZKyGPX/4pCaDzx7aCTD1i5A46NXWI
X-Gm-Message-State: AOJu0YwYBLymLGC0j3n9EF5ULL6VrdN/TvcvYQIcgtsXAlMobg8RqfQa
	HZ1zRSvR9eI0vNGIC+eYtfEKeTB8eUyRtdqAPbLVEusNkKgHS4BYP+DrdLN2nlaySGz6OH7aGqu
	NI/SYyfg/XhTOhggJlbHqO0QtvGisvSxwNQJiHptBPcRQpLJlF8dSww==
X-Received: by 2002:a05:600c:4743:b0:41b:ca55:2e2c with SMTP id w3-20020a05600c474300b0041bca552e2cmr8502335wmo.17.1715006983673;
        Mon, 06 May 2024 07:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEmpLMRChpFtoTgMDV3aoqDMFyufxEAAMjuwb6gH8jVd4UbrgetEx8t9mH1iRsKhjutk0Nw==
X-Received: by 2002:a05:600c:4743:b0:41b:ca55:2e2c with SMTP id w3-20020a05600c474300b0041bca552e2cmr8502298wmo.17.1715006983060;
        Mon, 06 May 2024 07:49:43 -0700 (PDT)
Received: from localhost (net-93-151-202-124.cust.dsl.teletu.it. [93.151.202.124])
        by smtp.gmail.com with ESMTPSA id cw1-20020a056000090100b0034dec80428asm10817755wrb.67.2024.05.06.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:49:42 -0700 (PDT)
Date: Mon, 6 May 2024 16:49:40 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, lorenzo@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com, toke@redhat.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
Message-ID: <ZjjuBCk33QtxLrAm@lore-desk>
References: <0000000000004cc3030616474b1e@google.com>
 <000000000000ae301f0617a4a52c@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vAieqiNxGUQydHCv"
Content-Disposition: inline
In-Reply-To: <000000000000ae301f0617a4a52c@google.com>


--vAieqiNxGUQydHCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> syzbot has bisected this issue to:
>=20
> commit 2b0cfa6e49566c8fa6759734cf821aa6e8271a9e
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Mon Feb 12 09:50:54 2024 +0000
>=20
>     net: add generic percpu page_pool allocator
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D151860d498=
0000
> start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.=
o..
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D171860d498=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D131860d4980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d=
440
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df534bd500d914e3=
4b59e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17ac600b180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1144b797180000
>=20
> Reported-by: syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com
> Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>=20

Looking at the code, the root cause of the issue is the WARN(1) in
__xdp_reg_mem_model routine. __mem_id_init_hash_table() can fail just if rht
allocation fails. Do we really need this WARN(1)? It has been introduced in=
 the
commit below:

commit 8d5d88527587516bd58ff0f3810f07c38e65e2be
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue Apr 17 16:46:12 2018 +0200

    xdp: rhashtable with allocator ID to pointer mapping

Regards,
Lorenzo

--vAieqiNxGUQydHCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZjjuBAAKCRA6cBh0uS2t
rHE8AP9aiQe9PRxjbu8EA3OAzA4evmD4DeMhokGWsZjanPp69QD/Qr+N4crIXk/4
h4vZ5Fo/cpxn4NjaaMLCYwTl/2NQ5Qw=
=QBb4
-----END PGP SIGNATURE-----

--vAieqiNxGUQydHCv--


