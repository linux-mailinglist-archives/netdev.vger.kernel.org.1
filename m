Return-Path: <netdev+bounces-213806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D672B26CA7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5911F1894F72
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37A25525F;
	Thu, 14 Aug 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pky8pzu1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F332143E
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189551; cv=none; b=rgXwKGT5uihY0XuQhZb3dU73E+6rDSoQrHwo/50wgzIWj3/k7LWH1UBK4FrUJtlw/7yDr75qwwUWFdsepXw101mDZBSUiQgJ2BGTogvefsN3p1WfklRHU2C09gar5iCQSfmliulNTrorJRJM7VPhCwo4h/vXa+RJ8HjJbnK8SYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189551; c=relaxed/simple;
	bh=Ct3AlCX9y7uITZnfTBKFstgzg9M7TRjpAiedsB+/+t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCXzHNNoLC6GDBMqiJ9eXDjgoN5dlJ+Y7C9ne2GO8LpaKTXLymHllBS0QnY7+8XLRi0CvEdy+7uqNxzix3V+TAn9t5I2xw0a53s+UZRu8d6H6hrJ/pur9xR5ZdZfv5IScJwdpMA8uF9GuomH3x236M6+8dp65xIwo9Yru3N5Ct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pky8pzu1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755189548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEppqHRat8wdl1XJP/AmPAnMYfhGQs9tTXWZCX2wRso=;
	b=Pky8pzu19ntYVkJ2WRZ468rd3D4ZeVMjfYVOrIUchc90wnth0ks3L3KpfjsuuRDzmwB92J
	R2MkcD0vnV7Cmw0FO+ykbz8o5x2T07Et89gMe3dZ31Rcc6gBiJL/SbElv6LTtVe3EYfN0Q
	1tMxjKxSY/lLwb3DycAaw4drgw/ho5w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-VHAhCOB3P8WhLTXl2gz9aw-1; Thu, 14 Aug 2025 12:39:07 -0400
X-MC-Unique: VHAhCOB3P8WhLTXl2gz9aw-1
X-Mimecast-MFC-AGG-ID: VHAhCOB3P8WhLTXl2gz9aw_1755189547
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b1098f6142so21180761cf.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189547; x=1755794347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEppqHRat8wdl1XJP/AmPAnMYfhGQs9tTXWZCX2wRso=;
        b=btgemJmW3L69C2xOEzUmSsqL9m8nZlwQGOrwSguSHW+j5izkFcO1ppT+GivLVeiqDN
         jCaV7/kqLJDQByCi55Iu1gFthY9XdmSV/PqvsQkr6pI+Avkryx8rvWRIg0/DO+aKEYRa
         17ibv99YbDIlFQAB5SFszqmj8/XCK+EN8zjQk5hqVqJTerUwsChM9TOt9hveFCqTNm1n
         8/bYn2lNxi70YFcxFHnNLDvAoGaFOgwsXwXEV/ydO+QreXCgTTwH69PpxaI3aOt+Iox5
         TTrrvNVBSOFOBRJD1E8ymZB7LuF6dn51bYBmdUYz2IWgbbghV7chIr1U/IDtDkIS/0oV
         Xr+w==
X-Forwarded-Encrypted: i=1; AJvYcCXhTjvOhaPUKBo1YY/pMo1aWkxXxOXmWUz4drumkfV4jLeM2+OpmLhy72aDi+sB0Tibx5++ru8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSD4NUE3RL3Z2KEpSBV7g1XuuuUGQIX0yH1x37v9TIqQ+7XY/
	cPqP2aAw2SbMpCg9nwapESCPwSG2Jbe06NA833uzEWWy6du7ZsqP42PCFpcc6wU8UDZjjUwPzHg
	FUlKUvGyBeBdlIZeSFLO3zdix/enY/H9QNHIXck7Qd7zKZssxeOzTU2o7QA==
X-Gm-Gg: ASbGnct8YoCZgOh/2pkbkanVMJH8ICZ6wnkFKwArZnQ7GPqpvzWr2Y0/FjvNXvH1vmE
	d3AVN3BqH+jpxiyPhJspj8OKUAXR2ltMYvxNMUXxkUMm1ZiP7cDNNKMMAAVyFBTmo5VXDSYG8uC
	nbtuc8uC/ltCWtEBmifpU5XE6vsejSk8KBulJaNCMQebl/c3/YAI32DRVCe56C6OJyPYicNK8wU
	q+PRbtOSRD/9fT0Iw56p3rJns4fSfMmJ2WyEjNuXW+HPw9Lyb+1NAO8Kz8A4WgtUalVASiKUFiq
	3YGv9r1aYpH3z8CJwgdFINz7CcXi+oIxrrJMcpzQFBv/PILm+rOA3YnA/0guNVbCFlC/CZwNS38
	MS+5UF6ejqEg=
X-Received: by 2002:a05:622a:1184:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4b10ab0347amr59453851cf.52.1755189545354;
        Thu, 14 Aug 2025 09:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKUjrf6zEGnC5XjqPBLZygAVO7rTB7q+0IX3fp3uYGp65uir/+shuhMTShwPePJjxp6HVFzg==
X-Received: by 2002:a05:622a:1184:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4b10ab0347amr59449781cf.52.1755189540057;
        Thu, 14 Aug 2025 09:39:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87b1d63a5sm56785a.0.2025.08.14.09.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 09:38:59 -0700 (PDT)
Message-ID: <ed68e6a2-f9e8-4523-9104-98a97b54b153@redhat.com>
Date: Thu, 14 Aug 2025 18:38:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 09/19] net: psp: update the TCP MSS to reflect
 PSP packet overhead
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-10-daniel.zahka@gmail.com>
 <a6635ce0-a27f-4a3b-845a-7c25f8b58452@redhat.com>
 <d78db534-b472-47c4-829d-83384b537ea2@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d78db534-b472-47c4-829d-83384b537ea2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/25 4:50 PM, Daniel Zahka wrote:
> On 8/14/25 9:58 AM, Paolo Abeni wrote:
>> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>>> @@ -236,6 +237,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>>>   	tcp_write_collapse_fence(sk);
>>>   	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
>>>   
>>> +	icsk = inet_csk(sk);
>>> +	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
>> I'm likely lost, but AFAICS the user-space can successfully call
>> multiple times psp_sock_assoc_set_tx() on the same socket, increasing
>> icsk->icsk_ext_hdr_len in an unbounded way.
> 
> If it were possible to execute the code you have highlighted more than 
> once per socket, that would be a bug. This should not be possible 
> because of the preceding checks in the function i.e.
> 
>      if (pas->tx.spi) {
>          NL_SET_ERR_MSG(extack, "Tx key already set");
>          err = -EBUSY;
>          goto exit_unlock;
>      }

AFAICS the nl code ensures the SPI attribute must be present, but also
allows a 0 value, so the above check could be eluded.

/P


