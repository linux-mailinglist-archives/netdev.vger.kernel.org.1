Return-Path: <netdev+bounces-22476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828F767977
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108F01C215D9
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABABC631;
	Sat, 29 Jul 2023 00:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91743621
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAACC433C7;
	Sat, 29 Jul 2023 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690590345;
	bh=xoYh6nl7Ymq+oEY+0iyKXVVHHgnEX73mQRAcXMXhUfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BCiqoZRADYsp7o6W43xzzcFifZX/tdqC4zkUqVu6R4lkllSL+7EE0vp6+VLek8YBq
	 Y6dJlZmalMnKiLu/4TKlRrBiBnAI1qDC+3pVNkOD6JbfGasZ4MjshJkm09OWQFFays
	 VpfMI6e3Um+iCDfsKebGSboT8UH4PO70WLFF880LAlBfYz9N57xl17hAkBY+gDf7D3
	 1SchvxhtDTIocM1Fm8VJhpuwLhdq0GALw0ftDZ77FZ4oFBr144+3vD+etwu9NhSLiO
	 iD6f/vTZMcWLuHAZ/RAnCe4VoWRS88niwBzOycLaSGvIE24lo7GMJ1Fcs3wfcp7H4r
	 aczenDH6y1PNg==
Date: Fri, 28 Jul 2023 17:25:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
 Simon Horman <simon.horman@corigine.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, Richard Cochran
 <richardcochran@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230728172543.2d5f5660@kernel.org>
In-Reply-To: <20230727112827.3977534-7-danishanwar@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
	<20230727112827.3977534-7-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 16:58:23 +0530 MD Danish Anwar wrote:
> +/* Classifier helpers */
> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
> +void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
> +void icssg_class_disable(struct regmap *miig_rt, int slice);
> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti);
> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
> +
> +/* Buffer queue helpers */
> +int icssg_queue_pop(struct prueth *prueth, u8 queue);
> +void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
> +u32 icssg_queue_level(struct prueth *prueth, int queue);

If you create the prototypes when the functions are added there will 
be less need for __maybe_unused. Compiler only cares about prototypes
existing, not whether actual callers are in place.

