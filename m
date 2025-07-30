Return-Path: <netdev+bounces-210990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA5B160D2
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8877B10AF
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B6298994;
	Wed, 30 Jul 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN41PW32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FA25D535
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880188; cv=none; b=TMtKnVDaalw2Ky0NcqkbFjz8X2UxDMxoPrzuSwQ0BqjkjYV6EgigOVdM7p+plX+6DR5xwfLVaAlF090QrawHJtDCKzAkwWtem2/mFqYx8BqQ6lTEkIXxTu9OcdYvd0kjf57L7ALRgFlDn3ALgjspyfX9xPHpUBvpRAQCMAxEy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880188; c=relaxed/simple;
	bh=zSAAqvx7+WVkof8WJaGgdy/lkwAiHLJS0efBtUvDVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT8lXZLlDBhT51dky8Iq5rMZid8uaSRZdKDgXJETow0BGbNW+PZFhHacHOB/s5ttfe/4W3iVhChbmh4uvL4FsokJpfNW7DRjJ9RBBaqGC6dCaiolXwm8D0kxb8OMKYPvya+9/fc51TEIENswrvqYXQNYbn/C3SvkxF3tTME2xIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN41PW32; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so2236942a91.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753880186; x=1754484986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYpiCOTMHHGqmnWdnrJ3RKxn0MKiEsCcDqKVDBHVDaw=;
        b=iN41PW32Hca2xFOmDc3Lm/t7wzmisJcAs13QR8SueShA6U3FARavYh0A7BEvkp1F1o
         SpHhtdT1YgbjYaAe1JOcAw0HGPM9s/+VI2076ixVg9DqkWP8dzHbtwA7bFHcfaJLoooA
         mvxYwDgV3VD0IFaaLqnYpF9RMeT3L2aM421IheaLCgVPl3toLIBVwlmokkBdwnWsHV4Z
         846eas3Rb37skwCjjwMF+EWLodYjYQrXAlG+REcPLnk/Qm5UYQQeGPfUiTVRcfFow1Z5
         gzWgcMIyva0L40iRwCKA+L/Baz4asX5GkfNBZnDLD6kRp4QOlCJDk0/ol6wRVIm6KFxI
         vxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880186; x=1754484986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYpiCOTMHHGqmnWdnrJ3RKxn0MKiEsCcDqKVDBHVDaw=;
        b=HcT72joZH6zTvuWVt0OVlSZWeuXF3lwrortDbMV8CerFjDeMCusPG83lS6MW0NP6iZ
         9h4IlkfFdgTHo2DJLgjrha890lN3RFPW7rPiCQ/OHExVLShR97MJfr3I6d+XvRwwU+Yn
         JjylKRreIzTcafdmUpArzvXNduIxQHWO8Ig3G3UEMfxcMykW2sHC1qNFbtShR+CJV32N
         hc3fO2v5MxSU9N8fiazdRHMHVKCiT71AUPSzfvaS5EA90E+ULwDMVdvmtZFoSZNs5v3u
         lTLZIFR3E4/a76aRuIbtO13mclT1VUDUqiDAbxktl1VCVoMwNDq2BoVbCDSEEqwgmD0C
         rqKA==
X-Forwarded-Encrypted: i=1; AJvYcCVS7PsEtjA6mQDvqsvCOj2AlzIKnuSj8TVwqnZSNG2b6a0d+Uu6f8NGRS49G3WowS29cl3LGPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnF43IDPKTfTnMbSeAOqlsKs4SivYLe0uIipDKd9vYP5IP97k
	pjKnETQBXd/zBvvjzYQ14IOFvqRQofSwFtNzjzckfsWccLBeltTG4Z2E
X-Gm-Gg: ASbGncuhwkSpGipaXkKMYf1WDTrfb0zZZ2gVn2AchGmf2NHKUW9WmfwluEOfg7+V7mr
	AEnsNocbcuOb5yTgqCfkfSLOR/IGN1jKuw91J7HXmyKDwGw3uYPQJ2s/FzstAffXMpkjnJfecFJ
	ceF2xBqUpyZeLlBPitjetaJwAqMnZa7ZTMTaWMoPYv/7UdMneweA1jmrvr+mSxiN2bhkpHepjNJ
	BiKGrjKOeTB0cRbzUo1BGgloqrZz0Mme/W5u9ahg/w9S8MRbcTDHycC8ivle5a+7WnbGAqGuTaZ
	Y7egHQ+ux9xQgO9wWNRTyJ1OQiIZvgIpE4900FouCqyc2OyLJqMHTPTwWVOa67S1vnkkYtKeRDm
	lSL8fbN3P/d9Pwq0jC7s8WsOwaNKoMI9r8kyYPw==
X-Google-Smtp-Source: AGHT+IE1r36xqjJz/GUA05gQwSoThWyW8cE+qNDxOeRVXm0nbbipl/uICAXRevTd5l498frzdpaiMw==
X-Received: by 2002:a17:90b:17d2:b0:31f:867:d6b4 with SMTP id 98e67ed59e1d1-31f5dd90e75mr4978063a91.10.1753880186485;
        Wed, 30 Jul 2025 05:56:26 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f67d30csm7558654a12.34.2025.07.30.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 05:56:26 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:56:19 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Dong Chenchen <dongchenchen2@huawei.com>
Subject: Re: [PATCH net] selftests: avoid using ifconfig
Message-ID: <aIoWcxoHfToKkjf4@fedora>
References: <20250730115313.3356036-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730115313.3356036-1-edumazet@google.com>

On Wed, Jul 30, 2025 at 11:53:13AM +0000, Eric Dumazet wrote:
> ifconfig is deprecated and not always present, use ip command instead.
> 
> Fixes: e0f3b3e5c77a ("selftests: Add test cases for vlan_filter modification during runtime")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Dong Chenchen <dongchenchen2@huawei.com>

Not sure if there is a way to replace the ifconfig in rtnetlink.sh.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

