Return-Path: <netdev+bounces-131806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F05398F9EA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286A7B2201C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E71CDA0F;
	Thu,  3 Oct 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6e3AyME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8F1AC89A;
	Thu,  3 Oct 2024 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994808; cv=none; b=kZja7wm58H5YrA2MpDzSeuN3vw0LELztk/tyQ7VYzZefg0DqL2+/i1h62KTyrHRLNV9zmN3deYq1CyB2cIfBukxvnwm9a8lLZ9PmG5hVg+6JFGaPPLqOiEcviB3/v6AYhvcR1xKdl28vBcxfhwngVtPhvkiS7cRUbMG6JFGzM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994808; c=relaxed/simple;
	bh=9f6ZNoNVumCAL/XMRoIt4C7FdjT9nJmVjTRImrxPJiQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h93fyBXeapFAa3JPQH+LkbGDqr9CrpscudfibObwiaRmOThZzsTvPVwg8ijzoWTP8TbkMxuPb6h9KbxlM8g9HPDNEDp76CGsjEkgxpwuJhOn7QKWBcLsPRibLJ2ut9/GdUbxdKIguLE1O7GTmE96huse/MUOffaNNmzQa6w49q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6e3AyME; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso13390345e9.2;
        Thu, 03 Oct 2024 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727994805; x=1728599605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oxMy/dAhzJddNHKFOdn1RmdxRCixdQKSPWLi6wAB35c=;
        b=m6e3AyMEoZ2i+2ddWZcqJT4QfIu+RsH6gLGNosqVUcPa8Qlv0uTBSdw6t1H21TgGQl
         cXdMi0s2pgrn0UJc9QSGafJzYkiImsgVY1wZv3CnLcpJUwvE4ZM7J2fbikF6IWWOaWbv
         roZk6Ndlml6gr9UggwbvIY2hcrGbve6LbeQ0/X5ZsDlLlKImroutlt42WCyV6m4DWAFS
         T9GuAaGcyUUvI1J0QN2xd9DWnrag1lxKMqMq/nM3bSS70P5nB2QGcLYwjrG1NPzJVtsc
         RDO46JDgdW/JwPvBFCfuOg6LF3ixScM3VZOv1dtZjY/vRRXxoHvs7LngBhyqoQmHdQ7H
         l0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994805; x=1728599605;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxMy/dAhzJddNHKFOdn1RmdxRCixdQKSPWLi6wAB35c=;
        b=w8kT96Wum/fNHky3x7PcEFHXmN6nrjTjhmfJnqah/XvIbSnTQRnPH5Gn/lcA03gQme
         kLFbWcSDR3VcOiWhPAfwdbMh9qey8nrbVBdKIEP3mPdkv7zZJOS+gVrJN6QJOrHIfSQi
         dSNXtX5t/w2y5cXWs0xotDk9BTxb//CyWMs29kvcCzIxeI9hZz2++cITREtzJG2nIJ82
         Tz25tJempc15Fd4vVPeY3PoLajefCaEWUbTSos9KY2l3fkmLpvSt0oIMG5PgQe4dBLlH
         PKIIRwSmueGKJI7Z+MrneaLVQQzL6nCxnDj3Y8ErBBubJH2Vw5TdMl4VV/zPQm09ESTn
         imkg==
X-Forwarded-Encrypted: i=1; AJvYcCUJO9IV8zvnlmt3Uo0+Tdyq1ahjIxh+WURDH1wbQv9T2a/wTEQZ3lwEaW9l3UE4r9aNrmjAgrPJ@vger.kernel.org, AJvYcCV6ilwf9jIhAMsOaW3ah7LUEuYYnEQKM4WWZcV+a3eYZFEUrJZ4wUaufPCRsCxHOOc6EF/TA1AqWpetqZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SMYZKF3ZkYGRQl5lyyk8tRbmHa7kLv5ijc4qPGAndmYvtLKi
	m0N//EpCB3gKdhuESxsfoRam+YarYhyuP/VzkPox7uPpqe7DMKoXpFg5p8Bt
X-Google-Smtp-Source: AGHT+IEjaQxIWwpaFBPl+TFPF06Iy9E54UI6p1N1Ppm1siih5wOMfTDUVgXEVVq/ol48G/5YZZ6KpA==
X-Received: by 2002:a05:600c:450f:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42f85aa3965mr3542025e9.3.1727994804556;
        Thu, 03 Oct 2024 15:33:24 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b3a646sm338105e9.46.2024.10.03.15.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:33:23 -0700 (PDT)
Message-ID: <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>
X-Google-Original-Message-ID: <Zv8brSDKmlPvlS5C@Ansuel-XPS.>
Date: Fri, 4 Oct 2024 00:33:17 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: Validate PHY LED OPs presence before
 registering
References: <20241003221250.5502-1-ansuelsmth@gmail.com>
 <20241003222400.q46szutlnxivzrup@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003222400.q46szutlnxivzrup@skbuf>

On Fri, Oct 04, 2024 at 01:24:00AM +0300, Vladimir Oltean wrote:
> On Fri, Oct 04, 2024 at 12:12:48AM +0200, Christian Marangi wrote:
> > Validate PHY LED OPs presence before registering and parsing them.
> > Defining LED nodes for a PHY driver that actually doesn't supports them
> > is wrong and should be reported.
> 
> What about the case where a PHY driver gets LED support in the future?
> Shouldn't the current kernel driver work with future device trees which
> define LEDs, and just ignore that node, rather than fail to probe?

Well this just skip leds node parse and return 0, so no fail to probe.
This just adds an error. Maybe I should use warn instead?

(The original idea was to return -EINVAL but it was suggested by Daniel
that this was too much and a print was much better)

-- 
	Ansuel

