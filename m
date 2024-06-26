Return-Path: <netdev+bounces-106953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF891842B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6886FB26462
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900A18754A;
	Wed, 26 Jun 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz1KbViq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C57187547
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412099; cv=none; b=TPKqf2LYbcz6zyTTfs0r2n1HN/E5lK9sMPvJ0PSNMT/y3+ph0TEh2J+nAi2TdfTTgRPkZPGumPEY8LdgojgqTGCZLnZkBX4KtVRFjMUpubCCOAvdGjV3eWE/YHVyWzBBA3Ebv2tFrb5GiLL5Vc2vUdjDiAXUNBreer2mk4qLISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412099; c=relaxed/simple;
	bh=NYSvpH13LV0r2OONznx86S7xrvHx+oibMpsGX+sOzYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlXSWpDTCe/77Tt/4PC7GMz04gyDdIQLrJ7nVnPir/7Ly6fDzX/LId5jxeaJCi62U2p5qjBSNnLsAzQb01mtxFZTqLkqtKXTdxYxadgGpS0kG4cR8ZQvOYI0amtIkoe8vv8rhCH3IkAKs3rg9fz6f/qaQVoAsRe4s55cDXSsSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz1KbViq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NYSvpH13LV0r2OONznx86S7xrvHx+oibMpsGX+sOzYI=;
	b=Dz1KbViq9uEKoH8aSunI6MBUYQod2tCLXA3aRtMIBudyNu70QuoyUgR/o/akjHTGQHX5XF
	xS+ltMg6NJAne8/5T0Pvw4HNKGAidVqCRntIHvzTptPMSQnx5Y3f+7x/y5FDzk16+ITge5
	Mj4ims1ayI0TqdD6Vyik+nEumfyOyso=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-x4jvNhcSOJ2e8k7J9VerJQ-1; Wed, 26 Jun 2024 10:28:14 -0400
X-MC-Unique: x4jvNhcSOJ2e8k7J9VerJQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a727d1e7e9aso106627866b.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412094; x=1720016894;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYSvpH13LV0r2OONznx86S7xrvHx+oibMpsGX+sOzYI=;
        b=JdnWhoFwuSYGZTrvJMAyRoTOWoMZrWbZ6rzEvK4MxjFxCtNQkfD3LTWzCrUjVdAGVl
         tUcDP4oXteWLX9D/9jCmUa/2PwNXXMKo9ZFK/cYiK1HLMOzK2qmws7SogVRIGnItWbZL
         kr8xqjaLQKmyWaXO98SCvTNptVARojONzMyZCHqXlY7opRk6+Q6aSPHMZOMk3WxbeXUs
         Tyau7iYSHtG32sCIeA+DJQUENLIHx6DMXNKyXQqlGL9HkfZH18Kyio7jGAdhpZUcSb33
         YwtQJjh1au4rgcE8Z639aq5uc3HMhJSnn/+ZClfKBFCpdiHwmLG90HEipkJSYoMnLSIN
         Rizg==
X-Gm-Message-State: AOJu0YxEmrdopckU/JDdnICC4PftTDz/W1ZeGX3V2UOMGzo4hPD4t/H9
	9HYKbha4LR+WnNZaO4SuciTQsA8C+SJ2irfdE+eeFb+Oap4y5UtlZJJNCWAeZ0IQ6FaiE5YGNVu
	1UYSDLVtWvx3aaBRefUJvXXkbNB5VJbc4m5oawJ3T+oynJj0pvrFMkg==
X-Received: by 2002:a17:907:d303:b0:a72:7736:9e03 with SMTP id a640c23a62f3a-a727736aac0mr425936566b.52.1719412093781;
        Wed, 26 Jun 2024 07:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmV1TpazIQFGMovVoqeNpU68OOwy06oabzZ41ccRnAAgm8yJJ5ATd4NSBJj5cE3s+8/2DuZw==
X-Received: by 2002:a17:907:d303:b0:a72:7736:9e03 with SMTP id a640c23a62f3a-a727736aac0mr425934166b.52.1719412093503;
        Wed, 26 Jun 2024 07:28:13 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:13 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/10] net: psample: allow using rate as
 probability
Date: Wed, 26 Jun 2024 16:28:12 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <BB7EF7B1-1237-4EA9-AD05-C36563A3BCA3@redhat.com>
In-Reply-To: <20240625205204.3199050-5-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-5-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
>
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
>
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
>
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
>
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


