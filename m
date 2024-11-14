Return-Path: <netdev+bounces-144758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F65C9C8643
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A102B2E887
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3521F6662;
	Thu, 14 Nov 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhvRWXqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515561E9097
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576551; cv=none; b=WCbNq3aM+6yNJWY1jhL1oMbquiPcC3UnJeRz1wi98037oRlddUaG0g4rJBCiQN9RFbAR2UwP9SjmubH762R2cwSiz5fEpzr5goQkvz2TrFfJqM4NPs1I2rjgsSFFAGsUzcHhkLnwzzQGC2kzZO3gXd4sPHgkeq6Z1q3ne1AtNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576551; c=relaxed/simple;
	bh=SunWVLxZJU191an+c75kTT6SIArlemY5vm2v+U03SGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd32ZgApT659OiLaFmhIRUXNpaYXQ01m7dnXGX1YwJf8mWRFmj7vC6og+Fs8t9khTXtU0eADQTMqGPSJXnW+57urMw8rTDMmXZOdNXFDRvU5DdnatuF/bZwZpwerYUkocKybPcbQxX5Dj+1Cvj8SLz5PjJmYn6lpHipQzbzvhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhvRWXqr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431616c23b5so1972935e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731576548; x=1732181348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nS1EJqfWpVBxhs4KFRyVItEivrNNryuQ6Ge6sLEQQzg=;
        b=jhvRWXqrRsAlYJ9S8pkTzY1xg+85WR7Oi0e102hsRph+pRtS0n7zLUM93IvtetiOkB
         4aAMWuUIgxgXgfSicb2siZqIPGgVU1RjJCNcHdaBCBMZjvvKLsnrmDcNFgu4YPgPQfcQ
         Egghr5MTB15xIgUt0OlfXX0xo/AGtOiHFd1bCJnAtJoXcbudPTt6q42Yl3aHZLYRiYqd
         rCHyOZzYnAYojtOuygAkpTx+Yy+Xj5OJkIzKh4qnAop7+THPv9onp9J831WvgjLn5gJo
         qYdhngqZ0LKP3T3W//EJIeRviOu/+RBdmYSWmxmd57WSHUHFa8oUrUYnv9kkLn6vK2Ws
         Xfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576548; x=1732181348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS1EJqfWpVBxhs4KFRyVItEivrNNryuQ6Ge6sLEQQzg=;
        b=wEjAmZRf2V3jQFWdUG82hT8Ae7chvmpUDHcKKZIznfdQtHhH1uQ7P37QyKKNZnjvN3
         dxIOMbpUggQPW+C7tEi5Mzi2mAopVP6XSQauB0TV8px/+sWmmJpmPBJ+Ft8iMZbl6haQ
         kOMcC9CdjNcSmMXNMqL3ZbTCM7LYlIT+S7VqAGI85OiWgoTcjfn+xrUxJVXacAIdhViP
         I46SO7RX+V8EEjIOKMhZ8w8w5pYVzArPTwiZQAmpz+FrRfFT41wMkwNeRBeApST09GtC
         +h8yECq/cp9zu0brHR7SlBOoKPyDx4/YAeJb0gjcV77evX9mqNQKp4JWpiyw0J+g5/HM
         8q5w==
X-Forwarded-Encrypted: i=1; AJvYcCWl2QIGFDcWdromwOV3RVsBngjqSH3fXpIXh61gxvMepmszb270wOkNH92ZQU2KhkB0VmefL1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdGJLZ28bt0JZCOQAUlHLGRv9Oxc+lNSwiusTzQhL+rTbFbKF
	b+vpkpNCbltT2twMaM9OT22KIwO6/4P6ToiinnzSqt2kobTNmLHYbBVD9PiGVvU=
X-Google-Smtp-Source: AGHT+IHa+GwPw1XMCZ+cH9jSTN1XwUkHTtzXZGQ1rcTxNIzhWEEEwnyYXS3SOYBkd1TsYzhe+styJQ==
X-Received: by 2002:a05:600c:a4c:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-432d95ad53cmr21357685e9.0.1731576547571;
        Thu, 14 Nov 2024 01:29:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48a7cf1sm47674685e9.1.2024.11.14.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:29:07 -0800 (PST)
Date: Thu, 14 Nov 2024 12:29:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <033f74e6-2706-439a-9c02-158df11a3192@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>
 <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>

To be honest, I was afraid that someone was going to suggest using on of the
helper functions that dumps hex.  (I don't remember then names of them so that's
why I didn't do that).

regards,
dan carpenter


