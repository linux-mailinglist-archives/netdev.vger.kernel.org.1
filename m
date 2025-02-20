Return-Path: <netdev+bounces-168240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48249A3E3A0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2157023DD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9A215053;
	Thu, 20 Feb 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xad7Lbxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C321480A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075369; cv=none; b=pwNJZINa8N5nrs0a0c85wIkIxqag6eq9JcTlTaGEySyUwGDTnn9oWhMTLmUdQq226fnzaLhNxdtNg0uYrIctMjlBhYLVxDFAAxz+oDxLNq0ni3NZW3bW/SZBUINxm4DjcVbTKCkC/5jtp77VoJBogyg5UXS7Gixtq/EPtsXnQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075369; c=relaxed/simple;
	bh=CqaYN9ba1JC4exm0v/aXoABkFQouqPchJ4A7TptrzA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7Kvk362/trRZuKFWUwSiy1ywBpyp4+eH0FdrG7yUUrjXCB8v9PdHZwPhF6C17xB6f4odV9tofLDL0+lxxXYVGlTmFLKXF9Xd/JKFAcaF69WDhdvpvlpNeXFywyRb0rS6ceJ09NQHOngO8uJklWQnFHT76Z0OXMwAd4sAkkBumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xad7Lbxi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0b24cc566so103108885a.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740075366; x=1740680166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihvxdX0Eo8QqJteSeQOugcj3Cmf99WeR7EZ0mstg924=;
        b=xad7LbxiDt/WwHrVfeidGzi18EHwM/ZBxsoX+3Df/8LTf9NVaj4X3rxHkZTvygDJP2
         LfZ+C8JOpnGUABxLBfIN7YPd2ceyRxn8aPOay02+ELGPIleZ7HVVdSbRKXhp2/9BstU+
         kab2+BEbrc/0cZKtzQ3N1xAYH6x1HpF4oBGHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075366; x=1740680166;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihvxdX0Eo8QqJteSeQOugcj3Cmf99WeR7EZ0mstg924=;
        b=sN73SUdaoLa28r8YB9M5rwnfSHrC+ULHIiXuz7FBYXLqKV2Q5aqkHzgHHi15dzzaE/
         GagHjt2l8LVnIXks6/FF5gNnmv8jh+ZJZXIIJLiHx4g+JOD2/XfEAF5g2CEQxJxPDRmY
         aiXeQIcSPnFPsoA10W0eLdhQ2yr1RyyjybcjXFjBbqbwGBPkZN47VVJPlKJcozpNm+ak
         2afzqy5+BSANwcWJ2poEPlohoJ85BRogJjJWn3bF+OIVsQ44mNHyeDaHvuUhRDtlfp5a
         VYCPLmDjawaGKfdVCX3h1oYpLo7wXLt0pAxXIfAieB3oWJ+beFG7c21vZn+lm0zxT/ZK
         4oww==
X-Forwarded-Encrypted: i=1; AJvYcCWnugTe33K5uAT39NGV01oXQjlbUsa6vt2G0pXmAWPgqdII8pKyEr2wNB5mdZ6ZJBQ7iuR/We4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRl9aUpsRXjgfmWHeGBCn8xvu7NscIGqZxCqIr/TVrmiqsQPtA
	IJXMaIyvWjzROtICfxJ4uiFezHrNr9NU7TL5luFRnK+wDRMlQesMR1SojDG4c4U=
X-Gm-Gg: ASbGncuk6VWhDruCjWCr2XHv6DIAW7KnFDpbCeQbSqz4crKtyNFBTRykSH/cwRvCaQX
	fsqwGwdYThZ8sTERNoltoTWdJOnhQBUeMM63juugMMoIYSBxnPgiLWNaZruDc12vamrq8ssb1Yv
	38wVmDzwgfxVr72GIdDIB2BfXtpnR2pDd62TH8CMivxXBrcxH55v7/zym9TziF4Tk/1Pe61TR3a
	fug/JcN+Ot47C3/VkkEgxrtqyf+Sb5Uzuvuo6eqIQoFcanC66cPzUaJ5/tpwVf4VXFONN92T2kI
	OF623vN/37KfsIKJcKoUDNO0qa/MwtTKQC8Zaea1KuTvg/6BQu2dJA==
X-Google-Smtp-Source: AGHT+IEe8IPct2LrWG5x8QLQ/2Gvkswrv0qrGD4AgkeTITgNQW2Gw2o8EeNLGJv2tlp9Gr2jR6Tm+Q==
X-Received: by 2002:a05:620a:171f:b0:7c0:b0b7:493e with SMTP id af79cd13be357-7c0ceeebcf2mr36000085a.7.1740075366685;
        Thu, 20 Feb 2025 10:16:06 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a26a1a03sm454961985a.46.2025.02.20.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:16:06 -0800 (PST)
Date: Thu, 20 Feb 2025 13:16:03 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 4/7] selftests: drv-net: probe for AF_XDP
 sockets more explicitly
Message-ID: <Z7dxYyL9byyh1Fow@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-5-kuba@kernel.org>

On Wed, Feb 19, 2025 at 03:49:53PM -0800, Jakub Kicinski wrote:
> Separate the support check from socket binding for easier refactoring.
> Use: ./helper - - just to probe if we can open the socket.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: new
> ---
>  tools/testing/selftests/drivers/net/xdp_helper.c |  7 +++++++
>  tools/testing/selftests/drivers/net/queues.py    | 12 +++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>

I've tested this on a kernel with XDP enabled and also a kernel with
XDP disabled and the change appears to work as intended.

Here's what it looks like on a kernel with XDP disabled:

KTAP version 1
1..4
ok 1 queues.get_queues
2ok 2 queues.addremove_queues
ok 3 queues.check_down
# Exception| Traceback (most recent call last):
# Exception|   File "/home/jdamato/code/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
# Exception|     case(*args)
# Exception|   File "/home/jdamato/code/net-next/./tools/testing/selftests/drivers/net/queues.py", line 33, in check_xsk
# Exception|     raise KsftFailEx('unable to create AF_XDP socket')
# Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
not ok 4 queues.check_xsk
# Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

Reviewed-by: Joe Damato <jdamato@fastly.com>

