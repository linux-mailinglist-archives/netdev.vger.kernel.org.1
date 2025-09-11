Return-Path: <netdev+bounces-221970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC3B5276D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE08C1893D6D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C11DED57;
	Thu, 11 Sep 2025 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="Q0hmFeu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB7329F20
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562663; cv=none; b=qhiiL1VsXVKb7B3FKbGvRHD9V+yKxpfZk7bda4hycYkiO+eMqYk9CZRnSi/q/5cbkfPU/SCkg+D4pzdDZlvsScQnLCOyoJCuceIFEEXo7mCIDVfCFORLQP28u53OF19vS20xHpebsLtq9LEHd6ioe0vdCl5jooXnuugdbHKR18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562663; c=relaxed/simple;
	bh=2RcHG+dlQGVwbg6GzMHZ0y6v4f+pMpDvxJxaGiOU+vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfjRp4X1hoTRTtirBg2bJtRUa26mIFGo+cg0GzesO3DQu4RLHNREPX7E4oreiJlIp5yiKTMiy7/BHid8/tplXKBH0+AVC/ywruEw3dgjr+hZUkPAP4BzavqmftJCqZa/LxhYSVDK20uQZk86mIGqCAVoqzsf8QvZQb+r/7fyO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=Q0hmFeu3; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so157842e0c.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757562661; x=1758167461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nAf35lgEeNHk0pFcYY7Z+5jX+myRGy2RThi3a4BoAY=;
        b=Q0hmFeu30mlZlF5kaN4POHlklfwx6UPONaHv0Dg1Z/m93Q1EiPEXqHeCYWUnE0tEw0
         cO5e36mGzwsE8Wf3dFqLCGuQ/7F6V+W/2ByQn+XfRFzUHWlQdSqprBlyCyql8PkEeo71
         YipHeH74szPVnf9z66+A44iT9gWhPtbT0DBNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562661; x=1758167461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nAf35lgEeNHk0pFcYY7Z+5jX+myRGy2RThi3a4BoAY=;
        b=B44gqFAmre5Z7GLDPR7PiUj98hVoS06fJPBmrOfhiXCjz2TYYurLR5TpoRingRUNXk
         7lc1W1kn5spX+KSYc96Nz5jq578jNpeaLja4Xs6hAIs2Gz+Os0miMOeWExSwvrqw3+06
         ErisJnX5M5j2cEyK+XZzLdgr5vKsV0DrKvxMKIO9p743hPIldLswsmAvBJyciD3zxymP
         RFD7++EKwMZPb7rCE8JiRZuAM+BynXldh3bSlXtFVg3+hKv/6aXlvPQ3HqVpRFpzLSBg
         b/D1jRwabaQkFRx2pGrrrLowsC7cFonuEsesJothA1MqENOvOzllkNHkU/3gXlo4oaUv
         F2bg==
X-Forwarded-Encrypted: i=1; AJvYcCW9NjsnJD8oymIvV0bQTReXnjNnywaPmDln4MwQ77bK8gN+5fuk7wRp/FvL+Josg15im1/p80w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6PGa5rA3DT/jJ9JPGKAQ1V1x9Bieki1Ys17K4pFawyI2rbWD
	5DN8prgrhBmgDcXdEJJbw8eaEZeIzx91boxfFMYJpYucyfbVjabD2zb9S2Vzzjfj86cok/1/YO+
	ZFd6e/otOPKLkvVGW2bJtGe/CHh71JR6oBlOKmS+AWQ==
X-Gm-Gg: ASbGncssfk89X6qUCVhUfm8eqQ1X5SbizGlxPxnceofk78ZGislQPPkTeO/xQe7N4FO
	W+ABHR9hv8wfuALbSo25ScmazOqlYvjaYIEDsvKdSEZafb9rgMKgUlXylAYZEEjvNlf6hOM8z2j
	R/4pnS5ceWdpC0M08ymA5WPeI4LlnZ/EMoP6pGH0u0IpZ8dFCkUZM9on+1TUivTsy0IFRs0K7tW
	3Z8YcJ8ZHqcvEF/0aQ=
X-Google-Smtp-Source: AGHT+IGHun0vVb26aSGszaq5vpKB5269fFzVk3tC6QLTOPElaHpL6CUcxq4cIh78YFRDkfNyXNaFND89eU6utQrkufM=
X-Received: by 2002:a05:6122:3283:b0:529:2644:8c with SMTP id
 71dfb90a1353d-5472abed77fmr6424919e0c.8.1757562661081; Wed, 10 Sep 2025
 20:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911013052.2233-1-anderson@allelesecurity.com> <CAAVpQUBoCPervZLc+-bWF5+hXX8yj0SwUcU3MiUQ514xi-F6uA@mail.gmail.com>
In-Reply-To: <CAAVpQUBoCPervZLc+-bWF5+hXX8yj0SwUcU3MiUQ514xi-F6uA@mail.gmail.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 11 Sep 2025 00:50:50 -0300
X-Gm-Features: Ac12FXxSrpVTS8iqDHK0LxpGmeT4PsaB3--Ah4QKHJGyv6OjeGVbSGH2Y6r5wyE
Message-ID: <CAPhRvky96rzK1-fwtyv-59ao2YtNOBWmH2+tozcm052Q8e-nOA@mail.gmail.com>
Subject: Re: [PATCH] net/tcp: Fix a NULL pointer dereference when using TCP-AO
 with TCP_REPAIR.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:44=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Wed, Sep 10, 2025 at 6:32=E2=80=AFPM Anderson Nascimento
> <anderson@allelesecurity.com> wrote:
> >
> > A NULL pointer dereference can occur in tcp_ao_finish_connect() during =
a connect() system call on a socket with a TCP-AO key added and TCP_REPAIR =
enabled.
>
> Thanks for the patch, the change looks good.
>
> Could you wrap the description at 75 columns ?
>
> See this doc for other guidelines:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#th=
e-canonical-patch-format
>
>

Thank you, Kuniyuki. I have just sent a v2 with the changes you
suggested. I hope it's fine now.

> >
> > The function is called with skb being NULL and attempts to dereference =
it on tcp_hdr(skb)->seq without a prior skb validation.
> >
> > Fix this by checking if skb is NULL before dereferencing it. If skb is =
not NULL, the ao->risn is set to tcp_hdr(skb)->seq to keep compatibility wi=
th the call made from tcp_rcv_synsent_state_process(). If skb is NULL, ao->=
risn is set to 0.
> >
> > The commentary is taken from bpf_skops_established(), which is also cal=
led in the same flow. Unlike the function being patched, bpf_skops_establis=
hed() validates the skb before dereferencing it.
> >
> > int main(void){
> >         struct sockaddr_in sockaddr;
> >         struct tcp_ao_add tcp_ao;
> >         int sk;
> >         int one =3D 1;
> >
> >         memset(&sockaddr,'\0',sizeof(sockaddr));
> >         memset(&tcp_ao,'\0',sizeof(tcp_ao));
> >
> >         sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> >
> >         sockaddr.sin_family =3D AF_INET;
> >
> >         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
> >         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
> >         tcp_ao.keylen =3D 16;
> >
> >         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
> >
> >         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao, sizeof(tcp=
_ao));
> >         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
> >
> >         sockaddr.sin_family =3D AF_INET;
> >         sockaddr.sin_port =3D htobe16(123);
> >
> >         inet_aton("127.0.0.1", &sockaddr.sin_addr);
> >
> >         connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));
> >
> > return 0;
> > }
> >
> > $ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
> > $ unshare -Urn
> > # ip addr add 127.0.0.1 dev lo
> > # ./tcp-ao-nullptr
> >
> > [   72.414850] BUG: kernel NULL pointer dereference, address: 000000000=
00000b6
> > [   72.414863] #PF: supervisor read access in kernel mode
> > [   72.414869] #PF: error_code(0x0000) - not-present page
> > [   72.414873] PGD 116af4067 P4D 116af4067 PUD 117043067 PMD 0
> > [   72.414880] Oops: Oops: 0000 [#1] SMP NOPTI
> > [   72.414887] CPU: 2 UID: 1000 PID: 1558 Comm: tcp-ao-nullptr Not tain=
ted 6.16.3-200.fc42.x86_64 #1 PREEMPT(lazy)
> > [   72.414896] Hardware name: VMware, Inc. VMware Virtual Platform/440B=
X Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [   72.414905] RIP: 0010:tcp_ao_finish_connect+0x19/0x60
>
> Full decoded stack trace without timestamps would be nicer.
>
> How to decode stack trace:
> cat trace.txt | ./scripts/decode_stacktrace.sh vmlinux
>
> >
> > Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
> > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> > ---
> >  net/ipv4/tcp_ao.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index bbb8d5f0eae7..abe913de8652 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -1178,7 +1178,11 @@ void tcp_ao_finish_connect(struct sock *sk, stru=
ct sk_buff *skb)
> >         if (!ao)
> >                 return;
> >
> > -       WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> > +       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connec=
t */
> > +       if (skb)
> > +               WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> > +       else
> > +               WRITE_ONCE(ao->risn, 0);
> >         ao->rcv_sne =3D 0;
> >
> >         hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_=
held(sk))
> > --
> > 2.51.0
> >



--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

