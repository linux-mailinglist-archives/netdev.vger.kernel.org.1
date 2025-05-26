Return-Path: <netdev+bounces-193408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5139AC3D52
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CADD3A7B45
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA71E492D;
	Mon, 26 May 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2JBrPo8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC119B5B1
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253081; cv=none; b=K/Lwp2WjvGcYbyiWZWwS5a3pGPjrRxhTZoUssBOeOrJT1DnD8oTfzTk+0elaJ+J66+Vh0m3Rg+toQdAbd2XuadGeBngAU1zt7vMi9Oux/47V1iOkexj6DFLbOeD8cOJD7a5FlyPMufGWvMPkEBdeNC+aUAuPavAGYkiQc+Ma0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253081; c=relaxed/simple;
	bh=ZYtbaY+d5yhYr6DFBZ7eUpm3z64xVH8UXDtgthbADjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSxtFMJg9eXYN4JsLBY8hiRwoUiWJcxjIfaY17dYE5nEhq5fe3zkPF4/S0DYGdP3+VZA/DgtyATxbt5ZzzntDdZ7KhGBiOIFD2WDdjHWhSAkmogFXEA2G6TY81/cuT9jSKbmlz34+GjxFAyowLksk5CElF09TYKtf/8doU+/gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2JBrPo8w; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edb40f357so16971435e9.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748253078; x=1748857878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uIA5Xm/bK7H37zOxnJOp+QlNAsyB5IEwlExbopAskmc=;
        b=2JBrPo8wXQswxk9x3nB1W/LGQtYZL63ASx7NWu31NA4xIM+8QzHDc4rsyLNLwlEEtl
         sKxeCeJwIQWkorIX3qlJdYFYTgmX/uMwN5FOVXa+aYuPq0sJ1Z5X8jGK+xW36z0b34HN
         M1cb+BqY5XIvMCHuLKNr5/lsbF75tIbOzPT+egcfCBdpHTzm2MXgwsfJShrPncLfhabi
         ZwYAnhFwvu2b3NEWl80kqOXj9WfB6zRg+sEeqVE9Jbsw5EqolxdPA25o/Bnktg6MX9Ad
         LYuFG2KC4691gj/ofJJ4KTtRQBZRdx2OqLTS4ZtjY/xeWA66cdcC6Y3OvG0wJEbkb5VP
         2yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253078; x=1748857878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIA5Xm/bK7H37zOxnJOp+QlNAsyB5IEwlExbopAskmc=;
        b=MZC2EYFx7dUa1dQklbU7eNC6+AVwJxe1FSkSO7oibEwRzz3hOfvgM/txDZqJ0iHY+B
         mVd1TsAExz3BNFjB7nA406aJqFhAHSvDxMal0UuN1UkPgGLkUFDrK4rf2nTVyYV1sw19
         LHmq60AElCW9uMW07mRwF1KWkUKMkdF0Uu973a0u9/sHotfwVXLcZr2JyBzdygLou+v8
         7YlhD3qGrP9shz4/Xxsg5+gONa3GTn5Au1M8F3xKhOelM2sMlmJjLXhnaJCqZFQcOx3i
         nz+FKvZKmmKDi0NZ/3pqFr2+CBQTuGFb3fVfw76kl369Q2JyAe3U1YjDDeaKpThcxanO
         /nqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCBTLNAf+9AqJpT2IvJwKIWsQ2oGzizhqD9VysFBqeP3vBDTtXZAy7OQN/D2T3fRkMZuUpNMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGGUcRelqchG//wtmSP/07TXQhxhQp40w2V0kzgA1F9XwwPAp
	3kx68g98W3wnCR/h4UxnwyeHv9RueiKNwItvB6JBD4V0mL9rTadivLnA8Fv97WQeeL0=
X-Gm-Gg: ASbGncuEI29CcF0cjWUccXUEhxNQGuWmFjiUyjwk/n7w/67aY7y14xWK9vuOKZPH0+V
	Dlmh6vKJ5uxIAKXHZZF+IWOiELC8r6d37+XGDQzX2yKlMgwvaAVjVLrn/FV1rCxtcirjDv4L1m7
	KsWJnFBduvFNirGudDO/J/3EjpwNdoA9w7tkIGbsfV5uaHYZ+AdnkaG9sgeeAQAbIDttP4TAcWF
	IhUrpsTy1L8rXsA/yzixxNwaHjHRDaWdWKQ7nIxbZZa8LqZfhuOeR5I9BdHwyRYvfw7M2cNMBwS
	QeR/6als4Uonty3Qzb1IAyUSzDriPO/Fn8CSyg/ckTTLAq8ZSE5R+Jv6iypgqdNmWLvm68wOx1g
	7wpc=
X-Google-Smtp-Source: AGHT+IEIkAv2sc8qHxQUWwxyckEsZvn4kLz0ctgjJMc4rSMyzhpWHefD1LaBYhAncvu0/PzqhVb3uw==
X-Received: by 2002:a05:600c:64c6:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-44c9141d996mr58637055e9.1.1748253077715;
        Mon, 26 May 2025 02:51:17 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm227022725e9.27.2025.05.26.02.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:51:17 -0700 (PDT)
Date: Mon, 26 May 2025 11:51:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v11 net-next 3/8] net: ena: Add device reload capability
 through devlink
Message-ID: <33wxyme5ngstfdq4aycta7ilxhjcn4nbf5ewa24kcm6zaw5ddx@637xcbjknc6l>
References: <20250526060919.214-1-darinzon@amazon.com>
 <20250526060919.214-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526060919.214-4-darinzon@amazon.com>

Mon, May 26, 2025 at 08:09:13AM +0200, darinzon@amazon.com wrote:

[..]

>+static int ena_devlink_reload_down(struct devlink *devlink,
>+				   bool netns_change,
>+				   enum devlink_reload_action action,
>+				   enum devlink_reload_limit limit,
>+				   struct netlink_ext_ack *extack)
>+{
>+	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
>+
>+	if (netns_change) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Namespace change is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Action is not supported");

Why you need this check? devlink_reload_action_is_supported() is
checking that in devlink_nl_reload_doit()



>+		return -EOPNOTSUPP;
>+	}
>+	if (limit != DEVLINK_RELOAD_LIMIT_UNSPEC) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Driver reload doesn't support limitations");

Same here.


>+		return -EOPNOTSUPP;
>+	}
>+
>+	rtnl_lock();
>+	ena_destroy_device(adapter, false);
>+	rtnl_unlock();
>+
>+	return 0;
>+}

[..]

