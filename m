Return-Path: <netdev+bounces-137310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF64C9A5551
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 19:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27747B218F4
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB193419;
	Sun, 20 Oct 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/2C3++t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8387464
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729444607; cv=none; b=h2s9orJiwkUzR/ZhN+9q4wO3HyJwwhvwanUXcBrsXJqkQfwMoHyZbvx8cq+lPUwstZSRBuYSZ3uoRAHUh0KaQwDrCGHzzd2tVwAErwstsLlQHzPStc0EmB2QDR4vhru8iY0wNh4jdLPFPFwYnmwCBqE1NebozzOI1UlSczUvGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729444607; c=relaxed/simple;
	bh=I6V8NQTEyfLTTEBu8Sn6bgUyr3ui4C1po8Bgpjc1aIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeidcVmr/ucTsN2o60PnN6Hr++Pqv9Lek7XZ4M73jpY1/n3ng5k6Lpat4n+dPrXTj+938ZM7J0QLR0GqlQdn1OX2/KkA0TVeKubbJkvqDNO1n5yU9YvUmxhzzp63/mMSbiVTro1BN9NWWtoXwuZI5dTrrBXIRdWpwDLGQfiemrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/2C3++t; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so4124547e87.1
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729444603; x=1730049403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6V8NQTEyfLTTEBu8Sn6bgUyr3ui4C1po8Bgpjc1aIE=;
        b=Z/2C3++t5QXX7Pk7dXd3W/jDl3pnzJIRzPPVmlsOZYdiHnWtz9J1BOjTCAPYMkEFDH
         wrVzqsjU/kEjUQ9T7aGcdLUoj3XguyjyAH01Ot+AGI3mAlZP8k3alx0leDjUqb+tZeX3
         tjhU6Y4j6pAc0w/xQ9hk7lKy2WuJsTtTwyTzdtugPnwTltJPrFItj/JFNgAQqLs6NjCY
         pjAy0VWmtdOasnJmQjQLRdTLsz8f7kZwnUo+Tiz8644LBbRH1ppPzrcsm895hDzfeq1w
         cCXpfsWpwqpBgZP9WXQHfFIbGFk34zhxWFn8pn8vanL/MuoYERQg4DsZ4TCIRyzuNMuO
         mGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729444603; x=1730049403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6V8NQTEyfLTTEBu8Sn6bgUyr3ui4C1po8Bgpjc1aIE=;
        b=Zhtt7NFdFCYLueSTBibqkBw3J/n8OmrKeX7W/JPxQcdzhmkSqgaODClCDv8UQSdWKF
         EJfwpDz8BUX+fLYUFVWXLjr6Z4UtWnGUDjfDSLZ5r/M+KweiMO7d/UsSn/0MxiDN+oea
         pYTvhLt/RU1mA0vk68ynxtxwMwDW94JhbvOjZztqFyEjpX5AuiYDw0yJE53TTGIe6Kp5
         v46Eaco/CdHLegCSf2Jo6mtLkFgERs5HN26v1j0c6p3yn7872VJpxjHu25WbbBgRoC1Q
         dkJiRTt5hU8AkqpYVQcygICAirwPxzBtuPTGwFnWUBVnWSluXDpDMVd/D5rgUy6S5i3A
         xk8A==
X-Forwarded-Encrypted: i=1; AJvYcCWEF5hD4T8SUzBUwzq4ciFNcDVK8nXsezptaQo4uSSnSgyHXbvmFsIo+Up8T17M2UrEjPVOFiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfP02lPHEwt7nyu5w1Tw8UywP4+98S/T0+647euS2rVSOZCPu
	kDEiwS6NVe6BriAZTxx9Ci/5EVfgJneUpsG/KFjyEen3Is9BCH2S7H9tz6X7HqQjPu7djUpn2tN
	o2+EkVU8JzY8DZt8K1byXnvVnhhKcsoyxHBpfHA==
X-Google-Smtp-Source: AGHT+IH2AqgSuWpQlh9ompn1q5wHaPZ1qFxrrbdVL9MqfxAkitzPq4pNAZ4XtjqY2wjU946yO1MA+AFW4BI1c8+w6HQ=
X-Received: by 2002:ac2:4c48:0:b0:539:f699:4954 with SMTP id
 2adb3069b0e04-53a1546ca04mr4715042e87.58.1729444603333; Sun, 20 Oct 2024
 10:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
In-Reply-To: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Oct 2024 19:16:31 +0200
Message-ID: <CACRpkdY9jaXDoFzCC0ejLZPbbJ+QAgsb+QE29sDEw0Htgej1HQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased
 fwnode_handle in setup_port()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 10:16=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:

> 'ports_fwnode' is initialized via device_get_named_child_node(), which
> requires a call to fwnode_handle_put() when the variable is no longer
> required to avoid leaking memory.
>
> Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
> and is no longer required.
>
> Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

I was as puzzled as Andrew but I buy the explanation.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

