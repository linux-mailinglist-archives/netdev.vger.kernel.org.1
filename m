Return-Path: <netdev+bounces-228706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287EBD2A3F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F04A4EC915
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43198302746;
	Mon, 13 Oct 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edJ2DNSy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B183043C4
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352654; cv=none; b=aRQUVsZVpoWrKgXeBJdEO7K9fomKNeIZLk8hjVPqb6JCgeJaiuaWJF74vSRA+xP5qmcjbSW4+LdtMqcZaIePxHQXUh0O3GtUgnsVsOGv9GM43l+3ATdrB9R5cFOeHu4L9p972VByPUIT7v432htZs+A5NhGVzQr8w/HrORKnBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352654; c=relaxed/simple;
	bh=wNP5THpXLBBCsooeBbFGaCM7Hjs85FFamh1ekejynLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWDqUOHsMJGiqoFddBghGxgPOZP6VW7SG2Hh/Wgalxbb1JWDKKwm81MfTVqL2kO+YdsO9VXFux5OP90L4LFfHxPzzvcmOdoSPyQWWwBIbXpEus4iK5iodkjxmxVRlF0kB7WtkeVeAj8HizpEDtL27VNy17GbyalJ6axhctRNTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edJ2DNSy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so8485533a12.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760352648; x=1760957448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywHY3N/RI9LLiDCgfHoL3E6H1b5BrPsw9rGztJzIzfc=;
        b=edJ2DNSya4n3LkBzMaSlhQLuNmQdeuRa6EsBik6tCyiqMkpkIO9+QC0uSwxcS6TT5l
         NhTmBm1t+TmFdBtG9jlk4ojBAPzpMewBQHXFOY4AJnJBMajkku1lsbiARphZIMiRBghv
         Kdi6NRC2mYNCG/VKsyavb0a9rNpc5VsKj0BS9KcDA5Ug9//zv8r6GHR4wnIT8GjSGjPL
         aGeAXx3gP74r3Zw/uV23sb9YYPQAT5LqbMbtPmvdZJhIefaWS9m4MG8lpvJL1BNOPoqa
         aZE7CY7ztdEc8FSBIFkePH1xuNO5tJ+aPt9LvsXpZ9YPwJRSuTOh+7c0XfSxY5cKcj29
         dGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352648; x=1760957448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywHY3N/RI9LLiDCgfHoL3E6H1b5BrPsw9rGztJzIzfc=;
        b=CI8FycXWsyvBRo/ZjBXf7s1bEMPv+qb5Iouvtet+NmGNdrSkkigStWgHqI942H92jw
         e1XPwdEbQYLXewD7lg6pcgZTbLd9OyZ/qfJw4xbzR+ESWYr+sp3IMr3cbZeGVMge1H23
         0WkybeUugIsU7+rXeNf+cod/4J+7Dx5NFsud6wsD6HtbAD4VbEAGgzyIB+/addGyyC8u
         Ndj4dbTNqhVnod1OqNjet6WiOlwRRo0bVUmBT5dYPpt5EvWVLGi2TR63/8hHOV8K8y/T
         MWqBRGQT9C6u8wBrDbjgW9IoMmfoQ503bikOYf5bHk02qbQwEgPztGHN9VTLkWFZi4A+
         2qyg==
X-Forwarded-Encrypted: i=1; AJvYcCUsPE5loqFDI4WtwkLzwDkkuWGBtMdahio3h2ER2ifryVrL/O23IG4Q8NIi79exKeI6fnio6Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCoWekPv14WfSZSqalfqn0xy/7Hctt58gTLRtaF2tT3otKbjK
	fZZzVLcxlOqCfe13UdFR5lBH5GzeG5nViJsXtQkputM33NtsrctZv+2d
X-Gm-Gg: ASbGncuX8Wss7WcAkgmKCYZuWWxArS8MfmT1T+91Eb58WyJGem+JU5OnVliK0Ux0vWZ
	FYUttwCm+KWmC7HoVhM524mNKFFUNnBI3zHmCXQysQNa/xT1iL/gdWD1t205GX/Ihnukeh5V8H/
	LrWkh1Z8JkxKMia69zTmvzm9DIMchWLczGBLp/YkxhlX8Nn2Ji0Uqk1MpLAvSDtk49CvBfXw358
	K+l7ywNFuEXnCLl84rHDab7uwR/eXf1Thjp7AN23iYa+Q7PBSwG+uXYMYHhGN00108+lt28iE3a
	UwAxOn4Ok9HXFEzqlUp59eer3lqXfdWtOBEy1CuyWtD8Mwt7T587vajciwxiB08Vau+3I3o1lzo
	2lGC03RQIPwUmrdYY3ZRe7/8qf1lq1owqV2EGtD58MYgzLqrE+UOailhMRO+EqL4J
X-Google-Smtp-Source: AGHT+IEr2IkhLy3Hq74fdNOtudRrfh+iuu7rWrRfFvpPJo3KF6R4emQcUvwa9LHRg8/IJ9TOsz5Fig==
X-Received: by 2002:a05:6402:144b:b0:63a:38e:1dd5 with SMTP id 4fb4d7f45d1cf-63a038e4b6fmr12861262a12.7.1760352647388;
        Mon, 13 Oct 2025 03:50:47 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63b616d12fesm8024557a12.24.2025.10.13.03.50.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Oct 2025 03:50:47 -0700 (PDT)
Date: Mon, 13 Oct 2025 12:50:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: rtl8150: Fix frame padding
Message-ID: <20251013125043.0ae574e7.michal.pecio@gmail.com>
In-Reply-To: <aOzNH0OQZYJYS1IT@horms.kernel.org>
References: <20251012220042.4ca776b1.michal.pecio@gmail.com>
	<aOzNH0OQZYJYS1IT@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 10:57:51 +0100, Simon Horman wrote:
> Hi Michal,
> 
> I think this should also increment a dropped counter.
> As this driver already uses dev->netdev->stats [*]
> I think that would be:
> 
> 		dev->netdev->stats.tx_dropped++;
>
> [*] I specifically mention this, for the record because,
>     new users are discouraged. But this driver is an existing user
>     so I think we are ok.

Thanks, makes sense, will do.

I will only drop "dev->" because it's superfluous - we already have
'netdev' here, which was used to obtain 'dev' in the first place.

