Return-Path: <netdev+bounces-171181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2756A4BC4E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDF03B6201
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47871F3D50;
	Mon,  3 Mar 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp4f0Qjb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8F1F2C34
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997738; cv=none; b=Ekuqyr9i/TtX5XWD7nzKv3pgFqJJidCkM9mItzrgAdqoHwPYpWBvDQhQDrBHTJGFm+cKR01G1OLi5xpXLRzFmN0HcV2lv/Tae6ruk4T8qUy2lBitV4IuSfg0vuqrGgLeEyr9pdNiGak3qwW3AAcLWLhDMegOZOx0m1nuqviLGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997738; c=relaxed/simple;
	bh=srl1pIA+ThlTF11L33x8WkwY3Gi/4wZSgcLDLWp5Epw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oR0wJ6l0tPKXOmZPuzcwcXwwbR/S78apZfhD8tkYRb+BBwsqztIOvHZA2LnVMwjMj0z5FSXArWqxI+URApzSpyaykVWCxk4wgPh6yG6bVW1qHUsTcEa7qobIV7Y03ZCLwVSItzP/g/81NgqA81lyyZ4LXUU5C+zemG9YDfxITpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp4f0Qjb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740997734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srl1pIA+ThlTF11L33x8WkwY3Gi/4wZSgcLDLWp5Epw=;
	b=Gp4f0QjbIP1Wn4qm3jDcmmevsaB6So37hMAeZzwwOlWIgDWKta6z0KvKjAYkwcgENOmTHU
	jKhmhF1wL+LUFvqgsE5f+I/CSjVOb0gm8+h+xVNJYaMTJMWsUosEzIV7KH0KeEG3pjvHzu
	g1RJvYPmY7I72t0PHydJ1tkxE9RfHPw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-xnkZGPchMS2KDJEQUh4A9g-1; Mon, 03 Mar 2025 05:28:43 -0500
X-MC-Unique: xnkZGPchMS2KDJEQUh4A9g-1
X-Mimecast-MFC-AGG-ID: xnkZGPchMS2KDJEQUh4A9g_1740997722
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac1dca8720cso58380566b.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997722; x=1741602522;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srl1pIA+ThlTF11L33x8WkwY3Gi/4wZSgcLDLWp5Epw=;
        b=N7hjs3nkUF+Nlcit+38mCD655a+/Ns+145aJ3fr9456r3j8erN1j8uwOovMVlxzb7D
         WrXQCYUxQdrYXfzk+s0QZ7X8E/lPJy+jw37owej/ouP5VKBGQBnbU387dkfyeiPf3tZJ
         ti0CtD9dJQCSgcjKfsjb8g1BqhN/2YrIeVSq6xjrjHgtU1ygJsF/FVgaEOAz7Yu3wsmx
         HLPh0HByG9v1KXmji+SjM/h7QNKq8LY+zf18loSU09TqrS/VBpy9HG1QnM2r6u8ul2yF
         0B5RC62ithaRIdCkI3oz5yCrFIUeFxW4QTx2mfYmoQ8vbEAHrfytQrqToJ4soHZ8j84Q
         konw==
X-Forwarded-Encrypted: i=1; AJvYcCWs0CEayrt9UL1+DGMC3qwLvZ83R580SWvijh1KNesTeHfkPKxzSzKIH3V/stw8iL2211CDRQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhodeOtcgvoy0DWDoth4rJX2+izY/acs+j6hsUWh6L4T4Mq8V
	dUAYy9AbTyidxYOmYVNNpI7WZL9YoJo0ODqBHkga5Ap4or+O2tswmXi3pNOisUEKL3XbNSE4raS
	0zETLqpR9Wz9imDdAG6+htIpFNNKG7uTrvjvqEkuUJK0ebzNAkN4C9Q==
X-Gm-Gg: ASbGnctQvF/MXWHqLmirbnqF41yTBk5niCaSeX7rS5kUqh/et9PxQ03DNPpcSm5uT8N
	g6mC0QCGgLjdnkaKfZwzqmeADA2PNWAqCA7CLalhWSfOEhnaedJteZAi4yd/jldh8hVxIr86q6M
	f6GHw7feDsTQw1XXf0mCdOt4gMZeg2DK69PUu1oFUiSownXdc0F41OXyE3gonV+xskJ4RsrZWTO
	6W+BBAlf/oDqvEM2Yh+WV4m2t87jFwxyWWuxaTGhj3FsqKADzo9JqBoT/HbmakJKlco7SJP42F8
	mjZPVm8b08r2
X-Received: by 2002:a17:907:6a0e:b0:abf:4ca9:55ff with SMTP id a640c23a62f3a-abf4ca9583dmr1015488066b.32.1740997721888;
        Mon, 03 Mar 2025 02:28:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7aUVBrdX1KlvAg+sycMlUbpc7AuA9RpLTN4rd3uI2Rj9vDiIS1Rku9nxqomui03mBJPMx3Q==
X-Received: by 2002:a17:907:6a0e:b0:abf:4ca9:55ff with SMTP id a640c23a62f3a-abf4ca9583dmr1015485966b.32.1740997721466;
        Mon, 03 Mar 2025 02:28:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1debb25adsm77555966b.106.2025.03.03.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:28:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B0A1F18B6F1E; Mon, 03 Mar 2025 11:28:39 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Michal Ostrowski <mostrows@earthlink.net>, James
 Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ppp: use IFF_NO_QUEUE in virtual interfaces
In-Reply-To: <20250301135517.695809-1-dqfext@gmail.com>
References: <20250301135517.695809-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Mar 2025 11:28:39 +0100
Message-ID: <87mse2z9uw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qingfang Deng <dqfext@gmail.com> writes:

> For PPPoE, PPTP, and PPPoL2TP, the start_xmit() function directly
> forwards packets to the underlying network stack and never returns
> anything other than 1. So these interfaces do not require a qdisc,
> and the IFF_NO_QUEUE flag should be set.
>
> Introduces a direct_xmit flag in struct ppp_channel to indicate when
> IFF_NO_QUEUE should be applied. The flag is set in ppp_connect_channel()
> for relevant protocols.
>
> While at it, remove the usused latency member from struct ppp_channel.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


