Return-Path: <netdev+bounces-115695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AAB94792B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193FAB2150D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F815444E;
	Mon,  5 Aug 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HZrBhC2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFC481C0
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852874; cv=none; b=YtsWiyoibBvbxv0Sl28IVelyeJ2sv2BbLYA5ytWGkVAkcbpOc62Ifohq6zg+QQRIu2IDO9v+uliGAMls1V0KYUc42EbUEKAlNpf9/oyrYULLddG24+Llx0C3KpwbiGheJuopxpU5CHvtH2DdxM7bICOTrxnwES3UJ2PMad9v1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852874; c=relaxed/simple;
	bh=KUTXv/4BMVQwGdjDsbktTy1NxZw7vMmfKE8tNFfq/Qo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8Fz4SPduh1Q7Fw5WF4som+6J+y1CFVkhTkiv9N9hM2sG/pG3b/9x/CkUYDb2XFIZVA0Xq6kMIQMmqmVrii+MehjMrSAdN6FbScrLH8rMOGnqk8AEM6S24phtwdB6W2WEdLwy7Ii/5KIMMcv7tK/sfD2xuCTmcdvsHTj5XFGV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HZrBhC2J; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso117214571fa.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722852871; x=1723457671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUTXv/4BMVQwGdjDsbktTy1NxZw7vMmfKE8tNFfq/Qo=;
        b=HZrBhC2J72GmBS5YErUjtE3F4mtbcGUtn0vPnMepRI256xkkAtAwesXGjGOIz8izsa
         aHOTAqkXd8VtTiwn04WqhtY8Kgxuk+6g4kioFlu812bFwXnDMD/3pI1ANIbzhdxJUPwj
         CvJQVAOGYF3j9Ycd2IZYdsTelbTB4vT/zlLSL7Dd4VGjYgfp6sZ4HXB2KBvNZWk3p7nx
         QhAHj9pz8WQYkS3kPDUy8h6vwF1R+4IuhibO2QFpl+I87ED3g8clX2mSgM7D09F2RW+N
         GROMcyOHSsGdweRGX2NKYv6e076pcaM1bsDZBzXV4DEdS/nqJxn1b0w2/VEaKkjhTmop
         Ou2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852871; x=1723457671;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUTXv/4BMVQwGdjDsbktTy1NxZw7vMmfKE8tNFfq/Qo=;
        b=sQak80IHEa4VvszoJ0tgz8ZDZNFYKY11S6Q5R+Oyn5r9qB2b5RnyxL59aUh+ZP4UHn
         aQgNpMMavbN3KTnSBUViBaFpxPXaBee3/TFLb3ggP6XNGGUZVuuVfc7ga8aSarxvjIa3
         C/zgq///TWU4EgBa6txB9SnX7UNVE+TUW0xTtByvOw9xvOcP5ifkjGbWeEtv5a7OyzWe
         NDhjwyKa96h9Jrucx17VrcF+ZCECGjOdTeoPOp9XGhVp3Iox5F1hy3jst61kmmqosqg+
         o+HuJetzFmvsYPgXPeAv6eYpIFDTISZXiS0Fm6tFbzlbGQA6i8i7URgFW/bAFOzOLIAN
         J34A==
X-Forwarded-Encrypted: i=1; AJvYcCWw/SnlVgjDLz3yBUZ19m1KHWF2x1SdDyCJ66fLhTQv90dRqP/suxqgshD6EfGmsgukSuCEAMq4AqOVI3ElV6Wa1oFFRf+r
X-Gm-Message-State: AOJu0YxWqPoVdGmluVeHxV0DnRr6GLXFIsqGb2bw716s4A1tax95mRvF
	UXNmhKRGVyq0q2vYWCjQEXURbOQ+g5W9BjyPcAyAzEnAEcQmhWNkrjPRcTiui+hjztfCoEPrRCO
	vxLsE4vt6CSN1I6j+9FQOxPXY/2Xjnk+sep5vEA==
X-Google-Smtp-Source: AGHT+IFsaV3LKwGCMOQn0O4QgIlm4dsCb2VYE13IUfFYBk5I+7bdruiCzlImY6gmpq5Iem9oqay4dFWaow8fEqE5Kl0=
X-Received: by 2002:a05:6512:3ba9:b0:52e:6d71:e8f1 with SMTP id
 2adb3069b0e04-530bb3b434bmr7719818e87.53.1722852871307; Mon, 05 Aug 2024
 03:14:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Aug 2024 03:14:30 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
Date: Mon, 5 Aug 2024 03:14:30 -0700
Message-ID: <CAMRc=Mc7tnjWnWDUjeSfva-XuHp_J25sGXjsa78UjsGG69hwag@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/14] net: stmmac: convert stmmac "pcs" to phylink
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 12:45:21 +0200, "Russell King (Oracle)"
<linux@armlinux.org.uk> said:
> Hi,
>
> This is version 3 of the series switching stmmac to use phylink PCS
> isntead of going behind phylink's back.
>

Sorry for the noise but I had the line wrapping on. Here's the tag once again:

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> #
sa8775p-ride-r3

(The board is a more recent revision of the one Andrew tested this series on)

