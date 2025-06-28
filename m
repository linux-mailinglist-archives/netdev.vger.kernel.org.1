Return-Path: <netdev+bounces-202113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBBBAEC43C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 04:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A63B4A70AC
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82B1CBA02;
	Sat, 28 Jun 2025 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSG95FTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EE1A3177;
	Sat, 28 Jun 2025 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751078080; cv=none; b=n/Nt7TkJVeMfGMUd9te+LYNXkdyTFhBxw9q/5jP++TqsRiMqhJmGqkNR+6DoqhFdU7yKgHfSHkwCc90PR6FHFfWEcBVOoh9hMZtiE/ribgL/SIRxyh8V/fg6K/64eSDT38yTVCsMTQg66NKhv8Jc5YyiN94rX9BFDF73kRzn5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751078080; c=relaxed/simple;
	bh=bUMjV42AAnUZwQesaTICI2r5JpnBLWkb6qGG/pPC7oo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BL85gW0kh57jShdiMEZgB9XW8oIFp8fXgjK4HQXnkzT1LugSn3FNKlEFyl7Zpqj3loIK4jarnEzX4JzqoPj+asf8Ho3n7ns/2mE01uUizSWhhWf+htLNHqXykxqoe6vpLOGQyC0QriVUqCb194kY2GxEaSZslq28cJHskAdQfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSG95FTL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74931666cbcso3100351b3a.0;
        Fri, 27 Jun 2025 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751078078; x=1751682878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLgSgTS/p6Xn687P1bEfCPfNF/GovvtrQo/hxR5s58I=;
        b=WSG95FTLwjgcEqIIIaIVBNO9AQVMYUoxKmzkfDeU3OdX9tBTKhw6u2Uj+1E/dEg/5G
         PfIk9ir2NRoilPDqqoryWoHNu5Lw5lQ0mlr60VzMWw6OGTxiCV7OFzlsgwRErytWJcTx
         daLAqfemHknmMZWqmmuIm0Kj4QGMyoeDYEKQts77rxBWVCFbklez7zcmhQrio6kBWojx
         CQfXfIT0QjkoNiFUWUKaXfhJFI6HIvL0fZxTSxztfLK5n/DaQRXmos6lkVFAqqRXBAZm
         co5PPNU3zPhJumK+SCwfMSeBXd9ZFQZ3/7cot3oWyadYv0KLqNxKMeEx52FYajDrL5AK
         kJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751078078; x=1751682878;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OLgSgTS/p6Xn687P1bEfCPfNF/GovvtrQo/hxR5s58I=;
        b=bLHP8CSwZJoYKFYemkw7gucS7WE+q4KntAL8iXjz0W2lJsvdUqlPXJ5hqJJ8PMbHc8
         3KAZ44HJx1E2D9JJAPxmtiRzj9BdDLYOtxqn/3m9BQK3VBNrif9HoWwRWNelR4ClBHC8
         jtNZPSj1dSNQe1q4ji1KXOltEtETnSVD9122SXQkpp1aF5MvyKPS/mDCI1oBBDARwz/+
         11/yQ4rXLfPrf+s8ltM6AiOwx+g7eM2XN8aWtTRTPYgKL0GiT54jDNjB33ZQJljA+wu0
         HNjdINWsviMEwhLmILKYPY5KYyIqvkL8WpedQsI+vdmERO5V4d0yfODt6vfu0BnS6EZD
         5E7A==
X-Forwarded-Encrypted: i=1; AJvYcCWr/LbG11dc7i6hPP5P1Rx5zRXnMaPOuqc7r+dfaDBKM2R4K9Q0TMG/toAvHmmQTl8cAtsVDb6s@vger.kernel.org, AJvYcCX5hVKcUny8vlpiwGU/WLvioZfSvVz7h9bSftIuvZJlNSKBbZtoKKtKGmlexkcHkvQwZ4UdTHlBpR+4oCA=@vger.kernel.org, AJvYcCXvki9FhHYdxuqJyBxf/rAGBwUuNbt/fFOMuPa06/g+RuCqZVMQJ1wGiQlvirZcO3AMH5q3I6B0JRe0xGq7YqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSobOz6jf+KUS77ytELaVLgBEkV/ES7UDt/W38hL2itxUuYwcR
	8UlDYUmQ4CyED5chTJO/7eydoEfjsccjcWxH7WL4tS9gtn194QeVfpLAMQEvASwI
X-Gm-Gg: ASbGncv4sNPKcZMSqkmwzHhye2nb70jimhKy9JwgMFjRnXww1uVmnndhKvCEJspD99a
	CmMT3EhPwTitiSxeM00UENRiMkgejFx1oQAmhixWdbm67808KN5p3fdMKFu7PtMp6AoLWMXydic
	jaQeZTnF6fsIOe1iyzDxshoIvMSoWe8XKL03hOTu3nGBR+a/eQ1MOTo1KrZeybvaWUw5LM343Uo
	ML/2bPO705VvFPe++Rx8fIjKK/vDIBmGOAhi89Q7KXm8P7IemBaSieeFF5wf5ErWsozOo6jMGti
	G3hMPX5Qc1X8JKrOrHjI38xG88tte/NXJfe4LwHc6LylLp467Q6v7RjA+/HHaF4PDhOy8HA0PLU
	7/6ZxTzdqI0nyG8jgNQz/xDs4TdezWnB9EWXg6U+E
X-Google-Smtp-Source: AGHT+IGvspN3xr07jKdiZeyLhaj1qvaD3Xxuzu6awzryXExjC9o/hrNWS8AVStdM6jxTUN1fQ+imeg==
X-Received: by 2002:a05:6a00:928f:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-74af6f70cc0mr8101229b3a.19.1751078078362;
        Fri, 27 Jun 2025 19:34:38 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31d855asm2631193a12.55.2025.06.27.19.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 19:34:37 -0700 (PDT)
Date: Sat, 28 Jun 2025 11:34:32 +0900 (JST)
Message-Id: <20250628.113432.912890378716072875.fujita.tomonori@gmail.com>
To: tamird@gmail.com
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, dakr@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] Use unqualified references to ffi types
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250625-correct-type-cast-v2-1-6f2c29729e69@gmail.com>
References: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
	<20250625-correct-type-cast-v2-1-6f2c29729e69@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 05:25:38 -0700
Tamir Duberstein <tamird@gmail.com> wrote:

> Remove unnecessary qualifications; `kernel::ffi::*` is included in
> `kernel::prelude`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

