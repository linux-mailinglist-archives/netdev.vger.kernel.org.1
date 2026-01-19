Return-Path: <netdev+bounces-251185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9AED3B287
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E97313C02E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D4C330305;
	Mon, 19 Jan 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWMViCUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFC32FA20
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840808; cv=none; b=LnSpFUVr8djZIbO4k7EQWYnHbxTRzeUMQgnDnH48glj30N8i+TEgBpYAiHVnquETE6PUStPWn8/BHL8qsG6+c2NMRShKwPjvShRS0IJNLtoYqkcBE1fVD7noJ0sRuhLRdhl6IMHWn5sL/Rc3B8Xv+1lK5ezOvON0hS6lNI0Iuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840808; c=relaxed/simple;
	bh=1+Iy1o5F36ViLRu5I85oZkieSfpCy+H8ACvtKM4qNHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDs4yGeufsu7GKxkrs4TJZhaHpT5zAChkqMD4ieMSW0HkL/X06lUmCq+iedMzCVXu6OdkTwkrvJ59xw/NYnTE3DVSJ+FhYptIaGF2UsyQ8u7WI4xcYB3XhjygIUakSiX6TBLRaPq8We/He9RcrU8VOk2KzFcCUYAA4/NP/CYx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWMViCUy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee26a760eso1757915e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840806; x=1769445606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2jNAdYmt/Vut8OKA3dCVLNXldFS3y4ks0/GOYBiREU=;
        b=nWMViCUyRmQkFs4H26gvGFgo3/Wn3qvPgrzAWefpkDwmPBTKSjAK3SDbE6OrdY7Ixq
         nsoNPVREfX0hirdgz/65taa3o3ipnvTe7x2TlInEOXlz/scCzuX50JNGaVuJ33OJ993Z
         bFO4y6yo9uRtD9rnmph3m8wEwmDbouCwXmRAtvVd84NpIrwkjh3edJ8ULcdZ8P34WhKy
         mxnSdMFb+oyDSyI7DrOEJLaD2JpcvKQPrpTV2pslFgIQWAwHUqSCMtaCNiESloavZskh
         pAu2gT0CX8uRKvCPUo3XMNr+pofvWKzgGFGAFXvVuEdgPilTDDULnBPRKOP0icMRdeXp
         bSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840806; x=1769445606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2jNAdYmt/Vut8OKA3dCVLNXldFS3y4ks0/GOYBiREU=;
        b=TWQZIaQywiTexChtLcTSWCiUORAcLAInxD128G8+70vxenQIdCUxDEQ11/cYFblBTS
         o4ZBe32HW35TeU8WyFY6ZY632aPQMuLD/77188cuvgTAKzhku6P3RT/8ZsfiFp0MHy0i
         i+muXlZIMxPgcjmB1JuyhVSWV2zg8+//zXSO8708ho0bR9M9m4IDsedWvJqNmblWVGFL
         buwxYxrMs+BPfI76to5i1cqW994BI7m/gBzbF5/3eTsvuWd6xPpxPuh7WNHbGmBlzSVW
         tZoDKNNHF/4OyooDWEMouPiwmZjvN4M4cYsrE/EWxvJt10H+gn2/nrNG0115kPX1O7kZ
         l/NA==
X-Forwarded-Encrypted: i=1; AJvYcCVSpId/tILEEv1Dw23F3bVsPnzuorD5QWeHNHMs08EywOwbBMXR7IwCaQZ/l2qaZ62A7dnX1sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErfCLv14hpa30JR4btp20ZOmOrM+Ru5aQHpxjdz5B52OroZ8S
	JhPQnGjlfsITQsGFq5cGw5fYSu+K3MsJ2dOMf2DvUcWyZXf7pfQdboPH
X-Gm-Gg: AY/fxX4G9LjKRNoN8KSI+kZOXdLLiy+MzJxuy2YEGQ+Z1yVBvzpwBW01Dw1yxG2n8ou
	3AIbEHzUgRfghER3e6es2V4X3nctZrdVzbHfqumCgc3JWBYVITg+ds4MUfTP9FvENjY6FI+nmVE
	e7QsEkdGiIVcZyuyll+CA8sQsS9ja9qm96pkYwoia48xxZ1E/+2alb2bp4nr7K5g6TnrP0bxOf0
	mu+5ptHL9oIbwYRZXob8osnYc2A2nm+XiDzPxXjR/JD4HPqiP2taRQIkkt/VcMLoy4smJlJbl5o
	y+Wq+ER9+3Da4Z7qvE1w0yrVux8H6YpeT54bFQmSjPSenqsTnCS2iEM82IB/xYcnPzz4YTczefd
	z/VPrm/Y9toGc/sspF5iQLYBH2fts5bW5Q3MqbzYlOMREDyOPlIhJEhQoMD/bORVT2PARJg4iGH
	RrDaw=
X-Received: by 2002:a05:600c:444b:b0:480:1f6b:d4a2 with SMTP id 5b1f17b1804b1-480214e6bb8mr82016735e9.7.1768840805547;
        Mon, 19 Jan 2026 08:40:05 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:619a:24df:1726:f869])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm321727125e9.15.2026.01.19.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:40:04 -0800 (PST)
Date: Mon, 19 Jan 2026 18:40:02 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: dsa: ks8995: Add shutdown callback
Message-ID: <20260119164002.uzzlmchebn7ye2l5@skbuf>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-1-98bd034a0d12@kernel.org>
 <20260119153850.r7m7qf7wsb6lvwwe@skbuf>
 <20260119083341.148109c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119083341.148109c2@kernel.org>

On Mon, Jan 19, 2026 at 08:33:41AM -0800, Jakub Kicinski wrote:
> On Mon, 19 Jan 2026 17:38:50 +0200 Vladimir Oltean wrote:
> > On Mon, Jan 19, 2026 at 03:30:05PM +0100, Linus Walleij wrote:
> > > The DSA framework requires that dsa_switch_shutdown() be
> > > called when the driver is shut down.
> > > 
> > > Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")  
> > 
> > $ git tag --contains a7fe8b266f65
> > v6.18
> > 
> > We are in the RC stage for v6.19, so this is 'net' material, not
> > 'net-next', the patch has already made it into a released kernel.
> 
> The AI code review points out that the DSA docs/you suggest mutual
> exclusion with .remove. Do we also want this to be addressed?

Oh, yes, I didn't get that far into actual code review.

