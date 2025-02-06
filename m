Return-Path: <netdev+bounces-163561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0CA2AB20
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C509416973B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF322F15F;
	Thu,  6 Feb 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLnkk7LU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1A214A99
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851837; cv=none; b=kqLZ8Gu4p0c0wb8W4ekmp9GpHe+K8CUQVFBDw5+44UOnKzg7wdQbUfs+FDfmcv8ih6xUbCg+dBFIIYXhsTRHx1GqPHxWUSVqL4oJnFJ7oRnFGFGA2AxoFrIdhhRvGy8mAZkqo3IsPvo2ug5ODS/1VAvWjflRCXtAS4oNTvlQuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851837; c=relaxed/simple;
	bh=QDiPoHWt78UETk6zWdqpw/0pbEYpx51QjZ6lwvwvUts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5fr042GK9HSprRJfOw6wmFfu87P7C0+16iPl5dEuLXFIICE79tnjUImOZk5vchXz9Ny+UiRYetGcXPZNFpk8YP5jFGzSRgJOnt6978z73UiDFzWzbC6GRAe+ohe+6f25K6oYLg4O0xl+tewB/iocBlxCtTkP4hso+dgaQeUjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLnkk7LU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738851833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sARMRwqWra02AxNOvFwwfgvAfZfjGVONCzOuY60nMKg=;
	b=gLnkk7LU0VAq9rhXPMP5NfVQBaiFTzcJs0L8L0LELiPEsbYTfFpIsYggbB/fdGuf5J48Bc
	X9D07Cm6ocHn64hhRB80SwVfBALajH6+5OpXh/2EkviovG19ZXpFiGNv1FHewzXx0xnzhz
	GNZ2F9LXZarv2TZbrg9oXo4nKSTvFS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-2AlxR76lNq6sTgGxjCQdqg-1; Thu, 06 Feb 2025 09:23:52 -0500
X-MC-Unique: 2AlxR76lNq6sTgGxjCQdqg-1
X-Mimecast-MFC-AGG-ID: 2AlxR76lNq6sTgGxjCQdqg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a873178f2so467359f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851831; x=1739456631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sARMRwqWra02AxNOvFwwfgvAfZfjGVONCzOuY60nMKg=;
        b=vuU3aCUeeLT/2PBrDfRmx1g3cKPFHqfEAaLCR/mAPcxyIJPuP5Ua79HELQ05IXlVTn
         F2sNC/EvRzgtIxgbFjHaldhgpYoPtr2FsJ7YkBSKzbuZN/RxSRntUkprvFNAJHVgidRz
         FLOgVoMm0zkt8yjouEQ6yg9CsVJ84Z6B7J+UfYOsTFrIyHq5QDh4YSaZ3MyZ772z/tUB
         qiuImcpCGzcG0vjb+b+T08TQyJ+toxVm15g15zm9CfGMmA0SlFDmM3++WjjSmqO1f+Ii
         n5YQs1Sb3NztSDH1VvMNpkNfZfOoVjmXQ4W6sPfEpUmI7LsgM0uklyYoQXXLfsx0QxBV
         BfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9qCOQFz7hnaG6Gf7VIkpKK2JOFZoGaq7qPBUkZI6P3q2cDLGnAbRXhnaYJ2zd8e5RS+ksEig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBoTbhsGZoi1kiRZwBypowhf8N/988rH7GdIYtvOrSCRpIaXR9
	mIgjC7JPkPPHz2CIS0yeLyFvrBtqNlwDDRSKZiQ8Z5uUzKxMw5JMiWWnKKCSJpSf+mWHpfFnjPq
	fDdOwhPFl/DtG5sizkoUtbWPZtpcKrO2YNtFWOEzRW6XSuHLrPy5guA==
X-Gm-Gg: ASbGnctdx54DeaAPRmMHNDYtCdDgUAPR0OKiFe2nJ6+ln6uDByYLfIiIhqd036g0VeH
	RRNib6VsLkpFrTuobiheD6YUK98S1l5gbWKqDuAJJNDXYPseqgG9yWa81dnlMvK7byRKFBO7ZhJ
	+OoHk6FSIMDKxS0dkRBFPfuauTkdN7giUdD6vAbT5FLuInb+MlEeee3NLsydlm9K0BFgz034FQm
	6CzhN5UOqi5wxpvI0OV8oM+a1s8/90A/tFixC7TL6vRoxZAt0RgixpEdfbE/19Pcku3MSRbGRQ3
	r476wa6LmieOkkhJPMp1V1kYdjTr2CpZqaw=
X-Received: by 2002:a05:6000:1446:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-38db48812bamr5369028f8f.27.1738851831297;
        Thu, 06 Feb 2025 06:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXx+BSFbHwwe2GFW3dNA+ND1wpXAm3XM60cAR69i0CFj0ZvSN/1/aqOpEGD0kNC8huOJ9WSQ==
X-Received: by 2002:a05:6000:1446:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-38db48812bamr5369001f8f.27.1738851830889;
        Thu, 06 Feb 2025 06:23:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd539c4sm1839934f8f.42.2025.02.06.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:23:50 -0800 (PST)
Message-ID: <5c11113e-c7d0-4c71-9f5c-02e7a90940fe@redhat.com>
Date: Thu, 6 Feb 2025 15:23:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v7 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250204091918.2652604-1-yuyanghuang@google.com>
 <20250204091918.2652604-2-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250204091918.2652604-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 10:19 AM, Yuyang Huang wrote:
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> index ad1e36baee2a..7b1e29467e46 100644
> --- a/tools/testing/selftests/net/lib/py/ynl.py
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -38,8 +38,8 @@ class EthtoolFamily(YnlFamily):
>  
>  
>  class RtnlFamily(YnlFamily):
> -    def __init__(self, recv_size=0):
> -        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
> +    def __init__(self, recv_size=0, spec='rt_link.yaml'):
> +        super().__init__((SPEC_PATH / Path(spec)).as_posix(),
>                           schema='', recv_size=recv_size)

The preferred way of handling this case is to define a new class, still
derived from YnlFamily, setting the correct path in the constructor.

/P


