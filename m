Return-Path: <netdev+bounces-97771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E98CD163
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA768283579
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46497148821;
	Thu, 23 May 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQtfHYLz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2811487D5
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464406; cv=none; b=YkjJBqA8ibPqXBX0aLewRPL5k2YBifn66J0dqVd7m9xeFep9wZVtOHMxMzkH0A1jSqfWPWi6/FoOxlhOCq0dYwbCjxg8wBLGhoVNgpToHdXNFYuGAAFeUwNOFk8AuyPRoAW0dAxYRC7xpdnVChjQwBAkDrQM1dFzNBF0KGUCNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464406; c=relaxed/simple;
	bh=3Ot8NX5u/VW3dZyape2AJCneAcQ+mFjAStVsHHU2mMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtkPmF+bnvKccBtj0x7y1ok4gKSUVOR64E79T+gvtJ++WuyLJmefW8BWCSvs00P6iA5KWw6az0uCDlKQXnCA+rBmGy+G0xLSbsqyHIaSgwcKMTkfED9a8W/9mwvmWBNUoYdY+Jh84JrC53KVsoDbHBIu2kQUnd/oS1+H4MtQnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQtfHYLz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716464403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h1zk6+MI0C8qkZdbgMNFIizBbAyZu4SmcNmoYwYKURA=;
	b=NQtfHYLzHQUx7tUQjI7kzQd6DGaqdBsAcQjUFxMATV2PBz9nMayfGlWfqir8T5QRwVuNe/
	iP9gaRtt/M/6jxL8fyNBKVxbMzuFbhYIHfVKNSaxfK+XKzG7rb2605ArC74Frv8TyW48nm
	JTm3Jws7/hg6DgtMPIA3r2xBKftpwn8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-OEDDrtNxPcm2dTD-oAL61g-1; Thu, 23 May 2024 07:40:02 -0400
X-MC-Unique: OEDDrtNxPcm2dTD-oAL61g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354f26c3379so208301f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 04:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464401; x=1717069201;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1zk6+MI0C8qkZdbgMNFIizBbAyZu4SmcNmoYwYKURA=;
        b=Bwtg4THliZPIbNIdNTHa3OLldr4gUDW0nI15fDAXggvyq8fRSG9lPJZEE3H3mZHdKV
         +43NzkRNts4jP1W9XvpSD/Ppe5z+vPOVl0IpzA+B+AP+YaEesA1x4WFB6j1SCGGHTYWq
         c+wo4SP+zcsueTZt+sxFksj6O9OCPB9NBNhkz5xdIQmcjDUmKLzyilGWhlh9du+LeWk+
         GfJh4rD7PHYFmWD7hn7dyR7kBm+7zz9jWLdWKtN/B7AA1SL0t3KlS02JHQed+es18Lhe
         LZSY1AeiNd7gR49qD00Lx4KmQpeae9mFPaXqRQR/wTn4yDoFzMGyv7GlQIOEcuYwRBsV
         kDOg==
X-Forwarded-Encrypted: i=1; AJvYcCXuOUB+9Xen128YqueRcZCxIKZ2O7by7EdfgmUk3MKrKRksa7N34VouiL9+cYvKlVZDRbbJTPbneLfXvf43zshTawdAXtIa
X-Gm-Message-State: AOJu0YyoKgVnPkQPqdTU5M8wTeJ33YeKm5gBavhAvVLYTzHUQgA2/UUt
	dqzkn98vo6DjPyW5+V9DiXBRYyZP4Bo1TeT6nvgMFVakkLUukWBGb1d6gWY8tyviJZTl2Xq92oo
	5F533JwoBac6JxnWpQOWaJyaUGdJ+ryQIhiYonS3S4Z9qN7xzUpCdow==
X-Received: by 2002:a05:600c:1f93:b0:418:ef65:4b11 with SMTP id 5b1f17b1804b1-420fd364485mr37648425e9.2.1716464401271;
        Thu, 23 May 2024 04:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGeWr/2kAUv48OpDEB3HGmXWRLWpKjlA7BEP5RkJ8VQ80zrQnMEI+3Khb+2AhPBk2eUV40lQ==
X-Received: by 2002:a05:600c:1f93:b0:418:ef65:4b11 with SMTP id 5b1f17b1804b1-420fd364485mr37648165e9.2.1716464400842;
        Thu, 23 May 2024 04:40:00 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fa4079sm22976825e9.32.2024.05.23.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:40:00 -0700 (PDT)
Message-ID: <da5658565bc28f1d9d7cc49bf31dce7e77b7982d.camel@redhat.com>
Subject: Re: [PATCH 01/13] dt-bindings: net: rockchip-dwmac: Fix
 rockchip,rk3308-gmac compatible
From: Paolo Abeni <pabeni@redhat.com>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>,  Jose Abreu <joabreu@synopsys.com>, Tobias
 Schramm <t.schramm@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Thu, 23 May 2024 13:39:58 +0200
In-Reply-To: <2389630.NG923GbCHz@diego>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
	 <20240521211029.1236094-2-jonas@kwiboo.se> <2389630.NG923GbCHz@diego>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 23:34 +0200, Heiko St=C3=BCbner wrote:
> Am Dienstag, 21. Mai 2024, 23:10:04 CEST schrieb Jonas Karlman:
> > Schema validation using rockchip,rk3308-gmac compatible fails with:
> >=20
> >   ethernet@ff4e0000: compatible: ['rockchip,rk3308-gmac'] does not cont=
ain items matching the given schema
> >         from schema $id: http://devicetree.org/schemas/net/rockchip-dwm=
ac.yaml#
> >   ethernet@ff4e0000: Unevaluated properties are not allowed ('interrupt=
-names', 'interrupts', 'phy-mode',
> >                      'reg', 'reset-names', 'resets', 'snps,reset-active=
-low', 'snps,reset-delays-us',
> >                      'snps,reset-gpio' were unexpected)
> >         from schema $id: http://devicetree.org/schemas/net/rockchip-dwm=
ac.yaml#
> >=20
> > Add rockchip,rk3308-gmac to snps,dwmac.yaml to fix DT schema validation=
.
> >=20
> > Fixes: 2cc8c910f515 ("dt-bindings: net: rockchip-dwmac: add rk3308 gmac=
 compatible")
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> I'm not sure how the network tree works these days, but this patch is the
> only one that should go through the network tree.

It looks like the rest of the series has no dependency and will be
merged
via other trees.

If so, I think it would be cleaner if you could submit this patch
individually to the net tree, including the target tree 'net' into the
subj.=C2=A0

That will trigger successfully our CI - that currently does little for
DT changes but still more then nothing and things could improve in the
future.

Thanks,

Paolo


