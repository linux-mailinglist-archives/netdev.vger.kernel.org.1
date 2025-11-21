Return-Path: <netdev+bounces-240900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D07C7BEC6
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4039C367089
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249D2DE6EF;
	Fri, 21 Nov 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU4VRKu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434B2D5C74
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766745; cv=none; b=QDtSMcIDcZBMfJ3VityLPTgwgnTggIESpBcbP1fEY0bKr1fPCke+VrOZW1XKKV0LzY+cBeG94XJQcnpcNp4liNouK+YNYcr63oW10GbfmVgM8Nz8OJkfRkn9ekrhui6p7mDAQhK2QTdVT7bZFqtn80FmVIQlqgCb+5eJVdoN4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766745; c=relaxed/simple;
	bh=b0GsJjNOkd23Y8b/rhP04LJ129wq4rJm6upoQsP5r58=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nTgcI9pBd/x2f7nUawN89ziI0GP3qzJbJ5prGpwgAykdujPNcJ7d+QiVuQrYrthcwTVohXY4vpwL3QeDZmBt8WmOZf2JVBW3wQjWNfjUtbyd5dkvEJ+MCROK6k/doGYFYafiDUKFNpiI+g8/eDhKUgChM9pkd4GmMO21ZsT8Dps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU4VRKu3; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63fc6115d65so2172610d50.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766737; x=1764371537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER0EqnipfQR28gz9kSpw01iLCYoIz+RpULRJggWqctc=;
        b=YU4VRKu3K+fhPvpG5WaIudyNIZ9MR2lX/t4N6FlhwJHE4y99fp/WyEDf37YyMk0f2X
         MnmZJ1OBbEb0lgvzD6ioYtO5DjaGob1xGbM1V5xyH6F02qYvdoHz72fGUb2ccuFMLAho
         q3f6BPDfbRIyStg7hwT9cIQottnjVEYV9gvK+jJ2pEqCFRdPD3rK+PcvX9EWbhW6TkAI
         oRXpNUGCjQW/FLxPZsVwt3hpRvjerp1NWUZ1O9+h03ye71GvKcU2lO1PGPjw5llybML1
         W662/1N3I/1athQLStiSeYETXQfM3N2l0R8SYunrDN6Cxqd4WZyJ9ejjRKgQe5OvWDkC
         SfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766737; x=1764371537;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ER0EqnipfQR28gz9kSpw01iLCYoIz+RpULRJggWqctc=;
        b=D2rbS46Hy+0C3MtwF4HtMIop4Dq7ZGM1u6gQTaUd7SwzZvSPNbaVFl1iiLVfICQEhi
         mLJ16eLv9GspEv88caCpI1ne6onhgXqHFXXya48fBYYngfmgeK3qi7sTnGR5J7Ia8MpV
         EDmYJRPa2agfo+KvJ6Hc/g4slFFZwveyPffdeE5WNGdHgIbe4DQ5jZmYhmaluIzI6FF8
         P+CEYlfWwuO37179X78IYvEguFn2xdBpmyG4OOKre2zv3ez4uxmfiyjZiMKbiN+NUPz0
         SzBV1u/a9Exz3del+6h45OFgSC33xQhuEJ3/m/v3EE07iLvGT5N3vB+zT0KZ83PcQ8yv
         LvWg==
X-Gm-Message-State: AOJu0YyxZswKBc7XmZp1osySCftd3ccTKxr8IYeCM6n/XeSnGNARUAh3
	L/hjQ90IQlZUegONixprKRfCprtryOW65rVsx1Pie3aEHjVIImPvxcLU
X-Gm-Gg: ASbGncs3mv0TDxwg17D3VUz3BoSmiwQtTgMAfRllu0cBR1jqoc01dPOQZxY/RHrPYCU
	jgFAyLQfVq5IFYWb0c7VZxetmXQD0buZy+n8lvRBIo69Ki8z4mjepB0Hnom8jjVY9gSkBhERBDJ
	3BuLzvmTFeRkYPBmpQg7GxsF7nBJLg/fNpIUzvmTYi7UdD9qKbdxZEvZcjbNbxCZpv1X2DhXGuw
	YlxQAaact9douG8E27y+gF/C09gSW5oi1je/O+DxdO7RF6esM2tScq1c0gCnHvg5DUcpY5ankC7
	k6pnAzy7tJsAXPixWXZmoCRHr7NolTnHkInBxQ0JnHgVrL7jQFqFV4BYYBY5yPuAhaW+4c9gKQE
	WaL2Kc3bqgiuGbS7NYviBvybD/pAZ3DM9DTv4U5wYbJY1ExTW/BoBlHKNJVyofP1OTEgIUZh0BY
	FMwKp8PY0n3nBMlZBBlj3HrcLWTQFLQsssgItpswP27RHe1+87cGHDGVjeO/6vkG3aOSzda+7Lz
	NNhlg==
X-Google-Smtp-Source: AGHT+IFtWJ6o3fFiC7w0yCo09Sxi6MfOMUc8IK5cJlx6nfs3tpvkiRuecR5cvjP6jh7JG3gHDx0YfA==
X-Received: by 2002:a05:690e:40e:b0:641:eb21:d6ac with SMTP id 956f58d0204a3-64302ab2666mr2074060d50.44.1763766737456;
        Fri, 21 Nov 2025 15:12:17 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-642f70a6c44sm2131489d50.10.2025.11.21.15.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:12:16 -0800 (PST)
Date: Fri, 21 Nov 2025 18:12:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 dw@davidwei.uk, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.224bdf2fac125@gmail.com>
In-Reply-To: <20251121040259.3647749-5-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
 <20251121040259.3647749-5-kuba@kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: hw-net: toeplitz: read
 indirection table from the device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Replace the simple modulo math with the real indirection table
> read from the device. This makes the tests pass for mlx5 and
> bnxt NICs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/hw/toeplitz.c       | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
> index 7420a4e201cc..a4d04438c313 100644
> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
> @@ -68,6 +68,7 @@
>  #define FOUR_TUPLE_MAX_LEN	((sizeof(struct in6_addr) * 2) + (sizeof(uint16_t) * 2))
>  
>  #define RSS_MAX_CPUS (1 << 16)	/* real constraint is PACKET_FANOUT_MAX */
> +#define RSS_MAX_INDIR	(1 << 16)

Only if respinning, maybe also fix alignment of RSS_MAX_CPUS
  
>  #define RPS_MAX_CPUS 16UL	/* must be a power of 2 */
>  
> @@ -105,6 +106,8 @@ struct ring_state {
>  static unsigned int rx_irq_cpus[RSS_MAX_CPUS];	/* map from rxq to cpu */
>  static int rps_silo_to_cpu[RPS_MAX_CPUS];
>  static unsigned char toeplitz_key[TOEPLITZ_KEY_MAX_LEN];
> +static unsigned int rss_indir_tbl[RSS_MAX_INDIR];
> +static unsigned int rss_indir_tbl_size;
>  static struct ring_state rings[RSS_MAX_CPUS];
>  
>  static inline uint32_t toeplitz(const unsigned char *four_tuple,
> @@ -133,7 +136,12 @@ static inline uint32_t toeplitz(const unsigned char *four_tuple,
>  /* Compare computed cpu with arrival cpu from packet_fanout_cpu */
>  static void verify_rss(uint32_t rx_hash, int cpu)
>  {
> -	int queue = rx_hash % cfg_num_queues;
> +	int queue;
> +
> +	if (rss_indir_tbl_size)
> +		queue = rss_indir_tbl[rx_hash % rss_indir_tbl_size];
> +	else
> +		queue = rx_hash % cfg_num_queues;
>  
>  	log_verbose(" rxq %d (cpu %d)", queue, rx_irq_cpus[queue]);
>  	if (rx_irq_cpus[queue] != cpu) {
> @@ -517,6 +525,20 @@ static void read_rss_dev_info_ynl(void)
>  
>  	memcpy(toeplitz_key, rsp->hkey, rsp->_len.hkey);
>  
> +	if (rsp->_count.indir > RSS_MAX_INDIR)
> +		error(1, 0, "RSS indirection table too large (%u > %u)",
> +		      rsp->_count.indir, RSS_MAX_INDIR);
> +
> +	/* If indir table not available we'll fallback to simple modulo math */
> +	if (rsp->_count.indir) {
> +		memcpy(rss_indir_tbl, rsp->indir,
> +		       rsp->_count.indir * sizeof(rss_indir_tbl[0]));

It can be assumed that rsp->indir elements are sizeof(rss_indir_tbl[0])?

Is there a way to have the test verify element size. I'm not that
familiar with YNL.

> +		rss_indir_tbl_size = rsp->_count.indir;
> +
> +		log_verbose("RSS indirection table size: %u\n",
> +			    rss_indir_tbl_size);
> +	}
> +
>  	ethtool_rss_get_rsp_free(rsp);
>  	ethtool_rss_get_req_free(req);
>  	ynl_sock_destroy(ys);
> -- 
> 2.51.1
> 



