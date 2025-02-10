Return-Path: <netdev+bounces-164700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FCA2EC1E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88DC3A50CF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9C1F790F;
	Mon, 10 Feb 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NziSCX9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74A14B08C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188935; cv=none; b=H/59EnH7ndK22xK/TFE9SjrGpIHbRkYsdj87wop6e6Qll/x8LT30URdO6VuCRXZWetW0TWxGIg2kad2WSopuRcVfTRAW8MiT7IIU/Hw/zFfEYtZ1BHW8vRr0Czyw6Ega/Zljcd4LG288lBcc7vseBsO27lviloMPcLVheRZsx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188935; c=relaxed/simple;
	bh=p3T/TnoKNAziM6VIjh2Ty4VZ4GuDYLvA2wCnxBac9So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5ms7i5YtFrbXRR0GtRGch4AUsCMdP5zcBsk4rVOBqwl11vjliYJ6yn51iJ5qK6sxzYTA1EF6+lWROFdwWxoQ3poAHBch2s5BWZOMhCsyJxgm9iADrcE0HCf769G4J1RTNSsQfXozU/qpslJ3204geBIJmUIXcXqp11fMZyYKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NziSCX9m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439490f5b7dso572695e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739188932; x=1739793732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qLRq58TQCfAe6aQj76IJLYK0CTvey2MwTA0KNfQNaA=;
        b=NziSCX9m/8/F9TOwlFlGTCagGAQse+ciLUUQGEpOTH7im8fjkvfp4hNb+4kzT+Y1qF
         QUaXgcsBa0HUuIk80yYXwqdQMMRETr685JsSSRrJKM/JKPkmGZHHMmIJRevwRNklIIH3
         SimodS22nUyONYQA+G77k658uAOZawxLvn+/enColivZZIqSAxnXQIulKYoKm9dw2AUD
         O7CQ9DZHFFmaGiSfxGM0rmyYGCPbvzaIrxgLMwCxiYzCNqEhls4oLAyC2nqaWw2zbVR0
         Sw9w+wz4ZW7zbv8EMrnaHfy12sV0u+fSqThcCvsf5pXg2HxgR7/ZfeW5WGCP0P+lAuuC
         VP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188932; x=1739793732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qLRq58TQCfAe6aQj76IJLYK0CTvey2MwTA0KNfQNaA=;
        b=DSXVUwsaRn9EFgA+sgYs4qr58h4NSahzM+WlhEKLVg70jdncC/A+RRqtXwPL0ZZQ8v
         fb3XIVtncM/sKJ6Sys5zJS3ZhhRH883gbmYO/V/8vFCnbRQ2pqaNKtIQrumpTbOVMP4Q
         bUi+w1VoAi/V1pH3XQdcDAeby+ebtzpUKNTq+NAP0rRnJ8vyqk95NSMxVhGzRH1IIU8R
         E9KhUvGqJTxeUXGjyxUpDktsCS/SjV3afLQ1jeSdygqwqtL0K/L22+bfM1biUdQBkrE7
         VMnUl8SrfqiCbpocK9mj8C+Sjy9dMA6wusXUv3/DBXSi9RdbCY88HV3j9Au0yT+WVVik
         /yvw==
X-Forwarded-Encrypted: i=1; AJvYcCXo/kiWcXR8II0EI2T2onWPy9hhJwirisrnoeVbIlJodxiWMBX3GMFMDq0hocK9q5PBMtzbNCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcT/zZmWV1wrcX46NQVhCztBTjTv2chiikLyVeKUdhKdxgSRNo
	Xu3i8bSVo5lQG1ODhF69kBQnXcVXrA92ks1Gxh+gHud5yjmEzirg
X-Gm-Gg: ASbGncsHRgXTsvb3RBjPhwcJi9+6e2arsRrcGjwamBoetsV8ggpS3Wk3hkLaV8U+7YQ
	5ijJTDzqvogXYAMaafl/x+yN5EFrf1mE1+NLG6waZYKTI/l+3kYC0qJgFYRFUBeNSJIBYEWjPlf
	PfFQ6L5+Nu7la6kKJXmikQWaqIv0VO6VFivRiIJ7gu2MzT21WbUIpGdVfeQq028ugsM9nnTglrJ
	R0gi0RpNzJobMFHyubnYElyi1023rUNNj4pujF0NKWq7QOUBZ0Gbgyg2Q7iun6Sc8opbZkHvW8Y
	bXU=
X-Google-Smtp-Source: AGHT+IG0QgYSgntnrTcR5lfyYg5fWrJbxYwJz8Aiqa6l2edj8U4YVxCYHZwaTgGYveWuF4J1ehDYaw==
X-Received: by 2002:a05:600c:1c1a:b0:42c:c0d8:bf49 with SMTP id 5b1f17b1804b1-43924a2cc74mr43178055e9.0.1739188931637;
        Mon, 10 Feb 2025 04:02:11 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439447ee508sm29313305e9.6.2025.02.10.04.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:02:10 -0800 (PST)
Date: Mon, 10 Feb 2025 14:02:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tristram.Ha@microchip.com, UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/4] net: xpcs: allow 1000BASE-X to work
 with older XPCS IP
Message-ID: <20250210120208.7y3eehmuri5nwore@skbuf>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
 <20250210110555.stuowh5l6hmz2yxh@skbuf>
 <Z6nnwfPtm9LqK3rd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6nnwfPtm9LqK3rd@shell.armlinux.org.uk>

On Mon, Feb 10, 2025 at 11:49:21AM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 10, 2025 at 01:05:55PM +0200, Vladimir Oltean wrote:
> > I do believe that this is the kind of patch one would write when the
> > hardware is completely a black box. But when we have Microchip engineers
> > here with a channel open towards their hardware design who can help
> > clarify where the requirement comes from, that just isn't the case.
> > So I wouldn't rush with this.
> > 
> > Plus, it isn't even the most conservative way in which a (supposedly)
> > integration-specific requirement is fulfilled in the common Synopsys
> > driver. If one integration makes vendor-specific choices about these
> > bits, I wouldn't assume that no other vendors made contradictory choices.
> > 
> > I don't want to say too much before Tristram comes with a statement from
> > Microchip hardware design, but _if_ it turns out to be a KSZ9477
> > specific requirement, it still seems safer to only enable this based
> > (at least) on Tristram's MICROCHIP_KSZ9477_PMA_ID conditional from his
> > other patch set, if not based on something stronger (a conditional
> > describing some functional behavior, rather than a specific hardware IP).
> 
> So Jose's public reassurance means nothing?

[ for context to all readers, _this_ public reassurance:
  https://lore.kernel.org/netdev/DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com/ ]

Yup, this is what I'm saying. He basically said that it's outside of
Synopsys control how these bits are used in the final integration.
And if so, it's also naturally outside of vendor X's (Microchip) control
how vendor Y adds integration-specific logic to Synopsys-undefined bits
for 1000Base-X mode. Thus, the only thing I'm saying is that it isn't
the safest thing we can do, in Linux, to assume that no other integration
has added a contradictory vendor-defined behavior for these bits.
It's an assumption we aren't even _forced_ to make, so why risk it?

