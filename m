Return-Path: <netdev+bounces-241696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C394C876ED
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBC03B2EB9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8EE23B61E;
	Tue, 25 Nov 2025 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOZgCHKn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o6fb6fQy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AD1096F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112284; cv=none; b=Y2CLrP168DhK2xc/CpO9p9/rSJVEEpBnmXvH+EJpMnRN5RmnpYq2ZBvJUWlKG11HjD5tZrw3/W+GPYQB9We0lKedkLJHp2F9AilCK93Fid450lMZk3UdPuwfQHiM0tDWgLo+T4FvQgx7UJ/gbWB8rhnY00PTcBUyiSvJyEuxCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112284; c=relaxed/simple;
	bh=rX04XqDqrjwBIeWLyVxJ0KJGbv/vLUvUan55tCGyyGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUfAthL2IRmzpI4ow9XZkwu7tRvlz+MlNdS6EKLdk13e4r0GWxpgsAGNYQOPIhisfXXlIwVFQJmjtYd4/dVXEuvY1JBRxaL90wKUKi+7zkae8LSunEOd6hdnj+khIpZgJdvqsxfLFfmCUKwSG6ZPb+EO+FZ+4VLUtF7LCSVHm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOZgCHKn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o6fb6fQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764112281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rX04XqDqrjwBIeWLyVxJ0KJGbv/vLUvUan55tCGyyGg=;
	b=bOZgCHKnyjh3xOkU2Mega8aHF4smMW0jHIWy+fZQ1mPD0GsRTLr9iDVgUktvR31Vok4mZs
	J83vMyyT6Dl6lsHsv7yECKEp570PxvHjTpKDhjrGWiffhb1AuHSmFcCzQfTerr9oI63iTn
	EUctxwboFZWUlQxds4UhtbwyUJ5/4fw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-iy44qeoTP6eBaxeQGieksA-1; Tue, 25 Nov 2025 18:11:19 -0500
X-MC-Unique: iy44qeoTP6eBaxeQGieksA-1
X-Mimecast-MFC-AGG-ID: iy44qeoTP6eBaxeQGieksA_1764112278
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64160e4d78eso5804155a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764112278; x=1764717078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX04XqDqrjwBIeWLyVxJ0KJGbv/vLUvUan55tCGyyGg=;
        b=o6fb6fQy17ivD7zlGeH52T31R0uugWjl8VzL4WQ96wLUooVUMxYkEefPI+XGyjJgWF
         NIO2aYjNp3k8l3dhEV7yxhyMSlDck6Py0TtRk172vvNp08/QaJzWthMS6WiWMtfrSiGZ
         lGni/NXUDpBPOlGauXwLrH17rvhK5CEW5uRZtpOk1Bk4mPcpFv9o4nFdzG+2RtBE3YRE
         dI4HWIftrrMTodJN8wSRKdBTDOrmLceVmEskHw9bqhGGL8fVOFDZ5dg8YtzAMZbp6xWl
         8VB5o4u9MJxJB2tioF3LAJpC2fRGgCPrh8Ag4mCHd+nNyySK8MAIRnxwfsmEsB3iL0O6
         O1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112278; x=1764717078;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rX04XqDqrjwBIeWLyVxJ0KJGbv/vLUvUan55tCGyyGg=;
        b=ZcBwI6b66Al9fH5m6oMjozZ+Ufcgi55++/elJbqTbz0x9XJCG2E0RO2ALnL0zCSkVN
         Ys7IbS2kgkZtQvlX88mpq55WoPXbKICs8M36QGcSRmHYL+kned8YFV1UIyjz4QW2/Pzt
         dRJeN5H4jiMXIPelMWYb3jKaLPb7S0jQwRYGQ43Va9jLlxvwCz87w1HBxUKzCG3ZInmL
         uO/k22EbyPgM4yD2IJhueLRj+ZYsTVRjntgWYgoKxvaTr50+PY518N62yX2g7y60u/92
         8fXkSCUwDfGgNboGObSWwCVu6vXdmhrAZyz902JKQr9XkIy8baiBdeN69NREKrYPUas3
         GmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmW3jCaZ3D/RyzQ9DTHdZBhlh4j2XOGuFYs03r2+Rr4p6cjCQ6Eybes8mvIHahIfXZ11b38do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFAokdGx+ZA8jKa5ay2ftDlfLOJhbw/xJutRiNX58OdbcKUx2
	U65LQbUoI4T6ZObLulia53SfiWf7hPH7yBr88TlgyhXnCpSnXA392ika3b9Y4qeGrtUCyxZfRiO
	hJDGe/98P36K3TfMyuu9fqB1vAww4rz9lXMvQ7K7XjQWqAoN8fM/wg9arvg==
X-Gm-Gg: ASbGnctDk1ZYPL/ZCMHqpHBJfHSlp4Zo9DthiZly1wIUJ4uWUx4TYoZgw6uIs7Aoej9
	s+Veb+0UYm5lHmya4LSpdJq+c/s+rmvGKfibYVp1ADlT8Ufh6Mkn/Bf4AjGj68G6u1OEhGbHG9c
	cwHMI3a+FEK94p/3/0AeDHaPiEr26VnQcsZqfVi3WlOVVo7HX2KYeS9M0vZIbVuVJe7BtwKqGi+
	op4nokVsnH9O8SfBFfksVMxDP/C8pp7RfLyn2OXpiIJW2caDinUPkLBWlCm0OT/Fhc7PnK4wvP8
	YY+W5GKdosTEPCMTkXva3HGtOAhTwrfWrV5aRiezchmlFFewiD7orNzonxAbsU8BvBHyYMtRRna
	iLI++BN91KwXZ4Bo7yGCS+HJNZCMi+94RtZ8y7/GZRzksb3DqXA==
X-Received: by 2002:a05:6402:51d3:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-645eb296952mr4030211a12.18.1764112278364;
        Tue, 25 Nov 2025 15:11:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG05d3nf64r5NRrucKHNMG5yWYKdt24zcAeoaIDzeEKhv60sm/iEX+ltNr0nnHxfI7gsV91ww==
X-Received: by 2002:a05:6402:51d3:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-645eb296952mr4030183a12.18.1764112277953;
        Tue, 25 Nov 2025 15:11:17 -0800 (PST)
Received: from localhost (net-130-25-194-234.cust.vodafonedsl.it. [130.25.194.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm16232000a12.9.2025.11.25.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:11:17 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC net-next 0/6] net: macb: Add XDP support and page
 pool integration
In-Reply-To: <DEHXIE1SLF7P.3OFKTXSVLN5M9@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <DEHXIE1SLF7P.3OFKTXSVLN5M9@bootlin.com>
Date: Wed, 26 Nov 2025 00:11:11 +0100
Message-ID: <87zf89k8s0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25 Nov 2025 at 05:50:25 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo,
>
> This is a small message to tell you your RFC series hasn't been ignored.
> I had been working on the same topic for a while, I'm therefore happy
> to see this series! Will provide you soon with feedback, but of course
> there is a lot to cover.
>

sure, thank you Th=C3=A9o!

> Today I managed to:
>
> Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> # on EyeQ5 hardware
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


