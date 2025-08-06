Return-Path: <netdev+bounces-211866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974FB1C142
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426C8189D790
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D79218ACC;
	Wed,  6 Aug 2025 07:25:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134720468E;
	Wed,  6 Aug 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754465103; cv=none; b=BLSLHB2Yu0D3Zsvp5opfLsQNoMSCEmk7q0SE0xpm2ydiscIkOLasAQ4gI+InuIGazkuUaDAC8Ho4XfidH81fYAmkjFzewAmbXL2zfarypmX3bUiGMncV9u2SW68DrJ64h1sJpqUTA4IEgKkkARS1igHZoZQK8UJqms+6TBGDWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754465103; c=relaxed/simple;
	bh=vAyQjzdKloag6yEo57pIpIcddwUakldw+0v9sT0viuU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pjvs9RWi9jLMDNy7UG3nMzCvJGbeUTg4l8tKqzb8hGVHgXYHwBanSBcHr2tOvM6NMcnqBLh5Qzn06Qt1/ph15h1XArRfyE90k1Ko4SqjpRRp1ZedFcTEKtd4irBiazlBQvbG1Wgwgu2wn7ZGVX1V6IcGVhZKfw8j2DBEzSBKfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b783d851e6so5450879f8f.0;
        Wed, 06 Aug 2025 00:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754465100; x=1755069900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAyQjzdKloag6yEo57pIpIcddwUakldw+0v9sT0viuU=;
        b=dEGd+/PpTvjtqSXKqzbgb99snw8/iAosb/OMig+6WR9fkYh8kI5q2OkIq0v2PilGM1
         dsULqbtZu80M4pNfYStcoFk8py45rqPpS1Xs80UTKBNoKX7LP2PKhkA4csQbFWduOOYP
         ASicDvK6METF4RIlPU+XdzMkVufy34qIS2ss/xrVKo8u9CVn1+VXR6D66LJW2+XmPzDV
         1hbIJp7DkSd1BFOYNgAaOPIzedEcShHrk9iB2EhOm3YOR++hRCnJem2zcE2rSTnESEKf
         h/prQJnzOrvoCX3j96Trut9hAxLbdBNYRCJ3IG/0uYF0ldh7DDO84CpP/20MZ8dSW6dX
         4ueQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3XLDQWCAumDvTjGVdOqMzwZNpp4yQ1DPAYta7jMiJUMZXwugYgnlVLpGXQdz8nqCJ0izcmY4D@vger.kernel.org, AJvYcCXLMMcfJLxJAQgd0lljpWC8wGJpfggfmBWmFRdvaunO39ZUo98OudREqxNvhcFzlUOE64JWyY3wUrI1sC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayNF6pH/kMnnoRLuL9kYJgId6lzhdABZCCyoL7M5hhOJLnWlP
	o1Pq4Exd5fnLx4ZjpAGHZp1Rzlw7XXOI2LB+kDH0XB4Rqv9RWM6GQb4A
X-Gm-Gg: ASbGncvr5SRdZTQ1umcpKgmyyXY6gBYeOd26Rm2gfXFtXQdAfpS9/rhgmCDl+EB5nfZ
	B6OUVa5K8JbnQppZPuZM6R5i9pvPiCIwdJlOt8eGefnKJDwIRB7byQ0n1Ge5V6iJLGOekScY1tF
	KPHvhTcgrQcuXOqq/FMGJyeSsGArzvqg5tGMCgA2LsRhBJkXaLyCBKB0a2zW1tamo7elvSOW7Ka
	BO4hIpjcVDd6D52Xxbgb9T/kwJ+VPZT35c0Qj33+RQRi3VdagKoXqPSygsJXt4C8fQfFJkG0VcS
	oXdUWFndBXRH8v9ARnW7fxrRDNYuwtvijMUkIadZ6XCu92zsfwoEGCJSDGbfLi7CJfsQxt9aCZ/
	XqIAQ+994JQw+u5Z/RfFSpTJ3n0nbfZ6YspPSI52DyZNI
X-Google-Smtp-Source: AGHT+IGR8ny0IPp42f3jE50MGwGkyEI6LYFeLbcDfeA5cPuxu0SLfdY4qVa4wH4utZ38yPEyQhDFlw==
X-Received: by 2002:a05:6000:2305:b0:3b7:7936:e7fb with SMTP id ffacd0b85a97d-3b8f49162f6mr915780f8f.30.1754465099959;
        Wed, 06 Aug 2025 00:24:59 -0700 (PDT)
Received: from [10.148.80.226] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9160sm21998702f8f.21.2025.08.06.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:24:58 -0700 (PDT)
Message-ID: <2fb8917d59b22dd78fe1ff216157eea7128e5990.camel@fejes.dev>
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
From: Ferenc Fejes <ferenc@fejes.dev>
To: Xin Zhao <jackzxcui1989@163.com>, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 09:24:57 +0200
In-Reply-To: <20250806055210.1530081-1-jackzxcui1989@163.com>
References: <20250806055210.1530081-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 13:52 +0800, Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Add hrtimer mode to help
> compensate for the shortcomings in real-time performance.

Do you have performance numbers? It would be nice to see the test environme=
nt,
measurements carried out and some latency/jitter numbers.

Thanks,
Ferenc

