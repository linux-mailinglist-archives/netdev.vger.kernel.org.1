Return-Path: <netdev+bounces-239523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D8C69335
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFA368531
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352003148A7;
	Tue, 18 Nov 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH0w9LnT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ksV9mjgr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979E2BDC09
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466404; cv=none; b=uYxufD+gqSjvDsl6G/dI/RBPyvuMW9ApIrmFSam6EhMmvqPx+2MKHRxKXS1u8Vka0b6Lc+XcFbapJLZvHCx/18VGeHjVJt9t9/6gmqpyzURB9K7BzJQ7eihf3VG7emwZDgSOQsAdCNW7qIZLJWbrjFi/Owr7wvvwefcgJb0dmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466404; c=relaxed/simple;
	bh=3tdQzlCbe0Y1DhaDg1LZSbowfoTXLvkluyB2GTOUvI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDmnZX2sBq6CkJveef90Gx5k9WAs5WQme2LSHazRwjy2BJpc3GS66x18mMTi8GVeQpkVflqsppsxlodSrO3rz6yPMIS+qu9mXzHFW4JTs2o2MGAqJkVYqqhkNZLoWtnJQOIsveXZzDbcljizyh4sKn3L3Jzh+P5kpLtmNT/v2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH0w9LnT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ksV9mjgr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763466401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G50nyUS6RKtYR6MLsNJYK4QZ6bz7S7uMs82ckDdodyw=;
	b=WH0w9LnT2nFmIyUIE3lYQ7KHRzK75RrITspaM1K3/63hLIylTpnnciyda3Zo9R4U//zerB
	khF2cE+sWoOKsN5SeNV+X4D2LsP7r9O9AGkL3cBLBoxHg1+UQtI0xnUQ1WFmoR5OvAT0JM
	BrmtwIwcCSsbA28w6tKs3muZExmPZ/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-FH_b8Vq_NR2dEC_3YedPWQ-1; Tue, 18 Nov 2025 06:46:40 -0500
X-MC-Unique: FH_b8Vq_NR2dEC_3YedPWQ-1
X-Mimecast-MFC-AGG-ID: FH_b8Vq_NR2dEC_3YedPWQ_1763466399
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779393221aso7094645e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763466399; x=1764071199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G50nyUS6RKtYR6MLsNJYK4QZ6bz7S7uMs82ckDdodyw=;
        b=ksV9mjgro1LBGlPmSzmGo86o4KtL/94/ilVas49hVsX4Ta89qEx+e0ixLhD2/WShDR
         ckX+bUodj9cfW7TExGhAT3uLlmcZRaUxb+Umwn/5QEjnFJtUdw2WSjfZuI4gj1TedahY
         zu6bZ65iWmOWPXxMIWbMHu52jzrJ9sbK4WPkNDvI4Mmzf5ymdjpOyvH32NLsr/3rwBLp
         oX3SYyxAPar5SXz1IpNB9BYfnSDtNwCWpOhfRvBSZpyOnRVL5K0IgE1tS4Qgg5W5dM8V
         GKMxR0WNmNGEu0YO+xGMx0PB+UzY2XzOa6CeicM1jxea33miCj1l0czXyNsIQHGOhsjM
         k5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763466399; x=1764071199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G50nyUS6RKtYR6MLsNJYK4QZ6bz7S7uMs82ckDdodyw=;
        b=N82kC3dgaRDQEMvAvxQ4SXTJOfoYY4/2ihmlmzEVKQm79Al0/y4aPyBMy9Z/d1xRnr
         v50VxUjR1wnvlg2l30iTDr41dKMr6i3dTCX7bz78y4pRRvsY+ToIM4S7J7GauwQWBhae
         XsMg7xcx2EasGMIC0ySTJxUmIBldId64hOSK7T3tFGEO0byJoZeCQTN1cHiPM4sarYm+
         5VVdNpjpj7niAQDhcdVaMQkZc4vxmjWg2mrVGkbmsf1LrdacGpamKpH4lUGc2V27pw6P
         W09ZS06SA4RvbY1H0Yyp4xAx5jw2e1HwpH7BwD1VRh42m7wu8XgOWPXZ1BCxJCUCHQVV
         FNUQ==
X-Gm-Message-State: AOJu0Yz3CzoJpVNuaAtF61ksaTZ5QOLvcpk0ZRPSlwMx0b8a1Y/3Nj9G
	kdNR39/f+4ofSQg1wJygtgUlX6dsw9j5/DRcJ5ecxeC10IivHi8Kq1le9DiG+SxKK6UfWCGdRZk
	EPy0eV2RPZMq27aDONwziupJWw12pofIi0r2GCKJirUbN1yJE3yPDry6cHQ==
X-Gm-Gg: ASbGncsDSb4bb4B+J07saXSAYlEjMR6wJqeS3pPGVl6JuSPa6pAWv5oJJdYA+wor51r
	nm+rka+R/Ha1asASZjUlocgSBWSsaYlOOwg+q+glco6tYQWxTA1ZSdvuGDZhWW9T5n1mnfpSqBt
	xX9SLB4xmWkCjM/STZx0B+e5h2DjuXEJeuBYQJhpff2KVY2xnCInaRRcBL4DynLTLerExuamHbJ
	i2KZ8YlV7BeH9FChvX8urn5L968Xi5gQ8nvdiB0CMJAUjb1r1f3L1+NUL23rFdkD1qsG1w5w6WW
	3nQPULUGnnbj4RNJyoO/9XUT7dR/MfJkHlRN0YnA9SI7epZRwrgUsoyhfUANH29/KvJ4A7GtPJr
	55Wgmy/ZCYXRJ
X-Received: by 2002:a05:600c:3b12:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-4778febd327mr129228395e9.36.1763466398698;
        Tue, 18 Nov 2025 03:46:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuf9QXTTEdA8gMcfFBDPoA6vL2L3+p/2KXiQoIKGU1o5Q+h8ztlweTgXipAxyEIVY8MRihPg==
X-Received: by 2002:a05:600c:3b12:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-4778febd327mr129228085e9.36.1763466398265;
        Tue, 18 Nov 2025 03:46:38 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779525d2bcsm216280495e9.5.2025.11.18.03.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 03:46:37 -0800 (PST)
Message-ID: <c6fa0160-aac6-4fc4-b252-7151a0cb91d3@redhat.com>
Date: Tue, 18 Nov 2025 12:46:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] team: Move team device type change at the end of
 team_port_add
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, jiri@resnulli.us,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
References: <20251112003444.2465-1-zlatistiv@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251112003444.2465-1-zlatistiv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 1:34 AM, Nikola Z. Ivanov wrote:
> @@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  		}
>  	}
>  
> +	err = team_dev_type_check_change(dev, port_dev);
> +	if (err)
> +		goto err_set_dev_type;

Please don't add unneeded new labels, instead reuse the exiting
`err_set_slave_promisc`.

Thanks,

Paolo


