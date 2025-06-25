Return-Path: <netdev+bounces-201126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CDAE8299
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DAB16202B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96F25BF0F;
	Wed, 25 Jun 2025 12:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBE221DB2
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854241; cv=none; b=jPUo9cxohuTwAT/FpG3/LV01u7p6iIZk9gKTWO2jElJiJLhCxq7znPuphJUuKgjX6nJOKuFFC0DycbkDRvr9kZpF9j5EJdnAStfHuC5byQa5xhieBbSIsWWhEZhgH5jyEPdtvm1wTVOhks8ng2V0hScdcYFhqzskvxNO/zlmfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854241; c=relaxed/simple;
	bh=xmSnW1cC18I65V8Rr/YREGR0HrXK8UVmpCU4mDKH5c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBE3JCfczViHXCMcgzyKOGPoGkjKwbwpc0J5n2/Oau+GVKtu+Wj9H741PZu/nMxsL4qHIU6d/zgUVaiQXjb2PoepeK5NzBU/QIrGa/dyeew4rjctO2hv6ABi3t/YZlqUVmysjvhHXydDKcgW6EZMj/sX/zYd0+UBcpXBGUyuaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so10336629a12.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 05:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854238; x=1751459038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAf/sCOal49NK3XTX4yN9mD4BrqJ7MOzywbMZOZFhSo=;
        b=OSYtGii05tCo+8qZQtmo6dnbAzqmscFBwHOryUvK9Cc9kG6OSGh5CA7mIrr03+9OZ5
         qSmN8TwpHBN1gYnkY4hAYygMf6TZVnUBvBHH/WifSmXHhNE1b2EUvAekq70yDWOcuYOa
         nEk6RVN9SPqAVL43R9XvrzuRrxCzm4zYrPcNQoq5ISiq3bhl/5Jwi/DfWxlg0TgS7Whx
         Pn+5Zawp8+2O7GyCPWIYMteOJeRNO2tH0nEIlsPINjG43wlFJJBYQsMjgFCuLtDlb7Vb
         nLqBYRkA4G1s1GoSEy+10gFH7GrykoGeGkt1n/oe6l0SV8O+RivZZZbPmBzmTpQU/pYK
         lIvg==
X-Forwarded-Encrypted: i=1; AJvYcCVeSJ7ZTcQbozvLwnu9NJ7HdffTVYMlFiE6FMvtrf+9PqFB4r5P6cvN9lXsPSg1ww7RSGKT/w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuFMiYHAneHm7BdSiJFT0+mQvl8q66gm9pqNfeEdjd4cnXKXv
	zEdL6l9bX8nuJBgGmvbIUq/MGSQisF3SMcvLkGi49dbFBLwW5epEhhMP
X-Gm-Gg: ASbGncuEmUsevUfKcC1QvmC1V4CP4n0PlG+C6pFAtwScNFhG66EZZo6x5DARWt8Mvw4
	pQtNZOJqt/FlvHA+Un6amJGZun5KafZWL7Tq1V0n9ZcFhtaC0r7izY1bqrz4S15IE4XzpCxR9N9
	+G4d385dmf75gYm1Gd6i/O+PEM2K5XeZHr6IuCCLdELnfXBPeZt4OaEaTxkzgaDyEtTGvzmuJi7
	UX1CI2DYpe1d/a1GE41/Vv/No5VO0rrhU+CjdoYR0UMPCuw5yfyRggOQ9s/jXgVXl5zzB2yMTRS
	W2YIOzx5IDMV+vH4gxfXz2cntAfIihGu32wJv8F6UomaNcZYpsS6
X-Google-Smtp-Source: AGHT+IF3AsACXcG1nt9VpqWj5H44JplgBRSlyWhjFSfl5Gponwkj8yWkS/VKLObQFNC3Xs6OjDWS6g==
X-Received: by 2002:a17:906:1651:b0:ad9:982f:9206 with SMTP id a640c23a62f3a-ae0bea7ecacmr231645566b.61.1750854237775;
        Wed, 25 Jun 2025 05:23:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209a80sm1056705366b.176.2025.06.25.05.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:23:57 -0700 (PDT)
Date: Wed, 25 Jun 2025 05:23:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 21/22] selftests: drv-net: add helper/wrapper for
 bpftrace
Message-ID: <aFvqWpnkGaDazk3D@gmail.com>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-22-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-22-kuba@kernel.org>

On Mon, Apr 21, 2025 at 03:28:26PM -0700, Jakub Kicinski wrote:
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

FYI: I've stolen this patch and send as part of my netpoll test patchset:

https://lore.kernel.org/all/20250625-netpoll_test-v2-1-47d27775222c@debian.org/

