Return-Path: <netdev+bounces-231337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA108BF7A40
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E5B1891C3E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDE3491CF;
	Tue, 21 Oct 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="dOZS0BM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A45346794
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063890; cv=none; b=mE+PCVuCRVqYP7qfNyGLX8FJBe/sqAG7njfyo/euRSsjSQSzJOgui7EPClH/wRdHhFPG0Hfhg3UVScE6KnUuXM1uKicg9zjrAkksoemF5S10yoRwHvOjP6PkYVA2TXT2fGr/9FH4v0AZmHf8t7FPSe7fae2L8kSIGbg6YcNgrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063890; c=relaxed/simple;
	bh=LPxcUV/uZgRLwv77CFqbAK5ZXM2mug3gCnaHpQGcE94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kvd+viRGmnza7ifF5CDffPLLXpQqvefJe6Y34qJhcIm4zKLCtfMu77hQjY1Fi6ApdddP/T0KbT1EMR++VRi9Djgj4CKcUWVvNkuziKk5s13cNeIbAzomiME/wqCkphcsqLxqE/iWLn3Uvywx5aoM8vwGSQb7zeypyF1N3m87jMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=dOZS0BM0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-784807fa38dso46875657b3.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761063887; x=1761668687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUhkDUpdWJD0ROxc0J5na9HrpWd09vQOwYetoz8/ls0=;
        b=dOZS0BM001wApP4MQUQVYMoA0ZL8aGm3ELyHJ5tDbiNjfFuJDJgxStpnOfqDMbnwdO
         4oA0DhnHXme8S071kCbgGYTuOFUhXbbXthj9CkZQN4f1SFHW5ydI6HW4A7FBjwze8/9O
         kxFL/ALAltq5PjUM1eodmtTnn2UhNOIMYCN1WpvXBcwE6p0b9Ss8+WICd5jnsiTaEpZR
         jujBkyYrCKirvzB/v/SlNdJAJ3bLkavYaGhvuOSPXhhy+qjjtdW4hm7AtOMacx8pF1dM
         QQlL7ADjXWv8vE/e/WvlML3KQe7NQRr08k/vXAf9P11P4b0U2g57S8Nhc5BpVDFuWZGF
         o0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063887; x=1761668687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUhkDUpdWJD0ROxc0J5na9HrpWd09vQOwYetoz8/ls0=;
        b=liVabNyIJio28JDWUQXVEsOYKU7ksVylhCMiWz/YqOTlLgA8JGE4If1KoUuY0/3q70
         ATy4/giXfjhJ8q1pf3CF/UXLdSXpyE3Bo24an32IKPs9ohPixxeDzM4F+Ic7S+UOhRlO
         185irXa1s2eh1b4NldCWh7t5LBFZsqthy+vcANXj4WgfduQBji+rkI8lEJ0n8HyRkLhd
         9WBxSI9AbmGVq5GHXeOmX7JqS+/Hw4AoojDB+p1NAQrtSclZlYkg06jLPEP3B9LtSGpR
         ns0oPg9tRFgCHuhv8XN2ZAoA9Ze0zH2Di54ZLWfN6ixPVbdmDNvqaFidIXRbMu5/Ub1v
         zKzw==
X-Forwarded-Encrypted: i=1; AJvYcCWAgQHG8c3UuiC0zhgqKIw8lqv575NXQH/Zedm24ICjw/t0klIvQBAkxr3u/RxvkucwR9tE2SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8e1MS94BFMvw9v4+x7E/+vSz/3pFuATypFAq1CXcn2A4ZZRb
	VdKh16lOjjP/N3kd1mESX25hdWYZ//XZllKcGm4UEwtb8WcOda1Kp4B6MBLQPvmyDtaSpzysaNb
	I8gC85oa/1fKdCHmJ9LkJIYomloO6IOyWaMc++e5DVQ==
X-Gm-Gg: ASbGncv2znEAbkzzao1+FfLAvjYbTnJmrloPtqE/Ge1sbPQbdM4+VccuzYIiGn952zU
	qmkIpOS9UUCI+l1aoNVUAf7RQTYmJtLnnp5npz7eOjMUanApQuTKNQqtACR8n0qTxp2xkomzwZo
	d6qho4T3Dd23UVejaBjAWAPIMRqNRJ4T99mUFTkOgdPFdbyZPWHM3ikON2x+DOqIFcQhf00cwvV
	XxIFzZxbIg0KUcfVpHxol8/QgcVOBj4AEJ03Oellsi56p1cFDzMdqRmzRMQEm0XV+TUPw==
X-Google-Smtp-Source: AGHT+IFIzbGahgpm0Eliv/ifkch8/rPof8WlRMgywPs12B4KoNybuHeK0ASzfvhF2LV6uGZNnc6bklwBlg55lommUi0=
X-Received: by 2002:a53:d047:0:10b0:63c:e3dc:c2c with SMTP id
 956f58d0204a3-63e1610ebedmr10995594d50.18.1761063887030; Tue, 21 Oct 2025
 09:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io> <aPeZ_4bano8JJigk@strlen.de>
In-Reply-To: <aPeZ_4bano8JJigk@strlen.de>
From: Andrii Melnychenko <a.melnychenko@vyos.io>
Date: Tue, 21 Oct 2025 18:24:35 +0200
X-Gm-Features: AS18NWBuMcw-0lPVxcWWOGxdZHPzhJEVza7-n0ngZzaB1sMq4eLnUMOo6bQ7bfY
Message-ID: <CANhDHd8uEkfyHnDSWGrMZyKg8u2LsaMf-YXQtvTGgni7jetdZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

> I think this needs something like this:
>
>       if (!nfct_seqadj_ext_add(ct))
>            regs->verdict.code =3D NF_DROP;

Okay - I'll update it. I'm planning a proper test.

Apparently, I need to provide a simple test FTP server/client, not
fully functional,
but sufficient to "trigger" nf_conntrack_ftp.


On Tue, Oct 21, 2025 at 4:34=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Andrii Melnychenko <a.melnychenko@vyos.io> wrote:
> >
> >  struct nft_ct_helper_obj  {
> >       struct nf_conntrack_helper *helper4;
> > @@ -1173,6 +1174,9 @@ static void nft_ct_helper_obj_eval(struct nft_obj=
ect *obj,
> >       if (help) {
> >               rcu_assign_pointer(help->helper, to_assign);
> >               set_bit(IPS_HELPER_BIT, &ct->status);
> > +
> > +             if ((ct->status & IPS_NAT_MASK) && !nfct_seqadj(ct))
> > +                     nfct_seqadj_ext_add(ct);
>
> Any reason why you removed the drop logic of earlier versions?
>
> I think this needs something like this:
>
>         if (!nfct_seqadj_ext_add(ct))
>            regs->verdict.code =3D NF_DROP;
>
> so client will eventually retransmit the connection request.
>
> I can also mangle this locally, let me know.



--=20

Andrii Melnychenko

Phone +1 844 980 2188

Email a.melnychenko@vyos.io

Website vyos.io

linkedin.com/company/vyos

vyosofficial

x.com/vyos_dev

reddit.com/r/vyos/

youtube.com/@VyOSPlatform

Subscribe to Our Blog Keep up with VyOS

