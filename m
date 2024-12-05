Return-Path: <netdev+bounces-149511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EAD9E5EE8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 20:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780EC285F33
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FFA22E410;
	Thu,  5 Dec 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYMYxOgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF422E3F9;
	Thu,  5 Dec 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427399; cv=none; b=Zj5HftRvmUCr5LYCVy/meXKeYnkh+xChcV3V8lUNjLr/XEbzUGRL9wA62FcWWWbhBTSSPPLxWmCLn/E6Sy/sWSIoK32sRELCD7JTR3ijBSoeIEiu02+bmzyP2lg7FGVs45pjdhiCRAvhyQTkots4oQxIdnEQ5mW6TFUHiMUt4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427399; c=relaxed/simple;
	bh=tE1lqBbBbB5QTaTAST7hMGo2GEUPmBltSO9CWen59Dw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaJXIldjCzCGDvNK107H3Xkmcpsh6mqd+CZfHpM0rCr5aUNz/y7r+apyho+0k7LZyruBPzvY8fCIHo8LMFvfTGZl5HlULd6aT9Sy0unDnAiTjg61btODYrSkoyHeWDk8Gnh4GiYkzOijVNqaCuzff3jE2uFqeGVD1qvM0rNxvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYMYxOgp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so12799535e9.2;
        Thu, 05 Dec 2024 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733427396; x=1734032196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TJgt0q1XFsdzcWEuTvfZzx/PS2Wvx0jTJ2onrpygoeo=;
        b=MYMYxOgpmIm9jl2gzOWrRyboYXD9kTBYiBwUx8TMkFvSK8bhh6tWBvdEkxj6lDa5KL
         ehzkbWJqwBCAvN9jRkpFexalgVzoLn0Hxk7jNaUv1hY2+Ic/DPF1GWqfNYoQyFP0AaEK
         0n3gwWBXCrg3K0yZckAX0JnT/8YlNe1MkEUjCB07ivVazm8Y4epFkguQqDlzpEbEbpoU
         XbCsnHwu0SZ0YslXQVdmJ8Oa1Bxpp1wOk76bOQblwl+dLpyAwQVkRVUzBofbs3wq2Upp
         xtFzjZGDBkIQyiOSRihtQGE5aGroClEjss1NoVERw2eJ+GXgjBKCwqpWZme7yAvlLDqa
         z04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733427396; x=1734032196;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJgt0q1XFsdzcWEuTvfZzx/PS2Wvx0jTJ2onrpygoeo=;
        b=cPoXhK0Rmm0nx8LpUsmoXEALoNbyYssbxWNP9furNK0WrBLgmBgAcuOVODiXOYsyLt
         TPSVFe9JpOwpaKeBSrHdYB8Ld63yCG4fSWOkZSN6iPwZNM9NeOBXAKR9Mg0svhoEQew/
         5wwvmpZ1h8aOYfgM+j6Pks21Bh9tj49E8OtJurXOQH3OMyG+jyWoP3E109fLw4nEyPYS
         CjXAvYzslAAQ8cJmNk9Jiisywh6qdfyyek47fMQVZF1/QUKUNQ7FDHZwl1R8pYhJ4FMR
         jPvXtRR9QdHpTmH8ff6UA7KZqDcD6taeXB1JwOQ2d2bPej/9FNVqfMSqwqFW1XH4VNL9
         rTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxGeIFSV7MhgFKjpPywA41HeSQB5UfbiENIsMrZjDBDO5QErRHS0m7W7KJy06tvdyM19zYZ/AiUNaF@vger.kernel.org, AJvYcCWZAL9Mb2sRq3H5YYlwmg7RS7MWvPR9yJE8SHSoFZd8Y28/nIm2mxzpW3K1oLH6ro4ojD6l5Byf@vger.kernel.org, AJvYcCWqIEJZATLqzxza93J4cpqGzW8SkQtYat4m6zsu+nXBeCMHAm0vUNyhls+wxVwjZSKIoiRbLmO63A6ILpUl@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUqsO2rnlMuYBP65ChDWNbqvGAClkqqctahvHCBMFR4XnXiy8
	Wb25XgZekYUyq6tIDuFHmUNhPcMw+xB0TQCbceCSBR8jt6nx3hrr
X-Gm-Gg: ASbGncuGQdkQSoZh+/TffTe38go45CJyKGv9QZXndKbODI/Vwr0J2lL5/yG0hNYkzCM
	zC1H8nEiHMK0/OQY86mzMFtUEQfKvoSJvTyOREqnv1amZAMOf1Orq4nAqKr0RUgzz/78aWR4Ug6
	5ncGZjhhzP78OroOhFTLJbMp4WcpzVjMqAc/oK1/Q97lWFbogLGVvPIcIR1e/zzhxBxVu638RLj
	zctapN/BPj/6Gkika9iO2OjjUdLEWF419H6YAc+8gV4Rx64E28cI4rfUIdG4funoIZb6D+PIRd6
	51mo3Q==
X-Google-Smtp-Source: AGHT+IHCdi5TBjn3C2Fzikl0DE71EaVKFu10wCMrtdjXfxVyz+eSoEPxb+E0BJhugPJeysqSonLogA==
X-Received: by 2002:a05:600c:4686:b0:434:a7e3:db56 with SMTP id 5b1f17b1804b1-434ddeae575mr4123485e9.6.1733427395743;
        Thu, 05 Dec 2024 11:36:35 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0da461sm33743535e9.20.2024.12.05.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:36:35 -0800 (PST)
Message-ID: <675200c3.7b0a0220.236ac3.9edf@mx.google.com>
X-Google-Original-Message-ID: <Z1IAvoenir8XRMuU@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 20:36:30 +0100
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
References: <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
 <6751f125.5d0a0220.255b79.7be0@mx.google.com>
 <20241205185037.g6cqejgad5jamj7r@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205185037.g6cqejgad5jamj7r@skbuf>

On Thu, Dec 05, 2024 at 08:50:37PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 07:29:53PM +0100, Christian Marangi wrote:
> > Ohhhh ok, wasn't clear to me the MFD driver had to be placed in the mdio
> > node.
> > 
> > To make it clear this would be an implementation.
> > 
> > mdio_bus: mdio-bus {
> > 	#address-cells = <1>;
> > 	#size-cells = <0>;
> > 
> > 	...
> > 
> > 	mfd@1 {
> > 		compatible = "airoha,an8855-mfd";
> > 		reg = <1>;
> > 
> > 		nvmem_node {
> > 			...
> > 		};
> > 
> > 		switch_node {
> > 			...
> > 		};
> > 	};
> > };
> 
> I mean, I did mention Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
> in my initial reply, which has an example with exactly this layout...
> 
> > The difficulties I found (and maybe is very easy to solve and I'm
> > missing something here) is that switch and internal PHY port have the
> > same address and conflicts.
> > 
> > Switch will be at address 1 (or 2 3 4 5... every port can access switch
> > register with page 0x4)
> > 
> > DSA port 0 will be at address 1, that is already occupied by the switch.
> > 
> > Defining the DSA port node on the host MDIO bus works correctly for
> > every port but for port 0 (the one at address 1), the kernel complains
> > and is not init. (as it does conflict with the switch that is at the
> > same address) (can't remember the exact warning)
> 
> Can any of these MDIO addresses (switch or ports) be changed through registers?

No, it can only be changed the BASE address that change the address of
each port.

port 0 is base address
port 1 is base address + 1
port 2 is base address + 2...

> 
> I guess the non-hack solution would be to permit MDIO buses to have
> #size-cells = 1, and MDIO devices to acquire a range of the address
> space, rather than just one address. Though take this with a grain of
> salt, I have a lot more to learn.

I remember this was an idea when PHY Package API were proposed and was
rejected as we wanted PHY to be single reg.

> 
> If neither of those are options, in principle the hack with just
> selecting, randomly, one of the N internal PHY addresses as the central
> MDIO address should work equally fine regardless of whether we are
> talking about the DSA switch's MDIO address here, or the MFD device's
> MDIO address.
> 
> With MFD you still have the option of creating a fake MDIO controller
> child device, which has mdio-parent-bus = <&host_bus>, and redirecting
> all user port phy-handles to children of this bus. Since all regmap I/O
> of this fake MDIO bus goes to the MFD driver, you can implement there
> your hacks with page switching etc etc, and it should be equally
> safe.

I wonder if a node like this would be more consistent and descriptive?

mdio_bus: mdio-bus {
    #address-cells = <1>;
    #size-cells = <0>;

    ...

    mfd@1 {
            compatible = "airoha,an8855-mfd";
            reg = <1>;

            nvmem_node {
                    ...
            };

            switch_node {
                ports {
                        port@0 {
                                phy-handle = <&phy>;
                        };

                        port@1 {
                                phy-handle = <&phy_2>;
                        }
                };
            };

            phy: phy_node {

            };
    };

    phy_2: phy@2 {
        reg = <2>;
    }

    phy@3 {
        reg = <3>;
    }

    ..
};

No idea how to register that single phy in mfd... I guess a fake mdio is
needed anyway... What do you think of this node example? Or not worth it
and better have the fake MDIO with all the switch PHY in it?

-- 
	Ansuel

