Return-Path: <netdev+bounces-241797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 149A1C88494
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5F76354A94
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8552192EE;
	Wed, 26 Nov 2025 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clplL1aW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B59463
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138974; cv=none; b=ebwDVZIsiUOGuB+DsMPCqV/EgJcYQ5pBEhATEhULzST762L658BabHv7FxdRjm81x3cmKMmSZGGzvig+q3RB8qx5atejvexQZE4jmS6WG6h7iCDQaysZR2Ew+KWlnDmCD39lzSL84RcZqW1lEhyz7kLXBlq8EKdSBRTdCbUS+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138974; c=relaxed/simple;
	bh=mbVAmpxuVdYFBdtll38ZG4XExtKPa8+UxWKw6P0bZtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd1y9S4fehMH/bkvxvmS/FXjlvXFm6kwLfKysKj4x5hQTAmtSLK3tRIBngpmuGyEtrereFoaHlcvBuMRxmtSaa28h8UP7uMb9H3iFWO0PmVizI9n913811U1OystINoTVXTiDRqy5P5FXO/VH5hC3IyAQiWQhdVkAe3tvmPR+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clplL1aW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555b384acso79778965ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764138973; x=1764743773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d4HMD3/cpN94TXe86BJ3k2woszUYEKGFWhwLVhlOjWc=;
        b=clplL1aW+xqj63wgsJAwDegjJGAEUpuo5Zn6dYBO8nGkCcC+KTH18p3g9LaXH9xz2r
         UpLxgjHeBUdT6XntjLWA3oBEIZc4KAARpiStQ6kmB9X4Rco2jGOdMyQyvCyQp2ATLT8M
         FjfPIgX+qowIOF9wpS1IGxkJWtoiFGQ88Q4iAaX2Kw9/CuLBjmaXID5oyikhg/GKozRw
         klkg/ZrJjbhTqvO8gOctANXtyEpHacraWW/lLq+zUCQf1RgKYSCbbcHC3hSDVjlex56q
         anzXPBV36pLW91YymC0n9C1qoooDcTf7tLtV1Q3nwci3dcAEpan9cL7thvsahp8TSBfk
         ec4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138973; x=1764743773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4HMD3/cpN94TXe86BJ3k2woszUYEKGFWhwLVhlOjWc=;
        b=PmXclAtflQ+sN9s7EwnyPZrPxTMWvk9iMQsoJfw3hbxtNS4VxxickI6xffX7rEC/E2
         dzDommgfqc0A3tKbOEwvaiAysXontW9eFXRYUIjm4VGVF8BuZ/M+AqCNd2f3jAUShHoa
         TTDiuD6A7qTyDSjUuBCvei6FmmVZ6ps8eNC0WVufRMQJJIgI6s/ba4M3APeX2PrZL7TX
         FYNR2Vg+J+YfVfcnxl1nnhrXwZPGzFpXBHzbR13FIsMhrtEsxtYK4uOLUNzcp18uHZpH
         4HzTF/fahs3mooR/PZxbGb3KjqmG/KkBuGHBpdY3sioPrKoSSC4GiqGOozE45/OHACYO
         5CtQ==
X-Gm-Message-State: AOJu0YzKywwss58yrbi/Gkpxx994UmN7vUQZHQY5j9YLUkwXQRLVSNU1
	aCWgmPDFJwZOWuR6sByOfww/vHgiQRAsRCCR2Me2OxFZl9ycCQVxBAMk
X-Gm-Gg: ASbGncvKjobIU1x/7uULG8IZrMAYFPJ7F4L1LSghh0Sp6AHFJF8+W+9LKqiGteobOXu
	0c4JxOw4S2ZgcC6rWt2lbPcAOnzEF9gyxSPDtpTJOOFw5/wdP7tzEUyPWAq2EQ2bqA+cyOuKJOV
	RXf60+MHSIy6pf6FFZylOn0SD4W9E4fmvTYLOQqQzdMhQXU6EkyWnzY+6AdwLsNBFTnZ44tQCqW
	V67HaQmI0Hxgc7+YJusefXMkNMDa1EVlNw1qxwxaLr6dKLN5LbNehmclwJslYvzbZu0cTjrsJ+z
	TuRKyXTTPyCR/K5XwfjkMQ1s8tQtw7VstPr0hM0cADzm+K3CfPws+ip5N9RmdjfiF6N2tuFRbNl
	/W7eL/BEBgspulMG6oRn6ryhnTDaRzeDuUbpb3TSqGhzWznNGrIkT5Jv/PPFj7cYdyuEvnLq0Rb
	7O5j/ViSzkX6xhUsM=
X-Google-Smtp-Source: AGHT+IG254HfBmGeNTznsq3jsfYF61E2/kP6jZtpJNUg1TRpIwjDQtdtAmmA4ou2yctOeWjz9GSASw==
X-Received: by 2002:a17:903:b4f:b0:295:5613:c19f with SMTP id d9443c01a7336-29b6c68d7dfmr224553155ad.42.1764138972624;
        Tue, 25 Nov 2025 22:36:12 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1077e9sm190037005ad.15.2025.11.25.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:36:11 -0800 (PST)
Date: Wed, 26 Nov 2025 06:36:04 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next] netlink: specs: add big-endian byte-order for
 u32 IPv4 addresses
Message-ID: <aSaf1D-N5ONmnys8@fedora>
References: <20251125112048.37631-1-liuhangbin@gmail.com>
 <8564b02f-18f9-4132-ab69-5ee1babeb18c@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8564b02f-18f9-4132-ab69-5ee1babeb18c@fiberby.net>

Hi,
On Tue, Nov 25, 2025 at 05:03:13PM +0000, Asbjørn Sloth Tønnesen wrote:
> I also checked how consistently defined the fields using the ipv6 display helper are,
> and it looks like they could use some realignment too. Obviously not for this fix.
> 
> git grep -C6 'display-hint.*ipv6$' Documentation/netlink/specs/

The ip6gre spec shows
-
  name: local
  display-hint: ipv6
-
  name: remote
  display-hint: ipv6

The dump result looks good. So for others ipv6 field, what alignment should we
use? Should we add checks: min-len: 16? Do we need byte-order: big-endian?

Thanks
Hangbin

