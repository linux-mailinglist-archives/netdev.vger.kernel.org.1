Return-Path: <netdev+bounces-237589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F0C4D802
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E153B1E48
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411C35770B;
	Tue, 11 Nov 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNz8XH0A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBYaVrfk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A2350A3F
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861576; cv=none; b=cBJLxzj5b4zTEnvBOZ6MPUQg94gofmigoqskgVQ228V6tTKFNKQtoBiqQnehGuxEFvjJrmf8xRdylFUAnsdAYrWaf/baCwhuXZp5UoigwHV31FTtSusQ0Yd6vFEEhTGruZ+PELKsHSLNrTqVKFZkj53/dF/Ltk7yoF5mEfz2Ix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861576; c=relaxed/simple;
	bh=ms3RSg/noIjsyA8oAmHE+F2zUwrJzf14af2/m8iMuRg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uRhI4opO7ynrVrox5PHXRFa2pNQHoSHmvTjtwfw7ZasTNojbPaj5Blut5Tq+HSnT4/vv2Or24Nxi1xi752UupkWm7UcpglB5ZvYkdJXJN1EVdoPM+KA8pm4NuZ/XYJkvHNFyCN7nGluGpbmf//6uDep8whP+Yslx5SzB8znLUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNz8XH0A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBYaVrfk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762861574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahehZ2ApA53mtBnHWumcjmErxgQ2sCVFE4tfaIMoMwE=;
	b=NNz8XH0AympX2Hnah8IS3X191SWoeSvFhE2T1w9hI4zDs2CMHgStizqTlzgL9s/DLdN2zc
	kQTnU/TcdsP2NLtetCWbNcaeAvW53amgY5QXlriX7/k4xtIjnViaY3ykpRmHGz35yd3B7U
	jiDZe9mugIc8IlyLNm2vx09POn2rLfs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-9cQLZHyBMl2Wgrf15YGR1w-1; Tue, 11 Nov 2025 06:46:12 -0500
X-MC-Unique: 9cQLZHyBMl2Wgrf15YGR1w-1
X-Mimecast-MFC-AGG-ID: 9cQLZHyBMl2Wgrf15YGR1w_1762861571
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b352355a1so329519f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 03:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762861571; x=1763466371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ahehZ2ApA53mtBnHWumcjmErxgQ2sCVFE4tfaIMoMwE=;
        b=BBYaVrfk5ySz27dTgnVnq+T6l28J9DGtJwRGNT6uqjmVE7MLQU3OLNbhno5CUWZb2u
         tSePfbbzYT7JyB7V4Ci7PizDanoY1aHnVE2GdNm+qyz3OeEA3nmPsdU+/Lbu9CQK1Z5y
         SxjIEdXZ1rSvm61yVwjLhnub69NQ7j6u/ZIdgZ5YX/L3bjLBTCRaK0VZX6EQ48rD9YRL
         n9rCU9Yn0jmtw9JohAaSXVcDuBMuyy8GmUfh3AuR9vpfFtzaX9rzkdluXjfYZn3SZTQH
         zjb+r9+6i/cMTBXBDxNTTv1WXtQQHTlxUeV4jr4JHF3eiRtU8Dr1lS1v/drsSuAOPn3R
         a31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861571; x=1763466371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahehZ2ApA53mtBnHWumcjmErxgQ2sCVFE4tfaIMoMwE=;
        b=ZgHVcBftJ43PkFF/1srVi42eHMHRNp6Xax0c0vSRo7DhOxjZQYP1OrWlucBAnEH6UX
         6iVbT87iKmc52x5i5pIPH+c1RTsJLUfQ3oVGaeSnYL9VwjgBLE5ly0uttKCyUA5wmLP1
         NudeYAEEJyR+g/EykdH851xBdWkA/TbJJc5AMHCokRi7LSAzkeRzvv1WFklei2btX2xh
         V5nYbiz5l5mQlgnI2Gnrkia8OSREP1ODLitgm1312J1zLkO1Hj64XmFexp3gl3+4/JxZ
         o+xdupMolAOMzIFHNLua7LMAkF2YK+WmTfaqZ9smNqpIojfMf9MCxJCGbFRRiBCeGHmu
         LG5A==
X-Gm-Message-State: AOJu0YwvmH753pxjeNe0hA2OBdBnO5ec8yEt8lmtTLYDtf6Jv/UGgfpz
	VvMELXsCPQQNta24Eaigww4TitQfAqLnVP35UEgTvhe0/QFjJzpIH7D0AkqyFKxCMmzmHymx8WH
	4bKSMvn711pxsTOQ89+z+kbBs7M3hQssECn2FjfPw+JrW5Xac/7XcL0UIuA==
X-Gm-Gg: ASbGnct+JPnmVCmocQwWAyW5vzlpA3h88jFGDYdB6ic84HNx4r1KVcCyOjzuoUCUnlw
	iZ2M07bQ2UpxOss8vr2rJ8UtupglrKAZqV7Lyh0A6iIJ3O3Sm15PanAmzMBdYSTHXvs0eUAi3QH
	Ip7AJaODu0lUYX9uSlAJgK8/UzkT7YRpoFyNjRDZHQknHHZ6mmkJdDO711b7iDYZ9kkwzSkIg0t
	vK4BZ6S4vbkFRDfQCiEPJh2ktpKOWVunQACsRRQKU62F7XL0rGz2Z/OBwxRMfpjpML0zh/MwV6D
	3TAy0SK0E1F+XLLa/AUN1LtetD8ckZUWLdaOvv6USs8XV8CE4GHdapODTs3MgDyPEyDwB+bSOxP
	YCg==
X-Received: by 2002:a5d:5550:0:b0:42b:47ef:1d7a with SMTP id ffacd0b85a97d-42b47ef203fmr744904f8f.20.1762861571323;
        Tue, 11 Nov 2025 03:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyqVLnDuF3LVtyIz/X8GkBlPs6v4NB9pPryojZkgF5MSvGjr6/u2n7BcBiKmsK3T2KXjxHLA==
X-Received: by 2002:a5d:5550:0:b0:42b:47ef:1d7a with SMTP id ffacd0b85a97d-42b47ef203fmr744887f8f.20.1762861570895;
        Tue, 11 Nov 2025 03:46:10 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b3123036bsm19473054f8f.28.2025.11.11.03.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 03:46:10 -0800 (PST)
Message-ID: <1455f577-1dc5-436b-8a08-38a74fa17975@redhat.com>
Date: Tue, 11 Nov 2025 12:46:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] tools: ynltool: create skeleton for the C
 command
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 donald.hunter@gmail.com
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com
References: <20251107162227.980672-1-kuba@kernel.org>
 <20251107162227.980672-2-kuba@kernel.org>
 <1ebaa0e4-8d7d-4340-b1de-4cb1dcf60311@redhat.com>
Content-Language: en-US
In-Reply-To: <1ebaa0e4-8d7d-4340-b1de-4cb1dcf60311@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:15 PM, Paolo Abeni wrote:
> On 11/7/25 5:22 PM, Jakub Kicinski wrote:
>> +install: $(YNLTOOL)
>> +	install -m 0755 $(YNLTOOL) $(DESTDIR)$(bindir)/$(YNLTOOL)
> 
> Minor nit: $(INSTALL) above?
> 
> Also possibly using/including scripts/Makefile.include could avoid some
> code duplication? (or at least make the V=1 option effective)/

All very minor. I think it's better to follow-up (if agreed) than to repost.

/P


