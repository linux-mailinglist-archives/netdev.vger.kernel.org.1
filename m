Return-Path: <netdev+bounces-238667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA7C5D2AC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B13418F3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017FD176ADE;
	Fri, 14 Nov 2025 12:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536851E505
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124275; cv=none; b=KdR6LHKroldcQAevLKdIdrvIwudu8YF3/HC4b5h5ivhPdX1GZLnqgaowL9tQ7K/WsmaQOhqTQqybFFpkc6ZRiUb9bRnuQIKCeEoX15l0BxIYxIlR/i9tN9PHglJYHh2WZbk4ja+ebMnkuZMYMkQ9wI7dtcJY/ljLGx9rnopIzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124275; c=relaxed/simple;
	bh=eXrSxF7g8VtEK9XfVtc1KHkvCDAGmL1xr6MqPdBG0yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPlrqy/z8eppH/eql9Px8D7p8XxBlsdQqCdywOFwb3kekc0abN1CTEb8bPVG74Q7STf4Lb3wxbWhl55c40MU+p/kJh7Mcmpucmu3HWYME5qwvstBGAMUjNTa+Ud+iqt0mJE10yEzL3yYE1KL2mpBtmyA0/5hwqeRA/2j3G3IVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e7ead70738so996426fac.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763124273; x=1763729073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoHpWXitx47FldIpJvkbxLdcbiPOnWRFPRWqGQ7Zchc=;
        b=UjVAglLH2ALyHIaXvYfm9D3QN8ZJdUAIDCBomXYQnuELh3+vK7T3POgrByOM948cHN
         ppMnP69Hc43DSabU4IKhMZnB78/iFFUTaZqmEZQ45GnEojVDErmU2K1jJx72BSzw9q4s
         HujBsI3oFis1oID95vMAsrwCqA8t7sZiqZjsBG+gFNOTpIaCjzFrdjVgl8RrpKsRhozd
         MDF23Oo+cf4KWLexDIPGrnHAE+3peOIQK3xFlBweOS1ZmVQBbRCaSUuw8rUjH7zVIPiQ
         tv6DkNfI2JBBxz513w9g7PRULsX56eTDFso37FawtY7mhnl1NpNgZ39GjPtvlxRYPCOB
         hNgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ucQffuYC6euWQluQBlRMhxBs0e5u0PwdGRnXy1BF0YA8Pcq2D1fCtnXqwYUs5FDufZUkWbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysC1ypC8lGOyqHZPyj6A+8qA8aG+zA70WBHNFddbQzK0qv71J4
	bigPnI7ltyArHMiR4tH7lgsn5e9R82Luj/pNhj7NY2S+1G5GpbizOZ0C
X-Gm-Gg: ASbGncuj28xzgoo8WI5X7HaizTJb+fEl4GQfOOoQlJ+HZMySxpTA1/4vWrn2lbS6R+M
	K2ZvSQLbWRQ6y8b4FgGN7l2qp1bRNaS7byGvmuSVUvikJ1tIyJrSC4icHUH3aZs/jZjU2HxaBOe
	hzkBBg4HO8VReX2+CuaTFZg9jKE4CMaD0wtjjYRtUh+PaffD95VsBF7sRHvYhNG63kNZL3Qyl/d
	76f/hjYRHdPfjzAe1NWed8isV+S3PYl0Cnun4lU4SnDkiWaQlSeJXM1+IsUal2Vr4CbNvGGbALq
	RmV3hluFKweFG9j3dcNVPSB2RvQvR5EFYm4nzU57vdRw4ApxtdWyY+Ju4gC2gH4J57lB5fVYVkp
	5qMP5P0tjObBBIUtRvWGJwlCL6+lpPaaRC790OIksA6Lo7MAW3XiEvYDcPNDByHu14NyvjFjM2B
	i0Uw==
X-Google-Smtp-Source: AGHT+IGdY4QN+y+T94GClU1TS4vz/RxaQrGP+Y+G4NtveS2PNDD2vRqD3caT+pzwZRqBcbYn2m77xw==
X-Received: by 2002:a05:6871:2b17:b0:30b:e02b:c7f5 with SMTP id 586e51a60fabf-3e8691844c7mr1423649fac.40.1763124273396;
        Fri, 14 Nov 2025 04:44:33 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e8522ae6e2sm2610556fac.16.2025.11.14.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:44:32 -0800 (PST)
Date: Fri, 14 Nov 2025 04:44:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] netconsole: Split userdata and sysdata
Message-ID: <nmtyovnsn4edb2leysure4hjriwdkcjpvppcaatqbqifohupw5@osqesr4xh3y6>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-2-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-2-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:19AM -0800, Gustavo Luiz Duarte wrote:
> Separate userdata and sysdata into distinct buffers to enable independent
> management. Previously, both were stored in a single extradata_complete
> buffer with a fixed size that accommodated both types of data.
> 
> This separation allows:
> - userdata to grow dynamically (in subsequent patch)
> - sysdata to remain in a small static buffer
> - removal of complex entry counting logic that tracked both types together
> 
> The split also simplifies the code by eliminating the need to check total
> entry count across both userdata and sysdata when enabling features,
> which allows to drop holding su_mutex on sysdata_*_enabled_store().
> 
> No functional change in this patch, just structural preparation for
> dynamic userdata allocation.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

<snip>
> @@ -1608,13 +1575,24 @@ static void send_fragmented_body(struct netconsole_target *nt,
>  		buf_offset += this_chunk;
>  		data_sent += this_chunk;
>  
> -		/* after msgbody, append extradata */
> -		if (extradata_ptr && extradata_left) {
> -			this_chunk = min(extradata_left,
> +		/* after msgbody, append userdata */
> +		if (userdata_ptr && userdata_left) {
> +			this_chunk = min(userdata_left,
>  					 MAX_PRINT_CHUNK - buf_offset);
>  			memcpy(nt->buf + buf_offset,
> -			       extradata_ptr + extradata_offset, this_chunk);
> -			extradata_offset += this_chunk;
> +			       userdata_ptr + userdata_offset, this_chunk);
> +			userdata_offset += this_chunk;
> +			buf_offset += this_chunk;
> +			data_sent += this_chunk;
> +		}
> +
> +		/* after userdata, append sysdata */
> +		if (sysdata_ptr && sysdata_left) {
> +			this_chunk = min(sysdata_left,
> +					 MAX_PRINT_CHUNK - buf_offset);
> +			memcpy(nt->buf + buf_offset,
> +			       sysdata_ptr + sysdata_offset, this_chunk);
> +			sysdata_offset += this_chunk;

This seems all correct and improved, but, I would like to improve this a bit
better.

I would like to have a function to append_msg_body(), append_sysdata() and append_userdata(),
which is not possible today given these variables.

A possibility is to have a local "struct fat_buffer" that contains all these
pointers and offset, then we can pass the struct to these append_XXXXX(struct
fat_buffer *) in a row.

I envision something as:

	int buf_offset = 0;

	while (data_sent < data_len) {
		buf_offset += append_msgbody(&fat_buffer)
		buf_offset += append_sysdata(&fat_buffer)
		buf_offset += append_userdata(&fat_buffer)

		send_udp(nt, nt->buf, buf_offset);
	}

Not sure it will be possible to be as simple as  above, but, it will definitely
make review easier.

Just to be clear, this is not a request for this patch, but, something that I'd
love to have.

