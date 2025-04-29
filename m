Return-Path: <netdev+bounces-186745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253FAA0E31
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED909842C0E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA22D1931;
	Tue, 29 Apr 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hj5lVsPz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB12C2AA6
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935705; cv=none; b=Ba77yy072s+Y0/Sl7RvXqgmabkEmqOrpJs3HcyHFiavH3nHjPYPHxrufCizRZuGgbgW9SzZI3v5WGqrG8YLoOWyvPfvKyz67s3U6dhOCKa28ds9OC2jVTQA3AoPma1gNuyn8o8WmCnqHGs+GDoirACOQfcQHpP2qbkwYQnY20Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935705; c=relaxed/simple;
	bh=ha8igNbGM13aMHaHrQdfISRaLlgwfMIsDFvz65727oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kKYWEb4gpzizueBzf65K7JCWXVF2EqwjSrvFw+spiLo7m/g26WdwtYXMp/7kpxSnh+Do66UtBuFL20Pop5FS5+JB4PW3sF5ON6YVRNZ0bqBK0sQOyNjVPXgm7Md57QfXuysKywwBJxCp3qfzGtVevo4+p3lfWsiQfjjRadUFPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hj5lVsPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745935702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suG985EOjCX8biycL8J7gZpWEOyx9rBhI4py/TvWT9I=;
	b=Hj5lVsPzcBaiLnlcJ7TmN6sFZ5KpAXLqXy24l/aGWbbwRNrOBi8JcL9Cy/ka8rvEx5Ze6c
	z+8Rn7cE83guqGPS38c/S1RVrTDYoxHfcKPIkd5/n5rO61rbodSnUIKVDuAOOCLIrFeNYY
	CjYnYVGsuWuJBWWVY4Bxa+yHHXKs9i0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Hb_mkruhNnyxMAV4-lolkQ-1; Tue, 29 Apr 2025 10:08:14 -0400
X-MC-Unique: Hb_mkruhNnyxMAV4-lolkQ-1
X-Mimecast-MFC-AGG-ID: Hb_mkruhNnyxMAV4-lolkQ_1745935693
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac6caf952d7so601912866b.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935692; x=1746540492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suG985EOjCX8biycL8J7gZpWEOyx9rBhI4py/TvWT9I=;
        b=iZLKfT5KKuzyY964ftg8WPDmEztmjRECMCqeLG9HOCq84XAMkD3LdU/TypYUh3D2ZE
         txBlePrbW1ASBOeAjsDQX3MNAPpba53z0irKODFHrXX+ezGawz5m11uyy8PR+7hTdKxW
         1M6K/Uoyts1Ytx7YFwGZHH3Okh4kWs90fLbMiTGhjL8GKNPxpxkRQMkSpD8mJDfEa/1U
         L6N3rT0zjnGh9G19+wYRp7/BrCclopK0J1GauqLI88AYNxtizFwxyL2Lzl0QgX6SNl85
         HvxjpDWWJt2uNwlvLBGUc72ToQi5Z5d819BbDtpIseMtMbjnE/SbBXG5IcyjrROjP/c6
         h48g==
X-Forwarded-Encrypted: i=1; AJvYcCXek904O/QRKqNX/uq24Di+L4rRz+6ssdPTnwZAS1f7E1aRmUya4arRwi7qJLRePl1gHrV2wkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fEK1Yic7Xi2i2YrXCH5uXQ4bMJW3TGWbvMCgwQRIAr4f01Lg
	OuGW4fTGT0NCsJvaDQdKPv7fivsIvXf2PACUTMkEj3x59poAe2iZ1oy5aQB2DTfis6Y2FXFKNrP
	uPDdoFJfaM21j2xIGHXjhNLM5Qg45u8ABVUdSTXWJXZhY/7mFPix7l2Bwht2fq1iY
X-Gm-Gg: ASbGncvhFwyPPz8euu2IP+VI8MYX+7Br5qgmCKXQ1gIV2X5OWwPgnmghC7Cu32a/KYa
	5UoYz9nBxmoGEXyUlBOjs6UUu5PAczaA0Rfe41SMOVW/H0vwBhZ+AhDw2DFpafd3gVO2LUrmD4n
	C63culJgUhphZMoNFk/c12RvolH7aC/FbxkenrozIxYjJQfgnO/jAJ5qBHJEu4zds1izqjPrQIz
	HTpGZ3lhi/0efWA8la0uGaxPfw/HAu7Nbg3xSSyuXvtn5scLSsUzBVMwXoU450mNVYYMEPMK0vG
	frfgLuKFM4vYEAMQ6Ek=
X-Received: by 2002:a17:906:264d:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-aced710ab95mr45809066b.24.1745935692477;
        Tue, 29 Apr 2025 07:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0o5uLI0ku+DTzc9hke4sQ0b5ZTjR+yED75DjtR+K5/25/riwLVDPh0sFesxL/FxQTYulrqQ==
X-Received: by 2002:a17:906:264d:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-aced710ab95mr45803066b.24.1745935691981;
        Tue, 29 Apr 2025 07:08:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed7205dsm777011666b.156.2025.04.29.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:08:11 -0700 (PDT)
Message-ID: <eed29236-f238-46c2-a60d-fbdd3955dc99@redhat.com>
Date: Tue, 29 Apr 2025 16:08:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/15] tcp: accecn: AccECN option failure
 handling
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -555,6 +556,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
>  #endif
>  }
>  
> +u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
> +{
> +	unsigned char *ptr = skb_transport_header(skb) + opt_offset;
> +	unsigned int optlen = ptr[1] - 2;
> +
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

This warn shoul be dropped, too.

/P


