Return-Path: <netdev+bounces-117007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E3994C524
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2A1B212D8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB31494CE;
	Thu,  8 Aug 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGgbxDAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B95433AD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145288; cv=none; b=AZuTSPDC5ziPFNtdiQQek/zu3FOu4vbH1ENffT0naKyl9bw49cb4q+shcafyH/3jVznpirjnLvuIhbgKx0PVMnpgrhCNw1S2kNepWKLcBoDGPbNyxtmg+C5fVDK0zevdZwN6a0pub6N3s4r0dlUmJnUnyNFuYHmjd7skvbvsJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145288; c=relaxed/simple;
	bh=pYIYtpSDcBkGz5YGj+6ttm8HNDbP8VLiDXOqihTeBZc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Tsq0GzcKN+u0im2TeeejhT/a8SkRsw2UcGf+6sf1yWcS/FQoek3snpjky0KWE0cG/M6copzsi6aggj1sw82tIs93uMo/Qw/l2lZuWxXqeyj8ejeBzC3bGwAXTzfd/4B3UNzqFMeh334H4dZn6NV9ButcUrmjCKxSGWtBo6p3w00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGgbxDAl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1e31bc1efso80741785a.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723145286; x=1723750086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AdGvHvQeGM2/3/1z86/xJ+xGDENkwM+YrRBA7tUy0s=;
        b=CGgbxDAl14p6I1RYQDO+tfZ8FGLG2VQD9EsdExVAcFQisMXtNqpSIq9ult9Zrfv6nS
         0aosKJmdf5OTzicLJQS/9x+gKGEGcM12LlWT55W069PODNEDJ2pW9fIQ6rRHGSpVr74V
         91lbuY1ooWUJ4r7qAgco8sREdxCoPxrYzRabDFxJoXSkmHY3jG7ZSt1Ptpv1burCC2mf
         R1USgNHdMRx/L2EVWn+V+bAttVEFSpvqq5qE7m6p268c2bGlEHZiNNLGbvKuU/cdkKdr
         tly6aUXrJ/pPyJ4ZbJU521+Sh+O9ng4PMO8TuCSJ7eFpCsxs3+n8mhTVpeESZ4hg4eZ2
         3Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145286; x=1723750086;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1AdGvHvQeGM2/3/1z86/xJ+xGDENkwM+YrRBA7tUy0s=;
        b=bV5z3bluqGEr2nf5MHyWwZbPVjMq08fNRrqD5cglaK9ZXnvr2/BVVWdNslPjtAI2qk
         kIUalypZlrsCuI7PLGYKMO4rJHEU/H6JVcd9taUJLcUIrY3E/PhEDVi8ZpowTMR2/hAe
         NFJyhnagak2pRvzBt6I3kE97oVsld9ZxNZi/hmqtIoFGdhBpCFmxlVusXaYuiVxIqqeC
         vu5s5wqGqxOSRHAi67N7q4Ub6TH1NEp1pidoQq+jjRnjwYpvXb0bdEcwkyNBQzLF3wsC
         HnF1vm2GW4C8e9t1zqkTtz1H3oiicvvKhWR31TxAlUHcp6yQt6dS4RvkH3Pqt2XTAVeN
         +ChA==
X-Forwarded-Encrypted: i=1; AJvYcCUvJYmzu1YntMgWP4Zdo+dEBBIR6zhQ+HP2xGBSdCenqSjRODh+x+NcNtf37BtTMxjs2DDsGHKv5sykuZffCZa3hMPf6FWg
X-Gm-Message-State: AOJu0YyitfKdK+wdVWStlAuczoW172oSvtfBC6VFemSkj2D0Z6cPNxlw
	KWLHIsbRj8WNKcZcBHfT8iupdRdmh0rXyJlnptbUKxIKVAqAOWU9
X-Google-Smtp-Source: AGHT+IF63Y6/Vh3L6sRutSHVcILb4GTF+px2/O135smYVM7aVBRipBfPraMv8UOaApw8T934uDVgWQ==
X-Received: by 2002:a05:6214:3a07:b0:6b7:ab98:b8b3 with SMTP id 6a1803df08f44-6bd6bd33c03mr32853786d6.34.1723145286178;
        Thu, 08 Aug 2024 12:28:06 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c765e56sm69524436d6.11.2024.08.08.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:04 -0700 (PDT)
Date: Thu, 08 Aug 2024 15:28:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com
Message-ID: <66b51c448f327_39ab9f294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240808-udp-gso-egress-from-tunnel-v4-1-f5c5b4149ab9@cloudflare.com>
References: <20240808-udp-gso-egress-from-tunnel-v4-0-f5c5b4149ab9@cloudflare.com>
 <20240808-udp-gso-egress-from-tunnel-v4-1-f5c5b4149ab9@cloudflare.com>
Subject: Re: [PATCH net v4 1/3] net: Make USO depend on CSUM offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> UDP segmentation offload inherently depends on checksum offload. It should
> not be possible to disable checksum offload while leaving USO enabled.
> Enforce this dependency in code.
> 
> There is a single tx-udp-segmentation feature flag to indicate support for
> both IPv4/6, hence the devices wishing to support USO must offer checksum
> offload for both IP versions.
> 
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

