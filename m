Return-Path: <netdev+bounces-184152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08443A9381B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 15:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991F87AE68B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43E78F54;
	Fri, 18 Apr 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4OHmR6K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAA224F6;
	Fri, 18 Apr 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984204; cv=none; b=k47wrtmYxMUb5cs0X5ldd3461v4pY7fbX6i7A3iR9Mvbcs30XvF1gnVeeE/int4JILXs1hrd+scKz++XXVZLc7lU9+hyuOAxrH9XPoYNFhnK+0cWi62YU6hLoULnxTUPMSFz9BDZ0Se3YMNFtoFDcvbchgKedjsKSrA/u6dOSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984204; c=relaxed/simple;
	bh=b3iMxPUCQpRg32E9ly0v4ay2UEkLVA23OpI4WICveZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgOgHmXBwNAcevlIRzJYdudWCUAAgAqDSJ1EmFJF/Ket6tTpeib33zcp+n+4+ew9uHOfvaXj1b+yf5VRO+wtqzhOQqayUIhlPeBeWVvM1pMrYo1A2FEIw0jrJOmS9hfR5tyeD9zCrVfXRA/mzD7wlqobalGqGgJKmUKrS82o9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4OHmR6K; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ebf57360b6so244890a12.3;
        Fri, 18 Apr 2025 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744984201; x=1745589001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fY+hDpLzJtBhDrBf6wESfqlaw9mSea9W1+P81uS8duI=;
        b=P4OHmR6KjiENVoCiLhCv+fiof5/meZhAk2f0+JYLHgozwm/LVydveomNO8wYhUmQfq
         TFw4NfB9PB8StBPdOMwFqRaXMiCNjuANsnUj8L9qG9iQZ7idTWuiJYi7rwAPU13160KT
         c1YPkqYZlCoMtj04Dr2TCHdeW2LM1kypaU8B7M4VnrdyELs6demSOJer47AFB7gPQIOE
         ZLhRf/Z1++kLCOpNVTgDRVl8hsq+8IhH2o0lkEgLIX1n6RY2VyuxaJiA9cI6dwc9nEtV
         KgROI/h4vKxLZn5xTuc/kYZLDPNQOuA2HwaTp+LvnYhTRsBe+brg2ZK1IIgqMIFhQgOS
         byrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984201; x=1745589001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY+hDpLzJtBhDrBf6wESfqlaw9mSea9W1+P81uS8duI=;
        b=SRr5w5WI2TMro/Pt9OSiTI89QwIFYaexvq/yz8X1o6MnSkew1OZK+TnE7gz5edPhlt
         UDjqvjy4l3kBaozXvKeypSuResQAPzOMVCcHIFvGlf9JWjJLH3zIupm2qVMfSLnDlJ3a
         mAmDgGIds6LNIwnz8EI7n9KlHyhOrMMGA7xKIiYIpmwqoZwovY17WbvV9tc/Lt/nsDEw
         DAd4T3xzRD3epHF+lmnplX54kfYwBtDFeD7GE4g/bJKsnmBhBX+QyCYHLpxWfFJoJXbj
         MD19rGE47WhZdaqDf7vYyGimMIIYLcejICRWJjmY97CcOLdz2OA9FPusG1V881eZgH6H
         Q2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWNW2rI8OszUSfJHXZUq6ucbfq7wloVNvbuz5R5zjA19QX6bJP7v6Y4szNX8EG0MJje7B+uoWXt8YaAHSc=@vger.kernel.org, AJvYcCWu5OtCELmkU3Iz7nLqTuWT9jdKjFKNRGqRMwtCtpy9kwPCtr+Jmi7zh4/IPtCcCl1ZZV+4zgdn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ad7voFHprCpiFo+1eLPj5npjkc4WBPIp5CA7tESGyh+pj98v
	eCF2HkOx/DrDEeDGeBG/il8oe6PUFLjc8xsNc6ZCBDMoUlhsovuK
X-Gm-Gg: ASbGncuULBh67gINgyfUjnXuJhqoDDRvek4jd83k5oHCGlz7xVRokoZYOio+CEiLxOp
	Q8ngzwzoZJx0r1RmspiBESIijQjW6k+tqp4Rn+mZTsfzcEkBqIZ9tQNykSn2MChki3EpjAP+Fea
	bxMWrUfRWW7Zm8fWODdJxL7ZXs8iO0Ac1sZ8RB4j+D/fnHU5zMK3RnA0IKzCDOXhbe25eaNaTH0
	fTiWGNCmvxZkxGntFdn8A+d8zQpYfrJ1O1KJlf5u7lLt5LcJg6s8H0JSDhG3EiK4qae7PV/mffj
	GQ6a0B/7QOV+RP/p9tmu+OSakDaM
X-Google-Smtp-Source: AGHT+IHjfpXDYgO9pT6Nw4Bezw1GjCosswQdk5p/7xF4ENGHQ2fIxqrauhJGFISGYIYBcl6ucEQa8Q==
X-Received: by 2002:a05:6402:4312:b0:5ee:497:5221 with SMTP id 4fb4d7f45d1cf-5f628628bdamr756775a12.11.1744984200603;
        Fri, 18 Apr 2025 06:50:00 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625578345sm1009703a12.28.2025.04.18.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:49:59 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:49:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 net-next 01/14] net: enetc: add initial netc-lib
 driver to support NTMP
Message-ID: <20250418134956.chlx2izlo6qcfzic@skbuf>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-2-wei.fang@nxp.com>
 <20250411095752.3072696-2-wei.fang@nxp.com>
 <20250418124905.2jve2cjzrojjwmyh@skbuf>
 <PAXPR04MB8510715CEE1461C5CC8D8CC288BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510715CEE1461C5CC8D8CC288BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Apr 18, 2025 at 01:38:31PM +0000, Wei Fang wrote:
> > Can you please add one more sentence clarifying that the LS1028A
> > management protocol has been retroactively named NTMP 1.0 and its
> > implementation is in enetc_cbdr.c and enetc_tsn.c? The driver, like new
> > NETC documentation, refers to NTMP 2.0 as simply "NTMP".
> > 
> 
> Okay, but enetc_tsn.c is only existed in downstream, so it will not be
> added here.

enetc_qos.c, sorry.

