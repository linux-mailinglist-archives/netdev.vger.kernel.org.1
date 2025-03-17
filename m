Return-Path: <netdev+bounces-175445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D1FA65F36
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE487A65F8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B01BC07E;
	Mon, 17 Mar 2025 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpbtneaV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F37146588
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243674; cv=none; b=k9wjS9VV2o+gd14VrYEpJb3IWq3WDiUPMJF65VVdQL6LwofjOLWoE2uvRvNMDBgwnUPXxHjf84umEXs0YHvR2tT1G6RRLJ0QvT+CoSHDkhTpWYOOK+n92ylPevhb0y3DH/7+tVvCUfR+prRbbCAvhjUg8+68Tklasqna5ZoeLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243674; c=relaxed/simple;
	bh=oXwGMSMzgOqAjVguF9JsE+Bh3OdpwxZVyS4J8W7iJsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/HmjHg2pm51Alp+edNAG6yD0i7j+smShuuu4iWR3Tbxos+ezCY7hiM16al+YjjdCBaFJUC+EVKH79Yqbt7KaKUJhocZR2giUTQOQPlAsHtzs3xdnkl2Dej8lh/WSpyKv3bBGNvZBf5jcd/28n9V7nnGOYxleUfNedFqdystWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpbtneaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742243671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be+m8+WOPuEDPOjxk6T2O5N+1An96EeClwZ5PGpZN34=;
	b=JpbtneaVDCco+ssnXb8wSVEWuwSqKwgOEAgJSMxw/sLtQAYn8wvjJ1QKruok4/DJL3BLeK
	iZPxYd70MjLa4ZNUpUaj+ccVAOJ61kui75r9GvtUJ3FDA6mTYH3BBMptIN9OQuLiol0fKY
	azyl1Uovkrk4je0p+I4mcnAh/VaTmwM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-pzt9ParGOjK5z9OZscIfDg-1; Mon, 17 Mar 2025 16:34:30 -0400
X-MC-Unique: pzt9ParGOjK5z9OZscIfDg-1
X-Mimecast-MFC-AGG-ID: pzt9ParGOjK5z9OZscIfDg_1742243669
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391492acb59so3059462f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243669; x=1742848469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be+m8+WOPuEDPOjxk6T2O5N+1An96EeClwZ5PGpZN34=;
        b=qTyvNebDDJ3gUK8Vg2Y6bh5+7CQHtVSFJdoxF7EoJIbAlufiIUUedhYsKpLI9N2NmS
         YtSO6m66oaeJMeW/IJ9g4JLAxQXXLjYFaDEdGxRK5R9bPWsUQiGUhuhrb9wcR5ipKRcg
         nrKym1dkAbjMVtiVdVEwLEbouRtrYqhwWNIA4F4vjtVJ5kOX2Ic4qyit9wIwwUqWtKHz
         Z6bksv5O72SzL83wC/TGIOtDMClQ9vJbUGWJHrUWjFBmgZVhIPbOzXr7dYUWBUGDRRNE
         F8q65ZeVJFVJ4/1bbJwQLzeGsbHvr8Nx7QTZKjJdejis76hQG30iNgW5rewQcVNg5DbP
         46fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvFCLUPqW7IvzvcJH/9BYqhFe3EiLQcIM10TDn0pS3lO6epN2g8Oaw0b7G1+ZGPsSaSmcsgAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKirD8PHu1M3lysgK2fPpfy97onGvkcRx1r8gveHAfxQWxjiYR
	Hg6Helbb79dqOX9g+0UMglrHzeXyh+xClfS+TQe9W7Mrivxa7fkTjbVGl/xL4jckc0UYAZ01ryz
	Vh8D7pleoZwOdCE802GhJ4DCA9jfKVSktCrydrbpBwxIGYdeTlX3mVw==
X-Gm-Gg: ASbGncs5zUjQEyzIGjY8vF18poUszTHAdkhetOeDFrxsAPw9AmX337ww5upOzqWacWL
	as+DaxU/M4kyz/pQRg8lrZVlyaxDJBsAkQ1QKMcKo8vMunUjA8F0vew8UQa5h2DDQe+E/2Z1dSv
	VbOw6zarf6c6TBFoIfl0bAVNNVTg2lq31OFQkQnNjPLAkQLn+C6AhNKJBOE/5l3v1zvw4v9bm4T
	hGlvaPSuVTgtETmUz0RJT5e5SYAvPwALfFAWivzplYQ33D0uboL6t+D8i0rU5q0boMLq6jMaK6f
	Q4TGY5L01hrmGfnPBjjn8vSoMG17NISfNaJrSoxuiPHR7w==
X-Received: by 2002:a5d:5f8f:0:b0:391:37e0:d40f with SMTP id ffacd0b85a97d-3971d237dd4mr11307639f8f.17.1742243669312;
        Mon, 17 Mar 2025 13:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxEfR0n9grx2beojtM/iScHwTGCBD3F8wtb70BAlYyWIxmSC6fEqAY7CKzL0p1YPz6UW1K1A==
X-Received: by 2002:a5d:5f8f:0:b0:391:37e0:d40f with SMTP id ffacd0b85a97d-3971d237dd4mr11307624f8f.17.1742243668902;
        Mon, 17 Mar 2025 13:34:28 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad64sm114260775e9.25.2025.03.17.13.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 13:34:28 -0700 (PDT)
Message-ID: <8176af6a-07b0-4f57-848e-6d161fe58746@redhat.com>
Date: Mon, 17 Mar 2025 21:34:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: stmmac: avoid unnecessary work in
 stmmac_release()/stmmac_dvr_remove()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org
References: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
 <Z9KTixM7_vc_GFe-@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z9KTixM7_vc_GFe-@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 9:12 AM, Russell King (Oracle) wrote:
> On Mon, Mar 10, 2025 at 12:31:32PM +0000, Russell King (Oracle) wrote:
>> Hi,
>>
>> This small series is a subset of a RFC I sent earlier. These two
>> patches remove code that is unnecessary and/or wrong in these paths.
>> Details in each commit.
>>
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
>>  1 file changed, 5 deletions(-)
> 
> Hi Jakub,
> 
> Why is this series showing in patchwork, but not being subjected to
> any nipabot tests?
> 
> There's also "net: phylink: expand on .pcs_config() method
> documentation" which isn't being subjected to nipabot tests.

We had an outage in the nipa infra that caused no test running for a
while. At least it entered later CI runs.

Cheers,

Paolo


