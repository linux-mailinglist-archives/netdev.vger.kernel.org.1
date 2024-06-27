Return-Path: <netdev+bounces-107289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99C91A7A9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47364280E38
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7EA18E772;
	Thu, 27 Jun 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBjMxmVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B01E49D
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494245; cv=none; b=lYyI5DcqCrzLxcWFiVFryytELHpzxLIpfTMK3PYPEwNctUJykhCfaa/B+TG7eV9SmpQ/zACnJyTGAcnvZ9NlwzagrmEgQZFbfArIpB/GFPHdW8HWhDhYZ+QhP9+cSW7qdDcF6S7J+pghywV0PcnoU9oqsIktZwdAGCBO1ST9yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494245; c=relaxed/simple;
	bh=WfNutsBpz8FQNlq6DTCEEaKVT52A02Dg/X+duM47MyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPlEY29BaDv9C4DsjelDKRm3YaSIJWwhnU9REQ0GsNtDTKRxq+5dvZ1UMSyaQSxEjg65i/gz8Wv1u7S1Ekr5PaoBw9uh9czkb6FfbZac9kgOcLVljKvdsi6Zuz7tHtNO2WA0bQm1/nq3KbtrxZlndtQwTHz+hCpOk8v+uMXTIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBjMxmVN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so4669453a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719494243; x=1720099043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7XpDbO9wnCpqYJrgGwIbVlZGjt4wQAtAcZyFpWZlX8=;
        b=TBjMxmVNvBLVAuUhXHwhseLpiXnWwuXMi2+44MRtyMd2dXlTsw8EQy8TO4HZCXh5wo
         3uMhHQdbzAFWhfxbEuO18l42BWBWgscC69tgYJJqd6UspNHiVKSJDCwVHpSdxOFaz7qx
         arvh2pxOuunHpwXbf8oys9Vv3PYDviSUinQJF9J4JKWvUO9LAUAmoOp5mSjxHOt3CAjD
         UYzUTJ/2pAq/Q9yJuGcio73hfVenMs1iMi0YWpoi3j7oJbj4V5/umF+ZOH/mnnmOTHyO
         WBarBKxzlmtnFVNTE5aNauYmE7o5oNxGdgd3RQiP0Kt3usMWit/dqJo4UBfC3ihNN0f4
         aDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719494243; x=1720099043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7XpDbO9wnCpqYJrgGwIbVlZGjt4wQAtAcZyFpWZlX8=;
        b=qwIFl/fWHs9atSB9zFTKoskcdUI7F7y35E2B75n2Ji8xzSI+7fvYw/Scp+G4zUZlaz
         PRJZiUdL4K9bBhMa+JksTH64lRDxRZU2TLf4Zpm+TvOoJMGbXBoUYXid593LPO+jFi53
         Dsno8rPAchSvAskeSGktGl1OugttUq24XLQbLlDmGLb2UKiVOEZf4WSvpkDlOIHEPbcY
         aZyTxhaRwSHe2VncECLK6LC9zaZG8iElVKJezPbQ4q2zVWGxwBGH9jk1jSBpsbt0Uhcp
         CsexcFvwCSC1+M9HrmMuBkQONRKJnB+EfArzG7kBdyHC6y1wBpLCyge/oxgoqsACsjmI
         wDlg==
X-Forwarded-Encrypted: i=1; AJvYcCXOcuuf7+WN9700Waw8KpVU2Fl27VmyWQ/s1gax7/hTChZbx9jiv6ErjhR5ga/jmkCwoB9SB1p7zwdED7rhXHSGRXtGf+aN
X-Gm-Message-State: AOJu0Yxyl2UM0OCJsl53vmEeFH4r4cZ6N0FIStyuhagM6xz/0yvhQZct
	hT9APmovfpN8UOXIQhHaIrsqO5x5i1ekRVTvr5hveplBw8gkNY2t
X-Google-Smtp-Source: AGHT+IFdaxJ0/OLXDn7PXdiHx8pMjOJE/fvGA6g0CxelzRHhaePeCsTov8WnS3ZORtxuV2VZUZcbeg==
X-Received: by 2002:a05:6a21:6d96:b0:1b5:2fbb:2d84 with SMTP id adf61e73a8af0-1bcf7ee908fmr13693667637.28.1719494242995;
        Thu, 27 Jun 2024 06:17:22 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a07d82sm1337893b3a.99.2024.06.27.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:17:22 -0700 (PDT)
Date: Thu, 27 Jun 2024 21:17:17 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <Zn1mXRRINDQDrIKw@Laptop-X1>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org>
 <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>

On Thu, Jun 27, 2024 at 01:33:10PM +0300, Nikolay Aleksandrov wrote:
> > Yes, but at least the admin could get the latest state. With the following
> > code the admin may not get the latest update if lock rtnl failed.
> > 
> >         if (should_notify_rtnl && rtnl_trylock()) {
> >                 bond_slave_lacp_notify(bond);
> >                 rtnl_unlock();
> > 	}
> > 
> Well, you mentioned administrators want to see the state changes, please
> better clarify the exact end goal. Note that technically may even not be
> the last state as the state change itself happens in parallel (different
> locks) and any update could be delayed depending on rtnl availability
> and workqueue re-scheduling. But sure, they will get some update at some point. :)

Ah.. Yes, that's a sad fact :(
> 
> It all depends on what are the requirements.
> 
> An uglier but lockless alternative would be to poll the slave's sysfs oper state,
> that doesn't require any locks and would be up-to-date.

Hmm, that's a workaround, but the admin need to poll the state frequently as
they don't know when the state will change.

Hi Jay, are you OK to add this sysfs in bonding?

Thanks
Hangbin

