Return-Path: <netdev+bounces-111869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE526933C7C
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB97280A8F
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693113CFBC;
	Wed, 17 Jul 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhY7t6Ht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9E41C63
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216792; cv=none; b=MFl9zk+uejIXLhaeVA9zCutBgmdouzDRLO1nXkCVIPDk7WlXCt16dHsf/BhtgGxEqne8VkvmYI6q5Px+I2EI66SrUHpNdqMwg3k+GCJRH8YJBP++H3SgndFoI7vDOdFgBGr6NOMd3qrL/eT1TejVdB//zRja4ffZkQLJzqekXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216792; c=relaxed/simple;
	bh=cmhkHrgf9T05c8QlpiGRYsf63JwWVcSgU6xbAq9R8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seMbL/6pvdvHe2cT+wF1mnd/2jc9q0QuK+LM1jy2tlGPqJ8e0IGsDQVd+eBqVDpuZs328l3qNSnMIA86Z1RsFc10+o1fL2gFoSjkwjAsbxNMq9YV7Nh1uoaL8Sv0v0FzPtsTvnqtFzexWXPpEbo4odbGzIuN+5wZOJ6LvxZDdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhY7t6Ht; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368255de9ebso419209f8f.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721216789; x=1721821589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3buyDdDhXJ0KAV5UPawfn4m6EPwQxEGECL/knta0nBA=;
        b=lhY7t6HtCNUnoyjE4bVYrw3feH3BwWiHjwvmvCsGxwc04A+NszTSkteDmEQ5g00xLB
         pf9Wtb1E3H5ZKY92h33WmG8LtVfB73tQLCOoMP1my+m/UGKKdVO+RC5Kk6Ws8tt2aU2L
         9onxBV/KKMqn4U8Ai7qwB/kOCEA5HdVMEemuY3vqX2WEu3tITutGBYQXg9gFL9OJdNiO
         GQ3pXFsEpzJ+jPG98LPxQ2J28Ui1/GrObtJVrKgpmB1frCsbJkgPbSfYq9xwy9JIPu+B
         p/gwnyOg+zVvq+Udx0fus10yV/TYQTKSNWHputZxt91phYmbqVvosG1Lh+9yzYC+f71G
         Bu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721216789; x=1721821589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3buyDdDhXJ0KAV5UPawfn4m6EPwQxEGECL/knta0nBA=;
        b=YSATPZl6qD4PoqhzlYt0wImIOIh+zlYTUZjkjBMphsGdC1yrpX7S1VaCsRiWPRUW/Q
         oJC+Agx+/jMhX1mugM/3XHEpDE5ASHeNQSAQbWIQxuyTNF29Rh/xTZwTE20Q33c5mYy9
         QX5TeQG8rO5kCysv35dKLU82WJ6Dwl8K+Jx8bPz3Dn3ICJidaMHzITkXndAcomFWs+PZ
         wi/C22swEkWKNOioJ8TnOyXyPTvh1cRzj2wUZq4yWe892297vktDJVNLW8iePSOfWRaL
         lgfEQ7zPZ8r8DKh7mORzt/9cYV6TxUyAot8gCid+vtZjjZ0DUOIpUl2r+FxCD5j/BpRX
         i8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfcPInjNeKQWisg/6qdBWmy01D7MzspldvMflbNNUKpf4mWCwpADHEMF72YrtUj5M9o5Wq+S5M+wJDYqT9wkfs0Yfqsmcq
X-Gm-Message-State: AOJu0Yzbmi3fA4wQSbHbrpCD7x0ySU0s14axI6bvii8G7bf/pvRWtyFx
	lXkGi3gp4kVp+dxhKTHt5UeBQlUhVQq8sBJcpKBbv5oohONQDi5fJFteKOaG
X-Google-Smtp-Source: AGHT+IE1+nFGBwUnX+I/Xue9S9SQ6BMKiF+zBa6ckcMXe23D+uO26EkDYDgegy1U33//r9P6VENuYg==
X-Received: by 2002:adf:ef08:0:b0:367:89ae:c204 with SMTP id ffacd0b85a97d-368273d6961mr3155261f8f.12.1721216787880;
        Wed, 17 Jul 2024 04:46:27 -0700 (PDT)
Received: from skbuf ([188.25.155.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23cc5bsm200291205e9.2.2024.07.17.04.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 04:46:27 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:46:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Willi <martin@strongswan.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Murali Krishna Policharla <murali.policharla@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: dsa: b53: Limit chip-wide jumbo frame
 config to CPU ports
Message-ID: <20240717114625.lfayhq435a4gskfv@skbuf>
References: <20240717090820.894234-1-martin@strongswan.org>
 <20240717090820.894234-3-martin@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090820.894234-3-martin@strongswan.org>

On Wed, Jul 17, 2024 at 11:08:20AM +0200, Martin Willi wrote:
> Broadcom switches supported by the b53 driver use a chip-wide jumbo frame
> configuration. In the commit referenced with the Fixes tag, the setting
> is applied just for the last port changing its MTU.
> 
> While configuring CPU ports accounts for tagger overhead, user ports do
> not. When setting the MTU for a user port, the chip-wide setting is
> reduced to not include the tagger overhead, resulting in an potentially
> insufficient chip-wide maximum frame size for the CPU port.
> 
> As, by design, the CPU port MTU is adjusted for any user port change,
> apply the chip-wide setting only for CPU ports. This aligns the driver
> to the behavior of other switch drivers.
> 
> Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Martin Willi <martin@strongswan.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

