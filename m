Return-Path: <netdev+bounces-137811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6989A9E6B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C3A1F21592
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51D1991C2;
	Tue, 22 Oct 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BupHsRmK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DE1991B5
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589019; cv=none; b=QiXv2IxUAj0GVGurXFxmtlhYwdBXi6OPxsTcAg9nFL8WJVWtpEdu+QRHPc9AejzVsxJRiBiRKpTvSLiEhfk0APRka0CL3wZnMKfT6ZnOw5cgVKOIyiobPyfT6E2klpiIf6xgcWnvAoN7sfRn6VMZlR0lBU7aE/LoeDIlabVCnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589019; c=relaxed/simple;
	bh=BwvEDWO2ONrOGKBDpF/Y9LOF59H0FbsJzedCitZn2iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrKFbH/XEBpwVIVXQjNBpymRmXiqewQzRXa9nQ0KI4i6qY8uERsItUdXdOBuDaiUKzxmm3LpbEllle4bPxnwZuDi+RAh9xqvIqpi2IJ7RlX/znHB1Np3y76r1SN3yQdbBoJ7Z0hJWsmGmuGUr7VnRM/VALyocT3JgBihaPL/Q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BupHsRmK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729589016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwaG/c5R9PyY0LVwY5/sfl7H0UKEAwsoDPRTXGHqXbk=;
	b=BupHsRmKnb1iupyi8QPsUTHvzOR/4ubko1awq/QnmEaaHwOH4S42eeCHGLqBXMFo8HlytW
	OFX2gUjs/hipyUcYufnLXjpNYVTKgcz5I24odDL3uSXUFdchl2r9BGij75VGIWFO3JrGwb
	+4GzELSTHf45Fjy7JgEcq2hdvKrDYeA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-zNOEOpF1Mfuu5d58PEkMpA-1; Tue, 22 Oct 2024 05:23:34 -0400
X-MC-Unique: zNOEOpF1Mfuu5d58PEkMpA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so2844811f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589014; x=1730193814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwaG/c5R9PyY0LVwY5/sfl7H0UKEAwsoDPRTXGHqXbk=;
        b=RBSepUfZNTZBHgsM+QWUd5JBgbGpH9dqQMgPTUPPqm0LcFjKoxIbhaq1qQY1pjh3k3
         hnLN4u+gswEIXUwM9ZWjk8s03lY2oh1JTeiK8W2xL9RJiQ7xu25TEz3o1lEzg8ZI9lSA
         VzBaC7fVHa/X0KPoIItR0DMOrLORinx17Z+FyksFK+nvrahD5GAliZcWo6k60SxrXhOg
         a+fo9lgYaVrJuXiaA90bqrNaXoJ+NV9G5ArphKWwOIW4CIsFo1AcaD8zlHyFR5hMdGuc
         Mkt9n45i2yKfJwdF5vUQkpr3BvPHG5xNHq/hrQ0QgoI1LGp6nudnM0JDEEXXa4nZFNKS
         o9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWzOrr3UYtx4c7wPOPpJ9ZSKt1XlSEMlzdRy7nd+d6112ULKN9ufSPu+UNKAfea3YzFqzZ4Lag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOIl0fE+hbVyEnTcE967a3ymePWMiLFhbyy8bmL0SwV2ZhOw0
	qYyD3VKPUjuHP0bY9XhBBlKPLMfh8t3bGr6+nNBF479ZQN8aShmHjUT70Xag/N/fiwZJlzaidHx
	4SWEBmHw0yxJ4cC6Iy36lHHWcj6NcoR92EjGwzWhq2IzNp5/JjXsbZQ==
X-Received: by 2002:a5d:58d2:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37ea21370eamr9413743f8f.9.1729589013600;
        Tue, 22 Oct 2024 02:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGABcPaq8PgmpfrgbIv7V6Y5QW9A/aP7VQTgUwLfJqvVEOm2uyGhoErcFVMPcfpZBwcFX8SYQ==
X-Received: by 2002:a5d:58d2:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37ea21370eamr9413732f8f.9.1729589013212;
        Tue, 22 Oct 2024 02:23:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b076sm6176529f8f.90.2024.10.22.02.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:23:32 -0700 (PDT)
Message-ID: <e5aefe89-ef71-4e50-ab3a-ac0e72b99fa7@redhat.com>
Date: Tue, 22 Oct 2024 11:23:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
 <ZxdpicVgg8F3beow@shell.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZxdpicVgg8F3beow@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 10:59, Russell King (Oracle) wrote:
> I see patchwork has failed again. It claims this series does not have a
> cover letter, but it does, and lore has it:
> 
> https://lore.kernel.org/all/ZxD6cVFajwBlC9eN@shell.armlinux.org.uk/
> 
> vs
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/E1t1P3X-000EJx-ES@rmk-PC.armlinux.org.uk/
> 
> I guess the kernel.org infrastructure has failed in some way to deliver
> the cover message to patchwork.

Thanks for the head-up!

I can't investigate the issue any deeper than you, lacking permissions
on the relevant hosts, but I verified that the merged script fetch the
cover letter correctly, so no need to repost just for that.

Cheers,

Paolo


