Return-Path: <netdev+bounces-129921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A615398704A
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CD01F282E9
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223491A76D9;
	Thu, 26 Sep 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbR9OIMT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AE14F9FB
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343177; cv=none; b=o98Igcm2wFjUNSw11DPdKHhXh7bGmP+5d4mkotHcH48kSoXtb+HJPMEtxG47Q8Xp3C+A4JP1/FAbGzk0qGGKWtmBg1lNGRecbJll7O4IIGAUrgdZxmwQ2Z1yxO2ufuSxrsS3YMsM0cbDNu2FQAo+lCqH2156NkS4wu63dWTI7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343177; c=relaxed/simple;
	bh=9KLITEozZMuMw31UlUJPPVtzDHJ+Iw2+blshL/EsAUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFm3pA3KnblXzt94EQuVJOKu8l4UFt6L271G9r6f5gFCqjiTZhj20QDnOPIcza0hNr0Hk/Uze4sKg4SjwLPbLjj1sCug+64bsYGsf1vcaKaatn6eRdUqCHxxQnI176ilFiBlNt1YJU03I6iRLUOzc6qeREibz0Wk/Gj9BsYBKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbR9OIMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727343174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viiv1R7Qk2EGD2osRa2/tRj2PEh5xjR8v8WEQ+l48h8=;
	b=FbR9OIMTnjGkRdQIq+gRA/nfxTIjNbfmQ2WcR252ywiji+V1qCh7vOe0LkDYK31kP4kSMO
	y7CSfy4NtjDCReDiH7MvKke3CzhyItGkiAT7i7eYyQInrlrxdZOvUa1nftDMlZ3af43iO1
	adTV1zEY31fsxYWrMJL6x8g50RCn4h0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-40TGfK0FN_-FKn1VKTTrCg-1; Thu, 26 Sep 2024 05:32:53 -0400
X-MC-Unique: 40TGfK0FN_-FKn1VKTTrCg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8cso4439465e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343172; x=1727947972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viiv1R7Qk2EGD2osRa2/tRj2PEh5xjR8v8WEQ+l48h8=;
        b=QbUh+XfmE0ADVSp6ABxDE6dztys7dUN+ELx628JBGN1aKLFbzZN32nQS7ceu5OzI+k
         svRKh+wN5olKYXMK0ZMo8pM9DYWkFVDdJrSnWtBDvz1JiOS9ThIoXzlqe5Lt7BZd0ti2
         m8y+r5QUawAmrkUNMWNOcaRmshk+ygDMugsUqXoxqxMW/Eks/umfd0qfNIdV9bXeIcGh
         Iw5HGzlLVSb+5YAmrr+Vz9xs6cRlpP5IsudSeqdTBZlu+bRBBva9BnV5mhkwsTF3ilj7
         aSPj4Tcd7AC3Ev7y4Apj7GfLpVUS7PfQQqeyQ6Cd7DyakvfXm3c9yXBswoXHna6WAUHq
         mF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdTcyzNZ5cjksAEa+fCmbpwtXBKox5BkyFIRQpzHlcddeqM2tUJiwkIw57HAHl+JtynQCSsUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6wNT62BwjAUTV1bthoZWQdtt9q9DqYcdmCg1WosA5wV/un6l
	nopAH7J/FBZLBvvgDASWClm5g9oT/1QS//LYP6/anF0qml+1FVWpAvfmOxBKGvBf2SKY/TIBoJV
	bcxR17mL4cQsxW7t2q9K54Y9aGWAeM1PJSBY0SBN2Q9kkphISCAN5qg==
X-Received: by 2002:a05:600c:190e:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42e9610c1bamr38128505e9.10.1727343171732;
        Thu, 26 Sep 2024 02:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENw/jaKF0ZTS+WW9dNaP+bfiB9Y+GVOoQJHXRbTb9+ASAmfl4wzmxgU8LlvJ332t4eckoI7A==
X-Received: by 2002:a05:600c:190e:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42e9610c1bamr38128215e9.10.1727343171327;
        Thu, 26 Sep 2024 02:32:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a168bdsm41800565e9.37.2024.09.26.02.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:32:50 -0700 (PDT)
Message-ID: <327e2020-4cb6-469d-87a4-dddc0bcf7ecb@redhat.com>
Date: Thu, 26 Sep 2024 11:32:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add unshare_test and msg_oob to
 gitignore
To: Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
 <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
 <62f52cb9-1173-46aa-96a0-d48de011fdc2@linuxfoundation.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <62f52cb9-1173-46aa-96a0-d48de011fdc2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 18:41, Shuah Khan wrote:
> On 9/25/24 06:23, Javier Carrasco wrote:
>> These executables are missing from their corresponding gitignore files.
>> Add them to the lists.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>    tools/testing/selftests/core/.gitignore | 1 +
>>    tools/testing/selftests/net/.gitignore  | 1 +
>>    2 files changed, 2 insertions(+)
>>
> 
> Can you split these into two patches. It will be easier
> for the net patch to go through the net tree.
> 
> I take the core changes through my tree. net changes go
> through net tree.

@Javier, while at the above, please split the changes in two separate 
series: one for core and one for net. It will additionally simplify the 
patch handling, thanks!

Paolo


