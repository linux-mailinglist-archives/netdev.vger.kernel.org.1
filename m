Return-Path: <netdev+bounces-150707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B591E9EB346
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C312281D3F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314FA1B394F;
	Tue, 10 Dec 2024 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYGKP4R9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493551B042B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840936; cv=none; b=Cjcs7Ehq8EpHgh3U+c1ytX704ciqxpdeLFYB2Vf7CIcv2yoXTXG0Nan/x4O4Y2FCfoiIM1mmVe1ojVGoIClvILdP2JkZEkdbaGh3TPTM9RSHuDD04rz+k1q7geg6MNG2IooU+5XTCK6QxntOE/uf0L0US0/3Rosg4THXWyiJCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840936; c=relaxed/simple;
	bh=uyPvZ41Etvmfq1tE8uJDaPMtfSj8eWiFsAuISEuHcDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1Bq3Te4IC2JlSrVtCbw5XyM6fgbKcU0S2SrdcQqgDthSgInXBq+zOEBvRmSUGwwW/PHF8fFrY8laiu+VkiQaH8iUCOuu6kpxahwIaVkvKtpVDYoy1iESN2UryCKrsOcO17cQSaMXTJuZP8/rhoVVjSIa0RQRmyBuCHKokFkxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYGKP4R9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862b364538so2401722f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733840932; x=1734445732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyPvZ41Etvmfq1tE8uJDaPMtfSj8eWiFsAuISEuHcDs=;
        b=IYGKP4R9dw5iWaPFEmwVX8DDVja7habrufmvSiOY/LXSYP40wS67FYvGeHtWgwmJKV
         9GlFGX4abENxWHo2zxYpw/hHQd4DELo/JTQQzoFii92pcTUS2cEwfO3gN/Z6WaFpPgo1
         g2iuJ/TuxsFTcXqaO4EzJoiMnTH5GVt1nat65V8UoVum6ZA71IRY1IH5qKdhKPUrw9iQ
         KpiYtoDa50WlK4FTWtCLYXgqIFml2G+dw/kK1XFFMdTu0KeB2gzBo6i14t1q2TRdganI
         6b3CWzYlAfSBdfao1eGADqf+E9lQWDmHp7dez2Y8ztvX/t7UehdSeN+5w698pvG3QADQ
         YmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840932; x=1734445732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyPvZ41Etvmfq1tE8uJDaPMtfSj8eWiFsAuISEuHcDs=;
        b=wCdAI/TJGLeubeEIfkm+q6lPtTQvvjs9lfuMVkXy6Zb/xNjkR5d7WduByiJ2Qj1Tcq
         F8m1bFjaXm403SY76IJd6XVXMwd4ilFlPuXdHKWyiob/Ds/I5hkk20k3IVw0qYZ7eR/9
         4mMuKvWyXOP3/9nD+P8oLP4yukkqFCtNE7fjqOooVYLNTlIZ7/lhbs8j7AtGtjauwhOR
         /p0mE4EUQ0L7Z0A/e6dM+87l7mlSxSvuRDVc4FfOyNwsagXyxc3RPZR0PfeRH3o7Z3a5
         FHexJpnCw017PmYxR2YnzyiccemZZN1ALrfyAHdUdRjvH5etzbV4Rdj9wfouv04hz+/4
         +O5g==
X-Gm-Message-State: AOJu0Yx82S2ggW6oGQpvvsVNmovBu43128hoQrSa+kSXoS55OSmAfUCG
	edwa7IcJlKZTKsbp5K/f8cVGLTIXgDr+2JdKsbHtMX7CAjdRXfVK2S3lyP1PdMoZCEarpg7Ez1f
	2u6XW9xVI3gNn9Y+8gp7y351lV5M=
X-Gm-Gg: ASbGncuvHFRLuRmeADUvyTY8y0Jlqd/rOjrHvPThbX2o0te6MWNESz4QQLn29ofAnXD
	GnJvymqgHq/kO7yE/FTIjcfnznUqEGNpnI6vf
X-Google-Smtp-Source: AGHT+IGrLfMK34OcxPeuwxi3HpqKLZOZhRJfLKjyABLf3Bi02q/7zAbHaINTEcr9SBtO5yt2jfiO1/g3dVOP91sAC6c=
X-Received: by 2002:a5d:47cd:0:b0:385:e10a:4d97 with SMTP id
 ffacd0b85a97d-386469bf8a4mr2520322f8f.21.1733840932217; Tue, 10 Dec 2024
 06:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207225906.1047985-1-jesse.vangavere@scioteq.com> <20241210141308.GE4202@kernel.org>
In-Reply-To: <20241210141308.GE4202@kernel.org>
From: Jesse Van Gavere <jesseevg@gmail.com>
Date: Tue, 10 Dec 2024 15:28:41 +0100
Message-ID: <CAMdwsN_P27r3dPmUFM4JwzjL-0Y-nv1a9eBCt_5CrHunrD6wrg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: microchip: KSZ9896 register regmap
 alignment to 32 bit boundaries
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Content-Type: text/plain; charset="UTF-8"

Hello Simon,

Op di 10 dec 2024 om 15:13 schreef Simon Horman <horms@kernel.org>:
> Hi Jesse,
>
> Sorry to nit-pick but the Fixes tag should be placed along with other tags
> at the bottom of the commit description. In this case exactly
> above your Signed-off-by line - no blank line in between.

No problem, that's a valid remark, it was something I already wondered
about as checkpatch didn't mention it, I will fix that and send a v3
later.

Best regards,
Jesse

