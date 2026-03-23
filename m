Return-Path: <netdev+bounces-270788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL1EJVa/wWlSWAQAu9opvQ
	(envelope-from <netdev+bounces-270788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:31:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374772FE44F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E259C30571B2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5D382F05;
	Mon, 23 Mar 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXwiLEqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6B154425
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304877; cv=none; b=tWQQ0z7hfT10tORrwzNFMk7o67QJazHzu+H6+weAt5GettzeUWVPruPiQ8aBplVCETmdNAccnUT2sbmrT1We/7WGtqfomamKqIkX4wGrTbg0PZhqGWiOLo1ny4esBn/XW/oIQrBpYSILd5A6tOS9Hj8rOGb+I2ZsbQHXr2yfsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304877; c=relaxed/simple;
	bh=t3DRPPEFmGvn6CLbNxf/rnOA0bdk4BEKupzcqZRYTk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK5uofQ77LLclifxCz2ljTjBkMQGIGEV091MM0AIu5aNO3BTkxYuESf2bE9DZgCLp2vj6t7paFGxn2hvFEwzs2AUDbzw6azZ55kVm32r+TXvLj/T4emX8vuWkKWS2Oxy3nW+iIKPWGhhPi9y7mQAoD2J1tI0zXlEspoPHW1C6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXwiLEqp; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c107ef474fso1470728eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304875; x=1774909675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEJ8II5Mq/xurnYxGbenRnl9vYWDBkm+Mx+1ug12uRY=;
        b=KXwiLEqppMPL+0YiNEsTHlixOZ4HNETs2No9NvHXpOtYnk7u0a/FWbqsWbAL4EdFRB
         EYbvEcKYUtiKXjm3Z+Tpxius3qtVX41SlPiWXYoCmym1raFmzmkCHknW8vBAbwZ5CRl7
         X+OPFsH7si8sMvPhn5GGOoKn7wNv7bfJrwLbQx1AJrKzmoZoJc2jS4MbIFLORjQMmwXC
         OfDZUb0oBi8CdWtyFhsDs2W0baJ8WAh0oYlc+detsjuOOK4n2tV78JyL6a42IM+rhS89
         WGUurGG/WsRiCRZ7BIyWzGN/CPqMov7HvLi3dKSqO/clWHOAmiPnH52DSPD0FinqBE4J
         Qk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304875; x=1774909675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEJ8II5Mq/xurnYxGbenRnl9vYWDBkm+Mx+1ug12uRY=;
        b=FVfqBAgb7e93fAmEeoDVMOJilvUuYlT2CGqVxYAX2faxMMzKyXBYiccGjeBT1wimM6
         DJTYx8nXlpAtju1KH44LdiUDSLvQz/VHImAWFTu/W56CJSC3dVE6dbQbXrtLW3mU4lFY
         vDXlWI8keF8Hyx3GQrGfODKsMhiq7Gh0Qf9D+gadh4oUjicIZT1j0bpTiqv+1bQHZeGq
         3La3JIFA6HqQpXCp8vqh2aVP7Mj1L9YsDhrVoXSg+n/NXdMmelbV9NFYNsc2vGki0gvi
         sWDHsaXAQqyt83p5dc6ZxuQw+DxJaWukvKc9P/yl35sP7qpowhSXqcDYIXkDIX9Z6er2
         jV5w==
X-Forwarded-Encrypted: i=1; AJvYcCXdfdvllVWgJePpLHNRUsqawPr27886StqmGhX2K3kNG8rLymcT0+3UzN6nG1NPLeQEinwm/qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwS1aj2ob5FVKeeJZxIkQomE1Y+1wKIURU3JHB2G1vHFU4K0/
	6IowaykoEPvdRiZtrpAALSS78M+lwPVf7VxkDPTxO8Vi6WyEkCrmwbPK
X-Gm-Gg: ATEYQzxvXgFwI7GTlTZATSRFWqfUu39RVvmXOgxBDaNjEgj7sHognL57Z7nPOrmAuto
	yn6g8bECEi5JFN27vDQNqcXXJXJq3hjdZauLM3okpKBZFywheTr31TiJSgbNi6cOd2UFjYudq63
	N8/HMWgwnxFNUyAt4qhqA20h+sKxUK89iyj2FboUxu1jmgVdlMg3Fgv6PLgvL26WP7zCGsvNaOO
	+D+r6LaQIv6210BStsNSCdN5ujTSmOX1N2GIDbxqKu0kryF2ggUXW9w+lizWhzCkoPynJDBD+pW
	iQj1+PXX3vHaKBI0g3NezckI0ElWSleGRu4Kk9u+nmKK8Shz4n7qhXLTfT7Hx8WArUZp/ru+Csx
	f3vg7dUu/WATApyyoDKoBp1XQOuLTBNBD/wbdlAcEYy0F3xnQnF8bzZlagzvbnandmZQgZ+3saG
	8EApRfXw/J4XWRZGPwuNsNiPfhOud3gDxwbb4yIQqsw6AiHwFMMeDxz4eSsF2Eldf3
X-Received: by 2002:a05:7301:4198:b0:2c0:c775:a46b with SMTP id 5a478bee46e88-2c10961ef1bmr7002696eec.8.1774304874980;
        Mon, 23 Mar 2026 15:27:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm13226951eec.22.2026.03.23.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:27:53 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:27:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acG9BPkFr_De-ulu@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <cf92122d-6b15-458a-bf89-189a0a6874f7@lunn.ch>
 <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
 <acGzJV3vKhuty3nd@google.com>
 <09072374-65e7-4792-af7e-97d7df93f9bd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09072374-65e7-4792-af7e-97d7df93f9bd@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 374772FE44F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:11:58PM +0100, Andrew Lunn wrote:
> On Mon, Mar 23, 2026 at 02:41:03PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 09:36:07PM +0000, Mark Brown wrote:
> > > On Mon, Mar 23, 2026 at 09:01:47PM +0100, Andrew Lunn wrote:
> > > 
> > > > How do you handle deprecated OF properties? This is a problem i've run
> > > > into before. A developer needs an ACPI binding, so they blindly
> > > > convert from of_ to device_ without engaging brain. As a result, they
> > > > bring all the deprecated OF properties we want to die into the brand
> > > > new ACPI bindings.
> > > 
> > > Honestly that one hasn't really come up much for me - not too many
> > > deprecated properties.
> > 
> > Given that we position properties as an ABI even if they are deprecated
> > we supposed to handle them forever. Newer properties usually offer
> > benefits over old ones and that is how users get moved over.
> 
> ~/linux/Documentation/devicetree/bindings/net$ grep -r deprecated * | wc
>      75     361    4195
> 
> So networking has ~ 75 of them.
> 
> Within the OF world, they are ABI and we need to keep them. But we
> don't want them in ACPI or any other firmware. Any code looking for
> properties needs to know what is underneath so it can decide if it
> should look for the deprecated, OF only property, or not.

If there is a deprecated property you can do:

	error = device_property_read_u32(dev, "prop", &val);
	if (error == -ENOENT)
		error = device_property_read_u32(dev, "deprecated-prop", &val);

You do not need much more than that... Checking node type only
complicates the code, especially when a device can be used on both ACPI
and DT systems.

Thanks.

-- 
Dmitry

