Return-Path: <netdev+bounces-178543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C06A7781E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0883A62B4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2E71EE01A;
	Tue,  1 Apr 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6mjwC9t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94191E885A
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500986; cv=none; b=SRym/QlrtcboFiO2YHZHHUpMkS3EsLzyRkzpA7hUqhNkdOtcxFRZ+JP+ydCaoR1nLaPSXcKDJOQaDbTbEPqGYTxQtRWzKdrlH7tlX8KyOuDN2fz0J18+KKEZ+TUpwQtXrLaKihW2Mn8Dwy4692zaiFszpuTDxw14U4gwk5kt4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500986; c=relaxed/simple;
	bh=n6+62L9dbn5yPCNRRBPjy2Xoe5oXCpq8+IGpUfsX3+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE9z6NlxmvX6ILB219xKPuQLEa8nrx/3NgFGJk1+zXNaWpBIcvi8F/CvplXRbU/qP/1JCQDDY4TRBuuU970F4VIC8va/OpwXSVgxRSfP6FrcB6rR9IZ91Ep71KcK15enV62Efqr/AhNR7Ys3DXw1yKcaiFbjj9199b/yov2qrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6mjwC9t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743500982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uz7X0saZ07cJoMgjZepVgox7FPN1JF4+WKasDO8EH1c=;
	b=N6mjwC9tyB9hmFy7Y9XBNygj/3wxoZGqwgdcheZtw8KOIUE6KAA0UnH7Ymp2tZtK7xJUuq
	8bt2pZQt3Oddha+IjNAsLm6S6hXUj5ly+7gzyHwqvhKBgGTUZec01HrxfvVzGch8pHqTgI
	FO0gsN7nY602N2ILvj9LBqU/XDmhGVQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-FH2MhGjsNFmC1elL4IGuRQ-1; Tue, 01 Apr 2025 05:49:41 -0400
X-MC-Unique: FH2MhGjsNFmC1elL4IGuRQ-1
X-Mimecast-MFC-AGG-ID: FH2MhGjsNFmC1elL4IGuRQ_1743500980
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so27866555e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 02:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743500980; x=1744105780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz7X0saZ07cJoMgjZepVgox7FPN1JF4+WKasDO8EH1c=;
        b=fUipP1N3vnFVw6K+Kq2Zupbz4qKOk7EZzQ36dGHrSSqFX4Hc9ykxGdn5q6tIf3VfYo
         T90D0iA8OCExeYUGXA/a8A4n3k3q/RhZhypyNkxgF3NipWuXjgm3i3/U/+GH8ATNDQtY
         gzm7MX7xNDLhfIVPFlJOgyyJV55YfumsxUsXDxb95Ac0DUcKxawjjGMm7/kYk07G2Qio
         dyXEdepZfdfNmId3WGbMS3KZ4XwxdH19yvVA8WQBkZtqW4t4FZ1WUXae39C52KoQbvZj
         JvD4X85Eo5LfVxtl80ln3nxaAUQgm05c88LXLMLQ+EvohjW2RUl7dRFmxd0pDPTPyli4
         zE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUdYj2fDcbdiDQuVWz0pVQlhXqMbvuzicjkqMoJc6/X4XsoPpzJqF3QBOURthlUCfQWJqrTGRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxzoA6532UJ+ue/TcUNwN/5c7zqci0GqbCeDMrZMsgecMfDPC
	CybNDOIYYhLXp4OZn5BjJIlaCuIfjpe1hTI5INQ7aQMEO8npi5lbmomv+ewPVzNosSFt/T88Crh
	LSY2ws5Vd9y3/DDOHrhw+HpDOXNzUw+v7nPjfmK+hfgwR97JD3nqqrw==
X-Gm-Gg: ASbGncvuisLYxUfhD1URMXONFsRz1tU5SOwJDlunOwf0aw4YFBw8nxpg9M4p0JShKAV
	dBd3Hn6+3BXoVfli2JN4gDCvNE0BdYLxFkfZP6rQXb7jiDBBLFyt/LPqOtqTNy+f/vTtj6aR+jf
	vmy59ELRExSHvEIRzKa91ksKOfz96kVWBaf3JdfEvevm1x/i+9Bfs4kZ80f+1ipY1cZKwWuIlcp
	2whM38LvId7Eo1lhyVWDu2BgpVUujkeCLh5Knrgm5NI2/A1UtcZMRV/aLxTKAqMOvjF6Eb4k9XP
	yxrHLBJd3qHthg==
X-Received: by 2002:a05:600c:310c:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-43db6224034mr86356895e9.4.1743500980218;
        Tue, 01 Apr 2025 02:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq6P/LONQIdq2pleoYEuzzxgyj99hAud3WvWbJHB5zZUAUKpRXcJTP2ISiVIGMBWKtclaTMA==
X-Received: by 2002:a05:600c:310c:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-43db6224034mr86356785e9.4.1743500979880;
        Tue, 01 Apr 2025 02:49:39 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe389sm192609015e9.19.2025.04.01.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:49:39 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:49:38 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix ETS priomap validation
Message-ID: <Z-u2svZqo4NC0JGm@dcaratti.users.ipa.redhat.com>
References: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-airoha-ets-validate-priomap-v1-1-60a524488672@kernel.org>

On Mon, Mar 31, 2025 at 06:17:31PM +0200, Lorenzo Bianconi wrote:
> ETS Qdisc schedules SP bands in a priority order assigning band-0 the
> highest priority (band-0 > band-1 > .. > band-n) while EN7581 arranges
> SP bands in a priority order assigning band-7 the highest priority
> (band-7 > band-6, .. > band-n).
> Fix priomap check in airoha_qdma_set_tx_ets_sched routine in order to
> align ETS Qdisc and airoha_eth driver SP priority ordering.
> 
> Fixes: b56e4d660a96 ("net: airoha: Enforce ETS Qdisc priomap")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

LGTM!

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


