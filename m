Return-Path: <netdev+bounces-251421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 319F7D3C48B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2D01548140
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5D365A00;
	Tue, 20 Jan 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIRWki+a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6VjzBMo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AC346AF8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902859; cv=none; b=PeoNAZDGj/ElGeBhu7O/R30BpDSlOATjYcSuGGRbvsxT+lsM7htWO44PDrv3Ku948Gx6aIT6XujzQMviGU4Rxua8oJX/iWaAWUtSA6oG3PcmfrtlgCFXQsE8DCF+n4//r4dp8OfymFaDhswE7pv3yXlyrYgRDLPFp1D0jkj9C9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902859; c=relaxed/simple;
	bh=HQ6wJ4Bhrdvh6n3nHk7OFTyGqzg+vXdzFzjSE2ttaMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=be1FjQbZ3Yk5XqQ9moVHDEk6VpZljwKadTgkGDCZpYkjG13pI/y312xd2Aygr3AiXrGxF9hVt+mKXH1I1HKghOsEXsEwyoctoa3Wq9C0ne1EC2PBLhAvqHSCLjoy1jHrq18N4P1FdSANN1SLFljiVibau6VLtM2/zE9io2EIYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIRWki+a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6VjzBMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768902856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfNKiVzxBTizUBnwJ9kc5DIY2uEEk4tt8Fkeu9u8yEQ=;
	b=CIRWki+aCPEhKmen6cwlMmbhgIW2Hi1KkJIWXNNihXy25oPSxzIi8w2qk7onLyKNIO2NYo
	4woiFYjWDIJyf7ZfXMYL/M5kaRVxqXdYEyTbeqXc2Gy8x1StopOK2BxF/CtHPZg4KzTefk
	qbY026XriQk0OVaCjruKIOswzbGmFeo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-AjgC_HKaMc-regFOQ0qcFQ-1; Tue, 20 Jan 2026 04:54:15 -0500
X-MC-Unique: AjgC_HKaMc-regFOQ0qcFQ-1
X-Mimecast-MFC-AGG-ID: AjgC_HKaMc-regFOQ0qcFQ_1768902854
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fe16b481so3353361f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768902853; x=1769507653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfNKiVzxBTizUBnwJ9kc5DIY2uEEk4tt8Fkeu9u8yEQ=;
        b=B6VjzBMofyHZ1hA24Z8HOE9i19WUwOAal0V4H3Xz1fwFDTSMKZChqoyX/NnomCwo+L
         J9TcLZoH4jE7zvgSEKtgVeWpRkwSfCnlVQ0FxxUbuaYUKwEQ2yu6yus8fHKrLFRzqkNt
         sxDd/GXrWOP9iF5CVGV0I0YUfjwdQ7YHoDQG6FbrF8j9EqmN+URS9jyec04dok119slm
         8IrNa6B14OLXL/9S9SdcmaJqmkxl+pd7sK1NVpLeTM9fUt6N2Xo8t952hDb4aooFkbpr
         eHbzbPFsg3kxnSPQvyOeDks4/041rBFBbD0EXgZhMSTENv+JyRIWyytEk2ytskBxiEhA
         jn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902853; x=1769507653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfNKiVzxBTizUBnwJ9kc5DIY2uEEk4tt8Fkeu9u8yEQ=;
        b=iG0fvh6NwBCBCn6HjJhh9ATLefCosr7I0p9HgQ/hr3JNIEIYLxXGUB4owUYROlV3HS
         fIb6vWfPYsUyIcy6q+rJZklWgxq4Uy0gOiPPq2ZY5bOHn+JCnUGQrf0jrJ2/uPz286fp
         +EHY0aEZ7A7UB9a0kWy02PiM7IW3pmv65gkm04Kb/uA6ebPnJOcf0aZxX0vzvhNWdRHK
         RKO5UF9EU1ss7t9dHS/Y8m8LpdFarkB0t/Mbwa9lPQOKxBF8/drDbuJWa77gtpJ7XMCk
         +gzhvE0BSxLt3ncxmDqdx0eiBKUaR7g5Vukf6Tm1/JmtCdlSoyafO4KvQSrH5Y29IQW0
         rong==
X-Gm-Message-State: AOJu0YwmEsNI4DRFR2G8/ByCMPLPVCztWuYb4O/HHcZ5TVWUM6i5Ju/E
	3OmNvta1fML2pIXM6NSKYO7lMrx66sHsIuJk/0qkHM9k1l0x9iQXovNeyyyEGB1Kyfs99ATk+f+
	PSpT2sCz7WgyAPSFrxcYwBfg+yvZtGYxxmFOHKIr0gTmF4UYF80SblW4e4A==
X-Gm-Gg: AZuq6aJ5jtMiEyAgleVqNRnxx+aqQ72/dn1ZWo9PTJ4DiBtV7XYyLlyDMw9cd4og15f
	U+WuC//x7THZGWBMxj57UyRfCksd4K1G7TS5H0ZeVOCaDXepAjzbNt0dzJQ+hSVWZ/vgrAalgfM
	JHZiN6qIxO6kOhmw5GG/3xl6KPVKqp3e61PqVcgs3ScvwFEhMvldqrLipw1PjUJomcxqbu8aWWc
	v3n0zqsaz//g+iWB6tB669h4h1ARqrIjmgnhn2WdbTn0xdxAP4+JVdKr3ICVEiCujaijm4LWq1f
	2v3crM0ZhXHtir7lBz+kol5tCJDSsNInT1NFbeXsfT2clZPYOYFzoBJlIGAmo4ClShEVLc9/GNA
	LbIr377BNVWtk
X-Received: by 2002:a05:6000:25c7:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-43590174d1fmr1655186f8f.44.1768902853094;
        Tue, 20 Jan 2026 01:54:13 -0800 (PST)
X-Received: by 2002:a05:6000:25c7:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-43590174d1fmr1655150f8f.44.1768902852700;
        Tue, 20 Jan 2026 01:54:12 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27853162f8f.4.2026.01.20.01.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:54:12 -0800 (PST)
Message-ID: <88981dea-63b5-4e50-89ea-f4ad38314504@redhat.com>
Date: Tue, 20 Jan 2026 10:54:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 01/10] net: introduce mangleid_features
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
References: <cover.1768820066.git.pabeni@redhat.com>
 <ec64bb86298c31608eee9558842da25c47669f9c.1768820066.git.pabeni@redhat.com>
 <CANn89iL1sJMe-j9n6--gdRwwkjpAD0TdDrS43N5g3=9HWUCOtQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iL1sJMe-j9n6--gdRwwkjpAD0TdDrS43N5g3=9HWUCOtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/20/26 9:58 AM, Eric Dumazet wrote:
> On Mon, Jan 19, 2026 at 4:10 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> @@ -11385,6 +11385,12 @@ int register_netdevice(struct net_device *dev)
>>         if (dev->hw_enc_features & NETIF_F_TSO)
>>                 dev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
>>
>> +       /* Any mangleid feature disables TSO_MANGLEID; including the latter
>> +        * in mangleid_features allows for better code in the fastpath.
>> +        */
>> +       if (dev->mangleid_features)
>> +               dev->mangleid_features |= NETIF_F_TSO_MANGLEID;
>> +
> 
> It is a bit unclear why you test for anything being set in mangleid_features
> 
> I would force here the bit, without any condition ?
> 
>       dev->mangleid_features |= NETIF_F_TSO_MANGLEID;

Indeed the check it's not needed. I'll drop it in the next revision, thanks!

Paolo


