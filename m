Return-Path: <netdev+bounces-134408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5469993D0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A55EB2475C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4041E1C15;
	Thu, 10 Oct 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Vb26OtuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC21E102C
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592829; cv=none; b=KHn8fE2L0B8lYxh7uqg4KrgRJIglutEGYSgG2DsZsWw29WB0VhqtUpnPyh4cph5YDHh6+SQoWHWbaFESkqCqlmjaqyaCv9X1wdOWaVQgaGf4pw0odHef7qHMEi6LdEqeo6+NReMaDTvUb9D+y4lMs71T6NKPC4ncfVdMfsCsw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592829; c=relaxed/simple;
	bh=zkZ6yU7DAD7YlmNJhmdip7MiifrOdjdqdbURkrcZAYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjVyn1O+ntLoCHTTohj47evxZzpS4frnStw3nubUgmryRKp/F2aIIYZVb9NEYlQc9PxCXzf7msTmwte9xWbN5wnE8FDVRV/nlBxw88arL6OZjqm8R3+SjX6bCTB8IIPKJSmlB7S9USXCPxDtjAtyzzrNfj5rq8hTEsSs8BdUwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Vb26OtuE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d49a7207cso683582f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728592825; x=1729197625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO42RQZBShP/lWCFh96DLSqblFSQl/8nGpu3kPW9gUQ=;
        b=Vb26OtuEA5psk8oKRqbL9ncjFN+fSdcc05gol3AShlW2GBEilMuCE6vjNCikA1j0av
         eWCcEDeJpfgjg0IYatYWao+zQpeqOYdbX1rTPuNPto9IPiRQ1i71tx1Oy1eTbnFgTVZK
         lCj63PU0FWQphuTL4NmojGHEjHrlBTCtzL0u/fkNzI7EoiDptj01HX4ejt5TpvtehKBH
         4DnXHvkq3zpeSbAl3osmghVDT1OlCL4tRuzRcehauHhq/MudRbtdgsW6ilXKiHvwNFnp
         aQsSHKcfMlRUxwQk9FOLyhUoMa2aIpkvni8hbR2vHTchk71lgYxig+asFofWr470cchd
         P0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592825; x=1729197625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO42RQZBShP/lWCFh96DLSqblFSQl/8nGpu3kPW9gUQ=;
        b=tK3d4uRdzfHxIHsHO3EMH2TRnJv5xOFVkekIoJyoYbN6DZWFuQb+TEwEuLlJ16bb61
         /TiG8YRMj4lo32P6M+JHi2HmZvynCEGsL0ZD3nVRgmw9I7zbwkL2GlBTfONjxdCNG+cg
         cOpfxflqLBPP1JBErfo+3VKfcd7UXrGEYpDc4w46nniBa/+mcDK70nsNhq5pLrR19ucV
         OK8CWz4gjiI9AAcSwnnZSXZI8h0ijT8p9hwbsnr3pid9SMAfUUDICm1Ke9l05ytWrkbk
         8lg4lDJMra4STijopcLGFJVBMjFY81HCjTbvXJ5Gmpskr4JoQpfkNNFwsjwAYmnfLcNX
         MNjA==
X-Forwarded-Encrypted: i=1; AJvYcCVwlGESxIe1sB1RCwTKn3g9Kl8GNO2ZOqpJidjMHVKvbtp6nh/IfBh6SggLI8TD148i8+dU3eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Eqf6qXHSh/ON1eozlLpKngJGU0oYDIDSWvO5JWcYO6c4pkSa
	C5+18o3sr5xhfF/+vZ2Sjd7hEBMXCIc/DOIQEBqhEmz8fRcipEDpUVJwff0Qm+g=
X-Google-Smtp-Source: AGHT+IHxYd9hOLDOuUcfxARzg6HTs3XT+7x6QJejf/5EJIDnBLsxJtYDpjq4FC6Qz2lH63Rfd81qjQ==
X-Received: by 2002:a5d:4591:0:b0:37d:498a:a233 with SMTP id ffacd0b85a97d-37d552ee198mr196344f8f.43.1728592824756;
        Thu, 10 Oct 2024 13:40:24 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8928sm2339875f8f.7.2024.10.10.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:40:24 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, upstream+net@sigma-star.at, audit@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
Date: Thu, 10 Oct 2024 22:40:22 +0200
Message-ID: <5924990.Vcsy2DjxtS@somecomputer>
In-Reply-To: <CAHC9VhRDZVJbhCbVkfs8NC=vAx-QdQwX_jMq51xzoTxFuxSXLg@mail.gmail.com>
References: <20241009203218.26329-1-richard@nod.at> <4370155.VQJxnDRnGh@somecomputer> <CAHC9VhRDZVJbhCbVkfs8NC=vAx-QdQwX_jMq51xzoTxFuxSXLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 10. Oktober 2024, 21:09:31 CEST schrieb Paul Moore:
> However, as part of that commit we also dropped a number of fields
> because it wasn't clear that anyone cared about them and if we were
> going to (re)normalize the NETFILTER_PKT record we figured it would be
> best to start small and re-add fields as needed to satisfy user
> requirements.  I'm working under the assumption that if you've taken
> the time to draft a patch and test it, you have a legitimate need :)

I'm currently exploring ways to log reliable what users/containers
create what network connections.
So, netfilter+conntrack+xt_AUDIT seemed legit to me.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



