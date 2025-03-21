Return-Path: <netdev+bounces-176748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF585A6BF09
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796AB3B8D42
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF822A1FA;
	Fri, 21 Mar 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqYVSEqj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2A1DE4C2
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573117; cv=none; b=SmuCObfGoU8MzcjqwgPt13OrBbFtwOXIP+0vArlkY16wCG+8H6aBDgWw5Q8bEb2S5Ce2UsJDTij7sr2FY7SNHUj1xf+FgIV7FkGrAxaiM8hAOzQsb2yGebeTyOpOPKMFv9xjqtkI6dSF1x8Bk+EP911cmOmtExpW2T3aRR0M+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573117; c=relaxed/simple;
	bh=jwkfakE1DANkUqJuTwsNFFdjoRqqoxIpJ6eThYSheqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9bLWd+tMOHK1BsaGSMSCloqlqKN7jGoWZQHI5AOZ6VlIGAsUh729G2GeQ5yW4kfR6Px/4aguj5t5YHSfTVJi1HeElrZt+pbhfaG+sUdC2FL7FST5MYSh8tUDT72au5WJ537KRUeQ55PH9kb7YDdDUkM71Ync8izTbesVpNwI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqYVSEqj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQs45VA5fWWnDDs/npKdUUvsMmoPlZhByWdxbH6ndSA=;
	b=MqYVSEqjcxKVoNbA52gqLb0fqsgI6POUIqXa8/sRVVVLDATJuFOGFvghhcu+aRsM06v/kb
	iMzSJea+cYsBr100Hp/opvUfOM1QKtl7DG6/24AZk+CcVC+EHSx0FjKJigrG2y1TOFb/yv
	D8rcNzkS/Yn5xqVIH5eu52qERcmvJns=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Qte9no2tPIC9HVI6l-JzCw-1; Fri, 21 Mar 2025 12:05:13 -0400
X-MC-Unique: Qte9no2tPIC9HVI6l-JzCw-1
X-Mimecast-MFC-AGG-ID: Qte9no2tPIC9HVI6l-JzCw_1742573112
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32a30so888640f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573112; x=1743177912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQs45VA5fWWnDDs/npKdUUvsMmoPlZhByWdxbH6ndSA=;
        b=ouOEaQmW1B1fG1TsNkQP6AFOFCNa9w09xFFFCuMM+EXbSNTrFLvgQpS/WnYRSZC59n
         V5n9PlyFsbp9LoqBC8rXHOVg8YWFumIbKhomb5cMUAHgXPs7VfMLlm/Apdv7q4nkgCIC
         MARhKBQNTZipDVmj9rfTFr+RhVvLTe1d3Oq1005ERygncPvZqC2knCgdx4ZyoMHo3f6D
         nWj2Atqhx00x6QiFzAoh+LfU08Mc/b8P3pzPUTOpJZe5bcp+Bt5I6E5/O0rW1EimBm04
         8tFtlSu1FiYOwxkieyVRO7p9MBQEohY7QDHXwTmhjkWkRK0Wda/qIPrkEqm0WWc1Gg+n
         /+hw==
X-Gm-Message-State: AOJu0YxzjXXqs4tJzG8X03HBcSYDppOxTznFbFHAFGec9Uxw+XKYdX/g
	3D21Zga/yaq2JsXjLLVSJf+CGOauxeHHSMgIvYbGG4+Q5HumAlzb+YPNh1/65SHJzG9MuLhLmfB
	zZoAR8MLK8MuWKB+NM2srcLCURbcNEt7cN+dAiuZQeQcUyy3PKc2M1w==
X-Gm-Gg: ASbGncv4v0KIDBurYSjMdNsEeizhMY94vZ8yrAl+w8Lt35RWCP/fmKA357Xp+gtuaNT
	lCiO0v1BbmJmE3saKGlG4FdlcJEkyf+RPF89Kbhvrqg0iVy97lD3gMY1v35QjYdZpPydjbyXbMC
	n4yPfcBnwgMms6Is/qrKgbmo5at/5ABQ3sTCGxNrCrf5FI1+IzapGlqsYcElMtRexpgVxVPWLZ7
	Ioc0FBkH9RQ9eVZDMIlzgEMeeBtW9Qru6CNjFrv0gEhtDNyhm8n+0zbNwKIfjBbAR7teqwdLesk
	5xgkp9vKjTk0SDDcy3m/7+xU8KEuv4JYjBSBvFzu3dggsA==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3997f9336fdmr2910931f8f.42.1742573110944;
        Fri, 21 Mar 2025 09:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv3TecOdXmFWBmFPlb9ypBRevwbrid5djH7Ctu3Ye4XmZRGvPpKB+zPMx70FJNmpZ1uxRAAg==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3997f9336fdmr2910895f8f.42.1742573110537;
        Fri, 21 Mar 2025 09:05:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4d9sm81992925e9.33.2025.03.21.09.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:05:10 -0700 (PDT)
Message-ID: <08d9509a-3291-4856-8129-1e440df10b29@redhat.com>
Date: Fri, 21 Mar 2025 17:05:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Add dedicated entries for
 phy_link_topology
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>
References: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 4:30 PM, Maxime Chevallier wrote:
> The infrastructure to handle multi-phy devices is fairly standalone.
> Add myself as maintainer for that part as well as the netlink uAPI
> that exposes it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I'd like to have Jakub on-board here. He should be back soonish, so
let's keep this patch around a little more

Note that MAINTAINER changes go via the 'net' tree.

/P


