Return-Path: <netdev+bounces-162449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18674A26F55
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C37C3A3200
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE5206F3B;
	Tue,  4 Feb 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcE4HzDd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA3201267
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665056; cv=none; b=g09KDpZE4m+PBy0qPoFa+qMf51RSo/GNZSFv4OkFkqemd/yPgV9j+Z0Kp/NC85VwbcajomgB3QS/MzH8RWkl5HsnOytpHrlSagmVNShSZzM2C4h1GcL9kfSQm3GLlO2NR6UcmfW5CkTbizG/POvh0mQ4mBiJclWliT0uoyvdDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665056; c=relaxed/simple;
	bh=DzOeXlA9QGnJsN3xx4znIgts1qjfECutINZtHWTcjts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jB/KDfH9J7oip4zoIWGr+FDBYr54xqO8TG+LyrpHY5X4cZnvhFf0QANSZpkCaoxp+XHlMcgPNvdNSaiEN9T603UxzgWBzt2Cz7R2BKqqtbwMaQuPwlwVViqFUmBF+J/cj5/XPqwfh2pYDVli1XPI99Wfx+X5h676gZiNqc1ciyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcE4HzDd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738665053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzOeXlA9QGnJsN3xx4znIgts1qjfECutINZtHWTcjts=;
	b=CcE4HzDd763yfkP/fYhHkKGcp4vIMZmm6BSSG7IHaFXrhkgJ9YCf3rtkF96h79lZfZ20P+
	Gz4rob94oi1jwuyLdRcWlm93rjTaG4ZjWxK/LmqESwz6N+DKSSmwtetLm2iLi19OzPHsXO
	E2BwjnE+ZYaYzeMRJTUoh9DLK4f85FM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-lnnqlM0wOASoSGyTLaLp6g-1; Tue, 04 Feb 2025 05:30:52 -0500
X-MC-Unique: lnnqlM0wOASoSGyTLaLp6g-1
X-Mimecast-MFC-AGG-ID: lnnqlM0wOASoSGyTLaLp6g
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30790542ec4so23769931fa.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 02:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665051; x=1739269851;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzOeXlA9QGnJsN3xx4znIgts1qjfECutINZtHWTcjts=;
        b=gikYzgU9UwynkgNjGr//LmLURNEt3lKyaQoxwXd8KAwroSYl1X23rOVcoHtc4LePC9
         lFKCNXsOfS511ut7+5O7bIhqEKOe6sYQk2RIyZD5SOgfbSUmRS3grxVZFnvCJt8U6nCa
         M7WMunQWAuTNa7ezUclNNq51dLh0TKJstCITkp2YlRNpzN8b0e7N4rFIEgqDve7pVSQf
         6VaRLBalqRxQfwsUOByq37PjlAgle47PRwW++8/+1YgxqXdy9okmFgfePlZ+nNXyg8gD
         wJ7ychud8gX5QK+xVJNQLiDhfNecSuPI2aVXwDFSLF0OGalVUDoxrSgrFtAc1v/RZ91d
         YWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAGBs+Au3ebpf3hbeHebWkYXxCFzYf9SgHxpeewaRePqzE5iAxDUIM+HI7hYHtywJX634DRgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+ExJpw1GGdt+pMXwXScDi24wWc2c9xLS1Dci6123ruBb+b5a
	ppA3pFcZaEif8oZcCOa6kj8FSMyOmWuq+G1AUVeT04/sVrLGlCMpFx+jnytPg1E1QLd4bkr9pt9
	B1SqUeGk9c0KVCHTCzK0nshOSWMW/X5DX2rfNmCgo11j6TdY0C5oVNQ==
X-Gm-Gg: ASbGncsulaUcRyHopgAcDGmhds0mRhUIJ+Y4gxTEn6u23piPansbvOaK5mBYpwRxqGk
	rqEvjp9JmlwakoQrrbJV/70BGOHNvt3gvz38R6pqPr70cPUdPu72srfZjROgKkytJ6dW3HsVBeI
	/fZax/nS2e2p9K25rqbTwADo8Zjfz0bszB8+gaCPI9+q9USYS5/bxCmZlwKsNEzymmTw02adjCc
	t+8avMe0/OjgjsOhKlYYONF6Jk4tnEFxZDWCP6FTqEVBzxBOLhv0E0H10dioN3/atgWqBOG4pAH
	hw==
X-Received: by 2002:a05:651c:508:b0:300:34b2:f8a3 with SMTP id 38308e7fff4ca-3079683f4edmr82432701fa.13.1738665049464;
        Tue, 04 Feb 2025 02:30:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4Jr8lRSWR1CE8sbYphxtm3lyFg5Q14w5pLzz4kHabLFdaegw4JRHGdX4X4R5wPp93OaJ65w==
X-Received: by 2002:a05:651c:508:b0:300:34b2:f8a3 with SMTP id 38308e7fff4ca-3079683f4edmr82432271fa.13.1738665047555;
        Tue, 04 Feb 2025 02:30:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a34282a5sm17649061fa.102.2025.02.04.02.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:30:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 68570180BC39; Tue, 04 Feb 2025 11:30:45 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
In-Reply-To: <4b9a6e08-df15-44c1-accd-8f157c62849f@lunn.ch>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
 <20250203143958.6172c5cd@kernel.org>
 <4b9a6e08-df15-44c1-accd-8f157c62849f@lunn.ch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 04 Feb 2025 11:30:45 +0100
Message-ID: <877c66ypbe.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> writes:

> On Mon, Feb 03, 2025 at 02:39:58PM -0800, Jakub Kicinski wrote:
>> On Mon, 03 Feb 2025 18:21:24 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> > Network management daemons that match on the device permanent address
>> > currently have no virtual interface types to test against.
>> > NetworkManager, in particular, has carried an out of tree patch to set
>> > the permanent address on netdevsim devices to use in its CI for this
>> > purpose.
>> >=20
>> > To support this use case, add a debugfs file for netdevsim to set the
>> > permanent address to an arbitrary value.
>>=20
>> netdevsim is not for user space testing. We have gone down the path
>> of supporting random features in it already, and then wasted time trying
>> to maintain them thru various devlink related perturbations, just to
>> find out that the features weren't actually used any more.
>>=20
>> NetworkManager can do the HW testing using virtme-ng.
>>=20
>> If you want to go down the netdevsim path you must provide a meaningful=
=20
>> in-tree test, but let's be clear that we will 100% delete both the test
>> and the netdevsim functionality if it causes any issues.
>
> Hi Toke
>
> What are your actual requirements? A permanent address is not expected
> to change, it is by definition, permanent. Could it be hard coded in
> netdevsim that the first instance created gets the MAC address
> 24:42:42:42:42:42? And maybe to make testing a bit more evil, keep the
> current behaviour that the actually used MAC is random, since that MAC
> address is not permanent.

I believe that would work, yeah. AFAIU, we just need some virtual device
that has the permanent address field set at all. I'll check with the NM
folks and respin with a static value, assuming this works for them.
Thanks for the suggestion!

-Toke


