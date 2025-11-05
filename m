Return-Path: <netdev+bounces-235962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB641C3775F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA613AEC9D
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F231D37A;
	Wed,  5 Nov 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOvPxOeW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B6321F42
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370646; cv=none; b=C7TKfsYTDHSJWKi0TxkcMuqSTESJ94UH/48NsTOs4v7CrOG7RIkUCiU2fTm82Gvmc353ijTAHFEWeTQDbnov4sr2Zt8mPd0SFIYBtTKUW4T9E7a8Ja/q06Uha53OIKd8TrmeYFLe00DBSiwAo9Gt8G5P3o/9AwIO9N3EgTEgf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370646; c=relaxed/simple;
	bh=z2ZuAl6m8mQF8bCGTrIOO7EDrjCj2YFxDmYFrGwTZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj6HINaT3+dbS9BQWdpkLbW640Wzbzs2vbS+/tk7z4KxdOzU5mtwm5NwGHF362YLqykudyuJn2L4/oK5ZNV0GfXmpZq/+OZLNztB5s7lim5vut9XXG8pfGD4hWK5mIHniRPn88FbJ42nEFydRG9hhvvlUzhOzfsxMTcrzFKnEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOvPxOeW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7815092cd0bso1249797b3.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370643; x=1762975443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=TOvPxOeWbNiSApawo+YHmwxouYBYo8ZqYZuOEzZ+ITc1CUWtCoRUQ/lr1DzgPoQiB7
         HxWmzzUT5AqskIjyw271EZGQLmVtgsXuWTg0I9KiP3ijIwHsEJH155nBvBla2uwVwtBi
         IDuzL2j0SQDNkDciFyUSF9kxqDKSwrBfo0+WWeMeFQsEW6cdDSdvjANMLQTdxi0xOjvh
         OP9P2RBiSf9tF7RiSP0/ddoMYB2jhxpBD+bcLvaSIKrLxlHFyqvvSfqlQOQtAuMbf67H
         GzSKHZuo1MKh/ZE0HCFFsTsnKb0t9uQsmfsuv8ABNSqMcDPoMjWopcuy1DOs6t9XbccG
         OuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370643; x=1762975443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=oLjxUyFAYdeeY/P0EII602hq3zFmMEUFKzZTnqw4a0Kl8nnCxT7kNQM+HX+CDSSIrT
         e0fb6Ka4bKOcm+GVQzqcRgYlFA4chUNqb14o6piZ6YGVvnM6JAFZ6mNEVFnVMIN3Gzf/
         T9GFVrs6O6LvsvwnlMND1TNR8MeIVcX051rrWKvt7NQN1azRmF/zmXaRg60OMvdD6UVe
         fUcLc2cr08qJPInSyO9C98chD4ZfVxoVEksvSH2H35vl9rHpAb09QRf8Y8508BB89XE9
         91/oxCY/FG6VHn8ENK0CIlvhHuKno/PJyamC8JZu5OzpVQA+70j0gVhwt1LFTlq9Gyby
         rlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP4oFuc5aPbYthzSmt7EKOskWfTgpVsLO37tctUdZoOjNm/2UNvprW0SueyMTybG/HONNKPHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8xVT8EjL+ZhI7qCtcBWfi8gF7xfGW5iAQUM60tW/zDekkCJR
	wFTDChlu/fJ26RwRTLj8If5JZdQXcDECcxG4jlC0YGsgqKSpg7eW7KWT
X-Gm-Gg: ASbGncsPyALHuvIWA7cnIdC/8BII7hp7Zi6DpE4wiRBrhpFXvC7crXOxT5ec70F47Sk
	xGVKcRxOO6d++TTV0BplN620WDQRd5eFLXgik/m4w78PWus8K7LTQGV6dvx9MyvH4fSe3oFiVWt
	v4XRR5W6cP7yI+e+bh+G1cOCKN40wgJB6Pb03n9eWVd6diZq/gWEoLfFDfYNN7xsCilbScARGR6
	zKXth8fy/5opXst0muA5MMXLxTsvIyoLmhotXHGHZGJQclPia1vU2q8qeoNhya5GkpBjciaV4Zc
	zuJEbysK5T8k80USF+1nXB6LMhrmylwvMPmEdey64FY4R+hgtbFdgOlXT1jfIoUeAXhLX5b7yWy
	0x4rVEi9A7yfg5u6krC9f4cQE6Fv0qEhrhbRNsyPvEsLE9pc0oOFCF1n4simb75z6gKXqKD92yT
	nmzLTfrEJGjhkbeC4iM6sBT8GZskCTeN31BKN9
X-Google-Smtp-Source: AGHT+IGzkMph0aR1AuSLsLz+NyiUmW9UyqgkXIKscDfhGHTikd7KQOHT6TykmLaTJLeIJUZrZX00oA==
X-Received: by 2002:a05:690c:61c5:b0:786:a774:e415 with SMTP id 00721157ae682-786a774e5d7mr54395367b3.56.1762370643208;
        Wed, 05 Nov 2025 11:24:03 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5ca403asm61413d50.8.2025.11.05.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:24:02 -0800 (PST)
Date: Wed, 5 Nov 2025 11:24:00 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <aQukUFyuN+iJ1zv9@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
 <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>

On Wed, Nov 05, 2025 at 03:48:09PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Testing with 1.37 shows all tests passing but emits the warning:
> > 
> > warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
> > 	The following versions have been tested: 1.33 1.36
> > 
> > This patch adds 1.37 to the virtme-ng versions to get rid of the above
> > warning.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I'm just worried that the list will explode. Perhaps in the future we should
> just define the minimum version that we are sure we can support and the
> maximum that we have tested.
> 
> Stefano
> 

Sounds like a good approach.

Best,
Bobby

