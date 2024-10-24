Return-Path: <netdev+bounces-138463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F39ADB27
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 06:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDF628374A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A3170826;
	Thu, 24 Oct 2024 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRJrosw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80623CB;
	Thu, 24 Oct 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745499; cv=none; b=DMAPu7G3QQJeXb5r1AN/LurWhAU3Mm/fdUJmgQ2XAiGVp2c6TZjP/CIim2vN4z6OH7SwfFcNI/glG5hrk8sjB74pQyyTTFh5MNZEtUDJlj5Hu21lLDZgviximDGUWsKc4aFiqfIjry9+Rk0Tdw7sslsGSTi9XTIJv/i3fPpm6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745499; c=relaxed/simple;
	bh=/Fy8U9zZd5rDijBEe1lG5eupn72izKbsA9PglcTncOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+wFuuFBom7+/XrQZGtxXOgpXmlIm5zli2lC9IuDW16MKbm/81TKEOYfhD4t1DFMt2iiVqfkGZ7QF5aJY7I25jp4ahWXFQza/paHP4tSjPMohaF4qmYFhVD81VUKEJINEV6/nj7/7xVAcWRFJN3EF9DyYYUD9fyGMFJ6+1YnzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRJrosw4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72041ff06a0so277771b3a.2;
        Wed, 23 Oct 2024 21:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729745497; x=1730350297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsILZh4krh0QXvX3a1dJzNvZ6BxeL6xSMOw+9+Av9C4=;
        b=cRJrosw4QlXXd5Po2qDEqxtKaElSCSu7pFXGzwW0IdKB47Ir6u8mWWciAAZ7047YzV
         LY21Nf4CRMuwBXTydx/OnLmkis2LAtuOEg+TMm1mTvM6XlJh9v0cvuyZHx9yRCBm3e91
         19e0pVAVRfP/4Xx0UXhbAs6CPHaeFSwiB/kfKNRR+5SB0X94J0H1Yx9jSHO++SWM4BDy
         XlKXp7hP/SXxDgU160RT7rBT6q8I/4tXuE2vdbkOFQymUBp2FVJdBsbC3seVZYxMcVJ8
         zSfDLrCAKQCBjV5q/3fGBD6GVsghJYVfOZHLVnsKsaju/jFN/7UCNfcZZJhNXK5HH0Z0
         d5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729745497; x=1730350297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsILZh4krh0QXvX3a1dJzNvZ6BxeL6xSMOw+9+Av9C4=;
        b=TC7LOVR9jaKuhuTn7K1brr2ZNSfmNYxAHOeYBbeVqvkMLB4t/1ZbQSwpDbhCYUr0hn
         H1gm2mrWUCB/g9bnFQfED9AakGYfz62OgHOeJteM+mSF4rgTCMSr1GyE6hltOZv02LkK
         2S8pLJW/YSsRWfrn6V/gx0UTUesNyOPEuhEMawIzsuiOwIKYWReJedPciamUVMTtdtnC
         3xPlegA5pAIkKZo8zsunWXpKEjH/HIu+sw1DXidw25LjKXVhAKIge3KL30xXo8CbhLGz
         2kQau0o3fE6aTsJ90KzTg1NkhiVoug+lgv8XQRsB64D90+NOsWBaik5y3eANEP0YWqiU
         KlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFSAFQ68zzJ4I1BvEn/WZnW4oOXexBso0GngMLYitknZ4D0cBzxplJzH97VeJ3ywhStdhN+rKg@vger.kernel.org, AJvYcCVwKIUU8uDc8ygqG8UIZz3EBNvWemdFlCvzOHsUAyC+1lvKEpMP7p095vf+4PFDjogeoKb2u3K6uHVbQMux@vger.kernel.org, AJvYcCWh4focfsqGzbf0EJnvXP+UlQgTZjtPbDeCi3FjD2+YQ2zrmRcbBr3hLv3ln+HlrZJKVOrlB4RLO4wUsvADark=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzomgL4kaNqnLvI7ios9EG3ejgmpnt1tC61Cy5lmwji3xvGeA
	Qe3u9VzLB8NpNVfsMpRg9CknTevkMPZa50nISRX94gEUFbM879o8
X-Google-Smtp-Source: AGHT+IFacVlm7olQMQ4s01LEb04I6dC0tnNHEM49WuDR0xKRj3qy5Mww3b9mejfUY3UmbFG7pUZvww==
X-Received: by 2002:a05:6a00:61c7:b0:71e:b1dc:f255 with SMTP id d2e1a72fcca58-72030babe15mr5017988b3a.9.1729745497150;
        Wed, 23 Oct 2024 21:51:37 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:c21b:c597:f9a6:3608])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132feb9sm7168856b3a.67.2024.10.23.21.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:51:36 -0700 (PDT)
Date: Wed, 23 Oct 2024 22:51:34 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: horms@kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@lunn.ch, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] [net-next] igb: Fix spelling in
 igb_main.c
Message-ID: <ZxnSVuqlXCHgeVKr@Fantasy-Ubuntu>
References: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
 <ba58bbcd-079e-42b9-8e66-52b2626936e2@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba58bbcd-079e-42b9-8e66-52b2626936e2@molgen.mpg.de>

On Wed, Oct 23, 2024 at 10:04:45AM +0200, Paul Menzel wrote:
> Dear Johnny,
> 
> 
> Thank you for your patch. I recommend to put the information, that the typos
> are only in comments, to the summary/title:
> 
> igb: Fix 2 typos in comments in igb_main.c
> 
> That way, skimming `git log --oneline` is more informative.
> 
> Am 23.10.24 um 05:21 schrieb Johnny Park:
> > Simple patch that fix spelling mistakes in igb_main.c
> 
> fix*es*, but better use imperative mood:
> 
> Fix 2 spelling mistakes in comments `igb_main.c`.
> 
Hello Paul,

I appreciate your comments, I'll address those in the new patch shortly.

Thanks,

Johnny

