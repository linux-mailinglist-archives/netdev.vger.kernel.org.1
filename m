Return-Path: <netdev+bounces-155801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C9A03D1A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A07A3156
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED715886C;
	Tue,  7 Jan 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGnjDHjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0381DEFD8
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247431; cv=none; b=EDJ6MekwGJZaX0wh9+i3rL1Wu1S2AQ6GuyPRSF7ylwvZA2T9z10PhI19YJWrbXDnbLn1wa2NM9R7TfMhnRfiDKbHt6bLg3X4Pk+fLpeBxqdEBWpPY1D8BRzuCnUY6Mn9PQ0TaL+Q29qMeQRpU5SQwDdC2N1dbktviqgpMRUKjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247431; c=relaxed/simple;
	bh=BuBx7ekn9yG3h/fuD4BMMqSSJfcKI0CQskBpBzuEQWI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=uNnYD9LqyYbAd/kNx8DhZhFUXtw7uEaZXKnLonMHBUyFLX0Pw5h7J/LdjpB/WtdXcNJuxDthp4GBrxbFUUoNkys3W7YjiPCyFIL9yygt+W6x1jP7U9VeQVcSUHKQ8qsJAbwIeakq2wQT1m8Wo6ae5OCdDqUmkRyHqsy2PKaVbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGnjDHjz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso106447815e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 02:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736247428; x=1736852228; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuBx7ekn9yG3h/fuD4BMMqSSJfcKI0CQskBpBzuEQWI=;
        b=EGnjDHjzbCVVzN++740Mc9kvZZxDIlbqIzVTY+9jRrvxvl+KuOFS0uXSjgxdJL4xo5
         CjjXu82XIv7A8PGJqewUV2dMQ2G3mnjxTShLqBRVwKrMtcpiTq8yiCy9fiGDU0Xar/Sx
         uNwj4FAb0KcFRhKkc3XobIH9MQIP4yXRpKiYK8lbmZwBYLTpdjGSOti/1hcaS4OhQ777
         2QJF8LKp7w+kLk1Iq3liTLX4SECFa5uk7q9K6detL1H3FlN0ymYW5ERiI3Idl+i0cx1k
         acH/CZxqscmu1rqsY2CHzHSk10CNt7wcRdIXmuQYB4chO6mJI7Fo4FWlFJvkS2elZW9R
         KX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247428; x=1736852228;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuBx7ekn9yG3h/fuD4BMMqSSJfcKI0CQskBpBzuEQWI=;
        b=Ddt+9XXYRn/zqRR5ct94hyTdy/OazC7JOR71riSytIE87p9tlAd41b9ZmtEOl28UNJ
         L6yV3iRPLX17hBgZjvtxUTzPgCzGyNm/yRWMEqluSc1NKx1GfFMU1WsaUl3jqh7nh+q6
         wHHtdCZ6HOnuP5PNh/8iTd2FdIVTYgxVZMikmO05x0dMmDgSp0AHQrQd8qqblIsHutO9
         hf5dkZ/03nMjjIKI23WRx1wa1lLdlXvliLr/prtxGvshwS6kirV49K4X2TJKqJhXHYvn
         z2jK/8Hxkyfpsv+ZwL9gLgs99vEoQVIAgKrhBcujcH4bBKMHY4PcYue7uULjhNBWj+jw
         5g5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW30SU9+oJ/BVWnwWB2w6Q1AHzY6nLN3elDZ+vAoP6Q8hpgaJl8nQzaLwwVWuIZl7KLEpF7eSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINzH7L1MeNo7C57wL1fOsN1fZb/UdamlottTxQJytoc9ac0cO
	kTkYFvWtT0oTRlxdV+Buup4IZ4z6fhDA3wykb5EVMZJN3l3/jnX1
X-Gm-Gg: ASbGncvOylAcgV0pMhsFydCqbLviQ+k6smE1pibXw5NAuGPZnhUQiDqjzy0nxwAzlsZ
	q8op+Ab+nZh0SwH8MYc4M4uTlK0NyxjJrz8e/QOgHvd1qwGUBn+OD9VYUN8vHCnd9VYxgvDV1KW
	sbjQVilr1UXPycHzxec+OHu/FXUFYAq25fX+yK8RVmc801MBMo/wHOks08lYF+f96awVqQJXkEq
	ZVW2/u1of0pQvU1BDYAwPLWOFDePEvlNMRkhVGNHf/gHM72usvRnv5JNf48MQG47KRM6Q==
X-Google-Smtp-Source: AGHT+IEvYlmb98HJnhgjVES/hWH/tQaB1TQWfKTl4TP4nIRHBwD1UvcvtyKmTtqRNdjeL30vDLYLOQ==
X-Received: by 2002:a05:600c:154c:b0:434:9f81:76d5 with SMTP id 5b1f17b1804b1-43668b49a47mr489105585e9.22.1736247427481;
        Tue, 07 Jan 2025 02:57:07 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f41d:e2d8:cf04:aa2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6cbbsm627316145e9.3.2025.01.07.02.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 02:57:06 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/3] tools: ynl: correctly handle overrides
 of fields in subset
In-Reply-To: <20250107022820.2087101-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 6 Jan 2025 18:28:18 -0800")
Date: Tue, 07 Jan 2025 10:53:59 +0000
Message-ID: <m2jzb6nbco.fsf@gmail.com>
References: <20250107022820.2087101-1-kuba@kernel.org>
	<20250107022820.2087101-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We stated in documentation [1] and previous discussions [2]
> that the need for overriding fields in members of subsets
> is anticipated. Implement it.
>
> Since each attr is now a new object we need to make sure
> that the modifications are propagated. Specifically C codegen
> wants to annotate which attrs are used in requests and replies
> to generate the right validation artifacts.
>
> [1] https://docs.kernel.org/next/userspace-api/netlink/specs.html#subset-of
> [2] https://lore.kernel.org/netdev/20231004171350.1f59cd1d@kernel.org/
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

