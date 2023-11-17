Return-Path: <netdev+bounces-48603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A639E7EEED3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE428130F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C014F85;
	Fri, 17 Nov 2023 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc5YGcJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F0D4E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daf702bde7eso2452217276.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700213955; x=1700818755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSdTY5g6opfcl5LD544J1YVLs1Qqn6IPbTfdBkgZlAk=;
        b=Hc5YGcJTYsH4peBG9glkf1JKTsdn5HZ4ZRcCvkKs1p2xgByDaNB2uQZEI8rhWBFy1L
         BYu5u9qxAIW7KFoFyHgPyB7CDzvzlFS94JFC07KnawWPC9BEFWsBrEYubeJe6Bme0YDp
         RCe/f4EAkNvG5yOP/fjihCOKItJQKD/ImoKliTphIz4c18GmXv/BNC2u2yxJJT/grQUX
         4VYTiLU94lzO8YnT4HKAiPzWpUq425p+hn6YkLynTJYEm7+zRdWkxs4iBezpVAuCMTcl
         NTmIv8s9Unmn8Pc1dob5sm9hAmb2ZHDq1E2cBXA/Q+68rIxazoZhVt8JBskbJeFWnzZ8
         BMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213955; x=1700818755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSdTY5g6opfcl5LD544J1YVLs1Qqn6IPbTfdBkgZlAk=;
        b=sg1wx+6lLrRIp0XB5TttJnZyUrvwK0Pnf5hvH93NjSUtvC3O9v120XV3xHinCI/vsj
         nCjvEcSUaTtaxxXLadM5tiLLNHXZRL8q5tWiomMAMRrhQ8shaM1PFvsHiBx6IpXKWRdI
         R1wbBYpds72ikwW+dnPkXNnx+t28VgBtXeLFgPiovLO6C/zd2ueyQWqpdpjiVvYl6v4M
         3Gf20ul3QZOa5Cxoc7jpzEOL/nP1tnCpmeQLYBDDAevY5d3+lbtkcWAfAI20XKBzRcVW
         1nDWMS+CRpaXGdhxl3kzEpxVuG5oatZqgBs7bu4nu4SFniwC/wBER5Co3QApkmQBda58
         5M4w==
X-Gm-Message-State: AOJu0YyQPQTsJZK3gIXQkz9rDx3z9EY7oSXHeQqhr2zkscYnDZwi5h9i
	L1/kSo6501WFhwB6a4HWlPO6EnJHj4WpFRU=
X-Google-Smtp-Source: AGHT+IHMFlaClkAzqBILnoa40sm3JbIfoSrk+T6eYp3aJD4yOrSyWowj0oMmpqANkG1z5PhoONy1lZlVx8ha9rM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a5b:203:0:b0:daf:7949:52f9 with SMTP id
 z3-20020a5b0203000000b00daf794952f9mr432793ybl.9.1700213955416; Fri, 17 Nov
 2023 01:39:15 -0800 (PST)
Date: Fri, 17 Nov 2023 09:39:08 +0000
In-Reply-To: <20231026001050.1720612-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026001050.1720612-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117093908.2515105-1-aliceryhl@google.com>
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver macro
From: Alice Ryhl <aliceryhl@google.com>
To: fujita.tomonori@gmail.com
Cc: andrew@lunn.ch, benno.lossin@proton.me, miguel.ojeda.sandonis@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	wedsonaf@gmail.com, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> This macro creates an array of kernel's `struct phy_driver` and
> registers it. This also corresponds to the kernel's
> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
> loading into the module binary file.
> 
> A PHY driver should use this macro.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

A few minor nits:

> +    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {

Here, you can add $(,)? to allow trailing commas when the macro is used.
Like this:

(drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {


> +            ::kernel::bindings::mdio_device_id {

Here, I recommend `$crate` instead of `::kernel`.


> +/// #[no_mangle]
> +/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
> +///     ::kernel::bindings::mdio_device_id {
> +///         phy_id: 0x003b1861,
> +///         phy_id_mask: 0xffffffff,
> +///     },
> +///     ::kernel::bindings::mdio_device_id {
> +///         phy_id: 0,
> +///         phy_id_mask: 0,
> +///     },
> +/// ];

I'd probably put a safety comment on the `#[no_mangle]` invocation to say that
"C will not read off the end of this constant since the last element is zero".

Alice

