Return-Path: <netdev+bounces-239739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D5C6BE25
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05B7935FE93
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36828DB56;
	Tue, 18 Nov 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxP7rhOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F822773E4
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505566; cv=none; b=JoAAJq8PXhfKriaYvL8zbutX+cRcdvW5BbJsmZqDzp0+IDvI9TPnQk9/jFfClVVWF2fQJmfRiXh3PtIVjzOH1qAHERCPE+3Q1PoSWH0JtHHw8H5ODvQBUX8vJ7aMP1UHl9kVu6au6jLRbaW/0TRGa1CAi0jPadkJcAZjUWoJx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505566; c=relaxed/simple;
	bh=c9K1HPWHc+vdEmZJTEBZWKyZ2QFogyTosyvq5Gy5IAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS+eB4jwIXAG0bzejB07BiZjoxKBD/N351c6NSnKaAijL643Wh6Z4djxQWjojz8eXDe6A987V2krBoGR4rp8yWrMmT/kNsSO6GeE7qzVejuXu08XH/kuB2W5DkYU5aeSNCbi4dbspywgvcsyJFJGmP6G4euJLSJ1V/RH8rCxi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AxP7rhOT; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640d8b78608so4574245d50.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763505563; x=1764110363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9K1HPWHc+vdEmZJTEBZWKyZ2QFogyTosyvq5Gy5IAQ=;
        b=AxP7rhOTDDvRlFEBom6Jfq0U8/J+ht2yWznf++cPHFDPQLG+beIR6MkbwW++IU8v8/
         ITF7t8QN7W+AdrGMqgyoANvU/J3GSl8FRe72cqG0Z0ahJEq+aFNRVMJRrP1j3lSrSf/R
         SalBn9fq1bgbLTSvdt+AgjFh2RfOIsITnTfj+XQ4KINqiMLTxRhjMjdab0u1/WP/6ujm
         AH9Si+CQuXMU3xmRUhyONlqMX33lQ4R8wJYu8Aelhwsr9Fq58JHD/Isv4TSeXO5jEfmx
         2iUgHBxYlRBDhfup5+mfRKXQqhW5m9A23g+8c3AMV2TY5lHLLVyjc6/ETFcWQhOntD2m
         TtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505563; x=1764110363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9K1HPWHc+vdEmZJTEBZWKyZ2QFogyTosyvq5Gy5IAQ=;
        b=GmxpIwd0g4jibgQd7MaLwQslVbZ6qNcAQuyw6osriBnB4Vz5Rp9McB+qZUftVrUjXB
         Qq5iXAbHmkyrRXS/9Gx4DqoRUdP0fIQ4e6uq0LcbMctOJy/krt+9Zlmg6QPzuPhXlvGH
         kdodmPJ3b8tKjGy1BdO/arkBgWK4B6WvOiEzWSRhZeiVlRTx6BcuuTIVnk//+P42pqpE
         /MXaOmm0RG04XFd4PG6/4JlmSDZdAHjQLHGDI/GHuMEeeD9bDdtBNN0A58BiX6GPOvAL
         7rmMcTqHkH3rI5GpJWxnx2zUVjnBIm6EptHb7m5DbJJsRzpnK9Ps+T4q41Jp5O21we4y
         cP6g==
X-Forwarded-Encrypted: i=1; AJvYcCU0z1fQUq5/JtQA/qtLYhOKWYFcH8x/qNQHS5+/MD0AcNxlMArpu48LDOjknGzAJV9sbmoK5N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZI1GBR1v4Z9+MkKianZ5dto9FZ7du5DKpSw5d+TJdoudx90n6
	GqIhSynfJrs069kgPKDjIFtSiU7VahcFz8/h99enZm7XoTBA4O6VtlF5yTGL0FJWCIMO1WhVZ+s
	zALNIruU36Y63Ol2uHvPnuZyRWXOaF8Oweij6mO3muQ==
X-Gm-Gg: ASbGncvY5qWZxu63hfLC0Bfpe2ScDkmRc/FdRq/Z5j3hxueM5+EisAXg0agfKUBz5Y5
	hpusETl5rJmCFGVBvY0abd9hHH0TX5wIIJkGFKuKcgz0rWxYDjOxdEOtFYvDshg3R6VdRcxAXwX
	wIclHB5RGFpOUyxQTxOlnEt6d8hj9GrbM3GP4jcBrwXEb8TP3qBxgJKpjG0wvBitNe0RdNTKUJy
	UZsbYAHaGjryOLrL4D0b1VA2UgB8iAkHByRzwUm2Y8UGL+MupW7hEJazOuQtXneXjhWf20=
X-Google-Smtp-Source: AGHT+IEDPiOPMPNifkCU+5hhmK93KdxSbeKelQxg70KsT3WoWLS+FfuY6DIqmyHZ4497NZrYxOtGvDiHvxRbaYcagG8=
X-Received: by 2002:a53:acc2:0:20b0:63f:948b:fef6 with SMTP id
 956f58d0204a3-641e75e68f5mr12470525d50.43.1763505563455; Tue, 18 Nov 2025
 14:39:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Nov 2025 23:39:09 +0100
X-Gm-Features: AWmQ_bn4HyQrQLaTarXnDEAC7QyOjldYFoPy-XdjYDbVht880rdNkqaFX1a1Qjw
Message-ID: <CACRpkdZbvCRxbRwd+wLntm7b0V4f7rFKhifk7QUySsTt3iHM4g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: ks8995: Fix incorrect OF match table name
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:54=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.=
com> wrote:

> The driver declares an OF match table named ks8895_spi_of_match, even
> though it describes compatible strings for the KS8995 and related Micrel
> switches. This is a leftover typo, the correct name should match the
> chip family handled by this driver ks8995, and also match the variable
> used in spi_driver.of_match_table.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

