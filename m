Return-Path: <netdev+bounces-144283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A351C9C6710
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8121F241A9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF54484D13;
	Wed, 13 Nov 2024 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="v+WPt11r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD57346F
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463510; cv=none; b=EqxiWlFOquWzpRBy/+wrP77W7LM76lOOOynbbIDtiLdZcUKhBuGQejh/6sEJGmQp9Od3/khfX+qQnQcreJZdCJ0oSjnhpheoiMx4J3Ch+QFelq0xoL63qlxXKn+9QMrD78njzGrxJkEcpaD1scCc5fnh07khQp2FuZWzDh78pBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463510; c=relaxed/simple;
	bh=cZnw/3d3PzrW45LyARayO0lNM4W6T7F7djT+bgWr9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocAYJIdmCRSUbj8Gpnmm37QvqpLhKuS0y4IRaeU0Z1nvHjC6C+/LwkxPRSul0jeiu/4mXpiEHjwdOSNHC+MD7vKvEOw8lRZH6TKvjxB9rTn1SpZJg3+Jr2vbES1cMMk4jbxjcarfkDYDIcnEXSAlNWkbywnj4PBPKHeEyxFQu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=v+WPt11r; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so4952671a91.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731463508; x=1732068308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMHgs78kJCT59kXAGyaHtemSt2oZrSdkOMKAYsOBJwg=;
        b=v+WPt11rn6f+WywNl7fcGBmz9BUQ4BjOvHs1RgyfVhq8no4RyR07DlUua0XokrWrxC
         hOYiFQICXQrzHKAJsjMoYkQ3m2dgcDGsjv9jXrpruxy9tzUTzb+czjo+gVxHnRge7krr
         4tfUUrSHvP67kiVHvwrpkYnMTBuS27QZt6lY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731463508; x=1732068308;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMHgs78kJCT59kXAGyaHtemSt2oZrSdkOMKAYsOBJwg=;
        b=jGXn/YDQBztXzwZTwyomCjbF7MPQtLyHFWooIKvl5GFdd6mfuV1gDjRYuy/cm1hPT+
         IY+25eJJoGpMO9P1X3lkHphtxema0MBUO1h+MpTkw18ZQd0v4nMDt7AJ9KG7eT3D/ZDP
         D1CfG5Md7yUhLa1pMgTlnek9BqNC/sVG6523A1zMGaugDXvCqQJF+lhhfEGP85tfQm9q
         p4XwgB01vegr29J6QBuvDrySUlu3usZr2spYA37kBOPK6xBXzFMTTOUMG+FW25nY2l8W
         6gCCe8cqgpkFaSHMZofJovgLbe/3tAA4Pmwoj3zC5IxrhuunAskJZYMGlLUa6aAAFbLd
         WdpA==
X-Gm-Message-State: AOJu0YxmyYa6XojTB9te038a3vxNBoP3BteXCNLZ/sbrQG2z7H0DszPV
	rhI0D2eLXl/c9TMPR0Rxe1vXl9A/7a6gCrH9yJNqUmqF64R7ZL3DDZjcGIBClZQ=
X-Google-Smtp-Source: AGHT+IE3BGRjmhR0ZvvRxux2FPKe4+dk1Cle8rzXMHK76AdSLTy/P4WM0poxY1ZTUsslRuA+89mD9Q==
X-Received: by 2002:a17:90b:1d11:b0:2e3:171e:3b8c with SMTP id 98e67ed59e1d1-2e9e4c73c42mr6334898a91.25.1731463508401;
        Tue, 12 Nov 2024 18:05:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3eca101sm275665a91.14.2024.11.12.18.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:05:07 -0800 (PST)
Date: Tue, 12 Nov 2024 18:05:05 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	mkarsten@uwaterloo.ca, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Message-ID: <ZzQJUdjWDGqbm2QQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241112181401.9689-1-jdamato@fastly.com>
 <20241112181401.9689-2-jdamato@fastly.com>
 <20241112172840.0cf9731f@kernel.org>
 <ZzQFeivicJPnxzzx@LQ3V64L9R2>
 <20241112180102.465dd909@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112180102.465dd909@kernel.org>

On Tue, Nov 12, 2024 at 06:01:02PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Nov 2024 17:48:42 -0800 Joe Damato wrote:
> > Sorry for the noob question: should I break it up into two patches
> > with one CCing stable and the other not like I did for this RFC?
> > 
> > Patch 1 definitely "feels" like a fixes + CC stable
> > Patch 2 could be either net-next or a net + "fixes" without stable?
> 
> Oh, sorry, I didn't comment on that because that part is correct.
> The split is great, will make backporting easier.

OK, cool, that's what I figured. Thanks for the guidance; will
repost shortly.

