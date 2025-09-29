Return-Path: <netdev+bounces-227223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996EBAA89E
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 21:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3203B2DF0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 19:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7AF24DCE9;
	Mon, 29 Sep 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5RB08Jd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D32459EA
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175864; cv=none; b=Ms1TM5sJr9UCTEDjMx8VdtsALjNie4jMAYBb5GTPwo3AO9NeRL1V3mm9U5hFcL/K5b61B/WMy58qivsD+8coVO0aM+oFUkmyRiCRO2kWtjE6Q7c9qqriLtSwkTo8vN+RE9nJ6j/9jR/XL7dN+Dl5SaIIBq7IGHiLqxoYg31lYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175864; c=relaxed/simple;
	bh=ILAe+VRfX0Fc+b5qLvaJzfBUJ4qz7jOpbJP92apYs7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQMGpaVXlabeFR1oYqUaQLh5XVI1d4V0eK2CMFZj/xn+jUa1b6iiFe++vfVqWGl13mxtUlp5d/sWDszmp9zEPUOWQ1NuBFOkV4hhmGujV3t7WpQdjNkpQPxHLQDh+TDmIbSHAliyjEPzatLRv5UgWsRXGp7GbaQx5sltI60RKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5RB08Jd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26987b80720so7704095ad.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759175862; x=1759780662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILAe+VRfX0Fc+b5qLvaJzfBUJ4qz7jOpbJP92apYs7g=;
        b=U5RB08Jdp+02qM+f5Mp+vuiVmfSvgvAx9OiS9eb/dfT+moX3pfMb+UYBBkKAocEnWD
         lb08aQk8t3PnXYbC6FKFPEpeNN+0C3ZK5K8O+tVbR+xM/l1tcssKZVmm03IKwOTCHEle
         otJ3pGwplRt2pfEJJEZvwsiu9yLStl62IrDFTM2XX7CeRRpwmQk921H0CmTYR3OS71XF
         NekIyiGHf8khHUgEJ7/Wg2ZlzVBCZ0wFeOg6ADpKhHUA9qnm0NL23qr46rSElBRBhtmX
         ruanjoQ1J/SgQ4bkiNZDbqTlMP5Xkn+l9J62YsWvCV6Vi6j5khk+VeQK0XuWqSD6UIog
         WvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175862; x=1759780662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILAe+VRfX0Fc+b5qLvaJzfBUJ4qz7jOpbJP92apYs7g=;
        b=l/DuRIEV6usRs8UVuC69cf0/TZAfmDavMzGKs5UQ+2NFvTz02iibzTzwQ/W4TvIuv9
         16CrIHZ9ex5Xgd2ppSURVGYsRfHhjWPhZx5h6FMBU0yX1TGM7H27CzM+A6KsveqPMYwy
         7X3WcqBylg9/3E5a8hupCZglfu6aVD+yxULyRnJQv199vFLJyK2hfQAFCaw6Gb0upa36
         TEm1WGL66RXGcOsAGhjiVdYpzqm7Z7CLWEBJtcYpeiX0i2KJs31bbYMWMfEFkBJ58Hgq
         lh3NZqJlfNUxq8vwRw0A+khph8NJIWl8jxoonuZcWz4i1+WVPMpE1HPMFF2Zhd7u66lH
         m4jw==
X-Forwarded-Encrypted: i=1; AJvYcCVFIwqnkd3VfzrRtEr1sft4SPu3SZrjmwNQU5g4xTDQ99W0u1WA4+DsoVQeluSigcK4kGpMv/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxToD2OV5Ip6kIiN9R9X1MdUJ1XecZA4nAUOGHfhBJIaE1DonWs
	YIz56DlOPlTWdj41slxg9jYcr15475REgdN1eIKHve3Ii43wqen0tE9/3f6qw6VASPZYeQr50v9
	N75DdeeiqZckg/ewxdzgy4kUPb4gWui0=
X-Gm-Gg: ASbGncuqPXXfMiByjk7DwV09xas/qVi4xeiw7253ox70wXyoBZ7LUWV9FZ058kOf0Fm
	8MmwtlF6niwZgJwpacKwxdebIrKvesA6GYY14iK/svq5MN/jg4+ZwnA+P/rWO3ziKkDRWUa1RoF
	sh1L9fhSsgPzrUAdxHpjK647gVeWyXrNZ6iIshxt1swXcdbON/QAE6l7rjf3OwxGue0xZGlrhER
	cczMDEkuObTUAG9Mouzy0LDPokJgp/esPlzvYI8lV4xBqE/8c5xphfbCZReQa4F5H90rS7KkI8f
	C9N5iOJFOkRQk/3NSbOYJQfsQtUL0wuh+n3w
X-Google-Smtp-Source: AGHT+IGYfATe7mmNTC4A+jEkwD5MzSelb1z0lWF68kS0t/NWgoEWKg6nD9jI4X3FoSNWbDyeH2i7qWWFajxt0X+1x5w=
X-Received: by 2002:a17:902:d501:b0:277:c230:bfc7 with SMTP id
 d9443c01a7336-27ed4a5d82bmr113039375ad.11.1759175862141; Mon, 29 Sep 2025
 12:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Sep 2025 21:57:28 +0200
X-Gm-Features: AS18NWCM9kbfT7mylXQdGB8ZyL_b6RmUa1M3XR6zo5RoraO0TPm_DutHWVTmZ7c
Message-ID: <CANiq72m=TJMWFZhHSSU_-A3+tr5h8vA+X+oKb9TcieXQ6gHyJg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:54=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Changes in v2:

For future reference, this is v3.

Cheers,
Miguel

