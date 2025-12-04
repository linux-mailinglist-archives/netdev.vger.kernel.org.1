Return-Path: <netdev+bounces-243624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEF4CA488E
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CD77303DDE7
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E42FB99E;
	Thu,  4 Dec 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuIE+vK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EA2F25E7
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866002; cv=none; b=CYkF17O/IMG4q5fya2EvDil/sQF0/pU4bNQJzoHvoFcbrXwFfmPobrIxP1cUqtRE8voEMZ1ThR0yN+FDXMYRFCYW80C1imRrvBQJPF0lvUkAYOIeiiUmRiZjLcRcUEW1alIDQfAlqTDVh8/U2FpROa9b7u8oG5shfmI+WU8Eezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866002; c=relaxed/simple;
	bh=433bFX8MqY9t6n/CFagV1V/BOZrKGc8FwpcUZYIGcZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfsucaL1KCDyzxrsQZCvz051gv4qhN8zn7ojajSr2St/QxBHiBnnJ48Wqh72ANNycqPjWvigFzrKorhmBwCPTL13Mm5QJJM4kzWx/CVmsnRj2llvcwXTFXZqn/mjYp7Y46TQSgaCT0KSu3g9YI6+yo+aZ1k8o+zt/UdEmdcBFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuIE+vK3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b2de74838so68832f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865999; x=1765470799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1NBivu5UEBkQBIeFnHZjPjnHfogcWbiZIn2200JwTs=;
        b=kuIE+vK3zIplkblEhEj1Ki3wQez7c3GN6z/9H0Qqy77+4uqjyu33SIgfLMy4tzGM1z
         lMxkYNXAt+4Rk6h3PC4GviDrvz2+691ai8ECyKfnDYb42YBZ5mBBx31RcW7S5D4J76yP
         1/mcbktCrSmA+B9xTHLiDC9IomLOD8TkOSuShdzMvfBS5C8N3fGekVjKKyo05eRtUJJW
         myk78GIUffatTDmWk1tKcwR/SdsPs5JFmke97hHTeGaXsXswuRhpwtyWSYGW9xx7pqhQ
         +yawykLgvZupM2vpUbK8gjRU4YPJKNtUIooKVDrDEDjyLhkClYv9FXeaBI5/iHtLwq3l
         an7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865999; x=1765470799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1NBivu5UEBkQBIeFnHZjPjnHfogcWbiZIn2200JwTs=;
        b=jP+rQC5kBbynENFjL9oiv+P0MudYFFWZ4fb5NV5MMjMRiStSCJKlfjfC1yqXYEKe1R
         CZ7rdaWxW8uJ9yCTm46fzpnsHuOvNG+ZvKpZLWXjgBt4iDAd+nM6mj04GY57REchNkXn
         HhJ3p8Gea/JzagY0M5TGXf8exiTgaBxuXpwlJyw5bFGNmF14Ysy0yfmUoAu1TScvkgTc
         qRIhhv2aPz3g2BP4RYJEjn10oVz5Laly8++JxOdEXeru4gWdOCfVJ9BORamVepDK+zhe
         EGKMhySb1thyYOAvqyHL/G0I2Z8z3AUH1j/YVd12hGaKUnTPK1q+ucwsUvu9xh0JnNVr
         zzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUheWgaJLA3DMFPbp2Ml2wTlOdCkneQNAsVOMNa+gLFSUC/Kvp9aKhrzQy/0eQ0XsZN+L0owYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtuFOZIXtVSZJ8enyHFV1JSSVoH2UBtfS/a91EIRN3xMcnMZw
	tExJUf1HWxqz2bQsIjL65mYBvymVFg92K4hFYV/oI9KNAHfMKlKLDTHu
X-Gm-Gg: ASbGncvBm6LR26WdDY8TgT449njdQMl+mLICBiy7+LvCv2nQLqzIj8O3pv0rrwv5J4v
	iguEr6Mwvf1kCseLM8ed0GIkJBsQtNAXz9WhsMNnDV8Zq9sn1x220LY2lXUWuoa2jErkf073wrX
	6Axh2GyCL54LTimFi2Nvd8soyiFwzYjbhDSBHN9qdhX7FLwUSs410aHBMkd0idBkjcnlohGot+3
	ohnn0qLDp06bXNhceefeeWGS0xxJuu0W4e7K4JIdgH69bqf7C+UISUUf/FdVIPECYIBEjMMVvwd
	q+nPBUPGKidba4zzVrXVzY1pwgcGyR0/BlPwN5bzxRB+rFZURb0BvhdfT5Oz5I/0iwWFYgyl9CU
	IAXLh+6v9teVD7IqsBJgeVIiArh115frCPo37iyqqWQY4088CTALQ1vxE59s2fhpd0u3PkYfY68
	MA7r8=
X-Google-Smtp-Source: AGHT+IGi6I2IgodSmUy9udv2+I0uezI+6X0NoB7sgQPDd5BV4p/ONZs+5KGeEu5OGTX5yIqBwOwJzw==
X-Received: by 2002:a05:6000:18a3:b0:429:c711:22b5 with SMTP id ffacd0b85a97d-42f73177864mr3997507f8f.1.1764865998607;
        Thu, 04 Dec 2025 08:33:18 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f8bsm4099038f8f.43.2025.12.04.08.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:33:17 -0800 (PST)
Date: Thu, 4 Dec 2025 18:33:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frankwu@gmx.de>, Chen Minqiang <ptpt52@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <20251204163315.rlc36k72cwfdyye6@skbuf>
References: <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <7aacc2c2-50d0-4a08-9800-dc4a572dffcb@lunn.ch>
 <20251204153721.ubmxifrev4cre6ab@skbuf>
 <6344bdfd-c22c-45a1-854d-59091dfeda97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6344bdfd-c22c-45a1-854d-59091dfeda97@kernel.org>

On Thu, Dec 04, 2025 at 04:52:53PM +0100, Krzysztof Kozlowski wrote:
> Yeah. BTW, you can also refer to one of my commits -
> 738455858a2d21b769f673892546cf8300c9fd78 - but also note that similar
> work later combined with much more useful change of gpio->gpiod API was
> rejected by Mark Brown on basis:
> 
> "No, the DT is supposed to be an ABI.  The point in having a domain
> specific language with a compiler is to allow device trees to be
> distributed independently of the kernel."
> 
> https://lore.kernel.org/all/9942c3a9-51d1-4161-8871-f6ec696cb4db@sirena.org.uk/
> 
> What's interesting, exactly the same commit for the same file, done by
> different person (Peng), introducing the same issues without addressing
> them, was then merged by Mark:
> https://patch.msgid.link/20250324-wcd-gpiod-v2-2-773f67ce3b56@nxp.com
> (commit c2d359b4acfbe847d3edcc25d3dc4e594daf9010)
> 
> so you know... it's all relative. :)

Yeah, IDK. May we all stand by our own past statements.

