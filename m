Return-Path: <netdev+bounces-97329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E048CAD2B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97A9B20B71
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7B76CDA9;
	Tue, 21 May 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBsDiWln"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8583BB4D
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289920; cv=none; b=WAdMq1mQ3Kuzwk6N/pNCmNttfrOyn2Ie62vfwhbyCySf8lNl1QKhbhFpxboBIGDXQcnm4OrosxIAPuCYSi2/4qO1Vxom367pyOapN1FWth8rbE36Ckzk0oc6K1tgrKNXbr/1huzZt1Ze5FsVS8Gp1YQKuUSEPMxxX1aRVH9famw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289920; c=relaxed/simple;
	bh=yNz02aNVpQbBKJAVGEiDNmTqOVoMNGNUOBEw10RCFoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2cd17c0KklldwMrSD4ogD3SpdaJ1TfqU6B9A6Ch0rr+TnU4PKAameTKq8ZzRT+bD//ftM1TzMRzIlymt5+gHRc7h212x/tS93gleG0EQWdGFW1oiCJLvuQ7mMkIUTngzDIx26iHuEeqRbcE8RjFeVwMZAP/Gf9rzR9/KW6pqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBsDiWln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716289917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jqtWLnRFQeftuZYddpHPUClLHiXEFj7muI3Dj/Utva8=;
	b=KBsDiWlnegOdaET/ZqyS0UIjdzlNmzpYfCp3DrB6Un0vk4RaDDm39vL669sSiojaxV5v5E
	0sE/Bt20gJ9GqfeF98NjxgkyTMqL9rI5YCMlDYfUBPSlpasCnka51uqBsveBd4MaV4wYEw
	3B24x8itoc0DXd+xm5mPYXOZlXAPNIk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-meQJF895OC2Q_5nwGjvKmA-1; Tue, 21 May 2024 07:11:56 -0400
X-MC-Unique: meQJF895OC2Q_5nwGjvKmA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e72a81a1a2so1465201fa.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 04:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716289915; x=1716894715;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqtWLnRFQeftuZYddpHPUClLHiXEFj7muI3Dj/Utva8=;
        b=emgbcYn18NbXzkybHf3+5yE9eFJwL94Ze4XJMjheXGpa06kwj9xkUgOqvuHLGDo4I5
         ddKqZfiH909Xh5M3xbl6fNQIevK2rfQBi55MzLdpVWrVCdQVOEjGdaMXKGylhnfClkBy
         MqgWTxql5mAjscs71SbubqetdsYxz+P+Fq/sKJHyahmm/9CTtuKlCDe8pUsX3QzY0QN/
         z12v7eAGPTkTESb/XW+bDS2oJomedkio/sXHEsiXo7mT1wLaNlhu9sEJGYhEjnE7uxk1
         XfzsStNsDPK+77XxkhgQ81bTs79w1NbIAF0VFzcGsl9teKK5Sz9qV8CAbeIcZgJpPRgC
         p3nw==
X-Forwarded-Encrypted: i=1; AJvYcCVN1IwuAFRWeAf1RwfwDvRGOJvydd1OIQzHRoXmJGi+bmOzYYD1+JdFCHqgX0tZrJbuJTvmxwPTU8/drj+g/3c1KBWZF9HI
X-Gm-Message-State: AOJu0YwQoS2ZDI7L2Nvc8WWsL3Hahde89dwVg3AwTl1ZWGa0CTBIRJ9g
	zXXsaJiJglT0O+JgeYOafkVkEGw05DP8QUTwkXzIUyiUbWgwPVZFAXTPOTPYnDj3FpEdJQO1iY/
	TdB8cobotz7R6Fa9a8vC01rGqmnZtg697ILG8GS/5S9YIZhNpGJebVw==
X-Received: by 2002:a05:6512:1296:b0:51e:e6f4:2ef1 with SMTP id 2adb3069b0e04-522104792f2mr22363936e87.4.1716289914917;
        Tue, 21 May 2024 04:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe+/XZMh93+F5b2G/cjAiPWsWQ1NCYwPsdVYso2US2i9z4XDruvUiMutQFsu7qboCJW5ig+w==
X-Received: by 2002:a05:6512:1296:b0:51e:e6f4:2ef1 with SMTP id 2adb3069b0e04-522104792f2mr22363913e87.4.1716289914412;
        Tue, 21 May 2024 04:11:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d92sm1614700266b.98.2024.05.21.04.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 04:11:53 -0700 (PDT)
Message-ID: <aa07bf0e1ad60520705ea4f51f77bf3faa83aed6.camel@redhat.com>
Subject: Re: [PATCH v5] af_unix: Read with MSG_PEEK loops if the first
 unread byte is OOB
From: Paolo Abeni <pabeni@redhat.com>
To: Rao Shoaib <Rao.Shoaib@oracle.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: kuniyu@amazon.com, netdev@vger.kernel.org
Date: Tue, 21 May 2024 13:11:52 +0200
In-Reply-To: <20240516231622.1545187-1-Rao.Shoaib@oracle.com>
References: <20240516231622.1545187-1-Rao.Shoaib@oracle.com>
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

On Thu, 2024-05-16 at 16:16 -0700, Rao Shoaib wrote:
> Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
> commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
> addresses the loop issue but does not address the issue that no data
> beyond OOB byte can be read.
>=20
> > > > from socket import *
> > > > c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM)
> > > > c1.send(b'a', MSG_OOB)
> 1
> > > > c1.send(b'b')
> 1
> > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'b'
>=20
> > > > from socket import *
> > > > c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM)
> > > > c2.setsockopt(SOL_SOCKET, SO_OOBINLINE, 1)
> > > > c1.send(b'a', MSG_OOB)
> 1
> > > > c1.send(b'b')
> 1
> > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'a'
> > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'a'
> > > > c2.recv(1, MSG_DONTWAIT)
> b'a'
> > > > c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'b'
> > > >=20
>=20
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> ---
>  net/unix/af_unix.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fa906ec5e657..6e5ef44640ea 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2612,19 +2612,19 @@ static struct sk_buff *manage_oob(struct sk_buff =
*skb, struct sock *sk,
>  		if (skb =3D=3D u->oob_skb) {
>  			if (copied) {
>  				skb =3D NULL;
> -			} else if (sock_flag(sk, SOCK_URGINLINE)) {
> -				if (!(flags & MSG_PEEK)) {
> +			} else if (!(flags & MSG_PEEK)) {
> +				if (sock_flag(sk, SOCK_URGINLINE)) {
>  					WRITE_ONCE(u->oob_skb, NULL);
>  					consume_skb(skb);
> +				} else {
> +					skb_unlink(skb, &sk->sk_receive_queue);
> +					WRITE_ONCE(u->oob_skb, NULL);
> +					if (!WARN_ON_ONCE(skb_unref(skb)))
> +						kfree_skb(skb);
> +					skb =3D skb_peek(&sk->sk_receive_queue);
>  				}
> -			} else if (flags & MSG_PEEK) {
> -				skb =3D NULL;
> -			} else {
> -				skb_unlink(skb, &sk->sk_receive_queue);
> -				WRITE_ONCE(u->oob_skb, NULL);
> -				if (!WARN_ON_ONCE(skb_unref(skb)))
> -					kfree_skb(skb);
> -				skb =3D skb_peek(&sk->sk_receive_queue);
> +			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
> +				skb =3D skb_peek_next(skb, &sk->sk_receive_queue);
>  			}
>  		}
>  	}

Does not apply cleanly anymore after commit 9841991a446c ("af_unix:
Update unix_sk(sk)->oob_skb under sk_receive_queue lock."), please
rebase, thanks!

Paolo


