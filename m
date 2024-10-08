Return-Path: <netdev+bounces-133062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1934994648
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DA71C229DF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFD1D0E34;
	Tue,  8 Oct 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc1NIPSR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB71CFEB9
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385851; cv=none; b=i5GditW3+hbSAGrt1/Lv8pMkwdE+LO4XHxGHj2gyYfnwVBcQViHTgLWogaX1T1wFmt9IXZuv5vIg618jPGYOevtx30QszqY3kPoLWyC8ker4Bs9t4I2aCglItzowlufJQG0rpKV6auk+fGRw9fcM1UyrcFs2wZumNiEcMzlOFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385851; c=relaxed/simple;
	bh=WQ7tYIHofTVr66pMBsJXvo+aThpW4ME/6RPNDVhYrdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijVY9Iq/ZeIn3597LWW+THUVnzCemHdEjd+wisHBWGxWHRFl1vnDSoQeVA8+hyRO9Yf0v1xNQs0E1qzpFs/qqcmcprE2spSpqj1jYOUweYOJPYD8d9afewQXG0Qq9SMFbg/Alenx3JZI4X725SJBGuOUiYJavIv+OYlNM8uqf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc1NIPSR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728385848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwxVsgf7pGRut7fzyjOAmYDyHUbQsUNHRLe+n0zipP0=;
	b=Wc1NIPSRcTZWhg9MN9PN37RDaMVEwBy+C8Dliy8PYBsnx7e986shF4KPZVZ21Lzn5fp2bw
	0RiKRPEUz4zyhSBi5lKrGkwiaoVC23Wlm2QgtLa8u5fktgf9kA8M1vfCfYEfx1HRTShINw
	6M53p/xC9r84cEj1smEDB2JVuL+E0XY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-d17pNRAsMfK9rgnJkH5Tnw-1; Tue, 08 Oct 2024 07:10:46 -0400
X-MC-Unique: d17pNRAsMfK9rgnJkH5Tnw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so60810405e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 04:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728385845; x=1728990645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwxVsgf7pGRut7fzyjOAmYDyHUbQsUNHRLe+n0zipP0=;
        b=uZLXn+wNE9Wmg4FRSa2tQYqsaVnusOXOjvuaeuazDxYoW9STRXfc4OSXr28Cah6fVu
         1F1MRVgkoSBihII274+NKBucJ7pnyWdvpeD5Ksw75S7ZvWwkMKYGJfR6CtPTAL4Cx9ge
         yYuzpMdF6hSciSz+DpYYigeT4Oimfwi6ptHDwz2zehUQZz9eqIlxIu5PA48oGMiX2n1+
         q9tBx39Ez7euTTLxzZIHJrrGJDpNk0Z5M+k4DithxUQdxjaDI2wfnT4VjBTHrtdNlzmn
         pNW3oDoMl3kEBHOhGLXF2z28l+aNGFJa86mV3fQjSa+ZJJjSRorLNY/+yNrOniqe+VIV
         AAxA==
X-Forwarded-Encrypted: i=1; AJvYcCW/2d5S68X18mmCWOPyIzIsxJ4Fsbvv944e/dhwT/+TdszdGgfTkdYeH0G4/vRj0/1eL2tvCEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA72cuifX89jNHbTuId9JMx8CXYGzhlMQDG29bAWbRPMn/dtkh
	fGlD9/mGdItT7WRKFvXrDs/qJY45TovfcJH6hOn/Nx2VLneI0/cIqnvrKfNxQY7bVoD43O1qzkI
	oS5EidI9uJt1bIj8l0SZwI9HFSjEFSXhnJsxPaMtnIxjadfz4roo6rg==
X-Received: by 2002:a05:600c:1c90:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-42f85a6e05dmr150921255e9.7.1728385845588;
        Tue, 08 Oct 2024 04:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/QE7qttY1+a7qCTREIE0n6Hq/vU/jc3g2PLUq3gMDjdOWSljVp6xmWxnqY3Tzkpapwo5hoQ==
X-Received: by 2002:a05:600c:1c90:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-42f85a6e05dmr150920905e9.7.1728385845125;
        Tue, 08 Oct 2024 04:10:45 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43054aa7733sm11188385e9.35.2024.10.08.04.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 04:10:44 -0700 (PDT)
Message-ID: <810bc6e9-1872-4357-a571-2ed4837b74f9@redhat.com>
Date: Tue, 8 Oct 2024 13:10:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/4] ipv4: Retire global IPv4 hash table
 inet_addr_lst.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241004195958.64396-1-kuniyu@amazon.com>
 <20241004195958.64396-5-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004195958.64396-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 21:59, Kuniyuki Iwashima wrote:
> No one uses inet_addr_lst anymore, so let's remove it.
> 
> While at it, we can remove net_hash_mix() from the hash calculation.

Is that really safe? it will make hash collision predictable in a 
deterministic way.

FTR, IPv6 still uses the net seed.

Thanks,

Paolo


