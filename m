Return-Path: <netdev+bounces-226208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3CB9E123
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4734C3973
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211027467B;
	Thu, 25 Sep 2025 08:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D7271475
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789301; cv=none; b=BhHrAskq6neAfrg4loKAJp6723izWYVp80nHELFYKopUIlfha1kllqEvFMfe752Reke+MRIAFlb7jg55/TRzNiIFM1cTbnFoVV+IhsSipUPv15ze4dyidnCnkoYVC6olRd166Rlv04f1yX+dySnjL+AcRAFFnarAG37PhfLKvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789301; c=relaxed/simple;
	bh=DJ1q9Crp31KPzDvdOQpVBt7D29LMFTTduJ+18kfO72k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUonjrKeqwLYiefb4pqA90DjsNjaPFRXtrEJDDOv+/k7DZii5aXZ0FHlRKfgKdp8XmeN1x4jjLhEBHGfC7oWl+k2fIbXaDjUI40AdZ6B393E8X6EAoh6N+yWjVBDGGc//jK0EWLzeHEBDLeNmdyg1GhNku2twk8F3V5/qV58VJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso1431237a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789298; x=1759394098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zDaJVs41LQUBnbqHVLMQ3tXnbakB9l6TXCCNtHO7SU=;
        b=OTCI4WO+7VFHyBYQ1Go5xDb8aDyCxQtztLFGZ77NH3v0OlfoZFhxOpD5+DPenG/rpQ
         19bvzl3q69L+Y9hqxqMF2IpYDupeQSYE1ozppc8vEoKkCdgEDXcFX2epzCIIS3t2ldY4
         +fgs+yR14XaK777y4R0v3nUDtvAJsMkHBpkC18CDv0AsSMb2X+kRX8eZN1LW/acvjRkj
         zqlM8n6i+KcCfh5n6O4nMhcelcq3N/A5LAcx5iRMbc60HXCMwGLLdEuzU7F7/yEhza7H
         XLnQ4DeP55GRYLqfWshn4BYNzpoiAkd0gyuiQWgqB3gz/w+kqYFCXmbXpJr0cAYycgg3
         SqwA==
X-Forwarded-Encrypted: i=1; AJvYcCVobRzuceNuzC3QmdHlnET2fgnzwVqT1fdu774vEi4/KH8UWmN6A7UmtARpz9amIGbLUYxCQd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDQxZfNRwPt2DtnWvVURG9xd3MbfjzgG9H9oGjZJxpngbyB1f
	+9MxfzrZOOk8PAvpRPZdFqdUzoX8Aysi8uDog0SbOm5WGfWS/ieWNPts
X-Gm-Gg: ASbGnctlkBWomzDs6nhc28C1leHQqinq3cm5N59UQVnmzTQ0ceiQZjOEa6qpF90n09L
	zU6FkT+7TejXZii8X4ghhfJ0lMx7s0unTAfzH+N+GFDzBQGDRl3wF7nuZyNujWRTY4ci/77vERj
	600btc65kFPa9eFCAInw6cUXTlA8LvY98D1WpCcZZwpcs94e5kfmZiCycum0Lvtvr99ntbgeekj
	X3W6e99l3ZA7yLYT4ophCQcF3L6yjlV7utFreVKJcgR0h1fHzRlszSwqTtWW6y90wYLHHw8L+oc
	9Xry/8I1bhbdiXTbwmaZriPxM9XpAvHkgT13OJtfLI10QxOSTPpbUa2d5Zz55kFLDF/Ib+fkLuB
	mMLCJe+DniA0hFupx7Idn6QQ=
X-Google-Smtp-Source: AGHT+IFW24W7o3bTWAsFoY4rllK5I1ic/HQWQVPhMEjT8+gukUVi5DmlXH9g2CZqkSx3goPwUOEnOA==
X-Received: by 2002:a17:907:7f05:b0:b2f:faf6:dfad with SMTP id a640c23a62f3a-b34bc8766d0mr287556366b.48.1758789297677;
        Thu, 25 Sep 2025 01:34:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35448dfee7sm116570966b.63.2025.09.25.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 01:34:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 01:34:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <iyeqx4bkzk7pha5neslqkey55ptjcrhn7sgairdpmzlf363b7q@ai474sr27tq3>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
 <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
 <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>

On Wed, Sep 24, 2025 at 11:26:58PM +0100, Andre Carvalho wrote:
> Hi Breno,
> 
> On Wed, Sep 24, 2025 at 01:26:16AM -0700, Breno Leitao wrote:
> > The other option is to always populate the mac during netpoll setup and
> > then always resume based on mac. This seems a more precise resume.
> >
> > In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
> > populated, and you only compare it to check if you want to resume it.
> 
> This sounds good to me. I've done some initial testing patching __netpoll_setup
> to always set np->dev_mac, changing maybe_resume_target to simply compare the
> mac as you suggested and seems like this approach works. 

Thanks. You probably want to clean the dev_mac once the is disabled for
such case. in other words, if user configured a target to be dev_name
bound, dev_mac might be NULL once the interface got disbled.

So, if user disable the interface, it should unbound from the mac. In
case the user re-enable it later, it needs to bind by dev_name instead
of dev_mac.

