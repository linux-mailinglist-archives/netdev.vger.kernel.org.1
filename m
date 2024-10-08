Return-Path: <netdev+bounces-133009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B7F9943E2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3F5281B98
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7707718C35E;
	Tue,  8 Oct 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OM7wCO67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EB188CB7
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378861; cv=none; b=asdK47jG7ajPpg5hUmkeuq9bO8J8KuMSZ837vb4mkDW8UOqems0SpvbZk4l3JkqWCWgFBOsXFRKoUU1ThjYjm/lM73JRdoYl858VKZxHIgYv7+DqU02WJtlm3LTo+l+lvHbBW3khgtoTpO+rtvM0PgNMHW/rjNKS8SIAn5mAzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378861; c=relaxed/simple;
	bh=h0XoJmnxeuzgLK3XsE5ue6QNSKsebyDFmi/AyV0doeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKu1dlc4VxjxIQArO3bbrNyf8P1IGk//wvtGkY9WcvZobyreWEESJki4+pOrD+SMKF4BwiHkx/6P87RAZiQMnWLR6MmWSS6Wm0SXu5tgGbJQ1xLTIj7gAPY3zP+ipPBKcOXtNymS7OoFNHcjAi0IyGiPc9i7ZyJkaSDIFGIblio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OM7wCO67; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728378857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjzBqg5gmnyslj1f7FzCfy4oe6l+aeujhqIrttDmUiU=;
	b=OM7wCO675OHsJu1LLpzoknx+RXC/DWmGVw2N81q2wzQuZnguP9f5It0dcmnKWCF/u1VT2q
	eObk7+9opeNibZ2UWbrosJZCULLbNdLl774R2ZZ1oJ7KbfOdjI4/RUD0Ltq9jiyQqh4Awq
	mh3qgJBz3FHYhv3vSdH+cw1wcg9dcrk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-fh40sO8qMFWGLz2Gp3SEjg-1; Tue, 08 Oct 2024 05:14:16 -0400
X-MC-Unique: fh40sO8qMFWGLz2Gp3SEjg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42f8ceb8783so23071235e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 02:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378855; x=1728983655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjzBqg5gmnyslj1f7FzCfy4oe6l+aeujhqIrttDmUiU=;
        b=mwLk0VPeUZ6IngwTVDMgk7mpHuavCkUmxYmRfpei6VUoWnD9zXtmQQjlmsjU2jq1Ra
         oIl4E34EW4LHJKpeS9JJKM9aEX1CQbkA4OsYzMJTIW8rbIlFNJ6LCj80aXSr8YM+Z6FH
         i1tjLGACPdM2Dy1C0OIH9ZLuBWeUzUI70kfBCGADTQpRxW9+H0EFgSoO8ydKj/ROCclj
         IVp4wM6HABNAMHLFmTTk36S6++PXZBujrdlN43EXW5idguBOUwR3hOxT5684XW114plp
         k1/4XYbUavMnVoJnSCCkm4XQIyudtyJaLbH6Kjq39LuSC6ibTNNr7O8r6A4ZYGzWwmav
         bk5w==
X-Forwarded-Encrypted: i=1; AJvYcCXVwk6YX5A+N5GuILd2bcs8NkOIcjpLlgEQHYX3BTUJx7lwXCtVtwkxxm/SEosnkyJa3eyUofI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkzBkMIRDw2fT3puQf9bd+t39yymECmed0HSA3JWaUQ/y9z2j
	uKyCr/97gTtA0Pt2R202bVSslMEmModVAAWqE+Rc2p3yLqilKrwgM2PGG8G6sO9sBSNUKdU3Cu8
	h8EpuQS+/YxZHbrQ5/K9lXB3M/P2Dqi7VQcfTW5hSbSMK83W3bcbWQw==
X-Received: by 2002:a05:600c:468f:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f85aea086mr109974435e9.28.1728378855368;
        Tue, 08 Oct 2024 02:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEntxED6Ajev+yYqCnvqbFQbY5VYJc60hLz2Tup0O0K/v+7ozifBz2tuAGRqhC6j91M0iDvhQ==
X-Received: by 2002:a05:600c:468f:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f85aea086mr109974165e9.28.1728378854940;
        Tue, 08 Oct 2024 02:14:14 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec63c3sm102594535e9.38.2024.10.08.02.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:14:14 -0700 (PDT)
Message-ID: <6db0670f-6a39-4a23-94d2-5b944fea8dff@redhat.com>
Date: Tue, 8 Oct 2024 11:14:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3] idpf: Don't hard code napi_struct size
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
 horms@kernel.org, kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>, Joe Damato <jdamato@fastly.com>,
 netdev@vger.kernel.org
References: <20241004105407.73585-1-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004105407.73585-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 12:54, Joe Damato wrote:
> The sizeof(struct napi_struct) can change. Don't hardcode the size to
> 400 bytes and instead use "sizeof(struct napi_struct)".
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index f0537826f840..9c1fe84108ed 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -438,7 +438,8 @@ struct idpf_q_vector {
>   	__cacheline_group_end_aligned(cold);
>   };
>   libeth_cacheline_set_assert(struct idpf_q_vector, 112,
> -			    424 + 2 * sizeof(struct dim),
> +			    24 + sizeof(struct napi_struct) +
> +			    2 * sizeof(struct dim),
>   			    8 + sizeof(cpumask_var_t));
>   
>   struct idpf_rx_queue_stats {

@Tony: I'm assuming you want this one to go via your tree first, please 
LMK otherwise.

Thanks,

Paolo


