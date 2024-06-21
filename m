Return-Path: <netdev+bounces-105727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F989127EB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F2E1C23AD7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFCF208D6;
	Fri, 21 Jun 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpW8IWs5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DB2031D;
	Fri, 21 Jun 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980445; cv=none; b=F4shUePw43CVBfpu1rbmUUgbO33Y+H00IA9rNXkPHBoFUD0TUdr9JG/rE2gl5m7wQUYHNs2w9wOZga8G4VrUUYVegxYr3xhCMKC6pafQbRFc35Q2Ar5NaSl7B9Jt8Crak+9XC8v/X1W1NqOM0KZ5f73DYSSjci7LVakbxFw+lsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980445; c=relaxed/simple;
	bh=FtiCuj6pDJKH+Oap7h66KpuewodSlnCT7gUM3HMKUug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObYGb2iQvT1Za4Ve1Z3h375upKbOn00e76DDCzI1FH7w/G4Uf/CX/KKuA5IKEWLMKFj1xJpyzbXftB/zr/crrnhVR/p1H8CGPmFG8YGLZYzqu6ALawZNjIVvGB3CBTxCKPAnKXMifbQvTmdNAPg77TLM9THjPm21Ve/H7JBXnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpW8IWs5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424720e73e1so17812175e9.1;
        Fri, 21 Jun 2024 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718980442; x=1719585242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg1JPojWu082xle04lVi+u3zC3t5IxXB6T+sBDaAiaA=;
        b=EpW8IWs54EXGXorKyIFV+NBTNCWpylWFiL99uiRc/um1buWJafjzkmC4q/V6zIQNZi
         SK2roFHsbVMSo8OTQ2HekeFvQ4hcuEHdJWNbazLXIffYSdlVYnJ6m5hjsGbLrVDat0lB
         nc3bC0LVDE6CL7nP99/Dkz1tXFrrA54EF1b6GdRMcnVTLyprfzIhHUayCfgH46nTCqJR
         g/6hE9aN5EOAsepjDzd3cn8TKIUN8cPOXHj+nHlXqwGVsKqQCdaNpY7oI7/Irb6qiesJ
         GBt8OAfbYoMFi8tqID/km6ibaCVgBFik9NgjUH9YXFiVaQvu+pIZDskUcOT8HCAvTS2d
         YEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980442; x=1719585242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg1JPojWu082xle04lVi+u3zC3t5IxXB6T+sBDaAiaA=;
        b=gE8jBl7bZzml2A/g9o+SKwafolKU1w99iHiC/m5JYGs/xw3vBmgFvZQCtULVhpXQ+v
         rHq03pWv4nrnmy3XJNf8p1LUTQ5Djl7KkCr9SucN5j+AiqCXcy0XAqTJQUrSYVCnwsLb
         tIzbp8wzBt4FgeUSD8Hv17ZpNfTmQcsfBDZwmgUiOVIH9bVnP+uoXK9nvfK0WNsZN8aB
         YzGp4ED6VktudCI16ILQaAcrl2JOG+MkwS5BzrzpPhvabi9mSX0IKZd5WcK4oMQxAqcU
         rHbR3+jyZ6W1z2lak73+n3g/ftDINXFTtq701+AJyDDeAhCen4aYeuvskXUoDfamenil
         X09g==
X-Forwarded-Encrypted: i=1; AJvYcCXVNASgS7rkK73wz+tgQHOtVJPnoCHjDRvSjMjuhK1SRaS0plG9x/NGawHQrhdPJsSfpmYH4RWnq1jWY/7SbstihpAASt2c48ekfoK5
X-Gm-Message-State: AOJu0Yw0tsWC49Vs/opWUgJMiCJFyRRiZMIJ12n777kmWFqiED6r79Xh
	HnK69WQ8yYgvaGWoLZrob7R6ksEFo9labA39TTMw69gRjczawouq
X-Google-Smtp-Source: AGHT+IGYx/x8wmcY2xY1ew6VsqFHxwOl0uye/xl53usaynBczXIUWCvN0TW5OrcMPhpZAWKnpboHwg==
X-Received: by 2002:a05:600c:4999:b0:423:499:a1e6 with SMTP id 5b1f17b1804b1-424752968c3mr60468825e9.29.1718980441540;
        Fri, 21 Jun 2024 07:34:01 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d3basm32870045e9.4.2024.06.21.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:34:01 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:33:58 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/12] net: dsa: tag_sja1105: prefer precise
 source port info on SJA1110 too
Message-ID: <20240621143358.gyqnoqkr6n2rdx6t@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-6-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-6-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:11PM +0200, Pawel Dembicki wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Now that dsa_8021q_rcv() handles better the case where we don't
> overwrite the precise source information if it comes from an external
> (non-tag_8021q) source, we can now unify the call sequence between
> sja1105_rcv() and sja1110_rcv().
> 
> This is a preparatory change for creating a higher-level wrapper for the
> entire sequence which will live in tag_8021q.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

