Return-Path: <netdev+bounces-249788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE93D1DFF4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A641300D931
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBDA38A9D5;
	Wed, 14 Jan 2026 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak+wGUxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5C38F953
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385393; cv=none; b=CNnUhPYb76WSwixn6iAysc79uepkIVRJr6N6ok1VBU2aV8DV0qqYmrJW7qaDUZ6XeywuM8TCpRZOTzsXfDo9lWJLSr+80WbbTvnL9+kkEt6wrZ2/69AY+nsRd+ZT/rWQq3M+LSx2HZtpHwVMTrcXcwfev1QL5luvnM5T1w9i7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385393; c=relaxed/simple;
	bh=lglvua4EVlJZWWN+umJtgEFU1k93wWFTZGM2L08B1rA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKTw5LaEvoK89kz+yMlEJBg0/fdnAOGAfk7ZocidsK5Kuf7BumNnNwSkZC6AE7es1sGWVBdb1bkN5N6oxVMtn37vJjvukjn1ZzwZgt8RFhrM6TYa9HIQuIdyPlgAy7vCoRzGWidsaKAtz7IQRq05M9hT/lO8hWE4B7x8ksn8NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak+wGUxR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso6274085e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768385389; x=1768990189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uG9zT1M5JtL8PrqjGVTSA0LQwsZKFnwHyBL1SQPctlY=;
        b=Ak+wGUxRtAMhANd9GD2S7fBDxd/S2LaWkgelddZYIOcheH4Lco/1lkQqE+GRs8h877
         KhYkis0BsZMA8fmw1Coi8xNR5vy+OLeqWkY9FjgoB052ivNwaSqW5PI0O8/EBvN9KXRE
         IpErG78OPJJf7l1vB3qcMVb+nS0PPeMymvB3nyRQKTPbWCNu4YUxL0MTFE2AkxqAsixl
         l+TVo/CNqTVujHidMY1MBBF4//Gkusj/07pABU/SjDpso+YrYMjUEpQZS464gkdLt2D7
         mrn9NBJUeYOR95UuK13EF7vVNfG+qgFRzlYpiu3mUYhv/zQp41mBspilEP34yQvDSXbQ
         0VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385389; x=1768990189;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG9zT1M5JtL8PrqjGVTSA0LQwsZKFnwHyBL1SQPctlY=;
        b=mX+Xln3t0wbUriICdbOuwQF7rkdykwGqgijImLzNAL5uAHpFestUHplaxZoKsfvVAl
         oyd8JPOjtso6L7HJ5mnLEl4UumK9s/EWIX6jfE4YpJtcCDekWVHnsMeltWynSQQdMej6
         tGnj9tquxfm4YiFmXQL/QCifH/XMoa71xL9lbuTQwIBlZeLBzT81lPIEEMBCTCxRcEne
         UlR5rcMp4vQjL0Y+VQiFlzblU1E35jM1bjkZJX259A6FZ6KA4Zte7mNn51Ib9dm1WS02
         uVfkdKboO2IgJpzU2a4EIk7DmYuTmKP+RtSGcGRc5vJ7fy52iVQJHZ9otT3TVjrj37Vg
         8Fhg==
X-Forwarded-Encrypted: i=1; AJvYcCWoJa8bCF5rKQ7M8wRrVpYWbJr0VAH1nTcrBZoioqDgxrwmF7vbrtAsI1saJEFd3x3fnrW7dxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07WvqKM+3Ti8ES5fdA9vG8L/A9uKjs3ZfUzSuke6ljdsbi9qA
	gGz2nFBuYY0jIZ++OLwAJrHg7ZDXy2sQByhSifx7thAF7ONFfYc3O4pB
X-Gm-Gg: AY/fxX7Ox6Rt/uXGFEmITkCdwbKiBxf3w74FbLJJ4O/qJYpZUaN3obVB/70c8JXMoGf
	zZCX6JA1E2Mf+nXVu3MVc+ToWoHTVGrXIEfh/es0URPDuiKOEMg2yxBEBOZki8BBN7t6/lEjii4
	MX//Gm73aeDfaWkLP9wObILBZiEipRqWcl/dO/QLtdtgJLxYmXT0NWYtH/mo5Ml0RJOWVXlW6Jx
	U3Pn8BAQWRu5in0Gor+l7HLgob2azPv/rC47ZCYs8noxdkSOfpG+/QHS3FKhkgvXhDw0MwzCMbn
	W8tda6z6K3ONXYG8QIn2VJMT+NFSbJpqZ3RT2v0qY44wFzMnHGMwYyXCNSOzplCOk6AUwT7GF2E
	uGPlNZBVuIddFHjcqZyQKsn3yyEgDCdpX+zzNDp6tP/+9o0+opxIMGhftgbctSoNsnh2VdYaIi4
	xkLh11IB0K1UvU5epyNp8gwn8dA/FHYPS6emLH9ak=
X-Received: by 2002:a05:600c:3d96:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-47ee37a442fmr23416685e9.11.1768385388706;
        Wed, 14 Jan 2026 02:09:48 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27d9aaesm17665225e9.3.2026.01.14.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:09:48 -0800 (PST)
Message-ID: <69676b6c.050a0220.5afb9.88e4@mx.google.com>
X-Google-Original-Message-ID: <aWdraCzEqwc4D_1x@Ansuel-XPS.>
Date: Wed, 14 Jan 2026 11:09:44 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>

On Wed, Jan 14, 2026 at 10:26:33AM +0100, Krzysztof Kozlowski wrote:
> On 14/01/2026 10:01, Lorenzo Bianconi wrote:
> >> On Tue, Jan 13, 2026 at 09:20:27AM +0100, Lorenzo Bianconi wrote:
> >>> Introduce en7581-npu-7996 compatible string in order to enable MT76 NPU
> >>> offloading for MT7996 (Eagle) chipset since it requires different
> >>> binaries with respect to the ones used for MT7992 on the EN7581 SoC.
> >>>
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> >>> index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..96b2525527c14f60754885c1362b9603349a6353 100644
> >>> --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> >>> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> >>> @@ -18,6 +18,7 @@ properties:
> >>>    compatible:
> >>>      enum:
> >>>        - airoha,en7581-npu
> >>> +      - airoha,en7581-npu-7996
> >>
> >> This does not warrant new compatible. There is some misunderstanding and
> >> previous discussion asked you to use proper compatible, not invent fake
> >> one for non-existing hardware.  Either you have en7996-npu or
> >> en7581-npu. Not some mixture.
> > 
> > Hi Krzysztof,
> > 
> > We need to specify which fw binaries the airoha NPU module should load
> > according to the MT76 WiFi chipset is running on the board (since the NPU
> > firmware images are not the same for all the different WiFi chipsets).
> > We have two possible combinations:
> > - EN7581 NPU + MT7996 (Eagle)
> > - EN7581 NPU + MT7992 (Kite)
> > 
> > Please note the airoha NPU module is always the same (this is why is just
> > added the -7996 suffix in the compatible string). IIUC you are suggesting
> > to use the 'airoha,en7996-npu' compatible string, right?
> 
> No. I am suggesting you need to describe here the hardware. You said
> this EN7581 NPU, so this is the only compatible you get, unless (which
> is not explained anywhere here) that's part of MT799x soc, but then you
> miss that compatible. Really, standard compatible rules apply - so
> either this is SoC element/component or dedicated chip.
> 
>

Hi Krzysztof,

just noticing this conversation and I think there is some confusion
here.

The HW is the following:

AN/EN7581 SoC that have embedded this NPU (a network coprocessor) that
require a dedicated firmware blob to be loaded to work.

Then the SoC can have various WiFi card connected to the PCIe slot.

For the WiFi card MT7996 (Eagle) and the WiFi card MT7992 (Kite) the NPU
can also offload the WiFi traffic.

A dedicated firmware blob for the NPU is needed to support the specific
WiFi card.

This is why v1 proposed the implementation with the firmware-names
property.

v2 introduce the compatible but I feel that doesn't strictly describe
the hardware as the NPU isn't specific to the WiFi card but just the
firmware blob.


I still feel v1 with firmware-names should be the correct candidate to
handle this.

Hope now the HW setup is more clear.

-- 
	Ansuel

