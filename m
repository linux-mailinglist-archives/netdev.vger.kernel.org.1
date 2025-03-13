Return-Path: <netdev+bounces-174597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9AA5F6E3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B43B88041A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE8D267F67;
	Thu, 13 Mar 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z97MaFyE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CB267F5C
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873939; cv=none; b=GawbeV7uItJJMPVCIpecq7b2YtYDhZHxaIgqw3RiiGesFA1/+uIWrtm4hFmTT3wdSvK9gqWcuKRtPy9V9rDZGfNHhb6cuv3p1FWqqTsfj5iQKGYKZQtO7E0EJyWK7cBtUW+0zaLSOQjbfP7RLW7mZP/Nnr6/n6IQOMZzAUEc2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873939; c=relaxed/simple;
	bh=+nzZx9ajjnQBt2TeA0HnBToTjx+jVg3oi9qxFXOv9R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeH4OuOM1V37Tr0kxkmwamhV0YEbOK1yLcqgKnnuQ5a+sskRHGDSMnlXfKE1NOhC2XbRUhDbKpqR7iRvg4xFQ01pFTIoA1b5/MmFzZ10E8HKFI5SXJeUDsEMjiDQSgydyFGIQJhVBsyCecwGRVMpBk5+sMAZ5++O5n0rWBmoVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z97MaFyE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741873937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al2zSVYkpwujGOmTgK9tfuhK7r0I1FYHf0bUIOZ4izs=;
	b=Z97MaFyEfn5iqS5z8AtCuc+Z2N1rFI3fsoDoksml8Kk6ywgu54/SprawVqv+iS0zUqDSLQ
	eCzDVnqsFFGEdz0E2tM6rkbSjZh61zNaCQvmY/c2+SJjIaCvYVKX7xPxnpXNhZC5A1qgUO
	7MJ18uc0Q+zUmwISciW0a/jv/tPKA8Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-MYwff8VOOU-5N7pTOhjFAw-1; Thu, 13 Mar 2025 09:52:15 -0400
X-MC-Unique: MYwff8VOOU-5N7pTOhjFAw-1
X-Mimecast-MFC-AGG-ID: MYwff8VOOU-5N7pTOhjFAw_1741873934
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so7452785e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 06:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741873934; x=1742478734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Al2zSVYkpwujGOmTgK9tfuhK7r0I1FYHf0bUIOZ4izs=;
        b=rXBklIvrnvhSTuh1Frn3DSd6iCzDRkv5TDxTKlB6albhYRtiRU0tBcbOsiEjEQl4V6
         l2cDsngIdVru+dMrzz6j5L6MeeP3PvVXMkCQCm4eFF87a5+KHGEvI+sHT3N1uq4ucpVl
         dIF+4GMQrvA2myY7x02BBHPZ3Npk7HQLKbWheWWkZjEtZACblkw7Kar663TA8WBP4VnZ
         1myoQeM5aeM0S5TM85B3WGvORfOQ9N8PK7BuPajgsJudpqVXIbyW274K/X6MSAt5S1q+
         BntHtjtkcGgLBkqbTwo2E4xxAn24Lsl64/qEis8TT6/b4Ts/NnbSGXqzY8kIiQoD32H8
         eHkA==
X-Forwarded-Encrypted: i=1; AJvYcCW0fwS3AWAVeDtFh66XBZX3HgMwZiMO6HeeFZhwpqqVhYcjnpuekFat6gU0TS7vhMTR0HNf3WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwucZFx6toiwGcyRa7j8o2KmrbrT/aGFBszHvsJkzSjUnjEWzNh
	10aVHbf5OGkpgLUjYwss6Ifb9IkgFNPvMrzLUMbMNwThosjV6bkvRXO0YJzqMH1DqyUNUCjbmSR
	oC9lhKF9CpwNodC5nfODxc3eEBWrhr0eui87pQGOD0TFP4x27+9b2UA==
X-Gm-Gg: ASbGnctu4MmvuIXW7+2sIZNFAwSAZfnUF/wWQpeo7G+P+tkm/BUeeDphfsnhWMXQpBd
	PnrKGWpOBVlVv8QhYxVOgIVsCxH5o/zDX2x+SsExaY4C+g/NQc2d+ccGO1PJ/uiuMFV6kWixP4k
	sBndX4KS7wLs9I0BzCaWEnUugegF/hFtqU5BmEbp/ifur4HYnl1eOducvzqjHkRgYolHGo+jxOr
	IK0ydpz+FmTNM2itIg7JdiHCmLAZBPBK6mDj+mwvmVZMXnvj0pkDKq7M6/1DlRTKoR0uscPCu9f
	6J9lH8QRu9IqHIQtyfwHpm/kfGG2BKKuZyLI+xTv
X-Received: by 2002:a05:600c:4e8e:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d083a43ebmr79929215e9.12.1741873934378;
        Thu, 13 Mar 2025 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgGbs+6tRrG5la6evXZMVQfIWrs/oMrajOJ39y1ezJw/eF0m6pNVRz476LEd8IvmDKYZqB8w==
X-Received: by 2002:a05:600c:4e8e:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d083a43ebmr79928905e9.12.1741873933991;
        Thu, 13 Mar 2025 06:52:13 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d19541339sm17962415e9.21.2025.03.13.06.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 06:52:13 -0700 (PDT)
Message-ID: <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
Date: Thu, 13 Mar 2025 14:52:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
To: Ido Schimmel <idosch@nvidia.com>, WangYuli <wangyuli@uniontech.com>
Cc: andrew+netdev@lunn.ch, chenlinxuan@uniontech.com, czj2441@163.com,
 davem@davemloft.net, edumazet@google.com, guanwentao@uniontech.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z9GKE-mP3qbmK9cL@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 2:20 PM, Ido Schimmel wrote:
> On Tue, Mar 11, 2025 at 10:17:00PM +0800, WangYuli wrote:
>> This is a workaround to mitigate a compiler anomaly.
>>
>> During LLVM toolchain compilation of this driver on s390x architecture, an
>> unreasonable __write_overflow_field warning occurs.
>>
>> Contextually, chunk_index is restricted to 0, 1 or 2. By expanding these
>> possibilities, the compile warning is suppressed.
> 
> I'm not sure why the fix suppresses the warning when the warning is
> about the destination buffer and the fix is about the source. Can you
> check if the below helps? It removes the parameterization from
> __mlxsw_sp_acl_bf_key_encode() and instead splits it to two variants.
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> index a54eedb69a3f..3e1e4be72da2 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
> @@ -110,7 +110,6 @@ static const u16 mlxsw_sp2_acl_bf_crc16_tab[256] = {
>   * +-----------+----------+-----------------------------------+
>   */
>  
> -#define MLXSW_SP4_BLOOM_CHUNK_PAD_BYTES 0
>  #define MLXSW_SP4_BLOOM_CHUNK_KEY_BYTES 18
>  #define MLXSW_SP4_BLOOM_KEY_CHUNK_BYTES 20
>  
> @@ -229,10 +228,9 @@ static u16 mlxsw_sp2_acl_bf_crc(const u8 *buffer, size_t len)
>  }
>  
>  static void
> -__mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> -			     struct mlxsw_sp_acl_atcam_entry *aentry,
> -			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
> -			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
> +mlxsw_sp2_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
> +			    struct mlxsw_sp_acl_atcam_entry *aentry,
> +			    char *output, u8 *len)
>  {
>  	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
>  	u8 chunk_index, chunk_count, block_count;
> @@ -243,30 +241,17 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
>  	chunk_count = 1 + ((block_count - 1) >> 2);
>  	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
>  				   (aregion->region->id << 4));
> -	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
> -	     chunk_index++) {
> -		memset(chunk, 0, pad_bytes);
> -		memcpy(chunk + pad_bytes, &erp_region_id,
> +	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
> +	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {

Possibly the compiler is inferring chunck count can be greater then
MLXSW_BLOOM_KEY_CHUNKS?

something alike:

	chunk_index = min_t(0, MLXSW_BLOOM_KEY_CHUNKS - chunk_count, u8);

Could possibly please it?

/P


