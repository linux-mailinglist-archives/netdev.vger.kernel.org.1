Return-Path: <netdev+bounces-172861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A19BA5653E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93314177989
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B0E2116EC;
	Fri,  7 Mar 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANWlpoQe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3F20FAAC
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343330; cv=none; b=VwFSFLlCrgOkhltVJqnm4cAo6QVxowtAV7DJmBAUykiXcdFTovDv5z24TjZH8EQIdHdV/yibRLgrhWsK2j9eWJxbsr1LqABjH42750GbNWcR1DSfPGFUtl+b2ZY8XEvite253geFav64jeQElw9DS6SLRS/vyHE11BXyB6ErxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343330; c=relaxed/simple;
	bh=lpz8W+/JwmlAFUO/QFcs0PO4HoUi4STm2Upsn1W5Eas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwPH9trk1m+iSGeeAVYiTERwXRFCSjJs7RcIPhq8PdAjimTY4m988Eoixz/qFfCYo0ti9BYHRYSkDMI5by25mRouwjhSoXTB9Wl0omrLLvX8YpgKW8DL5jOoN6QnufGy3wE+SlGC39zWZFYCKavjpfJ9mOUk3QdqCf3+SLuywGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANWlpoQe; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474fba180cfso14132341cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741343327; x=1741948127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1cIrBe7Ura9LTOFC9H3HdVhePICrfHd60ZZ0KZtTWU=;
        b=ANWlpoQeYcLYjAANB+qzRZSqOd+Pbch5Ex/EIukKQPpkdIYw2POxrInaazQin4h75c
         fwVi716z/mKZa56D9+N1hz/MKY73MziJxDO+WdfNrFHLnjfFoOAplTaXLvu28xz/kHuQ
         lnT/HN7BLOKGVae607ttdDUVDjUCwvghtCLd5QKA8JOmC0uv6fDNuWcCwDEyRYMc/8EE
         jo9eXRldLR4TVaT/oH2W6BfKkeQWyQPCm+NG1YhOvsufJYePeFD+X4uiPzwjRJ90Xo5v
         CiSGSsqdg73aRgrwFWijieuyAlvuSqxZGQMTvJS+JZIBKbI0Zb+SP76ZqtE2dfE59hTU
         cdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343327; x=1741948127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1cIrBe7Ura9LTOFC9H3HdVhePICrfHd60ZZ0KZtTWU=;
        b=Tl0hud7Y1Xgkd7Dgu21eCx6XiZktUKEtWFnz7RZ3SAhNqyGEbflNeLHzXmowJPCLDb
         ZPyQQeCROuL21vb52ddy9bBIWbfZWpdK6g0JkStqOXTDRtu2VLIS28w+65bfq74PhmHW
         MIvEh4makJp0jz//NMATVtmWieHqSj5K1H5tADtsuBy4WAxBo+5VPl67ZNDt13Dy4Sdj
         zGNblj/zGsb52lZJCPB6PQM6seqZ5b8SkteAUM5QvibgqKNMyIhAej9de5Q4Ew2sc9HI
         3d11qZCTe7wcLp6xORsNypMCCCY9ZzZT4KnNwhr+7fdz3BA7L3ggFFzCfzkz01z11B1g
         EQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCW8HYk5YFz+5M6hN7X8rkrdsTXWUbbe678r3XQx9GvPJmpPrRFbX7s1eO8XHRI/dJ9aMI0L1+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9/6VV7lBp1SmYKZUTSX7DiYngEJjSojRV+/YrbNIhZ3qjmIq
	czqjUUiJykMAZOZiraUhUmsJR7x95H4zgWS5BOBmXd2cSPzpOEDXDxJG7Ci/YDkuSUBfQ9CbUPn
	9drR9dWy+qCaOYgPEndtk+AuwfV05lMEjgdcJ
X-Gm-Gg: ASbGncvbl2i0dguT67moRgij09HYDEM28wtGpwYc9QuDdnhUYYBC+i484ONoO1Uk1ex
	h4HzxYknvqGG/Rfcy2MoQ1jtdJN515k0q2mG7Wg9545e/QEc3Y9fDTBn06pVNYo8aVkIVA0pHSK
	5me6O6HiwewFqTNz4j5wsx6TeL7bU=
X-Google-Smtp-Source: AGHT+IE8nkI+68Qgy6NjKoLj8c3bNZ3NiejGqaGqUFj0R2IzQEXjAp1CYnixCzSBxrmxoIGwPlxGnmpYBlgSoMnz/mk=
X-Received: by 2002:ac8:5f96:0:b0:474:f1a6:c917 with SMTP id
 d75a77b69052e-47610976675mr39528601cf.4.1741343327418; Fri, 07 Mar 2025
 02:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com> <20250305162132.1106080-8-aleksander.lobakin@intel.com>
In-Reply-To: <20250305162132.1106080-8-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Mar 2025 11:28:36 +0100
X-Gm-Features: AQ5f1Joxdy5jdJHG0g5b6zsYWVs36X3IvHqKfWtxWUE390Z99JJhbzv1OtAO1TI
Message-ID: <CANn89iKyyayTrepHuPbnkhVpu3trkRohdKxeT8RVefP95wognA@mail.gmail.com>
Subject: Re: [PATCH net-next 07/16] idpf: link NAPIs to queues
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak <michal.kubiak@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:22=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Add the missing linking of NAPIs to netdev queues when enabling
> interrupt vectors in order to support NAPI configuration and
> interfaces requiring get_rx_queue()->napi to be set (like XSk
> busy polling).
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 +++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/et=
hernet/intel/idpf/idpf_txrx.c
> index 2f221c0abad8..a3f6e8cff7a0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3560,8 +3560,11 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
>  static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
>  {
>         struct idpf_adapter *adapter =3D vport->adapter;
> +       bool unlock;
>         int vector;
>
> +       unlock =3D rtnl_trylock();

This is probably not what you want here ?

If another thread is holding RTNL, then rtnl_ttrylock() will not add
any protection.

