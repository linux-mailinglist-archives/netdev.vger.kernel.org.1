Return-Path: <netdev+bounces-280967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDGCAxsx62lfJwAAu9opvQ
	(envelope-from <netdev+bounces-280967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5B45BCF5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7786A3014542
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E13644A3;
	Fri, 24 Apr 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGn5NZG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4135DA7F;
	Fri, 24 Apr 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021169; cv=none; b=qqGMAXugDrEZVwmoC/W4vn3OfjuD751PI197bTh5s0V+6jrp/GYHqTqsP1iiirJZ/XmA4t+04PHag0vyWCB8GfCtDFIOOHpwNE5lfWvqbV4lc4FivlLiV1uR3FrzOZJzb4Q7bEeKbn9xafpq+YlH1hVryUy7atxIEzCJ2wIMag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021169; c=relaxed/simple;
	bh=DEoY8VRsnprsvGDeBUko4eOnwJrwDG98t8XxFVl0mqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNKVCqz9Mp8qGxhAa2WbjmXhhSSfDvBpwoavKiBBPrh3fyHVzSdCjKOeflsbLgDMTbS6DlF33kKCo/IjOGpQJMKQM7LbadxwCTtWNEp7DRAEtmXOGFLdDIED9e5ZqRw5gmbgP7sOvukTHSi5nWHmzyBV1N4YXUP53AHoKTQEucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGn5NZG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC5EC19425;
	Fri, 24 Apr 2026 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777021169;
	bh=DEoY8VRsnprsvGDeBUko4eOnwJrwDG98t8XxFVl0mqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGn5NZG35eMgsFLA4+s/v+zgVoRgkXnP4w5shd2SAl8ZoQQ5B5MrNS+eKhDJ02u07
	 GVEYoLHxhefV4iSoNh+jGALNdKqIw6enmE0aWB4S5xDcYKZI74L+cWlBVqNxcXu5VC
	 Uy195vvaXSA5m7MtmWO0cKuLrLeqBb6kbruy4tvgwlLFcU613Rc30RwXtVbttWVdIN
	 1CB3UJxhCMHJPez8bxMac+miFJwp92SQ91c112nM4bTE1GcPCXdITIcILnmTuIZ5Oa
	 UYR6y2FufJ7D39XQ6xJZ1VxJgqhVjsGLusWQW+O8IPbm2GCZWe9wbjFL8AnVCmVSrU
	 Oa9GXIQ0xtBHQ==
Date: Fri, 24 Apr 2026 09:59:25 +0100
From: Simon Horman <horms@kernel.org>
To: Titouan Ameline de Cadeville <titouan.ameline@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ne2k-pci: fix missing residual byte in block output
 for 32-bit IO
Message-ID: <20260424085925.GK900403@horms.kernel.org>
References: <20260421145736.15949-1-titouan.ameline@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421145736.15949-1-titouan.ameline@gmail.com>
X-Rspamd-Queue-Id: 48A5B45BCF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280967-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]

On Tue, Apr 21, 2026 at 04:57:36PM +0200, Titouan Ameline de Cadeville wrote:
> ne2k_pci_block_output() handles residual bytes after the main outsl()
> loop when the transfer count is not a multiple of 4. It correctly
> handles the 2-byte residual case with outw(),  but is missingg the
> 1 byte residual case. This means for packets where count % 4 == 1 or
> count % 4 == 3,  the final byte is never written to the NIC's data
> port.
> 
> In practice, this is masked by the count being rounded up to a 4-byte
> boundary earlier in the function for ONLY_32BIT_IO cards, but that
> rounding itself causes a little information leak by sending
> uninitialized kernel buffer bytes on the wire

It seems to me that the code being updated by this patch is for
!ONLY_32BIT_IO cards. And in that case count is rounded up to
the next even value if it is odd.

	if (ei_status.ne2k_flags & ONLY_32BIT_IO)
			count = (count + 3) & 0xFFFC;
		else
			if (count & 0x01)
				count++;


Regarding the information leak. I believe this is only from
the Kernel to the device. But not from the device onto the wire
as the device doesn't send data beyond the end of the packet data.

It isn't at obvious to me that this is a problem that warrants fixing.

> 
> Add the missing outb() call for the odd byte case, mirroring what
> ne2k_pci_block_input() already does correctly.
> 
> Signed-off-by: Titouan Ameline de Cadeville <titouan.ameline@gmail.com>
> ---
>  drivers/net/ethernet/8390/ne2k-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/8390/ne2k-pci.c b/drivers/net/ethernet/8390/ne2k-pci.c
> index 1a34da07c0db..1bd5b94b5d22 100644
> --- a/drivers/net/ethernet/8390/ne2k-pci.c
> +++ b/drivers/net/ethernet/8390/ne2k-pci.c
> @@ -632,6 +632,8 @@ static void ne2k_pci_block_output(struct net_device *dev, int count,
>  				outw(le16_to_cpu(*b++), NE_BASE + NE_DATAPORT);
>  				buf = (char *)b;
>  			}
> +			if (count & 1)
> +				outb(*buf, NE_BASE + NE_DATAPORT);

Because count is even this condition will never be met.

>  		}
>  	}

-- 
pw-bot: changes-requested

