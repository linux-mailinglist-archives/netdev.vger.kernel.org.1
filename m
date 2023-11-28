Return-Path: <netdev+bounces-51603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AD7FB510
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC880B20CA2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5A1946E;
	Tue, 28 Nov 2023 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or6/DZxo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74FE4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701161979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60UWT9hpYV2opT9b3jKpL7Vb/AVEC0x3aT0U6GS5l4k=;
	b=Or6/DZxocGgXuJy2jlJ/i8J1qZmFEfgZ/+1J6GhVwYRSGZtQ+qjHSjJcdkxoRt4qSL62p2
	dnc2qBIWmf1yP0aZ0bAl70MBBWPCJX1LG1646KSuSDWvwDkfe6xtQSnMWOVO0kfUEJC+Pl
	NUsXQbcN/ql69aiI+KO0PLuLYlPrp4w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-16X0ud6zOXOmd2y4eP3R-Q-1; Tue, 28 Nov 2023 03:59:37 -0500
X-MC-Unique: 16X0ud6zOXOmd2y4eP3R-Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a03389a0307so73167166b.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161976; x=1701766776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60UWT9hpYV2opT9b3jKpL7Vb/AVEC0x3aT0U6GS5l4k=;
        b=C/eZHTbRDKp66Z6IfFqy9JWoQFrahYmPhCiiM3KUSZ4q6a9KvDz4BbVaDlyIaSKhmu
         bXcD5Rf3B5IRoWt3bgE1IHbW16+ZTU3UHHwPXmCGJIqphGqvKLVIKCft3JgvrTpzqMkZ
         nD+Qz9H+KwNMKxDopea3Zi5B9rS89sz/7V4i+6O78BaSpEIntKcYPsZYG2p8+EcdHR61
         5vaz4yDM1z9eZMF7z183X1rdMIGF/qfm7nz6XYCxaSW7ZMmcCzaLk85kAhaiEwjezPLV
         tKCMpdxZriz/cXw0iY5MRZj4/KIT7Kyo/XRlSJkAeVGReDdMnSY9D19Ce3kfpO/pPuL7
         JCNQ==
X-Gm-Message-State: AOJu0YwQN5GKJnTNlAEYVaXt8FSlhp+K4agr4fkUptAUHvE7J8u72hmc
	YAIcwy1vu8vaDbmkdZxdVUxMqR/NqjLjiOFx+8Dtag6y/ITZzG2EBqSOffZEcdURlD0lSEpPlF1
	XLM+SNMiJVfw2G8CI
X-Received: by 2002:a17:906:7e0d:b0:a11:5a4c:6548 with SMTP id e13-20020a1709067e0d00b00a115a4c6548mr3111502ejr.7.1701161976652;
        Tue, 28 Nov 2023 00:59:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa6pz4f0Q9MMs7R29ydDBOIYcEP9Z0L1TlcUrM055p0HvsZw1mpK+lLRkGtiaTc6dnzMQ/5g==
X-Received: by 2002:a17:906:7e0d:b0:a11:5a4c:6548 with SMTP id e13-20020a1709067e0d00b00a115a4c6548mr3111483ejr.7.1701161976282;
        Tue, 28 Nov 2023 00:59:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id v13-20020a170906564d00b00a0ac350f807sm4456416ejr.212.2023.11.28.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:59:35 -0800 (PST)
Message-ID: <829107c3e007af0b0e040748f39873d838785dce.camel@redhat.com>
Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
From: Paolo Abeni <pabeni@redhat.com>
To: Neil Spring <ntspring@meta.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Wei Wang <weiwan@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 28 Nov 2023 09:59:34 +0100
In-Reply-To: <SA1PR15MB51870B8E934E9132044CE58DA3BDA@SA1PR15MB5187.namprd15.prod.outlook.com>
References: 
	<fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
	 <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
	 <ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.camel@redhat.com>
	 <SA1PR15MB5187F56AEFC6B6A581E056C5A3B9A@SA1PR15MB5187.namprd15.prod.outlook.com>
	 <3f549b4f1402ea17d56c292d3a1f85be3e2b7d89.camel@redhat.com>
	 <SA1PR15MB51870B8E934E9132044CE58DA3BDA@SA1PR15MB5187.namprd15.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 22:59 +0000, Neil Spring wrote:
>=20
> Would the following address the concern? =20
>=20
> tp->rcv_ssthresh =3D min(max(tp->rcv_ssthresh, tp->rcv_wnd), tp-
> >window_clamp);
>=20
> (that is, rcv_sshthresh must be no greater than window_clamp, but
> otherwise it can keep the larger of its current value or the last
> advertised window.)
>=20
> I believe this addresses both problem cases (transient tiny clamp;
> closed window when clamping) and passes (slightly less picky)
> packetdrill tests.

Note that the above is basically the patch I submitted (it yields the
same values).

Yes, it addresses the issue.

But it does not address Eric's concerns reported in this thread.

It's unclear to me if the more involved approach proposed here:

https://lore.kernel.org/netdev/ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.cam=
el@redhat.com/

would be ok?

Thanks!

Paolo



