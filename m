Return-Path: <netdev+bounces-69390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0B84B032
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8608B1C21CAB
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2512C542;
	Tue,  6 Feb 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLednPM2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02912B174
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209006; cv=none; b=k0F8Oc6rHi8kv73ZpBrjtMpOBrh8TOujdU0k8OM5NV1k6mzc/vc3E6Y1vjb4J+6k5w/I7A+5hOlkL6hA7l4JBq9DljymU4TeNEJMmofCpQc78L4KENYrgFb6Som2vejx9aiJjV6UVqRib0h9OU7TUZ58k7rT5D9HfneNQ3tQpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209006; c=relaxed/simple;
	bh=4kUF1dsqZ3HydIu0UmZlVkoFVYPz8YhNJl31ieHIyoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVgdGnfE4YBpU1e1NoYdbQldKv+s/yMtXBbRziqtLTG9Rs6OvVYhSifKKF/9hQLDotuH/slb3PzVxYIatuDYrFq8lB2U6ddzpjDewUl7KE+hZqaUAWRgou8K3G4/RcdOG4LnN/MzAHV5raPEx1iaKnaMgah9HrbbUMBFN/Ncn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLednPM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707209003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TLq3ye7gMCI0pAC3vStirIbgKgIsTAMc8Eh5rpxxxgc=;
	b=SLednPM23ceqf4wQ9ox77Cb4Mza29METZNMd8juWTB5kdwPi8wFEGgyxcrZdlthTWWii4f
	kNArAB/MgexVvO8qJ46/oUaY/H3ZYLxlMaBQHNkSeZSDadpgZ718kEvNiO4+wys0lrqkmn
	fQT5xbLC7SYKDuSkRIZQlV5YaIpT6XI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-8NQWU-x4O0KXUb1RMH9GGQ-1; Tue, 06 Feb 2024 03:43:21 -0500
X-MC-Unique: 8NQWU-x4O0KXUb1RMH9GGQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e93545a26so1534511e87.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 00:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209000; x=1707813800;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLq3ye7gMCI0pAC3vStirIbgKgIsTAMc8Eh5rpxxxgc=;
        b=OTOFzbW1P8Stf5v8OLXaI4OhcXU10qblL6+ZtZnkjbhKek7bAifERUrIECurYqarZd
         OWCIpuowhk5Folj0wgMneE8CfP9EZGBSFuS6OQqn7qxg67SQgdj9y5uZB5h/aJcUWi+j
         7Vc9d0H5ypoX5wUHarKNghlt8rpd1ldgg+Q4dnpudtn0OshrgNk0TzpLBXPThxX1uLZA
         KkhX5Bd93gBJIHONmnpAJ+DVCudD0VAKujf6ZMyUcWY6XNaSXIwvg7p7t7EH7HiCjs9Q
         4+hRubX61XJ+0JP21cGAYVahTKf8BInztIy/M/hkqrlmbj5DgcW2V4NKKiZ9ibT0Apic
         kqJA==
X-Gm-Message-State: AOJu0YwW/W2TD+WCQIdGBCTWwuFbodH2Jht6+/xpmQihCX8FNpsfj24A
	tRHEmi9KEL6JA81CA4qAjL8d3p8Lz4X+SwvRL8EKR7SOjoS9Ulj51wgeNwztaP+m41/2NUZMB6m
	IfCZ3Kv8X1KRlTfPW+ZmkKPliwkSIExYofgsNXaURJwx4TMLo7ylXKQ==
X-Received: by 2002:a19:e01c:0:b0:511:4881:1b6d with SMTP id x28-20020a19e01c000000b0051148811b6dmr1133567lfg.1.1707209000470;
        Tue, 06 Feb 2024 00:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjuD+flFVmy5XKfDIjacx28CSlDoqwFqJ4jwV3YQ+8SK8l48LEpLPowDDXO7YJrPXNewNyHA==
X-Received: by 2002:a19:e01c:0:b0:511:4881:1b6d with SMTP id x28-20020a19e01c000000b0051148811b6dmr1133553lfg.1.1707209000075;
        Tue, 06 Feb 2024 00:43:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXD1eN72LWEimGgaifuJWs5pa1umg2e4HMNCu73A5+Iq1LJr8JGeIQrYCHMsg8uGF8pww+OKWqWpk2UJa++zh+F5Zcc2FGq
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id dn17-20020a05600c655100b0040fc2b3d852sm1198646wmb.30.2024.02.06.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 00:43:19 -0800 (PST)
Message-ID: <852606cd9cbc8da9c6735b4ad6216ba55408b767.camel@redhat.com>
Subject: Re: The sk_err mechanism is infuriating in userspace
From: Paolo Abeni <pabeni@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>, Network Development
	 <netdev@vger.kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>
Date: Tue, 06 Feb 2024 09:43:18 +0100
In-Reply-To: <CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
References: 
	<CALCETrUe23P_3YAUMT2dmqq62xAc7zN0PVYrcChm4cHGJMDmbg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 15:03 -0800, Andy Lutomirski wrote:
> Hi all-
>=20
> I encounter this issue every couple of years, and it still seems to be
> an issue, and it drives me nuts every time I see it.
>=20
> I write software that uses unconnected datagram-style sockets.  Errors
> happen for all kinds of reasons, and my software knows it.  My
> software even handles the errors and moves on with its life.  I use
> MSG_ERRQUEUE to understand the errors.  But the kernel fights back:
>=20
> struct sk_buff *__skb_try_recv_datagram(struct sock *sk,
>                                         struct sk_buff_head *queue,
>                                         unsigned int flags, int *off, int=
 *err,
>                                         struct sk_buff **last)
> {
>         struct sk_buff *skb;
>         unsigned long cpu_flags;
>         /*
>          * Caller is allowed not to check sk->sk_err before skb_recv_data=
gram()
>          */
>         int error =3D sock_error(sk);
>=20
>         if (error)
>                 goto no_packet;
>         ^^^^^^^^^^ <----- EXCUSE ME?
>=20
> The kernel even fights back on the *send* path?!?
>=20
> static long sock_wait_for_wmem(struct sock *sk, long timeo)
> {
>         DEFINE_WAIT(wait);
>=20
>         sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>         for (;;) {
>                 if (!timeo)
>                         break;
>                 if (signal_pending(current))
>                         break;
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                 ...
>                 if (READ_ONCE(sk->sk_err))
>                         break;  <-- KERNEL HATES UNCONNECTED SOCKETS!
>=20
> This is IMO just broken.  I realize it's legacy behavior, but it's
> BROKEN legacy behavior.=C2=A0

As you noted this is an established behaviour exposed to the user-
space, and we can't simply change it, regardless of it's own (eventual
lack of) merit.

>  sk_err does not (at least for an unconnected
> socket) indicate that anything is wrong with the socket.=20

What about 'destination/port unreachable' and many other similar errors
reported by sk_err? Which specific errors reported by sk_err does not
indicate that anything is wrong with the socket ?

I guess that if you really want to ignore socket error for datagram
sockets at recvmsg()/sendmsg() time you could implement some new socket
option to conditionally enable such behaviour on a per socket basis.

Cheers,

Paolo


