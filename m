Return-Path: <netdev+bounces-99387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF918D4B35
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD91C221DF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F741822C6;
	Thu, 30 May 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgmusCt4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569905337C;
	Thu, 30 May 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070473; cv=none; b=gvyECefIffET0JdmpWV3/0XMh9JSuMhIqzIkTnZm4LELILIMMZxsUkCpB3sanbvHAMSROu414tNE7aNmKp6OYGDWLTkOLNdQvNBxlNH49r9rfaH+E6CjZmph9mv929yoCEZH1W2cF4kubye2OQc15B6c2YhisKYda+HL7+ALpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070473; c=relaxed/simple;
	bh=XLJKre9lM4Hdi9pCiyx7IxOa/7RTj7xY1R9XAnRJ+C8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CBwNrqRUU1kz9gqwRkf8gXnd7k50Hh2o1xp25qJi1TMngzeXbvfUB6DWSZTINBf5lLpbrNTh9T+qHu6s3Ox4cjy2YZJPqHV7LYRNjJDyXIH/MHzijQHpvMCLfXJMy+452By7iH7ePdtiWQiKDPydcXTqal9rNmsbB95WDiZRtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgmusCt4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421124a04d6so8574765e9.3;
        Thu, 30 May 2024 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717070471; x=1717675271; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WEQrqGnC7qOz5yKXUSVLSaKtdozBtcwCP1LShsXqGBo=;
        b=TgmusCt46PwBW/2WNE0XYOyqI6/0yIJzy+ZnRBb4dZSrgUHBNRVXd9KaVelFqCMa/3
         nLc9Q+Na/Nyzs0ALjkp93GuV3WCLuRTsO8YNlaScFOXiQRyiHRTTRFqJi9MurWyiDaw/
         F35uRxZXyCBWpqGpxZgnKVeGRqJ9OPEqyYOErBEeRUl1T1XG38EuHCv1oWJy6I8YqkPA
         xDy6tK3QMry/KR8Yh6yHfAceWbUej7zrnUuPAiZwxK6p00sH80OXfJW9UzKGaD0eLqi4
         Q965AqdurkeUp5iKDWMR4gOCG2lZBFqiSli06yd7cTj4KBJqjRewzv80b4GKWwFVPqlj
         E+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070471; x=1717675271;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEQrqGnC7qOz5yKXUSVLSaKtdozBtcwCP1LShsXqGBo=;
        b=G2uLJ7mD0lkoAliPBbAkt0C/raW5G9ZxbhIejRNlEvcnVxk+gpNWdq6tRmofYYCeQ9
         zOTU2aI9rMOCGrQdJOkNcCx9y01oUztJ/V/kllBcUvNEdfT328N2g649x/+FiMTBakN3
         dakJF1chfvyBcLXvttPqM/ewn4pLCsGrG5/kNXRy/439ndiroJSU2wZr/bcGJlS71V2X
         s5KrytcwbksPct3YCVDjRaP5AnKkjRqwN7IBtl8uoCvShzIHj9QXXtWQJW9EGdAVsNfP
         Dee6gPZd2aZiKs2FdztVKu/zWE3s05shJztbVXAYue8bziHZbBdBA/5nREV2Ij4Bm+US
         ISqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXSMKAJZ6ZVmjICaqd+J3Aq2dx9Z64hoY0kwHYs/pyFKQsgMq/p9NemIY5DWLH2zF1oFHn99JjQwd/6k2hfN2Py7jqgGLh2EGLcJOx9gkJsyEbnUVk+PdEkV1xJS3nl6w+yVY
X-Gm-Message-State: AOJu0YwKoAGiLdcfzoFqwBtx63EkSdV0BPTL+namGc4vDuRhNAH3/MM6
	lsKuXZ9u2Q0HOq9MhAnR7f3lw+iWH5dszzCzUa0LaDO5Ro3mbAwEb7CgtnDz
X-Google-Smtp-Source: AGHT+IHQqtiMBnCHQwIS+myk5eOGoXwO6b/L0RfVeHWUZv+ApdJ5ZPZNJeNe1sB76GA+qbdt6tUmTQ==
X-Received: by 2002:a5d:60c3:0:b0:355:513:f08b with SMTP id ffacd0b85a97d-35dc0091800mr1260771f8f.27.1717070470393;
        Thu, 30 May 2024 05:01:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c8da:756f:fe9d:41b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a09031esm17156567f8f.49.2024.05.30.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:01:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Oleksij Rempel <o.rempel@pengutronix.de>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Dent Project <dentproject@linuxfoundation.org>,
  kernel@pengutronix.de
Subject: Re: [PATCH 3/8] netlink: specs: Expand the PSE netlink command with
 C33 new features
In-Reply-To: <20240529-feature_poe_power_cap-v1-3-0c4b1d5953b8@bootlin.com>
	(Kory Maincent's message of "Wed, 29 May 2024 16:09:30 +0200")
Date: Thu, 30 May 2024 11:31:09 +0100
Message-ID: <m2o78nd21e.fsf@gmail.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
	<20240529-feature_poe_power_cap-v1-3-0c4b1d5953b8@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
>
> Expand the c33 PSE attributes with PSE class, status message and power
> consumption.
>
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get
> 	     --json '{"header":{"dev-name":"eth0"}}'
> {'c33-pse-actual-pw': 1800,
>  'c33-pse-admin-state': 3,
>  'c33-pse-pw-class': 4,
>  'c33-pse-pw-d-status': 4,
>  'c33-pse-pw-status-msg': b'2P Port delivering IEEE.\x00',
>  'header': {'dev-index': 4, 'dev-name': 'eth0'}}
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 00dc61358be8..bb51c293435d 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -922,6 +922,18 @@ attribute-sets:
>          name: c33-pse-pw-d-status
>          type: u32
>          name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-pw-status-msg
> +        type: binary

Shouldn't this be type: string ?

> +        name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-pw-class
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: c33-pse-actual-pw
> +        type: u32
> +        name-prefix: ethtool-a-
>    -
>      name: rss
>      attributes:
> @@ -1611,6 +1623,9 @@ operations:
>              - c33-pse-admin-state
>              - c33-pse-admin-control
>              - c33-pse-pw-d-status
> +            - c33-pse-pw-status-msg
> +            - c33-pse-pw-class
> +            - c33-pse-actual-pw
>        dump: *pse-get-op
>      -
>        name: pse-set

