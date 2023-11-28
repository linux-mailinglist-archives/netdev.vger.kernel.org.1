Return-Path: <netdev+bounces-51733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533857FBE7E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4128202C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610161E4AA;
	Tue, 28 Nov 2023 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N91FtReS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D090
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701186675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h4K1ccbQslEI6CdDcMlauekllahJXsz5FTmnurJLoU=;
	b=N91FtReSiR81e+teeA7Ot4gYe7zdLyrFXGXH6+NvGcUtQutDy1Liw+2vs9FOFXqoEnFDqA
	vBr6UI+UMaOPusfDEzCQGoi3hk9pkBf+r1nEpT98/jDccBJpoHC6tcLuk16CtCAWqhJiUA
	zsNwX/m33qBvAggjf4y1oLuhnq6+uqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-nJ7eauOCMu-YgSVUG6agJg-1; Tue, 28 Nov 2023 10:51:13 -0500
X-MC-Unique: nJ7eauOCMu-YgSVUG6agJg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332e4030884so784144f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186672; x=1701791472;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4h4K1ccbQslEI6CdDcMlauekllahJXsz5FTmnurJLoU=;
        b=PZDub+HLRw0pikUWS26/Y2sXFACsqXR5Ha7aVP1TVttmVIn2Fq7fHE2sQ8Th3WtiBT
         2OBcNiiv5vRk47CVSV6Xu0cnInkjCU0KkqiP7UKXG+/djRruC6FhQ+fj2QE90w+NV/rC
         WqAS6WdOlIjhJikVkV299xJmZjqouvHCdrwvwIc0ujIV6fz3o6SoKXHPqwxlRQ+vXEmm
         b4oa0/YV2ngNcF34PHZcUPubzxIji9UlkGkI2a1ThbgNT/wINYh133xlHe4owHMH/Fge
         XlvA0qNmckP6aH7xjg2u+nnnas5k3G38hd9EcLOKrOqX0cjXcbCuPDe9f0c/lfGN1r7B
         jqkQ==
X-Gm-Message-State: AOJu0Yz57TXm9ie2Sa/mdj7w/xi77wIga8/dmqbW+L8Ul3bAETRXbkyZ
	Kg5/TrQgtZ7tgDBLhG5Dhe59B4rWeOu+RsXf1eNxPZFrsh7TyxvKcDNjI88aE9wcCz/sdRiEJLl
	rW0KUBFtqOUex8YYCf5VOdV8l
X-Received: by 2002:a05:6000:1b85:b0:333:980:c388 with SMTP id r5-20020a0560001b8500b003330980c388mr1939160wru.5.1701186672056;
        Tue, 28 Nov 2023 07:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfMnj/2FNTGqvThbUF/4m8o1l2cbXNDZ7gJ4fjNtdMGR7oHS66wq+o/saOJAuM68jSexVxLQ==
X-Received: by 2002:a05:6000:1b85:b0:333:980:c388 with SMTP id r5-20020a0560001b8500b003330980c388mr1939149wru.5.1701186671709;
        Tue, 28 Nov 2023 07:51:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id q4-20020adfea04000000b003296b488961sm15260012wrm.31.2023.11.28.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:51:11 -0800 (PST)
Message-ID: <9daf8509e39cd20d9d806afdb425ad43af037f8d.camel@redhat.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Nov 2023 16:51:09 +0100
In-Reply-To: <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
References: <20231126151652.372783-1-syoshida@redhat.com>
	 <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 16:45 +0100, Eric Dumazet wrote:
> On Sun, Nov 26, 2023 at 4:17=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.=
com> wrote:
> >=20
> > In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() retur=
ns
> > true. For example, applications can create a malformed packet that caus=
es
> > this problem with PF_PACKET.
> >=20
> > This patch fixes the problem by dropping skb and returning from the
> > function if skb_pull() fails.
> >=20
> > Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  net/ipv4/ip_gre.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > index 22a26d1d29a0..95efa97cb84b 100644
> > --- a/net/ipv4/ip_gre.c
> > +++ b/net/ipv4/ip_gre.c
> > @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
> >                 /* Pull skb since ip_tunnel_xmit() needs skb->data poin=
ting
> >                  * to gre header.
> >                  */
> > -               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> > +               if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr))=
)
> > +                       goto free_skb;
> >                 skb_reset_mac_header(skb);
> >=20
> >                 if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> > --
>=20
>=20
> I have syszbot reports with an actual repro for this one.

Could you please share them? I could not find easily the reports in
https://syzkaller.appspot.com/upstream

Thanks,

Paolo


