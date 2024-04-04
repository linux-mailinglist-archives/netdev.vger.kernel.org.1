Return-Path: <netdev+bounces-84877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C371689882D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276882943B8
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1790745C4;
	Thu,  4 Apr 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UL7h4T/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDF535AC
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234830; cv=none; b=o2hg/r/YVgfxYVBdZwowhCJN7+9dmyYqibM61Gsho1NTrPw577Vngfh8AlRR1QNWnD20V4zOWSOUQdXa9QCc+Dpq0UY37wPdTjWblzPgn5chqHWwNx6asMk5EKeyDwKotZcJTVWKAYi98iHr9wAEYAX7CVz+exWz86a7+ZijT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234830; c=relaxed/simple;
	bh=LKX7vVNyqnnyjHXxmLAOtau0jOrACCVSiJJ7CZT6tc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMFT+zruMgaqbdgoWS2iQWRrdZbWHFukTp4fjQcr/FRefTd3ModowmdNq9ymT/S3xCr3QbJgxvzCbUlcbo9wgoENA2nnZjhcWBKHtGt0hBCN5ULkSqAnUhpM8vr9Kufp+/f31cY5c5OTuw6uI2roc224nosLOETD0x7KOs+eRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UL7h4T/O; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4daa8466d6fso111844e0c.2
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234828; x=1712839628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKX7vVNyqnnyjHXxmLAOtau0jOrACCVSiJJ7CZT6tc8=;
        b=UL7h4T/O0Lx41kWnx+2mfQhaonmBn+SgqIf7nMnevAvzKClKcdef4gze0prGteprf3
         OTlDWUk/Zwk3fyCHViWQYSCFShtvxFZQaCBvKvmCY8hftc8mg/TPvEj9wgyC+B7lzDNv
         rYx0BNBZR4CeOsVQ8lr3xhYoJLbgyBJhTYSkl7MfUBkD4qZlr5TesKsGky/TLQSYr3m1
         zOaxNcOBuEONg3sGreCHftyWQCQeQ1KotHgff1P+wLd4rFaqvVlHUDVoYMctY7Pqz86G
         tyzVhPHMlWLSA2fDKrb/w0ZDJPxyRB10NdCWMj9qb9g1t5bJySV9JRWvOVkNW8gKZbSJ
         pD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234828; x=1712839628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKX7vVNyqnnyjHXxmLAOtau0jOrACCVSiJJ7CZT6tc8=;
        b=NnwuhZjiskyovEBMxcTYqbttCzdJjDQ6upbQKQAeNc/r0wZIHfsfvWmjDPTUr61fDW
         wimipRMQiW+DHjghhg6au5lN+rQA25HqdMKBQILzk980Py5OR9MIiNCMmO+NZ9BD2JVt
         13Pz2662BK0zA4Kqtl5+haBakxxstP1vdn+HIrFTtGxKHf5E9aiTrxSlcq1dg5O6oBYK
         OgXBpah8xqvV6p9oFxxi0WwhSGWemdq8GOGYs+dCMBwTLIrVGShblA/KBUVAQfJmtq60
         7Tie3fwHJZQ5MMK1hNmMOR3AN5nw/STLakXf1enhO3id770SMr5yBVWMrhzptM9WjQuO
         zbGg==
X-Forwarded-Encrypted: i=1; AJvYcCXS1ZLjEZ7KpK5eYTDcO7Ru7fitnE+O/x4dvEG3FX3Flng8/nSQR+lwjL7xCdpGs5dYnDckEDM9Wb8zTNPUKperd0VmTZvv
X-Gm-Message-State: AOJu0Yyntx0WRexqZ8LjXyT1sDzMOoXTRmSQdT44C0/9IcU19b0x6NwV
	aDpJexJWYjOlH44Iwkoqz4r12si4Ik/nRfa6pjusLOhkkjzejXWHmTTWPLNRWbnJnp2Sw+b6t6E
	7wK2D9C10LIsaKu0suv9WUxTLN5A35TpVKM0U
X-Google-Smtp-Source: AGHT+IFKwJu/g7BbPnYrYJB2WSSLAQgmbJ4c/CB4oOIccB6vlZA5jW33C9kcqZQFCvLNmqUBHzsgj92sT6oOOlwD0UM=
X-Received: by 2002:a1f:7c8f:0:b0:4da:9900:a547 with SMTP id
 x137-20020a1f7c8f000000b004da9900a547mr2081279vkc.1.1712234828230; Thu, 04
 Apr 2024 05:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-2-wedsonaf@gmail.com>
In-Reply-To: <20240328195457.225001-2-wedsonaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 14:46:57 +0200
Message-ID: <CAH5fLgi7R0JX8sc-cCQ8eUgzXFx+6hBGZm_gMZ_RvHPKZeB2ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: phy: implement `Send` for `Registration`
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:55=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> In preparation for requiring `Send` for `Module` implementations in the
> next patch.
>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

