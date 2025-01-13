Return-Path: <netdev+bounces-157694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207AA0B33D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C4F169A9E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFDE2451D0;
	Mon, 13 Jan 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uhyt6gjk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A60235C07
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760907; cv=none; b=JuXq22B2FLKavD2tl4h40afdna8NwiCZd/1N7jDTCbMhzt5AleHDan0+KB3NwohlJcmFw1B8oLm8EREWioNJLPURch1kYnncJ8ZWk8huO3WhY3jux99wJgn/U+Cm65Cpx1o5FCs/SOebEQnHzN7FB4WKLrBKPvWn12bKJ+7tdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760907; c=relaxed/simple;
	bh=9m20lcVuonZqK6MB1zpIGr1mQbOWK0xO2VXrfUqPTuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX6OqbGk1kU6Z5vxquiKjGclX0EZ2WCG8oGFWJrphafv7DVtb0Mazr3ejykBiaTkAp+cOtA5hFLxcf8njk85zgqmzRIxdTRzMHwD7sy7Ant8WQhewnkP7R02XB7lTOmG1usJ61Vs6mOsnnnpbZ3Of+oZQWIkea2wj5P9YL7j3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uhyt6gjk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736760905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZu9QqBriWk4/CpGcgr7d0di4oBFieKVARWfDfbeYoM=;
	b=Uhyt6gjk8qVjuVsiN2P3mXEv+cjHJKJKZ3lXZR9cgv+JQDxcmtqUtQAgvBfHw9up9iQd8L
	4GoQUjLCNhtIlLs729bGvMM7dLvZcTn6MKNS6uMQl8g7AyY0NS4GR48fgx04oMiO2MJrnR
	mEo717C2M6k+xgTH/uEBaT0KrTkDSrk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-uDJsORfgNyuuaVW3hvkDRQ-1; Mon, 13 Jan 2025 04:35:03 -0500
X-MC-Unique: uDJsORfgNyuuaVW3hvkDRQ-1
X-Mimecast-MFC-AGG-ID: uDJsORfgNyuuaVW3hvkDRQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so32631735e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760902; x=1737365702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZu9QqBriWk4/CpGcgr7d0di4oBFieKVARWfDfbeYoM=;
        b=bncSTa8M7GcMfg0cHVnj7Bk1ymD8SHXJk9HrRs3AHO6pDBFHCUWL1KeLTrNcgAtHuv
         gPfJ9UosampVohrRkMdqWRVKj2Har4jt2jx80ZMLYDNF23Om74imjDPQXIkNsvHfuOFG
         kpJ15ICkPmaItr8TZEcfJv6ZHc0Zi2y0jIMlEG9gfCVj/A5Ba8o91kytXINhBzKm4/6Z
         o3fnf6rrA3MpgYsZXYM2qPRANdJyST5pZ0mSs1FYZ/MhDx0YLPNfXvAKCOJtwR0kI1U3
         AQnFj+TUHi6hmVQ54HSTBHdWCrW0HtBeK9PRqQ6yboP5fBJ5/Oyu2XoiDOzwlhUnOO2A
         t7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXFe7Ht1l9jYNNrsWjgkr0qGrZlCuaM2c8ylkuD1sWoJ2cVbB7oqtC1R2iy2qGb0case2p77I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6LGBnjsj4etyoe0wlANlTOfl2dTzzfmkadtwikF13B0MA3Vg
	T4kQxA3q867sAK/9HVssHUex0Q07TpdMBpgs1ZK0YQg4Q0/JngoEN0f8Q1YEyC6U1eOwvxeLigZ
	B/NuErkDziV9tPE7Ppi1Dg1jwVaxTmvVN7jYon+23N3/d2kS9j7Fd5Q==
X-Gm-Gg: ASbGncssc+2NoMhlScoBLjw/dlW5bWtGGcUkxHMl6uYp1yv9UDVPHf+/hMDG8s9tt3/
	CtPWqKydwSr5wQIALY4QsMK/ny2PxdzscQFD+uS8RARrbfHqXuWpKSOSEfBjyiT4hKo399N3F3P
	s8fpKrVgcSYKzYNHjmlO8ZfSqwvDaQiY9PbrCaeuvnFNERF3TFBQEDQ6GUobRRk9zyNR17mM90c
	wJ+bP7a4HhwUTuPhSjWraDsUG8iU/gI7NZ9JrseyO9ARPteBDMneFA=
X-Received: by 2002:a5d:648a:0:b0:386:3e87:2cd6 with SMTP id ffacd0b85a97d-38a8730fb57mr18342362f8f.38.1736760902194;
        Mon, 13 Jan 2025 01:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKWbgJ+p8D2nSL1Tg89dORue0vrIpeKEyO3MQ6XFunbZcOEjwxPA5lI+qzzFC0qFwWNbxBmQ==
X-Received: by 2002:a5d:648a:0:b0:386:3e87:2cd6 with SMTP id ffacd0b85a97d-38a8730fb57mr18342327f8f.38.1736760901806;
        Mon, 13 Jan 2025 01:35:01 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38b15d3c7a5sm5224226f8f.32.2025.01.13.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:35:00 -0800 (PST)
Date: Mon, 13 Jan 2025 10:34:59 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Enforce ETS Qdisc priomap
Message-ID: <Z4TeQ0b2d6vt4AID@dcaratti.users.ipa.redhat.com>
References: <20250112-airoha_ets_priomap-v1-1-fb616de159ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112-airoha_ets_priomap-v1-1-fb616de159ba@kernel.org>

hello Lorenzo, thanks for following up!

On Sun, Jan 12, 2025 at 07:32:45PM +0100, Lorenzo Bianconi wrote:
> EN7581 SoC supports fixed QoS band priority where WRR queues have lowest
> priorities with respect to SP ones.
> E.g: WRR0, WRR1, .., WRRm, SP0, SP1, .., SPn
> 
> Enforce ETS Qdisc priomap according to the hw capabilities.
> 
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

-- 
davide


