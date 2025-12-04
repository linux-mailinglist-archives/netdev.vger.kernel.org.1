Return-Path: <netdev+bounces-243526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDBCA31DE
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 10:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09543022B75
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 09:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B830C61F;
	Thu,  4 Dec 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zeh85N6r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ7mYwX7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F03090EA
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842327; cv=none; b=X5kJecviFfsYA83Mk8xtCRUcguwusKFLZxJpLcSIrE4gF+V3YJYVX0ihVIA/UjJZleMEybgFMiktFC1cZNqhLpD2GVG6gdk6LX0Nougk1c4pZYBh4dKUX+WfmnZ3UTs2PbFFFLm1zYitpG/deej/KOPUiXx93VyMSx4e+4Qtt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842327; c=relaxed/simple;
	bh=csnYn/zWPBymTxhjOh1IgCfrqGDsenqQm++WZNaPndg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP46x9CI72cFqBMIQjb+BXQvJeNYh+1FT7P8E6hLaFOrojkDIzcTyrIBfbzOIgsWXKoIX+OkJOzkGoE1Fk6GzJVis+1do/D0lSh4UNXDfQJWLmF/BYXsJjJ1vofxPs+2R66NE2ZTEzho3vgOgQbMeH5E+E28JJ7nfJknyVxANPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zeh85N6r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQ7mYwX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764842325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGMYk1sfGljMrx70XS76pz0+JZldIxvVU7ZbZaIA+pI=;
	b=Zeh85N6riuMWszORPbar8CgZ3IZVUbwtfGxM96vWGfrbVdeEijs/rcb3zMm9haHO9gdveQ
	rNXrGvf2mHfYhpcjCMCoP0508fmPPiwWYupXtPyYOQOy5IOP7NCNmQcP7nilBkS7XVzS6o
	1Spl4+prTInQgOxT4rZzXNdu+y6HVpE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-RDPsYYLmPPmyEBOYqpNDGA-1; Thu, 04 Dec 2025 04:58:43 -0500
X-MC-Unique: RDPsYYLmPPmyEBOYqpNDGA-1
X-Mimecast-MFC-AGG-ID: RDPsYYLmPPmyEBOYqpNDGA_1764842323
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e2d02b528so468882f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 01:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764842323; x=1765447123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGMYk1sfGljMrx70XS76pz0+JZldIxvVU7ZbZaIA+pI=;
        b=FQ7mYwX7i15hrAf9WKoQ+EaEvQQ2K39f4HgzopA3IOFyYGGmDsw5agiGp0T2ypYsgY
         ktktdlZlgU4Z59KaWXOs0cskU3DU3SCqEvKC/WRz9wDuuST/zvcFFhGAaYihRaHYz21C
         zqlsL4zspmJ0T7sv0WjGElqjJFBgDudMSMXc20Vfw5ozd4JreR9A4rL9sLFZRm48BITe
         6SogzoJxd8KYO0Em28IvL425IkZdCa60am0x/m7WrwmU4ADz9dxBs8g35YMSi3BMb9fo
         KGuD2WrJI+8QWAI+5S/fu5x6ZidqnlD9c0mRsXa4irs6PiCaWBQHPtwb5QV2bWAjeeXk
         ryvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842323; x=1765447123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGMYk1sfGljMrx70XS76pz0+JZldIxvVU7ZbZaIA+pI=;
        b=O//0Qe/nc/Vravf1R90ibk1qQ94I9gwWc2ulmuj/S3GkJ6jdx0zlg7zaPWBidi4ejI
         TgA/dHoWnV9g4LoLYJdeyD+OQ3aDeN9coAzRqyaeiaOOjFZgzhmdElqmIQKQ4JTc9DKq
         yfcfsklNwlBDpT9oqCkEtui3I2h+INa0rA1VyrG3++Ox18htN0Eo6RtOvemucw1RSPcB
         SK4THPUI6C24+PJaG/3PH88D628Xe5eiYp9I+VQDeL5egFKqHGJIY1DWqOgB8ZWsEgJX
         KSKpmhmDyFoQpAmu2Do3kHhXkYkAYJjfHacF1uMj2yn4va3ZnNMpNxH1yDI5qjnSyz9t
         KeEg==
X-Gm-Message-State: AOJu0YxMXdhsIxHNpEd6q5BOfQrgIZ8/NHHvx2pLT9RFezKFQ+Gh2ixf
	G7ODp7vSzTJ5l4tUlJtU54HR5P58x36bNv8MW0kQP4X9gHhJLMAQjs654H/A9V9UcCrjPNs70fF
	//UTqBFseu+u/GfMl1IjDqKpZCyAjOhKwuJ6cTQMIn0KiWqW/kTETTfBpJQ==
X-Gm-Gg: ASbGncsin27d0TFdZeuwmB6Bl3KAFE9sGh/WjhLWSR+9vYl/abrDZEU8yxfKsNFbMau
	v5anPW969RMqkGcrc1ZttLz1yuzS6Qnt81Lw5CpJ7OQoSoq/60AAdZY1FNuR0A8mHyp59qVoXIP
	30fKpa3eL32PCv0Yrc9WHK2tkokX2nrQgtS94qfJpNMD0oZ3mKGGEqM+stV2J1V3IuliRs9gZNy
	mxBP+iuzAR95IEkwO7ohI6E7cLBK5eNMr/hKenw0fpMXRsdKvhA5GfP5XIYepwsfBVtnAIUGAOq
	7xzYgG63vNG793L5soVo5veBSwSiluqNIYZwvCk1KOo8xmJdjTj4DfCEJetihtKlV4jhGCJFGl/
	8MoMOMjU4PrNi
X-Received: by 2002:a05:6000:2410:b0:42b:3a84:1ee1 with SMTP id ffacd0b85a97d-42f7317dbc9mr5978661f8f.18.1764842322739;
        Thu, 04 Dec 2025 01:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER0C5ptlDk7jPg7WID0quVbFz2V15FUInT+2qvmmyu5lX8HX6WC9NCtkC3D/YD1+okBxxd+w==
X-Received: by 2002:a05:6000:2410:b0:42b:3a84:1ee1 with SMTP id ffacd0b85a97d-42f7317dbc9mr5978625f8f.18.1764842322345;
        Thu, 04 Dec 2025 01:58:42 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f8bsm2297919f8f.43.2025.12.04.01.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 01:58:41 -0800 (PST)
Message-ID: <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
Date: Thu, 4 Dec 2025 10:58:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
To: Rohan G Thomas <rohan.g.thomas@altera.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Fugang Duan <fugang.duan@nxp.com>,
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 4:07 AM, Rohan G Thomas wrote:
> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> messages show up for dwmac v3.70+ and dwxgmac IPs.
> 
> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> Agilex5 (dwxgmac). According to the databook, to enable timestamping
> for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
> register must be set to 2'b01, and the TSEVNTENA bit must be cleared
> to 0'b0.
> 
> Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
> addresses this problem for all dwmacs above version v4.10. However,
> same holds true for v3.70 and above, as well as for dwxgmac. Updates
> the check accordingly.
> 
> Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
> Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
> Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> ---
> v1 -> v2:
>    - Rebased patch to net tree
>    - Replace core_type with has_xgmac
>    - Nit changes in the commit message
>    - Link: https://lore.kernel.org/all/20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com/

Given there is some uncertain WRT the exact oldest version to be used,
it would be great to have some 3rd party testing/feedback on this. Let's
wait a little more.

Thanks,

Paolo


