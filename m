Return-Path: <netdev+bounces-155391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCBA021FF
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F199B1610A5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F11D8A0D;
	Mon,  6 Jan 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKn8RFmp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF819343B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156226; cv=none; b=CjkMuPaALmWXe+iXiUBX2mEe5aNRCsp9yAAs11s7sXR4M6/9/KPzjq/4p/B1My7H33i+1A8oXhDaMvruoTC4YQfLjcjDxzniGRpQooPjkAhMhqo4F6GPlnCmybuUy1Q70JRQgb+7B1xp0IwlhlqtznFC0QZQlH0YoP4zdFYOa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156226; c=relaxed/simple;
	bh=9Ee61o+dLYaYGtaFFKWcxYn1jzSZS4OX56co5t50dxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJT5iLK+fijDaOkxDLljl5/wyntJWqd0ymhzUlfROvb63gYuDf0R/KpAF6IBKkaV5RBBp72HLj8QK29WF42PoRowMAvOKcCYGSADpFWqlD4fDhDByh+WxEQ6Spn0jhzuGV2bGw/qnd8RPC4AZjSEn9wMGdtw+JyTofBd52k8mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKn8RFmp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so685146a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736156222; x=1736761022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ee61o+dLYaYGtaFFKWcxYn1jzSZS4OX56co5t50dxo=;
        b=WKn8RFmphm/JEm//B+XVSPa64s7hHOpakO5ZheBsrkUBR0bBx3jLhM9Z/AZCC+ZSbr
         crO7xtsB3iocEZfVNW4TdA86dib11B5Lae3aJO7DMwghmNdGu3riTYmfjdvF/qkBsewF
         Rg5KgOFk1W9ZxMrZpfdmACxoQuyOLWBO/Of9sfg0MBtPAj2HQGLROiUWDdpJtOjhfavp
         4JvQ/xcw3YVindR4a17qxEhFmio/BOgpPCHO7JMAOFJSBJpWMYECy7ss2ChUTAgsMuMt
         VM1W4Sa4quDj4Wsm5lrd+Dm+Yi0MFUPz73Anb6Yx1taN0yYfm1NnMPkA5U08LROR2k6h
         U1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736156222; x=1736761022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ee61o+dLYaYGtaFFKWcxYn1jzSZS4OX56co5t50dxo=;
        b=Vxho6Y2W03OcgKer+gjqJTIInbkgX7rYNnW2GjJw8xJevSkN+m0VOQkDybQGJdpRVY
         kH90qABmLt9FVkKWCS9dCl2PwbDTM8yg0tYwlu7mo1zZ5XsY9QstkP3eZMdv5QK5xlgT
         9moK7kHcEUoW5t0u11rrSIiROrwLkOdSGuHc5JnkkwA5hUeu/POVxSWi06ZQNPTH4T9P
         QMN06AEvPHB4ieG0dna7hIrJcbk7TXeaeN7Ap3IP3QKohEeAl7LWGubev/PMWzM7zC1y
         GPjJpKn/AYznsVqkHxr4+2o9MGN45u0Ki5mHoWOf7HD4ELEVKCjltu1QUhZT8z98yI3u
         6Gpg==
X-Forwarded-Encrypted: i=1; AJvYcCV1NRw5LGh8x2QGm2SnJUQN2lZXdVPr8tp4iFkwXa3o4KW2hMKl9Is/GvJsgKgWIy54DMK+XCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9vg1fAK8RVcZs5ceQQT87uwxKK4d7Prqv4kG/O2WXmMzMyYy
	iKVMsGIJMd+On+1QwxXPPpr8QDtKQvz2CXHFW8zA2hhaicnp1xaoJugMU736YjADjdCwqWvRWN+
	SRYQnR0DAamYez5K0eEpBLU+qykB0KUW6c4b7X6vgalcl7EjDQ90y
X-Gm-Gg: ASbGncv2ShKFRoRp5m73uwBaDPTiICnQFLDEl0OURF/HA4hAyyezvHMqceAaFMxo/xP
	6dcE1IWgzqcD0+IWehY6gRenr6P5aAQmWIz4Vzg==
X-Google-Smtp-Source: AGHT+IFVULgnkSurkUb7MIT4deWYunm6BrWzEKJmGfjPlhDfzLAiMgfKd3p7KUrfrAYnn/O+J05GayPmqWF8xBkXLBM=
X-Received: by 2002:a05:6402:1e8e:b0:5d0:8359:7a49 with SMTP id
 4fb4d7f45d1cf-5d81dc74098mr45851706a12.0.1736156222161; Mon, 06 Jan 2025
 01:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-4-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 10:36:51 +0100
Message-ID: <CANn89iJ+QArHMDG5RBak16-a9NObQVrWKDXKtQd6AEEMLqzV_g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] netdevsim: support NAPI config
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dw@davidwei.uk, almasrymina@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Link the NAPI instances to their configs. This will be needed to test
> that NAPI config doesn't break list ordering.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

