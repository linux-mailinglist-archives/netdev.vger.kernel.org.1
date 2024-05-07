Return-Path: <netdev+bounces-93985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1728BDD51
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127CD283350
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC814D2B1;
	Tue,  7 May 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AupHgVjw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D46E61B
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071363; cv=none; b=MYd6Gbj0xanr+Aqmu0zGzzPecrCPSSjHaXEHDh8qvOfP/UG+8irnc0bolnezJEUdYfHdLuZRQ9nqDB8LTr10QRjypG77fjOxG3pH4jci9dAL5jZpQD1GwNSLmUvfiIbkLqVVXQ0nX3hLFTRiRWC394fkR1Tx58biqbwWQAQek9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071363; c=relaxed/simple;
	bh=joLZ82/qDlnM3hqNQDbtKRts1WGRIsmAEuypVyS/k5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j0gLZMGhaSI7+KAdO0L3RvXGPs5e51IVXZhzX7ywkjCDPxT4XqspXBAIg0jH6rxUb6XceANg+DeyK1aBsr4AqrxF7B8kczRTys9AQYTmPflZCqWXAG8ttztaeWIXxwYuFvrw1ihpzPNi0UicRVF/vQnWGheM7oNpexmxzFYsm/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AupHgVjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715071361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MeEIcD5RTZy4syRWjHXHQyoYiBxz8Z+MY7de/HdeVBo=;
	b=AupHgVjwrQ82aLrJuiD+86B/G+pzgeDyBuoqK59rYWVyqIniSUq9NPvezjLsL6BtLy+/r2
	S+lt+f8zi1OwB7SPIOok/nT2v1Ndp4ZNrzYtm9Xb53Fb7vOU+4afPaXZ030Sla6VWYnHnO
	VCNMZsVJ4ioKPw7wzbREUHAq3X6iAow=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-NIE4DY4fMDqBD-h3Rmio8g-1; Tue, 07 May 2024 04:42:39 -0400
X-MC-Unique: NIE4DY4fMDqBD-h3Rmio8g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e1d2d29f97so4245501fa.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 01:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071358; x=1715676158;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeEIcD5RTZy4syRWjHXHQyoYiBxz8Z+MY7de/HdeVBo=;
        b=IrE7DqglaRbHMFCrDDXiPDFr9mCefS3Zi/l+DquSYgdwC5AnqkUSTMDHf1H6v34plb
         cUfCYsobD4IImsQBmYYzqOVny371EhuBxz70Y9LTFM+32PHALDRneQYhvYXgNaqQ4zw6
         zaGsxN8JawT2a5XXUk2CzV3ZKSvOiSmgOJaDmrjTmElBAxcpfe8HhdcoP0GK1+LrXkDI
         8FBTeh0n3yEDqdQhmWoWdtyjKyVzMt9DFOfjZCkCqjT6KoTNFpE1MLmLEUn5iPv3kEa5
         6AwO79erin7RknTJ13yYN3edacj3wNZ9a3kDZS27HzgqupkGN+umNILxcdyFUYj8bfly
         x+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZja0p+aT1I9jJ8us1fOFPzgSDvRioRTwnLRdMhlrdvwMBys7fODrmc/3QG3Us5Hel55WbYCcY0bKww0cIdw/dMiJAizRN
X-Gm-Message-State: AOJu0Yx8rSTFx43sRhxBg2s15kyRmtyJi3LM7BsCdS4+HZJSU54bsqQB
	RMan3fFGekufLXCSlEJQ/svDQCTUKtTp0i2rDw+raaoblr/+f1thSrmGYgu1xP1lhXk/WQ8ZeZ9
	tIc76VHbU9H8yc7ay5XYVkdZqLHsnsYlV2Dmp5os1eFt6R/m4yVQYmw==
X-Received: by 2002:a05:6512:3286:b0:51f:1896:be05 with SMTP id p6-20020a056512328600b0051f1896be05mr7822761lfe.1.1715071358196;
        Tue, 07 May 2024 01:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Y56a5xjR2HcpqZeVfq1doUBAZqCrfzjo120onoMM93kAGNY3ZTtOI6x1WtXdxUx9LUN2Ew==
X-Received: by 2002:a05:6512:3286:b0:51f:1896:be05 with SMTP id p6-20020a056512328600b0051f1896be05mr7822739lfe.1.1715071357734;
        Tue, 07 May 2024 01:42:37 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810::f71])
        by smtp.gmail.com with ESMTPSA id b17-20020a05600c4e1100b0041be3383a2fsm22688823wmq.19.2024.05.07.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:42:37 -0700 (PDT)
Message-ID: <bbd6a75b644bf11b82af7fa25a47e4fa20630958.camel@redhat.com>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
From: Paolo Abeni <pabeni@redhat.com>
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>, 
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon
 <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Date: Tue, 07 May 2024 10:42:35 +0200
In-Reply-To: <20240502211047.2240237-1-maheshb@google.com>
References: <20240502211047.2240237-1-maheshb@google.com>
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

On Thu, 2024-05-02 at 14:10 -0700, Mahesh Bandewar wrote:
> The ability to read the PHC (Physical Hardware Clock) alongside
> multiple system clocks is currently dependent on the specific
> hardware architecture. This limitation restricts the use of
> PTP_SYS_OFFSET_PRECISE to certain hardware configurations.
>=20
> The generic soultion which would work across all architectures
> is to read the PHC along with the latency to perform PHC-read as
> offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
> timestamps.  However, these timestamps are currently limited
> to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
> by NTP (or similar time synchronization services), it can
> experience significant jumps forward or backward. This hinders
> the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
> is designed to provide.
>=20
> This problem could be addressed by supporting MONOTONIC_RAW
> timestamps within PTP_SYS_OFFSET_EXTENDED. Unlike CLOCK_REALTIME
> or CLOCK_MONOTONIC, the MONOTONIC_RAW timebase is unaffected
> by NTP adjustments.
>=20
> This enhancement can be implemented by utilizing one of the three
> reserved words within the PTP_SYS_OFFSET_EXTENDED struct to pass
> the clock-id for timestamps.  The current behavior aligns with
> clock-id for CLOCK_REALTIME timebase (value of 0), ensuring
> backward compatibility of the UAPI.
>=20
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>

LGTM, but let's wait a bit for Richard ack.

@Richard, could you please have look?

Paolo


