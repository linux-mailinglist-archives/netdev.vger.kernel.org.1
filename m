Return-Path: <netdev+bounces-165667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690DA32F86
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79B01889B98
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22826157C;
	Wed, 12 Feb 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqIkzzvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758B1D516D;
	Wed, 12 Feb 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388155; cv=none; b=koTllMfPiaWG3WLxhA8uF878JwcF037RnI6dw8YsWNHwMsvavxmKVYgVh/uppNOPbcB3Vgv6PwHy1Ce6ugnLIbfdNZu5+K/97PUFSCrQQLJouqGXYuoyu1/h+Ivs35ieFmL64bVVU7O6PaYNNowaG3qnYP/nR1TY8swkWqvbbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388155; c=relaxed/simple;
	bh=MOMRWX7y66bw+itcznoCfyFl4Dbwv4Trr49Qlu/x+h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSES3dSczzZG/wxGsm/JMJXK3O6v+o6zdmTZ4Y3d5hNJor4xmmmqpIYFp+R7brwrU+hVxIJYnDMCHzxGgpHtgoGk5VXRUJyKhNrXQBHvqujZZyGYgyKXu+j12ay3uuU7MJ4I8/J9onka850FP4kAC37Mf/fHjkM0qA8+jQoJPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqIkzzvG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7d583d2afso220867566b.0;
        Wed, 12 Feb 2025 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388152; x=1739992952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPC+JXoeDesx1/m8YBY1xFOPYCWwxZOG9abJwGiSBcw=;
        b=EqIkzzvGBZJmQN0qqZEvYZHoEb7zKpGPT6vduY5xVr8C2yRxlSAX3uPtLHYmRXE462
         mVTn7jbnysp2VeicSemAFpdoF9cH33+Tf176Frf/u8bcaLo+0im09DiOs4eOzUJc4QL8
         O/906Q4nD90wsrlve0Qbe1L3UXigb/fKO7hzHpvkFAI4TdtbrdCz51+JV/jQqIlcI7TZ
         fCQsCPY79ZxgOf3I2Ohtmoi1R1BBfg0j/mK3pKQZjo6di6Ghmc0BG814TwkOEYnipran
         36b4QG2y5mvIUvUj/6XiH3myUb67ycJq5O92+JB1arH244oHAMJqaAPO9+x5oKD4rx79
         J8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388152; x=1739992952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPC+JXoeDesx1/m8YBY1xFOPYCWwxZOG9abJwGiSBcw=;
        b=pMZvdp2Q2MqSU2WmCNcAWLOh7YiWZgFaD7M93jHvn8Dp/nufhaBGZYmyvv5ZNyDRna
         1A1GBkMel9TEzT0Q70jeOfxXtcIebq+y4AzObS0Zq9tOjyjsSo6MlgyosuaLqBpVVgXw
         zSrDxG35inbSQgyyeW2mFshLpV4nhCbC1b/4GXSlgKB/2yi2jKwESt8dihyk12zpPFMQ
         MJziAOaTgG602QluQ9kj7im+TXZVL3nyiOCV/L2RzFbu+wk3iYyBkBJ8GUIklJy2j838
         JmYF0Tms8ltlFf++5e1bP/q162VDDqb8lECes8UFdCoE57TaaPi+awe9zvE/hqXofVSc
         E9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVjBcsZEeJ2Ik/Ka8URDuT0gw04UEU6EEujAfIeHDYqw5p4f1qr34X8Z+q4uDui72zJYDqqwDoThjjKyBzr@vger.kernel.org, AJvYcCWZ3Mj/x7A9KvoM3oU3i2PqvmCpnEFzpWyFgqlde6V6YVqHs981THFhqWFCBfJssC4V5d/v3CGd@vger.kernel.org, AJvYcCXkfOS3PrWkpyz+D8Sro1sve6o9n8bHSj2gwd0kSfnz8cp2xzN7xioNQ8goXvUWPPOsu2bQJgv4EUc1@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKeu7ftFw7VpR1ijTTmkwVJ98Gqb27yauYHLxsugNjwfZMRGC
	89lR7N/PSNYhpz/zkfIjlHqrvCCiFjVurCwomtuM5vqfkkuB46XNlbeQ0g==
X-Gm-Gg: ASbGncvpokOoX4ryCag5/eKE3r9lF3LOWWmV69EwTiRpUs3T57qNImLB1MDTyNiPd45
	MTxO5LZ0HDCt4DGXHjgAW91kIp2jsFMMKLQA6rkvhqDTKrYl+pH9ARcbDQdqkgfmZ8Qj29CIOMV
	sLjhVZ/S2bylYc8wURdLIvK4aFh235HPOqOBytdUASi6NlfYH/LKOY8JbxOemdvDGxiKDw8BnBT
	RvC6dAd1R56fwgrbf/oMuEMQL140wzDguBQ9ib61Iz1AiN1zOmddQvHpewdLO34TjL9TNkshERE
	gVNTVYUBxqta
X-Google-Smtp-Source: AGHT+IF6FvFixqQDKBbekS+Cxre95GuzWINzpClT2uCUry35eAQuSer0gT13FlTqNY5wWkJuAiI38g==
X-Received: by 2002:a17:906:6a0d:b0:ab7:cf7c:f9ed with SMTP id a640c23a62f3a-aba510de33fmr10610766b.24.1739388151696;
        Wed, 12 Feb 2025 11:22:31 -0800 (PST)
Received: from debian ([2a00:79c0:659:fd00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e8050dd2sm338040966b.136.2025.02.12.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:22:31 -0800 (PST)
Date: Wed, 12 Feb 2025 20:22:28 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <20250212192228.GA4383@debian>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
 <b60f286a-75c8-4b60-9707-6d834fd4d3ad@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60f286a-75c8-4b60-9707-6d834fd4d3ad@lunn.ch>

Am Wed, Feb 12, 2025 at 02:04:02PM +0100 schrieb Andrew Lunn:
> On Tue, Feb 11, 2025 at 09:33:47AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Add property tx-amplitude-100base-tx-percent in the device tree bindings
> > for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> > necessary to compensate losses on the PCB and connector, so the voltages
> > measured on the RJ45 pins are conforming.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index 2c71454ae8e362e7032e44712949e12da6826070..e0c001f1690c1eb9b0386438f2d5558fd8c94eca 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -232,6 +232,12 @@ properties:
> >        PHY's that have configurable TX internal delays. If this property is
> >        present then the PHY applies the TX delay.
> >  
> > +  tx-amplitude-100base-tx-percent:
> > +    description:
> > +      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
> > +      default will be left as is.
> > +    default: 100
> 
> Doesn't having a default statement contradict the text? Maybe the
> bootloader has set it to 110%, the text suggests it will be left at
> that, but the default value of 100 means it will get set back to 100%?
>
You are right, will remove the default statement.

> What do your driver changes actually do?

Only if tx-amplitude-100base-tx-percent is present, the amplitude should
be changed.

Best regards,
Dimitri Fedrau

