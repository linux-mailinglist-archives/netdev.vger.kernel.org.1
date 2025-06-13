Return-Path: <netdev+bounces-197586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F297AD941A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE797A260E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C781BEF8C;
	Fri, 13 Jun 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="uRcIUKU/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A792E11AE
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837799; cv=none; b=pT8sYTZ3XdpuVHsFlk8HWuQNme4r7kCt+mXtxKk4UaxeNABTHjwED3bbcSVFh15X7nXDNBmr2G7npu98QmTsaJyACw3T/CPT2rc+QSpk7Kz0NS8kVf7dwShwErWtkvYYji0AZy0Pc6DD2lmyclvN6QIkukPn1eamTIS1rDXjrXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837799; c=relaxed/simple;
	bh=DPGGQAWvw49wh0IVggbiR7ccXkRXC3cr12d7nWb+Mow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLxongxg9zbE9n7j2bIi/qV5f8pWXDJrFdWpUPqxFHrCkFYCjV1Aojum94cyjD332FnowlOeGG65fb3dI1BU7bEOWE2LSe6tTFyH2XmEhsE5j0oGyodLbO1GupW+36HpQ296Yp5V7uXOAL/1tZl7cxTLtDpRqQBGTXufPn2GKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=uRcIUKU/; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DPGGQAWvw49wh0IVggbiR7ccXkRXC3cr12d7nWb+Mow=; t=1749837797; x=1750701797; 
	b=uRcIUKU/sd0QK6T7rzQCth4CmnS7ll5nQL9rvbx0s+cays7QXARJYk6wJyeS+plQVZP2zvFTJEq
	s1QC8NkwzQR01dYvBmWRG6yIpo1r7aY3L3jN+ZeIntBCwCHHSDuf5i5hlwJkO+F/Drww4o6zJ/MBp
	0a4bhfU4ty31msc5+yVgKWgqrMrdncIBbroL0cYTOrhprLKlbv4/o3nw7L8Ckpth1ruEPn/M966sQ
	O+URDzPKmebW5wOS91OZzQhEl4ECsDa62V60ohiFdwTup8TQNU04iXdVflz7Rq1IJQIIq4lo+k1da
	t/geVBOE030RO3Tktvgwh0pVQWJ+BiMgwgmg==;
Received: from mail-oo1-f53.google.com ([209.85.161.53]:47196)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uQ8kG-000618-JM
	for netdev@vger.kernel.org; Fri, 13 Jun 2025 11:03:17 -0700
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60be58376c9so420113eaf.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 11:03:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQiLR+WJLkz6QUEYc9Sog9YzndcPXcf9cJy9TgljseQ10fp6d4
	I1oJBGOplmhwZoUa5Rm8luIzPBVoAoeRtt1y5wTupyyHZgb7u4pKxME2FqFn3PGIla1QYYnCRX/
	uwVuiFPmmGN/zPoJZ2HsC0rFSZwQ9uUA=
X-Google-Smtp-Source: AGHT+IG6VtnwrdkIZNP65g5SRDTKe/uXMAxLn86uuIXEiWVrrTjL72YRkyFcEAZJXR++FHQx2W8YIck8fqFSF8cGs5A=
X-Received: by 2002:a05:6870:17a2:b0:2bc:7007:5145 with SMTP id
 586e51a60fabf-2eaf089fa4emr421620fac.9.1749837795943; Fri, 13 Jun 2025
 11:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154051.1319-1-ouster@cs.stanford.edu> <20250609154051.1319-6-ouster@cs.stanford.edu>
 <20250613143958.GH414686@horms.kernel.org> <CAGXJAmxQn_iAqhOHwxEQ16n+MKjFyEbiUoBbGyDY+TLYooeJhQ@mail.gmail.com>
 <20250613171833.GN414686@horms.kernel.org>
In-Reply-To: <20250613171833.GN414686@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Jun 2025 11:02:27 -0700
X-Gmail-Original-Message-ID: <CAGXJAmySuyiB3+c0_Rj=1X9wZwG7H0qhRtuvowfHke392vEpAg@mail.gmail.com>
X-Gm-Features: AX0GCFtf_NxJbBhChjWYhKtRbKv2qPAJqzhRySeh1v97j636f-4dc6HIg8L5VhE
Message-ID: <CAGXJAmySuyiB3+c0_Rj=1X9wZwG7H0qhRtuvowfHke392vEpAg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/15] net: homa: create homa_peer.h and homa_peer.c
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 9c8d7c79e82d9ccd3af9a51b4d3246f3

On Fri, Jun 13, 2025 at 10:18=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> I'm suggesting moving murmurhash3_128(), say to lib/ at the top
> of the Kernel tree. And I'm happy to assist with this.
>
> Aside from being accessible, does murmurhash3_128() meet your
> needs in it's current form?

I think so. I'm currently using a 32-bit version of murmurhash3. I
assume that the 128-bit version will be fine functionally, but I'm
wondering about performance. The keys I'm hashing are small (24 bytes)
so the 128-bit version will spend most of its time in the tail code;
will that end up being significantly slower than the 32-bit version
(where there is no tail code because the keys are multiples of 32
bits)?

-John-

