Return-Path: <netdev+bounces-224878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7804B8B2EE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11DD1C84FFD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E12853F7;
	Fri, 19 Sep 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVWP0/yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168B25DAF0
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313341; cv=none; b=XxvApXn9OnhBi6hvTjl1cbZBbQXzzdYOwRqv80Dbls5++ctpxTG2SNXP45E1wQu+kkRobcCdSXSGpa3gM/nHOh2U/7gs+SxBHi22fiAIDd1N0leFhcf9jFXPLM5bKG9C+AEgOobYfNEK+8C4rb3Tsmc7ZyiGwjXqorJlFmDxKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313341; c=relaxed/simple;
	bh=RgwiuY3gWTZmdM2pnAr6zFGdZRnLuqav1wWVEBWZFUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7/Woy+H1xBxb1vQfSiRoyHSAfwP6djP9XV5U8uPjQ8J4ZNDOZTooo/nuWmS7CxBDyElU/Aq+/6yuTPxJ4vp9+PE7YjYfRnEf9xFEx6Q/UhYkC5+dWL9Bd24GCX6SYFdpSjmUx0amWuznc01o274Jj8thfaFFl8boL6c4RImHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVWP0/yk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70ba7aa131fso25100926d6.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758313338; x=1758918138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3SLabrwkBWh6hxuZMDgN2pULSHyTTHVs+weWx2op5w=;
        b=HVWP0/ykWLA3PYX9Xn3fMw86bSL4axu6j93cjFi+0Ln9adYJhhRhFvoM4sKHfJTX4+
         mCP/21Fj55PQs42cseYc1ElLKZeRXr0Z27I/uP+pDTPQSCC9AzoW9kRyufNdiFmIO9Fe
         fX/vowpXUdlYtcXyXuuBhxAuGS3nrQVwXnqLOT/GozP3Ib24rI2g0SW0LsTC63mxNM2o
         9jWSdyNPGVXjryvHOtgCtT91Z0J3J/5g/RZRS7kkdPa1zYuywjNgbDLurzSJz+og3hYV
         BtDofG0YLM5R+cUgJimRnshnVR5VaWpLlmAMCpSgAho+/ankRH7D7msGQcc8L17k+Tm1
         jz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758313338; x=1758918138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3SLabrwkBWh6hxuZMDgN2pULSHyTTHVs+weWx2op5w=;
        b=hYMJEppveWcK6AXMYRM/EaBtkSFtvyjDMZpgeWC/l1nZfZD9e9EDqUMAGNPe0o4SN+
         dPyX3MR0KnQBPo3N5t7B8F+MBkfY9geKZTBPhWNu++yY3/Q1/bdRPCipVCrwsegqPMTH
         W6lQtkvMhum666k3SIDqMdRAtxfBJ0ES5aGBSXetuv9LwLKMQKRQbmcwD+hrEmYntuqD
         AVhLdCE/q6CSMjro6WKoT0j341+i5SuYl7eLG4KrOD8sCOrwZVkZgTSRj3i12r8D5njB
         3J4JhrjAk7KKeuVVhiUfPMcakWW/3zbnowvoV8cQ6mDnPwMjYsQTIQxdSrreKtPkmWq0
         cP0w==
X-Forwarded-Encrypted: i=1; AJvYcCXH+6YfEZhaIH0zAoNCNgVKiwhcpZNbV1iXrkg7nyRKUEzTM0BYwl98+PQU0LI4Z4E6Z1ya+FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoteNVmFByY+qc3G/itLT5N3RWN2oF5Dm1ZxlOxzBDb2gmheAG
	ODfUfDBbneaY72Lg0f1UDFH5x45TO/qY25s2zp2fUMmpe9orzdiX1RPMYv8MhnJkjLwwW1q73/z
	dXOKQbK6bKHInPIKAi1yTaFxpM7pCE2GsTQyjm3HK
X-Gm-Gg: ASbGncsXkHYv9xgvL/L+3yWFMcrkvXlBYSzDzxPYJxlbLif8Ac/g3Kbj6gsJvYFwRnb
	tcRHtx9tY5KvrXa7vLtgAmQcAnMHuANJzU1keT+K6RQVlzANQ7aavQKYWM5RZ1v6WaOZB/azHgZ
	MyX3qwD0hBW+FeTurV/0H5tAC09YmUbIg49TauiAkszNB72LmcyHShV8beUlCsXulW8eydfxIHt
	VXnSQ==
X-Google-Smtp-Source: AGHT+IFQCqn+0aT4L8isR/AOEauzkR4hiPWxIetKDyypaeDv1QDq5i8E6kyyOmaVnIRCuZF0LfMe4D7n2gflCBd7/7I=
X-Received: by 2002:a05:620a:4e89:b0:829:716c:4f61 with SMTP id
 af79cd13be357-83ba50f5720mr450335185a.29.1758313338028; Fri, 19 Sep 2025
 13:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919164308.2455564-1-edumazet@google.com> <20250919131607.66e74a10@kernel.org>
In-Reply-To: <20250919131607.66e74a10@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 13:22:07 -0700
X-Gm-Features: AS18NWC-zs_t6-UFDWEc1QTnIAjl-ScDHqIrNnUdYP_6IiA7pOCH3deG2OGVRoI
Message-ID: <CANn89iLwOEibFLrkO33OkyhLc+NaMaMWkTzvBrB7gaWMY-a7Qg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: remove busylock and add per NUMA queues
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 19 Sep 2025 16:43:08 +0000 Eric Dumazet wrote:
> > @@ -2906,6 +2912,7 @@ void udp_destroy_sock(struct sock *sk)
> >                       udp_tunnel_cleanup_gro(sk);
> >               }
> >       }
> > +     kfree(up->udp_prod_queue);
> >  }
>
> CI lit up with memory leaks. Looks like IPv6 destroy needs a copy of
> the kfree()?

Oops... quite possibly, thanks for letting me know.

