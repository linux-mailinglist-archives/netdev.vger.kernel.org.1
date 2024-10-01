Return-Path: <netdev+bounces-130921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3098C135
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B91F20FFA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442D1C9ED6;
	Tue,  1 Oct 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrmgohbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209B1C5782;
	Tue,  1 Oct 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795308; cv=none; b=Z/TuKzN+WMGiSbUR3V4nDNtvVGXY4qE2KW51mPC97+o6PzjUMeoTMweh9Adftl+s2Dk8Av2XcWfFMMmfj9OTEYAbvKy7T/MpE4tlFcUkvNVPtxzvbulj9MFCprrlduDLzSskZzNQMA1OZeMnBKtkfyFNKOKBD2srBUyWIuYDu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795308; c=relaxed/simple;
	bh=lpMYwuYF4ckUJX2+wXsUeHwRiLsoHg86KlylTNrREng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yc3x7vexHJTV4jJuFEMFik09A/eTtRX2BYmlUae8I4S5I211LWPSEw/f2d8QJ3imOo1df5bleQgJQIVyOPCG9x1EixHFB8Kgn4n+Kq0oFMG/QYx8g1HAJssrvYyA0/gsBRdSnNJje+DRhHwng8361+jNEQf3hNVavhMw5xK8jHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrmgohbU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398aeceb51so508941e87.0;
        Tue, 01 Oct 2024 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727795305; x=1728400105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EyuiSc0bXtkb+5216IBjp5AP5vKc6ihFV2MzU9RPgM=;
        b=hrmgohbUWMV5KlDSHUzDUZOPZhCCPMgKGNieKA4CS8YkSpsxqkIHCazysbOk3VoIz7
         4oLWrxgSLSmmDNZyE9eXeGCJTWG5VF7vYlqetgN9QJVaqwqJUyIc++J8hIVOQ7qWcku/
         RSAQZrFSPlbmra/f8LPlrl1HgC4cmIkRkMIrl6xnn2eJ+ul71MOo6usjY74rBslo+Y2d
         eAnTy+FRwZdvHXSejhcEFdwBdWQFalT9DCsOU4CuQUH740kdhobMzyrEJM9ABXaMpYi5
         Mi0FhvfKWnZBlCc2tIy9ifStAbGdO00yX3d0tBYqXUGRHPy/J6POsOlZm3Gtkwg1ILg2
         tDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795305; x=1728400105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EyuiSc0bXtkb+5216IBjp5AP5vKc6ihFV2MzU9RPgM=;
        b=EWLNrvkFuuFLt6Z91vAwDeh2L3HiejocHj4Lj0znUJjnskRKmll7OdZzb9B+XW9zWK
         j3HTFzP+2lSFr/y/I6Zqw7Tpv7w2DfeWudr+Afr2mfbCi29/pH4Hrz9ZZaQwZUf/8We2
         uW0tN8+MT8lJILd8Ey3hAz+a78G+3sc4ilea2fPbmamMXXmQmjO5qh6RO9aoJPjDYDQT
         EW+4DxX9RE7DeTXDb+Qx3mIZIi5Kf5JF+zkkhosbF4rfNcmGuSddTxm2G76Jz4rCP/VK
         gbIYrQ/xMuIhhPKNIWApBC6s5Q+TtQX4QGzrX1TdhLlYINFFcX/WqOJrBDdNcDFZDxoH
         nY7g==
X-Forwarded-Encrypted: i=1; AJvYcCW+33VUVXu9WjZk+0uW8T6RShrx0jTcT7bhK9TRE6O1g3sFLh/PGk09W4bi3ghy1MS1q0GYEf0=@vger.kernel.org, AJvYcCW/vtrzB6GM1q3/uN5Y48D2AmHJ6jmdUNU9w4z7ym9d3hlARZ2R0HAGqULcBnd9c0k1ZdSxtuz3ug7miAmz0T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfkVC3J1wZZEGdBbfOqA1BUt8BsR95LpFl3dJW4oUJEXYHWyR
	9zwL+WwmOs8njx0rR9RrKMxdKLAM1OU+Avbtyhi/si0TsFZDZBkvjgQ2r0RJsP9AHMvtJ5OdLcY
	vW+GIMQqckn+ghzVe+J3vMR1kvzU=
X-Google-Smtp-Source: AGHT+IG343eghsQFfS0pE0H59wL9W/6Hh3fwyaDyGe910LdOZrZUadoj4OqvtmS3yBsiz2VTPtOmTEMqGWwPlNH5Zd0=
X-Received: by 2002:a05:6512:3b89:b0:52f:cfba:403c with SMTP id
 2adb3069b0e04-5389fc3a056mr2294098e87.3.1727795304769; Tue, 01 Oct 2024
 08:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com> <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
In-Reply-To: <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 17:08:06 +0200
Message-ID: <CANiq72kgw40T+taVCBh5Onr5giUF7xx+wPS0CqNMQh9Lf_YOrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:31=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Is it possible to cross reference
> Documentation/timers/timers-howto.rst ?  fsleep() points to it, so it
> would e good if the Rust version also did.

We currently use links like:

    //! Reference: <https://docs.kernel.org/core-api/rbtree.html>

Cheers,
Miguel

