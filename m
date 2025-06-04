Return-Path: <netdev+bounces-195136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DCFACE429
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DA03A77A2
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5C189F43;
	Wed,  4 Jun 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUXiSvpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAE171A1;
	Wed,  4 Jun 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749060347; cv=none; b=pHtukqaZqX5hlGP+lU2wj9ePz3NA/F9mJyPeZq0ztnDSTYOLlHbn7PVFWNE8yDY9Rn7Rp9lo82+Z4ckz/YllVokQ3UKVBznsC1/SUllPYmit6KYBn1UUZtxXHc+q0dDfcjqLw9s+FyxVFHIrS7VySFNY0YYqbNb3anUhrnhqmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749060347; c=relaxed/simple;
	bh=woa/9/oFUYGJ7mpbgoHITHmbFt3ima38M8/u/VRjM5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBBpk4xnlk+hpJo9F9QkVWUAJB1MvtLN7O2LpSsumgs6OfcYJ7XWum6HKAwuu8mWr99nKZTSGPM/3rIGwaQ6o/bYITvvLZFWiRahnvl4encUM9/Sb+KpF/MefiobG9W1OsrpDHMIFiOlhmmCXBNr8WnZyj/FYqCZIgZtLaJR5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUXiSvpG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e102eada9so1880337b3.2;
        Wed, 04 Jun 2025 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749060341; x=1749665141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOtsFZcdnaTb/0TG9fHEA1iyAVHifgjIHxz/xjfXbmk=;
        b=MUXiSvpGEinIihImFQ/VkXleXZguqYg5YuEwMpcM7ws2MIzMWRXqEePA3oFwb2oyEl
         wOgW/OSAHGqwWRKTo8EXU54qQAKno2QqUUSWKYhxuy3P/vTw9qbw2FemQsCiSdIuwVxw
         4KnsK4ps2JHJ9HyPCjLyKeTfmMRyjWw+tn0FfqZqy9n0kn9dIIA7nZ8mwrQe/J4/H+ct
         fHVGARcl8L9DQ2dyHIESuGey/Vp3BxvyIfe+DhjfSCQOnMPZMZ/Tyy/Ed0wErCZgVSS3
         AYyaWatwaS1WDCOKLbKwg8sLJB/Sgvl8f0bqndgmiw64pnzF3tFZVoG4SAmm+UxVj5TV
         saYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749060341; x=1749665141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOtsFZcdnaTb/0TG9fHEA1iyAVHifgjIHxz/xjfXbmk=;
        b=tLbopuh3CWPoB9bBLSwKRMgMA4Sdn0UmhkojgwD6Hw28X7+r+VZJbiveUaQxbURkfz
         LAOR8eymtz3aORnjUiGV0I4HxZnMEb8LR25Rz+tRCpmE7aA8AbP1+Fczgym1AXMabc/0
         zCS0x1etii6LbrlchIiajd/pvUV0Jv0Krs364ScD+ihpJVT3nHJeQsTYPOsqKrcaFdRR
         vIO0t2+ALEdxNrnfFfjb+PnkqzZ6g6T/69dCX1S+WT9b1ddDUmk9I17MyQ9GFoxuQZ/d
         gAmaQFXMFArVvSfD6rSPc402c2ThjebPooJ8hgAZNWtaqeSXtVT8bRWp6POueH3tD4lY
         Fd+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+2QHF6lhwg6LyovZoJvOMAV8jkWP4jBHCK4WYdB76oH62totI8Iuo9F+84q0Cr+87dfFeF9IZeX4ciY=@vger.kernel.org, AJvYcCWedYqmKYzdLtesL0PdgXjE0DOeC1emJ4QuEY1HFZ2ILkaOxyLx8uEPk1VI5CuFFYIrLcQJw9lW@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmS6ZEmOnM+v0NLdkl3Oe9htiRsO1RkIKxoHy4+ksIhtOGs3M
	051GHHI/5qoREpLWdIcvd8C7nMQ0cuDN2OcUSIe9jlb0wyWAP+CwNguA9hMMRg+pVAFowLzJSOe
	sQQgc2uI8amA6Bnz28ySIJv46ZPjI+Lk=
X-Gm-Gg: ASbGncveJIQu7QCU540AEbWqZJVd3FCI3RwEo/ytuTrBAeymiMTqa0sLzk0ZXijeLUI
	6vLQsYPf2RxCW9HWsbqpe+gfSrvl62IatjmKGdaxlrxUfV2TXxLkJNwiqxaaGV0QePLu1H1UDlg
	BFHucFmq9B7aNKOeYUwpN9MfvPJYKLosk=
X-Google-Smtp-Source: AGHT+IEa4PwOxf1isUxGch8YFhl8hYCFa6vCV2MSTF8nphhd7raQVQD92S/v2R6LCn1c8iT85VOpF2AuW3TzUY5d4kI=
X-Received: by 2002:a05:690c:6307:b0:70e:142d:9c53 with SMTP id
 00721157ae682-710d9f9304emr53671757b3.27.1749060341259; Wed, 04 Jun 2025
 11:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603204858.72402-1-noltari@gmail.com> <20250603204858.72402-7-noltari@gmail.com>
In-Reply-To: <20250603204858.72402-7-noltari@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 4 Jun 2025 20:05:30 +0200
X-Gm-Features: AX0GCFv6Sj2tjhCmpvoe5eufkG_ANKWc3csxGV_MUx0Foq8BnEoiq_qu3w_SdMM
Message-ID: <CAOiHx=n00=ZkbuJN7MMumyOAXaNFAeXtVsJuHy5KLfqLRkE98A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 06/10] net: dsa: b53: prevent BRCM_HDR
 access on BCM5325
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:49=E2=80=AFPM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> BCM5325 doesn't implement BRCM_HDR register so we should avoid reading or
> writing it.
>
> Fixes: b409a9efa183 ("net: dsa: b53: Move Broadcom header setup to b53")
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
>  v2: no changes.
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 143c213a1992c..693a44150395e 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -729,6 +729,10 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int p=
ort)
>                 hdr_ctl |=3D GC_FRM_MGMT_PORT_M;
>         b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, hdr_ctl);
>
> +       /* B53_BRCM_HDR not present on BCM5325 */
> +       if (is5325(dev))

I think this can/should be replaced with a check for dev->tag_protocol
being DSA_TAG_PROTO_BRCM_LEGACY, as there is AFAICT a strong
correlation between the legacy header being used and the B53_BRCM_HDR
register not existing.

Regards,
Jonas

