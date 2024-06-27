Return-Path: <netdev+bounces-107432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498E91AF65
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C36283D49
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0819AA55;
	Thu, 27 Jun 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flFAOU3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB985360;
	Thu, 27 Jun 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514996; cv=none; b=Y+o3VCwfqHnoozHZ+niRfNiZBnA+akIQX4LMi3asAXB0pRqL3M97hcYyE+t/IxmmdeLJV9MqDoZWqiRoLQ4GNc4Fnoqgd9bt4NzH+10aaQASr8+iHV+P5NvxPZP2QNOHcC1YUcAN9EuQgWAY0v9IxrxUH6ZSpoFl5Fp2yk0EnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514996; c=relaxed/simple;
	bh=s4oEpDuEzHamdfCowVPpqqZfwSmm25BkIYA5zE16y/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNCxdVrY2/uncIBrDDCDkNBb9ZAmxwkP+2YM1q+xL8svpYbA36ciK0YqWh+W9zmvc/yhnibCnno9wXr2l+Q5KDVr+CKyefMSwXEzRxhkj2pXu79ds3jcCAI9HWY6HLCYxbRQOcY32DJUXCikc9kRMypRWKNZRnLX52QvyJPGlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flFAOU3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35677C2BD10;
	Thu, 27 Jun 2024 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719514996;
	bh=s4oEpDuEzHamdfCowVPpqqZfwSmm25BkIYA5zE16y/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=flFAOU3mB4XigsWmmjauBMrKEBDeX1+nlGJuXL/zzNIjrrR8INDJFGHsOlpxGYL6c
	 HkJXVLBdyPfhfYZkeyxZ+ZHDjJ2A3PlidM/rUi02WuqEmqbv3vMi3nSGiTKneEmPG3
	 tvrM3pY8oH5W1GNqYmBHdKOarQGFHcHIOcxl11ZRa/8V3QBWrIoUsbG5TQsL7gZd36
	 w7mxcRkJHayxAQQZZuZdBCEF5L++ry71qHbTO/V/NLmteS1q3CrIi7WkohJ4RYnRq7
	 gHtrPMriQ7oBodIg1RXydoLFmJmtx1D4nH9JZ5KcGSMLGn03FR+wBpRKu7T2bi6YLo
	 RcD5HI1ktx0zQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso66403801fa.1;
        Thu, 27 Jun 2024 12:03:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPe/Vn3VDzxTwK0h3FlRbFsHBWV87KHrsb8N5wRaiX6sk7EfPMTefDBfBrCFz9/Aao2ZqvrVzadnSbXFOXDwoxwu65wT/NvdBRZE4OYBJ0ZiAkcKt5MC6h5BsGlqn9WbpedCgLwl0qZ7TmwfF1AB0ukodntefj0zchiZB2HPZvZA==
X-Gm-Message-State: AOJu0YyHX8pXalzqBKN+5y5aXX9b2cy7ajhQudLSXvzvUdTHBfd+kI4U
	PHeBQEfKNEmgW0BXe/WjkQ1Y8BPnHKCt2UJ1MM09cEOrmEHDbUSIW/HjuC49ay/mEsgbHszEb5F
	wnnjtQWpfgeSGUjEyoSCeo1TePA==
X-Google-Smtp-Source: AGHT+IERpqYkHVSBMBLutpKK8Ckx8P+bb/s9EpxdS6FVvg+rabR/H1UO1yWL4pgy8bPuumt8TnDS170ObiA6rFOR7/k=
X-Received: by 2002:ac2:54a8:0:b0:52c:da18:6187 with SMTP id
 2adb3069b0e04-52ce185d05fmr10828916e87.43.1719514994561; Thu, 27 Jun 2024
 12:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625215442.190557-2-robh@kernel.org> <gr7rgy7cptnpj2rkeufhgqkve4ytqddpts6gdekeszoq7znwf2@ivyjpaiyxruk>
In-Reply-To: <gr7rgy7cptnpj2rkeufhgqkve4ytqddpts6gdekeszoq7znwf2@ivyjpaiyxruk>
From: Rob Herring <robh@kernel.org>
Date: Thu, 27 Jun 2024 13:03:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYHbr=Wqg-S0t_hK3uDATe9KKob9chFGFnoTcyt2ttyg@mail.gmail.com>
Message-ID: <CAL_JsqLYHbr=Wqg-S0t_hK3uDATe9KKob9chFGFnoTcyt2ttyg@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: Define properties at top-level
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:05=E2=80=AFAM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hi Rob
>
> On Tue, Jun 25, 2024 at 03:54:41PM -0600, Rob Herring (Arm) wrote:
> > Convention is DT schemas should define all properties at the top-level
> > and not inside of if/then schemas. That minimizes the if/then schemas
> > and is more future proof.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/net/mediatek,net.yaml |  28 +--
>
> >  .../devicetree/bindings/net/snps,dwmac.yaml   | 167 +++++++++---------
>
> For Synopsys DW MACs you can just move the PBL-properties constraints to
> the top-level schema part with no compatible-based conditional
> validation left. It's because the DMA PBL settings are available on all t=
he
> DW MAC IP-cores (DW MAC, DW GMAC, DW QoS Eth, DW XGMAC, DW XLGMAC).
> Moreover the STMMAC driver responsible for the DW MAC device handling
> parses the pbl* properties for all IP-cores irrespective from the
> device compatible string.

That's definitely better. Will still need the TSO flag part though,
really, who cares if someone wants to set that on h/w without TSO...

>
> Alternatively you can just merge in the attached patch, which BTW you
> have already reviewed sometime ago.

Can you send that to the list since it changed from the last version.

Rob

