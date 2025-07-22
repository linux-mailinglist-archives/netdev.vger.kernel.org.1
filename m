Return-Path: <netdev+bounces-208733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1613B0CEA4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F476C2F7F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF236A47;
	Tue, 22 Jul 2025 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiQiIz8P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27097F9;
	Tue, 22 Jul 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143219; cv=none; b=o2PhcBlL6Jh283gNK1LtgZj9HcgwpwRG0QfcM8YpifsvOMCMRk40jO5rv2kqaeuckKTBKH7cnt6X0atY/TxeKsl5cOxSLlb96fcfrpYz75fJbvJVqP4Ed9lq+1JfELyWplTIn4MGl6389LUEvLsBas2Z2FkHmd+/q1mbRg0VOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143219; c=relaxed/simple;
	bh=C4dC6WGf35fUs4kvD2XDKyOabQB1kXDVHpeKt0kWxFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1N0I9ZXFqNabTz7b2bBagnoB0PDAPRU2d1i5dw9nQzLF29pggESgpmNcwnFHLAtv7PseUFZJ0ROpNdQgVKAINggX7qarevB6UUt5nlw4eOlMHI13vDv6ci8UbNEzQl9eF0E5X0fUoZBJ1+C4grfoY8WkZztAllyATLGA+mpP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiQiIz8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F472C4CEED;
	Tue, 22 Jul 2025 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753143215;
	bh=C4dC6WGf35fUs4kvD2XDKyOabQB1kXDVHpeKt0kWxFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FiQiIz8PuivLGxssxlUtyn84n66QIAeUpERhXMdUDUohbcTTZ6JnH5DcjVP2U++GO
	 RquEhgk+SP9a2hkZyIqCJcXPH/ZsU8PXv2HTY9D/ZGVK6f2XnCrc8QaeF40AQ5tZPq
	 h1YLF71HuCQW+vIUBvH3z1QdbKF/k+GuUdmuUYZhzllBtEMSl0AzbtR6wZsPn/9mXH
	 mNARm72W6e/IAl9/XEpKUEk2Pd26RG0CIdzmvWDdSTyjNdGVkTpN1Di8vyFJGkNw0t
	 N6cAD4Uekjo7+Owtsl/9c4JAWXjaF6EY5rtyJwkwF/It+CyHNP2DdhX6hHuAZicuW6
	 eIbCjd9QpIUAg==
Date: Mon, 21 Jul 2025 17:13:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <fan.yu9@zte.com.cn>
Cc: <edumazet@google.com>, <ncardwell@google.com>, <davem@davemloft.net>,
 <dsahern@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>,
 <jiang.kun2@zte.com.cn>, <qiu.yutan@zte.com.cn>, <wang.yaxin@zte.com.cn>,
 <he.peilin@zte.com.cn>
Subject: Re: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in
 tcp_retransmit_skb
Message-ID: <20250721171333.6caced4f@kernel.org>
In-Reply-To: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
References: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 11:16:07 +0800 (CST) fan.yu9@zte.com.cn wrote:
> Subject: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in tcp_retransmit_skb

Why did you resend this??

