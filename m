Return-Path: <netdev+bounces-103190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29849906C82
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2161C21821
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF651448E4;
	Thu, 13 Jun 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NizoJd68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DC143C7B;
	Thu, 13 Jun 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279318; cv=none; b=MYhD088AhlpW0AEDGSdRvYza3CxNxZgbDtjruayUGvS3F0C2MHSDK242z7YOGT2BfGyati9vMJeAGciM1FPanbwSl1H2ourPsp2xWsPC46SbBidm+VEVl7lqVgn5ZvVLormWX3eUNLc+YSKUsHr8vkODqcvn5PRGzy5vrdzWY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279318; c=relaxed/simple;
	bh=Xvnfi2/UG9VRYAOcBoINScUhd6jaTRoOR9x6O3p1U70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4cxG/XbC4TtxM+3dWEZpaLCLyT5wmj2oJYvlpZW7rpAYDfxwp6S/vlGDk9zTNvDH+5H3owb0wB91IFr7Hz+bK3YnomVjzLaKV2x7xbZQnOGK2n8Ze+1zrKWYXs0CFCtQSzKhyx5KIYt+oQwb6e+XYqbaVgzCSB5qJnKLyi2kKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NizoJd68; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so1169158a12.3;
        Thu, 13 Jun 2024 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279315; x=1718884115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcakns7F7/iGFpeQizqpWzcHlOatf4TUkVmNTN3Ld14=;
        b=NizoJd68wnJikzSI/000+VUBeRDqOAIw8VzdFui4qFsTOXbQk/WC/NwIh9a7aeBjZl
         OKzJhcEuCt4whkPGbINC1kRwF9C5JTOgm7q9lTaz6PPDAWREVVmcvcV5dwRvGmNPO0BP
         rkcp9WC8RPzDrwD8bt+fIhv0rdalVkaqyx/rwAGPcjZloVV0/GnP1N3RXjMt77RKdsG1
         Eyg9O+SuWZAQo0JKAaWFtLxueSJn972c8fcRQJj5YmH1JG7dDQ6RSJA4M/Z+eARffOA6
         Fm1n2A7cInxPvXc935sL8rNm2aaFMNy/tctL1S30WYGvlOj6TxI9dVMCCkJQ19+lMDfq
         JypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279315; x=1718884115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcakns7F7/iGFpeQizqpWzcHlOatf4TUkVmNTN3Ld14=;
        b=NWvKmDBLEN5fBX0x0ERuMzmlTS3azwhEbc0oe15wYwWKkK4GOUu70fxWxPxfDIWyUZ
         Klqnwfb743jHVHHh/RrUU+zGZZvrJQENIDVI+8l2Tu0mSYfgumnSjLbpzmwpXtYZX0dZ
         Yed98bQgXUjD9vCThf9/P0rilMuQZ34jw6iQQXvSvf7QIUf4if+pAZi9BlprIB+NF9a9
         UH/z6Lt+YT1a4vhkODAj1cD2vE4wpSSDoutVprGkBSotjYd7/zq7HoXyxXKz90yQSFM1
         UsnOA1PLqxuisYyxZKD6XphWmKFidko4P9crfSM0VuP2IuFkhRzRo9Qbdyyenv2rRzyk
         Kaow==
X-Forwarded-Encrypted: i=1; AJvYcCWGOq1GOmFojPWM3fshtFsa4fKNw4a5jMA2+vZ7lGtTCBln5kIjqz9ulLWNo3e3s8WT9yVFY0NBgeJLsliHHeRoKNXfKmWrNK7Ewc+osalLATbrGu7HUeEsYZbAadZT0VmMt1hH0OCNncCbDXb9Q1qlBteUC5lIsV768nngvxieVQ==
X-Gm-Message-State: AOJu0YwV8UzEp8THSibHDpNcYCWa9EbPgw4MJV7W3lrPmMXwuG0NAoFI
	lFSJqutIcK1wOcFY87aiV+Tx+cW7zh/nUAb2AEG0pdSBZQntb5k8
X-Google-Smtp-Source: AGHT+IGlRwitn465eENiEeTq6LL6l3/QBU/x0u7UFX8FqlGKV83UbhFiOxb5+JfDp5NNSE9IOweyJw==
X-Received: by 2002:a50:d4d7:0:b0:57c:5fd7:ff50 with SMTP id 4fb4d7f45d1cf-57caaac66e0mr3746828a12.35.1718279315024;
        Thu, 13 Jun 2024 04:48:35 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9943sm821018a12.51.2024.06.13.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:48:34 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:48:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/12] net: dsa: lantiq_gswip: Improve error
 message in gswip_port_fdb()
Message-ID: <20240613114832.23pvevg6wmyczr7i@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-13-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-13-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:34PM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Print that no FID is found for bridge %s instead of the incorrect
> message that the port is not part of a bridge.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

This needs your Signed-off-by tag as well. Anyway, if there is no other
reason to resend, maybe you can post it here as a reply and the
maintainers can pick it up while applying.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

