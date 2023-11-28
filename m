Return-Path: <netdev+bounces-51880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDA7FC9E3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB33B20E1A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85E41C8D;
	Tue, 28 Nov 2023 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dTYqMrVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCA19B7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:48:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c21e185df5so4375933a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701211723; x=1701816523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHKRs45eJKVxg7G2rJaXhGHBdlJA8xFGmL8opE691K4=;
        b=dTYqMrVJVW4a8jhySDGsr1kfy0XV279YzHChH6L0XBkKBAlD7w6SJMoVPzvIyzSmpr
         TxWZzgOMrgHuLXCySkhkji2OmsNcUHsizUjS8rlTDOhe+rEsqjYj4pdh0vnqJmAWSN8j
         EYU+cWOKEQ+CPpiFzJV023Ase6GlBwfc9fvIuPRcDrGQncwNZs/XzXqkeU8AfMEdoiqY
         rC8rE0CRsN5N0boGBzwK9Ua3n6nlFqTrn2AowJx0+L7E+W/aFE81MrPxk28gLtBk7hNq
         zl0cHPPG44U/E4eAvCPVwjqY5IJsntOIJVG7yrErqsXJtJ4YKjJakRc0CfxwQhDsVQo6
         +S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211723; x=1701816523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHKRs45eJKVxg7G2rJaXhGHBdlJA8xFGmL8opE691K4=;
        b=LYIlaP1J3Fbpwc3G6YLLjkskQ/AtSnJoJzHu8Zt4nwSBfsXzob2Pr58S/TNdxqbO0I
         oDtqxpd2GsNHKXK4XZPCWiVNgE8+CYgatpB+038RMLKEAXLqAkImkzP0DcIvhpXyAoyF
         dFWqLipzVhcJN0gJHp8TlOQUZxid+TReojkGyYMbH0Kmp+Raojkf/DQge3ldsOZIOjMW
         bd26POdk2LQm0UX3QzJGN/lywSEwXl+cGO9eycFN9WUd1Lo0kPBCnZCMJroa3EuGkVbC
         yQ24ORHSK5C9Jwxd10lgE2jZ++jTRVM/u/GKB0DBHhwAwZryAsDPfUSgjQ7zPk9XLtCZ
         JETQ==
X-Gm-Message-State: AOJu0YwGbfo7NqBogflxDpttGW/9UtRi58zc9T47yxjGfN3f2B7qgv2+
	oEslkV3It4PyWVpZR/kHGwDxAw==
X-Google-Smtp-Source: AGHT+IH6OuxTpVSdy4LwRZ8Bus1I/2Vo+p4o3K6aSv6TPa4nIX6flEeNcc5vDgdXg4by9q8nXvDZ8A==
X-Received: by 2002:a05:6a21:3606:b0:18a:e4fe:3b8b with SMTP id yg6-20020a056a21360600b0018ae4fe3b8bmr15761079pzb.19.1701211723119;
        Tue, 28 Nov 2023 14:48:43 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a1a0400b0027b168cb011sm10592629pjk.56.2023.11.28.14.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:48:42 -0800 (PST)
Date: Tue, 28 Nov 2023 14:48:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa
 Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld
 <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 05/10] docs: bridge: add STP doc
Message-ID: <20231128144840.5d3ced05@hermes.local>
In-Reply-To: <20231128084943.637091-6-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
	<20231128084943.637091-6-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 16:49:38 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> +STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
> +model. It was originally developed as IEEE 802.1D and has since evolved into
> +multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
> +`Multiple Spanning Tree Protocol (MSTP)
> +<https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/>`_.
> +

Last time I checked, IEEE folded RSTP into the standard in 2004.
https://en.wikipedia.org/wiki/IEEE_802.1D

