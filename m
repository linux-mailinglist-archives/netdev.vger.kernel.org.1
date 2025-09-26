Return-Path: <netdev+bounces-226767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1EBA4EB5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EBB32329F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAB30DD05;
	Fri, 26 Sep 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir8tCqGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120B307ACC
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912378; cv=none; b=F8RGwkKsvbgyAy0DieOsYInFl1WD+vN11WRyGbN00DR52AtYYRRKNNckJNJ1COlwUI0j5QjpBsPlupPsFQurP7YCk6aKW+3cQ2OESiSd+5xJg1Q+ktK3wG7EBevr5zsK6VaN2ctC3yx2gryGA+jbGG7Ma6Y8rBa4VjjJx+A+yl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912378; c=relaxed/simple;
	bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOLAhbPLmmtDQR+KafL50W/SxZy6yGvVO+zSF96Fsi3F98a+gZOsEH8J8X8ys4IYzqFV9JZ7lgyGWdnnUEBF4ApA8gx4OEYxL4PQ/KeRNanOl3OeWDCEop46FfcZ7FuEe/d7FcWydCb4QbUv/oyrVD8eHZ0tTe067q7vrf0mrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir8tCqGS; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b551991a9baso382030a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758912375; x=1759517175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
        b=Ir8tCqGSjY7fG2+bMbC96eCICN3DWieYr8p8kZM26oAb8TrwhFr29tYMG/ONxQzbhI
         puWXlM8u0Q/ag9hzXKOcnG1H1gYk+GWzOmRqMqf7QZRDOhSEBjPgwtjTGkIuxzGNe76m
         senx55Q/JSlzOXZdLQGNP3dWBDTDFPDc9TqBj2LwayJlJSz85XEg6iYkKtAOn6cEcejK
         gZdDrDv4o0ljXNe4ocrYkDiz0lHnPxTft6uGPnUXIJA0bMU3+UDSpSEkJrLr5/ipVEZ2
         k8xjcViUkWhGBy4OvfS093phtP+nnKdokgXmth9qax+zdJJNV6oYPZaGVtL6zKq5gg5o
         Y6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758912375; x=1759517175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
        b=h0fQZjzwR3iTqbJX0WRE4q0TSlOy2Rnyd+otO+fAOf9wQDaPxpC+yAuzy0cCZd/n10
         cOsCGyuVQrjNWx+eyE3oA6zcKKTAe4QQVUUsZQLbHjFxfRUDHV+7CHcaqDZCVd3RvFXx
         F4ZE5k+mWqlqoOjRrexojaCOWE2euK4q9tG1MYUexx+S2X8vt4TDh7DU0kqCG8HFs7ck
         0oJofnIycGsM86+x4rBdSOGp3c32TzUU19bDwkMuNaFyVGLtRrzcY7kMquJeKFbXm3Rz
         V7aPz/Ne2G5CPFUj/DAzFEDTo2HhKcJgB6+NOAczIJB9oTHi8QVFDUF3Wb2BmlZ8q0LE
         m2KA==
X-Forwarded-Encrypted: i=1; AJvYcCUUEvAFrfjuTMH3YStXe5x7utGDUNlRXqIgCT9OWc0LNoS0zDWx8sQlCDjIyT+v2m8oimXbeX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ab9Vi9ZG7KuycDJNThP82dQWMnRJvQsjxiUtuShnWvSh8Rfy
	UlUOOg+IDRW2vJq7qmhGUnffvWhrDVCYhlpVuJWJBP+gU5xm88F4hRbamqka0y4jOvHNiaITJwp
	rNY3WLKtrtdESv+1/xpANNn0bt92jEJw=
X-Gm-Gg: ASbGncv7mLXbRGYaFkjcPkLArTZT9PuIhs46NyAqRte2tf04KXoUfoZgU7QICFm4UBF
	HU39kTa5rAC/zb7mm1Ow26P4vtO0KDTcE5AJneY8CNkzHUyn8+Hw3fohSbuyW2ENgpFgs/8+9hR
	dGFqPw6U96UFRl6+4FLJ7A9bECwkwKnLjUL+eVuhdA2F2IbKGcm1cXOPDyz8emAkze7jyNYME5N
	3cRWkOCFmw3geN0gEWOPAsahn8sYyX8736V93ZbiLu76CINmMGMQgmiQ1DT04h9Pu3MKmCR3470
	13Ficym1umL/izImrzG6r0xjYw==
X-Google-Smtp-Source: AGHT+IGICCMscDDR09yJt5H0iPKTO2HVhFlo2/cy7JDDWeiBMU3GNUjCo5LwRgqW0USPT3MDqhixj3g/rTT4Pi3J0GM=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr51481475ad.0.1758912374667; Fri, 26 Sep 2025
 11:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
In-Reply-To: <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Sep 2025 20:46:02 +0200
X-Gm-Features: AS18NWDpMwmpfdQtAlAM5mfbOpZzjcwdG8Vuf5peZ5dotzDbBFdbC1UDMcnVE7M
Message-ID: <CANiq72kNr32NKHGn=gfH52C5VLr9S0Xk0HNzroPqYhx4GngkXA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
To: Mark Brown <broonie@debian.org>
Cc: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:01=E2=80=AFPM Mark Brown <broonie@debian.org> wro=
te:
>
> Given that we're almost at the merge window isn't it likely that these
> will get applied once the current rust tree is in mainline?

Yeah, I am submitting the PR to Linus very soon anyway.

Cheers,
Miguel

