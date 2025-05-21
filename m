Return-Path: <netdev+bounces-192211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DACABEEE5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48A84E3D4F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66C3238C0C;
	Wed, 21 May 2025 09:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC72238C1B;
	Wed, 21 May 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818084; cv=none; b=Avb4jIHW/NzGfukQrmDFqYDmoMqeTOAMMnZeTCWKSF/fOzRS22gVTf7uq/q4bNJlubgmPtWqkU1bUDgTx0rdZwgIsUaDeIRjKgPQGm7Z2ZYlgbF8SI2KIeypsX13qBVlAyZU32lGgj9sOntJYZ9ixglMAN4X8fwVBHAxzHd4+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818084; c=relaxed/simple;
	bh=+YE7Vo1+vNliSMATmodmEqPoqVqg2E+pzG3KctWIWU0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aS9kJuptesJIiLI4jGUHhmOQXxC6L5Ba0K245cUZYO2OvywTJTUnaV2uV0o9koBxPlWDPA+a58JWnGCifBtmrAbrnApm4MlhFihxN+SSGR0LFMiyjLuBnCLEb2cdpOhvZLRj/Fg+IqVMY9FKilAZGdtNCw42UV1YnLd5kuoXDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad56e993ae9so599952166b.3;
        Wed, 21 May 2025 02:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747818081; x=1748422881;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc5hmGdboPRjK2Cmn68Q+X/uY5v91HLjANk/TAHHJYQ=;
        b=Dr8vYzRiNpEj6PIAoi49CxjD+4WOVUSy18P68XGJhcnBBKOf7qXkf/EvfniTcPJkqd
         P2T43CD94IUV/H3YCoD6ipW3xrmsdxpjCEXG8VPG9ZsxnXBsFVYMSirVhfxKYgnCmF9f
         hsuPwxuGYvnsNLT45WS1bGDMnLe+EQ6nW4qMJemd3sS5xrOeKFuC2RwuxoFKQEsK3kUf
         TVI7btFhAT8PgoqXvOOgSyUWKyrPOgvirXJsAlD3GIt91ssFIsi/MexVjswPxJMSyFr8
         bkpU+YgMVfF9dw4J5D1HIyt0eZ9t8IrFdE5LC7C78vJrcfFAmKJFcVw8bBBshCHJGhkk
         9Ndg==
X-Forwarded-Encrypted: i=1; AJvYcCVnBgDZ7Q9oEocR3tz2S+Qi+9TlvQ8jCFe3CGDtzrekMLl7xYx0Tr6o2jtA0wjEtI1C+9DDNGAB@vger.kernel.org, AJvYcCVyCtLccaXXyuGDSmoIryvAGtXpu8oO/CWTENiCxkUkmBYgHmkvz3m8N8vSuSmJeqrAE8mrQmZb5eBo924=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3y1R33RD6JWIr+PUn4apX7WRHDVOu3E3K2Xt5JLHAehdZQxYm
	oMJYRb/zdrit6Xh7zaHlKL/dJobrq6STYnLM87UyZghFqmXlGSViUMUc
X-Gm-Gg: ASbGncu8kgQ+yf2mjQ2Qd8quVyE2qG3lSjcIBcQbfoG38IMCLjOtcFkuEkB+EfdQLis
	guYZ0ATA3k0M8PBHb2S7O1pJ2j4/CKdoKUiEA8Hm2YJm0HWbM/8rizKqqkjeFa+K/giyFtBLjWZ
	evtPLNp187ZtxL1Iiq9UJv3XsIe/9CPmo2p4qmKZkHhqE/YArvpQQTVsUF9U+Ku0MYAiPmqrwCs
	CzVHj0UFtuv0wFGnOAUddzu2+yG393Xow6bRrQwfmlWug2j8jKPhn6BtFIvllnd2ZmzesX+cwzh
	Ft0qTeuSMkD/NATGuhm+DP4XiZabXILin+6jA1gP7wnNiSmujPwuQpaNWKkkSotaVycIUtwyJxy
	wLBINf3vIfZLHOY0ifA==
X-Google-Smtp-Source: AGHT+IGuG0HamIWvlodvzeSynbSTP7Ygef0Omi0ZEPpQi+FuIaoUwUTJIWM8JdhlCQsO3eB1YnQSsA==
X-Received: by 2002:a17:907:3d8f:b0:ad2:2146:3b89 with SMTP id a640c23a62f3a-ad536dce3f9mr1517863166b.47.1747818080846;
        Wed, 21 May 2025 02:01:20 -0700 (PDT)
Received: from [192.168.88.252] (194-212-251-179.customers.tmcz.cz. [194.212.251.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06ddd6sm883112866b.55.2025.05.21.02.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 02:01:20 -0700 (PDT)
Message-ID: <9e13908a-fc54-4792-9f29-8d2487118c17@ovn.org>
Date: Wed, 21 May 2025 11:01:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Faicker Mo <faicker.mo@zenlayer.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>,
 "aconole@redhat.com" <aconole@redhat.com>,
 "echaudro@redhat.com" <echaudro@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
To: Jakub Kicinski <kuba@kernel.org>
References: <20250520032654.2453312-1-heapbin2@gmail.com>
 <SJ0PR20MB60791551365A54151B195E44FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
 <c7d27849-f48b-4c85-bcd9-5d2206856abd@ovn.org>
 <20250520164458.392d5ac3@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250520164458.392d5ac3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 1:44 AM, Jakub Kicinski wrote:
> On Tue, 20 May 2025 15:37:53 +0200 Ilya Maximets wrote:
>> Is kernel.org blocking the sender somehow?  Does anyone know?
> 
> The patch was submitted with an HTML attachment :(
> Same with the v2 BTW. vger drops all emails with HTML parts.

Hrm, I see.  It's "Content-Type: multipart/alternative;" indeed.
Gmail and apparently outlook(?) likes to send the same message as
both plain text and html.  ovs-dev just drops the html alternative
keeping the plain text, that's why we have the patch there.

@Faicker, you'll need to re-configure your email client to avoid
inclusion of the html alternative parts, I suppose.  Or someone
else will need to re-send your patches, if not possible.  AFAIK,
it's not possible to turn off the multipart/alternative in gmail
web interface, not sure about outlook.

Some useful information and links are available here:
  https://docs.kernel.org/process/email-clients.html
Ideally, git send-email is the preferred client for sending patches.

Best regards, Ilya Maximets.

