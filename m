Return-Path: <netdev+bounces-205058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C406AFCFF8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53D217559E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D92DCC1C;
	Tue,  8 Jul 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/7HFq6H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B81E412A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990456; cv=none; b=Pa4lZz26GteGrbvc5yITDUHulXBRO/vZXMjAkAtNW7Uo997C6D8/LrUTOpOs2CExjb82ZZYvHumhx8dewNAOtbieLg28G1rDWahTNEitAYSKzZMVYlh4F5H3KNeg7PwI5LET1smZul/DgHMjs8c+dnfTEDDriWoIzAKo5P7VtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990456; c=relaxed/simple;
	bh=StlcZvK6aGILEdk1KZNWda5UzucYRHUtZYuMqW7hhhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac2AMjbmXdVCDDVsNcR4y486OvnlxOd5SBAKM2QTfYA1Hl/nqXwcSREeVBKj76Vqvdn3tSeMWvJCwt0hahRsUM+uexCLLh1Nxj7hjyTq9o2y8N3OLnfB211263OnciTWdiHAqrKav3y2ZkGWyYxY0iAhkskm5+gGrbx4S41NcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/7HFq6H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751990453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7rmSrQYi60FMAPm+K5LDdHo//beZbxEAuJpXe2zQCM=;
	b=g/7HFq6HuBVU4Znu76SKHMJUk+4Hglywl8N1LwPOsqd6EyTsBaZf843UArVtP0s2Io8yUf
	Q/rhEkiT8n2+1snhb5w3iG2zyb+xejXo2HFPYb7KVY32gsG1pEc0bV+H0BBi5c2pzhgoAS
	iY53bZRLUXA0fCkSsJaRmwuwNIyvpow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-cuo0TmZ_NOOE0n884tpGVQ-1; Tue, 08 Jul 2025 12:00:52 -0400
X-MC-Unique: cuo0TmZ_NOOE0n884tpGVQ-1
X-Mimecast-MFC-AGG-ID: cuo0TmZ_NOOE0n884tpGVQ_1751990451
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so25454035e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 09:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990451; x=1752595251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7rmSrQYi60FMAPm+K5LDdHo//beZbxEAuJpXe2zQCM=;
        b=h8MX9gO2KEuAQdodMgSeoAKf79s/c08Ja0Y9usn2Vc64KRbJArlU7zFP8ys8qJdaBD
         C6eJk9Ve1RWfy2z3r/ZbRfpQiVPoWD8/Rytt2epjjBcHbs5Qz73R9mSYDfv5g7rxT4iA
         ZIC+06DZIikhhZvI4ese7ELGKszLpGP/eA+G5wy6TZD0oVa8sXO0Lmn3aQC9XnHKxRR2
         OAzQsmpJlCbXUXCwDnh/4tRzTm2uS+1zrxjIjDy3KxdVe7In/RBiuS9uogWAPIxdS8qE
         NN/4w05xR+HrB98pxmCRUxc2CRk5H+WkeFPgoBkCvytmpLkF9XR5/cW/nNsRvVc7jKl3
         Y3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY9uAFosE3iJvlekqi9Huew3/XHNe5rgs9RD2FkgHDw2J9DYTVl8/EbiJ1vV/DDDG+K50uUCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFB4TNzzJ/XqQrmglt/tFALGgNfu9YI7A+3To1Se1YEcD7kAVP
	Eq2SMyCilJCIEGZNB12YKau6HochgD+yl/fwl3N1QBRICnx+JRnSukFY6RNCLmgmVynYMib8IGn
	xmKZfSGUzlqFZCVA/zADXBS4bTlhmUMdetWA6LEn325BvudSaC127T8igVA==
X-Gm-Gg: ASbGncuTy/CpoeIoUu5wLkx0RlglBk++qincJ5LXr8ciQRBK0qe3P8/U74Hz9zaJydh
	I8P7KNqxQXy3jsj9Gb8bgPqcT9POw1mvLpd/MV1cByXRCxlHR7b/mdAtlV5Qilo8/YcJiztNJ+T
	00sjl+g0oQhtpquLnU1lVGT3tig72PN1GkoKX9Q0VfEB4gOQcMHB/Fabn1HnbCYyLJi9C1bC/S9
	HSsxnCqvWpJ3L+pI0U8X9yapbcrAcsv0Aq2Ga18l+KZN2YxPluQOTG/tn/twYI9zugvPYPrCF8T
	O94eeRzKnVsChlg=
X-Received: by 2002:a05:600c:3e0d:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-454d35ffbdemr2267455e9.7.1751990451159;
        Tue, 08 Jul 2025 09:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiSR0msPRTkgKz930LJ0aKsR6/r+DX3T5MYEMydUmRzbvpCWWwSZ1kxGtK+XaWrTCCG9Ic8A==
X-Received: by 2002:a05:600c:3e0d:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-454d35ffbdemr2265355e9.7.1751990449097;
        Tue, 08 Jul 2025 09:00:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d44sm26526055e9.30.2025.07.08.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:00:48 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:00:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 net-next 0/9] virtio: introduce GSO over UDP tunnel
Message-ID: <20250708120014-mutt-send-email-mst@kernel.org>
References: <cover.1751874094.git.pabeni@redhat.com>
 <20250708105816-mutt-send-email-mst@kernel.org>
 <20250708082404.21d1fe61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708082404.21d1fe61@kernel.org>

On Tue, Jul 08, 2025 at 08:24:04AM -0700, Jakub Kicinski wrote:
> On Tue, 8 Jul 2025 11:01:30 -0400 Michael S. Tsirkin wrote:
> > > git@github.com:pabeni/linux-devel.git virtio_udp_tunnel_07_07_2025
> > > 
> > > The first 5 patches in this series, that is, the virtio features
> > > extension bits are also available at [2]:
> > > 
> > > git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
> > > 
> > > Ideally the virtio features extension bit should go via the virtio tree
> > > and the virtio_net/tun patches via the net-next tree. The latter have
> > > a dependency in the first and will cause conflicts if merged via the
> > > virtio tree, both when applied and at merge window time - inside Linus
> > > tree.
> > > 
> > > To avoid such conflicts and duplicate commits I think the net-next
> > > could pull from [1], while the virtio tree could pull from [2].  
> > 
> > Or I could just merge all of this in my tree, if that's ok
> > with others?
> 
> No strong preference here. My first choice would be a branch based
> on v6.16-rc5 so we can all pull in and resolve the conflicts that
> already exist. But I haven't looked how bad the conflicts would 
> be for virtio if we did that. On net-next side they look manageable.


OK, let's do it the way Paolo wants then.

-- 
MST


