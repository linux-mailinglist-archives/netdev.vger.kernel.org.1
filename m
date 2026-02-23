Return-Path: <netdev+bounces-260058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GICIOcFmnGmsFwQAu9opvQ
	(envelope-from <netdev+bounces-260058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:40:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0B17827B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E0E302CB15
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712422C0270;
	Mon, 23 Feb 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="QfXiEwYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273229AB07
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857599; cv=none; b=dO8tsMKrXj6qOmzuH05HhR93Eex+gOptRiHUY+vIe5HW+xZJz2IthlFI3WMD37QocgdGDaV906gmDNeuqBCZTz9/inbekqvfAQ1wW1f6lUFz9ao5GLPcF1Z8uPRLHPrcB5JnvunU4g26v+PCoa0t6UIOZsuyhLL30SmZzfRVTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857599; c=relaxed/simple;
	bh=t9KBFUqdb3FGV4nIE+fMrWaLv7ZIwKkO2Dt7HG00xmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIWt9ge8c/jSVTOu6JYis/w6eaNNKlE1pS61QYpbXEycyVlHi+K8rd21b8R16jTn3wts0uCzWvZnWpQ1zaaLgWwiCXmeX9Gb0pbJ7A3EjlIARsT3X3rVyyseS5ofxXuh37yivY6bxjao4J/16lbov7IXmUW6joYfEOE5ZoV/01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=QfXiEwYk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506c00df428so40583791cf.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1771857597; x=1772462397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWORPb6fb34LAVxof+FZjNAy04GbN7Kfnww3yYmf/ys=;
        b=QfXiEwYkdNCqZ5ipDT+COOGs61xLTT3yFvdd3XmPGs6Mm32ff0bWuECDBVkIddIsag
         DSlT7YIjAAysPfUhryT8NEMR9MZ6XdeXhqLWywlOv1+yAcb81fPEisElJqVyBScV5rKF
         Q+FRiIZ1IEfni7I+bGM9gaJwYHyBKvV7Dxd1tQh3OpQmIbCdHtV+T5vH1A9yRf+MvMvt
         QJlnh7naJaBx7VKxF3koasQhajIbRQx7dQu4Qwd7PYKRysUxeU0XWSuXjYaeCyz0WGy7
         qPiF9/94pfOOjqSHonw37CI2oTcjwTzz2CQkEWx+RUFiiQANSSsooC0L3767CbDYFhJ4
         yDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857597; x=1772462397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWORPb6fb34LAVxof+FZjNAy04GbN7Kfnww3yYmf/ys=;
        b=OWQRIFQhcEYv/39Ks2orLPTshFV6j2/gnVH7q48Ge41TmMqXG+K7VwrylUqVX9+SIA
         dckjWFk37nJ39yMN31RmZ2fPhv1osdF1XV/t7cGZYS2aJK4NrGQntn4oh5UnoK6IktV6
         U/Q9LUOtvsA1rU8AisbylgQjfQW5RLNR96Guk8xKzMa/T9z6lSlIOKDg9PhRMxLa3UhL
         zM8/717iCLsbc4OLtspxYDhfBTLaO7EAVz7txxzjyNy3VrvxyR83m1AG2Kwu+gCnYa/x
         XJUBkCkQip/pj5mMMqX2IkNGdOCNSfpjbUK1oxBae9an+KXckwV6v0AbwKrj4Qi1LrKg
         Cx7Q==
X-Gm-Message-State: AOJu0YzeKWCrsvLLEi5YMhOQAc6BI4OLKhyDr/txDCzKcb/TXanzDS/r
	PMjQrvWGjvRUJQNwAVqkz+ya4k0zsJ2rSjebtUk/jtPw6OeaemxTDnU1P7bRf0VTdKzzotfsoSv
	r1Ck=
X-Gm-Gg: AZuq6aKiYsjwfvcmnkBJG41jAxtgR0FjPtSxBr1SeET/OtMEaq3Y4s8Xqmjm7tuYYCT
	RNQsg/7rpcwAVUi3wdt8mHbn/MIkVi56q+SK57nMwFCb+N7IJi+k0eZHk2EC0MtrcMHJHU8Zixk
	6mCL/LwvaoYpekDWEXLvh1wk9qfp4O8XW3C1uQabxQmt7gsyuoQzsJa6ELGT8C2X0IBi7q0uPxI
	yoLmHgq42ErX6MM/DjvkEKtwQShzulQufYB23oxCs+dshWKcYu+fKlRtHbltcPycOApVF/cLuxr
	lxVwShCAuX/Y73afMwoQcJpBdQouodiaCutUtpey73+xT8Tl4HuUKBFI8i0NvwSn/eMOJ/QF4m/
	kWZaVet1LrrdgnIHR9vR2J9/32iD+fzn4ANqlSAH6ljSykWOuFTuso0ARMnlcPVS6NfoD2V4gEH
	s81PCSRo1hLfBduec1ZkcccjJy
X-Received: by 2002:ac8:7f0c:0:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-5070bc6bf35mr117323131cf.40.1771857596854;
        Mon, 23 Feb 2026 06:39:56 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6e9e81sm70887271cf.32.2026.02.23.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:39:56 -0800 (PST)
Date: Mon, 23 Feb 2026 09:39:52 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Petko Manolov <petkan@nucleusys.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: pegasus: validate USB endpoints
Message-ID: <acc166b4-9ce7-4e95-8f2f-4300ee6dd27e@rowland.harvard.edu>
References: <2026022347-legibly-attest-cc5c@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022347-legibly-attest-cc5c@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,nucleusys.com:email]
X-Rspamd-Queue-Id: 8CF0B17827B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 01:58:48PM +0100, Greg Kroah-Hartman wrote:
> The pegasus driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: Petko Manolov <petkan@nucleusys.com>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

This does much the same thing as

https://lore.kernel.org/linux-usb/20260222050633.410165-1-n7l8m4@u.northwestern.edu/T/#u

and that patch also removes some magic numbers.

BTW, what is gkh_clanker_2000?

Alan Stern

>  drivers/net/usb/pegasus.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
> index 4f539b5d509a..94c17fed0bd4 100644
> --- a/drivers/net/usb/pegasus.c
> +++ b/drivers/net/usb/pegasus.c
> @@ -801,8 +801,19 @@ static void unlink_all_urbs(pegasus_t *pegasus)
>  
>  static int alloc_urbs(pegasus_t *pegasus)
>  {
> +	static const u8 bulk_ep_addr[] = {
> +		1 | USB_DIR_IN,
> +		2 | USB_DIR_OUT,
> +		0};
> +	static const u8 int_ep_addr[] = {
> +		3 | USB_DIR_IN,
> +		0};
>  	int res = -ENOMEM;
>  
> +	if (!usb_check_bulk_endpoints(pegasus->intf, bulk_ep_addr) ||
> +	    !usb_check_int_endpoints(pegasus->intf, int_ep_addr))
> +		return -ENODEV;
> +
>  	pegasus->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
>  	if (!pegasus->rx_urb) {
>  		return res;
> @@ -1143,6 +1154,7 @@ static int pegasus_probe(struct usb_interface *intf,
>  
>  	pegasus = netdev_priv(net);
>  	pegasus->dev_index = dev_index;
> +	pegasus->intf = intf;
>  
>  	res = alloc_urbs(pegasus);
>  	if (res < 0) {
> @@ -1154,7 +1166,6 @@ static int pegasus_probe(struct usb_interface *intf,
>  
>  	INIT_DELAYED_WORK(&pegasus->carrier_check, check_carrier);
>  
> -	pegasus->intf = intf;
>  	pegasus->usb = dev;
>  	pegasus->net = net;
>  
> -- 
> 2.53.0
> 
> 

