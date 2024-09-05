Return-Path: <netdev+bounces-125703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A596E4DC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090E21C21669
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3511A76DE;
	Thu,  5 Sep 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJNfY7lo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9B181CE1
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571001; cv=none; b=qK3ALJ4cAgb/HgRc5kK8jnbfGoM8yIv6zmRHklHnBivmDN0VuzitG7moBCenOG6MnLljVoXHXznIZljDkqYqxWaDo2vDTNCf48ETZArBwNXhWe0ckp1Ob5q5U3HfIUujMRWgql7OGip/JdckobN6u9nFKNfmhzy83WXE7dOuVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571001; c=relaxed/simple;
	bh=/U56oYodVHS7dpWVocXrXDbGpMjUt9U+S2ou0QXjyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/8KKFxieEjJ1hiYB3jxgNNdziQxaqqnrTY23v9pHQ0Qo6Z2/qez2gnyQKDvVJZmR7b1CJOpBD3SD0Gty+pY06Quo9VOFKbSF/iJLWBGCrIpuilb0jB45+huMSulwGiYKb9IbBTfI5AM1lKEG6utpI0ojkiMeRjpFzNB/lAtFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJNfY7lo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725570998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCS9FGPb22Zp8YOFZ9hjWeIZgSN7BXU4B9ST/Ivvoxw=;
	b=gJNfY7loo+6uckt5qLJS3t/wG9zrU7YN3odJ4he37lo4dTkYCZMxtF17gJXvwSkG4MBMWk
	8DfMd3UzdB0fOgI+FzmOEhtQ4N8C/Mlpkvcf+7x0vOijvc6+8WSBN2pp6qYrMde/4NHC2X
	O5eJcFaJmObx5gIx82nd6rMXJXB4Gy8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-xgL5gxzSM1Kv975eLxhboA-1; Thu, 05 Sep 2024 17:16:37 -0400
X-MC-Unique: xgL5gxzSM1Kv975eLxhboA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5dfbd897bd7so1220252eaf.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 14:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725570997; x=1726175797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCS9FGPb22Zp8YOFZ9hjWeIZgSN7BXU4B9ST/Ivvoxw=;
        b=nvpcvHZoiliv8egk746EC9vYAU1AviQmF7HQ+TRbmdzL/44CGgcgELf6Tu7GWnFx66
         fUciV6onOoZd586q4vgbyPKeKe5yVrDL7Tta+7rPmYX8arry0NYz8E/6h1Mr5UY61Jot
         zHkEVrtio2BQX+ddBvQr09PKNzPeAGSh6jRTA8o6bG3yFVa/0Xq9Lm97EE3ZnN4kdY0W
         8fnKTJADsvIJhxEzBwRa250lFmmmzvknLjXhWV3dV/cU5NlbeLa3t6WX6a2vLsqk9r3x
         1SSkfR6Cbe+g3p2ezG2uumjuHeNr/XMcLFo9GgTJi+vhRPwnP/vQIY5fhRiHRvUbh7tI
         +TuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv+ohspp/QgEet92qGoihvKmdntXChotOXRssZc9Gpuc4GJaknZ239eWXw40YoXeyRxKgUwBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4IBcZ6JjCTWgVQOEh3QLOXHEnHZ2XJZVvaX6T76oIBwZSR2+
	Wxz97eDh7QBlQTLZVolF1GazLMFbkizzp7FpvHRwAm9BSkaSQrXr6oexE5DeOWCKjB+ccAoMfrO
	cEzEXotMkasGQKlUNSEk+6rcF4aeR6G0KfnRhM61JTbUY/kTux4UdHA==
X-Received: by 2002:a05:6820:220f:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5e1a9d3deaemr460138eaf.7.1725570997214;
        Thu, 05 Sep 2024 14:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcn3lC302r4cvOynTV/pTYo7UP0omv7LrahF3fXXR7CTInjmYCD99NLWRLjJz2kCarVDyMyA==
X-Received: by 2002:a05:6820:220f:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5e1a9d3deaemr460105eaf.7.1725570996900;
        Thu, 05 Sep 2024 14:16:36 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e46a4sm11023736d6.53.2024.09.05.14.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:16:36 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:16:34 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Sneh Shah <quic_snehshah@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v4 00/14] net: stmmac: convert stmmac "pcs"
 to phylink
Message-ID: <6ktdiyivdf6pz64mck4hbxxxvvrqmyf5vabuh7zfzfpcm4cu6z@oh43gmbrs2tj>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
 <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
 <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>
 <d3yg5ammwevvcgs3zsy2fdvc45pce5ma2yujz7z2wp3vvpaim6@wgh6bb27c5tb>
 <ce42fknbcp2jxzzcx2fdjs72d3kgw2psbbasgz5zvwcvu26usi@4m4wpvo5sa77>
 <74f3f505-3781-4180-a0f3-f7beb4925b75@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f3f505-3781-4180-a0f3-f7beb4925b75@lunn.ch>

On Thu, Sep 05, 2024 at 11:00:31PM GMT, Andrew Lunn wrote:
> > Hmmm, I'll poke the bears :)
> 
> Russell is away on 'medical leave', cataract surgery. It probably
> makes sense to wait until he is back.
> 

Ahh yes, I forgot about that! Thanks for the reminder. I'll be patient
then and hope is surgery and recovery is smooth :)

Thanks,
Andrew


