Return-Path: <netdev+bounces-273285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBDbC+C1ymmE/QUAu9opvQ
	(envelope-from <netdev+bounces-273285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:41:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E335F668
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDE1300F5E8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A5F3D6CC0;
	Mon, 30 Mar 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ePA2Sgiv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97E3DC4AC
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892387; cv=none; b=hD7DAZU9TDVUjCQ7rslG0Dlr709QkNN5/N6CHmizQsko3/T2dzC02YRTsp2UUrP04kaSJISLb0z98QY9vwZPEIFn7o6pAKJpuKhjNfg8lPdCM5w/QOnKp2/LGE66gGDl478ZDw3sI5KBLTGNd4c+Z7uQThflKBdXt5yH3tipVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892387; c=relaxed/simple;
	bh=eYiGKx4UJtJf4Q1Avkayv013k8Pwb2Zd8ZfL+Yv9bCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXBrtr1VYtMFQUwBfyii92C+Q909ju71bQSrRM/opHZggDuzVPbDm+0JKgr/EzloyUZ9wKI/Npx3KC9CEA44yV9IzgcepoQabBEketY/eowCS+AuqfSjTFWgGAUwQH2ozFM0Z+yAZpLLnfObRPh60KZBbfvyl9ixltk8It+9YDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ePA2Sgiv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so57976125e9.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774892384; x=1775497184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3tTxvSmqNW1V5FDg72/l9DpdB33WKVqHdXYeZvn1mY=;
        b=ePA2SgivNL+KhnjorlnoALd7eDjnnrysPSBFkO1IlTPrwvhdTUXSoC5gBnMh9jwrZq
         iQmtYjZi8BJgsTntn4KjRPfcVHTJmQLUnGO8Z5N3xX8JMLYVsmys0Qw9n6vgRnTmfJRo
         jhxYlmGcaYyXiTrq6ojY+duquZpU8rdrISNtKLvTqb8nVmnkMiAYohXUT5IXauxg/Ffb
         dPQrsM7hpTQYyJoS1kKqGvSbzQJBJlTltATHaEiVmzoFl3pBMTKUdvw7df5S3Y/6WdvO
         lMwJu+aG/dMaEPHrvHXpH2RZvgblJyd3ngAjAFROgxteHaCw8Hl3seh+d050mOnpa4C5
         MQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892384; x=1775497184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3tTxvSmqNW1V5FDg72/l9DpdB33WKVqHdXYeZvn1mY=;
        b=g3FxjpsyWvyFM9vd9GQaxWnjv3xbcaCmKpaL8EUQXVKnOuc0aQrZ3ZqJFcxEvHdqhI
         dfp96T1IGlaseZmHv91P6CPCBfgVhARPXzmTZQjH3Sa5oO7khzUhrSSA/dE64/RSj8Cy
         sFxSIZPYFIZeAWZIu+W64mPvCCt1DKpVV1oH4Em/0c6AQ+2MqRRu2MEdCwdY8T6c3Hmy
         Q9oc1DDKhldSGrkpjJrwVdGLApnpCEdaDqnjT/0bi0t4MIQPAUYgFgQ+wUzBibDThH1B
         0DI+68xY4rinSq/CG37y+FpmosiOHFI8fOYOhYazT+j3oMinmqVh4mMIXZO3inIposws
         1Wiw==
X-Gm-Message-State: AOJu0YwO1epJyp/CP81lodKA8ARGl1rDFHr6ERIuy3VdWLXPbH811mYu
	OQv/wcCWVYnLq08TW0JQbc4S4G6orW2SIiAvdsWR8tuB3gNmsxUnA0RrOVetBbdPGyg=
X-Gm-Gg: ATEYQzy7rF+S9AAnqdZaicj5nUObOs1JrCNG94yJNwJrzpfwfsaROw6jCqBJSUPmfnk
	LWz9XMl90jcHtgfC8GrszH/vozpoU9DpMOfngzP0PQFyGwV7ZhHRVTjv2qCA9HMeuPbPB+9mhJy
	QTYY/P6JbXF23LgQpLunjGWZ6IZJ9V59aHIiAtOc7C8HKX+sRi4Fik+wBLCw4syh6T/9t1MWJjD
	mmrHAVl/396GiSWjGCPogPBTYkb3NUjVVgqxnZ88WJHtfeqhTXjKJQwx2C1yzQqe6clE4XTS09/
	Ht6ibIqetDSdM4zfVs2ctbZjz1JTWrFA+EJjisl8R+6rpS7chCZki/zykQrGYXvuFSIbgrVPe8E
	mCyHd5PRInOjIZL3J0b+4rChY9z2XA7mV4X6Kleh6dXUVl+yl9tPLlh6Vdxehz8Wk4by3hfigGR
	KuWpyRTQX9n+s12QwvnQMfc/Fujg8DoV7SHHvR4SpnwwHH+I4j+kh0tgndvz3vajAJnA==
X-Received: by 2002:a05:600c:8b6d:b0:485:35ba:1d81 with SMTP id 5b1f17b1804b1-48727eb7fb7mr230986485e9.21.1774892383791;
        Mon, 30 Mar 2026 10:39:43 -0700 (PDT)
Received: from ?IPV6:2001:a61:1373:4b01:cc61:7bc9:bea5:a415? ([2001:a61:1373:4b01:cc61:7bc9:bea5:a415])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730688694sm183170845e9.11.2026.03.30.10.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 10:39:43 -0700 (PDT)
Message-ID: <1c660862-de30-428d-a772-8bee9b990a59@suse.com>
Date: Mon, 30 Mar 2026 19:39:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB
 suspend
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, steve.glendinning@shawell.net,
 UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
 <20260330134222.67597-4-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260330134222.67597-4-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273285-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: A78E335F668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 30.03.26 15:42, Parthiban Veerasooran wrote:
> The smsc95xx driver registers a PHY device but does not currently
> propagate suspend events to it when the USB interface is suspended.
> 
> Call phy_suspend() from the driver's suspend callback so the attached
> PHY can properly enter low-power state during system or runtime
> suspend. This aligns smsc95xx suspend handling with other network
> drivers that manage an external or integrated PHY.
> 
> Without this, the PHY may remain active and fail to execute its own
> suspend procedure, leading to unnecessary power consumption or
> incorrect resume behavior.
> 
> This change is also required for the EVB-LAN8670-USB Rev.D0 device to
> support OATC10-compliant sleep and wake functionality.
> 
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> ---
>   drivers/net/usb/smsc95xx.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index 42e4048b574b..3a6e03b7410a 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -1550,6 +1550,12 @@ static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
>   
>   	pdata->pm_task = current;
>   
> +	if (pdata->phydev) {
> +		ret = phy_suspend(pdata->phydev);
> +		if (ret)
> +			return ret;
> +	}

At this point you have suspended the phy.
Hence the device can no longer transmit

> +
>   	ret = usbnet_suspend(intf, message);

This wants to

1. drain the queue if you do runtime PM
2. can return -EBUSY

>   	if (ret < 0) {
>   		netdev_warn(dev->net, "usbnet_suspend error\n");

And here it will return in the error case. With the phy
already suspended.

And, as a question of principle: Why do you suspend the phy
in suspend(), but take no action in resume()?

	Regards
		Oliver



