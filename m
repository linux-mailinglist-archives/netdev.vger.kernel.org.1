Return-Path: <netdev+bounces-80699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C658806E2
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 22:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F52837C4
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397543FE2A;
	Tue, 19 Mar 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIRPm1Cy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214A4F1F9
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884581; cv=none; b=eW501pyo9pNKSbVrIs/w1jekmKvP9w0oblHCGHX+TsPMJeckT+cdPaTmF+ri7hB5NVB4U5ILtnIEttuiDBVF1Ch43iAaNuvTbbMhWLuSzwPnlOfHYIZ0tGdxNQ5FtBAXaP/uI2+i9vTfohGpZnavAKqw0K3e6TSAl69wrspG4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884581; c=relaxed/simple;
	bh=Rf/ZzLSJq+0hJEqJURHe/+XcImyRbdPUlA55Jcwz3ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT5fxfcC2RyK22wZBvHk51YvWplh5T+ImV8THaPElyw9o0wzqiNnNOQ25GhILVDn9c60qYqxByBIPb2LtPZbzZycSQCEV9CSkesvdAsW/8xPK4zcshT3D8RGDmYpSITBYYcqpZRUY4ahw09dmsEkKlhQ5/s82oRqqMgkOaGmTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kIRPm1Cy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dde26f7e1dso44105735ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710884579; x=1711489379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gn2BuHzN3nlK8aoPb0dO7Dxpaiy8FETIFCqPc6ZVPEI=;
        b=kIRPm1Cyxf/2+6Zh+03W/13X0ixZhx2/XQWYgWH9eJej9jr5J7KOybWM5hPZz2lyQr
         Jn8ELsRW9sUmKGZTzzgBao4tu5P8x9uUTE4akk1tVHLhisWhczjFCsWIbxB+P3yToHsJ
         Z6zuxYZ2/cVYOVO7gHeKtzGzS87ZSG+cEnAVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884579; x=1711489379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn2BuHzN3nlK8aoPb0dO7Dxpaiy8FETIFCqPc6ZVPEI=;
        b=omsFNhHDpzE8HBK6TMGPEW8Dpih5VQxGZXFv92sKH3ey35qoXl1ON8eKq29G8+v25s
         DM3qn53fI30kr+PlZxukoSHH98ICFQokxRYEoUgqHTU0UN5t2buXWZxKWPLf/e6HtieR
         YjoUOpaA6z8l4NrgppSmQm3PI3wARRMEgstiXtumhHPoq0/35goBpr1twkrX5V8NK0hB
         GYXVVj8BkNWfxTfBDYSDVmzAoiyW3zhNNyU7+nRPNZ3bO+S/FSAASkc4i4cfnwe1vyEC
         /vhg/IC1M/TSYVDgj8jtB5hE5z7YdKVgemwRKAK0KmL8PFnCKwit3E36xO6YGq7eL2Wo
         d8nA==
X-Forwarded-Encrypted: i=1; AJvYcCWeEjJkLPsQl1OkPHq2ShiWRNfhzELd2HXDn8goh6imRW+Ht2FV+lAOb/u//wj4K61/QS9oz6bnykj5iqwq4L9o+0tV5aF+
X-Gm-Message-State: AOJu0YyB3GoG2Mn9uCwYNxXtigarLv2Xm6Gjh2R6Iie+QuVVQ5kH8UDr
	qKVOtetmCObY/Bu1IJHGXjRdd/nMb3jIEKY/yJRIfnsx9sMxjIzwP5ke6aECRQ==
X-Google-Smtp-Source: AGHT+IHAZohXacaLJK6W6ePcVrSro2gO3VNsbfNh2CzbM77yQ3dVP31W+F8koj1yMP3uswTLgaW1lA==
X-Received: by 2002:a17:903:32cd:b0:1e0:444:5f6c with SMTP id i13-20020a17090332cd00b001e004445f6cmr8749688plr.64.1710884578802;
        Tue, 19 Mar 2024 14:42:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001defa97c6basm8707287plk.235.2024.03.19.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:42:57 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:42:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Simon Horman <horms@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC kspp-next 3/3] idpf: sprinkle __counted_by{,_le}() in
 the virtchnl2 header
Message-ID: <202403191442.219F77E672@keescook>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
 <20240318130354.2713265-4-aleksander.lobakin@intel.com>
 <20240319185718.GO185808@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319185718.GO185808@kernel.org>

On Tue, Mar 19, 2024 at 06:57:18PM +0000, Simon Horman wrote:
> On Mon, Mar 18, 2024 at 02:03:54PM +0100, Alexander Lobakin wrote:
> > Both virtchnl2.h and its consumer idpf_virtchnl.c are very error-prone.
> > There are 10 structures with flexible arrays at the end, but 9 of them
> > has flex member counter in Little Endian.
> > Make the code a bit more robust by applying __counted_by_le() to those
> > 9. LE platforms is the main target for this driver, so they would
> > receive additional protection.
> > While we're here, add __counted_by() to virtchnl2_ptype::proto_id, as
> > its counter is `u8` regardless of the Endianness.
> > Compile test on x86_64 (LE) didn't reveal any new issues after applying
> > the attributes.
> > 
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Hi Alexander,
> 
> with this patch applied ./scripts/kernel-doc -none reports the following.
> I think that this means that the kernel-doc needs to be taught
> about __counted_by_le (and __counted_by_be).

Oh, yes, I should have remembered that need. Sorry! It should be
addressed by adding them where __counted_by is already listed in
Documentation/conf.py.

-Kees

> 
> .../virtchnl2.h:559: warning: Excess struct member 'chunks' description in 'virtchnl2_queue_reg_chunks'
> .../virtchnl2.h:707: warning: Excess struct member 'qinfo' description in 'virtchnl2_config_tx_queues'
> .../virtchnl2.h:786: warning: Excess struct member 'qinfo' description in 'virtchnl2_config_rx_queues'
> .../virtchnl2.h:872: warning: Excess struct member 'vchunks' description in 'virtchnl2_vector_chunks'
> .../virtchnl2.h:916: warning: Excess struct member 'lut' description in 'virtchnl2_rss_lut'
> .../virtchnl2.h:1108: warning: Excess struct member 'key_flex' description in 'virtchnl2_rss_key'
> .../virtchnl2.h:1199: warning: Excess struct member 'qv_maps' description in 'virtchnl2_queue_vector_maps'
> .../virtchnl2.h:1251: warning: Excess struct member 'mac_addr_list' description in 'virtchnl2_mac_addr_list'
> 
> ...

-- 
Kees Cook

