Return-Path: <netdev+bounces-149527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E449E6186
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C21884F1C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44941D04A4;
	Thu,  5 Dec 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnTO+2Oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5849627;
	Thu,  5 Dec 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443039; cv=none; b=Opjw2rW6pdC9CFD5YTBY4jKls2urDxr3w5UJaJeE3cEnVSzTVEC8sXrvnN0O4kDMO5ZdkKhefVgSDfXRtcrwA063JkOrPL/qqZsXUuBxXHa+Pniir/nfFUA/0oM2VAa9M+pyZKpYUz5jlzJx1kAtf9g7FmqJdcBF1lXKxczgsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443039; c=relaxed/simple;
	bh=Gb9A7IbaXaNn0QmiSU5QWC6XaGim+k77cXLOs53GqPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWNoAXnQx+OwBpvOy/2WVe84dqSWsG0ZuCy/+o3psKk7IzMJNfZGLxRP2txqxdbjSYC6/Sg2K87ybXTbwo2dityDn8eA1N7oS5PK2zsxjBMc/qg/S+Q+DCecYSxDNSg/H8EYBJJttDAVRbQX4nnCFuGATPYVaY9O9I0qzP4on84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnTO+2Oj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa62e741fbaso17582666b.1;
        Thu, 05 Dec 2024 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733443035; x=1734047835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAo9cVc8wqzk5rP3Z3ruoyEUyVoOdbKhUC4uEqSh6TE=;
        b=hnTO+2OjxcQorQK+4/SnJh/Dk6oPhaRdCGzeF6KDTRS9OCCGW+ycGz13grEn5p6DeZ
         i3SYQrtMsNQzsxQ+T34Xl91ffJLK/+5sKlCwg3UpQdfaaDlPfJqSJf//f53oePjHGNpv
         xOtg0aAZ/v12mKz/Q3lutpViH2dBfsYJEXN6kJqX8QVyz4y6SG+CT90KvqxFjRQ4DFDQ
         nlpWhDt165BtYPTupS9zvfMs/Ua7Op2k+wnly3yojUcUhXzNitWNhvvwwJLNMAldqnFJ
         f/RSgSGypaGCEWIr/ybJN7vW2aXcElp6lYakPeUNZT4ACn/v1hXY1VUjtXNk7KNunBWp
         RWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443035; x=1734047835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAo9cVc8wqzk5rP3Z3ruoyEUyVoOdbKhUC4uEqSh6TE=;
        b=Gqb1w3bprxsrjFzoGMx1p2Ybu4a+XCw5qSRJeYHZzDSkduAnqOiWEEROvXCxGlnMbk
         yUz4rq5rPejEEt4BnnNEFGJlbtiy7kZKXf5T/Vi54wveIgM+nHiZ+pB5Obq1Oi8ZPhg5
         3kxCXhaLmTfm5agcsEJvbikKuzQ8pSrvdOBicLoyrpTKPLBdrNe6eqzA1Glyia5rdHl0
         zdCbekk6HIJ37NLxq/MgJ1GK2RuxRvJ2fjqAhuyWSnn3421UPh+UHY6VQmNXcKQ6XRuH
         qlpjvxqN79gd5GjgJvPvr/X67fWWqX/aioa1YuSJ4APy75ZIG8KDoxArl79mRUm3bvSo
         F/vA==
X-Forwarded-Encrypted: i=1; AJvYcCUnYtVdeuTvISaKHAl2fnH06r5goHnxWEODEM5IFjS/T4d97tkWdbMpxZpbJn9AyaRj64dODyNWdHPMDOSg@vger.kernel.org, AJvYcCXXldrefZ7w0MfLo3OM5Y4YTopNu/RJvHMrrl5nKcSoFi8DCLTywJzYF0cCpkeOETHZT9y5vdp2@vger.kernel.org, AJvYcCXhL0Rie1VCmM3SSHtNhd9etEqjeGfEOCCJekCJs8BLpGqpoWmlM53KzfiCjg/i0fRsYWlKdduTv+cO@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2cMY0OqhMe2LqcJepGgVDvgu8iLJI1NwxYNsUrkZpu8uw9S0
	2c6Lis4CREQom2tzM7tmehU7CYqWX6V0OI0jZB3Va0jS/o+8BXfq
X-Gm-Gg: ASbGncuI2OL/CX+3j8PfZ2zykIZ1PjmnvNV4KcbAqvDqVe0xvoNKb405YwBrRGjhMT3
	MZNGV3EzioHU4QJ2bW+L9tkwl/5tXVwySLKM7K9fH5KXmvTTnaFfuiu53guO7BpGG60kec++vye
	ke/2Py5o03jeLfVLonR08xYPUQrprHEqytUQN7tzr40nbvl8qmAbwdLjzlf7jqOZXLCFqtE6N5N
	gYSGvzYi0uZnBMNNWeXEYoi4eZyLdWPVPJJpYI=
X-Google-Smtp-Source: AGHT+IE7dUzMRW5X7ylWUaAfuLQLWmAdBw9QHxuByRnp2/sHxsnIHbysm9CaN6DPwjMSUukK5qW3ng==
X-Received: by 2002:a17:907:1819:b0:aa5:a36c:88f3 with SMTP id a640c23a62f3a-aa63a20039cmr24798866b.10.1733443034766;
        Thu, 05 Dec 2024 15:57:14 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4ed51sm155526866b.31.2024.12.05.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:57:13 -0800 (PST)
Date: Fri, 6 Dec 2024 01:57:09 +0200
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
Message-ID: <20241205235709.pa5shi7mh26cnjhn@skbuf>
References: <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
 <6751f125.5d0a0220.255b79.7be0@mx.google.com>
 <20241205185037.g6cqejgad5jamj7r@skbuf>
 <675200c3.7b0a0220.236ac3.9edf@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675200c3.7b0a0220.236ac3.9edf@mx.google.com>

On Thu, Dec 05, 2024 at 08:36:30PM +0100, Christian Marangi wrote:
> > I guess the non-hack solution would be to permit MDIO buses to have
> > #size-cells = 1, and MDIO devices to acquire a range of the address
> > space, rather than just one address. Though take this with a grain of
> > salt, I have a lot more to learn.
> 
> I remember this was an idea when PHY Package API were proposed and was
> rejected as we wanted PHY to be single reg.

Would that effort have helped with MDIO devices, in the way it was proposed?
Why did it die out?

> > If neither of those are options, in principle the hack with just
> > selecting, randomly, one of the N internal PHY addresses as the central
> > MDIO address should work equally fine regardless of whether we are
> > talking about the DSA switch's MDIO address here, or the MFD device's
> > MDIO address.
> > 
> > With MFD you still have the option of creating a fake MDIO controller
> > child device, which has mdio-parent-bus = <&host_bus>, and redirecting
> > all user port phy-handles to children of this bus. Since all regmap I/O
> > of this fake MDIO bus goes to the MFD driver, you can implement there
> > your hacks with page switching etc etc, and it should be equally
> > safe.
> 
> I wonder if a node like this would be more consistent and descriptive?
> 
> mdio_bus: mdio-bus {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     ...
> 
>     mfd@1 {
>             compatible = "airoha,an8855-mfd";
>             reg = <1>;
> 
>             nvmem_node {
>                     ...
>             };
> 
>             switch_node {
>                 ports {
>                         port@0 {
>                                 phy-handle = <&phy>;
>                         };
> 
>                         port@1 {
>                                 phy-handle = <&phy_2>;
>                         }
>                 };
>             };
> 
>             phy: phy_node {
> 
>             };
>     };
> 
>     phy_2: phy@2 {
>         reg = <2>;
>     }
> 
>     phy@3 {
>         reg = <3>;
>     }
> 
>     ..
> };
> 
> No idea how to register that single phy in mfd... I guess a fake mdio is
> needed anyway... What do you think of this node example? Or not worth it
> and better have the fake MDIO with all the switch PHY in it?

Could you work with something like this? dtc seems to swallow it without
any warnings...

mdio_bus: mdio {
        #address-cells = <1>;
        #size-cells = <0>;

        soc@1 {
                compatible = "airoha,an8855";
                reg = <1>, <2>, <3>, <4>;
                reg-names = "phy0", "phy1", "phy2", "phy3";

                nvmem {
                        compatible = "airoha,an8855-nvmem";
                };

                ethernet-switch {
                        compatible = "airoha,an8855-switch";

                        ethernet-ports {
                                #address-cells = <1>;
                                #size-cells = <0>;

                                ethernet-port@0 {
                                        reg = <0>;
                                        phy-handle = <&phy0>;
                                        phy-mode = "internal";
                                };

                                ethernet-port@1 {
                                        reg = <1>;
                                        phy-handle = <&phy1>;
                                        phy-mode = "internal";
                                };

                                ethernet-port@2 {
                                        reg = <2>;
                                        phy-handle = <&phy2>;
                                        phy-mode = "internal";
                                };

                                ethernet-port@3 {
                                        reg = <3>;
                                        phy-handle = <&phy3>;
                                        phy-mode = "internal";
                                };
                        };
                };

                mdio {
                        compatible = "airoha,an8855-mdio";
                        mdio-parent-bus = <&host_mdio>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        phy0: ethernet-phy@1 {
                                reg = <1>;
                        };

                        phy1: ethernet-phy@2 {
                                reg = <2>;
                        };

                        phy2: ethernet-phy@3 {
                                reg = <3>;
                        };

                        phy3: ethernet-phy@4 {
                                reg = <4>;
                        };
                };
        };
};

