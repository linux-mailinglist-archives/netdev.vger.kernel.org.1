Return-Path: <netdev+bounces-234701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB1C26366
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BF73B8F72
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1087283C89;
	Fri, 31 Oct 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZMxzuSO2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E6280CFC;
	Fri, 31 Oct 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928073; cv=none; b=MDXu+WwW32voQKzr224kND+Nu6oYdEVvvx2FVbtoLBTBGAWF4vEjWX0yMBHqVv2S2RRWTPjW/hePbu3OSz43P20T8ufjZjTgKqSW6si0BHSmGT/m8VTpPBYUl0zwZFHH0xtKZg/6j87apI8NR0d1merPq8QcTaF9Un8VlEllGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928073; c=relaxed/simple;
	bh=yK/wrhpQd79WHSEk+o7jrmxNAwAD6NeTN53aKKvV7+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyHggghYN04Z2/oV4I3oYfVXGmjvldTD8GaMBxPPsaGnE4QAIyQwsuDHR+VbzMm3uhKZL/FjzgB3z9YXzLki9c5o+xvTx0zmNqzLGdFpnVuiEhtVc2FO6zDjMYY1PNQZqX187SNpa7GXvEXEwFwhc7CtDQ2qTHrU3g1wmlHHiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZMxzuSO2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rZ5u2OHM4W5d6szB9Bv+CCsJsD0TGOZIN3GnPAec3+w=; b=ZMxzuSO2ccdhIWm5zO17X7N0hj
	fZG2XJboLYQpg6I+YlP6jenLMIfuyR8mRymm+D9sMhI9qdXT+fcbaCETx8Gn9C/DwDBQmMEEEIwSt
	HQ1M8dijbElQpMZYfMWHEFQnkvMeijVCekyGVbwxPf6QYmsBQbEMBGhhkuLM5nHSHpMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEryN-00CcCA-65; Fri, 31 Oct 2025 17:27:31 +0100
Date: Fri, 31 Oct 2025 17:27:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: spacemit: Remove broken flow control support
Message-ID: <dce4340d-a272-4b86-a7fa-71e6286f798b@lunn.ch>
References: <20251031-k1-ethernet-remove-fc-v1-1-1ae3f1d6508c@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-k1-ethernet-remove-fc-v1-1-1ae3f1d6508c@iscas.ac.cn>

On Fri, Oct 31, 2025 at 04:21:53PM +0800, Vivian Wang wrote:
> Currently, emac_set_pauseparam() will oops if userspace calls it while
> the interface is not up. The reason is that if the interface is not up,
> phydev may be NULL, but is still accessed in emac_set_fc() and
> emac_set_fc_autoneg().
> 
> Since the existing flow control implementation is somewhat broken in
> general (for example, it doesn't handle autonegotiation properly),
> remove it for now to fix the more urgent oops problem. A better
> implementation will be sent in future patches.

Fixes for net/stable should be minimal. Please fix the opps, by
returning -ENETDOWN and leave the broken implementation in place. You
can then fix it up in net-next, were we allow more invasive changes.

    Andrew

---
pw-bot: cr

