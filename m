Return-Path: <netdev+bounces-99198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32B8D4072
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAAF1C20DBA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBA1C9EB9;
	Wed, 29 May 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZHO7n5l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B11C9EA7
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019085; cv=none; b=dlTRn9UHVYd5X/7uBSrzSYiZGD2IpAwJevlG/FZsv2qmXjC5dMdCjJR/HB3MEv+kkX9Q5RaYbiHfG2qJHlJYNyQsIFj4UVf1U/Kbn1x3XNGYN07a5+oITjaHPD3ewaooFRpVoFgHLBHZVL9wf3KUsBpELdFjXkS6+RcAGZrjs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019085; c=relaxed/simple;
	bh=rwV9a04/damkbwWjfkc/cg9LZ7d8ZxS5hVCSmXnjbaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyqfQgn5qNzj7625GekqaE5ylSIHhVjBfYtt4YapCWdAwIa9ORiltBAE8ozjTkMfLAP7XFbm31REavo45oPzPTVDevQj7g02ejqzM7CaM6+TGp16ZgfyTBZ2Xvaul8u1gLIrkWzAnTNaw3NSykcqygQudlgMEWHAhYrGdz92uJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZHO7n5l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717019082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0hpOX9YOg0pCIp+iiPW9WCgKyleqs+d+4Let2HWBPw=;
	b=BZHO7n5lPZdKSSFSeb0oADmilwD/boBvFlv2alfK7qqvxXfCSuWXY3m8TWyBFQTrMcEa+x
	ipoI651uvP429klzYtNFcldu5yfEeBMHHxmU6SEQSKrbAW5s6R+QR+n0TYCnMlqPwEXXhJ
	obWWNj3ycLNAPomkZEhLRy4b5UnVGjk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-m5S9p7NhMvKXreOwIv8UBA-1; Wed, 29 May 2024 17:44:40 -0400
X-MC-Unique: m5S9p7NhMvKXreOwIv8UBA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ab9ce5a776so1761246d6.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019080; x=1717623880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0hpOX9YOg0pCIp+iiPW9WCgKyleqs+d+4Let2HWBPw=;
        b=g5etEtVY0sOXI8xFbs0nTdfellyAnb0gKV47ExCcFqvQ/EYASYRi9SKMDgPyeB4YHG
         fO0We40EdUP2SBvBH2/b0SUmYWangZeoXAk2QuvGx+6QYKYexPngYKsZNncma12IINLw
         CNOkeZlblB2KK1T19gf+cXH83ZISW3iUxlgklGwEgQlD1JCs5/nFlM0QE4eGQZkFKGZT
         Io3g9PxN6LX4YCsLGfMoPcHjMTeWG/EwYVdEOuFJvy2DpB6bEELtvCZW1yODB48JIqPF
         XjPUbh0yJZCOnXX27G01M3hrtyxs5d73Wfugo62VERsoYMlJQ7RdVZDObFX+F2pOYOfk
         Fmzg==
X-Forwarded-Encrypted: i=1; AJvYcCWZzBlzKAELOZdhYQi8SGLqMcAG8gWFDoHy8sWmgfQN1v7lqeu+qAa/M8k1OdfhnC1mdJHl7Xt0BxC/tROqYmYWCqwB2wku
X-Gm-Message-State: AOJu0Yyq820Z0DTFNGhM1zCr3HkFRztNEuf0mMN1TSXcY/CxWHDs8uDJ
	vw5PiZS8GXTJcbPGb7g172OI5cmHOBuYpofYVFbDjpZ0CZ3fs8nZfyzBBspvj6InycVkvR/ek9k
	k5gd4vSXavJA4hQwneSOuQ9oCFSuVhXJ2ov+Gv+SRMx8l9kv6CZjUcA==
X-Received: by 2002:a05:6214:3904:b0:6ab:8412:d7bf with SMTP id 6a1803df08f44-6ae0ccaf367mr4791876d6.46.1717019079917;
        Wed, 29 May 2024 14:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsFnEGiYlgZOr6BT1kqH8lOCeoyPP2kdowylSkFq9MED4xGC4AoewRV8KgtQLy1zmosdrIKw==
X-Received: by 2002:a05:6214:3904:b0:6ab:8412:d7bf with SMTP id 6a1803df08f44-6ae0ccaf367mr4791586d6.46.1717019079276;
        Wed, 29 May 2024 14:44:39 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070d8f3dsm57860966d6.33.2024.05.29.14.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:44:38 -0700 (PDT)
Date: Wed, 29 May 2024 16:44:36 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/6] net: stmmac: ethqos: clean up setting
 serdes speed
Message-ID: <3lpjpljgbgig2hgzywnevjixtfuk2pnd4ijscraks6n3gim4i6@ro6a3liims4t>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
 <E1sCErj-00EOQ9-Vh@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sCErj-00EOQ9-Vh@rmk-PC.armlinux.org.uk>

On Wed, May 29, 2024 at 09:40:59AM GMT, Russell King (Oracle) wrote:
> There are four repititions of the same sequence of code, three of which
> are identical. Pull these out into a separate function to improve
> readability.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


