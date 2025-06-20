Return-Path: <netdev+bounces-199851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE3AE2106
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20C56A2CF7
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473E2E9EB0;
	Fri, 20 Jun 2025 17:33:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46C218AAB;
	Fri, 20 Jun 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440833; cv=none; b=aygQP+F3ixx8xOTjQ7cXwVnXXnr2AHXEQ16dTJmobZnod6B+bUwqf9GR/xELX4ynk+8XSUCSkCCA2mPQPmY4yyuXmLeyhBjL+rWuxAXKg+1wKUl/iv2uPIpMQkBSfLYhEP/qUSBfBfg7AXEBcaBXhG8ntyGBDnIVJ4pZ01TRouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440833; c=relaxed/simple;
	bh=jUA5FzrvydbyyzJDdBtIRqJNaPZDEbr9XTxybWbYM80=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q+Wpmv4pVaU+UvMXpR6eWPW8Tw5tEApvnVEqsVQ0peGBqPF2wUWlMBRDEwzmeIDQzIX2GP3aIBqkdKQCQxzVzOKduQm2FxKgDeeEHWo/lU0Ak09R8OqVaQj61P2hkvKY2iGRXjiLN1cDHZjr2zdYaekTBczsenXMLjaEjnGjapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net; spf=none smtp.mailfrom=davemloft.net; arc=none smtp.client-ip=23.128.96.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davemloft.net
Received: from localhost (brnt-05-b2-v4wan-161083-cust293.vm7.cable.virginm.net [86.11.207.38])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id C42CA841F1AC;
	Fri, 20 Jun 2025 10:26:55 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:26:49 +0100 (BST)
Message-Id: <20250620.182649.211302145878462506.davem@davemloft.net>
To: nicolas.dichtel@6wind.com
Cc: g.goller@proxmox.com, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ipv6: enable per-interface forwarding
From: David Miller <davem@davemloft.net>
In-Reply-To: <d429f28f-f515-405d-b490-9b60e5f95070@6wind.com>
References: <20250620152813.1617783-1-g.goller@proxmox.com>
	<d429f28f-f515-405d-b490-9b60e5f95070@6wind.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 20 Jun 2025 10:26:57 -0700 (PDT)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 20 Jun 2025 18:09:52 +0200

> Le 20/06/2025 =E0 17:28, Gabriel Goller a =E9crit=A0:
>> It is currently impossible to enable ipv6 forwarding on a per-interf=
ace
>> basis like in ipv4. To enable forwarding on an ipv6 interface we nee=
d to
>> enable it on all interfaces and disable it on the other interfaces u=
sing
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to =
the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwardin=
g
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>> =

>> This patch modifies the forwarding logic to check both the global
>> forwarding flag AND the per-interface forwarding flag. Packets are
> You cannot change this, it will break existing setups.

Therefore.
> The only way I see for this is probably to introduce a new sysctl, sa=
y
> net.ipv6.conf.<iface>.fwd_per_iface (there is probably a better name)=
.=

> When the user set net.ipv6.conf.all.forwarding to 0, the kernel shoul=
d reset all
> existing net.ipv6.conf.<iface>.fwd_per_iface entries to keep the back=
ward compat.
I agree.

Thanks.


