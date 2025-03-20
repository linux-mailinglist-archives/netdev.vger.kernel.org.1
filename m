Return-Path: <netdev+bounces-176434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963DA6A4B1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E6170251
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313521859F;
	Thu, 20 Mar 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYyj9p6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2B27701;
	Thu, 20 Mar 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469426; cv=none; b=qQZvRvZalFOmj24arciQZsq0dDa7o9Vgz36G9lXbevSB3r+ukQ9AUCHjPySapMBPO84pHs/jFre1z5hQSuU+aIEGrfwEWh26/oc2MAXD/HjDJKEhBCuhNqnQxPkVJcCSVrTqWBOYX2/46RfBLUvX+1BYcQpVAULIfyIg6SqXIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469426; c=relaxed/simple;
	bh=/7u+gDUcP5o2rJ8pXOfKWcA25Zzww9gy+RHc9UH0fxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9HP9uzloWihw3DcGaFfyheNgEY4LSv3AAUVz1odi+v2YmJvTFoY6ptUZXY341qaT8NR6vA6T1qDojXLJORAl+va4q7ythW9RAMrYE06q4TF/q7e8eljDCL4BJoDLpetpuDSDaG+tH+qobWCaipVbIG5CSkahnGmyZleE0uA7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYyj9p6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E27C4CEDD;
	Thu, 20 Mar 2025 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742469425;
	bh=/7u+gDUcP5o2rJ8pXOfKWcA25Zzww9gy+RHc9UH0fxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYyj9p6g/zjks6iCfVzP7tHULnFlR+z8bMqS9F9Pe7E0YR4AHw5a6tkVLOj0eIR9a
	 wAl7LduM9Hm2hX2t0LKcHc9mT+95kUFupQ07vUs1ZW/fHczkO95AgVfiLGtCIWNyPM
	 wmoPOvU1kMrZcUyeXD0ASyQkaUbSxLwuIuxLGKMZD0jPUSWm8xZEgiWmWqEv7L2HlK
	 k0vCLJfKaeXIABIuf8NDg+4WHlIYeXKjPqCci70sSu4lsTtYlsSLfxEn0x7r6PqBgx
	 jkRSDki1RktIvTlCCh9Hfpe6mRJ4wBGD+guKhwM+awGTBDGAQirdYtarQmBMkovzvF
	 YMoMh0Fl3FPoQ==
Date: Thu, 20 Mar 2025 11:17:01 +0000
From: Simon Horman <horms@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 03/31] tty: caif: do not use N_TTY_BUF_SIZE
Message-ID: <20250320111701.GI280585@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
 <20250317070046.24386-4-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317070046.24386-4-jirislaby@kernel.org>

On Mon, Mar 17, 2025 at 08:00:18AM +0100, Jiri Slaby (SUSE) wrote:
> N_TTY_BUF_SIZE -- as the name suggests -- is the N_TTY's buffer size.
> There is no reason to couple that to caif's tty->receive_room. Use 4096
> directly -- even though, it should be some sort of "SKB_MAX_ALLOC" or
> alike. But definitely not N_TTY_BUF_SIZE.

Hi Jiri,

My 2c worth is that 4096 seems like an arbitrary value.
Which is fine, but perhaps a comment is warranted.

> 
> N_TTY_BUF_SIZE is private and will be moved to n_tty.c later.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/caif/caif_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index ed3a589def6b..e7d1b9301fde 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -344,7 +344,7 @@ static int ldisc_open(struct tty_struct *tty)
>  	ser->tty = tty_kref_get(tty);
>  	ser->dev = dev;
>  	debugfs_init(ser, tty);
> -	tty->receive_room = N_TTY_BUF_SIZE;
> +	tty->receive_room = 4096;
>  	tty->disc_data = ser;
>  	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
>  	rtnl_lock();
> -- 
> 2.49.0
> 
> 

