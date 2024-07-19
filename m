Return-Path: <netdev+bounces-112168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D7937417
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802351F226D5
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DC2C1BA;
	Fri, 19 Jul 2024 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21sOn7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0517BA1
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721371527; cv=none; b=DZoD+gXPdRDcfx7W7x5Ygzd9TdNyl805lST9IjnODLVcUB0IVebAvdyZ84gudQ1oG44aZM4UpesMhiLs3gG80n1hX26MyTfBF8V0lJ2ll6TUqocBHvBGD0o8s85dp29yQvj88DWN0x4syfISA8lIfRM0plrI+91G8sYvoBrIhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721371527; c=relaxed/simple;
	bh=RHJc+rCNP/iYY3Obr0xHpB5pUregLPBZcRws330Wyf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnJHuMqugCR7BKX8Prn32IPd63G8vCcg07WMVDbkx+6loewO7ikenX8IGI2XUU+Z/DyBa+CuwFc3+3p0vsn6OMznF9vfZdraOOBY0yaARE5JM8UTMOBto+p6P6iJW3NwUnXj8PlVMC4uL/q/FF2naKr7GAAff7wudhatXrackGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21sOn7E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd69e44596so899085ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721371525; x=1721976325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BK2X/XlLDdZfk+vSlCeT+DwvSYrZJ5Q8Y3EgJU7tLY4=;
        b=C21sOn7EaaeA3aUeS/Q5G085EjJ1yBduB5xGtmpioqXRi7RsnCC/sJH746JMJpm7QU
         jsESZ2htMcob8QtThrwvW7h3BzGj0wZ54RX0fAPdW+mzWf42JRsPukgKrzaSOp3xkA2T
         05oQ1+iXDb7Vtbr4ndbRFwD3/crjffFqgVBSzT+80n5/zm+Qcxaw74jJcDM6l7XDFlES
         yWjZnO58UI2L9C5U4AMhSo6bnOHc3erBATeOkWHSgCsHG06KE15yymWxT0relvUpbti8
         pEwCv2HLRK8pOCefC7olAJl9y052U4FY7axmV10G7F8vP/svEDGJr42d3sGNNgX3C8TF
         jAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721371525; x=1721976325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK2X/XlLDdZfk+vSlCeT+DwvSYrZJ5Q8Y3EgJU7tLY4=;
        b=gkVHDCJnKetSf2gKFNuevekjW6Y7d7qi3QJ7c2L+MP6Q+PGtKjPCMSV1QaQBNOoPby
         EON9lIt7jLVUobWMuGu4yMQQRCPPH3+RjNPiAe94mVCIIMS/RfPnaxLqp3zgx10sQS49
         6RPl8gOiImV48wsxbP0wltPknm+dAAV1O4+6Je9DwL9f+ajVJLRNn0fU9yiXRuRVxMbi
         rkbBZ0uGjOSqHkzT1fwWpZv8Fy7KXLX8lqNlXFOQkjm5KakT7SUMwKgpuvR32ud9j8jB
         6qIQlH5lkghv0OaxMmoTCFx6bTF2KhV90zFLrGztEaqAaIP8QLxwi5mP98CW6jZxQ7M9
         pNoA==
X-Gm-Message-State: AOJu0YzoKbzLGUYVGYUduQs85s5WhRfOlO8Sgdom3TUlwh/HPyIA+0AP
	LdagchE3SeN2rYAHw9fTvhxjT6i2u3PMyNWkmbIW8EQ8fftimkXAo9wmkSg6
X-Google-Smtp-Source: AGHT+IEmpbn8VhHWI2FgnMnMb0S4XKCXPRJ/JV6Ifujhj+Bd967faS6I5c05gOK3Wq6NFVK1hQrUcw==
X-Received: by 2002:a17:902:e844:b0:1fb:5d71:20dd with SMTP id d9443c01a7336-1fc5b0c592dmr93677675ad.0.1721371525069;
        Thu, 18 Jul 2024 23:45:25 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7820:f0c0:437c:edbf:e0cc:6fa0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d073desm6657255ad.161.2024.07.18.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 23:45:24 -0700 (PDT)
Date: Fri, 19 Jul 2024 14:45:21 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <ZpoLgQtZG5m8gU3L@Laptop-X1>
References: <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
 <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
 <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
 <Zn6Ily5OnRnQvcNo@Laptop-X1>
 <1518279.1719617777@famine>
 <ZoOzge5Xn42QtG91@Laptop-X1>
 <Zo9NtDv8ULtbaJ_k@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo9NtDv8ULtbaJ_k@Laptop-X1>

On Thu, Jul 11, 2024 at 11:12:58AM +0800, Hangbin Liu wrote:
> On Tue, Jul 02, 2024 at 04:00:06PM +0800, Hangbin Liu wrote:
> > > 	Looking at the current notifications in bonding, I wonder if it
> > > would be sufficient to add the desired information to what
> > > bond_lower_state_changed() sends, rather than trying to shoehorn in
> > > another rtnl_trylock() gizmo.
> > 
> > I'm not sure if the LACP state count for lower state. What do you think of
> > my previous draft patch[1] that replied to you.
> > 
> > [1] https://lore.kernel.org/netdev/Zn0iI3SPdRkmfnS1@Laptop-X1/
> 
> Hi Jay,
> 
> Any comments?

Ping?

