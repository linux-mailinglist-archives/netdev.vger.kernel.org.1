Return-Path: <netdev+bounces-205937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D807B00DA7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC89C7AD739
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30A2FD595;
	Thu, 10 Jul 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGvQTWFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9728BAB1
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182321; cv=none; b=qRQ+z/IBgfb74BA+m+BpMd1+BfZMLv1wfzaNIPXVQfzo/6LCXOX2tgwoxOsYRGvToj3TKfAi7jO4CL8ZM+9uMKj9DaIDDdhYZClz0iP213B6lGFnPdGn7pLwUKdFjjZUowkKq7D3zWzEaNQ83BpNMccvd+HzBABL3Xg0p1MMsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182321; c=relaxed/simple;
	bh=Kw8eJFGiyveHLHxOTN/htQ7rcEXtdy+sM8T+IeYLN6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpXxnZ03JXTqrMwBCtX+e4Tcu5KUiHLI59Oq5MprG+TuSQL5h3Rss1HTyy/8/dEDfcvxkhIgIwXYIDaLI0d8QkIu6plFRorhgMzYbo7ZOQ2LtOw6a9YB/V11dI2QQ7lOLG0+ggCLeI0TyoXvOH/ABKNri64nIrziQOFek5HF6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGvQTWFK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2232245b3a.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752182318; x=1752787118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90BXQUYS32JtT6yR1X+EcpEwleypFI059YuPrW40zvs=;
        b=HGvQTWFK7uhYN1dY24T7mzeg5cpzFL/xmDd5RPkwAtrrRwdMGGxUIpLjF/P4ELxCrR
         jgnLs/knx55Nr9/gfLKZAm/nKQ1G35UWiITtglKwWAfstue0UuStrblSHwIYoTBHXhCQ
         /EycQAmUPaC9iKUmGUBsL4TMrBsXLIQ2cvzQYAa+oKOzDdkE/Fk39PZvhEYXz8Y2D7js
         b67+YPWhzigMuxUDNj/YcWt5n6xnryCJ9BUAl/hv79HlbIqPVRA2zmxP1LO9+fPnI8oh
         mvl3ljopTpazXXVMrrYrBdmvxFx0RQulfExMRO2YpglazeXIR/jLz5Ki1wQLLNipTDBN
         8oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752182318; x=1752787118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90BXQUYS32JtT6yR1X+EcpEwleypFI059YuPrW40zvs=;
        b=KCl1bObTVX+4nI1uLqmU4RazVkd8EEYDb6f5L6aIAmUu5iqmCcPinvHNhMXrkNls8t
         zV0sIUjwDllqA6yu+R3d+WWI4axyZClUdEWZMpucUva/LbhlIQI9+4IVA6pWK12P9jdb
         6VDNyeF5haHqQVVIjd/qoaMAx2rSECsDoCEmiujiMnc/zw8nE+Y+3L/R1n8ynd57ZkaS
         mgEFZ15jqG36TebVtZ+bPwxumVIvCdCRRv3A6Lc4Vj2GEMQ3zLx95rRMWV2iFJ6WEAXw
         a3Gxe6VwL8AB/uMxt3jh/Em2LmO1gDQTN45UYXF6cU90OzhnAXYwb05SALQCbZEMeGPD
         uNmg==
X-Forwarded-Encrypted: i=1; AJvYcCW6zUCVqU4JFB1McM6zufDJcHnZ4uJd/eKieI0EOnPWKFOEU639+nhyeJIczAUfx4DF+NLrgwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauZ+xSwCbUNgNFuV6Him+L2cXqx4sg8X9VxWjwckuisdvGTwH
	8VCmI0xMvLbV5m6JA9oCVkA3eE7Mi3FVU4xA5M4WNvf0bSjzJROhr8+l
X-Gm-Gg: ASbGncvmFL91l/nDZcFd/Pgj21qHyD/JTEtBlrl3EutW0WK9E7hvK19vfAnSM1VsKNL
	Dfl/UspsY1UMCi1zp6S4O2hEv/fRWwVzqo3BioVOaTO2BWQrCZVUxtpYMRTEjmTKKRNjK2wcJTU
	UNLLautFcnyurSFO9iTcJI/ZRFCZXtOz9oX+w1TsQGGrj30GVTRG6HOv98y7sXNTo5pcBahHl65
	SF5nrUzdzgcdhlKKTi5irWizS5VomT+0ddNtQFmqdyYILT3Yt9kl57LxNJV06jpVlX8ChXieEDA
	f6wVSJ8n2c2upT7zMYTyEDiKB2GOg/2CV4xnTdqn42N4XrSYAidMWleNqrG7mxGorPWOLmv6Qb1
	C
X-Google-Smtp-Source: AGHT+IEEoSIBL6xB9Bpm8yMD7RFFUwq3a6dlbhuE1tzSVQL7Ok2fliDclIriULZ5E/FTJNdck3jRqA==
X-Received: by 2002:a05:6a21:3287:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-231272c58b1mr1030475637.10.1752182318089;
        Thu, 10 Jul 2025 14:18:38 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8f878sm3065907b3a.166.2025.07.10.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:18:37 -0700 (PDT)
Date: Thu, 10 Jul 2025 14:18:36 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHAuLCWpBNC5hUwV@pop-os.localdomain>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
 <20250709180622.757423-1-xmei5@asu.edu>
 <20250709131920.7ce33c83@kernel.org>
 <aG7iCRECnB3VdT_2@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG7iCRECnB3VdT_2@xps>

On Wed, Jul 09, 2025 at 02:41:29PM -0700, Xiang Mei wrote:
> On Wed, Jul 09, 2025 at 01:19:20PM -0700, Jakub Kicinski wrote:
> > On Wed,  9 Jul 2025 11:06:22 -0700 Xiang Mei wrote:
> > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > 
> > Reported-by is for cases where the bug is reported by someone else than
> 
> This bug's fixing is a little special since I am both the person who reported 
> it and the patch author. I may need a "Reported-by" tag mentioning me since I 
> exploited this bug in Google's bug bounty program (kerneCTF) and they will 
> verify the Reported-by tag to make sure I am the person found the bug.

Like others explained, "Reported-by" is for giving credits to the
reporter. Since you are both the author and reporter in this case, you already
have all the credits. They should understand this and credit you
properly. (Please do let us know if they don't, I am happy to help.)

Thanks for keeping updating your patch!

