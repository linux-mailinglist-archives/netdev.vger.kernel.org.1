Return-Path: <netdev+bounces-230428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B89BE7EA7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 277714E45C7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420A2DAFD8;
	Fri, 17 Oct 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BAHf8r5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88262263C91
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695023; cv=none; b=FAoYnOIoo9FkSVse148IaXvXw69zF1spiZQgpKDW6jXBk3Qk2z1IWR2lv0g0t6PvEwZESBshLE8mKrDUDeISE882l6iuBhsba/6LrGBjPeW0gfGl20t3YOmCYWbhkCbCuriVqkrZREy3B+JWZddxhizFlGjJJ9UA23mtpjfuDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695023; c=relaxed/simple;
	bh=xwkxvH1FPDvwbJfFaw1wRPhCDrLbmhSWOofttyY7r+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiCw8pvNr06Lh6A+wjUHf6W3tddUqrK1d1LY7j6e1GT9O5QQMPJrteEyMPfyK/bgENUWRnF5/jbQVnaQe/57md63vjs/5XPlkSrz5y9jMXo+IPDuF9vSQznbNDgodLa5nLyPBx2yYdkjnEBhQMuX9TNkgxTFRNH307BYojB/nCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BAHf8r5r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42568669606so1369179f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760695020; x=1761299820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjcGQpb5leVMb/C6XggUPD/+kfrKFLcG6qmnmp/+GHE=;
        b=BAHf8r5rrdAtbmmJ5i4mZuX0iZEU5vMCa1JxAlVrpOGqc4Y7yKVK7QARNchOKrkqN4
         cqEiizDpzOXvM0UfBlD7EjXtpSJ8sJ0/H+JWMQTqxVe209mYorVwNGjajs0qIXFnQX/B
         BZ345OwhlfUlSwurJvnpwowRoD31CxcHFKdiFwfP3qyzY7mRCSZ0NiVoDKnlYaP2adMk
         5KULHxddnIKlFBCWhFGCK/mJN1FVNmENGNnu27ejTVlx/PhJDURDSou0wWSIF96GcvJh
         /t10BvpxKN6uyKoggmH3RCcQHLNLtQbatN/ZBz60JCSzkAg5AWXfNglmGexNoBN8INqU
         4Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695020; x=1761299820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjcGQpb5leVMb/C6XggUPD/+kfrKFLcG6qmnmp/+GHE=;
        b=rc8q5JLaF2FgM2le4lHM5RRZX8fggHJdENQBTSa6TxMXADKn80muNLi14gqUu6B6D3
         hr8jKU4tVMBchG+s/zMwy2N/DmaE3FxyCZcqZjoNfE4HTNP+5jI7tvAAE6PEqllD5gGs
         HR8o6nM9rEBnCRGgaRPYv3ZV+29MYzcIpWHNsLgmEMuuBTH/houNU2PDDWCK+phEva3n
         XICxPooAKBFUtwmchvea2nWeW6dnIhSvc3l7lmzF1QJsTl4HKYz1UVZb9DzFrYGZlD1e
         rNuiXscMEoh0Xe6FIzKrmCO+7LlVRSebuWnw3RLDKZwhY7e078QA+btQnRRPqCiwoUCq
         1CUw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgIdqQSxBdwlu8MfwDRjRYGq05lVVh8wTXPXrRiazbkHCPrOaLlEaxSor9W7baSk14554Kwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIO0WKvC3bcPYkIl6qDCkZRrhmzEctlJU9ncYI/ls6UFT4XzaJ
	Fz5cIXsesrqIR2ch7ypkoUCD5wiVXXOTNWUFaeqLt3MX2blEInVandFhzrtojeE++pg=
X-Gm-Gg: ASbGncvSnEnZbg20+5gIqYpzqXJQWAneYyYAPgL5J4q0dN0KByfN/qDjAQK03TJkeIR
	SQGcOgt55fz2L/9rHTLgTwMaNyTzVP05yVm8sU53dYbeqvql+CgimCdgI0Syq2HKy01Jot5BUjk
	7APwNVl/rCbnIVNtmLp6IVN89bLijZ5NwCXMyHKrf3W5AFP9oAWczenTPhfQzHQHnMGjojaknSg
	f9SpXWJrvRHIWa1FhGlzDXqdBqQTmz9o2/QeoWlW0W7zWM/isMmSzEfhFct03sQES+l2/2487gX
	yyxeIKjOIL3KrDj144HqSOTL6Zxq4oe1ADXJSxYapVZhM+IFATC2Qy1syPdZ8eCKmijaUH1rDxJ
	uJIEGUzcP58KXJlYrDXaUNuIt5WRQQVq2Jspr+DOFweUAFbPaa/VlW28u3vQg8Di4yTLAtYDQS0
	49GVipZxTXrUJidbhto5rhPK57mkQNQG+h3LPb4A==
X-Google-Smtp-Source: AGHT+IEeZDP2fZLW2njiX0+fFCA2KIjPFuvYhRMWhYWRWctEosSmZW5GRuJTpVFprjQALkK02Vuvcw==
X-Received: by 2002:a05:6000:24c3:b0:3fa:ff5d:c34a with SMTP id ffacd0b85a97d-42704da9deamr2388563f8f.39.1760695019334;
        Fri, 17 Oct 2025 02:56:59 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704a929acsm5791355f8f.18.2025.10.17.02.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:56:58 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:56:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
Message-ID: <7quap7umeeksodg62bbv4ob4344edplb7f33yiebs2hvhrrdvf@wndrzz7rxi7v>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
 <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>

Fri, Oct 17, 2025 at 08:10:09AM +0200, razor@blackwall.org wrote:
>On 10/17/25 06:03, Hangbin Liu wrote:
>> Currently, there is no straightforward way to obtain the master/slave
>> relationship via netlink. Users have to retrieve all slaves through sysfs
>> to determine these relationships.
>> 
>
>How about IFLA_MASTER? Why not use that?

It's been there for a decade. Plus is, it exposes master for all
slave-master devices. Odd that you missed it.

