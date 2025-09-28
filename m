Return-Path: <netdev+bounces-227027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84248BA73F5
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599FE7A923F
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBF225403;
	Sun, 28 Sep 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4VmBkvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63B17597
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759073177; cv=none; b=WT4ikGGGRhZp6mi2JnikGik4bP+YAvPeAUjsf7poewml1YayGFEGuWFbNu+DU5BzIvJJAgRSpBCrvX+Y7cZthwNY9lGLu07emDeYygRu0gPuYt9CNJitaNOITvJLnPo9PsHVGwilBscHA1zqS1cuNirHJwIigjg+SXvNOEA2rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759073177; c=relaxed/simple;
	bh=1ERQlFtiwev+93nGlX8WZAk0e2Z6jhL93QCIb0AGxZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDgs/2EBGUh2qfP9gDM9cgD6G6FoTJZQB9eVCBD2oRmv3o+eboZ4MfGpVbPVCouhzU0VHKDV6WTKypZ346rxT0W8W8o52TsdF0mr75MFZqCzaawHfkPG1X4D/+Fs5qRMD9JtEjnIYlsHJT1NI3T7XwTqpgdmZqEsDmAMXfz7j+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4VmBkvu; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9000129f2bcso2863921241.2
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759073175; x=1759677975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5Alc4NB13gwKBoLXrQZ51wQV0kYW03eZU88Bc/twqo=;
        b=R4VmBkvuKK6VI/c9tGoDe7zFR1GMnYW6wjVO1CF4PYhUIeL67qj70mgu+kiRrwn6hL
         B8H5ToL1Yn6/61fEnV3kbsDC5YyxPQf6wR8ooUretCPS72w/B9WY8pnNm2vBoJrgQl+L
         cM1QCkfHpcAQoKoi9qeW3GzouywUyRXLWjkDfB2UK69Oe8wp9YSLPO+/LFubzbVd2gvT
         VvA2qJdRRmwsNzwkbQ3JtFdFccIWRR684d3/+UsYm/0Gcxk/eYqCTcgpwDEwiU4d7Kyr
         hjg6lM2/AkgW6XL7E/E6y6lTbmjZubzoWgTFl88or5UMv1gSOHtxtmwtD2s6OxlGFCrN
         00WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759073175; x=1759677975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5Alc4NB13gwKBoLXrQZ51wQV0kYW03eZU88Bc/twqo=;
        b=MjAzwAaAVXrXKh0GoeS1izbDm7sijpgSWzC2Fy5EbOnK0n+cpoymQh0thwRDN9rZil
         Lbw5V8RYFNF6w/TdFVhLXrAa2dzncEZdFP9L0bQHTnyAREaDHvZrUgkC4j6wkNrYLfVz
         wglOCEX2C7l6ZtiADehlOAJI8X8wnsGC8wYzGD8CBAGU0/r3GPe8OzB7tyxjNuy+g/aV
         dkp7if58lHQAfkMO5qJOlbTvlIRLOiHLQC6/FhhxdmCrnD8Y0dG5/biy2Fo9Q0d1pr2R
         aKtupRgoJKZNkjvKMZzhQ+a4q0ZP4TVFf13U62rrQYnwFNCLlAeFlnmn0IgpDw1wwE2P
         IwCQ==
X-Gm-Message-State: AOJu0Yz38joGwzyC6tYvE95P0cOYsetz8Jw23IYaVuOGFIi252L5gMFV
	EPgBKMOGq62Vwpc+vETeBB9UFRC/ttaUYjaWZmKo8A56fnr9vWpGXqodvxF17Q==
X-Gm-Gg: ASbGncsNE2hnmF0ZaiEgdSqMQgErbBtIwy836RUGjBLtaX6lS6xogkcyjTcCeHJYK4u
	/RU2L0h9KMUfZwz9PddfF7SSweO6DD/YFgF5QHNn96fUDUNtB3iXWol06mjUO++gsX7cvw6ovg6
	AYiUjG2AfBg2pIa/WXZxpTHDITCwcHO9XEv4/VqeT9/gNouMnAxj3r5zRketuyrXCDUh6oPOPo1
	qfhgDNsQB/FiAV1amryBeAyHQyLVB5wYQeMcruN9esLn1OqYdnlnszqLHaOfKSFYsz68topIhjp
	HrfBPD4S8knEaAjH0WTTa0TFjHNHklRnjanb1jnvd2iCZ566proH2uPe1D/kB88KrmspTZYYV2C
	NxVnBu5k1ocmU9sl3heG9q38llFRIZXqxoGjVDOPk6SwxzMC5DQ==
X-Google-Smtp-Source: AGHT+IGjMAamUm1kSVRaAVKwnIW0mikD0OoWVZOWVPr5K6MrIi8U/5ZZFDgThH3u0kobgv3zD5x7Mg==
X-Received: by 2002:a05:6102:94f:b0:523:4360:2b86 with SMTP id ada2fe7eead31-5acd046d79bmr5906381137.31.1759073175125;
        Sun, 28 Sep 2025 08:26:15 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54beddbb84bsm2008261e0c.21.2025.09.28.08.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 08:26:14 -0700 (PDT)
Message-ID: <03cfb82c-5502-4c0f-aaa9-05c4d1a4ae80@gmail.com>
Date: Sun, 28 Sep 2025 11:26:11 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 pwn9uin@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
References: <20250925204028.232320-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20250925204028.232320-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 16:40, Deepak Sharma wrote:

> 
> Do a `timer_delete` before returning from the `alloc_mpc` failure
> 

Was this code tested?


