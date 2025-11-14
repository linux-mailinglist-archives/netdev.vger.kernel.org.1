Return-Path: <netdev+bounces-238656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7724C5D048
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AE484EA9E8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B23128AB;
	Fri, 14 Nov 2025 12:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8A236A8B
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121750; cv=none; b=mlkL0p+bOSJYC0OvUu0odTxtvM2624msthK7SotFzgZQ6kElusNVFuAhEw6IsLUkWadhanFoFJVKWL2H4fXOoy3V7gB7DIqLdRVTxed/yyegfuziVAfnAFowJVi2VjvqlQG8aicyGOauE/D+wttDwv9sC4wolF426BT3QCYZ2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121750; c=relaxed/simple;
	bh=P2rDbxLN99bxs6YPpinBiTSsEfXXewl5hHR6vjb3rvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSUqRMCx5Hkw1W+GtJS5Tx9XgGiMK6p9V2W4wjYUZtvDm1ciPBwbaO+q4odpQMNaFKXmIJwmEZda6ObzheeBAKZ386ghADn5iCQBpN27DrfS6TR/mNHA3WHICyOXsAULClaQ+jlR3Qc0R3jXgr7UrsOa4ruHYat6+ngJJtzwMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so1384368a34.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121748; x=1763726548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUMb8rT5vzNFBptKdq2Qr+S+DTsITygruouKMFYJoco=;
        b=ugsLTySGKGZIZbq5yiN71GgIFcalh0RQC/MSADzGhF4homPHTtTPtKQJPBXnMdzXle
         u1TZEjHgvCtSN1pInckxfom9lGGDwlmUu+ZO3iWtB5NY7BtWR5wbdOFD8UddXWQM9m4X
         UpllP4p/IYNc48MMLvUYRzgknDPiNa7lbZ5pijPxqxpABoIlxSUu0KeDktiI0PDV29ed
         uSGcGk+ShtqNJdk9IDgUPxgrr4b3j+uRHbIaT7nzmFe7LmC8nSH4692rgeOdFNeO4HOz
         1JlRlB+T6OO2/a9PegshbSNQwIXYN2dWhJDVM0Sch6OGnlA6w8zgowKMXQz5c4DOPtcr
         nvJg==
X-Forwarded-Encrypted: i=1; AJvYcCVq3yfBBMmyiAzWfwc9aRGWgWpR1OXBBEnN5wlFd5q3Atc1448YczlRJuGtlPJXKW1Zj7SuM0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLXUSAb00OFEe6wU45KerWLBDwnzLdD8czuvYG11uHZNE5JTN
	4hZxE/tawZZsicl7pukmrbuxBJzzTTjVIz0/JoysEOL5CpHe/CGPtd+T
X-Gm-Gg: ASbGnctEik1BA1wJ2PD7rqIPMu0lSn8yX4qE75P+mPa+7zkaJJPmUV5f5qlD97tVYXI
	eYtMwGGnzVN3w7ClrKogun8USDkMUDOQULEBOvF7uAhDj87Ef0ng8AoxRUWrLGEFpYC8Ta0UdoR
	n/I2u3p6hjdXlDU4r8u2PpAHiC203E6b5kyh0vE6L8frOTBw8U0TISXGfLa9es2V18XWE6oYncF
	ZOPdUpJsop0P/260+r+A37ENETcLGR/MpqJCPgzSAxPtpdHRONoHPZpozFSPHjusUSRrtsABHKQ
	QvgaErdNJWUgHcwZQkXQkP80wTeoi0U7QgK2BsW+gcJ3Hy0IGrDKN/WWw1p7TsxjGoA6bBIRX6p
	AGh0L0YYuTvesiTlb/bXha4OMWY2vp+54qcPvYJjwtEDLDu1fWV8kxAraAjXE1GtAHmNAoRDNR4
	K4AOU=
X-Google-Smtp-Source: AGHT+IFj5d1/PW8sqxWgMu4/IMgSKSuw1jOqaWOp4Y/7Javx+X8Crn+xn0RTmUXT0VZYyIRBs2mAcQ==
X-Received: by 2002:a05:6830:920:b0:7c2:779a:5c4f with SMTP id 46e09a7af769-7c7442aed40mr1473379a34.2.1763121748040;
        Fri, 14 Nov 2025 04:02:28 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3bddd2sm2421111a34.25.2025.11.14.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:02:27 -0800 (PST)
Date: Fri, 14 Nov 2025 04:02:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] netconsole: Simplify
 send_fragmented_body()
Message-ID: <f3zsfjju6gsnpkq7ikxamlkncmirtvbt2fdieyqbpfbfyjjmkg@d3ezd47cqwip>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-1-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-1-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:18AM -0800, Gustavo Luiz Duarte wrote:
> Refactor send_fragmented_body() to use separate offset tracking for
> msgbody, and extradata instead of complex conditional logic.
> The previous implementation used boolean flags and calculated offsets
> which made the code harder to follow.
> 
> The new implementation maintains independent offset counters
> (msgbody_offset, extradata_offset) and processes each section
> sequentially, making the data flow more straightforward and the code
> easier to maintain.
> 
> This is a preparatory refactoring with no functional changes, which will
> allow easily splitting extradata_complete into separate userdata and
> sysdata buffers in the next patch.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for this refactor.
--breno

