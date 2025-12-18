Return-Path: <netdev+bounces-245262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B080ECC9EDD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7123C300E0C4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 00:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3B2264C0;
	Thu, 18 Dec 2025 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05P4ZzLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3552248A0
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019156; cv=pass; b=UEz/MKUGAMwZhdUpO2TZNFFsLsjGbTBrHTA4Xhpew2cugSQbloE+g+5xiwEx5vE5hfNOLPfVWMlNqoBJjZ0T5RrDACQmavtX14vMC2G+zlZwM7Lm+OzEsPIFujvNwRtQR0qR+x1IwS5IH6aZFcrVtIK41F+nTyPYu/T2W/x8UFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019156; c=relaxed/simple;
	bh=AsW5OaEntsD4rUYnqwLi0pmEfurXPvw1+DhlLXSA3EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXIqBABl8jArtVjt4ZfpbE64j76aBbQonzhb2D/P+Uz20OG28M05UdGB6DdEhgT5xVoECbk2dRdOxwJ5Ww7KAcDWJlLROtakFfBGrKTD3jN+H557yHbg3hPSGbjXvYkEnji28gzsHA7scoKK9WdNAcl2yJchUv7i9vVuSDA02oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05P4ZzLA; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5942f46ad87so2887e87.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 16:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766019153; cv=none;
        d=google.com; s=arc-20240605;
        b=TmngHCmruJZUiQe/VFE7Xs4asBMkzE8VmXegZvn9eAcY4GduxTDg84oUBUrdRufUUw
         3fnCqh4jE3WimcZLhDhYeeEE0uGKS5Y6fXngm86WkFuDzrsM1EWcoGsXXMZhCX//DOuj
         jAiccFGLlGYI3dQmOL7mpBc7LkU1iOrmJjkZnuHafKKduzPVPHB8SYVS4hSEoqesWgRW
         Lay1ygiUSyU5aBmi7tGddm/wY19ZaRn7CMymdr0EArgnjgmUBniLpUtXALIFzWZz9TYc
         t4CUP9ruj25XXkkn+uH2wSvGGmu2FphS10jhJmD3NROG925JKUXkywJWAdnBLhBhOSW7
         60AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=du0kCtfi5QhpLe9dk7Ff2CQwdsFdE0qZL7AISkx1KXk=;
        fh=GvLV+2TYrwYxI0HEmFYo97gsJw4eSbE4N1TZ9r3Zup4=;
        b=ZJthy49Loi9NGWyDkOmzRJiVn7xdrc1rdStxxSIeCfhdA5ZF1JzAH9ZMjFE2vlqHOc
         r1nGd6j6I5gFNPjvSLYjP8epMCeY052XelwLww7zin06jPilxVOrJAjJM66AF78+vIXf
         jWItJx5t+zQIgdL0EZZXrScYj+uJwOyIzddPBZqymmuiRuvEoR8s+FM7HfvX1WhdVJii
         eKz6DuRGXoDsVaUUelT4MqQZtQ1DL9J22oi0SIx2LhKTryQlNc2X1DarYKfKWp3bzOSv
         dsaT3PLB1ImKjUNWu4t2LlNBPcLAdCM4HzIFPdyFlwNM2BwW5j/kXV9qZN4PleE4l3eE
         /tWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766019153; x=1766623953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du0kCtfi5QhpLe9dk7Ff2CQwdsFdE0qZL7AISkx1KXk=;
        b=05P4ZzLA1CiD2TC0ahfqkxHZd3jV7bBMtgelY9HuzxvNhl5+EIWhwIbhd59eVTmH34
         A7oP7KKB8ZuKDE0y6zQxt0jI9kpGXhryxObeA0tcjKk0S6bzpPR8p90EHoxRNJaN8Ydi
         SIC4HWPduy3wJJte5l+HG5YDr22YTluuW2DWP4qoR8AjhQyzirhr+121Yo0t1712RUH3
         +oR91WMmKrTLnvdRmRLDZ+4RpidQCIxfE+aCEJ6YaOXOgZCaZg7vM727k9F/10MzDwI+
         auHFyXDyUhD2hE+O0B/MH/M4BkyQNNAmoZMSs1e7yZtInBpn5IlTRCeKVA/D+BLiBqD8
         xmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766019153; x=1766623953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=du0kCtfi5QhpLe9dk7Ff2CQwdsFdE0qZL7AISkx1KXk=;
        b=CRfw1W0X4KqXPX/TrLRh0baPwlaHlCiZPc9j/RZY1Iy0lgynmgFeAVQ8D3BcuZICUy
         5wTnEgSEh8lVkmmmkShZmwL5p+8KT1jgLhfdnCiN+xOSlSNt645MbfSq4SjzRFgfPIyP
         wRCd91gH+RvEP84+zAuPuwkrN5yhmYXZnqFQN2FfklOmjV0NXR8WzGQ8LRJvOhzQgkbc
         MoocKpjkOUHgV/W5kgmzX0bQiQMhgv2aQQds83mjKkBj2S/w3Ru3/K7FcV2vfPtecRAw
         mPqfVIZtng+M/PuUaWyWXtyvzmavUr5vTvqcj5o9A1aUpe8TxybwQKaPS7uz4zV2ILUO
         fk0A==
X-Forwarded-Encrypted: i=1; AJvYcCVKwJrOvQiqN3pntPe5H4TqClbIplTKNqmOmYxYsv7bNYv2VjnP0rKzfr4VVfLKsH6F2RL1lBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMIcnrRNTwHm8y/oMbxpxhroLFaKSUilIiZHj57hutqOwcAuS
	Ikb22vd/sdixCRAZFS8GTLeupD214XDQ4xybcuwXpeU3N8lLcrYJs28lLkSIiZJVYuFI1Oqjcxo
	M/OGeKtGH+e2sa/YtPNAEsToz1n9vHsSOusme26Lm
X-Gm-Gg: AY/fxX6QIy+cHTwPboWkk4oK1bP/xpxD3fV0OX18s1YNEbife4Ns3pYTxovK3Y/41TZ
	86SkNRobJxF36pocuimsD8KvWMq6T2f39A4Q22+3rTDpBugmVM4yaCGF9xzrdNiOO2/GC+iIYvv
	6hXe1qcFe4bvWj1ec1PkScYxOWGXWzsxHJJ5UDgo1t5LXJ6WrL0e2ERAuKGvivVjaQ349V1za1N
	KNbj7dHq9ekcTtGpXFS3F42CemZNvsqyYNWMRAOPgzMNY+TKN3EhCOSqf+b1uz2B1b126duuAXK
	GFNQIg==
X-Google-Smtp-Source: AGHT+IGhRe6cacnalU4Sbbx0+P+c9GB+XE3RKJaZT80HPKy2K0IZ0T6hUEygSC8LmCwKJ+ato7ctj90QisAGmb29DwQ=
X-Received: by 2002:a05:6512:6797:b0:594:2644:95c6 with SMTP id
 2adb3069b0e04-59a143f2106mr6242e87.7.1766019152768; Wed, 17 Dec 2025 16:52:32
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
 <20250930212352.2263907-3-sreedevi.joshi@intel.com> <aN1MSIO27C24q-gL@horms.kernel.org>
In-Reply-To: <aN1MSIO27C24q-gL@horms.kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Dec 2025 16:52:20 -0800
X-Gm-Features: AQt7F2rjkM-TcPM4FYbg46wjt_nAwd51pZtMcJTG3c8bX0EM5tdjUpRcCMo7RqQ
Message-ID: <CAHS8izM9dFNtkbdR+_rCrEmb0L6r9vga0gDr8GXeHX5N_4=32g@mail.gmail.com>
Subject: Re: [PATCH v2 iwl-net 2/2] idpf: fix issue with ethtool -n command display
To: Simon Horman <horms@kernel.org>
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Erik Gabriel Carrillo <erik.g.carrillo@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:45=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Sep 30, 2025 at 04:23:52PM -0500, Sreedevi Joshi wrote:
> > From: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
> >
> > When ethtool -n is executed on an interface to display the flow steerin=
g
> > rules, "rxclass: Unknown flow type" error is generated.
> >
> > The flow steering list maintained in the driver currently stores only t=
he
> > location and q_index but other fields of the ethtool_rx_flow_spec are n=
ot
> > stored. This may be enough for the virtchnl command to delete the entry=
.
> > However, when the ethtool -n command is used to query the flow steering
> > rules, the ethtool_rx_flow_spec returned is not complete causing the
> > error below.
> >
> > Resolve this by storing the flow spec (fsp) when rules are added and
> > returning the complete flow spec when rules are queried.
> >
> > Also, change the return value from EINVAL to ENOENT when flow steering
> > entry is not found during query by location or when deleting an entry.
> >
> > Add logic to detect and reject duplicate filter entries at the same
> > location and change logic to perform upfront validation of all error
> > conditions before adding flow rules through virtchnl. This avoids the
> > need for additional virtchnl delete messages when subsequent operations
> > fail, which was missing in the original upstream code.
> >
> > Example:
> > Before the fix:
> > ethtool -n eth1
> > 2 RX rings available
> > Total 2 rules
> >
> > rxclass: Unknown flow type
> > rxclass: Unknown flow type
> >
> > After the fix:
> > ethtool -n eth1
> > 2 RX rings available
> > Total 2 rules
> >
> > Filter: 0
> >         Rule Type: TCP over IPv4
> >         Src IP addr: 10.0.0.1 mask: 0.0.0.0
> >         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
> >         TOS: 0x0 mask: 0xff
> >         Src port: 0 mask: 0xffff
> >         Dest port: 0 mask: 0xffff
> >         Action: Direct to queue 0
> >
> > Filter: 1
> >         Rule Type: UDP over IPv4
> >         Src IP addr: 10.0.0.1 mask: 0.0.0.0
> >         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
> >         TOS: 0x0 mask: 0xff
> >         Src port: 0 mask: 0xffff
> >         Dest port: 0 mask: 0xffff
> >         Action: Direct to queue 0
> >
> > Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> > Signed-off-by: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
> > Co-developed-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>

Tested-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

