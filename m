Return-Path: <netdev+bounces-226697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E3BA4105
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8E316B5F6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1FC2F6574;
	Fri, 26 Sep 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YogcGYGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428D136E3F;
	Fri, 26 Sep 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896013; cv=none; b=aJi50fqEsdlaAz9eLUob27S160tEeZ2SUuSKAq33ListBrkeOj0TMWgPXZ3ckbYibxip0a9ux5npObMGT+con+5fMNKbXNKqunQO7ImbJMh7W5CuovJ4Tspni5Z/BK0+UhVkHGE5RQr/+bcCYyjqNvGkMgP2Hnfi6Xn01Kr5x1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896013; c=relaxed/simple;
	bh=8DMNFALDkQHKbMdFUPbRi3C2PGsG9BfieE87zOC1sYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOjgvVvIop7PlN4LaBTfXvYuu/cBQYuijNxKfClc5KTjVmKyaLuzFm+U724GEjlx1/1c21FlPLNGLp2Z/71wCmyaItBmaYXDbSL2H+8vSYhpltDoevMeQyBOArWS5mjooPQPIa09Qz8SZFAHZhD+mCH1I9WMu/vKos/Y2fJt3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YogcGYGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249C9C4CEF7;
	Fri, 26 Sep 2025 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896013;
	bh=8DMNFALDkQHKbMdFUPbRi3C2PGsG9BfieE87zOC1sYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YogcGYGThZCCV2nyf8IFPVQ/yMB/8SVaSjjgDPt0Qo9nLoK+QtZRJx9/VLZLFhjqk
	 khGRy3JzQdfrkA6SkjpPOKwISVkCKq/SBHyAJWMgwuK1gcv/42lYbATm4sC4y1XBOH
	 wTrL8zaXfzL069YawpnUoesSfc9A+Nk45fgvniGr8/XqYGwzq3FRINgNCOzMwf5eUI
	 lX7dQhTkkJeHL2TlbML9XMk1XEud+wl6MruRSbaHDvo8S6taMdd2TePWLww/9tKHkW
	 Rzhox4I1BfHqV260wQbYxDtdiqjJ9EITTaMJPDdCoA0kDZshx/lJ2olZH/N4AFp33C
	 7j9LBwBsoAGag==
Date: Fri, 26 Sep 2025 15:13:29 +0100
From: Simon Horman <horms@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
Message-ID: <aNafiYk3_Ma5QQ4Q@horms.kernel.org>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925190027.147405-2-admiyo@os.amperecomputing.com>

On Thu, Sep 25, 2025 at 03:00:24PM -0400, Adam Young wrote:
> Allows the mailbox client to specify how to allocate the memory
> that the mailbox controller uses to send the message to the client.
> 
> In the case of a network driver, the message should be allocated as
> a struct sk_buff allocated and managed by the network subsystem.  The
> two parameters passed back from the callback represent the sk_buff
> itself and the data section inside the skbuff where the message gets
> written.
> 
> For simpler cases where the client kmallocs a buffer or returns
> static memory, both pointers should point to the same value.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  include/linux/mailbox_client.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
> index c6eea9afb943..901184d0515e 100644
> --- a/include/linux/mailbox_client.h
> +++ b/include/linux/mailbox_client.h
> @@ -21,6 +21,12 @@ struct mbox_chan;
>   * @knows_txdone:	If the client could run the TX state machine. Usually
>   *			if the client receives some ACK packet for transmission.
>   *			Unused if the controller already has TX_Done/RTR IRQ.
> + * @rx_alloc		Optional callback that allows the driver

@rx_alloc:
        ^^^

Flagged by ./scripts/kernel-doc -none -Wall

> + *			to allocate the memory used for receiving
> + *			messages.  The handle parameter is the value to return
> + *			to the client,buffer is the location the mailbox should
> + *			write to, and size it the size of the buffer to allocate.
> + *			inside the buffer where the mailbox should write the data.
>   * @rx_callback:	Atomic callback to provide client the data received
>   * @tx_prepare: 	Atomic callback to ask client to prepare the payload
>   *			before initiating the transmission if required.
> @@ -32,6 +38,7 @@ struct mbox_client {
>  	unsigned long tx_tout;
>  	bool knows_txdone;
>  
> +	void (*rx_alloc)(struct mbox_client *cl, void **handle, void **buffer, int size);
>  	void (*rx_callback)(struct mbox_client *cl, void *mssg);
>  	void (*tx_prepare)(struct mbox_client *cl, void *mssg);
>  	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
> -- 
> 2.43.0
> 
> 

