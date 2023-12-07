Return-Path: <netdev+bounces-55098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C38809563
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C02F2820F5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631A56450;
	Thu,  7 Dec 2023 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSP0AOoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F43BA
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 14:31:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf26f8988so1638490e87.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 14:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701988306; x=1702593106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOpvr3t7gHDSoxt60OcMkBx8htFsJsLWI4Zw5MhXpXk=;
        b=mSP0AOoJqRJow4a5IpyhXyewwyXr3iM+4M+gVw0CPHJrE7C5/K62v21MOZfZ3B9eJH
         dgzoVPWe3I0LbRABUB2WfSK5NpGYmcKtDyEwjaxtMPi7BEM89Y3C6Tc0kkWctTwLVSgD
         6wjhSRe8hUmHti7vsTBn+ZLOOBn/vkUhrwoT+TOE/FlLo4K3NhLmmNZLgZUGfqlCZcOu
         zmCNzbfAjkWogJlseNULWVoR/xGF/sMSlBQ20HFE+ck8eNOnaJ4UPAGjEdsC+pkVa9+c
         2Mq08UsKNB3Sz5sMSQW6FwWd8SkEum2iGZPOS+7s6laotWOab4KsVPYJllYpLLqj7Oql
         eSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701988306; x=1702593106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOpvr3t7gHDSoxt60OcMkBx8htFsJsLWI4Zw5MhXpXk=;
        b=cQl90zcQs1DAtgFSY9MdFK1IDs+KpkeL8qB4/QZkSa/MNFcIBxTLpAb5PCO0K66mOF
         nOf3GsmF8drNEKzPqBe3ZtCLUpgNEjy9gzR6qL3D4My2fB0yDQlsHs+oNYssEh+ruz1c
         b/pWqdnxgHOYZhD9H+mJqg8ElEitMuR1uMbIlZMLN2N50zJL3SPvg6cydsJzCt5i8Nfs
         jA9mBv0XUBjfAYwaKieGO86Cv5lmra1LCdx6xLEBSKxCaMBpzZcZShJ/EapEkgycbgXo
         o7UBrJ//IaWPRmI+NdPkGu76lJR6R7+UO7ZWj/4wyyEhqctArbSiZnbNiO3gYMn5Wj0s
         KDXQ==
X-Gm-Message-State: AOJu0Yxn8g6ODwgnBFb+ZYERex7ETUpZEFZVW3yb3YFfOctP2WJtjYC0
	B9aSJ+b4d8+ZrKI0ddpZSkg=
X-Google-Smtp-Source: AGHT+IGJe3Bxvj4PdoO5pGAQA0Ivc492yi9j554+7ce+sYwSicTl56RCzKF6GMWUuQ8EsfQgNApw+w==
X-Received: by 2002:a05:6512:308c:b0:50b:eab7:40f0 with SMTP id z12-20020a056512308c00b0050beab740f0mr2971204lfd.98.1701988305749;
        Thu, 07 Dec 2023 14:31:45 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id u16-20020a50c050000000b0054d486674d8sm274410edd.45.2023.12.07.14.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:31:45 -0800 (PST)
Date: Fri, 8 Dec 2023 00:31:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Message-ID: <20231207223143.doivjphfgs4sfvx6@skbuf>
References: <20231120134818.e2k673xsjec5scy5@skbuf>
 <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org>
 <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>
 <20231207171941.dhgch5fs6mmke7v7@skbuf>
 <CAJq09z7j_gNbUcYDWXjzUNAXat-+EyryFJFEqpVG-jPcY4ZmmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z7j_gNbUcYDWXjzUNAXat-+EyryFJFEqpVG-jPcY4ZmmQ@mail.gmail.com>

On Thu, Dec 07, 2023 at 04:50:12PM -0300, Luiz Angelo Daros de Luca wrote:
> HI Vladmir,
> 
> We discussed something about that in the past:
> 
> https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/#m04e6cf7d0c1f18b02c2bf40266ada915b1f02f3d
> 
> The code is able to handle only a single node and binding docs say it
> should be named "mdio". The compatible string wasn't a requirement
> since the beginning and I don't think it is worth it to rename the
> compatible string. I suggest we simply switch to
> of_get_child_by_name() and look for a node named "mdio". If that node
> is not found, we can still look for the old compatible string
> (backwards compatibility) and probably warn the "user" (targeting not
> the end-user but the one creating the DT for a new device).
> 
> I don't know how to handle the binding docs as the compatible string
> is still a requirement for older kernel versions. Is it ok to update
> the device-tree bindings docs in such a way it would break old
> drivers? Or should we keep it there until the last LTS kernel
> requiring it reaches EOL? As device-tree bindings docs should not
> consider how the driver was implemented, I think it would be strange
> to have a note like "required by kernel up to 6.x".
> 
> Regards,
> 
> Luiz

And did you ever answer this question?

"And why do you even need to remove the compatible string from the MDIO
node, can't you just ignore it, does it bother you in any way?"

I'm very confused as to what you're after.

