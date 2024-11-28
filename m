Return-Path: <netdev+bounces-147756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03779DB97B
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F521633EF
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A219DF8D;
	Thu, 28 Nov 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOOWhb1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B3192D77
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803595; cv=none; b=syrnjGeJehkF5plPfs2kFvTNFhTDJfFoUgJ/KY3Yhg2TSKtJw3B58MeMEVD89ryNcCKGEOkQ/kvf38hEAmB5/DrDqNcMcLFoPJUO8YdKPzu5Gxv0oZ9O3BZdw2ku4IQt4MTXlnvU/HTsCJty55B+H4Tw7iJxhMbzAQQhdPkBu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803595; c=relaxed/simple;
	bh=4W6gCZFY/82ZQXBqs9K852OeD5BJJ8IaJURLXn4GIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz/15TZLsoeof2xNqy3sXblOAli2M4T3kWVo3/WUOBgVgmThUy93g3mF8zvNevkgKA7WJDRx//klsZRbnbwNXLb67v/AvMYRLaoFa/3tHQzChU1+FMH8AcHcBbi8ReP2JaT4FuIYvhOPnEDvyckbZyHvZhXxFLCJe40tUSOmuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOOWhb1G; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38232016b5cso33516f8f.3
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 06:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732803592; x=1733408392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4pwAEpMnv7cDMQ4E1BARu2yxtGbY5SKGrpYcaptcic=;
        b=hOOWhb1Gg6YPXNZE4HFO5MC+hNp9uOO+VXgQqd8fd4G/q9jahNTIf0ocHmtPpVwLYk
         p9TmCUPRCN+c8e736NFCsowbs3fPPS+/hmQXWKMFGIvCoOGNpBKZaVDdhP6VevIy8GdU
         wRCeTz2lbBg/agx3nbnUcr615WnrwYbQYNnB3mMlRTcS0sHZyZXINCiiDLGkMJAtyJAU
         kPxg6RiTm4GD1Tsd5/3QGqz+4JSDskYm/9smrFSXLSuaTKdeB18kNIun9iA6He3LGaId
         gzJFZ9YFP9XEGdaZ9jlsg1P7sqkUFdB5ynKHd36hiFhn+hVlfqvaQejxKxeKsIikdQmU
         nM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803592; x=1733408392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4pwAEpMnv7cDMQ4E1BARu2yxtGbY5SKGrpYcaptcic=;
        b=mjhLjxnuRPNyFNu5kYuVZB8pjDEsSaN1ctB0z/AQpF95crRlGk5uEoM285/+hAt0SP
         P0J501RuRs2m+0Ih9mul5cpCUlogACwaxJvGncqzNK7qxvR6qz+3n41xX0ShYq7nFU7k
         XHBdbAIsEpwzVkv/tzvmoy48m8atpCIfA9kHdLxc01n8oXtDy+Uho6IAy3Cw6eyAJ/H3
         uFvHbr/KjygVD8FpEpb3V6f/pL/wUPP4bQ6A1lO8vj0EBr7qpqVkTH8YdNtd5Ub6Otlt
         RqhUYU3jQe1ZhZ/8Kiuu6/Oylt5I4QfMvcZYFNEhk49FGFBtc/rTHTPrwKlQWYvXz0OZ
         ps1Q==
X-Gm-Message-State: AOJu0YynkGiZ6e00uWgV15HyMo9r6aXZsG5q21SLOvCZnDjS1CAaiec+
	WMxl+GfE0ci0uWtfw/zWCx+qH2vqdzXX5Db3biZFDkCa92COXPxJ3UVO/3up
X-Gm-Gg: ASbGnctl3MJXJmBTf0qaJluN6rB0bEq8ZfcNv6gxvNHSmkvMisjRVsobGoqjzQNJJ9z
	HOH930CvGXp0JreKGtva98HF/39kxaGpfzGs1Vyoi99bk/zifb1anIIKKLN80JVrVJJ8mabiGcu
	VBywlBbXUBlXKRwJ9s20ax71ctP1+AcvuFRO2XRFtMsqMxdwnXA8eTFLwNmUrw2/DDhZd1PJwWk
	bZLP0PSAxwDvdQ21w0xstPTecuFQo2lDjNxWCQ=
X-Google-Smtp-Source: AGHT+IHu0olp2DqmLqhy1poICvCf3dc/GdfNTQ3bfGd3+TEIsQritVcVNfYUz60kiAsE7j/Jv3kwoQ==
X-Received: by 2002:a05:6000:1fa3:b0:382:40ad:44b3 with SMTP id ffacd0b85a97d-385c6edaf4fmr2037017f8f.12.1732803592093;
        Thu, 28 Nov 2024 06:19:52 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7fd2dsm1715288f8f.93.2024.11.28.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:19:51 -0800 (PST)
Date: Thu, 28 Nov 2024 16:19:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jesse Van Gavere <jesse.vangavere@scioteq.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"woojung.huh@microchip.com" <woojung.huh@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: DSA to switchdev (TI CPSW) ethernet ports
Message-ID: <20241128141948.orylugaetrga2bdb@skbuf>
References: <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
 <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>
 <PASP264MB5297F50F5E2118BBFEA191CAFC292@PASP264MB5297.FRAP264.PROD.OUTLOOK.COM>

On Thu, Nov 28, 2024 at 02:01:23PM +0000, Jesse Van Gavere wrote:
> Hello,
> 
> I have a question in regards to connecting switchdev ports (TI AM62 CPSW in my case) to a switch configured in the DSA framework.
> My setup is two KSZ9896Cs connected, one to each port of the AM62x.
> Using something like cpsw_port1/2 as the ethernet for the conduit port fails I presume in of_find_net_device_by_node(ethernet) as both eth seem to be under cpsw3g which is the actual ethernet.
> 
> So when changing the ethernet for the conduit port to cpsw3g I can actually get switch working, and I see it registers under eth0 of the ethernet, however when the second switch tries to come up it fails because it tries to register a dsa folder under eth0 again.
> 
> I'm kind of at a loss what the correct solution here would be, or if this is currently even supported to connect e.g. a cpsw port to a conduit port, if that would not be the case, what is the suggested work I'd best be doing to actually get this working?
> 
> Kind regards,
> Jesse Van Gavere

Having ethernet = <&cpsw_port1> or ethernet = <&cpsw_port2> is what
should have worked. What is the actual failure?

What do you mean "cpsw3g (...) is the actual ethernet"? How many netdevs
does cpsw3g register? 2 (for the ports) or 3?

Your setup should not be a problem in general, the switchdev model is
compatible with usage as a DSA conduit. Could you print with %pOF what
is the ndev->dev.of_node of the 2 cpsw ports?

