Return-Path: <netdev+bounces-147717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3A9DB63B
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E737516490F
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13B194A74;
	Thu, 28 Nov 2024 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6GhhOoj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF2193079
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792065; cv=none; b=o7KbsUvlu1avwWYg22R/jV7pb/9A1LgbeDnaoyinazs5xx0w0OCQ/JpCF6If6elxqsYeIgyr6ef00oEMXmBUN4iMvSgLwngPbYwbcLzJn/5TL+4O9XyBJub1ydsOeZEqX4/3nLwZSoQBwxINDsfEjHAnx9qlkkiw3T9M7G0fWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792065; c=relaxed/simple;
	bh=dtEbl+eAxjNtqIHD/lA/11e457LY7bQDSZJVQdho3vc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UQEQw2zacLvWFkbcANN5S6EUt3oujn2hh25Rt6XJ920CZJUlqEKITLWQIz+FyUm/JGfSS0oE1xU2KJ1o/tIMP/hj4+m4P/WyMBih9mT73Gh2wDvHX8dVdc9w5EigLYwOrTQkqOH0JHa1KclxC1gbmn9nmkaqdXLJn4Po5qEfPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6GhhOoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732792062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YLK0mLTOGgTQPMKHKX0ABr1QZ2jKPpEqJQKsnJzJ90=;
	b=Q6GhhOojHt37Ha8CIwT7qIGJ9Wegin62EiM2KL4MsUUNON2G1LAQOQlVwTJXtq9I5gRciW
	rbnfkhlEC2PMNi+SKBfyQqN+tG9/1XxfPh7gjY4EQUFeqWwS+yWZY6DKVANLnI05ei5nYx
	BNyeQiO+25COEGzuwzb+diJEkMahpME=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-BJxV8pHPP2WCWCmoeNncJA-1; Thu, 28 Nov 2024 06:07:41 -0500
X-MC-Unique: BJxV8pHPP2WCWCmoeNncJA-1
X-Mimecast-MFC-AGG-ID: BJxV8pHPP2WCWCmoeNncJA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3825a721afaso435846f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 03:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792060; x=1733396860;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YLK0mLTOGgTQPMKHKX0ABr1QZ2jKPpEqJQKsnJzJ90=;
        b=sdRrmx0iZ6doTnagY2BwRoD7ekbKN6wmm9R/I1NUQ0oERc4I/xxBfrxW13vTLfDpS1
         74bHBIQ/72IwpNfbNtmWyAd0M5b+tL/DThZhwVYFSoR7mazii6sNPau7EqOlAOThEz/u
         chnLO1T9rmaWgQjYC4hNhgjAzRxJL/c52rWZ75Og7o+vRkZsBPMR+xz/4Wo/8Al5K24V
         GmssGDCEiqVxrZwBmV4w48E43qRAnGXXXBl5qRORmwinqWqFQizH+QDccCm+jc7bxxsS
         SsxPs8bFiK2CdlalVFmM6ecB4fpao7+9HgVyCTjs7asAAQglv9cBTmoInard52IIuAyf
         siEA==
X-Gm-Message-State: AOJu0Yx+p94ymfsHJkQapWvXkiIW9H1QMI/Wu3CfmGTNkW4h9vHICX/W
	hfuiriJmOq80cN8pkw5een/h4wrfcvb974nlBJLvtjZypIyTzsWsqTDVxQz6+4ZhBerj4FdAjX2
	Dr3g0PtA3XFmAVvphHPw1cQCT0d/eOqcEvWeW0WdvCE0T0ExlvbMQCQ==
X-Gm-Gg: ASbGncsQV5opz2AmWpgLhXI+cQEx44thCp8rBSp8MJi/poUMhUiLfwNh9dQs8r45BYn
	JMN1fRrDrI2OnKDzmZ/DqoTiPYubPfQbf+Xj4jwzzc/yljSdKOwOg5FBeTFufpQ5baJ33uZ27hJ
	0YgoO9mlLW5aU6lk9O7oJV9GpZ2WXvIA+4MgqlK1Mn+M7j5mVwLxCbc1yUFJHsQ5tAVAZ00lGzs
	cU8veFxdYfxlqmWSgpPAx/9sYCI/95k+eAJtujgooGTxjIpsbn+98qtzjohO6T4cvRP39zCFrj3
X-Received: by 2002:a5d:6d0b:0:b0:382:450c:25ee with SMTP id ffacd0b85a97d-385c6ed74c9mr5453033f8f.40.1732792059859;
        Thu, 28 Nov 2024 03:07:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeEhbHAnt7UDcnIN9QSU5mCAPewp86pSwIsK84xm7VJfZBGKBADTHurkaCfScNk20JP2YEcQ==
X-Received: by 2002:a5d:6d0b:0:b0:382:450c:25ee with SMTP id ffacd0b85a97d-385c6ed74c9mr5453014f8f.40.1732792059503;
        Thu, 28 Nov 2024 03:07:39 -0800 (PST)
Received: from [192.168.88.24] (146-241-35-20.dyn.eolo.it. [146.241.35.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2dba8sm1393832f8f.1.2024.11.28.03.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 03:07:39 -0800 (PST)
Message-ID: <d327579b-45de-478c-963d-fb3b093c2acb@redhat.com>
Date: Thu, 28 Nov 2024 12:07:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fix spelling mistake
From: Paolo Abeni <pabeni@redhat.com>
To: Vyshnav Ajith <puthen1977@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121221852.10754-1-puthen1977@gmail.com>
 <fc0bb8a7-8c6e-49db-83ba-f56616ebc580@redhat.com>
Content-Language: en-US
In-Reply-To: <fc0bb8a7-8c6e-49db-83ba-f56616ebc580@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 09:08, Paolo Abeni wrote:
> On 11/21/24 23:18, Vyshnav Ajith wrote:
>> Changed from reequires to require. A minute typo.
>>
>> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.13 has begun and net-next is closed for new drivers,
> features, code refactoring and optimizations. We are currently accepting
> bug fixes only.
> 
> Please repost when net-next reopens after Dec 2nd.
> 
> RFC patches sent for review only are welcome at any time.
> 
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

Uhm... let me reconsider the above statement. This could land in the
'net' tree as well. I'm applying it right now.

Thanks,

Paolo


