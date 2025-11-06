Return-Path: <netdev+bounces-236405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5492C3BE8F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49161504121
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12533F8A3;
	Thu,  6 Nov 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwNuRB+E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYUakjPF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0234572E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440797; cv=none; b=lDhKgeX5l9cAFuzgdCvk6qx42yvQWKVUqiOY2NbjcmYHNTmqKofcRCXeTErx258Yupn+N0iX0W+DqQv86fECe3VPa3e1Ta9or0FmYNaO504NPV7SXqCTCgtu0mJluUTJ7MHon/kNrQK7ub89Wt4E3BnTswZZ9v6Jvk4VgEVKJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440797; c=relaxed/simple;
	bh=0Bi4LHwQ3Oz1+CJ2dXX3nYlqYoDS15IyYtJpQGkCX9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiphximCFHngAkKAVlTlCYBRKEOGEu7jqw65xeTGAW+QggnspebuRO9bYxj4CjTqsbagNV63A5ee+IssQfgjSGOtdUecIkLV59aA1Nq89lyZLgO8mz5XEDNJ7/cqhbZ9kZEmSEz8rsZM0r0dS4q9ZY4YHmTPVhd62Q4TrIdZuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwNuRB+E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYUakjPF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762440794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
	b=AwNuRB+EUp0JlXQ4pZkJfHi6OyhRYaIvgPgf901Cq0oGNe1iUBQIw77DmVx4muzjvvaHFe
	tUsQ8e/93fdTmXBpZrcZdGZK/l3Bi3ZEa1oGqd1kM34i+z9XeikQSSD4HUT4wcSfoLFTRE
	Vi00vBuflO45v7e8B6hKslLxxofJD74=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-qcg9s_-KN-W_e7y6dTFiCQ-1; Thu, 06 Nov 2025 09:53:13 -0500
X-MC-Unique: qcg9s_-KN-W_e7y6dTFiCQ-1
X-Mimecast-MFC-AGG-ID: qcg9s_-KN-W_e7y6dTFiCQ_1762440792
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c521cf2aso757575f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762440792; x=1763045592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
        b=RYUakjPFBI1nQ6ByJIzNvlePbCJqTmoLqWb7LSgbpmqjTaiLZjm2ODi+vkKuZFaxQF
         tcSj9lqHgLHryg3k3gngUnIA6/KoyUKAiHdh9sBIS1OaCHaljiidS4oGDa/3Sy8uPBFT
         xumpfatHv1vLrt0iERFlnOrt0a+GslFR5a+N6owhFDN0pytct6kpwceJci9ruD/bXetd
         CAmCKK+PvwDcTDPhE+h32qUYk9GHJU4eDVsWHjCzKsEC8dEphFc0INFpajZD4bWm78fW
         lmJSBhdOaDtMIycqhYAQE6akAgaoNQvI2OKrKBB95qllMWmK8tYyRMftjzTqBQLL9fTj
         uXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440792; x=1763045592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
        b=lF6j0VasbT7yAAx1kK8x/Hb9FAxeQXzVAWHaK6X2aRltyAlL/T9Nhi3Jh6Q/wNNrfJ
         BY+X0jSFcR9EVO7oLmv8GEIWJk2xe1L2vTT79e8Fy3Rfom4dVOE0VOpjBppsnJ2yC3h2
         VMWsM6HSpyj+X4q/Yr1RaOSpsl93L4j0zi7M2jm09NyJRi8k3DMaCG3JY9lJ3nEPUnMX
         G1EjPzWATiWRcC0uSLqblbM28xrxA4F+XGamla4L4ecFDKj0pvA+ZYf9Tpn7VEnwH8Yp
         orGO8t1OOWYdT4MTEEOBzlo64TueBtEJohCsz+QeNlJCIwckqayQtqC1JzRMEcsi6vKu
         eDTw==
X-Gm-Message-State: AOJu0Yz9cH0We09bD3u47ihVweO3exCM5ummGbkeybFX4yrlnkV80DE2
	UBBeM6xQ3Rw9FsVG2C4LRsjKRc23fgvs7fbSYyWm2jqixdORlQSNgWjktSdlGNDKjP5Uhz7E64G
	SLgU6gYKASIWZulInbDzV9Mvvsxqdg+c4UbMuRckHPfF6DjiKicrut2t4BQ==
X-Gm-Gg: ASbGncuN2ycYHTifa1CBsFcZkHM1wxUu268rgWEcAq2ERf/GTm0CBhz5hdLa+2d2kl9
	HZFjpF4we3og3F2dKDOuGGZV9VtRvNMwKks/Z0a+/PjZ0aJezMo6A0P/DV4QXmXpD2YrwN7kXjE
	tH91AGFtpdvlrmKj3ml6E4LaXJgGFsP8vLYIPaksmSF5flNvrtNmncHlsK4VjG5MA3VtBxT3DKl
	zPQrPfv32VJHOkw3dJoieHSRjytBA/gKofPj/3kaYHwlDACMes8JvfhAieq0FFnrEBpQqi0BudC
	KWGK7HNHTIvVIrjgsfsVi0GPSzRzm+LH/nvRuBxjqGuM6L9klIxKKPmuEVUEBSPfhhR7IDOWSD3
	aVA==
X-Received: by 2002:a5d:5f56:0:b0:429:bac1:c7f5 with SMTP id ffacd0b85a97d-429e330aae1mr6387402f8f.44.1762440792104;
        Thu, 06 Nov 2025 06:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK5t7Fq6Zv4jWk7ndZnINKEE6SRIPfe793yxVRVTG7XMWpFYrBjzrI+ymWB1vQzl2d9MBt0g==
X-Received: by 2002:a5d:5f56:0:b0:429:bac1:c7f5 with SMTP id ffacd0b85a97d-429e330aae1mr6387380f8f.44.1762440791658;
        Thu, 06 Nov 2025 06:53:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm5566783f8f.17.2025.11.06.06.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:53:11 -0800 (PST)
Message-ID: <8d9c37d0-b238-4778-b18c-473bddd6481c@redhat.com>
Date: Thu, 6 Nov 2025 15:53:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: local_termination: Wait for interfaces to
 come up
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
References: <20251104061723.483301-1-alexander.sverdlin@siemens.com>
 <20251105213137.2knkuovcc3jpnhqv@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251105213137.2knkuovcc3jpnhqv@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 10:31 PM, Vladimir Oltean wrote:
> Functionally I have nothing against this change.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Two ideas to minimize the delta in a more obviously correct way.
> They can perhaps be implemented together, independently of one another,
> or not at all:
> 
> - setup_wait() could be used directly, as it waits for $NUM_NETIFS, aka
>   $h1 and $h2.
> - There is no case where run_test() does not need a prior setup_wait()
>   call, so it can just as well be placed as the first thing of that
>   function.

I think both suggestions make a lot of sense, @Alexander: please send
and updated version including them. You can retain Vladimir's RB tag.

Thanks,

Paolo


