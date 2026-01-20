Return-Path: <netdev+bounces-251358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE6D3BEE7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 06:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1A6E4EE9E7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED835E538;
	Tue, 20 Jan 2026 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3IEwoyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AE258CD0
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888302; cv=none; b=FR8iHSHYFDW7OaYVigDH8gmCwJFPIVLnCjuR1B66YiwCWNKg0/nIKTLdfAhtjzoBg5qy++Jo8sGH1FQJrI4M+fMWPqb2q2i0o2uQAPbT0NCOaRztNQ6Mvu/pmakKzY+EKSbFW064HsaJg8TzMF6UwxK4FR3YBdNKHIbuGiG9JP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888302; c=relaxed/simple;
	bh=zjNwbIGBZUFd8+/HEHCrDCVd3nuCfY5LWsSOsX+6qXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ2aXwq2pghqcp2umTFMW9AUyiaqzbhk5U5c7bA5LoxrDefC/Q85KyRXN1m7/aHG5eoyafj2DDhBy66xZCLUABHW1az3fTBSFeF+4m7yFnY63ed0vCB5C3k7cI/o751K1e1f37Y7LaEuJqasEYJHIObCOMRSCquEGIyrTWfwgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3IEwoyn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso2305721b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768888300; x=1769493100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjNwbIGBZUFd8+/HEHCrDCVd3nuCfY5LWsSOsX+6qXQ=;
        b=A3IEwoyn8DD8pFl1pMLibT/Rs4n8WnhD3zl7RxDwku7vj4lO2Vhoa6dnPKvqqvCpCs
         8SGoXusaBlzn4ssprJnA2xS2vbXisoJ/yfeafh6jLq6HlR5hU2kSK576hkP/ZqHaLpm4
         Ba/L7Fx0r0etTDOGHmRgrQ9Nw3nhPPrMpIhBTUoJatwFdG0RgSDAInjbGG79uD8W3Z0e
         gXSgFWJOLUUR9Szi2ReBmEfgNWnJM/r69HiXGyyqnKb/2DpKyqw1lH3uf7Z+PBJ1Q2Ia
         Do/y8IhDRAKfgdfhKtMPl3EHgRuLT8IJmGfIrzAMIq8Q5zVpu4HuBY1T86kdYVuTPTAh
         CSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768888300; x=1769493100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjNwbIGBZUFd8+/HEHCrDCVd3nuCfY5LWsSOsX+6qXQ=;
        b=rpis3caOU6FLDb8rDakuOfuOO3cRkcjwC4DrejR6/3laC4Bu/gbaZmgTFRaGyYbjUI
         7NOPw9jzzTi90Zt9SbCyeDm+HbhKGbNPwfoR460pzpWaIcsjzIq7txk3YzYs4VLYzB2o
         +JZ+Dh/pZn0Uohd0h7OstlNp5ZJKSCHlo1Dv+aTmDs8aPENU4cIftXS298loMQM++RAn
         pkVSbe7+g3LK/wFTwtuxKKka7XZxWcTjwzX5naT9npMHkcnC5DVtJ8vkBKAIbtQeQBpL
         VGm6430FtTSku5YnngJarZgMCoCqxNzQkKN85z6gpx0QyOcsNCGHnyJX0HN5px4ZY+q4
         fXtw==
X-Gm-Message-State: AOJu0YyX0wmDsh+OuN+B61/iU77dlcf0sLRvpnQqGulpft1GAItMyfhP
	5Mvmz0X3takXJhQFeMcfAVhXljdIHy3UEHTpvGCyd841iuDsGTv0CGKQ
X-Gm-Gg: AY/fxX6jpCLC1PNOLRnLOL+HuTIOH3DrdN0K3ay5q1+dekt/svBIPjTHv1ASL1THsAR
	+JvAhzRICP8mTusH1hpVml0gtq4n+SHCI8qEpbBDtMEvYKHnOq1vTG5KDq60Ho5d1dbcYaNQ8fJ
	rAOphCKeNHzuffZVAOO29dNGsRedIN3rTO4XjBB2gfrPEK8FhplY8PMJbVj4madfc0EJN5dGhKW
	iuynPw3FBZPfz5RT3lkRXRre2WrZcgf4gpcpc4GdI4rvn/WAm0YQ8+tk+Jim1LT953vSekhBPsh
	vS7r+k6lO1LuSqsr6j7SuFqMAd02QV87lGZ0MRb8IxZSem5vCTtVlaFBs2KK2bSH6L7Hwrf3Meh
	Rr7TOpHbSUubSpD3+O89Ow7p+DowJsweT9lXnP2u7g/i9crzRdjgzjjtK5sS8w7JF8plLNZlbFU
	cMS/DdybuHAdYqNbk=
X-Received: by 2002:a05:6a00:1311:b0:81f:521c:b645 with SMTP id d2e1a72fcca58-81fa186243fmr12972958b3a.51.1768888299943;
        Mon, 19 Jan 2026 21:51:39 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12784c3sm10829338b3a.36.2026.01.19.21.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 21:51:39 -0800 (PST)
Date: Tue, 20 Jan 2026 05:51:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
Message-ID: <aW8X4xm99aWK-W1J@fedora>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <20260114064921.57686-3-liuhangbin@gmail.com>
 <20260119122203.5113b16f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119122203.5113b16f@kernel.org>

On Mon, Jan 19, 2026 at 12:22:03PM -0800, Jakub Kicinski wrote:
> BTW please make sure to CC Nik (based on the Fixes tag I think).
> Always run get_maintainers on the patches.

Thanks, I will keep this in mind.

Hangbin

