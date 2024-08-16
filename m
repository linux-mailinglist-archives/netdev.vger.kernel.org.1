Return-Path: <netdev+bounces-119134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6684954494
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C5D1C20EFE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07313A25F;
	Fri, 16 Aug 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQhm20SM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAA12E1CA
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797337; cv=none; b=E9h9xsB8fqaCoe+jQotNmmXLNnNlun+9cyCLXqDoQ046b/TxdJqTxtwQQheFIhZCMzXyXKtqeHV6p+1OrxsvPJcafnOWUewhZw2GfNrv3KZ0wn/1LDkn+zAktXZzMrXcR5g9rAk80+TkItyudnwJ/mu3b9TeodmfASoZfvYyuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797337; c=relaxed/simple;
	bh=rBWF2VaqjpyqoM8JqIvMwk7LItVsS1lcc+rioJaQ9U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlGSCiP7GD9jxmkzGYUX8yPr406us/tlTdYPo5GNrvqdSoWtwWdCFXf5/q7zXnJjDlawSxxTbbZo7CxsJuehcLVvqj4cWW31Nv1WXrKg/DeMBUjv0RAA7JDucG5iF51UkxKdvj0KzSyBpbcrwIFKIpx2+C93lTq1dNSWixxBwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQhm20SM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1c655141so1204795b3a.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723797335; x=1724402135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBWF2VaqjpyqoM8JqIvMwk7LItVsS1lcc+rioJaQ9U8=;
        b=mQhm20SM9aXcG4Fylg+ASkrTe24X1LQsGckC5JUamJHrsrF1iCIDvliKG0rtrYBK7j
         TSqePNr+p7/oc2FlqTru/peCy9AaYfjDv7ADJRlgRcEd9Coi1CWIeORklPJT4U9/yKU6
         YS5JClwOxpB8e8sin7VrJ10ZB329QHZ7amYwM+sro797DkOw8LlXWYhUK9zVwg6/CmvF
         8LDbss+QKTffkSbXD1g3aOniGTada/bY/11DbXJJuLDst+MxFbFz8P6Rj7vRrc2n5vgl
         o3Rwb32xcYSgkvjjYnqeoq+AuBTa5CKEP7qXDF7d5F/y1BOVF1I2YOZey1iySMmdHEjJ
         RdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797335; x=1724402135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBWF2VaqjpyqoM8JqIvMwk7LItVsS1lcc+rioJaQ9U8=;
        b=LODbueWprw1A4ZKVomc96qkvqwps0b0hlPxAtX96bonxgBKM6JnQMzvKRIwn6/S7RH
         IlNuimJQmwoGzP3jVpjWS9bpEDLLRwyipt5U3jZ3wK/+H5WVxpvMSJRIY2ONuEidowAl
         9OSweqf042tUrLI6uAdRKW/ea4j9OCFum8DFW9EXPFo5ZGQ2+PMa/WToLyhM31JLiNkO
         NbGlT67Oiot1y7yC3xC2eCcrCHL+dD1kUsnzXqVuyLSFb9lesCuzMCkCNTj8bM+RP4um
         7xejp7Q8o85zm8N4Y9CQXPcxYNd+lI1S7Sd9MLXPtA2lneJVf3y2tw+OLG2qNdXd7QWV
         z5ig==
X-Gm-Message-State: AOJu0Yw5RXT1VpLIe1e8mZYU5IKNt4qdTTqV7RUi1eESx7SbdhJ/ae4m
	sewmm9o/D4xaC7rh3elsbT4ADsQYoMr3HoSPK20g1VilZmK/mfW0
X-Google-Smtp-Source: AGHT+IGcuZjnUm0j9gHLAmh7RKWvyEBe+lxTaTH3pmmPS/GSU/RYiStf37O6fCMHTJeZyT9ceVADnw==
X-Received: by 2002:a05:6a00:cd3:b0:70e:a524:6490 with SMTP id d2e1a72fcca58-713c4df2617mr2386403b3a.1.1723797335484;
        Fri, 16 Aug 2024 01:35:35 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add7322sm2181014b3a.25.2024.08.16.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:35:35 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:35:29 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
Message-ID: <Zr8PUTUWY3rh15Ik@Laptop-X1>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
 <ab09bdf3-e67b-4548-87a9-acf9a08806c6@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab09bdf3-e67b-4548-87a9-acf9a08806c6@blackwall.org>

On Fri, Aug 16, 2024 at 09:00:17AM +0300, Nikolay Aleksandrov wrote:
> the set looks good to me, one minor cosmetic nit is that the two
> functions look very much alike only difference is the actual call
> can you maybe factor out the boilerplate?

Thanks, I will update the patch to use a common function for the checking.

Hangbin

