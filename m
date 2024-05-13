Return-Path: <netdev+bounces-96021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5DB8C4042
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE3E1C203F6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4570E14D2BC;
	Mon, 13 May 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj7+XGDq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37214D2B2
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601552; cv=none; b=BCRrZnygsYGeNrjer60OjwOY5IGDcT4NLkEOR0jWA1nYBSHVtQ4ZJ+CYGwlTD1wRHdD2rE4pYxY8MN+FZgyTehFKIjy5Dr7px5oaI8rFjAEbp9nv5vT8x9Txn73cBaIDayjkrE36kAG+hnDLRgppekPIWFDcyR5z/J50SzA+wSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601552; c=relaxed/simple;
	bh=XJOZ1y/A/fRr2Un7hFH/UvBNMP1qm1XE4Fg4gM9Msiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVGTWf6pSoo32/pf7s1jBS72k9zSeqcWAXc3twxbWZNQqp7Z0Df7toxCDWJza3UJTn/YFBAbSIio3uFKz8yTo7q7bkdKCWXlEU9K9PUUPrfcTrwm1O+0UfZY+Yq6itX7Ri3m29PulhE96RyrdTat9/1Yk6yvfBL0QwQEsxHq5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj7+XGDq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715601548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IykP+Rn404SK6IYZiDrJ9QnBFv3K+ECcVyrq/opT0Ec=;
	b=bj7+XGDqWBHb1N0JysUfb8KiHjRBYiGBeivw1tbYlR0rE9/d3we3IQV7KQ5TufIFBYQ4bR
	H/7OEs3v1YMZGqff1xDqkb+klvfRqvloKzWxoP5KlOKM+SxfQm/ffAHGq8hGIEDWAwEb0z
	ZIjmkuu9RRsgM33I0kQv+I0V52O3plo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-Syx2OT2_N2q3kSq5KR8JRQ-1; Mon, 13 May 2024 07:58:56 -0400
X-MC-Unique: Syx2OT2_N2q3kSq5KR8JRQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34d9055c7e0so3086953f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 04:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601535; x=1716206335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IykP+Rn404SK6IYZiDrJ9QnBFv3K+ECcVyrq/opT0Ec=;
        b=kHOIjOkQVvA09eXktfbBMJKILde/AM/dc+1IO+ezEQ/6MDtGt0ykZ8JG8kXKnnP98k
         kmLOlmFnfROPsFhNeGQZPBAylbpx1lnzoFlufnuHBJO+R4rkADtEcj1fwrmIys1J2fUP
         CGoGfH7npHCwvseTmvA3MPJh4JehfoUY6PU+L6AOVNNZWZQyHKcQ6qmlxXlXSd+8QAxq
         J5UImeBAGsTLxcu17YwVmo7zUd4yTF6PVrRx0zdYRylx16Rso1Q9ax2QRP7/gPb/q4tN
         +V2OAnNoZoJ075s0LOwP1eo0Wrs/otsVdHb79GYp6wKmdTGZHmOIc8PXSGOe7y6Viv7C
         sryA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/EIVe0a/WDZgyi9ROHwUyerMv42ti41og7FKN0hZFapB/3DohvP2ojvFTbgYpJzQ6nX9ZeYQOEQ995uHoQqdDqgDqm8H
X-Gm-Message-State: AOJu0YzzbWNsVotBsIE66FgVIMkuu+VWo9+ncSuqWaMdycInjglYh7c9
	Y3RdlNVRSSdUErxs6U8NUDMnr7YwLEBs3uP1unifo5PrtxHcmtGW3JUKNHHuXs905/Pp2QCCjAK
	JP9/4bADUEhLGQo9zfnj+OL1NTsksdqywK+7wFvKZ7oFy2CiYUCUj/A==
X-Received: by 2002:a05:600c:470f:b0:41a:b56c:2929 with SMTP id 5b1f17b1804b1-41fead6b10emr64861645e9.34.1715601535379;
        Mon, 13 May 2024 04:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5oJKOSfTFUBVPWfo97QXO8dK1tn39bRmQl5rLnSPv7DZMiW92M991TxXOgfXPGLTG55H6kA==
X-Received: by 2002:a05:600c:470f:b0:41a:b56c:2929 with SMTP id 5b1f17b1804b1-41fead6b10emr64861475e9.34.1715601534776;
        Mon, 13 May 2024 04:58:54 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1532sm153167045e9.46.2024.05.13.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 04:58:54 -0700 (PDT)
Date: Mon, 13 May 2024 13:58:53 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <ZkIAfWna9UqzVDEF@dcaratti.users.ipa.redhat.com>
References: <20240509160958.2987ef50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509160958.2987ef50@kernel.org>

On Thu, May 09, 2024 at 04:09:58PM -0700, Jakub Kicinski wrote:
> Hi!
> 
 
> tc-actions-sh
> ~~~~~~~~~~~~~
> To: Davide Caratti <dcaratti@redhat.com>
> 
> It triggers a random unhandled interrupt, somehow (look at stderr).
> It's the only test that does that.

wow, no idea why it produces this. I'll try to reproduce and let you know.
thanks,
-- 
davide
 


