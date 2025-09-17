Return-Path: <netdev+bounces-224043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78317B7FE37
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB52720706
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CE2E3705;
	Wed, 17 Sep 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXrXHs/g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02BA2E2F15
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118104; cv=none; b=nNSLLmRT8iUweR1YW+Q58oZs2mYymHZf+CLOsZltmEdxH/ShQYcQWUZSxp9aFncDJNqEtYhTJsotvGCZKO+LPIwDtBmlhlv6AZ+62vS/zSufnFCQQ1w4kt25TCS9DdYcXY8iTn5WDnoITBO6Z6gClP9AGnQngNpijYxp8v7hyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118104; c=relaxed/simple;
	bh=lXCWglnUt90yI4aRsoMOta6ojCYjUYZrQfBXDrQOyNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muvDcASslmhyCCGx2XqzehO76m80y1Yn1jPYxzIUox2rgXuK06hiRa8XWPiJcxMCmHYWo5/U/xKK755EVRtga4IwxMoo9yeeIr+P+Y4CIUJRr230eJ3zvZVwNb7au9liSr0bnEukqPHUaDyulEdLhcyIHXtpLdm3BquFmBAw6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXrXHs/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEE8C19422
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758118103;
	bh=lXCWglnUt90yI4aRsoMOta6ojCYjUYZrQfBXDrQOyNM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=KXrXHs/g1qw/613j5auhUt3GIPp/QsjHcbCOjwPwoByTRaQfe1HCwKpmUuEvRLM5P
	 ieAavHzuBLh5oRok+jpEDvm9ZuacjnuqhBa8cvZkI15sQsKj+m7VLNAXraT817uh3h
	 hKQZlNeEgDIhIMQbQ0+ezLdyb9KnqeC1GZrnxlYRZNTrP2NrXtihrDz0Q1Bu+tr9Y1
	 eMfCLYldKd/dveVkVrDggkTvfopSbs8uyofOjTe8UH9ftwYQMvOoDdEmxk2t0pQJ3U
	 AAejCD24iU+BEer8SCaDe5evgQp78RlAQ3LdRekoLNzURBMNRTvM6+d/TNxQMv1yn+
	 wuym0xuDm8ZSg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-351c164936eso53059821fa.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:08:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ4XuQEKGl4OWZcMsc5XuNTI5N9ZuB/B7ELH+hpLC79c0TgM5ckHxgPG+zKR5jkwC1ZkHO56Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIevjEuAGck7wxB2nRdA7CZg1/Mee1IacKrcnEhDDuEAVt9HHK
	pqRCw2qnI/NkJzYP1RMECmqSmxkkBW5Ew1ngL+pb4nmb5vGwOmQJpCS8z4U7jLBcX+WM9fMyjv+
	qNXtDp9Ve/h29qo7aTW3umORQMo/rudA=
X-Google-Smtp-Source: AGHT+IGqdaQ8C9lVtjuyq3Lst//zIEIlnNEWTnnZW0oeQInZavtI2ovFzZs+fzDjBgh6Oll2QYo+R+KbyOIjgKRKfDM=
X-Received: by 2002:a2e:a484:0:b0:338:7f3:a740 with SMTP id
 38308e7fff4ca-35f6093b1aamr6295401fa.7.1758118101743; Wed, 17 Sep 2025
 07:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913101349.3932677-3-wens@kernel.org> <20250917070020.728420-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250917070020.728420-1-amadeus@jmu.edu.cn>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 17 Sep 2025 22:08:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v640r+TwB7O+UAB9PehZ2FaXDjhVerK6j_CZ2+caJoJ9zA@mail.gmail.com>
X-Gm-Features: AS18NWACYa7boO8HaxahcwxNgufh9JCYIxjbMd7TaIvgTTRgZ9eVfnU6RZmksT8
Message-ID: <CAGb2v640r+TwB7O+UAB9PehZ2FaXDjhVerK6j_CZ2+caJoJ9zA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andre.przywara@arm.com, andrew+netdev@lunn.ch, conor+dt@kernel.org, 
	davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com, 
	jernej@kernel.org, krzk+dt@kernel.org, kuba@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	robh@kernel.org, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 17, 2025 at 3:00=E2=80=AFPM Chukun Pan <amadeus@jmu.edu.cn> wro=
te:
>
> Hi,
>
> I tested this on Radxa Cubie A5E and there seems to be a small issue:
>
> When VLAN_8021Q is enabled (CONFIG_VLAN_8021Q=3Dy), down the eth1 interfa=
ce:
>
> ~ # ifconfig eth1 down
> [   96.695463] dwmac-sun55i 4510000.ethernet eth1: Timeout accessing MAC_=
VLAN_Tag_Filter
> [   96.703356] dwmac-sun55i 4510000.ethernet eth1: failed to kill vid 008=
1/0
>
> Is this a known issue?

I don't have 802.1q enabled so I didn't see this.

Can you provide the base commit you applied the patches to?


Thanks
ChenYu

