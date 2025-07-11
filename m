Return-Path: <netdev+bounces-206223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72164B022D6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686B61C27DBC
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54F02F2363;
	Fri, 11 Jul 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJqYaoBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8F2F2342
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255688; cv=none; b=DeQ+eTnksU/8kMliL24GVlMNw8MrwjDxMlkSsTnfCp80seoUAkR23hG00LHc5bvXs4o7dODxxr2PU9CNa0oKb6SdslSK6Mvv9FsB3/cRlfdohvuzyoHA7FbRa6BOy467triQ1zsncxNN7GNTICJ6zDQ0uWoqlSIvz8tZ7oqgo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255688; c=relaxed/simple;
	bh=6VyrdOhz3OpJpcaWmKE9X2nQHoJVwliO7EyG8elUc4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lxhpw8PXGlqsMsqzVcUtPbClFiZEoOKmDN6j3m7ZPF8jeNbFAQ3BK70PoChycql4PYQxOAnJlJRJVMh5H8aotJiMJd/Ehy8VnGM18jJgfdioehhAikVEkO0lAXyurUd1e7d+tHW6J3FGSLtxZdLBZXG7TTMT7yPYNptAIlUjZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJqYaoBb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d5e18860aeso137999885a.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255686; x=1752860486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nin+9OknE6cMvI3bP7mEA9naVL+nmwYUXCjyoIRSmn8=;
        b=DJqYaoBbvV/5E/gSc+dINfLibUhzB5mCj41HDiL4eWx160/BfyQ+wNnSsiw3SQ5a3Z
         j7LvdMCd15ICwaxQQ/mClTvJN/qesme0W5CQj99sABX7pGdG8qB/XjpRkxyDS6MAFU70
         WJqff87lGR/hKnn7vEdpkv7ROiB+toFSQtYJWfoNP3ktlJJWZqlHKGCoYYqSieItrMTG
         xxA4bbjR49ihP1CkubvqYi2f3T4qPiLswrPfVlAwb9ogImg/u0nC7bwea/VqCr65gh3f
         T6DUSZRnEP3XZzqBd6a3wbZTj41IHkftMQylPDHmjKBAAz5EXI8aAbg+a/pdXlh7jK8E
         ISjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255686; x=1752860486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nin+9OknE6cMvI3bP7mEA9naVL+nmwYUXCjyoIRSmn8=;
        b=occWRHx3T7e2URn4sINFKTqO/lFRhoC7Y/TdzHOSjAb4RW0NIbs0E8ZPiLSwD7AegI
         vNxHqf/6JQn7KMEQFfMfC6dqtBZ39Cxevon/wAhZF+2QT0cPE0d2S8N7cgk7Pwo+8+d1
         FM0th+ZnTTb3sY7R46T2TxL95efGBKZxIkbdYc6tng7nQvAMBZ+OHmfiV2gVlkfI0aCD
         6/gs4xn+tjsnu8ZVeaGOVrRoheDLhddwFyVgRS7luFoq0SdOCiPrEGbog3vau0+ZQyVH
         hCXikXaksXTteFaCI+Sc2YJkXZvKC7OMqBlUOTROpPSKUR8DMdwSIYLQhsWL2UJBHXJF
         xIHg==
X-Forwarded-Encrypted: i=1; AJvYcCUjHAt50AInQfmYIVnmNN4hZc9M2gwZEuynk6KviwGJGlUktgKPA8nk85YZLQQm2QQ1YyIYx5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzT+PBsURJgguDgoAbgVHUwf+ugup8O2KBZOrxVfwdIy36RZ6
	72+9XitN3nquj2cronXZDhrf+rFK1I2rR8OVHeyPY+cQLnlR1QLLdw7/
X-Gm-Gg: ASbGncvSlUZiXDLfjXl3XSBCyQPOW9QUHsf6ftoRK60ZBv2y1vQcu63WQIpd03pHm1P
	XllFCOhej/w5ktgRr0+wl7+mXmoOY478pn92s7laJkWPWwcRhYWgMKYkBnjtrH1a3AM5fBRrW3z
	mKlLTcqYC0j8efZjMinB097piWbPCwsOzALy/zzELQ04nlxk8TMhqrNHnbT5wKwbryNbizBRVSG
	tc77kuqeF13Ao4bxULM8P+TzbcE67RSQwGp4KB4Qj4ZJeybjDzoMyTl6jTQm0KjNDYF1IfJs97O
	vELWdrCQUd0IyEa33S2ZXciVo0wEXt4964tv3jW6ElJq/Yq4QV7+M/MdR0A/yEwPLOTQ7A3S1h5
	+dntqKgIfOQiYQA4VfS3yruNfB20GiY786yvCOkuTqO6IOUzgbRcVEaYB6jHWwcC5haVU/1tEFb
	rN
X-Google-Smtp-Source: AGHT+IEBw2nvt/3MNR+BpQCtwmfrhfWrsE6qLvo2OFQZ93WCGpg0ykkC9UZTcYNwVOHb4lXgR/gxfw==
X-Received: by 2002:a05:620a:1915:b0:7d4:49d4:b908 with SMTP id af79cd13be357-7de049d815fmr537307985a.3.1752255685643;
        Fri, 11 Jul 2025 10:41:25 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde80637esm241892685a.85.2025.07.11.10.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:41:24 -0700 (PDT)
Message-ID: <061ab5b3-55e2-47bc-8515-3f6b8b4ecbf2@gmail.com>
Date: Fri, 11 Jul 2025 13:41:23 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] net/mlx5e: Support PSP offload functionality
To: Cosmin Ratiu <cratiu@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Cc: Boris Pismenny <borisp@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 "kuniyu@google.com" <kuniyu@google.com>, "leon@kernel.org"
 <leon@kernel.org>, "toke@redhat.com" <toke@redhat.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 "willemb@google.com" <willemb@google.com>, Raed Salem <raeds@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "sdf@fomichev.me"
 <sdf@fomichev.me>, Saeed Mahameed <saeedm@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-12-daniel.zahka@gmail.com>
 <0e7d382ad191c19aed123ff0c2bdda7bbeb5268f.camel@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <0e7d382ad191c19aed123ff0c2bdda7bbeb5268f.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/11/25 8:54 AM, Cosmin Ratiu wrote:
>   int mlx5e_psp_generate_key_spi(struct mlx5_core_dev *mdev,
>   			       enum mlx5_psp_gen_spi_in_key_size
> keysz,
>   			       unsigned int keysz_bytes,
> - struct psp_key_spi *keys)
> + struct psp_key_parsed *key)
>   {
> + u32 out[MLX5_ST_SZ_DW(psp_gen_spi_out) +
> MLX5_ST_SZ_DW(key_spi)] = {};
>   	u32 in[MLX5_ST_SZ_DW(psp_gen_spi_in)] = {};
> - int err, outlen, i;
> - void *out, *outkey;
> + void *outkey;
> + int err;
>   
>   	WARN_ON_ONCE(keysz_bytes > PSP_MAX_KEY);
>   
> - outlen = MLX5_ST_SZ_BYTES(psp_gen_spi_out) +
> MLX5_ST_SZ_BYTES(key_spi);
> - out = kzalloc(outlen, GFP_KERNEL);
> - if (!out)
> - return -ENOMEM;
> -
>   	MLX5_SET(psp_gen_spi_in, in, opcode, MLX5_CMD_OP_PSP_GEN_SPI);
>   	MLX5_SET(psp_gen_spi_in, in, key_size, keysz);
>   	MLX5_SET(psp_gen_spi_in, in, num_of_spi, 1);
> - err = mlx5_cmd_exec(mdev, in, sizeof(in), out, outlen);
> + err = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
>   	if (err)
> - goto out;
> + return err;
>   
>   	outkey = MLX5_ADDR_OF(psp_gen_spi_out, out, key_spi);
> - keys->keysz = keysz_bytes * BITS_PER_BYTE;
> - keys->spi = MLX5_GET(key_spi, outkey, spi);
> - for (i = 0; i < keysz_bytes / sizeof(*keys->key); ++i)
> - keys->key[i] = cpu_to_be32(MLX5_GET(key_spi,
> - outkey + (32 -
> keysz_bytes), key[i]));
> -
> -out:
> - kfree(out);
> - return err;
> + key->spi = cpu_to_be32(MLX5_GET(key_spi, outkey, spi));
> + memcpy(key->key, MLX5_ADDR_OF(key_spi, outkey, key),
> keysz_bytes);
> +
>

Thanks for the updates, Cosmin. I did notice a small problem after 
applying these, where v1 keys were ok, but not v0. This seems to fix it 
for me, but it was a bit of a guess. Let me know what the proper 
adjustment is:

         outkey = MLX5_ADDR_OF(psp_gen_spi_out, out, key_spi);
         key->spi = cpu_to_be32(MLX5_GET(key_spi, outkey, spi));
-       memcpy(key->key, MLX5_ADDR_OF(key_spi, outkey, key), keysz_bytes);
+       memcpy(key->key, MLX5_ADDR_OF(key_spi, outkey, key) + (32 - 
keysz_bytes), keysz_bytes);


