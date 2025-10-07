Return-Path: <netdev+bounces-228070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CCBC0BF8
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDA9188C545
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C672D47F6;
	Tue,  7 Oct 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD0lMbSc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73E2D3A7B
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826513; cv=none; b=XVap4RTCCpioTpSksEvtp4foNONhl6jG8x2aw/3Lt/4scMrJzKzawu91hOqrlH7Hvm2BqlTEdi6uY/4u3ghvUDdON9g6LX9zeaAIiADA+qJS5+MZG1CYBqljCqykv1gHlGR1H6qecLRUFHAxj36VsqKV0YdGwBUvZ5X3ck7/dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826513; c=relaxed/simple;
	bh=N7osgbXR/Nb02nCTiJ+ibSI+O2czeqyHA6JbTI2aH0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+skgKk96fFBXPEKwBie6GxW/upT2bAFQML2mDvf9OQqd3lCSgw3XBFpGIPumhV5b71TjjzhMI7o7R3mG1g7OxsF0zxyfY5JSxwYCExAlOi+/KNJLV8rAFHvOi39KQbI8Hi6e5U+Icgn9YCuCi6s1LfRlsxD1fAALAXkuLyzHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD0lMbSc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759826510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7osgbXR/Nb02nCTiJ+ibSI+O2czeqyHA6JbTI2aH0c=;
	b=BD0lMbScysGJBz0GrUafq96/xFv3l/JUid3Gm318KFJpnh9VtJOhY/6RF9Js7+Ean6tsKr
	BaTF1fRONuulbTJcVRwDHxgHPDJLsZ7EVxZSnIPkuouK9RRLDNPTqO+ncxgfzdn4OqDrO8
	nlvkEmYG+F2BrrrEXOQx/aThbpU2n+A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-Kko4YgVuMsuS6RTV_IOVug-1; Tue, 07 Oct 2025 04:41:49 -0400
X-MC-Unique: Kko4YgVuMsuS6RTV_IOVug-1
X-Mimecast-MFC-AGG-ID: Kko4YgVuMsuS6RTV_IOVug_1759826508
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4256fae4b46so1834828f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 01:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826508; x=1760431308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7osgbXR/Nb02nCTiJ+ibSI+O2czeqyHA6JbTI2aH0c=;
        b=GXhrTCMcX9GBePQu4vwbkhl5LOGQR8JSvNC0ERZMCfFW5T2/Dq9BoKQI2DFV1T18o6
         +ThZ5yyRg3DYqcgFOtg35W1DPeNI4JadThdi6W0pHWnm5s57v+ul1a+pQxx87GCfymoF
         xta5UjA+kuj3VwP320a5Hf7nx3n8ro2nyB5w1yL9/bU294xrTvZ7htNYZwurQNqf1DBv
         aZWfEqTgUsMR3g8o50p0cPq4bwz2PLLWnDEp4HX4vRN5YvPoLuLQc7BqGhf/Bi4kttkP
         zddRP/MzFJQIjhUKPBNl7gpcAheeAx8CfG8brkg+g4YXvRMMiZUfwTNt4aLSAcmuZ6Fl
         3Wtg==
X-Forwarded-Encrypted: i=1; AJvYcCX/DTTWnvvV9w7X8r3/OAae9CDjK8DgPstFmqS/wksvfmxCWiSBig3REnSU6eBfuQd0Ls/RaQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98w6FfOIaHNM7UZrXnGKGNh/vfiVcSB1ulxwd8CP7kS+ArYbp
	/pS19TFI3hK5n7NztG4YfAxb64bi1zJGQm9vzYluwNqXb0R0j4+zmeK8K8UXggnwZ9qFWBjy5hz
	YK2ar6yMym8qpcXV0Ncuhd0oa49Z8dhcLrpOSXYoVWkg1GeqbSUHj/ihEzldqXNGsZw==
X-Gm-Gg: ASbGncuyjAgLjYwue4363XUvWryGviPMdb2AYVlRlqQD4L5CU0t2lZq+sSCWDHnrEBJ
	33/hHI3uxdvSJ30CWdDmn4cZOIkFwg8mPII/PaAy7OJDxq+RYFaxK1KgfPOs76beBVhhU44+jSd
	gQ4x2PEhpG239aQKJsYOTW8KrE1uNtTvqvQLQtUVZUESqnqt3Mw0eXePTit/NGVC5zNZrZVy1Ul
	CqtX+wwIY+hh9xE9ENj59MEBl9ATS3wGWAN/zaj+JJexB8P+/yKtb024d0b+yVmkexY9Lu5+Ijv
	E5p0nyBTiHJ7rpiWQw6XCclyXqqTELKnO1SNExO5RTpO+ajIQHW0lKhnKw74hvy+0VQikwOtxqK
	4GRTHGlzuRf653bdFWw==
X-Received: by 2002:a05:6000:1884:b0:408:d453:e40c with SMTP id ffacd0b85a97d-4256714d755mr10312700f8f.25.1759826508134;
        Tue, 07 Oct 2025 01:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxdfixPGpLhL9XW+jR32nQk9zCoNallfAtZ7SneV9aO6UUhophTTA8FHKS9scyKLuEpDDBg==
X-Received: by 2002:a05:6000:1884:b0:408:d453:e40c with SMTP id ffacd0b85a97d-4256714d755mr10312680f8f.25.1759826507682;
        Tue, 07 Oct 2025 01:41:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm25156532f8f.49.2025.10.07.01.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:41:46 -0700 (PDT)
Message-ID: <d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com>
Date: Tue, 7 Oct 2025 10:41:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
 <m3o6qotrxi.fsf@t19.piap.pl>
 <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 8:43 AM, Kriish Sharma wrote:
> Thanks for the clarification.
> I can update proto_name() to return "LCP" by default instead of NULL,
> which should silence the compiler without changing behavior.
> I can send another patch for this if you'd like.

If v2 is not ready yet, I think it would be better returning "unknown"
instead of "LCP" when the protocol id is actually unknown.

In the current code base, such case is unexpected/impossible, but the
compiler force us to handle it anyway. I think we should avoid hiding
the unexpected event.

Assuming all the code paths calling proto_name() ensure the pid is a
valid one, you should possibly add a WARN_ONCE() on the default case.

Thanks,

Paolo


