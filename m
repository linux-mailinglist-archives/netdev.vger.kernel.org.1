Return-Path: <netdev+bounces-120857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFC95B0D7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2AC1C22CCF
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3A117F505;
	Thu, 22 Aug 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioTORdKR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D317E009
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316295; cv=none; b=YGd1L/0p6r4JJQHGI2QAqgtu3q5eDh0f50OUkh01OwQ9RF2E6h2m0y0OjsI8XFYaHqlCmKbKTmzqPVUKC86izC9TrdW7DLXMeQiekwoZKLPJa10Vl3lcidobu9pl3rhcdPT7ez3IRwvXqUMs9k603KpPA/QItBKGgJUSTT2EUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316295; c=relaxed/simple;
	bh=oEq15/LpxYIpU/RITm9cqOxFXCv/xhNAEdwjqrFQeiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDKMFbk9vvGN/T9crk0STm/v0H5uMso0aLD9n1owJ4Fg+g4EitKa6X/MpmRId1I47KK0lrUD7TMQM1sEUTNiJjx0GM7Gic8AnfjAx96ez4MpWznswuY7vODwae423uZMCIjGkdY3xeFAAH3PSGjWQ1pASVr5JrQo2BsCfxXvSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioTORdKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724316292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MMnGsGQUkY4j2NZDFkPgM0sj70coBUY1yzar8bIptg=;
	b=ioTORdKR+mwJvSFbzosscdbmb6E8i05+3E84wcEbVjhYp6T777izGnYMJoU22sZrAlj/2w
	z4wtDYYAgkB7Vt/LcGq64xwJ8wuv+7ggtfmdWiGcFpv3TAO1BpUKzKTjKg2ucrcf0xEl1V
	whIZJJadryHzCR3/UPFfyFcF2vkTPMk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-D8npXJ7lPHyBoO9k4sUUNg-1; Thu, 22 Aug 2024 04:44:47 -0400
X-MC-Unique: D8npXJ7lPHyBoO9k4sUUNg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso4197965e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316286; x=1724921086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MMnGsGQUkY4j2NZDFkPgM0sj70coBUY1yzar8bIptg=;
        b=X+kNuFqm1QA3B657Y9T7PdgHsOStx/XAm0hMQymN8yt+goCpEx2RgFdexFmqD5wKXX
         Ch0Eo4MvapWs08HzjKNOFfNNGHNDdayD7j6FF2seXH0srukwl+IChxLPa572+TQasYK9
         LgGaOFYsSDvgttsn6PrM0XFpX0PAjd/QVKViGs2YM0/q9NKkN828klo4NuUmjwJLsWAE
         E6iJO8GEUVKrJD4uncvyJhenHZyox+mKcdBBB0SsyT4ifTzCdfJqNThHfJXojPU9KBp+
         CA6ydsXd+gAVyRohb8oXdkkCNjSQYZcn3l29sF6jQC7ZO9h7hrO8KwdvoDmUZr6K9LKF
         sooQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN9QuZsYi76FQ/ZywHUOiBzRBElHOhuaR9ubm5yVSxkyB6OJjf83ak5S7r1BpNCzmli+dhkgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMq4ev5+h3IpmRUNgLy4E+yV0fQKLSmTWc4y+PXHce8x7UO7Ba
	ffQaIZoSrpAOWFnsEYbKQgHPO2wc8xwzOmV2VrB4EypOH56jrFOrTZ9LyViMLXvZKNqh1p56E0u
	VGoLlSVOcNXMBmNcHdnACyIrdQoT2/SUYWMr+6FDLLqtBjeDBFJUTpA==
X-Received: by 2002:a5d:4e8f:0:b0:368:4e2e:7596 with SMTP id ffacd0b85a97d-372fd6c0823mr3107931f8f.37.1724316285920;
        Thu, 22 Aug 2024 01:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES3ZpNK2Ahc0HkiDcs9Ga0KrEJHwYTp0N2GyCfvG8PlS+gTpLTUBsuCoPb+0FG/dt5WRNfVw==
X-Received: by 2002:a5d:4e8f:0:b0:368:4e2e:7596 with SMTP id ffacd0b85a97d-372fd6c0823mr3107910f8f.37.1724316285357;
        Thu, 22 Aug 2024 01:44:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308160586sm1108453f8f.58.2024.08.22.01.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 01:44:44 -0700 (PDT)
Message-ID: <e15e5b9e-e392-4cf4-8620-9bcc375711b1@redhat.com>
Date: Thu, 22 Aug 2024 10:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: ipv6: ioam6: new feature tunsrc
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20240817131818.11834-1-justin.iurman@uliege.be>
 <20240817131818.11834-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240817131818.11834-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/24 15:18, Justin Iurman wrote:
> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
> "encap") mode of ioam6. Just like seg6 already does, except it is
> attached to a route. The "tunsrc" is optional: when not provided (by
> default), the automatic resolution is applied. Using "tunsrc" when
> possible has a benefit: performance. See the comparison:
>   - before (= "encap" mode): https://ibb.co/bNCzvf7
>   - after (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq

Please note that Jakub's question about self-tests still stands off.

I think the easier path for that goal is to have this patch merged, and 
than the iproute counter-part, and finally adds the related functional 
tests (you will need to probe the kernel and iproute features), but 
please follow-up on that, thanks!

Paolo


