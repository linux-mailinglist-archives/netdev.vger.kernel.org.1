Return-Path: <netdev+bounces-71010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249908518D1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F39280E9F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512313D0D2;
	Mon, 12 Feb 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2cAYOLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FF3D0C6
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754764; cv=none; b=gjbLW/y0Ug+rG502v83dkx9QJ1ND7vLj5EVwIHjv/c0ialFw0RBizpBS/1SZf44apHCjR+MVWESb7/NY9u8OUtvPpMaBlHifm5eDE+OBtLA6+Buo/XTqvaixn2CNeKaykfWr57GNsfd6M797KvhzthjQ8/TsNvj285lT8eQehWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754764; c=relaxed/simple;
	bh=U64gvLlDfOMzVcYEIsGaggJTU9iembPXFRSVhO1RPkU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Iklr89Xwj54MWtZEUPhIqTmFva4LJ/oDlYocelVw+px+YRFAeR86q85zH6NoiJFey5W/K/xroXcIAiqfsDDl0GulX2aek2cdOUqKjGtTYWCTigClPAIO+gfTjTGA+ZklWyK7mu0j+LglJk9eiYjY/R+KKujNePX+Z2Vh1j/6rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2cAYOLm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ce63b1d30so3495111cf.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707754762; x=1708359562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXLjTuP8gjSgEaNbQyPphVppBWGE/fLPXeF8p66gJqk=;
        b=V2cAYOLm/03M0OXsM+RIQPy5r+ITsAuPKN01Zm9jAYQB2iOh7glAsNhCNIfpS3EE76
         dNvBwVh65BSeI/sSV/PVv+UhjOd0aM5EA057Uzd6PEchFJ+gbMU8ea+u0DPk61S+Dp/w
         G02oRycQVTliFyktmVE6/7PJOUzpfEhdXvzHKgkcnJVAwgBaMPofJWPGjKCc5WCTzNzs
         Rv3vy6Ke6osD9iNNSftABaD+BhqF2l1WinKtgomOmJlRznfkyap7pngoNiXBqPMpbIO7
         EMjlUwQxVMYbqqwzf7Na28puEDDWUkmTg0uk+BNy5dMlIhQyEIDRqmAz9fvEx7q2AdK9
         vYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754762; x=1708359562;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXLjTuP8gjSgEaNbQyPphVppBWGE/fLPXeF8p66gJqk=;
        b=M9J69sm6J99D7PUb3RfpaM+/7JSxd1V5QFx6pu46c52PUYJC7lgZWscaMmLreJwGGY
         BFzmlDvdnmF6R0dn6bwVbPP2Mj2I0RnzFiR0GhLEMwwtEWSKum56pEidwT+C+7NoX8BE
         oOUV3QJSrLuuq3X4vIV86sJGjCHSb9gjvxO4ETc9BlOvrnLmrs05qnTFBdp3QhazNr1b
         uzfXEjRLrnMilxPYsoIpyqev4A8ATGXhvBYIaBvTYU0VrXYNyfLWdZ4pO+jDtzCLDZvn
         a8g7E23BsPxe5v1RPFUASJ1EzyVrsDWRf5eX2NdYtdMhlRlAJwkCwc+xB7J5r2t8Icp9
         kA+w==
X-Gm-Message-State: AOJu0Yylg/jeHnNpsDBgVRql7jK9QBt8DtzXJeCOr3rReKIpprjgacss
	Mu/JUfGK1aEL7gt6BKX/ESo/VSWYfmkdQBqq/siY6wiUIe84p6WC
X-Google-Smtp-Source: AGHT+IFvLXmELFaFUm1L3lUcOpmPNHefauVsxH86uPZfps/2BN2OiiGw223kL2oaDG6taQhhYr80yQ==
X-Received: by 2002:ac8:5a55:0:b0:42c:7586:71f8 with SMTP id o21-20020ac85a55000000b0042c758671f8mr4272139qta.31.1707754761792;
        Mon, 12 Feb 2024 08:19:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhj9NV/BW5Q38jIj6lx8hMgehGmLU9t6Iq5mRXhXl69mR1ELJmhB8P2WmN2rQYksLe48mw8Y0o2sAp8niE0CZyC+UmsGJKWkXOt40dfa+asgohuSei8ePqAsmqtfbr/lS72ieFfNviD1k4bmkkHYDF9pkwRJL3Rbp3UqrPzz7vqL+kiQAg0gUlP9nnpL9w5JZzRaF0Zi2K83OD57FbAgAd4RbVmBZs0HH9ZkTBIrlWM3KnMFc95gXv8TtChRVdZ/RNsyKF6mnoh9y3aE8JFxADiA==
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id ke20-20020a05622a289400b0042c6ae89193sm270136qtb.93.2024.02.12.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:19:21 -0800 (PST)
Date: Mon, 12 Feb 2024 11:19:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andy Lutomirski <luto@amacapital.net>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <65ca450938c4a_1a1761294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240212001340.1719944-1-vadfed@meta.com>
References: <20240212001340.1719944-1-vadfed@meta.com>
Subject: Re: [PATCH net v2] net-timestamp: make sk_tskey more predictable in
 error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
> the sk_tskey can become unpredictable in case of any error happened
> during sendmsg(). Move increment later in the code and make decrement of
> sk_tskey in error path. This solution is still racy in case of multiple
> threads doing snedmsg() over the very same socket in parallel, but still
> makes error path much more predictable.
> 
> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

What is the difference with v1?

