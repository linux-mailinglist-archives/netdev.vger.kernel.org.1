Return-Path: <netdev+bounces-207861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2940EB08D1C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B171C228CA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB82C1588;
	Thu, 17 Jul 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGaKIKve"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845822BD005
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755898; cv=none; b=FM0Q5l01O3JTT1A+tbWiUTb63cmBKyVr2OGyNIP7HyoCbiNdiR61V+O4MAkZOynFmPrTsnMcjGbUbMR+DhlfmVhkShslaAl3/cLlD0MLMdbsPvMcYoa1a5Ov/Gfvn5OEDheM0ybJnOJtFMoIac2yXmgtT0lh+E+Z+X7AUO62jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755898; c=relaxed/simple;
	bh=N3UgBmXMJ82HmWUgVZJoB81u9rw5HUAhpMTxqxV4OLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEEmjsJJDQ1WxT5fSkB+xzOj7mLHVJscYxEfAYEYF8UKARxgp8nbVRMusRVkHEav24/z66oTvNbGwMZu5CCgMMgqJ+JLdrC0c0jFOxIS95Wz5zRVLErjcQ2EUTG/ZLQWFnH+LFwhva+HvpClqUBjBETu1sQgppAmqlDcUuzLT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGaKIKve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIQorcRmryvxVCzpJ5J62xkHuGe+oWK34LGznXnYv6E=;
	b=GGaKIKvefKjGqMDir4vCLF6h/LwFkFEFiGThlWxlnS+NoGQ78Nk7lIzZweStl+svgwdVhH
	Nv5wh/m773Vk0071YKR4mBYANpe8jHC9TK5Id2oPHwEv+Urz1EOorUyQRiKzW88pB2X/y0
	FH6e+1j/4CI1CR4A/5GNc6p2gwGHDzA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-oxhy_AwtOiaUBZoPMIjSBA-1; Thu, 17 Jul 2025 08:38:13 -0400
X-MC-Unique: oxhy_AwtOiaUBZoPMIjSBA-1
X-Mimecast-MFC-AGG-ID: oxhy_AwtOiaUBZoPMIjSBA_1752755892
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so4453975e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 05:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755892; x=1753360692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIQorcRmryvxVCzpJ5J62xkHuGe+oWK34LGznXnYv6E=;
        b=mmjnvh5g3RNUfl1fm8oIE3qyL2BYerQrasGYvpcAsEAcI2ED3ZXv+6JEp3cuH/EoxA
         HcVOJtJypI7VBPRvYbca0fh5XVkkmn2qXJES1JMqsQ85ifajN2cwSrJuMcXY/uhDR3k4
         gtAQpvXZ2/5a++ILQPUzFRoX488toNH2acYq3LOY96uFL6tCIPcMFot3xKAXShXTYPSq
         HtpOnXnmbTmOHjCTnbK/fDuJI+QU/Ek4l63slycOUVbTQl5o+z2tWpgCL8MrW6qLcedz
         fycYdtEAf+fGtgTsu/Ch7tLjhamp5smiahUtKix4VR+itRo9E314AHOl4t+meEKEbsot
         Nhtw==
X-Forwarded-Encrypted: i=1; AJvYcCXfqlv0XgGdzJWXnVOndfOb8HUd1UCJGyWxEZavMVKqufPOY7Q/Iua2XJoi/XJQzNvN3IABu98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUW4AIPbqnbmNLjMwBFXUa93Twsh11Ri0N6Zne32JZHz0n2Nbp
	2fMt5vHTQqEzFcMIdPQ8QCIiaGOkGm/BoYKXNa4pWpZOcyAXcoIxdx1EbbgMXnmU8KZwyuY8Z+k
	5Nz7MvEjTJTtss5GQYCpb2n8yus1Eyd8CWv4LW7xa5bNWqoJklnz+nKoC4Q==
X-Gm-Gg: ASbGncs8YD1UM+QjfHMQPnV+sNUqP7kvEmxTmSiiaAe4l/XotN9QDoNSw+j4iGoE3mv
	bUA5VUyXU/LfwerWxHk6dRyOgIqqT+z2EkKE45MZNtiOl4Ag4HOO0MrjUD9wQ4qgRWsoxzJeUex
	F+5S0EEqAcujwgzy2r2CTv7+JnR2dwOW7ZrUqf1tPlEwPgBzg9X8fFUBQlOqF2JdYMVphdfUrT2
	egHGGeqkhB1SPTts+PkYbreMxnKMOJ0/Ja4LF+IxcH6+/QdOL62MiILI/9Nixula1BddGZaM9XZ
	NaBFYWwYr1k8niJYDRGkNsHoR5xaFMNNi8Dy37mKbuZPZYN1u2nQLbkMntJgS0fLqBuUmT1ecVQ
	D4U6RbmfZHLw=
X-Received: by 2002:a05:600c:3b11:b0:456:11db:2f0f with SMTP id 5b1f17b1804b1-4563532c395mr25752605e9.16.1752755892255;
        Thu, 17 Jul 2025 05:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCYvQxFSEXEQ1G0sQev9OTHxjbK7UpkTBTpCyZ5G8y/kfOQnfprc297mGkFHriICQL9Vbg+g==
X-Received: by 2002:a05:600c:3b11:b0:456:11db:2f0f with SMTP id 5b1f17b1804b1-4563532c395mr25752335e9.16.1752755891844;
        Thu, 17 Jul 2025 05:38:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e68sm49942235e9.1.2025.07.17.05.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:38:11 -0700 (PDT)
Message-ID: <33ce1182-00fa-4255-b51c-d4dc927071bc@redhat.com>
Date: Thu, 17 Jul 2025 14:38:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2 0/7] Netfilter fixes for net
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
References: <20250717095808.41725-1-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250717095808.41725-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 11:58 AM, Pablo Neira Ayuso wrote:
> v2: Include conntrack fix in cover letter.
> 
> -o-
> 
> Hi,
> 
> The following batch contains Netfilter fixes for net:
> 
> 1) Three patches to enhance conntrack selftests for resize and clash
>    resolution, from Florian Westphal.

The first run of the newly introduced conntrack_clash.sh test failed on
nipa:

# timeout set to 1800
# selftests: net/netfilter: conntrack_clash.sh
# got 128 of 128 replies
# timed out while waiting for reply from thread
# got 127 of 128 replies
# FAIL: did not receive expected number of replies for 10.0.1.99:22111
# FAIL: clash resolution test for 10.0.1.99:22111 on attempt 2
# got 128 of 128 replies
# timed out while waiting for reply from thread
# got 0 of 128 replies
# FAIL: did not receive expected number of replies for 127.0.0.1:9001
# FAIL: clash resolution test for 127.0.0.1:9001 on attempt 2
# SKIP: Clash resolution did not trigger
not ok 1 selftests: net/netfilter: conntrack_clash.sh # exit=1

I think the above should not block the PR, but please have a look.

Thanks,

Paolo


