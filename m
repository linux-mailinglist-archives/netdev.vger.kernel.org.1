Return-Path: <netdev+bounces-186032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E3A9CD00
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBD173ABE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447C28A1DB;
	Fri, 25 Apr 2025 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIY7oGRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF4289342
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595018; cv=none; b=sVbFZGfLj6apWqdxQPmFIGvhKejUQTR1zqXxz/xCd6n1ihXJqfZeADzjLlWLbYkcqKF7RU5c0KfioUCoC68XQC4d9BQUStphyd8S4n5BKmqsC0Ms9ryJsBMyz6D1NxZPGCG31nKiRE0XUFKaC5taCuMbmeto2ASasyFpLGMlKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595018; c=relaxed/simple;
	bh=ahFIwcIRMsxGsYw7Ro1znBHhQb9IRWhbo25rb6BKN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE/eoP3u9XhjSoIr4BzFHQadMO+XS4R+WzRFbdr7FScB7blKqXXIt90EJEDOHLHSgwDDI59ivFJo5g9/Ac9jiflb50lj9vDlsFe/rWiv0cdx8INGkXiKfVn8SfqaW0yNV43D5tDvc8XWx53ja6uo/tw7qYgNRW1IUw97EYgJ1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vIY7oGRd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so1733187f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745595014; x=1746199814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYX9LNywUVjZ5MKIhmplUJhVT60qSNh9kSQfKfBdFKY=;
        b=vIY7oGRd8jYvnGLP4tQWZxxx6C8AFthUwW6eEVVbdrkJLWUf1be9CY84oNfaJ1Ynwt
         OUoth6j+G8ubGm8ByBCLEEfbsyXOA6cbPDZn0DAnRtXkPENRnVTcEfrl7+Fps/gdzad7
         xwZQnnLEbhGFn03LsCYZNpEkZPynC8+30FV4Kw6oOyrAa+h62XHI2+UKncKY21yZeZj3
         JEaF8XG6RKy0hAnrNhi6chSpxfBlx8uB+UGJoAGcVad4AS+53VlNDGjFfv/07B0zmBkj
         vlBTOW4vs5zETlF/4dDAqXMRACkfjMtD3af4nrzBZH/m1fUcCn8bpATx7RXfysVecQFf
         KM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595014; x=1746199814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYX9LNywUVjZ5MKIhmplUJhVT60qSNh9kSQfKfBdFKY=;
        b=sp8jhMoajZft81dTGvgcIqLSnLdDBaCqZWftzsFF/mfvgv4PaefXn9xAofn1Mj6Ds3
         5+BGtZHGRAd5SS0vvVEpwxSOTwx5803WBa96Qs8OmDa8684hwMqpos+nfJRdHx6LVtuE
         xl/60kXhaThTmbn2Wu1IvvyevhoDwuzc7nzfI6J735VsqsoTjggZiLGpSiEpkfGsxN+u
         EqFIqpnqIQ4QSDCj0CQQWs7W3QMJ0vmA4BdhtfsVRiyxA9mD6yafHJ18hSM65QFbiBrM
         AZArq54yggMNkJdCsXBfeFfkZN6cpdS1VnJrzZnoe9bGQW064lxD/2DQj0OtY+oWmnw5
         vglA==
X-Forwarded-Encrypted: i=1; AJvYcCV8EafzYOhhx1C4r+rg/cpHx8Bv4Hm2qAxK0TO3D9c2h0k3vjrSp5rCKKHDOniY1y6aIXSmsCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBYCpZXpnfq/mYjciZ7i2vp7+r9v54qe1j618ozeDbM7nLyPU
	XiTE7hgrwcMXiy+01jNOWuAIHSm0mQni/HaHsGlN4PjchXTf67ZgUo8lyCGwFNM=
X-Gm-Gg: ASbGnctNMOBSze5YusJetrc8pbn7SO4IdDxKHsMqxoEPTaRu41j5XKqkFQqq1v3+QmR
	+bWUz1W0Gft74UQHxmr+yOZFaQnFTNdlzwBZeP+dyLnWYrQWNKh97wTlblkqlwk/PWIpWuFmF3z
	cQX/QLeO5BjIZ30DhzRv0TO+xA+YEDS3VKFQdYaWOuTHMEWUzIK8w2uwXbz7h9itQIeTsozk6X8
	5AF+vV2h3YZqb/RLhvBsGenIJw+itHz0+mmCbkyghEZCtz7lAPJkuHWVRgv1+8jDv+UTvDIECx5
	VybxOQ3UldzWo2lAEk/HcDNyB6+BNJ+/dHDV4XN/ekeVi6RXf75qpWo/
X-Google-Smtp-Source: AGHT+IGyQoffBkkjn9GdlBOynB35D8e4ETPc01tgM75yAlc1oqBxq4rXGz8GsC/XanHp8nvcBgQZNw==
X-Received: by 2002:a5d:6489:0:b0:39c:1f02:449f with SMTP id ffacd0b85a97d-3a074e0e059mr2152557f8f.2.1745595014541;
        Fri, 25 Apr 2025 08:30:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e6daa0sm2592945f8f.101.2025.04.25.08.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:30:14 -0700 (PDT)
Date: Fri, 25 Apr 2025 18:30:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "zhangzekun (A)" <zhangzekun11@huawei.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, robh@kernel.org,
	saravanak@google.com, justin.chen@broadcom.com,
	florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
	kuba@kernel.org, kory.maincent@bootlin.com,
	jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, taras.chornyi@plvision.eu,
	edumazet@google.com, pabeni@redhat.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, arm-scmi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	chenjun102@huawei.com, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/9] of: Add warpper function
 of_find_node_by_name_balanced()
Message-ID: <aAuqgiSxrh24-L-D@stanley.mountain>
References: <20250207013117.104205-1-zhangzekun11@huawei.com>
 <20250207013117.104205-2-zhangzekun11@huawei.com>
 <Z6XDKi_V0BZSdCeL@pengutronix.de>
 <80b1c21c-096b-4a11-b9d7-069c972b146a@huawei.com>
 <20250207153722.GA24886@pendragon.ideasonboard.com>
 <be93486b-91bb-4fdd-9f6c-ec295c448476@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be93486b-91bb-4fdd-9f6c-ec295c448476@stanley.mountain>

Whatever happened with this thread from Feb.
https://lore.kernel.org/all/20250207013117.104205-1-zhangzekun11@huawei.com/

The issue was that people weren't expecting of_find_node_by_name() to
drop the reference on the of_node.  The patchset introduced a wrapper
which basically worked as expected except no liked the naming.  Krzysztof
suggested that maybe the callers should be using of_get_child_by_name()
instead.

I created a Smatch warning for this and here are the four issues it
found.  The line numbers are from linux-next.

drivers/net/ethernet/broadcom/asp2/bcmasp.c:1370 bcmasp_probe() warn: 'dev->of_node' was not incremented
drivers/net/pse-pd/tps23881.c:505 tps23881_get_of_channels() warn: 'priv->np' was not incremented
drivers/media/platform/qcom/venus/core.c:301 venus_add_video_core() warn: 'dev->of_node' was not incremented
drivers/regulator/tps6594-regulator.c:618 tps6594_regulator_probe() warn: 'tps->dev->of_node' was not incremented

regards,
dan carpenter


