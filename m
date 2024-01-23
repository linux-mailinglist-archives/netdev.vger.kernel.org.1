Return-Path: <netdev+bounces-65012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4683838D51
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84C51C22AA2
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F45D737;
	Tue, 23 Jan 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6cjB/2L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0065D732
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008848; cv=none; b=k0wQctE3Dnhw6iXahI8xLwxsQhMKwJ3FQZ9ErHShq6KQx346oUlcfe7/Ntbug25fnfuP6xuhDDwrFaUI03clAPrNyWXue/MxlyTjXCnrTU4Uz9JXlyJhf+BNXwtfdj01SmQCj/jg6/za2Rmi8pjVJFerJBhm6k/F2szDTLJkwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008848; c=relaxed/simple;
	bh=3WmOUGNWT+pIH3cj07dWCAKXanhkJc4EVblQcDQpCHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWWB+whrQagTMc1CWXCRbKqf4U9vER3/Lrnj51lRr13XHBtesAtjp1/2ZoZ43yKAHnRI0CZdA9cJdK+TeGeTSnLPfE39bNHmpq8BmtSpssBCwgBRGo9rrq/TYTYgmpc3K6PVVNNMkXDUpVB3iSnpox+Eyy8OviAdkN/6DLF4aIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6cjB/2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706008845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3WmOUGNWT+pIH3cj07dWCAKXanhkJc4EVblQcDQpCHI=;
	b=B6cjB/2LpMskypf6/h69jSGlchax4rOTIUvWpGrthk9H51gFenXp+G875PFEKIGcwyl8f8
	mOJy7mSuo+98VX4qAMLmUq3HJj+Wt4Svr4xEuWZ/FeLGNt03MMcAmnMx3RVyebGMPYIUkc
	HYQD9pqo1NkR0Omw2cWrtclO3p6bc6g=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-WOdrpyBXNq-3o6RTCi7uMA-1; Tue, 23 Jan 2024 06:20:44 -0500
X-MC-Unique: WOdrpyBXNq-3o6RTCi7uMA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6de137d12c1so1562188a34.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 03:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008843; x=1706613643;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WmOUGNWT+pIH3cj07dWCAKXanhkJc4EVblQcDQpCHI=;
        b=K6F6vnOPihcmnULhQ9XwPR2pYakMm3d/pE+qWbTkz3uSx/E+TsBNG6QHRJKwkXOTWw
         pM1rZ5UMA/1CgXBKmGN2pq/ExRTdt5q8ztDbLq+X7h8GyGN1xderPlzdUbZCzgzdyXpS
         JolQ96xijDrwdIxSGw1PfnfAeCPhioaXxLAk7mQx2NV7ArNGlM0lYQozsYEs/sNM4QaM
         22AaJodzD18vrNyWy6DuqNeg4OHnC/BzG0hWUdR41H37wYDULf8ukTomFY/IVITjtRuu
         01gIg6ewfnjjrCVvH7ieHTz40nEyHa61TVHOYW0wDHhAQdK+C3lV/scOo89vdTQzWzm7
         x8FA==
X-Gm-Message-State: AOJu0YxxOucFMQE4or+U/vRCNovRlNrNxlHk6vuwfBfu2c9jjDw+XTd1
	90BH5Mc+v53TLqLLB4Vsgr5QxwRivUy28l/wi3ldYdEKSg4UUFqFQ2aRUyaC8YekD/QKHvFSPCz
	LHqVmoxUVekAxJFFMspFI3hPZrCTHWt+CWVyTiQLeNZEmM5nz5M+/MQ==
X-Received: by 2002:a05:6830:34aa:b0:6dc:6a7:857d with SMTP id c42-20020a05683034aa00b006dc06a7857dmr11412887otu.1.1706008843460;
        Tue, 23 Jan 2024 03:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhC0XJtyC1wujZZKiOikk7SUbsCYqJ34/Qhr6ckzRck2bhIAEJrmOiE0bPr12etnSABf6IOQ==
X-Received: by 2002:a05:6830:34aa:b0:6dc:6a7:857d with SMTP id c42-20020a05683034aa00b006dc06a7857dmr11412869otu.1.1706008843085;
        Tue, 23 Jan 2024 03:20:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id ka18-20020a05622a441200b0042994016b68sm3378750qtb.71.2024.01.23.03.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:20:42 -0800 (PST)
Message-ID: <bdca9e023993b56fef0a6bd1b0bf65b5cdeaa488.camel@redhat.com>
Subject: Re: [PATCH net] selftests/net/lib: update busywait timeout value
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>, Shuah Khan
 <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, 
 linux-kselftest@vger.kernel.org
Date: Tue, 23 Jan 2024 12:20:39 +0100
In-Reply-To: <20240122090544.1202880-1-liuhangbin@gmail.com>
References: <20240122090544.1202880-1-liuhangbin@gmail.com>
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

On Mon, 2024-01-22 at 17:05 +0800, Hangbin Liu wrote:
> The busywait timeout value is a millisecond, not a second. So the
> current setting 2 is meaningless. Let's copy the WAIT_TIMEOUT from
> forwarding/lib.sh and set a BUSYWAIT_TIMEOUT here.
>=20
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> Not sure if the default WAIT_TIMEOUT 20s is too large. But since
> we usually don't need to wait for that long. I think it's OK to
> stay the same value with forwarding/lib.sh. Please tell me if you
> think we need to set a more proper value.
>=20
> BTW, This doesn't look like a fix. But also not a feature. So I just
> post it to net tree.

I think the 20s max timeout is fine.

I also think this is really a fix: on slow/busy host (or VMs) the
current timeout can expire even on "correct" execution, causing random
failures. We had a lot of similar case in the mptcp self-tests in the
past.

Could you please send a v2 with a suitable fixes tag and an update
changelog to point out the possible failures?

Thanks!

Paolo



