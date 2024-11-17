Return-Path: <netdev+bounces-145613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B89D01DC
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 03:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5951F226BE
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA9EBE;
	Sun, 17 Nov 2024 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRf3fef1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA9322E
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731808838; cv=none; b=dxZwyeFzMLbe9lLQpyU44w/6hvWqFmlVlieZFJHoSKGZyWdlhjMqUbAy2rzUe+oJPFQZd6rPRIDPsfrfEqBcVcX0wlKQ1HaM6oyiVDnejdPUACCH+qnc/NA+GjNyTO0OXcn8yvABdinpSDSm9ibUr1Piq/oEiwBwIUaARnpS0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731808838; c=relaxed/simple;
	bh=pggGwYYiO7/EKpaGZyBXtbcE3Gc+xSn+dqRYs9jjf7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4aXj9ShvpmvNtGjrX1FAnv80dyoXGx1BvrpBpFjQ6ys/N5LIi5FlFSut4ZMzOxbvYqZOg7EUZQ0YtBZrLnWvfdelgtDBq52cDHu3wDc1xeK8IR1iUVHi0Xx9M0BG3ENgEJU/PqK8AofmmfCxP4t1XU4avTUlN+D7kWjoAopy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRf3fef1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so588739a12.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731808837; x=1732413637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSj+/u6+GW4MKPbW6oQfGVJ+m84++DtvLy+bIAMU78k=;
        b=MRf3fef1Mw6kIynYD+7CHa7CjM1HV0MMAslXAv5WafFMAwqFpeHGEICUM5/LhqYgKD
         0Nf76Sw+Lg2vPef54sSf5bXYwg7VsjysGHw4glUE+gDaLyWD2bkkJWpGgobzHGNjpqE1
         E4UEBSID0WSmxHP6mn1E7CiQ5RXvad66EuzlDAaaOx+bo7b29BBjB4/Rxio1kpvq85aV
         bBqeKRTMvZ7Zke3m5iUX+SfE35LYowJCL/yEhcEUyD5S65U6dqvd1/lirMDafjDzmTv1
         ljF73PScW1SnSgBhywv43DlvbCq9gGezKVj7Cn6wE2/Izd3BgPofCCm8pMXYnGd3sxUw
         3UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731808837; x=1732413637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSj+/u6+GW4MKPbW6oQfGVJ+m84++DtvLy+bIAMU78k=;
        b=v3uGb7OWynbF0v3/2ut275M9+WribNaJ9k9ZSVTUSIcuT41YFgRqJ4CqGOXYGHRa9Y
         HOMvy7iOAcAVU0Qw+0B2RxkCQz66bwWkE1cymBflXLZ1CMFm6ZRAAhj4Q8J1o656B1pw
         bOYN8twtBSDOLBVALCGfYVTcS8mjlf2V/h4FkwiCf6qLJdjCNUSJTJhONuSOmK6Nrsgi
         nmmkxO1mEmRAe5/iwlhbdDCPMYkTv+BFM/FmMJ8pnAKLy0p565NgMDKQTZzNFsL64Bvc
         jWLIUZvqKsuMoghUGi9w/tlz85Cgq2x5o0A1i3Pf7Kedc9IIHL2AvQWUDI/TYYBhKbCr
         fpuA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIECkwCdX/nUx5Dq67GMn3K/e5bA79fL7AHS0p9uL7zYnzqxLcEC61FevtF8rufvasUJNHrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fg0KwZz+3Unp4ozi5XM8INsMquPFZgAd/NQfL4IuZbyWNRKM
	IMAFJpf0jkBgv8ITnLq1PMIgl5ykqrmkVqSBGov3Ik+lJ8j0b775
X-Google-Smtp-Source: AGHT+IFsZMZwSwbAKPkv6r9IvFGROXfwOQP66QD5l2cdrvFymWhAYjttisJwAoW9VjB444FjZdteiw==
X-Received: by 2002:a17:902:e80b:b0:211:aa9e:b825 with SMTP id d9443c01a7336-211d0d724e1mr99791465ad.14.1731808836602;
        Sat, 16 Nov 2024 18:00:36 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f56defsm33307405ad.270.2024.11.16.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 18:00:32 -0800 (PST)
Date: Sat, 16 Nov 2024 18:00:28 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <ZzlOPEyFxOjvPJd2@hoboy.vegasvil.org>
References: <20241114095930.200-1-darinzon@amazon.com>
 <20241114095930.200-4-darinzon@amazon.com>
 <ZzlMlnDvhBntNkDS@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzlMlnDvhBntNkDS@hoboy.vegasvil.org>

On Sat, Nov 16, 2024 at 05:53:26PM -0800, Richard Cochran wrote:
> On Thu, Nov 14, 2024 at 11:59:30AM +0200, David Arinzon wrote:
> 
> > +**phc_skp**         Number of skipped get time attempts (during block period).
> > +**phc_err**         Number of failed get time attempts (entering into block state).
> 
> Just curious...  I understand that the HW can't support a very high
> rate of gettime calls and that the driver will throttle them.
> 
> But why did you feel the need to document the throttling behavior in
> such a overt way?  Are there user space programs out there calling
> gettime excessively?

Answering my own question (maybe)

I see that your PHC only supports gettime(), and so I guess you must
have some atypical system setup in mind.

I didn't see any comments in the cover letter or in the patch about
why the PHC isn't adjustable or how offering gettime() only is useful?

Thanks,
Richard

