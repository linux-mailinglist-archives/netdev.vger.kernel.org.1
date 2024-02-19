Return-Path: <netdev+bounces-72837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF3859E1B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124981C217CB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011ED210FB;
	Mon, 19 Feb 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVQ+9qpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43F210F0
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330939; cv=none; b=sEqeUWyCMR+OoDMJjO5fG6ZNnGIBpWuRNodoDyMHU+EF98GhXzxUk80VT5ZKeo9w3FWMpZDfBEH8c3SpUo+IWgwdjNq68jf80iVdfI8yVSnBl6PJY490/Txm9SnqUlhudgLKsulm1KH1vD3eku/NfYvPoDqPZBViIkvP2S5PHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330939; c=relaxed/simple;
	bh=nGitsSxjPk+gBIGLQ3qxvow1rCE7hQe9MOGZfZ0PH3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OiHeu/kKO3jwa8B32g+3/IHa2KMo7gnns+BkT4wC3+59npiGfMiS0s+v9wJ5c4gUiASg6BXbzfDwPzG1ReJ0GB55Ujw99S+HtAHW9lDZA6x/UcGi7WSFhYk380EXMxSFDuaVSDqIMmPpWKfH7w+gpPKDoa6LgxIYlae/kq/Vcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVQ+9qpN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so86705166b.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 00:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330936; x=1708935736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJawKhMKgZfK3H+o45cb6KDvj97UBnzXFXRTiTe4vLc=;
        b=XVQ+9qpNO0ZLMclvaqsjyCBzjEybdT5LcLfgNTuzZqzocLsDkkxRPAirEmzz7GW6LY
         528MgiuGoTmbmRDtDJkKDyjTS6vO7OzqWOsMPimiofX/qRyYVFmDkidOCyhOZm5T681e
         ePTj0IE4zOt94UQ6QZ1wNR/poKy5uQYdTclKEdud5gO6hUTl9n8o8vuwFfDXY3R9+nJj
         cY98wHw0dSqGHZL8R7k6CgOtas85WlOhrZxxqHsMf+jGU89DdH83eSIz+3bZuiyh/AjN
         2POLhXbjZii3nNWlRWnrC93BM56yrN1GcIKqoz3Htsh6ne7nK7VZnb8BRGq6Xte5YJYU
         WP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330936; x=1708935736;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJawKhMKgZfK3H+o45cb6KDvj97UBnzXFXRTiTe4vLc=;
        b=wrCg8nq7NDdqJVojQ4/agx84rPt2HBCOlayDgYOU7Z7k2JXWGgGEum7yMnOQGvcC6q
         wTglNkx6c0xzTJyN2DAC1HBNj0gsDiPuiXXIcJ/xcXhFGLrrC8KmcJT8AD+TxtHFc6Vx
         U2v69kjdVU1TVqC9Y3xlTFJOywLOuKp40Xt9V9NdggNBXS8ZETMf4LGVq6vKFvurkjV9
         Ul+ScFJCfcT7q5X8KtRNedwdzoYl80bbWSfDjt7c5eAJo7UNxIeE/Pn7bbopldWQqf/6
         m75OcIY7DiPGB0hB9bM3ff72lgiK75LJgp1VIvw88MPsB2Lx2mSyIVXkesTj3ZoJv5ZS
         QiVg==
X-Forwarded-Encrypted: i=1; AJvYcCVno2g0Tse63lZHesUXoag+jXHDOWDBbMTwoDnL5r9NZVKbmVWqNQ0CWW9j1Vt47l8qQuVyESvnpEoC304Edgz55HMSS8VQ
X-Gm-Message-State: AOJu0YzPEdxuNtEmzao1NgiCAMShpy6HlfR8AsVxityJmUycb/2Gogjd
	0ze+ZU1loq19eu87n+ZETYqLe/ySgoqW5iOulcot31vpuVWGz3VngRj0ykn92qw=
X-Google-Smtp-Source: AGHT+IGl/ITfmjq0RpjNkokRRLvKEhrU7NvfHwqSMU7MFfOC3zR13Xzxi+jsjB0P34SMxHIUAdW/cQ==
X-Received: by 2002:a17:906:1388:b0:a3e:79f7:d218 with SMTP id f8-20020a170906138800b00a3e79f7d218mr2415837ejc.43.1708330936473;
        Mon, 19 Feb 2024 00:22:16 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y2-20020a170906470200b00a3d0dd84276sm2685297ejq.184.2024.02.19.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:22:16 -0800 (PST)
Date: Mon, 19 Feb 2024 11:22:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jeremy Kerr <jk@codeconstruct.com.au>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Matt Johnston <matt@codeconstruct.com.au>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next 06/11] net: mctp: provide a more specific tag
 allocation ioctl
Message-ID: <95174361-e247-4792-866b-d77152659fd6@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424009ba3e320ae93eb6bd44ef5e474aa5c9221f.1708071380.git.jk@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-mctp-avoid-confusion-over-local-peer-dest-source-addresses/20240216-163203
base:   net-next/main
patch link:    https://lore.kernel.org/r/424009ba3e320ae93eb6bd44ef5e474aa5c9221f.1708071380.git.jk%40codeconstruct.com.au
patch subject: [PATCH net-next 06/11] net: mctp: provide a more specific tag allocation ioctl
config: parisc-randconfig-r081-20240218 (https://download.01.org/0day-ci/archive/20240218/202402181713.OQAPBmZC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402181713.OQAPBmZC-lkp@intel.com/

smatch warnings:
net/mctp/af_mctp.c:389 mctp_ioctl_tag_copy_from_user() warn: was && intended here instead of ||?

vim +389 net/mctp/af_mctp.c

28828bad95a357 Jeremy Kerr 2024-02-16  356  static int mctp_ioctl_tag_copy_from_user(unsigned long arg,
28828bad95a357 Jeremy Kerr 2024-02-16  357  					 struct mctp_ioc_tag_ctl2 *ctl,
28828bad95a357 Jeremy Kerr 2024-02-16  358  					 bool tagv2)
28828bad95a357 Jeremy Kerr 2024-02-16  359  {
28828bad95a357 Jeremy Kerr 2024-02-16  360  	struct mctp_ioc_tag_ctl ctl_compat;
28828bad95a357 Jeremy Kerr 2024-02-16  361  	unsigned long size;
28828bad95a357 Jeremy Kerr 2024-02-16  362  	void *ptr;
28828bad95a357 Jeremy Kerr 2024-02-16  363  	int rc;
28828bad95a357 Jeremy Kerr 2024-02-16  364  
28828bad95a357 Jeremy Kerr 2024-02-16  365  	if (tagv2) {
28828bad95a357 Jeremy Kerr 2024-02-16  366  		size = sizeof(*ctl);
28828bad95a357 Jeremy Kerr 2024-02-16  367  		ptr = ctl;
28828bad95a357 Jeremy Kerr 2024-02-16  368  	} else {
28828bad95a357 Jeremy Kerr 2024-02-16  369  		size = sizeof(ctl_compat);
28828bad95a357 Jeremy Kerr 2024-02-16  370  		ptr = &ctl_compat;
28828bad95a357 Jeremy Kerr 2024-02-16  371  	}
28828bad95a357 Jeremy Kerr 2024-02-16  372  
28828bad95a357 Jeremy Kerr 2024-02-16  373  	rc = copy_from_user(ptr, (void __user *)arg, size);
28828bad95a357 Jeremy Kerr 2024-02-16  374  	if (rc)
28828bad95a357 Jeremy Kerr 2024-02-16  375  		return -EFAULT;
28828bad95a357 Jeremy Kerr 2024-02-16  376  
28828bad95a357 Jeremy Kerr 2024-02-16  377  	if (!tagv2) {
28828bad95a357 Jeremy Kerr 2024-02-16  378  		/* compat, using defaults for new fields */
28828bad95a357 Jeremy Kerr 2024-02-16  379  		ctl->net = MCTP_INITIAL_DEFAULT_NET;
28828bad95a357 Jeremy Kerr 2024-02-16  380  		ctl->peer_addr = ctl_compat.peer_addr;
28828bad95a357 Jeremy Kerr 2024-02-16  381  		ctl->local_addr = MCTP_ADDR_ANY;
28828bad95a357 Jeremy Kerr 2024-02-16  382  		ctl->flags = ctl_compat.flags;
28828bad95a357 Jeremy Kerr 2024-02-16  383  		ctl->tag = ctl_compat.tag;
28828bad95a357 Jeremy Kerr 2024-02-16  384  	}
28828bad95a357 Jeremy Kerr 2024-02-16  385  
28828bad95a357 Jeremy Kerr 2024-02-16  386  	if (ctl->flags)
28828bad95a357 Jeremy Kerr 2024-02-16  387  		return -EINVAL;
28828bad95a357 Jeremy Kerr 2024-02-16  388  
28828bad95a357 Jeremy Kerr 2024-02-16 @389  	if (!(ctl->local_addr != MCTP_ADDR_ANY ||
28828bad95a357 Jeremy Kerr 2024-02-16  390  	      ctl->local_addr != MCTP_ADDR_NULL))
28828bad95a357 Jeremy Kerr 2024-02-16  391  		return -EINVAL;

Should be &&.  This function will always return -EINVAL.  I haven't
looked at the context outside of this automatically generated email but
it suggests a failure in our test process.

28828bad95a357 Jeremy Kerr 2024-02-16  392  
28828bad95a357 Jeremy Kerr 2024-02-16  393  	return 0;
28828bad95a357 Jeremy Kerr 2024-02-16  394  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


