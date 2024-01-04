Return-Path: <netdev+bounces-61451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FA823C5E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 07:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAEC1C217F3
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7061D68D;
	Thu,  4 Jan 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Sd/Ezowo"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868131D532;
	Thu,  4 Jan 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9D2CC20154;
	Thu,  4 Jan 2024 14:43:38 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1704350619;
	bh=aJl+oHXDo4ELtFcCjq6IsOosLDZjjl73qKxSGl/upMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sd/Ezowo3UGOPhnaBd9xa5LGyC3pxxL1kYJ3Cgay8BdpEaIjZz82Qap0tVyMNZSqR
	 v8SfsLQ3OA6vENR+B3GFnSvUegvAJ6SmW5iAhyn1uAalhDoibGkObtjvYPJ+q/+Gut
	 Ezw5fB1zFkOpcWoqldk+UnmqvEgZdicRdEA0hFzNtD3T3OI60NhvA0+o5tPMMjTa8K
	 FAxTv6+hWJECdm/GjhjJmEoBugaJRDzpZJOowXyXXey+2E7cEEbLSeYQySSNZ7Mwpn
	 Y9KDHFMb8sjs+RI5A6kJKNOt9RLIrAPpXB+/o7gpnCX6FrHe0xM1Ut3YoRZrmTHxpI
	 IiuYZAXwhSdsw==
Message-ID: <e5e0640094a4e594eda8c3f8a54eca6728e58510.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v1] net: mctp: use deprecated parser in
 mctp_set_link_af
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Lin Ma <linma@zju.edu.cn>, Jakub Kicinski <kuba@kernel.org>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jan 2024 14:43:38 +0800
In-Reply-To: <7cbc3044.688a7.18cd32c5f14.Coremail.linma@zju.edu.cn>
References: <20231228070258.3052422-1-linma@zju.edu.cn>
	 <20240103174719.2b2c1565@kernel.org>
	 <7cbc3044.688a7.18cd32c5f14.Coremail.linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Lin,

> (1) will get AF_MCTP with nla_type(...) call, and (2) will then
> passing `af` to `mctp_set_link_af`, which will expect the
> `NLA_F_NESTED` flag.

You could set that flag? It's not exclusive with the attribute type.
From netlink.h:

  /*
   * nla_type (16 bits)
   * +---+---+-------------------------------+
   * | N | O | Attribute Type                |
   * +---+---+-------------------------------+
   * N :=3D Carries nested attributes
   * O :=3D Payload stored in network byte order
   *
   * Note: The N and O flag are mutually exclusive.
   */

Which is what we do with existing userspace:

  https://github.com/CodeConstruct/mctp/blob/6aa4b052d/src/mctp.c#L569C1-L5=
69C1

Cheers,


Jeremy

