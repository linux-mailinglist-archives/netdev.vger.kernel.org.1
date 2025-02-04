Return-Path: <netdev+bounces-162580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFBA27479
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4EF3A3E73
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BCF213259;
	Tue,  4 Feb 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCTzaLNp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B221323B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679685; cv=none; b=PnHP+8IBhoprNEUcmq0zRcoevm5B9kIVKHx8dBWPSa3eHIFMecgV5YzcuzJIFojY9j0OP01vX5QToxn1uTxM8zwLhyQMN6syKCkOmvG/GgykzJWbdQoKEm4BWnQWdWzWZTGkfmcw/r2BYxu/6VPkbZ3HUkpbPH9LcfH/eExUvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679685; c=relaxed/simple;
	bh=e+mk6Go6YBOyUdQc2Du/FlFuwBxNIMX2W0mbHPlPEpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvFI7bylCgNEiuuRXHmiby5SR+CDIQ5S3rAOYKuniincmuRHMig6FI5hcI7jLmyjLHe7467jRiuK7KMF67QIiosKM+IP3cF72lNR1t1mBox49aEm+cxY5AXbpDSD6sLUUet5ZFtFDNGFhuNmmy026h9O+P3Aq2K1ujd7tVj+nsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCTzaLNp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738679682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/sznZPYCGxBgx5ZYncrrXMOgkTcbfYSYYoc1loZOiU=;
	b=gCTzaLNpqDTRZ5dMTl8iw81cgnXtXlVu6HOPtIMcD+fQTjyOGCr/FlFHOziGosMCx51nH+
	ey2+Jh7vIEPCM6oJngUY5uAxvx9IAaZLsKACCsmuGl+Hhugab2S5jc3607TVaHpBfUKmuF
	O/5zKlwnIkRgZKGptkkPrgNL0gk7r3E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-6YRqY2MPP1SQUSsUj2PDXQ-1; Tue, 04 Feb 2025 09:34:40 -0500
X-MC-Unique: 6YRqY2MPP1SQUSsUj2PDXQ-1
X-Mimecast-MFC-AGG-ID: 6YRqY2MPP1SQUSsUj2PDXQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so29652505e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 06:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738679679; x=1739284479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/sznZPYCGxBgx5ZYncrrXMOgkTcbfYSYYoc1loZOiU=;
        b=FAHwlAtqTwZlHqCYKjh4oSgvXhPDBjPQf/E8n1sj/g7uMr5msUIx4C6eG8UcBxslmN
         FBE7MRFHxC5Hs2IyvNUkpQ3fPUu07NNFwOy9NrREfxn+XOTdCAWXQTg6YHyvf95Rm4Ca
         hGJzJqUaIkP4wTxMNMqvlnb9nqx34eYZ+bITY4JromSTgqoEFSmnAaOLNNZkdHcrXDzG
         8O/ZGsuM2J5hmMo92UXT7qdte5r2NJ2lldXJLNHcb2zylkI+3qZ0rq1sF2JO7t8Ksb7B
         bo7tUkIKU4lVlh5yCq+V5i+G5w7hHrmCN80N/N81s9JZ4kSoP1IgukRbaH5y6wdtYNFY
         pdUw==
X-Gm-Message-State: AOJu0YzHmRmSJzSOfe57oi91pXdqEypHKdEdsAkln9z2aqSt46w2/qgG
	dtevylphzGnvPanqNwbgdMCJVRXWhgVxX3S0NmFikUHyAEVJQarsYxZ6neaV6JlK6jlbQgrYvwc
	+QqR6YMagU8RCUb3DEbRvLrF6MDExfY6bxodz5DGrlRJ3g2rYBF9BgQ==
X-Gm-Gg: ASbGncsJDF6p9KZZ54NE986JVhf56QZQzilQKdMA0KxCAWSMiH4Vuzs1gOtTvPaIGRd
	nlQaauSktZVYrq0MqqB8CSjztJDjnlmBSVLOYAnR0KaOiV5D4huMGThOSJyB7n6P5430Q9co4Mh
	Q5ozKKVkGXUgI3YyqVtPtvq/CLNAuXEvIkRJuHNUfnRBweDnsnfL5CtmZ3KwKhuez3fud8s36d4
	UWotHGqIKzbpdSu2D1SQzil4RJBolQnTKmxkO6iUbPgMX6fXr4kBpOl56xC/koyJ97RHkJnGY61
	YoOUv46YrJfjB5yiSSjlpIDzX1BOHyqnCNI=
X-Received: by 2002:a05:600c:1f10:b0:434:feb1:adae with SMTP id 5b1f17b1804b1-438dc3ae88amr220885255e9.3.1738679679462;
        Tue, 04 Feb 2025 06:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKACEzL8lGYAK5Sah9vAMaiK3BXB9bavSsTbKa3lm2NJJhDe7ER6aVQEmUsE4VcxvW2Cnh5Q==
X-Received: by 2002:a05:600c:1f10:b0:434:feb1:adae with SMTP id 5b1f17b1804b1-438dc3ae88amr220884965e9.3.1738679679100;
        Tue, 04 Feb 2025 06:34:39 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11fadbsm15720723f8f.44.2025.02.04.06.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 06:34:38 -0800 (PST)
Message-ID: <aa464cc9-7259-4745-bc9a-45b34cf66a60@redhat.com>
Date: Tue, 4 Feb 2025 15:34:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] rxrpc: Fix the rxrpc_connection attend queue
 handling
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
References: <716751b5-6907-4fbb-bb07-0223f5761299@redhat.com>
 <20250203110307.7265-1-dhowells@redhat.com>
 <20250203110307.7265-3-dhowells@redhat.com>
 <549953.1738678165@warthog.procyon.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <549953.1738678165@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 3:09 PM, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> A couple of minor nits: I think this deserves a 'Fixes' tag,
> 
> Fixes: f2cce89a074e ("rxrpc: Implement a mechanism to send an event notification to a connection")
> 
>> and possibly split into separate patches to address the reported problems
>> individually.
> 
> I can do that if you really want.

I guess we are all better off without the need for a repost. I'm
applying it as-is.

/P


