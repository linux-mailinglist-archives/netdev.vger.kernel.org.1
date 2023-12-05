Return-Path: <netdev+bounces-54030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC31805AD5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589BB282095
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD9F69295;
	Tue,  5 Dec 2023 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwHU84E4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B75A9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:09:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bffb64178so2035286e87.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701796195; x=1702400995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XQGZ9T9MrlOrzbpw7fSt0ofhz5b7fz92bdI0zZzenY=;
        b=lwHU84E49xMsjEKMNIwz42P12KLuVodUp0Kniw/Wi+MEKOuLKf1iNxnBLJgTMMtbhM
         qY9+9szixYlDrYjGp4SH/+Z3cjOYs20a+Tr0Y88V3vFhFo5R+wSHV7mNEcM0zKom7/ni
         VLuZ+Osyo/wMDj1/Lz8ChDFZ4hBXfeSvaQNalmClMDCn6nyzm3PlvQ/vIBxae0nExV6m
         88n3BiXMG1fKThL5Ee7gHl27PDnBkHKtNuHOo/OaxPMbV77yc9TnbiNu/aMDgBaLtN7h
         fByvd91alhTh3pEAu7l4JUzSvId4i9wAym0TaeGAaltcgPVeFfAcoV/GBqYnb4b1CFas
         SdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796195; x=1702400995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XQGZ9T9MrlOrzbpw7fSt0ofhz5b7fz92bdI0zZzenY=;
        b=rb8KJlmoQZyO2Z5gHxfBFfXZEQuG/iR1u6bwZ9/O+/lNIqQrvjVtw2GHxgapYIsWDF
         eiHK8cPEArPtRT95gCd3fK4ADIrmQwopAfHj9gg5m92VCivQDuJHmJbajyOuq6CXwx0m
         KkkW8aISKf/lYblGweC+zj1FClcqzeWEl7zS7s72jAnNCD1eSIBFecthLw+LUfLUVzwn
         LjjlGH4gy1ScGRQ57uSX9aWP/oEzK9pKsIzpe+lgwGJbPHn/rE0WiniHqplaXwSrNeC3
         1coPPcodeICDjFdb3JiStLkxOZyk9Ge9RWkxkkpsBhTzCGv/PnAX8vwA7orF678xP2zy
         3f5g==
X-Gm-Message-State: AOJu0YxOge5y0e9DluUhjcZwhBmcX7PmlK1d73jfD7hXOwB30o0Vuo4e
	h9bmE6SafX/wT9mvcCRgC98=
X-Google-Smtp-Source: AGHT+IH/Im/XC1uYAthMXXBdkF1wtL9cA7nonoojFqc4N3ZjgHBA9h1UpElrOsa/eMO3+ZLLSd/rwg==
X-Received: by 2002:ac2:558d:0:b0:50c:60:eedd with SMTP id v13-20020ac2558d000000b0050c0060eeddmr912766lfg.23.1701796194614;
        Tue, 05 Dec 2023 09:09:54 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d889000000b0054b1360dd03sm1344983edq.58.2023.12.05.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:09:53 -0800 (PST)
Date: Tue, 5 Dec 2023 19:09:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	ceggers@arri.de, netdev@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference in
 ksz_connect_tag_protocol()
Message-ID: <20231205170951.x76gswlwvq4gqx3k@skbuf>
References: <20231205124636.1345761-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205124636.1345761-1-sean@geanix.com>

On Tue, Dec 05, 2023 at 01:46:36PM +0100, Sean Nyekjaer wrote:
> We should check whether the ksz_tagger_data is allocated.
> For example when using DSA_TAG_PROTO_KSZ8795 protocol, ksz_connect() is not
> allocating ksz_tagger_data.
> 
> This avoids the following null pointer dereference:
> Unable to handle kernel NULL pointer dereference at virtual address 00000000 when write
> [00000000] *pgd=00000000
> Internal error: Oops: 817 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 26 Comm: kworker/u5:1 Not tainted 6.6.0
> Hardware name: STM32 (Device Tree Support)
> Workqueue: events_unbound deferred_probe_work_func
> PC is at ksz_connect_tag_protocol+0x40/0x48
> LR is at ksz_connect_tag_protocol+0x3c/0x48
> [ ... ]
>  ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
>  dsa_register_switch from ksz_switch_register+0x65c/0x828
>  ksz_switch_register from ksz_spi_probe+0x11c/0x168
>  ksz_spi_probe from spi_probe+0x84/0xa8
>  spi_probe from really_probe+0xc8/0x2d8
> 
> Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission timestamping")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 42db7679c360..1b9815418294 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2623,9 +2623,10 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
>  				    enum dsa_tag_protocol proto)
>  {
>  	struct ksz_tagger_data *tagger_data;
> -
> -	tagger_data = ksz_tagger_data(ds);
> -	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
> +	if (ksz_tagger_data(ds)) {
> +		tagger_data = ksz_tagger_data(ds);
> +		tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.42.0
> 
> 

Please spell out the list of protocols for which the driver should
provide its deferred xmit handler. This is what the "enum dsa_tag_protocol
proto" argument is there for. AKA those struct dsa_device_ops that do
provide a "connect" method: DSA_TAG_PROTO_KSZ9477, DSA_TAG_PROTO_KSZ9893,
DSA_TAG_PROTO_LAN937X. Also look at how other drivers do it. My bad for
not spotting this during review of the blamed change.

Simply checking against NULL might be masking other problems and making
them harder to spot.

General process-related information:
- Please designate the next email submission as "PATCH v2 net" to clarify
  that you are targeting the net.git tree for stable fixes, and not the
  net-next.git tree for new features
- Please use ./scripts/get_maintainer.pl more diligently and copy all
  the listed maintainers to future submissions.

---
pw-bot: changes-requested

