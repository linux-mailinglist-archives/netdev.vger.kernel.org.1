Return-Path: <netdev+bounces-213342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E45B24A24
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6201B60B5F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A22E62C4;
	Wed, 13 Aug 2025 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbaSs9qy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A012E6136;
	Wed, 13 Aug 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090371; cv=none; b=H4YFzUH20p9TwxHMFEydMeDz9p4e5QZuWZ0VT4k1xvOisD/QhFyRg2ZNXea9YcSMAHlmCL7onjUfrAsB+PGeh5xNC31rhISEnJfdeYZEQ9Gp1rv1C+78sYDiROHyl2+4rO764PLcLLflfpTulUgUHdt5nbNsC0eSGh3cNcyfOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090371; c=relaxed/simple;
	bh=r+IGYqrvJJjZmyKpusqgdcFNQmtdoepMkDAxfPj8LiE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=su+zGcNEbsWvRE269gZvHdrWAB5C/qaDEAy8M5aA5VUQTUEy1I5j79SOzHNamqqbIfy0d6Ld9mwwaDcJZJUJdaoKXQIA9vmXj5M71o1QfLfAnbbmD9SjL9kyfB5SUySt0mM8UjInQNAUUsDFryGvcPvnehRU3rcf0i2pi45EHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbaSs9qy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af027d966eso77952321cf.3;
        Wed, 13 Aug 2025 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090368; x=1755695168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kOBiwAHY8I7CRdoG3Ej9jT6nAiy55atfze8yFZhgSw=;
        b=jbaSs9qycy8i3UqY9We/jBMh8FOGp0b+pRd5re8JEv8Aok/oW+iaH+hgyP5/zd0bjJ
         pgdonDeGn9XR+7mYALs8G3gKX3LDUOZbgjZe8Pxs3IbE/XdyCBmGfhkwF/tudKD0IreJ
         GhP+4708/8DWuA+681JdPYF7hgEXfnQXGiUNDutBUJ5+gBcOCUfHtTK7QDSbHKqwpz+h
         eZ69JtAvtZ1pmaoZeROAOX+Yw/HEHSH6J1xG4nFWNCZwzsruGwbwScgRIaEcVqRi4P8O
         w3dYgEIVwQnpFcnp7LlOhanX0Gk5wqZApRqiqDV/Coz0nEzfFZIClAB2IDK+AQLepD/2
         FWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090368; x=1755695168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9kOBiwAHY8I7CRdoG3Ej9jT6nAiy55atfze8yFZhgSw=;
        b=mwJvO+bNgeOA8jGwdoVxCN6LGNpTSqO4Gt8hrOBnhGxpbeEL5rN933sfNU3Ox3YFoV
         7KLSLsLGTGvdH2LxFvKlPzNWJEjMh0FHUaMvYIbgSlnBrEDKwmpIxUnTbfqehLC0NCpk
         Tyt2lOF9FfB/EPl/vJyawPVTfq7FCu2EHMoIKil1lQn9mB4D8d5ZeDmDWHnJIw4Vtc3Y
         t6lpUayTcPfRUmvDvgK1FHeA8WbRO9TTdIbVEYYqZKuFocTCAFy66NPnL6YvkymiHJYg
         7RYI5Nlq2QgqPsqLNigdHsxfFO2qRUgmVhPn5gSMie9tsQVQvgxMWHbF9gjGgyudXeqD
         IT1w==
X-Forwarded-Encrypted: i=1; AJvYcCVYVoWC0Kb8UF+zbGc+6SAPfLNpEgnBgcLH+qvGH4Itqk/XT5qKcbK1d9oWppL1q4m1rIqF5TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROKIQhChScF+wWOlVp8+ozB49oWafpIDuORx+2K/5Cfgf5nog
	RfOAnFwE3gVTO5D1UZ6keaPxoQ9hFmh892dDpHcSZJxdVARHzcUb1mOnB5opOi/t
X-Gm-Gg: ASbGnctob5AhXVu8X7EBxjKF+VC6YkqNXdSxTP3vQKatWdLxP1NZKVVmKxl7Hr7V0Q3
	ToWj+G6QOIaYGFAkUgKDI1CyiyHf16DMdvt7igSfFjc0THi8ea+WnLdadnlJgbAOVono0BHFeSA
	0e9bEGsSuE5ys50B40eZFhxT6aA6FTB5FCjCb3bxCGKjvxaijcS+pUP53pLceXtOmkRdcVZC4zF
	ZFaGqH61/AqXYzx1bmErY3jI/SpvGiM47s3R73MLwDV1PhxVAEnUz4iO6KPJfjT2f7G+ZWuCv0z
	NlVTLGXaPuPp0uKbq0khp9hnwiQd4xN0sBAC6BDWwvdofYDkpLMXaX7fasy2iKzLjUClZa7zoHc
	NbNKqNqEDOFJuRB37r0rGOtaNUHLUrrj3bW+Eed1KG8NTCb0QbV1xp7wkM6nalF8TvfyzpQ==
X-Google-Smtp-Source: AGHT+IFlCSL9NVKYRT9MMUQ7J4HVQO1dCBWU1ZOM7+9VzfwOV4/qNiB8HhpnJYW31G3/H/rP16/cKA==
X-Received: by 2002:a05:622a:cb:b0:4b0:b5ba:bb9 with SMTP id d75a77b69052e-4b0fc8924aamr38950371cf.56.1755090367779;
        Wed, 13 Aug 2025 06:06:07 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b0f28b7422sm26605721cf.59.2025.08.13.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:06:07 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:06:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWlndWVsIEdhcmPDrWE=?= <miguelgarciaroman8@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 skhan@linuxfoundation.org, 
 =?UTF-8?B?TWlndWVsIEdhcmPDrWE=?= <miguelgarciaroman8@gmail.com>
Message-ID: <689c8dbe91cf3_125e46294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250812082244.60240-1-miguelgarciaroman8@gmail.com>
References: <20250812082244.60240-1-miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH net-next v2] tun: replace strcpy with strscpy for ifr_name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Garc=C3=ADa wrote:
> Replace the strcpy() calls that copy the device name into ifr->ifr_name=

> with strscpy() to avoid potential overflows and guarantee NULL terminat=
ion.
> =

> Destination is ifr->ifr_name (size IFNAMSIZ).
> =

> Tested in QEMU (BusyBox rootfs):
>  - Created TUN devices via TUNSETIFF helper
>  - Set addresses and brought links up
>  - Verified long interface names are safely truncated (IFNAMSIZ-1)
> =

> Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

