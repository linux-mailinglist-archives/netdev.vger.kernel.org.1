Return-Path: <netdev+bounces-238695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F41C5DF4C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5771238052F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712DF325717;
	Fri, 14 Nov 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y3zntbql"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9C265CAD;
	Fri, 14 Nov 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133088; cv=none; b=d5EkyPIzYe/h4sK8zbJndRNdXWja9rmmYx8EAfThCvC0Jk90RXBFxfCTwyEDW88wsb0CxYeAsXGuTzNm5KhtEd66pB9670zWHFlBhHtpANTOHv1WAGKzAoFxKYE3lkvvctpa14bgtHA+e0Zt9HXMmKvi+5VFQvKBk/1d1Y6DSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133088; c=relaxed/simple;
	bh=2yfQIuv0KwgKkZJnXSEdpNNId/bOn5snEr6YBjY1alQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZs5vqGR7qO8Xqxp5kZXC+dByNM9eAcUQUv5f1jU32udD0d7IuiRnH1GMLWNT48ausEOCzlslO6hq2SoKUeG4QkjWStwx8mqApY24Krk0dyDa/W9BiGaK/ZAsHXKVAmQ4/Qqsl32hgzcyp7sjej8+NrvrSL47G8h8u2budJgZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y3zntbql; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lkf/NIV+zn/9c9VyQW91H6NJo+JDIv4n97HVo442nMs=; b=Y3zntbqlAXnrFIPEoy7AObTnLI
	+MCw0KIotibKRlNKGi/K5a0jmwCHh7DqYzMpHuTY9tbgzffKYTzMlDbpQ/NYrYqFfGbHU0OR0qrF4
	ijRr85nAf7eFCDBp8gD/MRC2y7xOnQw0dXKbRyRQdBtalBFoWWDd+duZlRS+BK0F8WNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJvSE-00DzVq-SG; Fri, 14 Nov 2025 16:11:14 +0100
Date: Fri, 14 Nov 2025 16:11:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 4/4] net: dsa: microchip: Immediately assing IRQ
 numbers
Message-ID: <aeba78cf-a220-4a40-964c-08b9d852ef17@lunn.ch>
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
 <20251114-ksz-fix-v3-4-acbb3b9cc32f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-ksz-fix-v3-4-acbb3b9cc32f@bootlin.com>

On Fri, Nov 14, 2025 at 08:20:23AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> The IRQ numbers created through irq_create_mapping() are only assigned
> to ptpmsg_irq[n].num at the end of the IRQ setup. So if an error occurs
> between their creation and their assignment (for instance during the
> request_threaded_irq() step), we enter the error path and fail to
> release the newly created virtual IRQs because they aren't yet assigned
> to ptpmsg_irq[n].num.
> 
> Assign the IRQ number at mapping creation.
> 
> Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  drivers/net/dsa/microchip/ksz_ptp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index c8bfbe5e2157323ecf29149d1907b77e689aa221..a8ad99c6ee35ff60fb56cc5770520a793c86ff66 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1102,10 +1102,6 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
>  
>  	strscpy(ptpmsg_irq->name, name[n]);
>  
> -	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
> -	if (ptpmsg_irq->num < 0)
> -		return ptpmsg_irq->num;
> -
>  	return request_threaded_irq(ptpmsg_irq->num, NULL,
>  				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
>  				    ptpmsg_irq->name, ptpmsg_irq);

static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
{
	struct ksz_ptp_irq *ptpmsg_irq;

	ptpmsg_irq = &port->ptpmsg_irq[n];

	free_irq(ptpmsg_irq->num, ptpmsg_irq);
	irq_dispose_mapping(ptpmsg_irq->num);
}

This is supposed to be the opposite of ksz_ptp_msg_irq_setup()? The
opposite of irq_dispose_mapping() is irq_create_mapping()? But that
does not happen in ksz_ptp_msg_irq_setup()? 

Maybe this change is enough to fix the issue, but it seems like there
is more asymmetry to correct in this code.

	Andrew

