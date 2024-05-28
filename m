Return-Path: <netdev+bounces-98473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367638D18AC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE10282FCD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280D16191B;
	Tue, 28 May 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3yg0Qj1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE613AD3E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892549; cv=none; b=Xw1PSAcX85n8vgV7qnkVlK1b1Eoa2i8qClUIGCfz0fdYWOZamhCeS7VqE0ZYe3my+PEXK1UhnZxEVfEzZxE583DT8W5q2FjeUUxIAG496ivkSM829BwZrTEWbNaX6IdOS7pNZNdlWqY4dG8hHc1TEKN5m7qva4Lg+JG0qCiseFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892549; c=relaxed/simple;
	bh=j7S9DlbcPJ/KoNsgI3oHtUhoD5q3oshAimgD89cyeDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R52jEjpzC0IBd0VZBOVufZNsWQ7ZWYNhpnLEXD6SzZd/UxHIacV1ec766aAikbYxnP5djALm7KSCxOPVTI3CrBei2K+cZl6CT1LFvFbDTueuKjHhEtEXkHf4IJslx/NaxcREFHPbC6RqYzLEV3t7ltbWer3i/bWfpOGMnwIGf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3yg0Qj1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716892546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jHLUOF3dRCwShB1z++/pimEFBJJYEgEjXpaC56kRpsc=;
	b=J3yg0Qj1bh0UTc20om72R+ccs5Bj8eSPwcnyrXBplgZAdbeKph2oExMbeLN4x0GUR5XMjA
	e9DZ/bkYeFBVK+mmyXve7Cku56EVDCMow5HM+eOSLPotTQnaEHI1SdKp1ll/Lg0GpofTpi
	jrpQ0zi2j7kT4lPMpru5BonAmvMvqGQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-0ptlA3snPj-Xglk6TBaX0A-1; Tue, 28 May 2024 06:35:45 -0400
X-MC-Unique: 0ptlA3snPj-Xglk6TBaX0A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354f30004c8so59903f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716892544; x=1717497344;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHLUOF3dRCwShB1z++/pimEFBJJYEgEjXpaC56kRpsc=;
        b=Znw0Ne9mOInzvgvUWaUUz9AJYhrDvOgdSza9/5tkj9KktXx4jReJLsx9A1QC9FqzbX
         iR+d7po9ObDZXDb+i8o3i63EJhr7R8cc19mjaSsY5BtaS7ApNAVd6HdHg+ao2A2TjBwx
         QMSsQrc0l6FWasoiAJ1dWOds3SnZV09ZQpBWHzTXt8Brh9/yfbPAnofOXKF7T3nJ25+b
         dhhgCjizDytL6/TT7+FufK2sA1Wnq6zhzD47xEcKAT86gDDgcV188ap48ua5rexxy/L4
         ToI0qC7jwgp4AGSrWgHI6haHwM6KiodXXGWGYVuJOLzBU7u/oxBgYTC7GLsYergYw7Qk
         J8/g==
X-Forwarded-Encrypted: i=1; AJvYcCVL8s9jWIakavNf0jvWuLgaHHANI9LnrrlJ8iktcHe2DHn92REiSicDb1jJsFfAW1+VRwdwvCQ70ZtsHcyDo/YODDb32bnO
X-Gm-Message-State: AOJu0YxPzK0qR+QZoSKecfnbtEWC+FhfGsOO8sfoHyyXjKItarz4jQ1R
	Xr1QWkpocw0iCQil5KNnqKOYLiNn+5tSyw8BB6DofiN7bzzdYYgOrbOJgJn0tTc0Mb6zDjVwvhl
	iG2vNUVngA8YKj9UfvHkri1z7YrQtYxt55d52FKmXPSGms+mmR2e4NQ==
X-Received: by 2002:a5d:4f04:0:b0:354:dd6a:a5bb with SMTP id ffacd0b85a97d-3552fe17d9bmr7633868f8f.7.1716892543977;
        Tue, 28 May 2024 03:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr5nxMnM2mRlf7N3yUwwFKa1De13wN1h0z/RthJIuLAcT8t+vQLaUTQHunQnp8n4AqvpoMAA==
X-Received: by 2002:a5d:4f04:0:b0:354:dd6a:a5bb with SMTP id ffacd0b85a97d-3552fe17d9bmr7633858f8f.7.1716892543570;
        Tue, 28 May 2024 03:35:43 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0907fasm11317377f8f.57.2024.05.28.03.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:35:43 -0700 (PDT)
Message-ID: <dfcb505c48ff1571734d7afeaf6b7f747d70d258.camel@redhat.com>
Subject: Re: [PATCH net 2/4] tcp: fix race in tcp_write_err()
From: Paolo Abeni <pabeni@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>, 'Eric Dumazet'
 <edumazet@google.com>,  "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Date: Tue, 28 May 2024 12:35:41 +0200
In-Reply-To: <889fbe3feae042ada8d75a8a2184dbaa@AcuMS.aculab.com>
References: <20240524193630.2007563-1-edumazet@google.com>
	 <20240524193630.2007563-3-edumazet@google.com>
	 <889fbe3feae042ada8d75a8a2184dbaa@AcuMS.aculab.com>
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

On Tue, 2024-05-28 at 09:19 +0000, David Laight wrote:
> From: Eric Dumazet
> > Sent: 24 May 2024 20:36
> >=20
> > I noticed flakes in a packetdrill test, expecting an epoll_wait()
> > to return EPOLLERR | EPOLLHUP on a failed connect() attempt,
> > after multiple SYN retransmits. It sometimes return EPOLLERR only.
> >=20
> > The issue is that tcp_write_err():
> >  1) writes an error in sk->sk_err,
> >  2) calls sk_error_report(),
> >  3) then calls tcp_done().
> >=20
> > tcp_done() is writing SHUTDOWN_MASK into sk->sk_shutdown,
> > among other things.
> >=20
> > Problem is that the awaken user thread (from 2) sk_error_report())
> > might call tcp_poll() before tcp_done() has written sk->sk_shutdown.
> >=20
> > tcp_poll() only sees a non zero sk->sk_err and returns EPOLLERR.
> >=20
> > This patch fixes the issue by making sure to call sk_error_report()
> > after tcp_done().
>=20
> Isn't there still the potential for a program to call poll() at
> 'just the wrong time' and still see an unexpected status?
>=20
> ...
> >  	WRITE_ONCE(sk->sk_err, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
> > -	sk_error_report(sk);
> >=20
> > -	tcp_write_queue_purge(sk);
> > -	tcp_done(sk);
> > +	tcp_done_with_error(sk);
>=20
> Is there scope for moving the write to sk->sk_err inside the function?

Do you mean that the compiler or the CPU can reorder the WRITE_ONCE wrt
tcp_done_with_error()? I think the function call prevents that.

Cheers,

Paolo


