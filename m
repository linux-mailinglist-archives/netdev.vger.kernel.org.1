Return-Path: <netdev+bounces-238274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66231C56D84
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EF4F4E7B21
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCD2FF648;
	Thu, 13 Nov 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PckbuV7q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qGdl6ygI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764412857F6
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029509; cv=none; b=MBSXSCFwrtYQGWNCMbQGHX7s3U8P5p1qlcd647xfiudMZbRd+Udky7ribMBFl9JZnetI0aJwM3AJfPHJTIn+Hv0O1Zaisi0ldN4HtEWJNX39d/v5tU6ixiTPPgoes3NhQbkChiCXdvx+NgEfjfnlXFYWhWVhpT9YncyHdjd0Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029509; c=relaxed/simple;
	bh=AdZ46maKG+L+E8y81GF5NY44lgNBTKlHPWh8vL6SUHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=th3g7Hi0N+AklBEmYAPoQksc0vdTQTweTI4pPTdmZHq80fbU5SLDNxZF9epv62f3nyHGZOVq2aB+NA23X91hQUjvYgo91IyENAq/ReY3tkR0UhEl2RcI8yj0J9j5PS0YWW7iDQNyaFG1Yy11yL2SWbGJSHlx9IK/EDXkBde/YNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PckbuV7q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qGdl6ygI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763029506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PECF0hu6yUiMcL/Z5zwVr4ADplf8rKig+Vh4qG1P2U0=;
	b=PckbuV7q93aEYsBDKkb/20wwc5/hG7IRrPCMTdhei8bguaCzjdSCHkflded0rifEamr6ND
	a0xJgFKR+PbWDwMuvOlU8NkjEctTrwsNnQ0PXIv3KeIlFQ1FNxFi/ZfoBsL9kNrdPss7Uv
	zJ/rFBJX4yS03Ho6h8CNFkqSXwgIDTU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-5RSz8IK6OD-Ov1oKkFtdOg-1; Thu, 13 Nov 2025 05:25:05 -0500
X-MC-Unique: 5RSz8IK6OD-Ov1oKkFtdOg-1
X-Mimecast-MFC-AGG-ID: 5RSz8IK6OD-Ov1oKkFtdOg_1763029504
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so279540f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763029504; x=1763634304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PECF0hu6yUiMcL/Z5zwVr4ADplf8rKig+Vh4qG1P2U0=;
        b=qGdl6ygIdRHDbc/NLLnMT8+6Y8TODM7LpZZXogRWnfHgoYu1G5I0MEvi/95I56Efu5
         yfZV9YXqaJrWaJxwaZeycX9VJ3b7vYZn5CdUTHI/hnr75rXxIdJRHF9WUD9eqwfYcON+
         BFKolpgO1meAK5ENtBZhMhjGQDFzWcx2+gopIjxn/eGbfbywA7pDzdK4y2kq8u8bNTW5
         t8NkSJn8mlvzgLUlxBl67Xzz9g40G3/YyQMsolfpLYn6/tM0Xf/wyeklNp3i/WlzTCG4
         AsZ6DiJYRrVWTBzjsqwPxSrXiNMH5By1SroWcEg/i4tnRqGzgIIeGjM2GUEVkaO2P1sL
         Oq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029504; x=1763634304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PECF0hu6yUiMcL/Z5zwVr4ADplf8rKig+Vh4qG1P2U0=;
        b=l19lG4pXRSa0PEZ232klfNefcKJTayg8IjhcUjBleKYGiP08SS6HcDPsegxLgrGwfR
         OCpzVfDpYsKszBjCr/poLdbIM1s8F/RbHnDVhfvH8u0jPez8Yjc2KnR02fsj3rOsKXiG
         +f1TkzfxQV/NMIF1ke4c1fdi2j9LrKR0J+cbYQ0Swb+XpCze7OGY74pxCt2hsRxynY72
         TONr7CALJRfSk0NYX6bqm4xm58S28hh1kZOV5/LhCthAL76N7MuXdOuKXHQOSGEv5P8P
         YYbrF3/TAsemwSetwUYR04oaoKDcTIko2hE3leqSixWxw6OiGGxRSe6MaOmVdxM/zczj
         gsZA==
X-Forwarded-Encrypted: i=1; AJvYcCWVcJXxT3mocMoYlVG+yDS+tSdyzPz7CT4NdozQ8PB/F5SUHZpCRiw/8nAV25Qfvf3gOOkIANI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywei5JEUaPr6MfmqSL5N63vvf+NwJmM28fSb4mkjysVDRJjdWsL
	pr0r9htl/JwuuKnACUQSabHSHWYRAMPai2Zd+Jw5S+U3RzpWZZJddrtyJQ0t7nkTEyqM0arxJ4N
	rsm1cOljepS9N50XnycYs37P6x1QQjGVq1IhdWT1mwBgxerg+vKuyyYCXiw==
X-Gm-Gg: ASbGncuTivCHk4cT/Xq58K9o5t/AZ5sokYqGs9C6npVB777pIzXMuAI4Jx6iKN3+aOX
	6LO8q5asQp4XngxPpj3j/u4+KDFytoiF1LhGSFpN3LCSfDOuzMGm6h3lZ3nChw4DFoGHu7Vnwuf
	DA/+hwWOUC0/fQWK2ad5YVDZDP+QHQCn8P/AhNOBCNZx5SChQL9JdzGrJv4bkCDpTmGXHlsM/uz
	lUX7UC9VXBAXTO3xFOPZBeACdbMuaPyJZxJhQvSvydpn9yrhLylpYyJXUIZHGmw0+yCP+nkdYJ5
	4i8MYT5PDqqPHaOi4L9Hh4ULX2ooxacIjqSyuvnKYGK6cpaWK198XCPHAkooNYjyxjy58Odz69P
	e5baXn5jrpO5u
X-Received: by 2002:a05:6000:2a88:b0:42b:39ae:d07b with SMTP id ffacd0b85a97d-42b4bdb85d5mr4745415f8f.50.1763029503896;
        Thu, 13 Nov 2025 02:25:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJkaZOemYguID9V6H2FbBGyHiwc5M2Rg6bywmRqobKBF0bhnHhJwhbKd4VWDKKkEMGHc6pWA==
X-Received: by 2002:a05:6000:2a88:b0:42b:39ae:d07b with SMTP id ffacd0b85a97d-42b4bdb85d5mr4745392f8f.50.1763029503459;
        Thu, 13 Nov 2025 02:25:03 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm3040291f8f.2.2025.11.13.02.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:25:02 -0800 (PST)
Message-ID: <dc26959a-ee51-4480-9a03-2fe4fc897f70@redhat.com>
Date: Thu, 13 Nov 2025 11:25:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: bonding: use atomic instead of
 rtnl_mutex, to make sure peer notify updated
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
References: <20251110091337.43517-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251110091337.43517-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 10:13 AM, Tonghao Zhang wrote:
> @@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
>  	return NET_XMIT_DROP;
>  }
>  
> +static inline void bond_peer_notify_reset(struct bonding *bond)
> +{
> +	atomic_set(&bond->send_peer_notif,
> +		bond->params.num_peer_notif *
> +		max(1, bond->params.peer_notif_delay));

The above reads params.* without any due lock; at very least it should
include READ_ONCE() annotation here (and WRITE_ONCE on the param update
side).

But it also mean it could observe inconsistent values for
params.num_peer_notif and params.peer_notif_delay in case of concurrent
update.

The possible race between bond_mii_monitor() and
bond_change_active_slave() concurrently updating
send_peer_notif is still avoided by the rtnl lock, so the changelog is
IMHO confusing WRT the actual code semantic.

/P


