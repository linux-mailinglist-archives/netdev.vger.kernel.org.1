Return-Path: <netdev+bounces-160296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E1CA192DA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC683A197F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7D211A0C;
	Wed, 22 Jan 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYTrXeIA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F228F49
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553579; cv=none; b=U6fyVOGWa5iq9qQp+9tqSNGuVVTK3eO62kYjKeoNUdon/ahJowaANWmDOEkQflVxL8bDezXBG7KylHCgEuISvJ1EN52y56Z/kq5YS9C8sy1+6nTiKDZi7IGn3bRyJPMhz+gA/IuaTi5TFxtHSKUhyNBTJfg25kGCBVSrLfYmaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553579; c=relaxed/simple;
	bh=eXXv6pVLb7iKan+715mZ0jt8WuyNHV9c/5N7O/RDLp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rD/zXh7AxJdZkHL05FMPRCrNIP7n5BivYFNrutHD/e1P3Pi7jekWAMNg2cdGe8Vbhjl8ngaqo3qujvzHPE9Imr6qMKdvrf9hAdeq6d4nqms1XyEUZR6mKGRXMImkb4dURILRLdX22L8BNRKayDI8jCDaYTk0gzKdywkH2bLBdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYTrXeIA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso11771182a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 05:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737553576; x=1738158376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXXv6pVLb7iKan+715mZ0jt8WuyNHV9c/5N7O/RDLp4=;
        b=FYTrXeIAREW+Fj3SXtmSteP3xWYMA2U4yghfPHkPvUSd/worWOZmb5Za04S6U4pLJf
         Zoji6fKOhIqayi/kNv8SbGAzB0R3TDglIefPRr5LTLPYlX1oTsG7+oFW2FOHKVqLuBUx
         NlHUSRizhju3ty51Xs7aNyeyJ2zkHn5s1BnfqOG0B/lJ3qhf9abhAHy9J+uQxTFjV809
         dYv3Vlt614bFBsHMHAUwRgOd5Qj+so8YXX5SE5VIkrO30zK/hMm0YaFmjXlZTDBu4sIh
         MBctntOpCJtltlBdBYZnIpSgnkRo9SVpRZuIZj/lb5ioW3FynAscYxm99VE72xWOzOz1
         CtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553576; x=1738158376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXXv6pVLb7iKan+715mZ0jt8WuyNHV9c/5N7O/RDLp4=;
        b=p3+Kdx0neCpvmZRKNX4T6Vme3vGdbeX6QYNAuzJ8YsNw/K9rQgvfBIpKcJrsKZ6MwN
         vvnzlEww9i2NFcvoDeoxGPpSV0E1D+ubCuRTU9htkXpdpH/nIOwZoVThAHrzzKbLvy4/
         eR/SFq0CPX5niGDEWlXo9qx4pFGF+EC2yNINeEFcx+OoHJjsRWDYpLF3OKskSHFmSWe6
         Zq2RAb+NUH8g1+50iiBnhtXaFqH2QudWcNWnLj3WSHG41FcKgkDXPdlOwwJId4azV3mT
         Khac0Yty2sYaRLVDh11wxD8XkVzG+0IfyfgDL/A6kIZPP2oVKvPQ31ierf9naCuVOpXC
         DbJg==
X-Forwarded-Encrypted: i=1; AJvYcCWkagpCspmxrK6bfMauWHSWqfcP6jqBissi6JFHrt2g6e4ySyqvbvgnpcB/PpBXDWI+jQAYVZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhcl2Gmxc2sWABPzy40CxTDkR6oAZc3Af31NwWJGA/vdvlpV9
	eA68u2Q21u3eCEXRXH7QABiCPfsBllWFzjaVRT2kwq6v4gIhU/FFhDufFGtGUlUo1GLw1NbU2q6
	o0PHWdzawcvyfenT4IXlhq+0OyUrhiQK3kPBg
X-Gm-Gg: ASbGncuBzgfX6xFpORoa1j3txRaXzjeqZ5VINYXzHVM/BanNA7GDlpjb7jtvw5kusEn
	R+qYBLjbdWgG/H60UC52BsG/JQM0RLhVSuHO9o7aW3s+XOXtRlw==
X-Google-Smtp-Source: AGHT+IFleg/DcxGzAKFeQ2GbEp7LmcIycng1elrdcDLwiVvtb7Mqkcwjc46SpwPVCJktx5MTZvztpqr/RjMPtrcmjn4=
X-Received: by 2002:a05:6402:2341:b0:5d9:f5c4:a227 with SMTP id
 4fb4d7f45d1cf-5db7d3550camr18461444a12.20.1737553576194; Wed, 22 Jan 2025
 05:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-3-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 14:46:05 +0100
X-Gm-Features: AbW1kvZ8_9mabLHytWnb3dCrkVHjmrz8m9NGZlk3qg9OwLCIpvz5BZer4tdAzR4
Message-ID: <CANn89iJqPUm+=OOHoMTAp=K_LD196AaQdNUzzjBE+AZnuDUDNw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] eth: forcedeth: remove local wrappers for
 napi enable/disable
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	rain.1986.08.12@gmail.com, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> The local helpers for calling napi_enable() and napi_disable()
> don't serve much purpose and they will complicate the fix in
> the subsequent patch. Remove them, call the core functions
> directly.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

