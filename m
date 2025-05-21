Return-Path: <netdev+bounces-192487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D335AC0078
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BF16A36A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DF23BCF3;
	Wed, 21 May 2025 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="IZ8Iq3tm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7D1D90C8
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869208; cv=none; b=L4qTQI5s84qs4woEyLqwKbQQoEtZgbkdQP8G0sz3wviQtSveJYugkidtWD+d9Lqcz6FRw576v0HAqXYMCmpzPztDPmAtVhTzXq6AUc6jv8lXwsNWfe6DVHKFRXZjYurcbdib6MGBzeTDfcoKIKKiho4Onw/yCZpUjIhWrskXO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869208; c=relaxed/simple;
	bh=nSuedLaC8dXdCTCsgGVl7NwKTBULofQeR1ejaSzL/fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjzvM8jmYC7ZyyAd68VR8D/vJ2PHyu7q+2WVOKh8Fu4Rrzghct4J+WmWHb3GtbN6DATdN1L+moIvoFG5u6EH5mWXYY7f3qOzZc1+a+0LJKXvvQBhb+UKgN/Q3Ome0G+aSvGuvQN6962q61YRqgROqxJKgW1YPU90j/X8eQo5EhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=IZ8Iq3tm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2322d8316f6so5300045ad.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747869206; x=1748474006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKMJ2fz3N6fpkcvc501kYEjftfIcABz7h6kFhTzhFWo=;
        b=IZ8Iq3tm6JNz6LhXM/HVNFB4NjyUpc3u0HYv5wJQg0wIdZaA0/fRiHA+PKxSt8j1nb
         WmoOg5ycTh/D2K4B9dZRcpSUD/vEVq1AAtDrjxuZpjZtmN2Q/6+n5xfooOm3b0o+MPWl
         ARVWQF3AJ18B19IPz2lohahT/iUbgSjsMFAqtrLwkQd/GV3hCvZN90RWZE67ZfBp1V5v
         xmA/nlvaCberYlNaYLW3JwEU8v3wbN0Vta+IRoHS+S7EUkxp4zqU9JR98COhYMLDMA+J
         +ppyT7AXm2iGezqFmTfIxCS52nShZT8ET1IVM8HnQ4tScgMkiOIs3gZyOAerhW6v7fgr
         N7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747869206; x=1748474006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKMJ2fz3N6fpkcvc501kYEjftfIcABz7h6kFhTzhFWo=;
        b=hACtszrPQf2LUPMoAIWdyQHpXI+5qJbziP7pc2xXOMcQ25qepQG7AsUB7R/yNu7q6h
         AUGUYCZ5cgDteC1HQ4uWSVooX+0YyT0Kn2GkMHddwEC2Qv/fQAje/tJTPK/OLgWdSBAg
         ULkA3UiyeoP9Z5IL11Sx3lxXVvtic56zp/0nhLk20roJcv1yo+adCgIgR/dhS/wmJdZc
         NCuTOooPa1X+ERSgIzTW8lt7biPayufFx1e1HZeQ4AidD2XfaYtVbxD8iggFnhI305WF
         wvYCC93ShhckKUZgybim5MzjR5CP4XIr7aczXdbeb9y54q3UsWm6XSKYuyhHgWuCuXKF
         ChuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlFMW747KecgoGtmwR713Tvo0bm7o6fhS08F1wWbCxucqEFpz7n8dP/cbLGv6gdW03JX9T63c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9Sp0xz+mxpnK3utoJgc3aMIfdzcQjLSoXhCrEQZ+pmOGPkUf
	ZxB9q3BUWX2xHpROl3LTO4LQA5XomJDUucYg8G990e9g6OjquWjfy2tab3qywfT5vZQ=
X-Gm-Gg: ASbGncu4PuPRl5bxQ+dFa5p3c28IIb4njUKcSKYKouUopukYnEz8buFtVlNjmp7wBdJ
	4UJWmUcR2jq3OFSbZ6KpzXIub/vpTFeRH8hsPcYVVvcWhOcOxK2z291dMZUSeAWxIyRN1GYXx4U
	KEWCgH9U72fw5RstKmQ42IkdDcfodq8Gkha4Lba47D2tD7enqANtb604Hmazi+40C7MrfX3kwLG
	hEyzzuA2o4p1CDnYdVjqwe3LQjNOhcWuSNyTowQae6EC1XqtlybL2c3hWmMZVXMocNLvJ3vKb5w
	7/WYpmit6TskE4CbOlHF6ke/3jAgOPVb8hd4XA==
X-Google-Smtp-Source: AGHT+IHJqsJtAdXfzDjopZWWI8xEjT0BiyBGtq9CFsmyZluNMt3NT7LTnT7qs3VJkkcckq91qpX16A==
X-Received: by 2002:a17:903:41d0:b0:22f:d4e7:e7ca with SMTP id d9443c01a7336-231d43b2377mr120368645ad.6.1747869205985;
        Wed, 21 May 2025 16:13:25 -0700 (PDT)
Received: from t14 ([2607:fb91:1be5:f4d8:99e5:a661:f426:884c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed2568sm97882475ad.214.2025.05.21.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 16:13:25 -0700 (PDT)
Date: Wed, 21 May 2025 16:13:19 -0700
From: Jordan Rife <jordan@jrife.io>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <p6wsy4m7obq3apegcxpgpp4wmjgahy2d7dzkjb6af46k4eptvt@dpxpfj7sst76>
References: <20250517192955.594735-1-jordan@jrife.io>
 <20250517192955.594735-2-jordan@jrife.io>
 <aC0PUO0V_osG_ZrN@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC0PUO0V_osG_ZrN@zx2c4.com>

On Wed, May 21, 2025 at 01:25:04AM +0200, Jason A. Donenfeld wrote:
> On Sat, May 17, 2025 at 12:29:52PM -0700, Jordan Rife wrote:
> > Introduce a new flag called WGALLOWEDIP_F_REMOVE_ME which in the same
> > way that WGPEER_F_REMOVE_ME allows a user to remove a single peer from
> > a WireGuard device's configuration allows a user to remove an ip from a
> > peer's set of allowed ips. This enables incremental updates to a
> > device's configuration without any connectivity blips or messy
> > workarounds.
>  
> Applied as:
>   https://git.zx2c4.com/wireguard-linux/commit/?h=devel&id=8f697b71a615c5dfff98fe93554036a2643d1976
> 
> And the userspace changes have been released already:
>   https://lists.zx2c4.com/pipermail/wireguard/2025-May/008789.html
> 
> Thanks for this! And sorry it took so long to get it applied. I'll send
> this up via net-next in a few days after a bunch of testing.
> 
> Jason

No problem, we all get busy :). Thanks for applying.

Jordan

