Return-Path: <netdev+bounces-167525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73C5A3AACD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963E216C21E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD01C6FFD;
	Tue, 18 Feb 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J0+Uc841"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5193286286
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913858; cv=none; b=iNLdn6GymvBP7MqB6aLEN9wKmIzX8dp0hq2J0Ts9l5ACqlACCfsddzb4F0+sudKVobCJMjm5VvXRkMsF0EYSo9ailMv+2FFcJ2VwFi20mzPw1sczl3GGWsj32F3t9u4rFDzIcwuLZ/Hivd2fId1QJuKybv6rEOw2sDqIpQHuUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913858; c=relaxed/simple;
	bh=lMr6IN5R2TMFC7ZVVwcYIe0ieLHkNhi18W4Z40fVI9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2tiDw0sHr3DwFnqpzP6X0p6ghGsI/mAvbsLbOaLI7TF03g244vFToqniaH7Pa08Zlrt55vI5GxnZP7z+MGaf3/SyAhc6yZgxZz3axWaPAXG6/nLDJAkrsVjbKD0W6hD2giYqPSG5IfZRT6BdDaiYXyHV50aJJqoy64kEzXlyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J0+Uc841; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0a974d433so21435385a.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739913855; x=1740518655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PDON++W7Wapo3Nh9QN3aZ3p5upKwyXuDJoXQTbsi+0=;
        b=J0+Uc841SAH8Gyobuco9kd3kblmGKAUF6DFVuFFGHhEyRhadUplo9MRzf6BhBunPlR
         jjXmwbpkr7BrVydTnzhkjXS313DgSDjXk2yn1v4h1bpJoA2xDwibI9dGYLj6wxE7Fkxg
         qvbIkf5kyg7XCO3S21iqYp31MWHpfWWyANACM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913855; x=1740518655;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PDON++W7Wapo3Nh9QN3aZ3p5upKwyXuDJoXQTbsi+0=;
        b=MH8NjdoyNmeEFCFjC4grTWhEvkZObBXqoNioh5oIQoNUI/+LcBqJqA2liPMErGLX4m
         fDLmwlIayKaYhfm/SrM0xZUlMu4tFq7QZOM2zUxQIDLupvdTqshUq/VvPLKDQ/D6QW0D
         bStf+GkA9jWSYYe7AnPuNefOTPIsgLvPlRSb2apclNOl88klJ3Xm+67elBVRubsRhe2l
         68iCQQb+0iQSfDGH8GvFsmL1w4AsRMQDvHixKjQvIT8lj7ZicsJuB6rNXeY0jF9E4C3Q
         nSp48iHFY25mYIxK5nRqg5La+9T5031pqfRzTmiz8EfnWqsc0J2/AqWqwltpCNoTZJX3
         bSSg==
X-Forwarded-Encrypted: i=1; AJvYcCWQzgRBYZNgUGJ1NYPF3uy/GPjArPTsO0Ux5AcN9FLt3sZCpnQJNIZqtrVlQpqrib/L6O0Xt8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfCk2PUEO3mPqnVr6+TO5LBMZ715IK5nVQwEfLW4sD1B4FOgP+
	ClHMYEYTwqkERBEb1v0Of3PenLErGclEnNB908PDehAPT3/nZFheomuLSCZrhgM=
X-Gm-Gg: ASbGncuunGdAtcMMDaTf63a+yjOL8kiMjkuHKVSet0CRAGE77OxxtLiQMfUiGaqDbmH
	Cu6CohHhau7PWngaw1H8QU6Zu+fE6r3lYTXKIZ6aH/o7mWoR5CLZtRhFEXQJw7EMMhEXzohDyK4
	j/o6Ak/XlWBrMUxxeGV6/7VwoBOtwgAkHhxyNfiKVXSAm2+mPuYz+8caZVmZ8tCzr9EEDEqoshV
	iEq5TSSsJG5z00X9Mx8dHr9dMr9BQvcu6rK5yD87DFA0ouv3OQH+3xRHECDhQE+EDVoRY7Fp5W8
	B9+d6g7O9YKlPB7LizYgOktbAwjTPFi/XdkS3an2CjOi65fKVUp7hQ==
X-Google-Smtp-Source: AGHT+IExoY6cFoJOKm//AZzMPPIlOabCPetqMyNf1Qh9RDD+WiWYghuYkpZ3MGKOyyA1Gf8u8SSOrA==
X-Received: by 2002:a05:620a:1a05:b0:7c0:b350:820 with SMTP id af79cd13be357-7c0b4cdd3edmr194297985a.5.1739913854751;
        Tue, 18 Feb 2025 13:24:14 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09b2ece04sm305608385a.50.2025.02.18.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:24:14 -0800 (PST)
Date: Tue, 18 Feb 2025 16:24:12 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 1/4] selftests: drv-net: use cfg.rpath() in
 netlink xsk attr test
Message-ID: <Z7T6fK9Y4jo1Eclk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-2-kuba@kernel.org>

On Tue, Feb 18, 2025 at 11:50:45AM -0800, Jakub Kicinski wrote:
> The cfg.rpath() helper was been recently added to make formatting
> paths for helper binaries easier.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/queues.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

