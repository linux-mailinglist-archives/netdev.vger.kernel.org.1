Return-Path: <netdev+bounces-249617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A10D1B9CD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A58930052A5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AD35C181;
	Tue, 13 Jan 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijx8tYjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F73557F4
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343945; cv=none; b=kyMOWXOJZ+mkQykJBuCDB+WIpUSgyhsU2h1ea3P08fu2YMr7tMcbXa0IT4RRZsc9H5ZYKQwIeXL6RFFCNNa+NoEufjN/u9NPURLnU6YDsccipiHoYGAJBoynPXStTm4c9EN3DbZbso83O5sRFQ+0G+v/Z6LlmZmhwvzvUGMFLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343945; c=relaxed/simple;
	bh=pjrV8Ah/L7zNpoB870nEG8kWEgsLpqEksFVHqYTKqU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdYJvf97LVI6f4ebQIXQ+5Jrn3vlEHYHH6E3mQ9A2mT5E7CQGvrvM2aFc0vA7SI7ucRaRlEuL6miRJouX9xZEudQNsuQa8UtpA66p3vKbV8gWdolGXvikhV5ZGVlVQBoQZ+G2jpQVbLhjHaKrF0bCuVirBqHAJc9nUaiM0n2nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ijx8tYjs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so13014692a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768343943; x=1768948743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjrV8Ah/L7zNpoB870nEG8kWEgsLpqEksFVHqYTKqU0=;
        b=Ijx8tYjs+w5bTf9KCRQz8GckPxFCmiHYVct44S1f3GlSYitzyDyYS51Gw8Y5AEYflA
         Mzu23STfOmIrLwxyRINmeMmepCvH4mPHXn5H3vweX5mNTzvgfbulK1nB5t0sgv3E6oQr
         4RYmWOFPxtXpkUVxl4xhDf2mAl+QP/0UjxNTIs9E03uoN/Exa/GLzfbK8emjgfqXctjv
         el2pPGUte52odN6sbn2ApvRx0pfnq8EWuyYQCOVq0GN8hHqXu41/12LK/WuISZvtCFMD
         PKahVLmPdvP+qf9887Wt87RQLCWH3nYbPHivRdUiPX6aEjJK9MlrX/f7G3QhiM2zKWux
         lylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768343943; x=1768948743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjrV8Ah/L7zNpoB870nEG8kWEgsLpqEksFVHqYTKqU0=;
        b=p+XbdeFU3BjQnMBbi1zRoWFrbHYYD48NyDhNA1TDQJul4h3Fci5KDMdehiUdcgxzpv
         8ac3PGN5/4FodP4sLOi2QPiQ/97cpw9JwTFEBu03mFPyd+y+qruv7lwwgRleo0NMH72A
         7f/VguXKrMZvYxyqfzVeL+/Ghitvz9k6dUYcKJMLTLzNeBNzhh1DteKY0Xv7gn6/y7R5
         LscIeCrLM1SvxBC/uMir3oHJMIaS8xL7ewtFv1Jek31BWbr2mfrdTs2qmg6OTf2aaHja
         drrabD8gbBnxawClpo+3VDBXNBDkCGLkTXrysBtiot2rgDtn4mhqvM8jvPHh5zMnwJJG
         yLww==
X-Forwarded-Encrypted: i=1; AJvYcCVrQxs4MlEHCwBpBxv4sn5hAuKDz+sVIRzejrIjL3yixZ2RIHOywCC7e0HMeO65kzk1Muv2Saw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfnm+O9dYi6guEVEsmxc+DklgucY/s70OBiJWqg5mGPfZKGFb
	4bTBtKEv+AKgpZECUSz47NyZb4QxWWZ6DYwURUlju6YbSSM4hQjXvTxAr4rGiq5QUYpQzE/dU0U
	3ggsJP6MG7YPXodfbMKkq9xETtBw9SsU=
X-Gm-Gg: AY/fxX5JwfSThJVKa26OKVDSZyj6txppErDMlE2gzQiQF+4pHwl140QhO/FJge/WYdG
	jKufeUjE++dxf/Y0yA09VccELChzUN9mMqNFVZrheW2wyqHI59mje2CjkJBPRMwfaLvQb5g30HK
	lAl7wt3UOJgPy8Uvk4BR53UiJSgd1ZWFDoSlg4A4Nvcmb+snMERlDhk8gB7mzLaOPM/IYSTNNuy
	YBQPMZtpti2n1aEZHmXJr0DMSWorBxhj7zZ4KvlBWmen9fWeXS/VrW6BK53kC6tjrlYNr1m7w7H
	s2aVYRQVDkwhRPAE32OFIAvo9A==
X-Received: by 2002:a17:907:d27:b0:b73:7a44:b4d5 with SMTP id
 a640c23a62f3a-b8761139a87mr45560466b.41.1768343942489; Tue, 13 Jan 2026
 14:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <34647edacab660b4cabed9733d2d3ef22bc041ac.1768273593.git.daniel@makrotopia.org>
 <252d6877-d966-4d19-a38c-cc83ba908494@lunn.ch> <aWZVIBh6AKiIaxdr@makrotopia.org>
In-Reply-To: <aWZVIBh6AKiIaxdr@makrotopia.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 13 Jan 2026 19:38:50 -0300
X-Gm-Features: AZwV_Qjg4zpsS4od6KBCg5IH7ipEaILyUhtFhNBfGxqCxTWtWrTgv-97YJUF4cY
Message-ID: <CAJq09z727C=9mh2a0BEVcVLKkWcdVOL7oNvVBq12k6zm7nxXZQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: support using
 non-MediaTek DSA switches
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>, 
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> MediaTek folks also got back to me in a private message, confirming
> the issue and also clarifying that the length of the tag is the
> limiting factor. Every 4-byte tag can work, sizes other than 4 bytes
> cannot. As MediaTek's tag format includes the 802.1Q VLAN as part of
> the tag itself I suspect VLAN offloading will still need some extra
> care to work on non-MTK 4-byte tags (like RealTek 4B, for example)...

My suggestion is to enable it only when sure (mediatek tag) and drop
it otherwise. Something like this:

https://github.com/openwrt/openwrt/commit/2603d6d81d1a088c6ad271fe20a63fa6e3a75124

It is not worth it to risk enabling offload for unknown cases.

As Realtek was mentioned, the 4-byte tag (rtl4_a) is for old SoCs,
hardly paired with a mediatek SoC. The newer tag, rtl8_4, is already
too big (8 bytes).

Regards,

Luiz

