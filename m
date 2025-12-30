Return-Path: <netdev+bounces-246342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744CCE96FE
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 890B03030DAE
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106222C237F;
	Tue, 30 Dec 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyWm6VlR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvUlh0rJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DE29A32D
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091234; cv=none; b=SeDF/HHCwqTOS6QBOCzhie8e05Xn0sgHg4dQaHmi30Abd3XYfwF/e8f3YrT04Sdff7cHueLTdqjf9DwbgNTr+63TMjI85euJf4x6V4nsSOuxREMo0J9WCE1ICAu+IkyO3Mssc4A5GbaygzbGaj5xPZcNOz4ZBJXhOYM1/xgzvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091234; c=relaxed/simple;
	bh=87tBszBBmgtC8Idw2n7m2p3GwBU7qIQ/w4/5FPRwImo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix0QquyqFn1pR/1eLgg27x89bMOcbKivVXF1KDuqxfT0L1DxjIhqhNFeRewTxuNLWGs86iIfUwVG1Na4yAjHIgn4JmmlpLzQjhICPxRw9EDvhdSGKJ/P2WvE6cCkYE6MG3eLWHa48DWsyUwK4fKyqKkXZOA8QlEns0MGVO+u+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyWm6VlR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvUlh0rJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767091232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmpAtI7HNajU2rnUGpstLYFrWBgny2fAjrQvEOTx4Ds=;
	b=FyWm6VlR9C1id8wZpqDmgtoPNA9WJJP/0xkH6aI2qEAK7FZrNW4b8JQD3pcznqkWzpNFfw
	9vWyQNZ8SUjm8s6GSdop5MF8pn22s5xQKJeJcAKvhbQnwsaHP8xb410xIrBDsrsmLq4V5O
	xuJLroKZW2vT0yLqiLmJqJVn2LlHw90=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Gaj2eJIdNi2270PlMzxMuw-1; Tue, 30 Dec 2025 05:40:30 -0500
X-MC-Unique: Gaj2eJIdNi2270PlMzxMuw-1
X-Mimecast-MFC-AGG-ID: Gaj2eJIdNi2270PlMzxMuw_1767091229
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-431026b6252so9431445f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767091229; x=1767696029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VmpAtI7HNajU2rnUGpstLYFrWBgny2fAjrQvEOTx4Ds=;
        b=LvUlh0rJT0jwmavuwb0dVlLP5nvNg99baybS1r91wRGW47ITASYd/16oP3ZN8jy0JV
         6BUc5D+0QYvHVb+nE3xu1/hupKoctLdyZ3djcY/ng52EO31AA+fIKDAgH5QxQSJOVjC0
         3CatQygSyyM+KYuGpBvhWm6qf6SsYTH2uUkYFDGN4fo2w3+A5FizuBQAcTmAQY2Um4kZ
         moDREEvdjIdSemBrnyMmfBMcFLOSxQdL15fT4/86ftphgIyXezxL8fbJpNjtRJJwG0US
         COLF/cK/YRTXvikl9hytgv5J0kadMTJs0o129y8iXk2SgLl33FxrjRqD7dvuo2um1DJS
         s8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767091229; x=1767696029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmpAtI7HNajU2rnUGpstLYFrWBgny2fAjrQvEOTx4Ds=;
        b=phfWZKEelQLk0G+VnJ6UMn1UdhV+XiLves25IQMaJlcVQnOmiUKI7djAepkud7R6v2
         eUi9rGLpguzvZhbpZsyaEWwI8lEalZf3y9svXvMaw+WINFSbhW5ZyvkYGfvcUukluYN3
         Fq/je7Y4+OUYsPotCV3L08iaP9csjP7Nt2BAwOGfUxzs/IEY4qRxEj3OvMFupFi+gDcf
         kdxCejqthqarKF9kkNWeVrC8oUtwPfs7UhyXnN2HES0I/e/Og409l9GBI3zzA1NWFjUQ
         foCnUIr4uu5PUpKqbUhZqlrRXnCE6PGt2VwcHE4q05LFJbK2tk1Ek3sn7reEC1hmZxrF
         vVYg==
X-Gm-Message-State: AOJu0YwwkUwQJddk+e8fSOWmvdZv3820MQC7e20a1e+5F7VVSZIj8iJK
	jW8/Nqn6CopLcCFffZx9vZReKZUy5fgO4LGGLxfDLX+M2gX2QqwfI1lypCqqsXZz/5CrcC+bYLt
	133XpYIQAZYZAfMiHvnF9TC8lXMGcZSAuE8P+g9F6hW0OEONjZ7w5T0c9Zw==
X-Gm-Gg: AY/fxX7gvI3SUG1/0n8hyCf7e6+rWRRA4e0butNfg93DtZUEMUhcMmRqZ+ir+82JyoD
	wkT4RmqyRU7o88iW/lLZZWHZlC60flgwxfXetGwFfUQaH2lcuPBvQWuS2pFDm0unl7pJbfDnGvg
	mqxWod1AtpwcGFbIdEC6N1LDFKiZuqtTCrqjwHDzBnw4ZDMkPjtbCHGDSSi7vy2v6+15Bu4vwzt
	YVTEJ1la2c25CdFXRHykIs2h/0p523lE0enT+MXCn8voQSejE6ZRxZUYNpUNQuMO1aSmSr/zFFs
	ZOOKQH9d5rlGtunbHTXOME95b7EZV6SaWkFri05n/kxe/ARN8S0tN3gA+IEsS5eFhVGStVBwflM
	Jmreea/5iLZRX
X-Received: by 2002:a05:6000:2902:b0:431:8f8:7f2f with SMTP id ffacd0b85a97d-4324e4fdb21mr32991020f8f.34.1767091229419;
        Tue, 30 Dec 2025 02:40:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHod6TjYZ5kG7LXpsr8emcE2y+xSFRQY9/4WjR81R2ql5w776p6X0PQdjwwLyzZ0LZZR5XD/A==
X-Received: by 2002:a05:6000:2902:b0:431:8f8:7f2f with SMTP id ffacd0b85a97d-4324e4fdb21mr32990995f8f.34.1767091229026;
        Tue, 30 Dec 2025 02:40:29 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm68260811f8f.28.2025.12.30.02.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 02:40:28 -0800 (PST)
Message-ID: <44fd3760-5a01-43b4-ae68-31e6d3c18dc3@redhat.com>
Date: Tue, 30 Dec 2025 11:40:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: net: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross
 <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
 <20251222-cstr-net-v1-2-cd9e30a5467e@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251222-cstr-net-v1-2-cd9e30a5467e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/25 1:32 PM, Tamir Duberstein wrote:
> From: Tamir Duberstein <tamird@gmail.com>
> 
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/net/phy/ax88796b_rust.rs | 7 +++----
>  drivers/net/phy/qt2025.rs        | 5 ++---
>  2 files changed, 5 insertions(+), 7 deletions(-)

It's not clear to me if this is targeting the net-next tree. In such case:

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


