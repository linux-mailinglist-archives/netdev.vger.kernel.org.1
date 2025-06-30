Return-Path: <netdev+bounces-202436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247EAEDEC2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEB57A53A4
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FD70824;
	Mon, 30 Jun 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU7bDU9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1B22301;
	Mon, 30 Jun 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289565; cv=none; b=ZW3sEiVP7FjnI4ZQM3OdnkFigx893c0THlto/0g8qQlbjJ3fc7OCEdoKNmei3a9coeZve+CP0RbyJkQBJGS9hBnAY8fxMpa/eerot8s4lGPlcaLNWiDOBH014y3fgjqlGT/vVnuFEyQOQWPvPaPAHO+RDu7UVWj1eJWL8ZWZb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289565; c=relaxed/simple;
	bh=BB4EhAJ5HkH6vvLgwEbYk7Jud5q2LTgGhCpMP2egKY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdXgBGUWWqFD6tTiCHxDlMLgmWZTtI2GxQXKlJFIvQt+O4TebxICvfzQzIZ/ZS2oTxX3N14Fogzpgx3xLqYPzZUPgn2jJz7h7h8aSHYsm+Vfw3iw43n/WaKcAbjo6y1EdKFKwPgm+tqEq7Vs1nPvAR3SfcNaWxL+xXs357DdRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SU7bDU9m; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso42516791fa.1;
        Mon, 30 Jun 2025 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751289562; x=1751894362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB4EhAJ5HkH6vvLgwEbYk7Jud5q2LTgGhCpMP2egKY0=;
        b=SU7bDU9myprdIXpFm9eyHYnllvz0eyBBRh2T9Kg977WGgis3bVYme3K+ESlhlihOwR
         LypZXO5GawdUIvnasw1O8+j+ODXx7kDGG2JR9+twR+d2kZKkCOwFYnwdDKWI5a6Ne3Nx
         hgbvIqrWp9B2aSKLUPfBwMgSh6e6N1/IyKLgknYoAZNCGWUkCUKQ9ACCHCCeqffFzwaa
         zF3vbW6OFp0nvjnLiT6DO0YfqsGRty22hUdDMAJevH5afi9Jw5OFQNrm8h37qpyMjYpD
         /7YADu7dRcFjip9GY+ESUBG8IW/aH4EYRKH6KqQNjTxyHVN3T3jkxdrkYwsCRubyi3lp
         OcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289562; x=1751894362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB4EhAJ5HkH6vvLgwEbYk7Jud5q2LTgGhCpMP2egKY0=;
        b=XwUNv4mwUddykwjZob/zQSIvo3UYqldTbdXDduSQF2KhHR2Ju0ZaigEEW+ZOAlb1Ep
         xLf+MKz2CMhs0mlpMwHrYYyVfMTbZMZ8sxzAX6NmEIqmAgpR5oS1dBDUhjc/XPqSSTP+
         jYOugc3dr0jAZZoN80AowcmKUgvEIWNF9G2KeL5IHmd3OXnmnWwsiDfGRH1JD+RnYKag
         WAX/dOK2b4D1Mzlcu1JOIos4O/IIbSbikHz1RxVSVBUuvXirpPkmHBZAMu+rQ5zf3rmy
         tCdYAbE9v6QxFB5S5biSnpxfJ88pe4X+AOFnKNnddL0529qNcRnwtKHPVWi+te0cmu1o
         tFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYuWw3iL2D+9HeuTnmMXUoZHzLO8rKy5PrpCOhsgC2dBtDBjWUo5FwJjJ7dvTo2f4kV03/Mv6s7s+hMIE=@vger.kernel.org, AJvYcCWI+Nnig4GDv8DDcBh4eiilk7gpbQs3FKE8/kLDvApXeD35/ADnLhE9tGr6Ez7pk6cbaJq4cfXoPWjSBlDcSZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj78VTmFC6RIcOhHsCWlOtqfQlv1q4hrcd2lFi+WYo4wS6onxD
	uX51szFtk1DwyAWglN4miyt8wwnkggRqkXOUqc9c5jny8LB+1u2zrs1L0dcpxPYkQyvaYMezK5M
	0WAE4IFncbH/CLaIiIs0EALyUe4qaYgRl+YLG
X-Gm-Gg: ASbGncvTZVawVVEeWCm2iPYIuUAPzHTW20ywkrdMlkiMOAr/WNF/WLWfMOdyZSVdrm/
	VfafXY1COWOM/gwVtS2/1XPyMRcnDJ8koHIwBMsaz/clEYVV+1jTgzAUVE43GznFhZ6/z+GrXHa
	xBLkvI1eGF9JaCIwdQfPuaYBQtB7otvzXvIbLTgKnvooxM9dsL2bGb00A=
X-Google-Smtp-Source: AGHT+IF5pIx5wo+HF1lwVIZBpxl4HIAmuRfnrMvUSxkLMVbB+vvK+Bx0PSvGBy2Ln3N6lDEClCi1fiNUJ0y1Js12+Sk=
X-Received: by 2002:a05:651c:4181:b0:32a:6312:bfc6 with SMTP id
 38308e7fff4ca-32cdc524da2mr33036691fa.35.1751289562265; Mon, 30 Jun 2025
 06:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
In-Reply-To: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 30 Jun 2025 09:18:44 -0400
X-Gm-Features: Ac12FXwZa7u7GlLPyIvy5LFGEnAY-4b2d7cOZCJ5dVC2JmLJnzo3ar6SdKum18M
Message-ID: <CAJ-ks9mnMRVSnsn_bpaE_XsJ9b_5+=h9FY+jCPJE35dtY849tQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] Clean up usage of ffi types
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 8:25=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Remove qualification of ffi types which are included in the prelude and
> change `as` casts to target the proper ffi type alias rather than the
> underlying primitive.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Hello, I believe both patches in this series have been reviewed; is
any further action required?

Thanks.
Tamir

