Return-Path: <netdev+bounces-251416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F66D3C531
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0545F6CA77D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA13ECBF0;
	Tue, 20 Jan 2026 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ndOfVqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA653DA7F9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901790; cv=pass; b=BOaMjSSCVyCfmHhMDPKpuUk5ERPTP6RlShxLj5Fyz7gxld0U6pt6DukWUBC132SbEYm7M1SMgMqyc7QN2LuE1cv99iHiz4IzNEMGDKqvyO6TJA6Kse4ptfd9jxcHDwdW5zYK01cpXHscjsl9+qfJhuHoMbUw/siVqM/lijXAGGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901790; c=relaxed/simple;
	bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzQk7DVgGU0NJRQb6rL73kPHhylZI25ldipUVBIkr9Jg8vtGo8KCkxeX/+drxZ+be0naxlR/mYMREKvzsBbRx/ORwDz9kMax13J/OpXxca9SNlgJlzVy7dOZMsp+ZDAYguWaYZSP0qyoJWOoP9XxYLZnvTPrK/etWEkCEnAisD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ndOfVqv; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50145d27b4cso54337701cf.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901787; cv=none;
        d=google.com; s=arc-20240605;
        b=bizbM9cuJq7n7mLb0NJF56SPv7ej/kg7RVk+ufR0NB6SH6lcczNCNcfwVLjeko22Zl
         +qYLgVOMTq7u9bdR892HF4SGvacOy7XyORPCy3P4dOratxFqUUE+X4dxVs2P493+QDes
         yWh+npwYoB/WP6KsHdJVUB/SCl9BgOAs06CX/FMjT25X0w7qZIxNatbE4MwKqRA0myzo
         6TaKhWmJN3/g8BpEGMGw/kxjKkwHxLNjSfgW+0ZafD/x3I0PWPsFe18AiqRRS3dam/iH
         TbR3Jwnu4octBKUEXK5gMD8wM/nhuISSctFB4acTDZZH0Kt2uKNCS3jylm2PQX31f63P
         FzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        fh=ljAH7QjwqNa/S/LVUrBhpLSBOLJqwrMIGWn1nLpGfVw=;
        b=iCd3Q+/wsrXdyBmza5W18ohcA2DMEtcWPz2iXGJfqty5pAob2nQ+xLXjoxfpTJdIH2
         I2zjgM7/GYNjlvs1io8KMaz5dz1+o8/no3gDljdS10WbpPRqI4qZl8+VR9deHnGe/ezr
         SYQPg5CWupw2zPLZZrFB7HxznQvUyw4TuG0dA9WgjBniFO93wVg11kcDm0/EQExO0XzI
         4oPIEopXfsoWm7ap3PTI0GdOV3rK6rOTkKqB6sxT58YgXMtbJVO/tY3aOEL7wDoV+dSU
         cKJAaDow7Lv8VAVfYDjzeeADbrFX2TTKrxYTfPfrp/6BojizOStWBARCPia3aPO49LEn
         popQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901787; x=1769506587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        b=2ndOfVqv4fK/TW+z5jKOb/UcajjFo/tOTQT6yvatC5jm5+XPDy7mU6DadDkJT1Mle1
         61ETuJ61zbQwfq5yIwsHyrqHPcjPe8+V3KODtHYyXJeK7QSQBEy0xv2mhXw6c1NqLoLW
         5ysj/VFaP4nI4f5jxQdVKI7EbPI9ly55bpH28cJimcm0czM8U5h/w7GwbwAfTNRtX1k1
         xv/awNwSLU3l5THmZBjVLlHXzwGbUbSN7Fep9X2lqtpPF8L9Y5eupsFQH5K5Ct0uVUnX
         2/xYuRl5usVIcOXiQp66YMwSvx3TDN5nQOV3s2d1QKBTwydj56smrEdi35z7YlEs13gm
         aG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901787; x=1769506587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        b=tNPxyaj0qb/dIjBACv9ZSfl6XBL/Tu8VARIEaVArXrvXkzKv5VEp54xG3dl97ii13W
         RXBBkDLNtMstPAWUG9354LMrW7+g83HwA8RAuA6xhLOTz6zRDlY/DJcHM4tX+gDa3R6i
         DPPumRKMsUf92K87ZpBqpNwwK6MEk6DWB2mubCbE1MfhFrJurPO8F8Wd7QL3+v3nHG3T
         RZVWZ+02Jzejiw7ixdJl27PdKlqrT2cPU0tm+tzDbghwSxwy5xUwkW+zXh42NdecsbAp
         c5DnT/Kjg5J17y5TTBiesdl+1nvSKY/lLFhRloUbkgZKBK/TTWMmfRz4dGhAm5A9zHOC
         gXaw==
X-Forwarded-Encrypted: i=1; AJvYcCXjJ9L8lf0/XdxjteEqrgS01VavIqjjwtqZphbGQpmnSpiceQ6clJ4DFZmdlnFDiyWzsXFbB/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdmBGrvjNitwyVFBvZpaCDmwpHhf5eidLCbX9mq4UF23b4hYC
	NaOSV8wE4P8C6l4eGlCT0VBsGqHtvp2+V/xbVwlC92b1xe7C/IFpHmMhdACjlO6yA4h5chQBvCB
	Tcn4cXQ0edbuc5s2NfG+OkjdsEw75F8olaiU4UE+y
X-Gm-Gg: AY/fxX4lxCyHz0BXp34aI6zZMJIAwby/B9JhL5jbliJg90NJno1GB0SVcpeH+MfsKHA
	qMCJwHRDFp2uQky0ryBIHnyh122+BhlbGv6lG1pmCFoTbxMvInOO7uBhCMemWYVjVzkJpvfU3ZJ
	2zNDAnnhoGR62Ts5UN+nBDZoNgzhQv89W4TC4WvHDhz1CHpD1E3Byix4iAF1bi3kfw6WB+N92yq
	fcoGpNxG00lhZ/qWXqf0zOQZCvJbxX5/3gWfA67JkCLu8uM4EGM0+PlKKHEspO7GUXEKXQ=
X-Received: by 2002:a05:622a:180e:b0:501:4730:fbe1 with SMTP id
 d75a77b69052e-502a16073e7mr186116891cf.22.1768901786640; Tue, 20 Jan 2026
 01:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:36:15 +0100
X-Gm-Features: AZwV_QiBVALGf5mVTwkAOxxW_7LaEeT-CXPBAq0Ya9GQEa2O6BH9EXhsIb0Qnrc
Message-ID: <CANn89iKNgD9tUqck8xHphqc3iiERFjYcLBa+PTHCqXwT7cxY-w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 03/15] selftests/net: gro: add self-test for
 TCP CWR flag
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Currently, GRO does not flush packets when the CWR bit is set.
> A corresponding self-test is being added, in which the CWR flag
> is set for two consecutive packets, but the first packet with the
> CWR flag set will not be flushed immediately.

Reviewed-by: Eric Dumazet <edumazet@google.com>

