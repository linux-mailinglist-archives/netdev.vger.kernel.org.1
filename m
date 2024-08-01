Return-Path: <netdev+bounces-114977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA7944D60
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98FB287D4B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF341A4873;
	Thu,  1 Aug 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUCYuuhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262A61FF2;
	Thu,  1 Aug 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519848; cv=none; b=bClMaSKgZJrlnvmQX1ucID0jL1oayIkTRRXcbSDggrm2HEwOeuF6rD3MmuqzPr17j90qk/NazEFvK5TpbkJnrsRnjumdDtnrbd7B8M72eK4sVa7y2mL+YZVlvbjglYcWIumzuDA1SsaxKCNsm1BkBobMoePq1eYZ3eIXkaSn9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519848; c=relaxed/simple;
	bh=thFxg8OzzcxQf4MMkIWf1lfjmAKKVKW6trC0V+uF7Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3ebfXkzGPMGDApPhrh6PspcQfv2lHf48D6SCWuyBjajK7MPgak+xwM+yEW9Es8W5fPNQ42MvekC3AktLyiOHRJkZrZkVNX2AFQ+P158Q2OQk5kutVgphmErJtldbaLDbNKgQAUS1ngJPGHow8+UyXzSDi3e110q/U0tvci4cuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUCYuuhE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so11151224a12.2;
        Thu, 01 Aug 2024 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722519845; x=1723124645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X88/CsdmLmbELcktNgy2HM0ZWdZzSy/cvXSHWDa5C9w=;
        b=lUCYuuhEIP6x+2OyTUxdJ3JVIUC2k/RRuMtwqPDM48SeQbr4BdMFg8NPc7PAHU5rrg
         2MM1AJQ+ELF9bub3U29X8UJvHtlbRp+cNE54WJcdEX3dWby2rH34tNSIOxObgrK3uao1
         iiKHxaMwkAemXfQ3DmKYTrJIPCViJzhbtRvjytfSVINcoBa6HgPCD+IUgGCxOk+gB4Dx
         lEGdLUv/zfSGnzch7DryhZ35wIpFb21Y/MrUZ28ZVofp+j5THPDIR5NC6pQuqhKeoTo2
         oHEAf/sHNDspi7/hddEQguitsVL8AMHhGJupJ8z11p4L4dD/RFoY4P4CZVxMO3uVx4IM
         GxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519845; x=1723124645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X88/CsdmLmbELcktNgy2HM0ZWdZzSy/cvXSHWDa5C9w=;
        b=lPUoVQY4WLJwpH2P4sJDh0Y1u02q70DDGezgl+9JuSfNLyW4DoJLdqkArSwgtu9Xc/
         ZbuDYZ+a6J5f/KkdmW+7fQp5esyo/dbbGCqmTdzHca3LW63l/wM28bXCem2/TtD2Ysyk
         SFuQ9g13mFOl2pNHuJWWf4cTzY+OHTCH2qWCr67V0i91ZTA2v/UScZpsw6iZ81tln6Gh
         U/BNPsIHvKoKH4Rsu3/Iuz9x3hu7V3jWIbMOXD+MW3Lo94RzpJdJ0t23lu6gWlqjjnvJ
         4o8FR5pqZVvf3EZVRm1rpJlrdADfgfUdzGzZysSCBgpyTo1kFQXu4doTJ4an4DjPKlr0
         Z8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPw40BQRN4uL6zHI5ZPYxYlgJ4A0VzRLk10FzQUyKZQOqiu+npTtoXDZGxMAaxn4/2ewS8jGpIJJKYrVc5VmbUdKNLcLKu
X-Gm-Message-State: AOJu0YxqIEDTVvDpYPzeEGUmLBMEE6TCeFdAvSyA22JEa2CaSLSYErA8
	hUSa1yJQ7Rl6A2eXEnYctQ1/uEGQ3xj/vePiNZ8Qbm2W+24E/yzA
X-Google-Smtp-Source: AGHT+IGFNv2QHGvPS9i2SZVHutTLhDALDLT5CL38a93ykAR/jj7dmB+landsIUaymqtGa8TIH7UKPw==
X-Received: by 2002:aa7:d552:0:b0:5a3:f5c6:7cd5 with SMTP id 4fb4d7f45d1cf-5b7f550a75cmr238198a12.26.1722519844469;
        Thu, 01 Aug 2024 06:44:04 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac65783665sm9979717a12.94.2024.08.01.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:44:03 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:44:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 0/2] implement microchip,no-tag-protocol flag
Message-ID: <20240801134401.h24ikzuoiakwg4i4@skbuf>
References: <20240801123143.622037-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801123143.622037-1-vtpieter@gmail.com>

Hi Pieter,

On Thu, Aug 01, 2024 at 02:31:41PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Add and implement microchip,no-tag-protocol flag to allow disabling
> the switch' tagging protocol. For cases where the CPU MAC does not
> support MTU size > 1500 such as the Zynq GEM.
> 
> This code was tested with a KSZ8794 chip.
> 
> Pieter Van Trappen (2):
>   dt-bindings: net: dsa: microchip: add microchip,no-tag-protocol flag
>   net: dsa: microchip: implement microchip,no-tag-protocol flag
> 
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    |  5 +++++
>  drivers/net/dsa/microchip/ksz8795.c                   |  2 +-
>  drivers/net/dsa/microchip/ksz9477.c                   |  2 +-
>  drivers/net/dsa/microchip/ksz_common.c                | 11 ++++++++---
>  drivers/net/dsa/microchip/ksz_common.h                |  1 +
>  drivers/net/dsa/microchip/lan937x_main.c              |  2 +-
>  6 files changed, 17 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 0a658d088cc63745528cf0ec8a2c2df0f37742d9
> -- 
> 2.43.0

Please use ./scripts/get_maintainer.pl when generating the To: and Cc: fields.

Not to say that they don't exist, but I have never seen a NIC where MTU=1500
is the absolute hard upper limit. How seriously did you study this before
determining that it is impossible to raise that? We're talking about one
byte for the tail tag, FWIW.

There are also alternative paths to explore, like reducing the DSA user ports
MTU to 1499. This is currently not done when dev_set_mtu() fails on the conduit,
because Andrew said in the past it's likelier that the conduit is coded
to accept up to 1500 but will still work for small oversized packets.

Disabling DSA tagging is a very heavy hammer, because it cuts off a whole lot
of functionality (the driver should no longer accept PTP hwtimestamping ioctls,
etc), so the patch set gets this tag from me currently, due to very shallow
justification:

Nacked-by: Vladimir Oltean <olteanv@gmail.com>

Please carry it forward if you choose to resubmit.

Even assuming that a strong justification does exists, there already
exists a mechanism for disabling the tagging protocol from the device
tree. It is the same as for specifying any other alternative tagging
protocol (applied in this case to DSA_TAG_PROTO_NONE).

	ethernet-switch@N {
		dsa-tag-protocol = "none";
	};

it just needs implementing in the driver.

The fact that you chose to add a custom device tree property suggests to
me that you did not investigate the problem space very seriously.

