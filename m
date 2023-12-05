Return-Path: <netdev+bounces-53721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13852804441
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB551F2133A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7231870;
	Tue,  5 Dec 2023 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gctY3hSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15C1C13;
	Tue,  5 Dec 2023 01:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306D5C433C8;
	Tue,  5 Dec 2023 01:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701740916;
	bh=u6mofPvRKrtmonF/7EVu4FENIouv9pimKacSkGVq2J8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gctY3hSOu3E8Zz9JBFyE9f3XGk3yHKdYyXP0MxP3lYo50XHLujZQ4VVaqSWx9Qp2e
	 mNvefPUcOLeqzGEVmawe5ocV0LL70HwdpaDPGGg3QMgtVur2bzrVCXVkCXzziGAE29
	 6/CTHWvs6C6UNYzXXXTWEF2YPC7fx1WgNx7tbBPij6CtsiL/Q0RvbNuB3xVO6dpJjG
	 SloS9gJvLQHE2itlONnW1YaYyCQUU0HxduTiy2yHixTTJp5ka6fKlmXH9eYXNEIQ1W
	 WdHueoEzW+LsqPG5HJP+RPYQHTs26un0Zm09/Du+8AfH94mzCBTPTuOABchZSN2A+5
	 2GF3dkKInANdQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2023 03:48:32 +0200
Message-Id: <CXG0T2MKC8H4.2WAVL6YCX9XC7@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <andrew@lunn.ch>, <tmgross@umich.edu>,
 <miguel.ojeda.sandonis@gmail.com>, <benno.lossin@proton.me>,
 <wedsonaf@gmail.com>, <aliceryhl@google.com>, <boqun.feng@gmail.com>
Subject: Re: [PATCH net-next v9 2/4] rust: net::phy add module_phy_driver
 macro
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-3-fujita.tomonori@gmail.com>
In-Reply-To: <20231205011420.1246000-3-fujita.tomonori@gmail.com>

On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> This macro creates an array of kernel's `struct phy_driver` and
> registers it. This also corresponds to the kernel's
> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
> loading into the module binary file.
>
> A PHY driver should use this macro.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/net/phy.rs | 146 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 5d220187eec9..d9cec139324a 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -752,3 +752,149 @@ const fn as_int(&self) -> u32 {
>          }
>      }
>  }
> +
> +/// Declares a kernel module for PHYs drivers.
> +///
> +/// This creates a static array of kernel's `struct phy_driver` and regi=
sters it.

s/This creates a static array/Creates a static array/

Suggestion for better formulation:

"Creates a static array of `struct phy driver` instances, and registers the=
m.""

> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, w=
hich embeds the information
> +/// for module loading into the module binary file. Every driver needs a=
n entry in `device_table`.

s/This/`kernel::module_phy_driver`/

Or at least I did not see it introduced earlier in the text.

BR, Jarkko

