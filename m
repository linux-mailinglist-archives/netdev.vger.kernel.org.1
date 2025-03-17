Return-Path: <netdev+bounces-175427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D26A65E01
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4DA3AA4CA
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272FA143888;
	Mon, 17 Mar 2025 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSUFOXu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85CF9DA
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239854; cv=none; b=RttS7kk0SoO0mHgJnU2ywEnFVxJMyuY5rIWWeTlux7XNwJIY96GrjMiDKV680G0YQVyUG9UgEVaL3ceUOfGsZ+TLpoTGxfM7mVj28e4N7vm/duKjExVoEDBADIW8RRTEjmvXk9kW86qUj87t+F7DMEtkOphBdPXHGeZwXM0c6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239854; c=relaxed/simple;
	bh=a2Dpa8WjodPztabxLEaUiOxiClVkS8d9/rwX2GEnCEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwz8UaX2fRa3vmjRDxXbxkRGTqZS7ZxAAAAr6qKGywAm2ivAFljWpLvgWoA7rSLSmzPAarmwji4hEbxgSW0b5B11bNOwZu91dVC0BasIXvYcffAIVkmodtcBHeVfuVFteFN49sCx3yWMVC5flFJw9zdfFHJugVfNAQWcGj6JSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSUFOXu3; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d445a722b9so26553795ab.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742239851; x=1742844651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jx8sDLM9tp/ovwhQaouHwQefXyZrcfvMomAxp7cSD/s=;
        b=LSUFOXu3D/1eRQyjvR/rzObr6IX6hGrMSMQDvLJcdTiii4Tk8sztCxpgcWqN00KJL1
         oXCTIzHk+hmB8kmIeScv7wBng9URaGKWqW8YAUR80RCB8UMWFxrv07QtujhOGyYmMNGP
         pmBfTAauhSYsF7v7S3v5w20pBTkUPc5irD/aMHnf+3H2J6Ep+ikYh0M8q3xGgjM/QVmX
         1j7gY1Q+a/5m/wESQCFUDEce4bIub+Bgd88om+z4v43XIDG61hF1lapOnRrWwbcniHyc
         j6MfdlhNhmwZZkupnym9zo1IZuB6nf+ZFsZcAB3cnKj7XGT6FV9r/7HwCdMrsEvfL2Wg
         iULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742239851; x=1742844651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jx8sDLM9tp/ovwhQaouHwQefXyZrcfvMomAxp7cSD/s=;
        b=OtET0IcsUBTi26Dh1YU621XCfUwymGcmSt3OyzoHg1hsrQdpVH3kSRFFdKH0Ik4wvz
         Vkg77rv1ZEhrwT7uRjMD84kBHD8DDec5Xjp6mXXN1KWwJO5RU6/X9dwWgn8HOaRfgrfA
         a5MGmlX1sjBNLrXRZsxcq5uWxMv9MPBRFfFWYuLm1DIN+qfN8qRdK8nOD+nLS852f9Of
         JNOk55+46zZvcbE15D71C8ZbgfibokfKvByOk2e2gp8BAVt7KweYhWePp/T3Cyzydsrt
         E5u8p66ACghpXy/jqwsysS6U8lFtg67aBcSig9yIMyBe+zXOLt+vada9vFrloxG+5LQx
         r8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXDpX6bw+7c71AnWXj1pHDG1Xz4iSxEgb1qk2ZPgIZvXVwCpAZjrEX3BcwWoteg/490AjbT4+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeq2ss+B0oK4/8UHkWTWrQy2zL496/zdMj6qrJou3zNzoUW+ZM
	cRyJGLmmFWTgOWwdfwB7YJBtI1/0i32qVRs22feEN9XpPCpZGSUsNMgv2jmpi7/kXbf9HyJS+h5
	WCEjdPKSCSHvSpIANbJQj0dZSyBE=
X-Gm-Gg: ASbGncv7F9LlLKAqSi3jrkWeeqLpj3LBo0DOAxfW5saDRai4qAcOWHM6ZYoya56hW09
	LGr9q2G14z1DnnJB6ELsURJ2LyA2jjOzbma9/z9Axk7mMvmUuw6wbUu8qeJJxidU06N96vb3/qh
	F2Q1zMIyJSW/zLzkZfOc89Hw1P
X-Google-Smtp-Source: AGHT+IFiwMt2Y9x5Vhkn9xYzSSBIevauY3JgCy5nlv/IShFrm9jr2llFfjFa5nGL6BLxRba2Y/jlumWgoZi+kTvakXw=
X-Received: by 2002:a05:6e02:2485:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d483a765d0mr149037575ab.15.1742239851426; Mon, 17 Mar 2025
 12:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317103205.573927-1-mbloch@nvidia.com>
In-Reply-To: <20250317103205.573927-1-mbloch@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 17 Mar 2025 15:30:40 -0400
X-Gm-Features: AQ5f1JqZ1pqnoRy1UIx_On3cMyoV1hHeTrsqlGq8us4szh5q05pnILeIQ7zXi4c
Message-ID: <CADvbK_ftLCTfmj=Z5yhuatt5eOvxuf=sxbduwdjK4mfuw=4wVw@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: Force software GSO only in tunnel mode
To: Mark Bloch <mbloch@nvidia.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Christian Hopps <chopps@labn.net>, Cosmin Ratiu <cratiu@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, 
	wangfe <wangfe@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:32=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Cosmin Ratiu <cratiu@nvidia.com>
>
> The cited commit fixed a software GSO bug with VXLAN + IPSec in tunnel
> mode. Unfortunately, it is slightly broader than necessary, as it also
> severely affects performance for Geneve + IPSec transport mode over a
> device capable of both HW GSO and IPSec crypto offload. In this case,
> xfrm_output unnecessarily triggers software GSO instead of letting the
> HW do it. In simple iperf3 tests over Geneve + IPSec transport mode over
> a back-2-back pair of NICs with MTU 1500, the performance was observed
> to be up to 6x worse when doing software GSO compared to leaving it to
> the hardware.
>
> This commit makes xfrm_output only trigger software GSO in crypto
> offload cases for already encapsulated packets in tunnel mode, as not
> doing so would then cause the inner tunnel skb->inner_networking_header
> to be overwritten and break software GSO for that packet later if the
> device turns out to not be capable of HW GSO.
>
For UDP tunnels, there are two types:

- ENCAP_TYPE_ETHER encaps an ether packet (e.g., VXLAN, Geneve).
- ENCAP_TYPE_IPPROTO encaps an ipproto packet (e.g., SCTP over UDP).

When performing GSO via skb_udp_tunnel_segment():

- ENCAP_TYPE_ETHER relies on inner_network_header to locate the
  network header.
- ENCAP_TYPE_IPPROTO relies on inner_transport_header to locate
  the transport header.

However, both IPsec transport and tunnel modes modify
inner_transport_header. This patch raises a concern that GSO may
not work correctly for ENCAP_TYPE_IPPROTO UDP tunnels over IPsec
in transport mode.

> Taking a closer look at the conditions for the original bug, to better
> understand the reasons for this change:
> - vxlan_build_skb -> iptunnel_handle_offloads sets inner_protocol and
>   inner network header.
> - then, udp_tunnel_xmit_skb -> ip_tunnel_xmit adds outer transport and
>   network headers.
> - later in the xmit path, xfrm_output -> xfrm_outer_mode_output ->
>   xfrm4_prepare_output -> xfrm4_tunnel_encap_add overwrites the inner
>   network header with the one set in ip_tunnel_xmit before adding the
>   second outer header.
> - __dev_queue_xmit -> validate_xmit_skb checks whether GSO segmentation
>   needs to happen based on dev features. In the original bug, the hw
>   couldn't segment the packets, so skb_gso_segment was invoked.
> - deep in the .gso_segment callback machinery, __skb_udp_tunnel_segment
>   tries to use the wrong inner network header, expecting the one set in
>   iptunnel_handle_offloads but getting the one set by xfrm instead.
> - a bit later, ipv6_gso_segment accesses the wrong memory based on that
>   wrong inner network header.
>
> With the new change, the original bug (or similar ones) cannot happen
> again, as xfrm will now trigger software GSO before applying a tunnel.
> This concern doesn't exist in packet offload mode, when the HW adds
> encapsulation headers. For the non-offloaded packets (crypto in SW),
> software GSO is still done unconditionally in the else branch.
>
> Fixes: a204aef9fd77 ("xfrm: call xfrm_output_gso when inner_protocol is s=
et in xfrm_output")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  net/xfrm/xfrm_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index f7abd42c077d..42f1ca513879 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -758,7 +758,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>                 skb->encapsulation =3D 1;
>
>                 if (skb_is_gso(skb)) {
> -                       if (skb->inner_protocol)
> +                       if (skb->inner_protocol && x->props.mode =3D=3D X=
FRM_MODE_TUNNEL)
>                                 return xfrm_output_gso(net, sk, skb);
>
>                         skb_shinfo(skb)->gso_type |=3D SKB_GSO_ESP;
> --
> 2.34.1
>

