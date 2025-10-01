Return-Path: <netdev+bounces-227456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C280BAFD97
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 11:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF713C7CE7
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3792D94B6;
	Wed,  1 Oct 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZk4BoDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5727B339
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310919; cv=none; b=Z05smZxeorwdwbTYDW6fonPtq5gZ24FDkUyHbA8f2LUo1dwHAMV0h8DmdrjOC0QBirNlDTXPOb+AwUZ+d9+kaJv67rCMwqOCgonWZaIfZFWsZgJPI4uhkkMitfMDgXawduUwJnGv4xwvB42gDxakITJsOXTaNUA6a1yrjwmTlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310919; c=relaxed/simple;
	bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAhlMFLVcD6m6Q57xma2OiPwieagDJl4dSwg42wuoeW/Ikv+Rg2gNv1YEKd7eDbIfN4dqBOtF7NY2i+VTvna/77vdjaih0TmbEEKXEFbspYRWKH9pFa+m0YJMEmaiVO2Ul3X04RWzD5edP91ckZMu1hfGlJFhQrvcDqQGR5O6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZk4BoDg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e504975dbso26381815e9.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759310916; x=1759915716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=SZk4BoDgsFAf5kMvr7CbXBjcwCX04Gigy/5uI9mf3QxITYphuXHHOPFGqSL+otUVU0
         2S+ooXPjysDGDq5LyrNPJHYnCXbCx6H/PQoEKlPmttcSprij44r05SUx7xUq7wQ2zxYw
         nfFKg2EPAo2A2HpO0LMagnc18VPUsVaw9ualx5ys9clXOxrxYzqV/vNwKXVXf9+la+tC
         nqJ54pGhDvCFFMcNYqLV1bA1Es7uY6AOJ910q57gfDxP3FhMZrQHPHl1RhY2WEHlXP9T
         aEuYrwYCfYP16Y7s1ETYGvYUfW0Sa3RHGsEsE1dAcO9uF+AXd/FQtKom+Xfidit8qAOy
         v7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310916; x=1759915716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=XbsDItOTETUnOZjopuixqblvZfsZpslWvOBnZ0Vg+7UdneO+kB9/ok3nYdMYzE/nx1
         GLfrlf1tSX+igoXQQvFU+bkhWxsyPhmpcP2MJ6DAGtkrVbf7LtgqSaWeTfKcnFowup3L
         UCOOH6k2d7qH0J5Yo3PkV4kcDzVmnCNQmH4Pkic9J8CRpFBCTK1u6E+tD8F5pxRbFngb
         2zgwAkgeT6Ql5V9ITXwq1YBqUavz0skw4j9K99z+nvRCGYCMZy8m12+YOmC2DQJDoA+W
         Sg7p64URYL+ZfTsCRzXj+vbuoW6WTrTeYRyXeP+5B0rEdS8eTO3d63kozSDixOrzqN+q
         plcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3odVSwr4y/q4srZm5UsPpA8CDGPGBu6yeDSxgYEqd68A2lZ/IMfJ6w0P3JgQmtSSDy57K/WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEEKUhrnaQ6s6TAZqFLVjMLCgAkV96Ixaraj9U7eVZNEWOJPb
	6HiVjlhgSR7zazdBTNAzDFuNcrv/tOMRyMBnyFEFyTY1UUotU4zYasIGQ25LEwSFcAvA5p7ynaN
	FOdAmKPtvWqAwzsl/u3QJojhquR9qifYe2dCxdpTN
X-Gm-Gg: ASbGncv+dD6X8u12QncYftQK9oT2o+nCoXvpRQzk7KaK2Ckfq6+gdp+pjdjPLER0oYT
	QxuAXoAl1fVovaN6l5ckKS0epEuIeEakXWREOXa1SmGUFp4gMU/lX8qU1mA8cTg3j8i786ViwC4
	HzszxHxEVrtzg8AOfArAN4P0XkmYgwyhvgXQc1A6mXaylk1dq2CnDE6is6At6QnXfTr3aCzU3dA
	V/bCoWAsycEeduw2GYqBhOuT2plllJ99XgmjpBarte73pGlLqVK3uHHdOuihgAJh9ThT26l5vxG
	sCA=
X-Google-Smtp-Source: AGHT+IFcom3ihUiZsvQc7Ctd6T7AFUDP+BI45kum3YBKQg7Ja8eF4g1jmM9Rz4a7lPBApkzRM7m3vX/ZWyyP9taYRzo=
X-Received: by 2002:a05:600c:1d12:b0:46e:3d41:5fe7 with SMTP id
 5b1f17b1804b1-46e612dcff2mr22205905e9.29.1759310915370; Wed, 01 Oct 2025
 02:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 11:28:23 +0200
X-Gm-Features: AS18NWC0UIhXtF3ngdaaXlg7HajAeA8SvMGIxlOaATZh6gKK8pvCVQpA1AHU2RE
Message-ID: <CAH5fLgh84SZznuv_BHMxSe4riF=YZekCp1Kx6KmiipzTOHmRsw@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] rust: io: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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

On Thu, Sep 25, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

