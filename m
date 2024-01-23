Return-Path: <netdev+bounces-65238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE3839B89
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE15283B83
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3341742;
	Tue, 23 Jan 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efF6GQhu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB42C682
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046948; cv=none; b=HinHjkxSIZePMld6O4cHg6ZeBvjQhKgCDeyKAtdgY5DyN0tqak7jBu4QA90PCM6dVAteHsgDikuCSeCBy1mPnlWxnpQUczh0wGYRjIAvWHewX1BBaFeavGsSLIhqGvLlc+mTgzxppky0wWsfTAJZbLi4Jy3ll7Uxd6cz4TR/r+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046948; c=relaxed/simple;
	bh=0MmYfk6J709jBYBIhVGGWPXUph/cO/3WdPjCaerXvh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1IKCSB/0UaTiCQpNlGvPOEdEX/Vf1OpJE3c1AV4aKQxXDE9LeKH5OIfbfje80yxaeYRnQSuO0LPHMaXPdnrgsYMcjjQOgU028nv4eETjfL+69BLicj7rhaiYM6kiSw6v4DtwJ0ZmqPK6BRORuxQXoAeA6emPhT6LKdoUVqziP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efF6GQhu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf1288097aso11458521fa.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046945; x=1706651745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0MmYfk6J709jBYBIhVGGWPXUph/cO/3WdPjCaerXvh0=;
        b=efF6GQhua96EgqhBNae5E8XFEQFqEcKL5ucEOm7qhxrH0omeKp8qFYoTftmFVdrlXs
         qi8KBpV7H101z5iPDRmayZ3iVlgXkSEoTxAg0FJjBbQw/bF6Ix3hyA6VNB7HTx6fwHa+
         BYu4pUrkHbLhMaJiUPWwgUGtSItDldWRlBo3S3qsRH9FlGrIbq6d6R+cUBC9Qkjk+lQN
         QstdO2sliyosJJALJiOXu1PswhC3M79Jb/fSg6vKPUvASRfJG4dNTASNFBMLCWKTa5TO
         YIy+gTxJB4hhzNnVZr9gFr9lSl8CbTbcOmz4XDUZZWoySq00M0/AMZpiUyK8TZAmS7gU
         f1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046945; x=1706651745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MmYfk6J709jBYBIhVGGWPXUph/cO/3WdPjCaerXvh0=;
        b=trcx4oNlWuR9SVYNMKEYy/iP4eofN03urOu3OYOrRoFFHEZp34m+C/K6BM40gIgv4V
         yEW6pvt1ZHoZAoKnQDssApru2MAnTgQNaBINWCEbU9u24k0gZbYugyj9tMrDKqr2xuCI
         h2oh0yf94vYV0i+7s+y9Z6d09xsUWYeMDnRKSXilvqcbbnp3wemkJ/dqphB5h15jEC9h
         b0B+4jIWNN5YJO/TUslRyujWR1C2c2iNDra8f6mb2crOx6Hx5z8nJ6165oo49XpQSc9E
         yp3ILPIemagCn+XSmPAJ6N4As8V8NGQVdK46pNOMR6V51Gj8hSHXOP2v/z7Tf9OdzOVE
         dC3Q==
X-Gm-Message-State: AOJu0YwwIwh8nPLVf6inU21myMx6ay2tMr9ikSsj8YodDJMngD6cs2T0
	3Wje+HZ/rBNFJbIO6wAau0+lT+p+uVnN84Eip9pOiTGOwUj9/MbAqvztDLowtkAnm+K/XgBya3t
	voGy+UKmgUQIpLqDlNVr3ktczZAb9nCC4V3iaTA==
X-Google-Smtp-Source: AGHT+IGKpAlBltQXixDM1PYPUjeRL6cuYK/pbhZegZnnW7z3VZAiq7j4P0JllKpuwZNZ5yZVEM+p8Kxi+ZKeIAps5s0=
X-Received: by 2002:a05:651c:50f:b0:2cd:1ca4:48c4 with SMTP id
 o15-20020a05651c050f00b002cd1ca448c4mr283078ljp.11.1706046944706; Tue, 23 Jan
 2024 13:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123214420.25716-1-luizluca@gmail.com>
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 23 Jan 2024 18:55:33 -0300
Message-ID: <CAJq09z4H5TmOq4tM1RifGrVQPrSs57dR7yCv=1+gnxZadFobbA@mail.gmail.com>
Subject: Re: [PATCH 00/11] net: dsa: realtek: variants to drivers, interfaces
 to a common module
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

Sorry for the mess. The cover-letter broke the subject-prefix I was
using. I'll resent using the correct prefix/version.

Regards,

Luiz

