Return-Path: <netdev+bounces-149500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB41A9E5D09
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967B8163331
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34986224AFB;
	Thu,  5 Dec 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEASM+yB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639D2EB1F;
	Thu,  5 Dec 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419570; cv=none; b=pJzRSQ/k3jiEYy2LDfYr15T+CIaBLfO64VLLD74WUMF5oE7aa3xz9gorKi+LBE3uaIC2HqNLIlR7kPV4VKmLCNyNkyqiGwffWxyPRUX+143v39YKnMdzTOKApo5MOj4KVC2aeUrqG1ARaRTDQSuzF75mTXrpDsakvXYcKQ9LhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419570; c=relaxed/simple;
	bh=P5ccLN6eWJniFJTYGSj3ZMEMZKKSoNechfgI1QFAHSg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpM/JQCX5SFpxPlryzi+Cl4BXDuqzFPHNRCx8aKTtWEGprF96g8Z4a6tmU5YAshF36KDINjhQzkg+OnwUbDoK7HRsPh6aZOSehX7lV0Goy69sV/9fl9OtQnos1+0PTN9hV/vRhIz4FPB0l/eGIGjuIJFdY54+FB0qEo9H50Q0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEASM+yB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1833367so7653585e9.1;
        Thu, 05 Dec 2024 09:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733419567; x=1734024367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O5mhDTiQCniX4dOvULwv2bY5E40qxNFbSX0TtTudBO0=;
        b=lEASM+yB38pSz9a5T/RIVsbK36Tu9Ip41yma15QSaljKIr2M+Dzot8v3BDsve+o3/3
         pNEdAgUNn9Jcu3VX+VEHPq3lZQFerzKDGYRWWmTT+G24D7s1Wb/afyWerg25d3yD1lkr
         fuKxUX1/sqkT6MfF/PyUSVtCpczWl/ZPwAocarYKYXVZhoK8c8mU44hGfmHqYWmpzgna
         6OrfCLDfAv3pPg4K3LxtR15gAt9D0qnwyYQ4f5ZYOZ/6kBqvb+NKVInx7ewcCE+WhV2U
         hdjwtEfYIW3g3PjjveSz7bW7jo2xI37BEo09KdMOz8ELEsG1RWF+VBm48u+5jEYCIsfg
         nahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419567; x=1734024367;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5mhDTiQCniX4dOvULwv2bY5E40qxNFbSX0TtTudBO0=;
        b=udGi9jjUpPn1fFdUk1Wb8JLLkOXakRSAOnT0oAsZ9/iTdDnAoHOTmoKfkMQW29tf/s
         jh2RabYhwE5nrm1tJfy52tTUB3EJ7LIxqvDX31jAbUpAUFybO2BiI91gHXz/1Ggo9Kv8
         EzREn+RrkNokzbLnmftEvhj/FfracXLTsYUXl/APk7Hz5YjQKuaSsOwbfoCm5710bwVy
         fmu35P59nhurNQUrJXdjtxp+J7pkVNCWL2Ki1Q01O0PBdsbS1hYpO7MYgq/t5mErQm8f
         FxNRUSUs5HGWSSEP77xtmZve3HZXr1S7xoRB9bgckMHo8sNu1pwzvSYCfvZlcIlxjHe2
         jgyg==
X-Forwarded-Encrypted: i=1; AJvYcCVaf56GdAFOIax+tEQ+VM7DYrlG2a6m3h+Sk1vRQH6+H/YhNgDzEKfNaPd2lFCSlWZYnMJZwnXw2kLk1X31@vger.kernel.org, AJvYcCVbAUlGNIwmEdG78eQtUrhMV69nETcbAztro7oeNOHcy741mjLFsprJnYNSgg8P4uqFowyIdtmq@vger.kernel.org, AJvYcCXu5mMO2L0xg1BYCB5qCMdkRE27/G9vhCJPvLO1SXe2a1nbM5lcgfXnjN94cB+uXuXlVWl19yF9hvFT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0iyRGmgS8X8dn1RE8r/nHqnoKjJJZ8Ke7ZsdmheBnQR8UpcB
	1ge5fozOWqxV+l3lLnbA23/vIX6zDw+95SBYG7vxYNOX3GBu8IEw
X-Gm-Gg: ASbGncvH6MKbc6t2eVIvZWfdk6kIx4+p29OJaX3Wd8oyvjoPXsFTeqKUKYrU51q9rek
	EdEXS1KXYU/DchyYvBVEreUGicGoZtWrCZjtgRDpvU0a/J+BgdTBPQhtZT3J35khVao6i9h4c1Z
	b4hHXZtXMWKNhrwpyIJxTDbX5l2mRlSvRN4NC/DTKj5somtWgELrSSZCZNdzYgQdVrogL51Cqcq
	Eh9HtgtnQwqri9cwD+aSV7ryw/5srQlBO5lE0YQUE22lX+j0Y6qCZHODolBkHcGH4ntwPx1sefz
	VloxHQ==
X-Google-Smtp-Source: AGHT+IGWBr7m/eK/LTokHoFmkVp6cSV6bU7ybbZzYTsPTC5V+3f3UIT5XgVkJ22lghZ4+yW3kvJwBg==
X-Received: by 2002:a05:600c:1906:b0:431:7ccd:ff8a with SMTP id 5b1f17b1804b1-434ddee0503mr1062795e9.14.1733419566414;
        Thu, 05 Dec 2024 09:26:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm68800725e9.3.2024.12.05.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:26:05 -0800 (PST)
Message-ID: <6751e22d.050a0220.3435c6.57de@mx.google.com>
X-Google-Original-Message-ID: <Z1HiKXfpdluKA0_w@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 18:26:01 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205170629.ww7qcvgbqdf5ipcj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205170629.ww7qcvgbqdf5ipcj@skbuf>

On Thu, Dec 05, 2024 at 07:06:29PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 03:51:33PM +0100, Christian Marangi wrote:
> > +	.port_fdb_add = an8855_port_fdb_add,
> > +	.port_fdb_del = an8855_port_fdb_del,
> > +	.port_fdb_dump = an8855_port_fdb_dump,
> > +	.port_mdb_add = an8855_port_mdb_add,
> > +	.port_mdb_del = an8855_port_mdb_del,
> 
> Please handle the "struct dsa_db" argument of these functions, so that
> you can turn on ds->fdb_isolation. It is likely that instead of a single
> AN8855_FID_BRIDGED, there needs to be a unique FID allocated for each
> VLAN-unaware bridge in order for their FDBs to be isolated from each
> other, and so that the same MAC address could live under both bridges.

Mh ok, I hoped we could first have the base DSA driver merged before
starting to applying these kind of feature.

Concept looks handy, ideally I can just assign one ID for each port
like:
port 1 -> FIB 1
port 2 -> FIB 1
port 3 -> FIB 2

Question:
Ports of the same bridge should have the same FIB?

What I need to check is how the switch handle this for learning. Does
the switch correctly create FDB entry with the right FIB? If that's not
the case then I think assisted_learning is needed and HW Learn can't be
used?

(I still need to check if I can assign a default FIB for a port...
Currently the STP register are 2 bit for each FIB id, so 16 different
FIB are possible)

Also do we have a script for selft tests? I remember there was one back
in the days for fdb isolation?

-- 
	Ansuel

