Return-Path: <netdev+bounces-207820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F8B08A62
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648D117DEEA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556D28A715;
	Thu, 17 Jul 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ccc4Jyze"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB87235C17
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747462; cv=none; b=kWJUyBdGgpzq/9EqvUBXJVPw4xKzrbKILa8w/GPS0Brt3l8a0ngsaoYghGWXjOe1Jc91+6ZrVAdQ+ay7EXIVwugJwHKeBqE9AhgAs/rvvnkELAXNJl4YLjycbenP6Ew/nBW6PHhYmAMrLhCV5OVs6zOpbd9/4Re1Mkho2M7y/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747462; c=relaxed/simple;
	bh=NBt8jkLPn4GumDkHjCWKpe0G2W6zlI3FqivQA32cb7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GugCTPwOR9nOYwyo0IqU43PXPoKwD68xNFIv3ruOIKBv2xIjMIMJoE6pXk8cKjpIQhGvSOSQXxw/ceIJt6DPoTZMIts5MQWZ1YccLSscnB4k7LKl91zDl1gCG/KwW0pKjMKgpDlO6gPcM41hVnOc0WgAwzB9cmtV338T9KpPE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ccc4Jyze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752747460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA83DHVfeNFVTjWP8lzcP6NpqW8OSKmbcKpzsEz/UVw=;
	b=Ccc4JyzeCZYv1xkRP/axQEd5dddE1h4z9TxLSRurvro1nT9J5K8LQiHLPBsdnQFzt12Jmv
	Iaiqoul+du/PFj+QWHsGdAccg1MorF14mR3fNXgVGQGsYrfCdwUCLVJRzLH8LlqvBY+r9G
	SfzJ/QTh4SXzNPGvMP+5anrZd5USpnI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-JWd80PGMNNKzwevFC3Ek-w-1; Thu, 17 Jul 2025 06:17:38 -0400
X-MC-Unique: JWd80PGMNNKzwevFC3Ek-w-1
X-Mimecast-MFC-AGG-ID: JWd80PGMNNKzwevFC3Ek-w_1752747457
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so470115f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 03:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752747457; x=1753352257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA83DHVfeNFVTjWP8lzcP6NpqW8OSKmbcKpzsEz/UVw=;
        b=j9V/Bi22Dmh9b7ytm5pnnyYKzWQ6cKnCERvKDvnaBOSYvwUQcx97UHUkX7k+LK6/aH
         z/K96FgHW6/GV7OSyp79rKX0Wc76Ni2u9HYdPV1qQ6E5Op8c2EHt98BJc7xl7GIXECgH
         MwpQwI29FMIObBurc++zrzT7lgAzYa9jcsq3d9jz6gbEjUBEeUfoy1fLBTMoifguZk7d
         mupTQpqtJnaN0ch08zPP8rnMSPv8ec2UdrnBfi4BB5rvsyJ4eB8WQHu7JGlkBIq14kIg
         A0GPNTOoCyDUcRwNE4OYt8d0c2uH9Ll7FwE8hD+DidNiUnwBuvfGwJiiCnRPMb/ezYu3
         jr2w==
X-Forwarded-Encrypted: i=1; AJvYcCUsPhU7yp8QTrVXkfoDQLAKGuUCTaN8FrxgfThxTf7D9AiqXjisk+u6AWO97t8Tg2huv5etWag=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTuIRpa2Wt5fu2zHGOAIyDPNpxmR619inpnfcnm72rSMRuxyH
	gOR2DBHvaUmGFZDEgToRBQtGr4WDXc5ZjU/mvWy1/hmUqyqwgfOW0+xpA0/ZxslKrgF7ENnTgPU
	NelnzV4vxqUEpSFjZziZ2pmX34DzvdoQ8z4YLPPobjhvI5ChyO7nVwLzbhw==
X-Gm-Gg: ASbGncu8UI0SxIp3MYqoCSoLnM76pWaq1JXeRvQsGbkEADDBzcIqO2Q8g3OsCOBgwZe
	JGB+zX27gYHswkFcn7rzGkN4pcQdJBHsEwkeYx+Qv0k3S7Xpg+nhYbwNlCAzQxR3tOhU0XNhoz8
	I1giyIefSpWVVyXJRE43FmWKHiBNmYJsZ25qr7yTmr6wKPeU9/Xu1Ux/CmdRZ4XfU1EXZLaQ8TJ
	PuLycW02JAcVVOsCnGQ3zdN00vp7kgyqmM4h4Sh44hf5cu3UXJ+nHvMjkY4/2UduhFer+UPKDpM
	JDlqI4YymQi+vBn2u7T4epwiOMjHkZ62wp+0qQ1/gjd/cq8iHAgbfNBx+4lGfAt1hSQaAJ58CrF
	BPoa+sSfxlq4=
X-Received: by 2002:a05:6000:2dc3:b0:3b6:d6c:efb6 with SMTP id ffacd0b85a97d-3b6139c9ff4mr2311895f8f.2.1752747456988;
        Thu, 17 Jul 2025 03:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ4nb+S2fBLt8jwcH+8MZT/7FPHYdOWtKr0hVaFs8ec14pMlJS9OgTkny4GDrN/HFFLoToFw==
X-Received: by 2002:a05:6000:2dc3:b0:3b6:d6c:efb6 with SMTP id ffacd0b85a97d-3b6139c9ff4mr2311876f8f.2.1752747456571;
        Thu, 17 Jul 2025 03:17:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm19831179f8f.8.2025.07.17.03.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:17:36 -0700 (PDT)
Message-ID: <7d445ce0-bf96-441d-8fd9-2ed6b0206b4f@redhat.com>
Date: Thu, 17 Jul 2025 12:17:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2025-07-16
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250716195124.414683-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250716195124.414683-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 9:51 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93e477:
> 
>   Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-16
> 
> for you to fetch changes up to c76d958c3a42de72b3ec1813b5a5fd4206f9f350:
> 
>   Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU (2025-07-16 15:38:31 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci_sync: fix connectable extended advertising when using static random address
>  - hci_core: fix typos in macros
>  - hci_core: add missing braces when using macro parameters
>  - hci_core: replace 'quirks' integer by 'quirk_flags' bitmap
>  - SMP: If an unallowed command is received consider it a failure
>  - SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
>  - L2CAP: Fix null-ptr-deref in l2cap_sock_resume_cb()
>  - L2CAP: Fix attempting to adjust outgoing MTU

This has issue with fixes tag, the hash looks wrong:

Fixes tag: Fixes: d5c2d5e0f1d3 ("Bluetooth: L2CAP: Fix L2CAP MTU
negotiation")
	Has these problem(s):
		- Target SHA1 does not exist

Could you please adjust that and send a pull v2?

Thanks,

Paolo


