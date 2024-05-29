Return-Path: <netdev+bounces-99160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358618D3DCF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF606284ABE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7915B55D;
	Wed, 29 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XfTDVWrv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16A1B960
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005587; cv=none; b=J96+fZOEGqD6ZQPmtFV99XrKcBfO8qkHRTi+tMZml+1zsxFx88ERXleSxalHe1UejvHjIU9giX8KU2VvNrxh1J3zI8zokKrZpoB9p6pamMTChPpUa8q8f7+HJynHUegdec5RMt7OfMDD4ZP/ib7wRSHNetvD0ue7bQuLZekMK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005587; c=relaxed/simple;
	bh=aWjnhJ+L8LGS2U4kU1C2i4xs1A/WOpmgtQu2/zm7dWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8ik4xBjjZSIh4bl9WIB+++t0rPll2bJ/Q7HxFpPgzo5qLEM+yXpr4GHkjVMYKe+kQh+4KZ0smUC682Efp4/h8ut4bU7YNTrl2dh20pliGi6iSD0Rsgjkj1qpJldP0zWDKqqCSP7t+Ct1JSfnj8r7IelipgKS8wZzI8UYFTYCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XfTDVWrv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f47f07acd3so281775ad.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717005585; x=1717610385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6G6VshQZvLEBKyNaqbw0vxNTRoxF2g80F27tR0HxSE=;
        b=XfTDVWrv4k8/hKW7Bnt4OTC3dlHLBfiKXhyS0fL3Pq1MOWsI8fmsSZyq94kCernHGE
         kMIVIzt6//rA99YfB4GO1bUsLSlg1B9QfA5hws2HB4iXjWiwQEUvG7X/G2+hv8F7/32a
         w2zskBXP+OqZItlz762UarrNT2xWzwj78An68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005585; x=1717610385;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6G6VshQZvLEBKyNaqbw0vxNTRoxF2g80F27tR0HxSE=;
        b=LbmVn393ec+USzPzYO6likkJ0muE+aMAt/BywJJ9NYKRaBIMlpXW2k9RNr0CTYUiuH
         IGmOCnp/YsOfcHPGxEruSqm/bzhEMFUvdgn/MuGladEiWU7R2CjxCXMZ+i4m8t0dQZV+
         x6dY/4IseEhaS50dq1DkcKbbTfgtAIO2y1rmIdXgnKu0zJqIPnlBDuFw3g+uzs3CrsJd
         3WoXnOTte0l3g7iWiC4ZWoQw0LbDFwKs7MuRwMUXQzDzw1VAXtAES1RWz+oX5fqwshlA
         wHrHJLTfCqChjFkTj7VbwjPm5UgIMHBO1twaUaKAaJ5WlNd1cCUDydgWqzjczEEhJ3T6
         OkFg==
X-Forwarded-Encrypted: i=1; AJvYcCU+a1uWW4/zul4aVqSfGK59+W9exGIDWIUd/8yFir2jjNurCcYVAN4HfE/q0q0c2WFNhzzX8I2O742UhgDVnY23N+1tfn9W
X-Gm-Message-State: AOJu0YwDFNSYzZYlkOq5snG9arddCxLrluUPPQtoOraHjW+BuC3j5DD/
	Fs7peCChmguxYRrxyM51XcLUztfHwBsBzlz/t3L6iF39NhkP/KQZToqNdyfF5dE=
X-Google-Smtp-Source: AGHT+IG3wHeucNhJrhqSBDUDAuscAJ80DyUsIl4Xwzn/ERkk9e90W4mpu36QfDHovVqZ5IDoe6A6JA==
X-Received: by 2002:a17:902:ecc5:b0:1f4:a1b3:1b9d with SMTP id d9443c01a7336-1f4a1b32852mr95440825ad.33.1717005584894;
        Wed, 29 May 2024 10:59:44 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a8db7sm102736225ad.222.2024.05.29.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:59:44 -0700 (PDT)
Date: Wed, 29 May 2024 10:59:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: qstat: extend kdoc about get_base_stats
Message-ID: <ZldtDl_COcYhzI4U@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20240529162922.3690698-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529162922.3690698-1-kuba@kernel.org>

On Wed, May 29, 2024 at 09:29:22AM -0700, Jakub Kicinski wrote:
> mlx5 has a dedicated queue for PTP packets. Clarify that
> this sort of queues can also be accounted towards the base.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Cc: jdamato@fastly.com
> ---
>  include/net/netdev_queues.h | 2 ++
>  1 file changed, 2 insertions(+)

Thanks!

Reviewed-by: Joe Damato <jdamato@fastly.com>

