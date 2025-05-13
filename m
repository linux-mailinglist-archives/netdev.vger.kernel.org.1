Return-Path: <netdev+bounces-189999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E068AB4D5E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A531B4205E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A41F0E2E;
	Tue, 13 May 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VN58xoNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FB1F151D
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122881; cv=none; b=RZn2BHIjwhapd5UxmWQ6zfjmHEN6wHzeBiP/aOgHr0Z++hI4qDYxNVleC5bsV7y5c6Md3cwKnCQn+pQTh1GEdiHvtWhEzLOwKC1g+S+BNwnhoQPiWra+0cLUM3e8H2MaHWkI5ockYoF7IDU/4f2JTetbuf1bSI0Gp9TwQ2R0QDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122881; c=relaxed/simple;
	bh=sQIKt5cc7k1HjRLbGX1r+hR+G2VtONUbjF2jZ/owH3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK6K33FX1bgJEEahk3Vvmj6jJ3cUYtfRgP90+GO4Qe+kDuMKIdVaRsjBeKM9VFV8KZUdqWwr2ea43SlMDqQkqhKW+HalAR4gMoj9ODAkVCqiyZfvIba5TGL9v33huD2qxfHZRqRLMsz357jCeAvwtdUW5QY/0c3mFzxHxqSWtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VN58xoNK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad243cdbe98so436201766b.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747122877; x=1747727677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IWCGc864A7d6nnFP6Tjyde3BIOdiO9p/POPHX3upR4A=;
        b=VN58xoNKDE8GaaPui9zHOfE70lXJBPtDsnEguCcXf8WdVX2TI+1I4C9dCQ3/2lcJkN
         NQvb2Io4i4rq1pqtSzdvF0HeSmbT2VfGdFYsEUwhBB7cTgP/camDHdsZXZoCgeTqA6fv
         tKnk5cYTrdbh5QTrsl+RMCh7FciyP5iMN+RsUNHcey5frZEEt1V3YYJ90o/fTM8H+CUF
         MgdcpvDYhMIF9vtHRS+t4usiN8naz9uWMbch1XS892oYz3CphIRhjlZymjh1vQVMRKlt
         8YLrC+Yw1uxm/Ojpz/VQQfFgGqT3HrAq0VEv4XelP2feXKcGPq/RuoCDcKk7BTb1TIjl
         f0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122877; x=1747727677;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWCGc864A7d6nnFP6Tjyde3BIOdiO9p/POPHX3upR4A=;
        b=KwKFTBlUkkXhTZqydRhF8jYi2AvePaP5MH1vFQDNUpCN1eSJImQXa6nJtXu/EdVITJ
         3p3cJAOTQtYtvhFpZgN1H8SZ8CRJUeub8et9JYiecQvrGD89qZUIDbyKjFCE65ser75l
         58gs/d2iuWLZZ+Iy15X6onSzfsJnbvCeXJKRR7gqSND31iT/1stGmF2Zq2ELK5nr/Q7s
         GVdYqUnSrx9otwB9Y66ZvnBzruCuWj/7UXapfnPdGyZ0XJzEU+L6NjJc6oFjW6YSeSW9
         XZG+nfDOcKvpLcVJ1ibzpwVi5m+/7VNpiV0pTgIYrUidiwTX6KUwpf3HxcGXpzG57HYs
         I/vg==
X-Forwarded-Encrypted: i=1; AJvYcCVuSDi8YF3Aui3o3OZT+khuGzpglusGnNiszoD8xfTT1en1FpxtW0TQlx0iklKreodWMDqPI54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26k/MiXNo52mE/NhWStM16g7dv+hQCplZD1QZLGWS+1Lhn/J6
	mTnwFEpjMp1M8hFkD/lqo26mr6u/zWy2pWVHJDMeqxHIUqlnpydI8nbr+CB2bnFd5gAVYc0B0pq
	+zX36n4QhCwOHFSuhqqTJpWmDIVb54Yp/5KIZWhQ4QVIfXGIYW+5Y+AGHME2e
X-Gm-Gg: ASbGncvsLMe6ZjBykHwsy7LQs8Bjq2hqnFnQPIGjPniWaf6px2s6xVvUte4ECJ7RTFz
	FcHE13/MaKJzskxH7HZ6fFmtna9u7wR6/UBKL11enA7kh0PA3MVp2WFnOruloWo1EPBavy4byVk
	DDnAKupBG5vYgsXgoRhCHlyi173/o6+6JQi7Q+CATVEenhzYlF9+a7hp+W9bYhXrAVWr1lbV6hu
	B+j4Iepyj23Yy/oD7/LtM9djS1Ec3d83tBUprOIT1jOLR63b3gpizhIfH+EwzJIf5ddcatOEcy2
	nNb02X8FYknKy2WRoSEptYMMhXnCZrEw02c8MLatPP23dFCL/Ho/wv631Cc+AvyQCubWRDsEEOX
	108vCKJi1BymS7g==
X-Google-Smtp-Source: AGHT+IH9TZJW5nI2yB6IMfmK0IsOufmX5KUDluVCTeKH7xgyBd8WizkklqYRkiIGJ2iH+qFnKVhGpg==
X-Received: by 2002:a17:906:6d47:b0:ad2:1cd6:aacf with SMTP id a640c23a62f3a-ad21cd6ac9emr1168486766b.47.1747122877517;
        Tue, 13 May 2025 00:54:37 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d7016b4sm6947371a12.49.2025.05.13.00.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:54:37 -0700 (PDT)
Message-ID: <9fe0a11d-b66a-474c-a831-3c7694e12bf7@openvpn.net>
Date: Tue, 13 May 2025 09:54:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] ovpn: don't drop skb's dst when xmitting
 packet
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-5-antonio@openvpn.net>
 <3a173ede-e2db-463e-a135-7dc9c7976cd7@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <3a173ede-e2db-463e-a135-7dc9c7976cd7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 09:45, Paolo Abeni wrote:
[...]

>> +	/* when routing packets to a LAN behind a client, we rely on the
>> +	 * route entry that originally brought the packet into ovpn, so
>> +	 * don't release it
>> +	 */
>> +	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> 
> See commit 0287587884b15041203b3a362d485e1ab1f24445; the above should be
> 
> 	netif_keep_dst(dev);
> 
> and no need to additional comment, as the helper nails it.

Thanks! I missed it.

Regards,

> 
> Thanks,
> 
> Paolo
> 

-- 
Antonio Quartulli
OpenVPN Inc.


