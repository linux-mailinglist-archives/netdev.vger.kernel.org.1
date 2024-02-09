Return-Path: <netdev+bounces-70524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356584F606
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49CC1F22DBF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1793C680;
	Fri,  9 Feb 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="opTZal+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A4381DF
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485427; cv=none; b=gw2hQWHxIRWm3l7T70WCh3mPH01DLxda4nNCwPqCEdW0YIVeReKQXLn6TNUCb60YSOqTAMyMLE7aoE6omfxzMOrTcjWNu4Vxm5/vKyRh2uEMinyRn5kNf3pmJE+55FlmY66i7ivG9J/sr2yGnZnuEtn16+ALVm2pFatF7I/FBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485427; c=relaxed/simple;
	bh=8sIFxxTA+kFZT7SMBIXRaEJWo4dhzYR5M12NFQkTaLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMVgTZcZbf8ROlIKmYWklhxxZBoQUQkXJc6Mv+b00wS0eiXUWaWxIgvavNIxExBqZHRtcv9SWHtj6oZ0VHuG8j5mtH+IUELaA9G8Msr09c0g1nIeh+Bczjxhwf+/VY8c1znQfNCifyu7jxPMzafi6z45q3AW+uAasTRQALG+39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=opTZal+3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6002317a427so9248377b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485424; x=1708090224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sIFxxTA+kFZT7SMBIXRaEJWo4dhzYR5M12NFQkTaLM=;
        b=opTZal+3GWton4PbVJOzkJLfu8s2Xz0QtWxMPN9DSLEEPLBJUlxg9I6Ox7ksXM2tnN
         QhZxGO5cvR2KO8+TYF+zwQlKPHQH8d6brgrJDkBfwYxt7r3UEQQjG4xL2JQ8fei9lYiI
         FCJuC7F4XkDLCGuTeb6mh3UbSABBh2O6xuzTf43ncToKgo5Xp7OL4A/ja3uUGZPTxjT7
         pmeHuhdSjTgJ8P/QqZWkarrBgovkT8dpJr8mAnHlylemZ34vQ1NVPQIgMCp0mm8o0B5i
         HL2wIWS8fAzKi1ECOToHZlByWmEcvoboaz+1EqmNqQ1THw2E3eLPSLzItDovHsCesF39
         f85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485424; x=1708090224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sIFxxTA+kFZT7SMBIXRaEJWo4dhzYR5M12NFQkTaLM=;
        b=fdenCV7htRw8GM1nU38Cyiv/TmWw26Z8veJ8LMmCcqn8DgrWaHnmIFP15fR7MqWLoZ
         pEozY3sOdEZL60db/OtgKruzUwWnYe6TuNPpa0NH0oP18m0/OsrbuRBkqJn0JuLy6dnp
         xKPemuoUuNFnDzsAnLOFJ2ZxCbwA1qtJxbqvzDNeFT2pOxkHUWGDae1725ksTPiC+/xb
         RCJhNwUaikVZ7HdLnWm6XgxmAV6lpRtwjTG9QpojkJjLarPXxlkJznaPbPHCew9UC24G
         wH5OdonjpVooxxgLTEVmba6qOe7KJEy2/eM+UU9lFeAkvBVSmtYCb0HNqQM88fljfESn
         9dMw==
X-Gm-Message-State: AOJu0YwA2Ww4iDMW4z/TI9BEabj7RFta7/XDdQrAlOj5PSr8u7TTuywQ
	WJZllkQVZW7ArvVUGa5Mmlvj6uT2yra2H+Oh26CS8ttFF+WD2ECER9+aARTXuqJoOGBBHqNsJ2T
	uWI0RZwLfUXg9ZDRkl+G5muPhUMLr4WK1Ht/VAQ==
X-Google-Smtp-Source: AGHT+IHZCQ+5vaXpkmSIUlfItwQ9qMjUfRrkgkps5uTRejECLhETkBx+m8+gijhHiaD5kznd/7S8AjDjJU6Ow1aTtaE=
X-Received: by 2002:a0d:d8d4:0:b0:604:9427:e169 with SMTP id
 a203-20020a0dd8d4000000b006049427e169mr1481315ywe.27.1707485424747; Fri, 09
 Feb 2024 05:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-realtek-bindings-fixup-v1-1-b1cf7f7e9eed@linaro.org> <0c47da33-3f50-4b31-87bb-3aefb01c0e47@linaro.org>
In-Reply-To: <0c47da33-3f50-4b31-87bb-3aefb01c0e47@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:30:13 +0100
Message-ID: <CACRpkdbfYnUDq3a+Q+nDgUdYZEg_vFSEvkS9S6axypkt52giTQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: realtek: Use proper node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:47=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 08/02/2024 23:40, Linus Walleij wrote:

> > Replace:
> > - switch with ethernet-switch
> > - ports with ethernet-ports
> > - port with ethernet-port
>
> Would be nice to see answer "why" (because it is preferred naming
> style), because what is visible from the diff.

I guess we eventually want to get to a place where we fix all DTS files
so that we can simply disallow switch/port/ports without ethernet-* prefix
so they become easier to read (you immediately know which kind of
switch/port etc it is).

At least that is my "why", also yours?

I can add this to the commit message.

Yours,
Linus Walleij

