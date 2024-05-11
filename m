Return-Path: <netdev+bounces-95683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C258C3022
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287A1283EB4
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDDE4776A;
	Sat, 11 May 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mny/XfnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508AC14F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413347; cv=none; b=uovLrDFfZqQosMQ/91JuOvBK5+7NGdZNsuQKCXGB6gd/59abbaf2u5gQig4kPAoJp7funh9KY2Os1aFVR9PZR35h4OXxue7D1lej1MU3By7AGMC5iNNPzjj38Tp9xxjRE+uH2NGShiHKHEujy/YeOCAiHloduCXzKUNW141W8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413347; c=relaxed/simple;
	bh=kL16KIc3gKOFT+K/Z7HhD+ZKWW5POcTfLuTkkPRlZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuBf4cAtXPF2V+EBIIlGct06WrcSb5iVmGnN5fIZGTGLKFYnKZ/hqAU4bxDHviklbhbAeBtUE4J8dF9UoOVrgR/D5V9ZXEAYlrJMtkKn5+qT0OHpo9zPJt8Dxl7VR6hpSjQbse9OCI6Kjs/59UbeAHv+bUla/0tFar6Oxlch0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mny/XfnL; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c85170db2so12823175ab.0
        for <netdev@vger.kernel.org>; Sat, 11 May 2024 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715413345; x=1716018145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL16KIc3gKOFT+K/Z7HhD+ZKWW5POcTfLuTkkPRlZU0=;
        b=Mny/XfnLpbxkgJfb4LmZFjDMvZYZyCYVxnrfzQme30RnbHdnvmB242fN1bJN3fVee6
         vIJEi+9cCCoVqKDw0jBTNAB9U4aI0BRrsQS0rmNhBhK+glzHM28F8kCD2GniDtfawFja
         hS3zYzBGVFmnz02hG/7Rm39s4HJGEawjgaMtE8mGRHDw7EQknBIZNYVyHwdAjMSkZvnj
         bUf88D8nB/E99FQ8ifpvvtyY6A1837xnICIrf8W9VwDisbaUQUmSy6m7Grdb2qw8QKP+
         jondgFc1rUx+Xq8c2x0q8EBc0S/kS2/cmSHYQEw1Zp9gFetBIlE0eyo274Iuk8nyWcny
         jpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715413345; x=1716018145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL16KIc3gKOFT+K/Z7HhD+ZKWW5POcTfLuTkkPRlZU0=;
        b=Btzyg9EmIb4eSN46DS5CoaHkoZxsTF8w/lq9bdEpKZh/OomRPABQ2zoKC+kuWUZNg5
         RIiZrmHGplzsQwtgKBNjj7JG0+ywaOSsmZAouCGvOia6PeeA3Oxutd44CkwfmBo34Hhz
         iJbOOqgVC19eD65QV1QnXsqt2e6yJpxLADmN5U/YtPZ2Dg1EIEOWkHyqNDBuTCd8QydA
         /iTNlHAytnZ7C8vhbKI4m1d5srN1TFJEQ2DyGRwe7a8YMWGUAOcnNpDMsyiLOH8mfllm
         /KtaAUFKcoR2oJw5dkuHQtYHZooZ9+5y/sgtTS0/9MbOCYo2qkA8Nikae4lzhlpNkW1F
         HcNw==
X-Gm-Message-State: AOJu0YxjcMk91vYZMtEhbgbonWvnpgbImday85hLdD9zF20iP05EWhUY
	GQU6RQWfjggSC9VRs7jaTY8R+EbIzX91dCujTkWv+KzQd/J7RiCa
X-Google-Smtp-Source: AGHT+IFxpx03jmAFOxhkwHyMGm6RlyyGs1zJ0XolCr5nOYva2XTvWSsMSSfvY9bUZRBAKbPE6ghrvw==
X-Received: by 2002:a05:6e02:2184:b0:36c:73cc:710f with SMTP id e9e14a558f8ab-36cc1456286mr58184125ab.3.1715413345669;
        Sat, 11 May 2024 00:42:25 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b769457sm4198776a12.33.2024.05.11.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 00:42:25 -0700 (PDT)
Date: Sat, 11 May 2024 15:42:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCHv3 net 3/3] ipv6: sr: fix invalid unregister error path
Message-ID: <Zj8hXAEW0zBel8_V@Laptop-X1>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-4-liuhangbin@gmail.com>
 <b6d0cbfe-e1cb-44f5-a392-38cad6b40b5c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d0cbfe-e1cb-44f5-a392-38cad6b40b5c@kernel.org>

On Fri, May 10, 2024 at 07:52:36PM -0600, David Ahern wrote:
> a good example of why ifdef's create problems. It would have been
> simpler if all of those init functions were defined for both cases and
> this function does not need the '#if' spaghetti.

Yes, I will post a restruct patch for net-next.

Thanks
Hangbin

