Return-Path: <netdev+bounces-131712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3898F509
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2225C1C203B1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A51A76BB;
	Thu,  3 Oct 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw+y2+Lk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9181A7065
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976362; cv=none; b=G9WZl+SOUT7rZsJCqa1QZuuGdp2VP/j8tR/bR0nXGdMqrUCBys+JCW3iPm2O0KjNOAYRQmN52eETeYpxyb1u5OuF4nbKszqfJF/OlTKAg5G+f0PSeWlY7d9cy1v2HctWZJk4J1UNqRxdFAkDcGBDMa4ikgeMwBPobYLrOvVbODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976362; c=relaxed/simple;
	bh=uSw/pbVKyLVapDLuIIT8QZzOuUcD9GN93NjnaNgR4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/g+R6ME25Hko4y4x7WwXrCW/qZV0ejNMue4dtZnfgGYZ4tpKC6DVxhmZEc3mqQiuFXOrcCcC7/+PeK+nk5S30ALGia07lJU0LWE58RHHWKAJUA7eDLK1ka52mASELPBrd0TjxdZJz6NWGTfBTC8mPnyMYPmBkE93mhcIFJJZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw+y2+Lk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db54269325so882925a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976360; x=1728581160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aa/k9vHPGBstB0qIh/qabfo/AZ3Fcww0DfvteXDnfgs=;
        b=Zw+y2+LkhjxWdWmZVc8cGSlL7upkcRIk+bmbUIHajC9/MDTzyKEhElbzWixNCfglsN
         1ZVuewFJqcgC2UgkHtq7qcjwownbonf91aTlYj6BH7wiU2yFMcaCFyNTX/nl1jyg23lr
         8mkjUhamnALntMSFbSAuDbERYqygSPoK6PnnoC3Wud8OHYD3xDw3a4/T1qhoiGFfB3kz
         m3LgKdaFcy9OhuAv7mtbDKGjw5d7hfAQYFfNrvR4o8dPvb4IohrLkp7oeTbmV6C0u0Z7
         YIz3ntoE8hrz8cyUuYkLmVOwVy1BW1tU0VQ1BHmVj5+SjuH5XG7NgGXbGZ9TD5HrLNMQ
         y63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976360; x=1728581160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa/k9vHPGBstB0qIh/qabfo/AZ3Fcww0DfvteXDnfgs=;
        b=hTviiWQOc1vxvkniXLrWxEYEPsp5LoZDrXpXjq7YMlOI1nOZM4cKWQN9ognR1SUpRs
         yjvdXc0V64yjdFaDOHjrFE3TCDCHWCvhTd/cncbfYA1CqR2P44f0IL21+dartORoGLUa
         VwyNjZ6fqIqVVhLMYAyazKmZzYKSzFrh3H2B7ALB4D7IDkiDU5LpK2hUvkzhsr5+kKBP
         jd2Ds2Y5oWrum2+ROY+NejpyM3IfWRJ8WD/PD4uyDK2UwgANu7+lGb92IhiCIXxbZtEi
         DDP6D3ySEobRvAVaZ91h8Gy+x4Dqokgna8DB3+i02IQN1Ik/2R820AN0OInAjIQzrjUy
         tf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTCiGyFSK99bGuB9UBnxkr8jTHnGRDBYdPx3DMQt5iWOk1Bm3a/SvLNz6hp3ZxpwEf38K8AU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXolt+srseR0LCeT9WgamHGef3Rh9GpNCy3q3QJEYZ5BFH7XT
	Yhwmn8c6k01VdsMqxJXPrU8Fa80cUWHrabjzOFZCZGCccpZ1cKY=
X-Google-Smtp-Source: AGHT+IHakx/pEpyydvjnTHV5eAg3cRg3sVolQs/iDPbkNaT9efNXQ7Cq+BTX1KxyC4c9BZrhQN56qg==
X-Received: by 2002:a05:6a21:9187:b0:1d3:eb6:c79b with SMTP id adf61e73a8af0-1d6dfa231cfmr127451637.9.1727976360242;
        Thu, 03 Oct 2024 10:26:00 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb4d31bsm975294a12.57.2024.10.03.10.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:25:59 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:25:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 11/12] selftests: ncdevmem: Move ncdevmem
 under drivers/net/hw
Message-ID: <Zv7TpwAgpVs2SjyH@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-12-sdf@fomichev.me>
 <CAHS8izN6ePwKyRLtn2pdZjZwCQd6gyE_3OU2QvGRg0r9=2z3rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izN6ePwKyRLtn2pdZjZwCQd6gyE_3OU2QvGRg0r9=2z3rw@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > This is where all the tests that depend on the HW functionality live in
> > and this is where the automated test is gonna be added in the next
> > patch.
> >
> 
> Tbh I don't like this very much. I wanted to take ncdevmem in the
> opposite direction: to make at least the control path tests runnable
> on netdevsim or something like that and have it not require any HW
> support at all.
> 
> But I see in the cover letter that Jakub himself asked for the move,
> so if there is some strong reason to make this in hw, sure.
> 
> Does it being under HW preclude future improvements to making it a
> non-HW dependent test?

I'm moving it under drivers/net/hw only because I want ncdevmem to end
up as a TEST_GEN_FILES dependency (drivers/net/hw is the directory
that the vendors will eventually run against their HW so this is
where the HW-dependent tests are gonna stay for now). And I'm not sure I
can do a cross directory dependency in TEST_GEN_FILES. But maybe I
haven't looked hard enough?

Let's not marry too much to the location? When you get ncdevmem
working with netdevsim, we can move the file to a different location.

