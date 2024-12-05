Return-Path: <netdev+bounces-149506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6D9E5E51
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D661885069
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9422B8D6;
	Thu,  5 Dec 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY18eEnc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9D229B1A;
	Thu,  5 Dec 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423650; cv=none; b=szR+LYJRAnTnXi2CE9WkCY6UWlMAuU4VbIynDsFjS/hJq8nJF0twWtue1Sk1XO9/wvz+ACyAMwWr+ub0t5sGU573B5TFhyYExNA+k3HfEMTJaUSKJFsFSN7z4Hpa8ihADK3MFxEtAtzxkaCIWtT1fcCUSakXnotDotzCQStVfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423650; c=relaxed/simple;
	bh=cvNodn7aeQRFDOjnU4OGV5pp/kJXa8bzEWLC/Rv3d6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYk5QhIP95MfffkdbGGwwMB/aGlDLSHLbO0FL+wbyPIQZ0LWcGv1WJOJfOIDW9VN3gZyMRC2U8pXiBaa+nrWy6Obor/9Rhw5MzHhSIvJjS75PZc4xaLimH5cxSHDJ65f9s9eEjRFNhoevhAq4yKZE9e/ofM0DgkOGmEUv/l6cH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY18eEnc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa62fc2675cso10175666b.1;
        Thu, 05 Dec 2024 10:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733423647; x=1734028447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yta+XXMHP1ejgRZZWR5HMkhLHp1OT/pNiE2xb2AFLps=;
        b=DY18eEncrKUxMQcItFsOMFjp0QjBzMnKZxkj7X2Afe2hTxq+a5I7tkcj810zNegGkP
         HYWjHxkjyox/vOcgWfCGrqI6BlHYtX/NWMXnShjOb/IcVYOCemxm2TuZ7LuQ1bnMvisc
         Nc05wtULK8HMH1Q5PYbYaByn7ds8yCVc1oqjUdlz94PSgW/y5QhCtdpwi3eBqHg4B0nB
         XZeqUWmOKhida6udu0w+8FBPTQZh2k3BlZhZG+V2hEuFGmJvptw2HkQYLLe8rsY5vwMS
         qVvOmmrBeVwpKtwP4t3vGjUNIltiwegYht7QqTe74nH1tU+3hhEOfjfMBiTW/L5F8pr3
         LISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423647; x=1734028447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yta+XXMHP1ejgRZZWR5HMkhLHp1OT/pNiE2xb2AFLps=;
        b=hqJQYl33SsLzgGxc2XTuOgxuq+ieyDJFRoeKteoOigUY3/yaJdeA9WjtjOqLUI+Toe
         41SysGHT4Cj4nymQSAQ3Jisk4sQAGJ4FsyS3MQgpTZTh6PGSBp43sfui8gedvUNMUJG2
         P+pk1csQM6Ae7JOSxLrhWzwlx9n88rmrSSpHUO4AbbfXzQlGwG9kaFuNKVXQHKhwp+QM
         PU4ts8cfquHdMHiNrWs3OcURmgmXhiLE9lDmwK41TilR06G2lnVtKGdk0QAJOS2kUTDX
         g0lrk4uFgl7dJeGXnlAdQWv9y1NCFFaUlkOoIkHjMMemUybDPovQ1RNYd4L6huP1geCQ
         sHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuwC4/BO4vRuqrtxJQyrTAkze7+Y551Tzg3D262ijEL25CXkRIOBWxJy29LrUXq7PWPMxW1IAM@vger.kernel.org, AJvYcCXG6EFaSBd4w2bJpCbc9qG0Zot9hdlBvAo09SEBYljxSld8KGJWqCa4RIqw8ZJish4WJg4rKx2tStNJ1C+R@vger.kernel.org, AJvYcCXxRjQRXiQE8QxjUdNHUnXImqMD5ji3iU/W6fLz0qQrMNISAbrHVNerlFNkvBVfk5IuYT7jNYww3QMe@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAW+2W2uhLzod4XxN3mgjxueb8aThCTtuaV8lgLsEfPqBSeL8
	ucT8XdtvXJBNpusNvpk6NIjspLCTrfsIfFq5MsPOX9kPAhECo5nH
X-Gm-Gg: ASbGncty+hqXcg1o2iNQPv86pAGDt7jPZEjd+ru17NlWMHMFLVZywQVTiT/Yq7dZmEU
	FNEMM3WZ3+ipol1ayH3CjvlwkDsmF0iPnyTHb8CnAYtIBNe8E46/EqPJNtKvJbowDQ4neUoA8fU
	+pFChwldMqwpBM3c1Fns7GpZ53aUYxXxygFns0/jrrJDw8+X4IQIY0nR9qbQLJhjJSXk+qirFqE
	gJaiWuR0qN5CPqNPt7UXSTVaVGkVi5HuoLtQ2A=
X-Google-Smtp-Source: AGHT+IG4CYEfyQeKmQp0tq23JHoVrVPDcBsqZFNjm8gaj1DxcM0BYc34ahZP6mtlpoMmYTjT7JB0lQ==
X-Received: by 2002:a17:907:72cb:b0:a99:482c:b2c6 with SMTP id a640c23a62f3a-aa5f7dab976mr476916066b.8.1733423647107;
        Thu, 05 Dec 2024 10:34:07 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260a3a89sm125047166b.171.2024.12.05.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:34:06 -0800 (PST)
Date: Thu, 5 Dec 2024 20:34:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <20241205183403.zla5syfzj3yrinwj@skbuf>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205170629.ww7qcvgbqdf5ipcj@skbuf>
 <6751e22d.050a0220.3435c6.57de@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6751e22d.050a0220.3435c6.57de@mx.google.com>

On Thu, Dec 05, 2024 at 06:26:01PM +0100, Christian Marangi wrote:
> Concept looks handy, ideally I can just assign one ID for each port
> like:
> port 1 -> FIB 1
> port 2 -> FIB 1
> port 3 -> FIB 2
> 
> Question:
> Ports of the same bridge should have the same FIB?

The answer, as well as many other explanations, is under the "Address
databases" section of Documentation/networking/dsa/dsa.rst. Please read
it through before starting to implement anything.

> What I need to check is how the switch handle this for learning. Does
> the switch correctly create FDB entry with the right FIB?

You're asking me how an8855 behaves? I have no idea, I never interacted
with it :-|

The idea as far as the DSA API is concerned would be to learn addresses
in the bridge database (DSA_DB_BRIDGE) that the user port is configured
for, and not learn any addresses in the port-private database (DSA_DB_PORT).

> If that's not the case then I think assisted_learning is needed and HW
> Learn can't be used?

ds->assisted_learning_on_cpu_port applies, as suggested by its name,
only on the CPU port. On user ports, address learning should work normally.

As you will find in the documentation, the CPU port is not like a user
port, in the sense that it is not configured to service a single address
database, but all of them. So, source learning on the CPU port will not
work unless the switch knows which address database should each packet
be associated with.

In principle, one way could be to pass, during tagger xmit, the database ID,
so that the switch knows that it must learn the MAC SA of this packet in
this FID. I don't have the full image of the Mediatek DSA tag format,
but if an8855 is anything like mt7530, this option isn't available.
Thus, like mt7530, it needs to set ds->assisted_learning_on_cpu_port, so
that software will call port_fdb_add() on the CPU port with the correct
dsa_db (for the right bridge) as argument. But I don't think that is
going to pose any sort of issue.

> (I still need to check if I can assign a default FIB for a port...
> Currently the STP register are 2 bit for each FIB id, so 16 different
> FIB are possible)
> 
> Also do we have a script for selft tests? I remember there was one back
> in the days for fdb isolation?

I don't remember right now, I don't think we do. I'll try to come up
with something in the following days.

