Return-Path: <netdev+bounces-219940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18841B43CF0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE22C3B8F48
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7D2F5331;
	Thu,  4 Sep 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIduNvg/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FB158DAC;
	Thu,  4 Sep 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992079; cv=none; b=V/gZJnFopJE8Jw+60wVT9HpexAWT1AhoQPgBJxFxYEAe5eI0GRjR/WJvV/tvWns4QApfizaqcmM573SRd053jlEjXIdUzDjnTt288qcU8KlRULSuD7yFdFMEgMUcx44XEcGNmwkmaVSnU/31upBEElXpMoLJVHQjbXYw50aNsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992079; c=relaxed/simple;
	bh=/0B3jovSesp/hxR08tvuxjzy1mvl0Jv+lkX17ZO+zUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxT5D1Z6RPxxp1cmx2N51EdyuGB13fvH2/eC5A0rY416kQx4Fz7fDyjtFNfZ1vQs4jyr61OHjbx5RH7qzmHW5nHWrwGkjJD/3PjSCungxPsA+8ASSQYb8LxIpvQ49NK+wt5Uxe9s7BjZezfsTDUPuBwc4roYSr1kOgP0y7r+VDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIduNvg/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60110772so11171997b3.0;
        Thu, 04 Sep 2025 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992077; x=1757596877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UW3lWz1gWateAvfJ4OmLaSxYKXnyj9z9mVCRV3AJ32A=;
        b=GIduNvg/Tj3AOqfhcp6fWcMKkPYbvFK1ex6+DvQjQiz/NZ4e3JPQbubFWoi3nuc9da
         Br9fi581SrCqghUcU6scW4/JyG1qRHpFTMY4CFcl00Oe1YqtBnDHD+HnJigl516pQvdR
         QGxHzUpcrReE+ccMCN/wD2ZvOof/rgAOFkAbKZFpHqV1wtY3fwt9msTtJoVhK8hWfknI
         o/TbRs6IxMCb2IHpGm7hSZltuzgTGII2vLLZaWDk4bmxrql6UE8DyuVPjXqsMUungz6g
         KrDzK6uR4K3cR1EFhqdPZD3AL40oI+5I8bONuKAz4JKHoZNQW5pYCe6dkgHT+K0nlsa6
         vgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992077; x=1757596877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW3lWz1gWateAvfJ4OmLaSxYKXnyj9z9mVCRV3AJ32A=;
        b=OHAfVT+Fvzx22HuQ2C2s2GQJOjf+Y737bDZus32PGgL3rPTeQclU0VsH/A02H+qoId
         UQ3ts0g4WwUkZFsVIfIAfDPXbJh8u+J550q4PR3FrqpwMoAoPUnO3D8UR6zEJ5ts1jLG
         026uqr4zOsTrtHEVb/pPanXwAoyHObOh6tsrDqs1I4mL4DalN/Fpk115SLENfLJAoR+8
         mIm1IwGYnxWzwA8k0t58UZMWteSCq+Oq+ZG5y/s9KypXvaKyYDN24iAJ2qxFTR8kZ4OI
         U3r9sepUUmsGGhj9BlstfDjqjqNsaXw7tSoVSRI9u8v88HaLjSTqeCb5N5OpiyY1GCE0
         D78w==
X-Forwarded-Encrypted: i=1; AJvYcCU0byhzbYajmMZLMvTSVWy23Ks5ijp8Ac9LfPHcLpMqbrNyZYmISvBRpY0aBUhPMHp/YXfnhUqpbUFp@vger.kernel.org, AJvYcCUUKBSY6IJA820geomG5RwdiE07Rgz11Gdnhu8cxEbdqK7lFzjx1SYfoQaN4J65GaWZv61eb5eZ@vger.kernel.org, AJvYcCVy1fKaDnhE3I53PkZbkvPpeC0OTnHA3dr6DDmSDVMt7GMSbD21aTZIxT/Ph9gXQ6n5FXJT1jh42W4HhR5g@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkaiMfHQA4+1yZ0iltrI+NNdZB8E6m2rdTW6qZL+z7uFvgfga
	ATcGAwBDitlbjefJQb/kFCvXZ18pjUxblFrP7lxgnATwI5hi225TBZW/
X-Gm-Gg: ASbGncvkmIQfWyIgDdd8QsJIjMEiM7pmcFMc8KIjCH5AHFgwacYKgaG5scAJPDH2D/I
	dboORqRgBP5uqVcG38YOt0gZeVHHXjf0GyoTnrhWjNmN9bWJzvAibkq1HcIv3M2GEwMWWXAQRsA
	kzR4TmGKdFV97lnsCwjrXqXEMN5kKy81grF5/ycqUW6QzBGOjWzxfl+n9mqCvRgy8pTgSxQmG7z
	z/+kJ6RAzLi9e2C6/76kxIJJu7vYv5RNDDPvTleD5dbiTwzBLrpD+2fRxbuR/oOSKdUFbHey2df
	I4YDfTg/TpG2GWZUjT3uhdPGcGIzb+L+AKfYwq8FaJn6iE3Si8U7/ib9OTjokVOxiQjx6V/6Mz5
	JxHNxqVyvpUIfObZNCwMP4X3wTF+xdadCv3UHsgoEGEXdgd/lSAOU
X-Google-Smtp-Source: AGHT+IF9+DoFzLHOQRcPIJ7cBivUYyoDwWq+J13ybXKomD3r4/KZ33bHYn/W4QL4kQIHtZodp5+7Tg==
X-Received: by 2002:a05:690c:4c11:b0:719:4cff:16db with SMTP id 00721157ae682-722764f3cd0mr60887077b3.25.1756992076451;
        Thu, 04 Sep 2025 06:21:16 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8503a46sm21340297b3.46.2025.09.04.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:21:15 -0700 (PDT)
Date: Thu, 4 Sep 2025 06:21:12 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 net-next 03/17] ptp: add helpers to get the phc_index
 by of_node or dev
Message-ID: <aLmSSC90dWDfhGkL@hoboy.vegasvil.org>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
 <20250827063332.1217664-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827063332.1217664-4-wei.fang@nxp.com>

On Wed, Aug 27, 2025 at 02:33:18PM +0800, Wei Fang wrote:
> Some Ethernet controllers do not have an integrated PTP timer function.
> Instead, the PTP timer is a separated device and provides PTP hardware
> clock to the Ethernet controller to use. Therefore, the Ethernet
> controller driver needs to obtain the PTP clock's phc_index in its
> ethtool_ops::get_ts_info(). Currently, most drivers implement this in
> the following ways.
> 
> 1. The PTP device driver adds a custom API and exports it to the Ethernet
> controller driver.
> 2. The PTP device driver adds private data to its device structure. So
> the private data structure needs to be exposed to the Ethernet controller
> driver.
> 
> When registering the ptp clock, ptp_clock_register() always saves the
> ptp_clock pointer to the private data of ptp_clock::dev. Therefore, as
> long as ptp_clock::dev is obtained, the phc_index can be obtained. So
> the following generic APIs can be added to the ptp driver to obtain the
> phc_index.
> 
> 1. ptp_clock_index_by_dev(): Obtain the phc_index by the device pointer
> of the PTP device.
> 2.ptp_clock_index_by_of_node(): Obtain the phc_index by the of_node
> pointer of the PTP device.
> 
> Also, we can add another API like ptp_clock_index_by_fwnode() to get the
> phc_index by fwnode of PTP device. However, this API is not used in this
> patch set, so it is better to add it when needed.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

