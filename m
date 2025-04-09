Return-Path: <netdev+bounces-180569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11482A81B5C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA28D173470
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13480192584;
	Wed,  9 Apr 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wr57Cdf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CB8C1E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744167599; cv=none; b=ZuUmGDAWxOh8pZTAZ/AM1TCIfOSDxMzDqRh3eaysfMXsTx4ObXpEwj5ojKJW3843yAENBFQCDNYp2hnkiBpDj8Q+/fOoB1oflblwDnuaDlGVFXt7OjhQk5YFfEqPMi5foakFeoY/8kBYnr9VDbGMdgEj2X4SrZ/VHJUlKPTbtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744167599; c=relaxed/simple;
	bh=wDOxN+6LHWEH5hMztYK1cRCFp1eqRe+rlGyBbbh0C1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEg8MX+vn/zLwIlpGSrdqvGJuBTnh6o5m6/4hz03uun4KtHn6rWZUNiYT/kcuKp79s61MAetaakWoEff1gUogAczUC1tp3i7AxBedpWhK8xsS9UGMlccHd7XKRv9IAStIziswb44fxCcMXWNBzoYBars+aGvKQQx9ndjzGLBaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wr57Cdf0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so5298010a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744167596; x=1744772396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDnY8xqQc3Ju7LJRgkAguxpsVQYNNALs2cNJRrOL2UA=;
        b=wr57Cdf0Z1E7RR2evY5LupUztqThS8ACLF5JH/JNBi2RC5JLfwPzgxL5tJ4Een/xRz
         Z18UJ0eB7eDxbCJGEs0yDM74frnrSZ2RfChfFED2v5X3OpeMxxLQLDqLdB4+EEef9y0q
         w9ZFoTRxwtapxNlZ++1CEVqB7deJIPCfuM4KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744167596; x=1744772396;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDnY8xqQc3Ju7LJRgkAguxpsVQYNNALs2cNJRrOL2UA=;
        b=N1mzQYtpD7daM8P2ViI+yQihZ+ARyziOYLVGENiFQIfoGuoHcRdOnpAIpRoykr2u/g
         SxIlYmCtCMJVURTrZ1BWm+feSlYTSexr4ejS/KBOtKKKzZiFtUQT+QQA49/av9VzIPVt
         CH4IRez2gjWzogXzMkD2WHsg4nzIi88/m4X4v3+Joelb505pRSQCchyNc0xE/m5cZKuc
         huVxZKMC3ymdZKhkqQWudf5SebmE7I/2QcR2HL5BE/ytEEmBxs3uRTUFqrNUY4PKn9Q7
         HIxLXPHoj2C79HvafO5sukKFMndnMWB2dIJNIWazNAfFYpuqa5SSQa8z7FLgEXyyx7gU
         Dgsw==
X-Forwarded-Encrypted: i=1; AJvYcCXtFAFiFHQQeUun3Wo5KO6FW1NW97yTZwU/tTaw77cg+wg4q1h8rVTWOx732fgvIi+Vj+F9Sr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17ZcJvLJ3bzAObL3/U5yo2t6w8ZYS7Jv99Nmz+5DorBMra+kv
	sTBCAugv9VJqxF0x0qe1FMMBN0l9OLvvcTiJppMnJpk1Mm1wmhSbpmTpwVfewcI=
X-Gm-Gg: ASbGncs8ZeRhG5hN5xw680A0WkdQTWJQz56BarZLpxhNNwUE6soCIf2prWUW2iw/r2N
	racRwrPRSBp1TDZnHNNp6BmyB9eCjUphTCibGCRaDt728vwiApHHapBLSWlwAvvJ6MrzMeB9WpE
	xsbr1HIYRfuncGanWJnlTVheUuXSbBVHQM155rY42omvMdw6z3f+PVE6i6MyHST941Uy3O0V0mq
	iR/W/D0p6p1Sf7viDfZSED2r7ETnUXrjBvStdZha+gzSIGjw8xsv5LeEKFSTiAVSB1TcedN7IWI
	EVsQoV0I9FN5tXm6QeJIsyMWXJs0kPWMRgYPeUFQxRA2hDub7qfJL7jcEchslPf7XmtLe6t5Cji
	RvxmUFCGIJdePldRDsGEF/krPhdE=
X-Google-Smtp-Source: AGHT+IFIS3MUKIejKO9w2187ZUm64bs2tFh4zENyoXQgJHDfZKbPM0dEXg3Soqa6SZECmp41MB+gZg==
X-Received: by 2002:a05:6a00:2e0f:b0:736:eb7e:df39 with SMTP id d2e1a72fcca58-73bae55140fmr1790126b3a.24.1744167596388;
        Tue, 08 Apr 2025 19:59:56 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d2d36sm175105a12.37.2025.04.08.19.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:59:55 -0700 (PDT)
Date: Tue, 8 Apr 2025 19:59:53 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
Message-ID: <Z_XiqYPIp2ak0sik@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250408195956.412733-1-kuba@kernel.org>
 <20250408195956.412733-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408195956.412733-8-kuba@kernel.org>

On Tue, Apr 08, 2025 at 12:59:54PM -0700, Jakub Kicinski wrote:
> Explicitly list all the ops structs and what locking they provide.
> Use "ops locked" as a term for drivers which have ops called under
> the instance lock.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - an exception -> exceptions
> v1: https://lore.kernel.org/20250407190117.16528-8-kuba@kernel.org
> ---
>  Documentation/networking/netdevices.rst | 54 +++++++++++++++++++------
>  1 file changed, 42 insertions(+), 12 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

