Return-Path: <netdev+bounces-212657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD5B21973
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B71A204E2
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A71F5851;
	Mon, 11 Aug 2025 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Cin9Rvwk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DD15990C
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955439; cv=none; b=tbjMgdh1rBnN9GNsD0ah7OBj+rFJOBeOttFjx7Vd4i+gOGX/yWeqNZtGdnzk7oSsLocj9YOwRTSNlzDSrvNSJGD4OfgJ/TpFqAQB7PQWfFgmiSui7gBFmv6K1pVIfYOL0qEWECalrE/iuh2bXvheE0mPHjJGqKAlB0qZido+Fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955439; c=relaxed/simple;
	bh=t+BKRCWZsKqgAOgvdI/IQS5v4/7HhWU8/k4yGH4GnXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz2H0fYhLaVKp2B9e+vtRmAe2E8SwcJMBi2QFSooHkrh9t1gfEqzmQDD3iCMEG7Pwmyxbk7j9w5b49VD7nSZ+6KKT8bjWelBuaxrL1hlF3ryNgv2FRyUZcyj4P//wuIp4Mif8sSQSphwO3iyZxiX2v5GsTBgP88ihbujCxtRlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Cin9Rvwk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31f314fe0aaso5761335a91.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754955437; x=1755560237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfmfLdS2dFzqX+Fr78BWjugD3hNZ34Ysqu9SesKrFGM=;
        b=Cin9RvwkrG6S6OfPjBvnjljsQTyOTT2sBlE1XMiP5BISl7Pu8bmZcrjX9zM0lwHuWT
         PyGQdHvJ7S3T7SFxk/75s0j+YYf39OlKmVa0r5azkdgZWKFSsVVFYIXxjrIzCy8o8+Kj
         r3yg3up0qws4L0XQwaDhkalLWcV0ZFGoqXFBOqkXOkKvVmIKQlgd7xwlSapvHeyCzH1P
         yM5I9IxxadMYB131/DuZcUln1gc1rmaQCDM86T6xbBcMDPgac8MWBHwiEicmsUthRTD9
         UsRr7FETRTTSHhJe2vwXKQ1XlTL1SziBPdlZRI9j6OIibxfgXILA29hlIbYXIVj1oDli
         rK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754955437; x=1755560237;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfmfLdS2dFzqX+Fr78BWjugD3hNZ34Ysqu9SesKrFGM=;
        b=rnRfQcbcBOtOxBlKx+aYYd7jdKfss4+BnPlWfswLhTySM11UKocoWQWF9Zr4gSGsvw
         lsI5tjESMjnwJK8j2LpDSNOLEX2S+RNnkiGKCqZu6K4CE5X6hKO5xhmLxD8VKdOrTEq8
         /efOXqFEUTBCCsn+nUHOcRKIhkUKDz/XMmomJ3Gfb27PMSmEEyxgwldautFamFL5Gqv7
         KFLbSRJ/Q9gSfxBtPkJYOuGC0hoAqXI36uhpqXeSenyZuwv2n3dtGlzdEoQMbuidjTu7
         a2WX1VDTxDMnuDL0RmO6UIq87sKHVSrsICHYv2xkQsAEKOpG5WINHC3Sx+5xdEALijrC
         KK8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBOuWb5xij35EtsyAGpuZKLRFKtK6nmFDFVDLKYQxU/3hmZ+u8nODKTsi4rsDbp0sGfc8fdCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPV/ifWo7aB4uRID6hW4MczUJ6QtC3I+AA/8QPmjDwl3MAXg6
	4FWHOsyEdLeDebFCPuXocwt6edpc1zQdGejxuJT7X0/oMDslwQgJN64Msx1KiXhUjmc=
X-Gm-Gg: ASbGncvon7KwaWMhOzY2gXZFLd/zFRb6TqW6FyqHClutDzvsMdqYGpQOOjw90gi/YG3
	MvY4ijOTR5Gz4u4/R9xS/rBCvt6QA/nxD8cCzEDt10/QAepzWtD3DWAVwqb5lg22Jdsbxs3vSWn
	KlFdgyWrN8Vya6U8nGrzRdketaF7lL/p9DONi/0ktbOHOZ61ItlSPidEQkkjLlbq+p5ra2hdPBm
	aW+crAPvJR+5riLGzZZpVXu/Ny6erUKw1uEYzLouSCRYZoaK8JZZw1Wv103VXNXxzbX2kAEuwlJ
	Ph7QlEw73K90uNR9yTetm4ro7UcHF+g+FCL2iluSPku3kjPzBQRBezfUxSQ5cnF6pFkrjWoKUyy
	SVv0hjLGS7zZeAEAsTQviGg8odZXPYcgdWUGVRJQtZ9uJPofTS23RlgbLwHuFUr9wNyI=
X-Google-Smtp-Source: AGHT+IE+UBYandDx5z87lM/XbpF62WzKz4U6tb9Qgmd4oPQwzpn33MGHYW9itmHr3TzEusfdJbbs5g==
X-Received: by 2002:a17:90b:54c4:b0:321:156f:5c00 with SMTP id 98e67ed59e1d1-321839d5850mr19572692a91.1.1754955437052;
        Mon, 11 Aug 2025 16:37:17 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282b5esm15905398a91.27.2025.08.11.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:37:16 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:37:14 -0700
From: Joe Damato <joe@dama.to>
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net] Octeontx2-af: Fix negative array index read warning
Message-ID: <aJp-qm55O_ka7vSv@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
References: <20250810180339.228231-1-chandramohan.explore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810180339.228231-1-chandramohan.explore@gmail.com>

On Sun, Aug 10, 2025 at 11:33:27PM +0530, Chandra Mohan Sundar wrote:
> The cgx_get_cgxid function may return a negative value.
> Using this value directly as an array index triggers Coverity warnings.
> 
> Validate the returned value and handle the case gracefully.
> 
> Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 8375f18c8e07..b14de93a2481 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -3005,6 +3005,8 @@ static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
>  		return -EAGAIN;
>  
>  	cgx_id = cgx_get_cgxid(cgxd);
> +	if (cgx_id < 0)
> +		return -EINVAL;
>  
>  	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
>  		fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];

A couple pieces of feedback for you:

1. Since this is a fixes it needs a Fixes tag and a commit SHA that it is fixing.
2. cgx_get_cgxid is called in 3 places, so your patch would probably need to
   be expanded to fix all uses?

Overall though, did you somehow trigger this issue?

It seems like all cases where cgx_get_cgxid is used it would be extremely
difficult (maybe impossible?) for cgxd to be NULL and for it to return a
negative value.

