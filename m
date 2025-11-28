Return-Path: <netdev+bounces-242454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91774C906C3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9784D4E104D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D67205AA1;
	Fri, 28 Nov 2025 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdrjLKo4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7C1F4C96
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764289586; cv=none; b=nVlhcDYJrd2AO5iB6/2oIB1woQU4tqd9aN3A4nqWLVDu5vYM9PBwswkj8ayGqLfrtNqQhasacTWYnU2JATZIeNzqf9F4Z6cGSasRgpWaa5bcScgOOcrAJ8cSFC7Zxmp8U1AfxWNGXMeOahlxn0R0eoO3TpsTu0yM3Mn71P2oP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764289586; c=relaxed/simple;
	bh=fnj8ZS4XAR8c6IuvAYy03m9ZxUyL06KUQCeYMBL3bHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4mmHXVCtLaxolXsEVj0sf4QpQCm7uZX2zoGB8S4jGlUHeYYmPo07AehJ4SaUXhxoNuQGoNxE+L5qd+vUK6NXhboGWcCD24Ybj01NBvAv/E8B4Nb68MuukJyH4DyydcyTzehzGUDYMJsC6/QGa74UmabJK3ESk+h4fgmbTT3Ej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdrjLKo4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2958db8ae4fso13195145ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764289584; x=1764894384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzjAS/DAbgVRPhP5YZ+gkb8gp8TYm3Y4OihcIvNbSOY=;
        b=HdrjLKo4NIFyb7JvTOJlKDb/GvuYI8yRYcrAQq2k3wmlKZmOcHIT38yb9JaYKWzH5p
         iQgJBZPtfB/rG6d6yp8aO6C7XG2+vHmtDI518r9D3jxW/H+RiIxsCWb7FwH7IPZvtBbO
         /p8psiycjGhaZISnre3eSgxFQ+9fqGWf1N9WoXlzJuTJec4MMrNEpNQzpzFaVajTxk3V
         B3v/yLaqiGQqm2+wIlvj3f4hynVZ+bfNvXUfqJNv2sNm4awNaJauT04hrlfWQc6YCZzx
         mx0Gj5mvyMzosc2FvXd6m48ML3Qzdr1LtKm3Gd1VJRRgkn32bBIeGP6jP6pxMlfYOz7c
         RoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764289584; x=1764894384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzjAS/DAbgVRPhP5YZ+gkb8gp8TYm3Y4OihcIvNbSOY=;
        b=UaV0qPPz9Rd8Cy/9uCIYm49xJYtsnmRIuVShEjiqzNQ8LiZpjHdftUEzpfgqzO1T/X
         P949/1HC25IHIaGyZkoe/wzjUggW21tEKYU2I1AyoZTfZ301la81ARt6JgL0aQeK4mht
         G47WfH+E3fGuU+XCazN08bU8lWYCnC1F6u29/7xd0/EwSgCznvUqkZWLd9ZXZycK6ntT
         d+LaIE9ME9hQNXDVF2LbSgrBwo8mHnOrFlrSlDN/JSSmtJNUwrZLRa0cun3C9RLnmLZJ
         dSPrJi3RDYIKr8EzCInN4ItQTLu1j0eJkXp7K4FYksqFP2H0PRC7KQaNLWhv8Y4P/ZIG
         Xhug==
X-Gm-Message-State: AOJu0Yz9fPfhK/ZQRe7Wo7/vd8JtDjaciyndBHd/3sh3K6796LaLDE8p
	epYZiw+G8xY1x5RbCHZ0HAex4K1qR2pgtOIsjwXaD6wy8L7qb9+X4kCVSq3Q2La7YZs=
X-Gm-Gg: ASbGncsTBqAuvTxuE59sqsfPKfoAeAeppeYmhZz80uESgHnv+JwKnezJ4iqXMEx+8jd
	2sLqyo2ISPdqS17O62/poOarZvod2mcyxn2/svJcowsPE7yKedObYaviSsAipOBN4ulENW5zSjS
	r200R75gAs8gBCyMyzsITPvH0ACJXqjrVkxTMZ1VsQr69yegyKx2wVhqUKY17pFbcHpduRBhBuQ
	sClxwRsRyC9prmRM7p6jHGHnDkKPO4bGgt0M94n4JDjZp6mMvkzKSF3wLbgLulgOudBWrh1Sscg
	LIhWTzHzshS7O9T+1XccTs0UD+50qpSUQljaMvwEJB+cEHng63Dy8wnvYviwUH9lRdez8NnqWQk
	AV2vr1P3SYJDzhTlTC3UshBs+7hPY/PFLiTwTSroMk+QE81zfdEGvOwARTxjPBGcs4uLZaTh+oi
	zuGNo74TZU46HxTXM=
X-Google-Smtp-Source: AGHT+IEahetEHgsrchTrvYUPCtqVOgoruLamh0gS6BfLUQCuek2B1vmE7RW7ZvYDAf5SVfIj66bpcw==
X-Received: by 2002:a17:902:ef08:b0:298:60d5:d272 with SMTP id d9443c01a7336-29b6c3e42c8mr278852045ad.17.1764289584019;
        Thu, 27 Nov 2025 16:26:24 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm27882635ad.97.2025.11.27.16.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:26:23 -0800 (PST)
Date: Fri, 28 Nov 2025 00:26:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net 2/3] bonding: restructure ad_churn_machine
Message-ID: <aSjsJxaB5LmHYM3d@fedora>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-3-liuhangbin@gmail.com>
 <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com>
 <aShbAp7RZo8sfq2C@fedora>
 <7f7238d8-bf0d-43f3-8474-7798e8b18090@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7238d8-bf0d-43f3-8474-7798e8b18090@redhat.com>

On Thu, Nov 27, 2025 at 04:29:47PM +0100, Paolo Abeni wrote:
> >> Please avoid white-space changes only, or if you are going to target
> >> net-next, move them to a pre-req patch.
> > 
> > OK, what's pre-req patch?
> 
> I mean: a separate patch, earlier in the series, to keep cosmetic and
> functional changes separated and more easily reviewable.

Sure

> >>> +		if (actor_synced) {
> >>> +			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
> >>>  			port->sm_churn_actor_state = AD_NO_CHURN;
> >>> -		} else {
> >>> -			port->churn_actor_count++;
> >>> -			port->sm_churn_actor_state = AD_CHURN;
> >>> +			actor_churned = false;
> >>>  		}
> >>
> >> I think this part is not described by the state diagram above?!?
> > 
> > This part is about path (3), port in monitor or churn, and actor is in sync.
> > Then move to state no_churn.
> > 
> > Do you mean port->sm_vars &= ~AD_PORT_ACTOR_CHURN is not described?
> > Hmm, maybe we don't need this after re-organise.
> 
> I mean the state change in the else part, I can't map them in the state
> machine diagram.

The "else" line is removed

Thanks
Hangbin

