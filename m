Return-Path: <netdev+bounces-251169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03062D3AF49
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 652FC30010CD
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E05389DE0;
	Mon, 19 Jan 2026 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzq35x+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CDA1A285
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837137; cv=none; b=Azb5Q4DG1UScdOc0d+QfR+Vats+fUR+SSCNBxQS7uSEppsAiPT977YAWaqyoPqA6MQTks3XWR44XAAdUTAr9r/TL2DyZgDxRamh/2EeQvKs4J6FgNJny/zubPxJeUZdy3pR0VTSWSq60aoRkkA+YkoAxOV0u6mVzQIWuSzveLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837137; c=relaxed/simple;
	bh=jXHKJrXJSnEOQxUgddZjiad7A9U2BlElWaNWeUFGA/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBZ0Nly2DUAW4Edjv3zCUAhDCPOtiTKu6V416SMldfnNuRHXUaPYu3N1bCmlKuWwNO2auDaPYgzkaF8KQA1REoUWHWyvATm8yG9yEZLlcSoa8aIdXVkQu1Q+5bNCxnO0rnMTyOIxXbljbzYCY5lRhx6vcA+e/QIRXTDVjVo/TlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzq35x+y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee57c478eso1998265e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768837134; x=1769441934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OlaBMXpZRh2mRF/zIL7zkkXWi1bK1vG4lbJ+gzlq2A=;
        b=hzq35x+y6xN6+XOjL8lbFswuatU11hID7TGbtmZDyfiaAitDg+oiR0KUXflQX7zmOP
         JyojV75nzeaoG+U9crQzppNlhsdwFq/vfkp8FWiefbxipwP+JLsUusTvS+ri/vGL1xix
         SC913n4bDNST7YBrqRoM3L9YcUBK7Pe667uGY1Ds5VE/h+x2/aLteHENHylTZ/OS/yPE
         6bAEAdeBZ53BvOzsl45sO0CyQZa1gItFT4aBm3EZSpGiMchNQ6Ia0ckdS1980SPcSCBc
         Ev5l6W0NYZyKzD2Zd6wuUiRwpA0Xb3CEWx8jt9eIO/AQP594kkzoKIRpctAEf71+J51z
         tbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768837134; x=1769441934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OlaBMXpZRh2mRF/zIL7zkkXWi1bK1vG4lbJ+gzlq2A=;
        b=xFM/I8407f+1WaE2uqP25QemOxd3RafDoJkdVWcdhmLH8cAB0tOMwiqMnzNfDRIoR9
         iaKInfhcOPp/UhyoxzHXNzhYBWetMtPE3XW4w6tJb2W0DuihAFav09HoqaOmvA1eBn8f
         oO87imamtF6rAHLuonYxSyuoDKOckOJt+b2KSZiCBdIByPEXzlL5nwM/yD3TUqzrlNJy
         SICkBX1kIcwjPn9T0+GrMdxjcuuo4yDgcYSjPUTbLn4EJyIFVLqeS+gd8qHqKNEeEK05
         oy7tAHqHCNIRUtiZw+8vWwH8xiyQCSM25cytunvqGt5ecnO65B2IHgYl1vz+W5pPLQ8n
         DH7w==
X-Forwarded-Encrypted: i=1; AJvYcCXSBgioabq7AOuQ7UmpFJ9uZ4MRjmzDi3fGjQUV2n4SzZZru4vPd3JuZjc7PQqZgz4Vznl0bsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EQSbObCt4FGjF13r+hei5OsSS4NyznBg2VxhcAOS0E7fi69G
	ahzjoaD7SxVnlXkZaag8yaMRyOKRUodmWxlCBo6uYyX9etU8VfXWztlc
X-Gm-Gg: AY/fxX7PVEwlMBjV67Q//C9PTYKsPLTI8KWS9PJeLMMVaB4/DZrK9vlhUlXmLY+e/AG
	p4tW8OA12tdx60XyJ59IJMQDa1fd46YSAG/KEsoreDYn09GzChWiJNOwsnxdbVIMgV28EI+SL8J
	L6c4FmEIzxRwfNsivvNCOzjOIPiiqBhWw+tygSPUZKS/hJUOVUJa7dsZaarH9ICSBzrTv0inMEU
	B3mQ4IIog4BUC33B6ntz1XhoLe6faEowuSq0x3O+Cx07RdntHQG0QxRpKsycBSBGjQwPGIwk70M
	t5QfgyvO41IeDHIPHJz2aDE/ld3qzpBQLxHJk81Vq2HGWyq4GK6fvKLel44VuyFtRBEpmbPbJZI
	O/XmugHte/xIdUZaEU51vihAE3PyOA58GeoitmUMjuof5WH0/fBV+TfEfHQsufUoFquWWI1BjOr
	fryFHYi4O3kSI5yA==
X-Received: by 2002:a05:600c:3594:b0:47e:e20e:bbbc with SMTP id 5b1f17b1804b1-4801e2f2845mr105772655e9.1.1768837133999;
        Mon, 19 Jan 2026 07:38:53 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:619a:24df:1726:f869])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cefdsm23190982f8f.24.2026.01.19.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:38:53 -0800 (PST)
Date: Mon, 19 Jan 2026 17:38:50 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: dsa: ks8995: Add shutdown callback
Message-ID: <20260119153850.r7m7qf7wsb6lvwwe@skbuf>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-1-98bd034a0d12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-ks8995-fixups-v2-1-98bd034a0d12@kernel.org>

On Mon, Jan 19, 2026 at 03:30:05PM +0100, Linus Walleij wrote:
> The DSA framework requires that dsa_switch_shutdown() be
> called when the driver is shut down.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")

$ git tag --contains a7fe8b266f65
v6.18

We are in the RC stage for v6.19, so this is 'net' material, not
'net-next', the patch has already made it into a released kernel.

