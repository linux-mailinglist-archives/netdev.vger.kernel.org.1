Return-Path: <netdev+bounces-65432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF783A6E2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6525E282786
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9A63CB;
	Wed, 24 Jan 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eghmTqZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F16AA6
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092483; cv=none; b=rwTTCF7oU/NZh6xWPnCOV+d7khQMAM/Y1wFNgw+Kp6s/BtakuUNim7L8bx2+izX8eCewCL7qWbhNZenPnpgKKlB9a42CKcnXK/e6Vrns1CiTRU04F5ina8eqY2LFDWAoji4E/LJ4J25XSxVN0ipmjbtZE03uACs8K76RiUqaRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092483; c=relaxed/simple;
	bh=cCITTypGrCypIAnPYn00kmnwxbDCQVTtjggzckEskHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g86CkFKpjzPHz1wJ9r0jhtsmLOBDQcTSsXGMhEC5V6yYwKHJT30sK6jzZBYCu/7IjzQUwWPGz7t+sjdPjgFZ0NAP4DfcwwneYXNAhxNdJ+cK5BoS2YUGbZ1AnrTW3Sk9vWlyXvNy3IHsFSO3dL6QwAyd93c0E9LW808Cp9DvLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eghmTqZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686F5C433C7;
	Wed, 24 Jan 2024 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092483;
	bh=cCITTypGrCypIAnPYn00kmnwxbDCQVTtjggzckEskHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eghmTqZj0F8GdvSZUf+EXrSHrRxniGE7f13u4RIUrBPol93H8grZpCYsxDBwvVS/C
	 HmRRqS2dQIelBHY510sWEgzp1+QnGZ6I95RNr5n+BCfwCuYzdwJ5L7Mm+5eKl9fR6g
	 20U85KI9bGaj8M/vV7sr2yXfB47fkk/C9i64w4E2cklYvk++eZo/JV2MhUoSvj7+x4
	 XXI1mmnxdzeiqq31UNLZiibUCLcXHbilkJyeHHjfjzs/ttm2ER81parqQgLWVhKHAv
	 ddLj4LqIHl34e7zEBPzBwxqR/5M6dH4S6pgJkNuTmdD+EPf+k0sWLUbDIau9D1X/Xl
	 AWPVD3oHDLVVA==
Date: Wed, 24 Jan 2024 10:34:38 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 2/2] net: txgbe: use irq_domain for interrupt
 controller
Message-ID: <20240124103438.GX254773@kernel.org>
References: <20240124024525.26652-1-jiawenwu@trustnetic.com>
 <20240124024525.26652-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124024525.26652-3-jiawenwu@trustnetic.com>

On Wed, Jan 24, 2024 at 10:45:25AM +0800, Jiawen Wu wrote:

...

> +static int txgbe_misc_irq_domain_map(struct irq_domain *d,
> +				     unsigned int irq,
> +				     irq_hw_number_t hwirq)
> +{
> +	struct txgbe *txgbe = d->host_data;
> +
> +	irq_set_chip_data(irq, txgbe);
> +	irq_set_chip(irq, &txgbe->misc.chip);
> +	irq_set_nested_thread(irq, TRUE);

Hi Jiawen Wu,

'TRUE' seems undefined, causing a build failure.
Should this be 'true' instead?

> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}

-- 
pw-bot: changes-requested

