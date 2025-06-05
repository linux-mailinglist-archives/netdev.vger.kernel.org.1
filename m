Return-Path: <netdev+bounces-195325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B739FACF8D4
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921EA17A993
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034FF27C875;
	Thu,  5 Jun 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAXTuLFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327CD27A127;
	Thu,  5 Jun 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155617; cv=none; b=K8/NiDOdhSSb+wkYsLVO9vI5YTSgo9QWy4fvqN26UGvDbRrMsy4B5at9jmnyWkN8uVdEokzssy1nZtkr78OGYVIphrdpwb+9n/YTILHIorAVnhBaBjj/2QaZsJYpwIjAv7R+Fv7fjtQNl+hR692hSpKw4t0pcpcE2C3VSYT1DCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155617; c=relaxed/simple;
	bh=C13lyaepQeg+W9FybN+9Webo8rqXcAFoCH0QZGDKxcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGUY+0qz2d1xXj+Y8xhBUakemN7Q4+VPIwOqI4MVxQ/gAuTODtAwDGNFMtRbn69FvUyhryBHOVB3RhbZUrBN5e98dPI/ffDQoTJ3LjaZOP1JUTz/dkpNRGsRj6GU4k9bG1tKaACA3SMN5F+bwHTFEjnNonLHK44/AkZ/w+A897g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAXTuLFa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a528e301b0so108912f8f.1;
        Thu, 05 Jun 2025 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749155614; x=1749760414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C13lyaepQeg+W9FybN+9Webo8rqXcAFoCH0QZGDKxcI=;
        b=jAXTuLFatQnKS1TMyPSf3lx6BYGlsaFMkqKoFBrzRtflQvzj1ryn9AYKC04HJUKUJy
         M75P4XDi2y/KOomUVdndtM3f1CzoOzFh7vLiSAs87oCw/iOWfW4J6ZKtS2d86BNZlGsO
         VXUf3q00s1xxsLCKhPEBX7vs/1h4FPTAFn5adVMGOUW6G3m0gpzMINdPCINBPGcRkmiQ
         XMJThm4+nqAW38Bb0hF6kkriHsmqaGag632ZeBXyn8ufL7W4VqlS8EGCafF+/bClmci/
         0iawWKTf+XU+I5S50ibZz9AK9DbFEVSkbqK2qXR9aSRT4ES8JDjftPdPiQbqS5m+9MAn
         YqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749155614; x=1749760414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C13lyaepQeg+W9FybN+9Webo8rqXcAFoCH0QZGDKxcI=;
        b=DGQXKhaQOxMqGkRFyUWTSqMxj3Y9bX26oZMAbhMOBdGFsD+s0CBRHXyQZqyhbyDkD+
         E/Lo7+wD8W0rYd4zAbYUws8SLSTeoUH83rDXazi830MLKUiBYT1vMnfcbAtsPMRctDRw
         7uZeOqjNivC/tZAh7bhnGHqwKl2uNX18dRJXeEsSKMkDBBCZSUn2S9gyUvulKclU6bIM
         nfqydrBmPsMEkpIJ6ppAlPHeP2t3xn4AgWmaZk7Epw6qdQhhqdZN/t8jliTJGFnHqOPt
         8Glvi+GkW6su5kcNDX3XSFUMBuhNMBLThbxiIWUkozJcsva55jmFYhwjwnfW1derAjvm
         tajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNnjBogH5xy0eTdVEsWkmRPJoDo0V9E9aF0QGONPnw+5BDL+EmyrOgVygg0C1d3UpCq1Ehu3lMdzkquS8=@vger.kernel.org, AJvYcCXtek22UXX1qvknhYDdcGcvb04Ia2lWgJpEzsEPML7E62KG6CynrCQnlTG9o+wPojly5Mz2Iszr@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjP5y27dAvU1Lvpxd0grRpzW9F436TpEnkoaqEPImG4Fh2/XF
	0VG4cg+HW7lpVyET8XRWzxO37B8H73AdX2m3HWyQesd84tqlQIB9HpEd
X-Gm-Gg: ASbGncui/jrB3zqZfA1EJgdL1Op4nBb3uGYXyN7yDSjyr4t5Z2SAw73G01NZ0fthhMm
	uC47ghSfqNpQh8nAtLkj17P5XLLQPe2jhwJtPP6rvMUiO86XIo5lI22LvONw0Fkzf7g3pZoVcyb
	aCGICs69JzNMIa8i2WKrlexwo8B18ekJs/zYEvdOfk5cDE99bTT0p9tTBuwxQOvx8qtCO3Iac7G
	8/vv9IS5ay/JdijDibICSdxxFlI5NVbV4VXmPX+rYlYFP8fCXIqvEnP4eBnkdVTkhNOkWJEVrXB
	/E1BKrDM+aXQIkfFW7SS1XhPnqCKai8bqfDJhgSgwRHc57oAIA==
X-Google-Smtp-Source: AGHT+IGXEKJnubZ7beEaQJblRyNzWfu8E4pvqMGMNr0AwK4lFXVVSq9+04lNS3pnIjDVm8/5AwunAQ==
X-Received: by 2002:a05:6000:2dc9:b0:3a4:eeeb:7e79 with SMTP id ffacd0b85a97d-3a5319a96admr170386f8f.12.1749155614180;
        Thu, 05 Jun 2025 13:33:34 -0700 (PDT)
Received: from skbuf ([86.127.125.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209cf9715sm3554475e9.18.2025.06.05.13.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 13:33:33 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:33:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: fix untagged traffic sent via cpu
 tagged with VID 0
Message-ID: <20250605203331.twof2p2orvuxwuzt@skbuf>
References: <20250602194914.1011890-1-jonas.gorski@gmail.com>
 <20250605202043.ivkjlwtvzi6jqhqx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605202043.ivkjlwtvzi6jqhqx@skbuf>

On Thu, Jun 05, 2025 at 11:20:43PM +0300, Vladimir Oltean wrote:
> Testing both on sja1105, as well as on veth using software bridging, the
> answer should be "tagged with VID 2". However, you make it sounds like
> the answer on b53 is "untagged".

Sorry, some neurons misfired. I don't expect the b53 answer to be
anything other than "tagged with VID 2". The bridge passes the skb as
tagged with VID 2 already.

Only if the bridge port VLAN 2 were egress-untagged, would the skb be
coming to ndo_start_xmit() as VLAN-untagged. Then it would be processed
in VID 2 in software, and in VID 0 in hardware. But the fact that VID 2
is egress-untagged in software just like VID 0 is egress-untagged in
hardware will mask that. That would only potentially matter for source
address learning, which I'm not sure whether it exists on CPU-injected
packets on b53.

