Return-Path: <netdev+bounces-243885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AFCA9886
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D478F308D46A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A562E091D;
	Fri,  5 Dec 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zv1Zhf1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713D2C158E
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764974668; cv=none; b=t4DJzOXANYvgWEeUgZCAKprNSN0aX9Y8Bd02HtQdyJFMimNURPDtx2Z2m7nNHcmu6u97lY3oR5hIa4l/e95JOrtHJKNRUh3V72k8MIg4q+vnngyH40/55yCovuGSMqtrABpqYkCVZZjHjYxW0rgN7kydSsGMuhmHutDWSbRj0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764974668; c=relaxed/simple;
	bh=TKxYuJzteoTXG6aiRaAQt7uS35uRcSX+14ELdeuuSSY=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=fI0VkNZVuj/kNrKpGOk9Ve4g4rRZcMkVO3F5gyxIYBDHdFKC8gv18kpgkZeuPPB0YHGas6F+v17I3Mzp9H/swONxWZEF81RLzwP0XCYxYReX0haKkEsaF6zPzAnayAPVckbomNTSK0QLi+QWGyAdtvDXhUaVlNiIPHjQ8yt/MbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zv1Zhf1G; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297dd95ffe4so24719185ad.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764974665; x=1765579465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpEx1ambYyP5Rtm2X3yIyoxtb1u/IW39Aq3QNvu0oX0=;
        b=Zv1Zhf1GFRlBr5toEsojie8/qGvwVP36FYHZmrY9HB7RUfghbJdvb9pLmXSVmG/p7Z
         tBrOOZ82zGHA4ePKF3QWyMG+YpOsSFaKZtTJLUlF8ydtO37oHegGW2E5No/iNoOsffuP
         t2cyXHin36mq0z8DSNvJridInhBDQssEV+m/bWKKUnakw8JMvEM4HSlkHImJCLNLicnJ
         kv5i2fyCXg8VuXFIm1Po0krt7tsOpC466INVhpn1B3Mu77ZM6D/Xpj3h3BBPnTm0nEVh
         L9Ew7EmTKH3HCDNPHhhJ+RvUmDfAUpyQz3ELTpmERJXJ8ZITloZaOqkA+fEi6WYiYwtj
         gY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764974665; x=1765579465;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpEx1ambYyP5Rtm2X3yIyoxtb1u/IW39Aq3QNvu0oX0=;
        b=sxjf+e7EQx9sF1AJWES3tdFmKuH/FLI5dNd3A5p2vJMK1ff3xPTtgD6l+ZtQOuSw2a
         ig/Z3QOphGmK+cb/s1DG79XummeyV4ZfIKb7FiQQiFmEkTQIHskf3cl9FI2j9mIEsl8n
         hf4UuXMHS8dUiwRUUMcTRoCGBaq4IS/qx9wboMdgTfCXBYF1BT7Ss53A8sZw72F2zsxm
         zv4RKUTlPleNCQM9LHBFRhWBFDWBPV9whY2KvymVDgn6YHYq5iW72pEC97nIA2FPRHky
         7PrGgAuGMpTNjF0s7MtiyKaF5AL1vR521RjUquoAFFRj9Xpn0AHSv/jqEkTe3tNPcT9v
         xM1g==
X-Forwarded-Encrypted: i=1; AJvYcCXMgj9mdnFPPD6U2ZqjRmmgc2jo+Cu3jB2DSCx6aFLuwTZmnvsRe3YA/HtySsWIaYifAMxj4AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMNJSQTbn8GpaZKMi9sgYJSbHcnIe5NImnnn9x39RdRTk35v4
	b83sSP7QQSjPoyLrfzdtZN5iaSEiLpJ1k6gV5nGuQB460DTlK2comurLAfMx/7+4E7g=
X-Gm-Gg: ASbGncsb8HkxNU2pqqSwSW1azwlBIbRv8K+bOU1LCGXsNNpmsLQIJjPSMNEe/68uJOc
	FazPMjk/ziK5F/HpxYT9NBcq3OvkJqABRLlomErSVWJj7hxBf3rjYkOE/4UmZC7muRMtrCn0SlL
	8u1A0fW3o3sQERzoxZJiOrI0rucFJPDMeOqmeexx21+gUFHMrBPlnVLOzvbbecdBC8HUsg2fxGg
	9tqLa5PEIOFvy+NQAxF+9MXG8lAFom0rNihgGTKWiBFl8hvcLVCJ/73RaWwTLxS/8Z4eKEHAJ48
	EvQEVIQ3HvFjjZLalhKu3eviM9WQsdrs4UyA4RwZZjiiHUA06iCgcwKqCnaryyta1bWFt3w3lP0
	9ypmCHkD5Gw8C6J+fY2ARQ6ONmhIWJMWLm+dKGfz4tiFz0xRybYgQT6GpoYNvFJBWBdHlVbKKqS
	v7Wcg7cCNpLre9QuzbSoGDhxsJ
X-Google-Smtp-Source: AGHT+IFhpI3ZHThmGhcjIO8StUj5kK4J0ohrFCCoQv50ysO8or1KHcNeUUJeASTwpDf5xm+pApbegQ==
X-Received: by 2002:a17:902:ec90:b0:297:c058:b69d with SMTP id d9443c01a7336-29df5e1b869mr5922005ad.34.1764974665492;
        Fri, 05 Dec 2025 14:44:25 -0800 (PST)
Received: from [100.96.46.103] ([104.28.205.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29db93d244asm45943365ad.63.2025.12.05.14.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 14:44:25 -0800 (PST)
Message-ID: <a2abd596-f8fb-4c2b-9181-7c2c9f0b9936@cloudflare.com>
Date: Fri, 5 Dec 2025 14:44:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: jbrandeburg@cloudflare.com
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 IWL <intel-wired-lan@lists.osuosl.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP csum
 mismatch as rx_errors
References: <20251201233853.15579-1-jbrandeb@kernel.org>
 <IA3PR11MB8986697A94FB36E893C7E87FE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <d6dcd835-7564-481a-a854-25b187893e6c@cloudflare.com>
 <IA3PR11MB898654344D883B1CC06A7636E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898654344D883B1CC06A7636E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 12:56 PM, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com> wrote:
> 
> 
> > -----Original Message-----
> > From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
> > Sent: Friday, December 5, 2025 8:05 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Jesse
> > Brandeburg <jbrandeb@kernel.org>; netdev@vger.kernel.org
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; IWL <intel-wired-lan@lists.osuosl.org>;
> > Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: stop counting UDP
> > csum mismatch as rx_errors
> >
> > On 12/5/25 12:26 AM, Loktionov, Aleksandr wrote:
> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> >>> b/drivers/net/ethernet/intel/ice/ice_main.c
> >>> index 86f5859e88ef..d004acfa0f36 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> >>> @@ -6995,7 +6995,6 @@ void ice_update_vsi_stats(struct ice_vsi
> > *vsi)
> >>>    		cur_ns->rx_errors = pf->stats.crc_errors +
> >>>    				    pf->stats.illegal_bytes +
> >>>    				    pf->stats.rx_undersize +
> >>> -				    pf->hw_csum_rx_error +
> >>
> >> Good day , Jesse
> >> It looks like you remove the single place where the '
> > hw_csum_rx_error' var is being really used.
> >> What about removing it's declaration and calculation then?
> >
> > Hi Aleks! That's not true, however, as the stat is incremented in
> > receive path and shown in ethtool -S. I think it is incredibly
> > valuable to have in the ethtool stats that the hardware is "not
> > offloading" a checksum. As well, all the other drivers in the high-
> > speed Ethernet category have a similar counter.
> >
> > I hope you'll agree it's still useful?
> 
> So, the hw_csum_rx_error still will be visible in rx_csum_bad.nic as 'private' ethtool statistics.

Correct.

> But I mean it will be not reflected in the standard "/sys/class/net/<if>/statistics".
> What do you think about it?

As the commit message said, no other drivers reflect this stat in net/interface/statistics (also there is no where to put it). I think not showing this is the whole intent of the patch. If there *was* a bad checksum it will be reflected in the kernel's checksum MIB stats, because the driver will have passed the frame to the stack anyway.

Why should this driver be different than all the other kernel drivers I mentioned in the commit message?

BR,
 Jesse

