Return-Path: <netdev+bounces-149785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2F9E77F4
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1316B1639C3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F71F3D53;
	Fri,  6 Dec 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ihp5NaUt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069A1F3D2B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509028; cv=none; b=LnMgc6XUNIZKtrZrAFwQ9vQenMWWSXXvX3aFz2eCbS8Za4B/mvLoahM0PpHdbDxH5QTCkws0tQ6Z9VoN/pcuhlC6m96acbxOPtRYlyg8iDIlfhlD3Be9WSqdLc8M7gikESVCYBnuzq6KKAyMAprZM84NkRuoQWUbY76+CsHbQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509028; c=relaxed/simple;
	bh=0kmwuOz7qibXuGzXJBalsi9zlGLF7Gq28kA45wgqC4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSw78eCfq7O1Zt8jTrqa0I5wVROFkxW7y9vZAL2Drq8A1D8qEsQCb53N2QPaTK1F2tYs/12+FnD+9SinH/TIEWCIO3CpyNAtJgfylmST0z/u2orx6UIO+sQ7z+v+PzpMRHRuYoowKArjmYFb40KkE41TX4wJr8uQSJhRCMMYLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ihp5NaUt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30033e07ef3so7595071fa.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733509025; x=1734113825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6ecbloalYthckNBNhPOKdoCIqqonfcHxmM2rm8Txtw=;
        b=ihp5NaUtowz+r+K4K4TJxGidG3B0l0vYq75fCy5U0qaDlpayB1vrPqEqGMyD8XKl8E
         zwRmIZ3aG/A4n8lXj55V0S0SMq2gHI5ZfkE72HLvIMxatAPL/Vbl1x3SD415DyUbJVb7
         Mdfcj8C5Rn3+NJWFaHaoSbt8otVWeM9fomtOwVMxVUqidmcfWrEmMp5JajX+7U9iyeh7
         adN8tNA3E+POvtvT1Nh5VfVXgGF9HOFOKbaUOO0d9xtO6poWd8u81wawD1+yB7jZcjxK
         5nQrm3o+0Ps5cu7fqX1tGIGWU9+H7ZzWBljib5h5IVUYcjCv/cCjg4QxTFJp1+DEC5ft
         dWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509025; x=1734113825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6ecbloalYthckNBNhPOKdoCIqqonfcHxmM2rm8Txtw=;
        b=mzjvkH416E5T9wj2dMeGw4rowdz5QjRFZclfT6VnbrOvBJMIj29cZzswLBVShSVuhM
         p8ymkT8KJ1nxoAfOVkLA5DIs0EKjP0yVdnsGYaserOMPiTV2MOKFy4vJfi+YyFkHiERZ
         GRRYqVThjryHAA49ybykKk2QHPf+OkklLNFVDmXqF1O0FV0SxtwMby29uT2dp3IQ75Tr
         Y2m2JYyk6EIYLYN1ZOksL5W2gT2c5O5QxJh1eHR2egC99d2a/dc69wtgM+VIu0N8mJch
         vXkHkSmQvr3JZWDV+Gc7N1m3pocGUneSOXFCY7SGZNmpRm1yfyXxE2YP3hz2pp6ffTAq
         ThPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGnc2uMwPjjHMKDJI6RYw6Gs26vfdtm6Z/71ERc5YM5X8lQWxaQbAc/eWXrmx5a8q5cBM+G9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUCXLAp9s/z3p/V8vCvqV7iTWi32YEBonnGBIOmtvAtElazw9
	oTyfdMypFXr0SwCqdislO3TCdgn/OxeFxnasnZnmaJnYP0cpXGR4UlFf/H1Zr+8=
X-Gm-Gg: ASbGnct/H7g9RAeMo9zGeUA2srBnOruscaw652pMnQfPP6XrTqTbYSHyTk81EGkGo+M
	7113I7wmn8KT+P3dNQpenPf+PT2T/pi9qf14+km86XH7iPrNXB1/E3cz0TtdrX1gOqKbuoFnSwY
	r3zWxtmDkC1wfB+PqtbTIBJMOSFHCk+hsEUcBZSGsDLK8/CO9hCs8kHAuVZnEhGXO1K8dGMQ8O+
	A3+fPB1siJyNLm2c4A86c5YrQ1hsOg3z2/e1SRDltwWHsJW/3Bik2mnSiBDtArlr+n8Gg==
X-Google-Smtp-Source: AGHT+IFSQk4LVXdGCOIZgkcmUG+e+P3Squ0CFAeeVN2glBcgom7D7Xbv7QXnrDJUIxPedfYrmXMMhQ==
X-Received: by 2002:a05:651c:2119:b0:2ff:db26:2664 with SMTP id 38308e7fff4ca-3002de40268mr13998711fa.6.1733509025014;
        Fri, 06 Dec 2024 10:17:05 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85076sm5301271fa.23.2024.12.06.10.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 10:17:04 -0800 (PST)
Message-ID: <3796604a-0636-41ac-b7e2-13ccd0694d4d@cogentembedded.com>
Date: Fri, 6 Dec 2024 23:17:01 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: renesas: rswitch: fix leaked pointer on error
 path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
 <20241202134904.3882317-3-nikita.yoush@cogentembedded.com>
 <20241204194019.43737f84@kernel.org>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20241204194019.43737f84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Why not move the assignment down, then? After we have successfully
> mapped all entries?

Just realized that moving assignment below the loop will open a race window. DT field is set inside the 
loop, and once it is set, completion interrupt becomes theoretically possible.

Furthermore, realized that existing code already has a race. Interrupt can happen after DT wield was 
updated but before cur is updated. Then, with the completion code won't check the entry (up to a new 
interrupt, that can theoretically not happen).

Will fix in the updated patches.

Nikita

