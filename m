Return-Path: <netdev+bounces-151677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C59F08F7
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCF618821CD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3A1ADFF1;
	Fri, 13 Dec 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA7FrNLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD018BBAC;
	Fri, 13 Dec 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084172; cv=none; b=EoL4Lh2AlUJ50UMwOErUrqSyNyVnmg3xbLkzSaACNEOTWSiyLKB0/6ALn/aPa4lPEx3zpUEBhPQpirOzwNpXcfwn4OWe6Y8oJTo16/hyJkBvdXVjuKDx8gQsTR3/Wf8/oS5EZW3QDVQ1nNxLB+BvBzFcWLOqdtYhNGJEJ+y8cIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084172; c=relaxed/simple;
	bh=g75VeR7xnQsOy14UaWCDhMykR3nk0TYaGgOoL7QGfTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdtUzN1UN0f94fTVRRwLr+0jmmMgvd74fqoMl+0QZIYhMK+NOTib6N/x3THndndrnzLgcAXVvPDpYv2jDTnOOX5xvdPjAeIAo6yTSMSK55vCoznbwW4IPfU5uZUe//Hd6G62+41BX2Gg4pFXv95AMDdLs8TkOVWzYaNqLRCEwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA7FrNLM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e0e224cbso814829f8f.2;
        Fri, 13 Dec 2024 02:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734084169; x=1734688969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g75VeR7xnQsOy14UaWCDhMykR3nk0TYaGgOoL7QGfTk=;
        b=YA7FrNLMqXc9NUBrPt/U1mI260UwUOEyaWo2ju2Z/3E0tATfxDuHliT7bwEOM+wKoD
         ixKYlzLFd1c4Gd7opKqVKMGFxqixdcqN9munFb/GYoJtfMSM+FbRdMa9S0BpDVn+bEU3
         m4TvRtqYU+qyMMTkqG9HKYFBKHf27KobV4QlD0j92nXnqXP10CcGDpUrVX1FHSxmOM2w
         6WGbQNqw5LKZQs3bCCZnNXlcxJuj3sZJozQbaNkxiGOGkYFDwEvPr568zz+YYlVpCSyT
         x0X9GrHMFMG13AGxTSvq0ZG7qV3g5LHSKQkn5FsBBusBcJc78zfGyncebPdSAmpVQ2lr
         Zm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734084169; x=1734688969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g75VeR7xnQsOy14UaWCDhMykR3nk0TYaGgOoL7QGfTk=;
        b=hQDnImWEMAgfLSbzGLAACsRKQNioYQb0GoROfaSbJMPZR73OcGVGuMfb9QIXVwDAkx
         uBchivW/IFWznuk3tvmk4/dhDKmLqo3+55Q36ZRm6iMdRF04qYeRa4M/UjtAOKFU2wau
         p7et6Y/1JHGPrRb0Kp2erfOgQ5zIiclMMbF1yjVUXcASIkcpRuqig+RFEcan3d+4w6vV
         LpyCjiBhrx0f15h2RtkNqVcn2ZrOacpQR65+9PJUZX3d22XFUU25u8qnSSyW8WiVqm8M
         xN8s57JX+nDWdvqQqNXoZdB2hngfsIWhTAyPGJT5+sEmyrEaWiLsEiXzuKOE/FqhFr7v
         5u1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0p1YSk8mSz3WMW/KEfu+nh3D6GmufTJtSlJDiHT/CPmR95vp7/qSyl/owYaG+htan3oLeSbcD@vger.kernel.org, AJvYcCWpZUdumqyN8MOME1ouo5Y8ERLCmAL89by6UDJ8AChbasIvTTZWMdUz3muQY3LgLUZJZEEL+qgc3wuH@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxNyMji2S9S/PiFiXCRp7qzQAfhhMarM3AIyMiSRSpGJTbwBr
	k6vep75Kdoybefg/RXPX+JYbb7TiiEzoEHArI8+0Qr7wmF20HmvaM9ZkqGZQsWBdQAbEyezRG+c
	16PwAd4YhRHfNiodQb8VdLbFVFdU=
X-Gm-Gg: ASbGncsZddwJuuuZCjI1XmC5YDST1kTXFXZ48CPSsgpF+R9Odch5pGsGyGESrTCKYzw
	+YWZxgcZ4Wwc/D1oA+f6dy7C3Yfjdo+HkEP//Q9g=
X-Google-Smtp-Source: AGHT+IG8+Zvp5mBol3e+mWVdgRf+P5IxgzboLnubz8ra6Ud3QEf4CIcFcYQCF+wQS8Z/LyVWNDuu7o2nEw9p4VPoERg=
X-Received: by 2002:a05:6000:4616:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38880ad91e6mr1232213f8f.24.1734084168831; Fri, 13 Dec 2024
 02:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210120443.1813-1-jesse.vangavere@scioteq.com>
 <dfb09395-78ce-477f-bbbc-747b0a234d4f@lunn.ch> <CAMdwsN_Kgb23Rw0q041fFr9T70twx2vAX2J+MvJz+585ZyyanQ@mail.gmail.com>
 <sugh74o4cevws4lkrsweqzejaciu2dcjt4rlzuncp4ceddwgra@lhgbx3lmkqyk>
In-Reply-To: <sugh74o4cevws4lkrsweqzejaciu2dcjt4rlzuncp4ceddwgra@lhgbx3lmkqyk>
From: Jesse Van Gavere <jesseevg@gmail.com>
Date: Fri, 13 Dec 2024 11:02:37 +0100
Message-ID: <CAMdwsN9Jau47fhnQ8+DXsURQUgDUnDjpB98HHS_MNS4wvfOTMQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Improve
 example to a working one
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	Marek Vasut <marex@denx.de>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com, 
	Woojung Huh <woojung.huh@microchip.com>, Jesse Van Gavere <jesse.vangavere@scioteq.com>
Content-Type: text/plain; charset="UTF-8"

Hello Krystof,

I can understand that from a code maintenance point of view, in that
case I will not continue with this patch, thank you for the feedback.

Best regards,
Jesse

Op vr 13 dec 2024 om 10:50 schreef Krzysztof Kozlowski <krzk@kernel.org>:
>
> The point of the example is to show this device, not everything, so
> adding there nodes which are not covered by the binding is usually not
> what we expect.
>
> For example what ethernet ports are might be pretty obvious, considering
> they are already defined by child schema which is supposed to bring you
> full example and full description, thus parent schema does not have to
> be detailed.
>
> Best regards,
> Krzysztof
>

