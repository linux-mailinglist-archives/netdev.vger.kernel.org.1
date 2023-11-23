Return-Path: <netdev+bounces-50400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A717F59B7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D363281418
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBEA18AF6;
	Thu, 23 Nov 2023 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2kbJr8h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4141738
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700726462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fc0JVrpQ0q+qWvy2uYw78zXNtmSoaii+jhiF+Na6Xz0=;
	b=S2kbJr8h73OABA4+yq6nCWlCZ/GGXZfWFa1oKRRsRBp8Zk+hrlY/14WnObxrSGp2ghD/U9
	LekhkUFpY1Npc6liCxNyU6AmWW+ewh9uFAF9BdZ9rjhh3SYIr87dV5R8vd8GbApmZ4GUTr
	OIsabcR46CqxmUR4cnBR4uPuNUMaSa4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-xg3EX8RvOVWBWizZF9GjVQ-1; Thu, 23 Nov 2023 03:01:00 -0500
X-MC-Unique: xg3EX8RvOVWBWizZF9GjVQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5491de618b1so13494a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726460; x=1701331260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc0JVrpQ0q+qWvy2uYw78zXNtmSoaii+jhiF+Na6Xz0=;
        b=hD2BZPQViXpMMCLYVvtlsPu2z/f73VxdAHVaMkbCaL0mQYha9Qsb3RZCjJpEeuM6Gr
         plgs7taK9Wp9EbC2UcmQ7uor2bjhx+wNkVf4OGxZEJ1eSKjH7HYIel6Fuj1MMadJVTAx
         t2Qj0b1GWqyOVHpqdMXTE/WHyghkhlwi71nUrhGZvALtnw8V/qX4iLvwyYn73W1uLwLj
         NuQet/mKZKMyERhTM/jec1YMXJN/bYPpW+gO17tRe6EKZAkYQMMTtpemucNeW+tOnzWz
         KGDjtmccKePYq1v7myt6rks/afizkvZ6Nd2WUOoKYv3Z9/67Bi+3pDJpw5J5RDbNEZOn
         Uw/w==
X-Gm-Message-State: AOJu0YzJtY9RtDIyHQZSNOA9zlrYn1v0u1b4S9gma1R7vOMvHPKxNHDC
	LfTbBYWcQA+pJsC51XwI9w69jDGUrAdEyPSiNDXbs6jatVoWOAKiN7hW8ZdT5NTaEspHlYeA3nT
	j22kEzQrVkpOvc9Pu
X-Received: by 2002:a05:6402:27cd:b0:544:3944:d7cd with SMTP id c13-20020a05640227cd00b005443944d7cdmr3887473ede.2.1700726459831;
        Thu, 23 Nov 2023 00:00:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeZEd7t22xXOJeCp2tazrytapW1GyPswmje6vnKsa5mT4uEKyU7gzX90EOT+fC2hdRju6uwg==
X-Received: by 2002:a05:6402:27cd:b0:544:3944:d7cd with SMTP id c13-20020a05640227cd00b005443944d7cdmr3887441ede.2.1700726459453;
        Thu, 23 Nov 2023 00:00:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id bc18-20020a056402205200b00532eba07773sm363428edb.25.2023.11.23.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:00:58 -0800 (PST)
Message-ID: <193463799264cd58373df81b6e93cc4091c83ca5.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net,  matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com
Date: Thu, 23 Nov 2023 09:00:57 +0100
In-Reply-To: <20231123004834.58534-1-kuniyu@amazon.com>
References: <000000000000545a26060abf943b@google.com>
	 <20231123004834.58534-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi.

On Wed, 2023-11-22 at 16:48 -0800, Kuniyuki Iwashima wrote:
> From: syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
> Date: Wed, 22 Nov 2023 07:43:23 -0800
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    c2d5304e6c64 Merge tag 'platform-drivers-x86-v6.7-2' of=
 gi..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1536e3d4e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De32016b84cf=
917ca
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db834a6b2decad=
004cfa1
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11469724e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13934aaf680=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/23ea827adf3b/d=
isk-c2d5304e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0f964ac588f5/vmli=
nux-c2d5304e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b061be889285=
/bzImage-c2d5304e.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in mptcp_incoming_options+0xc93/0x3a80 net/mpt=
cp/options.c:1197
>=20
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t c2d5304e6c648ebcf653bace7e51e0e6742e46c8
>=20
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd15ec73073e..01066aa7e67d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -370,6 +370,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> =20
>  	/* initialize option status */
>  	mp_opt->suboptions =3D 0;
> +	mp_opt->use_ack =3D 0;
> =20
>  	length =3D (th->doff * 4) - sizeof(struct tcphdr);
>  	ptr =3D (const unsigned char *)(th + 1);
>=20

Thanks for the patch! AFAICS it should work, but I think the variant
proposed by Edward:

https://lore.kernel.org/netdev/tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A=
@qq.com/

should be better, adding the additional instruction only in the code
path needing it.=20

Thank!

Paolo


