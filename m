Return-Path: <netdev+bounces-137043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C33D9A4159
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F0282F8E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0411F130B;
	Fri, 18 Oct 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExPF4vgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C00768E1;
	Fri, 18 Oct 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262319; cv=none; b=hyOdz5EXsE1nCqeD3GPL0DeALwt66baGrQlpYBTHP9GUOelIbbO3IdK+OcS0+9oq961F+gR/B42znaccgLfqdvue79G+TKWQ0jEXi2Tn+jbGycFV0tGm5EVIDARtcMkYs4ML6f64bzqCT1YMdxjEit0Fp0xsu6qnkrwJO426EAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262319; c=relaxed/simple;
	bh=v73bTIDUcXnDFQiLmcLtLyT8FFRm72E67ebb2v/k680=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg7XAqEMpVwBfe1d4Xcclm8uKpUMzAPzQweSlM96RGNyrFaWnE5b8pqQeIC//kr4kKT4ZFVfChRvjs/RtQBZX94jBIVILqOsK+p/cLAWF38dyl62htIKgtpX7TaWSpuen2Om6jhkxBQILYz5I5ogOUg41dKiKYjlqL6uYrR5T+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExPF4vgP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so387539a91.0;
        Fri, 18 Oct 2024 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729262317; x=1729867117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v73bTIDUcXnDFQiLmcLtLyT8FFRm72E67ebb2v/k680=;
        b=ExPF4vgPd27m9UVDuoXdiRjVPENihfIB1X62TPRMpmTzo+KCrza0Fyavw9kpS92KGH
         1lXONzII7hWZJgMn60uW18tAEwpQsxnmTCCFQ8Z8jaQ7fRD81bJ7slxg1mwZJXVY2A37
         c9TbIBATMUL+a5SH+gQ+sS+G0cBTTsZOjfspJ5rl+zPGU6z+jsdVx9O0nuB8cuxW6wn/
         5wnb5L+OxvO2fsYSzmgeKXEJ9drwqGBhY4u1nB1vq4VftfonCvG5OB4QDn6WrgE7g3Xb
         ciLHPBSOjUOnwvfCnqopebxsm+WnfY9AfsjQowXXNe4YgCMK9NVxG14cpEYpWzBEPVgf
         laXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262317; x=1729867117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v73bTIDUcXnDFQiLmcLtLyT8FFRm72E67ebb2v/k680=;
        b=vwQcytwa0NE3XaTu7QslZ+gjsmx11dKS7Qq+qWpWwBm3c0sAImyEDbwMR35c1inaTM
         fg97XSqdaW4mH99XDhRNZKvVZvaC+KLYG3/HcEI8VTJi63JGMXeFngyBlbYsNubJnlta
         vMibety6v1Q65ZEf1+ZGDgexwFo2xpMmjqqI1QDjxznd6S2A+Je88mMgxXpLImVT6JGc
         ID5561o2gRmSO7tVALleYLbVFyOFvgBW5Drl0Dw/0ceUuPMl4cLRAzHANez5q/SUaZe2
         QJ6nPeXAjS0mCHw/vR/gG7CsNmnD12ECaSrODi7RUAxzjvvd2ftUdDsf9yRGlYViS9N7
         VpPw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jahlXyMSsFd3PvtIjTYqFAEDNjoKuEN8+e8fRE6kD5I3ced/TD7PxDvUZYFa/2WkEaQ0sDKKTo4bzhBpRrs=@vger.kernel.org, AJvYcCU5hSuXwZaOcxHPb6F0Gdp1bFKg3R4QBfIAvS6472jT0QyRTZelwspGMED2t/YlpaCQfRbKvFdcceUe3kY=@vger.kernel.org, AJvYcCXgDd9p/UWoLUE8FxYrTGPbdT77v9n9u18FglMGd8Lxz96zdFNj2AP7X+CjDBXl0sQT0NcRZBLF@vger.kernel.org
X-Gm-Message-State: AOJu0YygRbVeqO51zBLeM0n3SIckygFrQfT8oEEj9YooP0kEXfAHXx1U
	V3dOkOC0kPqH/+gcJ34YZ/CjakfyDe0+hP4f57omsKrM3PkAi/4SLGQlAtplVTJMaLVL5St/WGp
	VNJBylhBgJnlZeMlm4OOTEAmguE0=
X-Google-Smtp-Source: AGHT+IHZIhHKyOoGl1Ty0n3ZwEXDNsNQ39lzHwnLbXD0RpAXpY2al3qAt3xUJOC0Bx1QSBXax17KvcTqzyNFH3YhVzQ=
X-Received: by 2002:a17:90a:e296:b0:2e2:de92:2d52 with SMTP id
 98e67ed59e1d1-2e561a58096mr1379700a91.9.1729262317102; Fri, 18 Oct 2024
 07:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-8-fujita.tomonori@gmail.com>
 <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
 <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
 <20241018.171026.271950414623402396.fujita.tomonori@gmail.com>
 <CAH5fLghpBDKEwW9maYD57O9+FuMDtVUJm7Dx6JdvjS2p5ZQNbQ@mail.gmail.com> <146d0bce-19c8-49bd-be9f-511c8e9b21e5@lunn.ch>
In-Reply-To: <146d0bce-19c8-49bd-be9f-511c8e9b21e5@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 18 Oct 2024 16:38:25 +0200
Message-ID: <CANiq72kFThZO1vEHoebPav=tEDYsT7VXdqDW+YHJ8iXo+fG9DA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Does this allocate memory? In this case, that would be O.K, but at

No, it does not -- it is all done at compile-time.

Cheers,
Miguel

