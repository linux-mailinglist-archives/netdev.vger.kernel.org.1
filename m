Return-Path: <netdev+bounces-183146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6547CA8B291
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466D83A543C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29522DF96;
	Wed, 16 Apr 2025 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDNCtzf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946818C03F;
	Wed, 16 Apr 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789648; cv=none; b=SupOab8Iqd2o/PJm2/IzbcEQJSht47VCjfbzzod0Nb8L33SVRfpMElI4zMJRU9uA3jumsKORkbHFMx2wZKAvzo6qXk4oipbA5MMQlx39ThCOKoTHpKlc5UGjoJ7R1vYJcQJRRsTlLB3VoxX/BS/GOSUYfrxI5heE3UxvTN4aMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789648; c=relaxed/simple;
	bh=+aK7VwUgzlHBYFwskORp/vcOjArc41p9ulC7hT1Rb2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmyuL8vC5S/zD5LzJDTGsyc/f6LPIDvihiqtao4vh1Ry36Wn4IlbsZe73rNIVW5EQDJDHawoQ9IHja1SVxAo0qevWuck2ANXPeCo4WOqSNPRdH1Gc3ZtAbr5/DG18hYN1eV1T8Z6hDAbIc9M9oYJkgROIdZV1MTxN09n5RgWs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDNCtzf6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so10788873a12.1;
        Wed, 16 Apr 2025 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744789645; x=1745394445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnmYoRkzfxz/puh5JdgYh8xFfsxdlpS9stminDS1YAI=;
        b=cDNCtzf6n/BLpqB+50pfJ6+atmbw2cDFOkAFZtMs0VOtYl+1Ri1srrbZpyibeUXuAe
         L8NYfCeodbK7hlSaS0GIES7jT8HRYktY8myyaYDfUeJlHFevAyAExNsDQCYwnRSqrHSe
         ciznA5aB6Ckic5GZ8wTdLogXNwNo1vihzTl2WY1GK96gY24u3aAdb8oMZZv9OQY4KbdL
         6OVRRW1YKSbo9tlQ7ARybh1jRAprFEH0jiB19UZ8wxCIzp5rvxY1B0ys2pC4coqFwQQY
         MN5utHjZ2NRNlAZOlGX7apmWI4YkD2jBh9uYxPpSDUdYimLK3+TBWuPdkDTQ8/bXoQMf
         D2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744789645; x=1745394445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnmYoRkzfxz/puh5JdgYh8xFfsxdlpS9stminDS1YAI=;
        b=I4jlWAVlfgmeDA96li5fJoVHshEygMr2KVqmkHi4d5jEmgzl8Z9rGBeBj0KQYLpwvb
         oS09jdFgSDCyHib0Xkv2RcOit3NIDXzuZaKOTy8jTxkW+ECtiQyeBiF6D72b1bFwRlgr
         Q+0MHFcMcPX4eWU7tSeAp/V+erD+GnhnK1Tl1WHiIIepYpp0qVO792oQQa+Dl+Xan/+p
         N3AA8uiUKJnrq4oz8bx7MAQnUEobDTu8L9KtT6A/lODVEk6Z2yOgW/5nrhrJTQ/St9N4
         xYDyT/lyT7CzZr144sUWOJ9RO8oheGQtcnkTSXzpRA9MfyYtWux893rnKOWUF6u2kaxv
         W1vg==
X-Forwarded-Encrypted: i=1; AJvYcCU9BEmX6W5f1MVEOp8Yrl2CPD7FFZybKNCIec+04nk/QXvZn6UQY/3Wmml7bBYruQ1hBWPXyijv+NOS@vger.kernel.org, AJvYcCVImKHcMBziPVgUJpYp05v4LF3LNia9yB2MpLmD2TQoO+u3BCxx6TZha7S4qsbJ/nj/w30A1B8k@vger.kernel.org, AJvYcCWSrE4TcTq9y8m11f2jTPb/rBBaxaQ9krgTBfwSHlE7rymlQA4I7o7mayd+F4dkayA6asRXIyZ7BUjJpqQc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oDUMhHPpWouSkw0LiIDyyL2Dx0QO1qmGPpBEGX0+I5U7oUgq
	4emulOm/uQ9DOJTYlxn6I2A+X1D4OMics/MHIkuyEvARcwHpAu0I
X-Gm-Gg: ASbGncu0Pq9w01bJuCPyO1tkjI5/DwxLPyzfHYK/44x59yc9f0jX6BpDdCDjeyieRfF
	XzUZCtEseVE+qLRWYIIyq++J66vT1EXfufXAFlNwdkdNkHBdoElOv12jq3ziTnFaeeFAmJ1z/HH
	SccK4DJtAKQLzgzmxXN61DXRy/oxCQYjrltw3pKF4C50xT2I/wSs99HlpY8DyZnpXmHbf3nd/8S
	8FdDZ7yAJMxMYeyZiHXCGU4rqEOLs0AYfZXkyh9WkkdKfGdY4RG35aVHHc0rzvb5SLjoFnSh1Xe
	dpGT2bJUXBVR7WRU6MKZFXJ3pgXcOhMgyAp6BPod1Yv9c/rDeXT3NB90zp2dVEPo9gt60Q==
X-Google-Smtp-Source: AGHT+IE4wZAAuWbgh94amq9c4VWINUMCA2nvDxELJOL9xH3ncpbcFzGL7F4tzZoeBmUHByL6j7mvpQ==
X-Received: by 2002:a17:907:a08a:b0:abf:4c82:22b1 with SMTP id a640c23a62f3a-acb429c24b1mr63690466b.32.1744789644539;
        Wed, 16 Apr 2025 00:47:24 -0700 (PDT)
Received: from legfed1 (lis01.vpn.liebherr.com. [193.27.220.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54d8fsm8074206a12.12.2025.04.16.00.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 00:47:24 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:47:22 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"Fedrau Dimitri (LED)" <Dimitri.Fedrau@liebherr.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Message-ID: <20250416074722.GA17235@legfed1>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
 <7dbf8923-ac78-47b8-8b9c-8f511a40dfa3@lunn.ch>
 <DB8P192MB0838E18B78149B3EC1E0F168F3B52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>
 <04dc2856-f717-4d27-9e5c-5374bb01a322@lunn.ch>
 <20250408171831.GA4828@debian>
 <20250411150448.GA3236749-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411150448.GA3236749-robh@kernel.org>

Am Fri, Apr 11, 2025 at 10:04:48AM -0500 schrieb Rob Herring:
> On Tue, Apr 08, 2025 at 07:18:31PM +0200, Dimitri Fedrau wrote:
> > On Tue, Apr 08, 2025 at 03:28:32PM +0200, Andrew Lunn wrote:
> > > On Tue, Apr 08, 2025 at 01:01:17PM +0000, Fedrau Dimitri (LED) wrote:
> > > > -----Ursprüngliche Nachricht-----
> > > > Von: Andrew Lunn <andrew@lunn.ch> 
> > > > Gesendet: Dienstag, 8. April 2025 14:47
> > > > An: Fedrau Dimitri (LED) <dimitri.fedrau@liebherr.com>
> > > > Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > Betreff: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for changing the MAC termination
> > > > 
> > > > > > +static const u32 mac_termination[] = {
> > > > > > +	99, 91, 84, 78, 73, 69, 65, 61, 58, 55, 53, 50, 48, 46, 44, 43,
> > > > > 
> > > > > Please add this list to the binding.
> > > > 
> > > > Add this list to "ti,dp83822.yaml" ?
> > > 
> > > Yes please. Ideally we want the DT validation tools to pick up invalid
> > > values before they reach the kernel.
> > >
> > Ok, but then I would have to add "mac-termination-ohms" property to
> > "ti,dp83822.yaml" as well together with the allowed values ? Ending up in
> > some sort of duplication, because the property is already defined in
> > "ethernet-phy.yaml". Is this the right way to do it ?
> 
> It is not duplication because you are adding constraints. I was thinking 
> the definition in ethernet-phy.yaml should have some logical limit. Say
> 200 ohms as termination resistance is typically 10s of ohms. 
> 
> Seems like a long list to define to me, but if the driver is going to 
> reject unknown values it makes sense. You could also make the driver 
> just pick the closest match rather than require an exact match. 
> Resistance values are nominal anyways.
>
Will add the logical limit into ethernet-phy.yaml and add the table with
the allowed values into ti,dp83822.yaml.

