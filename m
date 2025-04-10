Return-Path: <netdev+bounces-181380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4248BA84BB2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF834E50EE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B328A40F;
	Thu, 10 Apr 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+tERaep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D31EB18E;
	Thu, 10 Apr 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307468; cv=none; b=XIDxaxRzssS4tOuCsp9gFqNd+9DSg1Xn6ayyOOywBhDvI7KOVeopJq7RyTEEmp2Qtryby9bZQrU2e4dY1pobCjsHCxu9COxJdg7p/9kMVYFUfLNrLOwgKjFKRGNKz7o+qf5jiP7el+eUcmHM/BszA4VFfaKEkCgN/qd7BOwuCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307468; c=relaxed/simple;
	bh=wAIBZyScjM9GzfPH5lVVoYYeJAwv6s5c/MC2TR5jzRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO1w0sddwGh9FrOSrPquyDmvs6m6nQigtIQeGsjVEGvjhEauHHurnxHNAAVU/RjoKB0fHf3jA6vvQw5wJUcnlk53le4kU2WmL9NUUd3EeI7Mg66fHC1gUh6DQaAC4ILJNa9eXjim0lp0fCnJq/H28cCxTENMF0wV6dExeUZh0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+tERaep; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac29af3382dso199424366b.2;
        Thu, 10 Apr 2025 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744307465; x=1744912265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAIBZyScjM9GzfPH5lVVoYYeJAwv6s5c/MC2TR5jzRc=;
        b=i+tERaeplQ9gPo+qEg/wIzMyUcSAqBY4e9MAKonWeNzfRPypQ7hekX7QRgWl2L54mN
         ZjNGPG+68bUh02ArzqH2GBvs0CsQpaUmFkZwq7yIYImK5yCSYvvJ4W8Vo/Fo07BXYD8w
         aY9WYv0KEwUd4XSuL2Z70wnjOHn7kSSrkgR3PHKPR047/ePZ+add+GBJM6ZQ7psHRc70
         Bg4r8V/jt5oT8ZOO4Rbxx+hVHc3MPeQFnK0PUUfvauiJiI61y/277M7qf0lrH0Eq386r
         caF+YKIc5SAdG1PoGTRtVf2/lOD4IsL42rS4ETaEJ3Syu4QInKqF9zlYVKA23kLTZMvN
         lsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744307465; x=1744912265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAIBZyScjM9GzfPH5lVVoYYeJAwv6s5c/MC2TR5jzRc=;
        b=sXn4li71FbsJiWzApQaH6K2MRFBqC65kC6WLIi57vQxCzgMYN6zuVkweDiZ5R+vJJz
         KzdBUTyBytKIVRfh83UHaeRBCDW7n3XB3/qCM3WpgnYx/IPlfkLqUQUnNi/BTMSajmf1
         Ydq0RIU4/OvXkzTwzMIq43gph4OLfmIo3puioz1iCEXq3KzApS+cVAoLOR2Uhu4dT/Xj
         b80I+ycY+rUK5zSNmNLkyifErns+OzNb7vjKCEHSDurRoKQ/wWH+b//UD1uuOvlK97+B
         YlqQuxAXFCmSmWzrMuTvjoai15qRalnl37kXA+7eeVQsDYRRdOfQIPaio2iR0mTLjReC
         +wZg==
X-Forwarded-Encrypted: i=1; AJvYcCUE0Y7HVYMAGDicG3m0lUzQmP0NNiaPyvifLWC0k2G1gy4PLIyKfE14ppeSf6T0Y6G/3Ea3xN6HuzTyor+G@vger.kernel.org, AJvYcCXFcErOlAel+hQQW48c5eZ0DyPo/ihi0IePtCWD3Wf+2Xo5UQqQocKge0jMQivQBbTcpqga7PnMV/VJ@vger.kernel.org, AJvYcCXOYY6NkceSt+HgD5zeKlDEFRXfvxICD1nb3dULqhfR3yNpXOsvteqKkR/DGYuNVdIQ8sGBTHlavFl2I/y7DUhs@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOmUYDO37QxHc8p222RKwEBWgQkg7hL7yTR2zJqFqrMfxMBuU
	MNBMsgvQ6s876SLTh1IVCF5TkffEW2WbhjCWCElTSJh8m77pMUBcatvQzKQEPmbiMv73dND8G9P
	IDyl+m7oDSeq9uRZunC7Jr1oRw2Q=
X-Gm-Gg: ASbGncvQGyo5ldvxZG24g+n1z9YomVokJo7L79A82i+uYSkSE2PxeLMMP50ds+H0jHK
	maTsKSO6FimMituHd2pk/n0pf9H8JTjiaM2lp2pR9UmpQjBNE6My7rzgT2x0FLS0nynZoM7gYVl
	9zETkxvO2Hmzg5DSl1360hqQ==
X-Google-Smtp-Source: AGHT+IFyvBWj7SK83evWaCD5ZdH9G9FA79VGWLwbbZLHVeXrUvYIpxpzA4VfWfkVoK7x3RPl/PY5yO58k51iqUYOMJ8=
X-Received: by 2002:a17:907:2d21:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-acac009efc5mr298604166b.27.1744307464559; Thu, 10 Apr 2025
 10:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409144250.206590-1-ivecera@redhat.com> <20250409144250.206590-8-ivecera@redhat.com>
In-Reply-To: <20250409144250.206590-8-ivecera@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Apr 2025 20:50:27 +0300
X-Gm-Features: ATxdqUEASyhvyAg9ecKZpV6uV51rmSBsvBIvrZWcXlI7KyAsqGTqNeEUAqZvRi0
Message-ID: <CAHp75Ve4LO5rB3HLDV5XXMd4SihOQbPZBEZC8i1VY_Nz0E9tig@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register defs
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:43=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wro=
te:
>
> Add register definitions for components versions and report them
> during probe.

JFYI: disabling regmap lock (independently of having an additional one
or not) is not recommended. With that you actually disable the useful
debugging feature of regmap, your device will not be present in the
(regmap) debugfs after that.

