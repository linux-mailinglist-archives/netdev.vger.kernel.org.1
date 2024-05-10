Return-Path: <netdev+bounces-95539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B918C28B0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63A91F210F7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63017557B;
	Fri, 10 May 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKWCwvy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276FB175540
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358144; cv=none; b=g2zMDz/edwLKF9656PKNh36CtETUPBI63/JGebfvtZ2nHzGDq8dOyJP0RmPhZljdDc659eVnfMMwT4ZiHboIoQncmNNyUnowflBZPDAPgCrv9FoouBIGTJzqKs/7ZBLnDWzKxwko4Wj8ripAmUk42QttbVMIxiHiC0zzz+8+b7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358144; c=relaxed/simple;
	bh=u74CTH8bkR/6+1/nMcqAE4Ha/tcLk2jclSRHENcGDpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCiO8HsJrzwKfi1eGIB9nnRi09GyGOqjzcXAeW1KGAI8Rjh5OavW8JyKWwgvitQQ942poB5sENHR8mm5JkTKiEMToWVZqRhnHncYtUjCJRMfCmfI8OHeDt9pucL0klUWYzArGsWWst+eKYpJ/sF24X26xBNnfb9CWF2kxN3vxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKWCwvy3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-522297f91easo511463e87.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715358140; x=1715962940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HsOPUxHaBpYmZlNT890ywYtohgsUb5QMIi2B10Vcd8=;
        b=sKWCwvy3iC3+/lKcczsnDimom6e5r0Nxf5udZyHSeZsL+1TyQdo6nviYYTfBDlZZPK
         aL4o7nOHv9RelvY/JVumeKIbKryicDIW8aGHv3Zqbzap52TV5d5qMHkNVrcSec+vk+Ct
         0xWgdcO30Xs1OZZcb0xqATiXdG/m3p88C/fjd1onGUeWiPLtkYzqTl03ghlPboLBgIR2
         jeKlNzUT7Icbn0hX03+kB2YSPwDa/aGPTH5FaMTjqa5PSNqhnirsbVZ/6+Dz9uXqcSF+
         rmB8I4YcY/irv6ZqsKCLgQ+d++rg2FaFkhjRfhx52WlOLyUDzy6bHcdVvV5GDM3tjL1n
         u1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358140; x=1715962940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HsOPUxHaBpYmZlNT890ywYtohgsUb5QMIi2B10Vcd8=;
        b=hFafpBis1uhCQo0MDPMdRFbw85RrlIZUMVs2fiYCc1Ob0hK7LGM4eHaTe9tPa1nXrL
         czbT6N97eS8DwUPVdeRHD2TVia4QzTxIDUD0RJJKHehXyKrf0HBhzJr3aaXprEgbQ2LG
         8NEyGUEIoTwQQBr/qezM7rNdKTEYu1RocmPx1CmJ/mDntU6cumI/0ZYrh7I4iSAdxa2J
         TSuTGW5ZaOT5zeqteserzfjDENzB+itHhYzr+eN+eciR+MGuFc1wg/I0eUooBBBL66IY
         ADOaQvdc1UmUiDpJ1UUPj+xyC0xuZVyeUb/uHFWb3XaaXqpwHAGYh3/qzpbFCcvgxVt0
         g+lw==
X-Forwarded-Encrypted: i=1; AJvYcCVdv9Oeturcfj4iTQI8nONNT/kc48gyCtU4mHlc0tNlivLpa8EOtKDg98h9ap78CC4MOozP3pYg+KzZkTqbyDdmiuNoaj+J
X-Gm-Message-State: AOJu0YxqWaqrAixcSmcqZND0qL+Ee8opBOBs4W3pr8WNWGMX+EMm8oRY
	v4ptHOfXkO2xrM5JLc6d5vg5vLWrEo+jyDlHIegWIk65CD0H2QAsLJCu+qnM1b5D4HV+XIYyGuQ
	JBGRZakLBKynlccY/Unz+QDbPMtQnPqUWu5y0
X-Google-Smtp-Source: AGHT+IH2KIcF78KlQb7EAGESCG2yw9jrYqThZThtmmFt4FRjxZ1BqwNQiQVQTwLloGlhLb4SduhLkIqqRmVTvsHCz2M=
X-Received: by 2002:a05:6512:388f:b0:51d:5f0b:816f with SMTP id
 2adb3069b0e04-5220fc7950dmr1953400e87.15.1715358139674; Fri, 10 May 2024
 09:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com> <20240510152620.2227312-9-aleksander.lobakin@intel.com>
In-Reply-To: <20240510152620.2227312-9-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 10 May 2024 09:22:05 -0700
Message-ID: <CAHS8izO7agxQ6nbc=BoK5KuYd_jgVLgJTbZbmEUqarfVn300Tw@mail.gmail.com>
Subject: Re: [PATCH RFC iwl-next 08/12] idpf: reuse libeth's definitions of
 parsed ptype structures
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 8:30=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> idpf's in-kernel parsed ptype structure is almost identical to the one
> used in the previous Intel drivers, which means it can be converted to
> use libeth's definitions and even helpers. The only difference is that
> it doesn't use a constant table (libie), rather than one obtained from
> the device.
> Remove the driver counterpart and use libeth's helpers for hashes and
> checksums. This slightly optimizes skb fields processing due to faster
> checks. Also don't define big static array of ptypes in &idpf_vport --
> allocate them dynamically. The pointer to it is anyway cached in
> &idpf_rx_queue.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |   2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  88 +-----------
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 113 +++++++---------
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 125 +++++++-----------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  69 ++++++----
>  8 files changed, 151 insertions(+), 251 deletions(-)
>
...
>   * idpf_send_get_rx_ptype_msg - Send virtchnl for ptype info
>   * @vport: virtual port data structure
> @@ -2526,7 +2541,7 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *v=
port)
>  {
>         struct virtchnl2_get_ptype_info *get_ptype_info __free(kfree) =3D=
 NULL;
>         struct virtchnl2_get_ptype_info *ptype_info __free(kfree) =3D NUL=
L;
> -       struct idpf_rx_ptype_decoded *ptype_lkup =3D vport->rx_ptype_lkup=
;
> +       struct libeth_rx_pt *ptype_lkup __free(kfree) =3D NULL;
>         int max_ptype, ptypes_recvd =3D 0, ptype_offset;
>         struct idpf_adapter *adapter =3D vport->adapter;
>         struct idpf_vc_xn_params xn_params =3D {};
> @@ -2534,12 +2549,17 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport =
*vport)
>         ssize_t reply_sz;
>         int i, j, k;
>
> +       if (vport->rx_ptype_lkup)
> +               return 0;
> +
>         if (idpf_is_queue_model_split(vport->rxq_model))
>                 max_ptype =3D IDPF_RX_MAX_PTYPE;
>         else
>                 max_ptype =3D IDPF_RX_MAX_BASE_PTYPE;
>
> -       memset(vport->rx_ptype_lkup, 0, sizeof(vport->rx_ptype_lkup));
> +       ptype_lkup =3D kcalloc(max_ptype, sizeof(*ptype_lkup), GFP_KERNEL=
);
> +       if (!ptype_lkup)
> +               return -ENOMEM;
>
>         get_ptype_info =3D kzalloc(sizeof(*get_ptype_info), GFP_KERNEL);
>         if (!get_ptype_info)
> @@ -2604,9 +2624,6 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *v=
port)
>                         else
>                                 k =3D ptype->ptype_id_8;
>
> -                       if (ptype->proto_id_count)
> -                               ptype_lkup[k].known =3D 1;
> -
>                         for (j =3D 0; j < ptype->proto_id_count; j++) {
>                                 id =3D le16_to_cpu(ptype->proto_id[j]);
>                                 switch (id) {
> @@ -2614,18 +2631,18 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport =
*vport)
>                                         if (pstate.tunnel_state =3D=3D
>                                                         IDPF_PTYPE_TUNNEL=
_IP) {
>                                                 ptype_lkup[k].tunnel_type=
 =3D
> -                                               IDPF_RX_PTYPE_TUNNEL_IP_G=
RENAT;
> +                                               LIBETH_RX_PT_TUNNEL_IP_GR=
ENAT;
>                                                 pstate.tunnel_state |=3D
>                                                 IDPF_PTYPE_TUNNEL_IP_GREN=
AT;
>                                         }
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_MAC:
>                                         ptype_lkup[k].outer_ip =3D
> -                                               IDPF_RX_PTYPE_OUTER_L2;
> +                                               LIBETH_RX_PT_OUTER_L2;
>                                         if (pstate.tunnel_state =3D=3D
>                                                         IDPF_TUN_IP_GRE) =
{
>                                                 ptype_lkup[k].tunnel_type=
 =3D
> -                                               IDPF_RX_PTYPE_TUNNEL_IP_G=
RENAT_MAC;
> +                                               LIBETH_RX_PT_TUNNEL_IP_GR=
ENAT_MAC;
>                                                 pstate.tunnel_state |=3D
>                                                 IDPF_PTYPE_TUNNEL_IP_GREN=
AT_MAC;
>                                         }
> @@ -2652,23 +2669,23 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport =
*vport)
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_UDP:
>                                         ptype_lkup[k].inner_prot =3D
> -                                       IDPF_RX_PTYPE_INNER_PROT_UDP;
> +                                       LIBETH_RX_PT_INNER_UDP;
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_TCP:
>                                         ptype_lkup[k].inner_prot =3D
> -                                       IDPF_RX_PTYPE_INNER_PROT_TCP;
> +                                       LIBETH_RX_PT_INNER_TCP;
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_SCTP:
>                                         ptype_lkup[k].inner_prot =3D
> -                                       IDPF_RX_PTYPE_INNER_PROT_SCTP;
> +                                       LIBETH_RX_PT_INNER_SCTP;
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_ICMP:
>                                         ptype_lkup[k].inner_prot =3D
> -                                       IDPF_RX_PTYPE_INNER_PROT_ICMP;
> +                                       LIBETH_RX_PT_INNER_ICMP;
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_PAY:
>                                         ptype_lkup[k].payload_layer =3D
> -                                               IDPF_RX_PTYPE_PAYLOAD_LAY=
ER_PAY2;
> +                                               LIBETH_RX_PT_PAYLOAD_L2;
>                                         break;
>                                 case VIRTCHNL2_PROTO_HDR_ICMPV6:
>                                 case VIRTCHNL2_PROTO_HDR_IPV6_EH:
> @@ -2722,9 +2739,13 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *=
vport)
>                                         break;
>                                 }
>                         }
> +
> +                       idpf_finalize_ptype_lookup(&ptype_lkup[k]);
>                 }
>         }
>
> +       vport->rx_ptype_lkup =3D no_free_ptr(ptype_lkup);
> +

Hi Olek,

I think you need to also patch up the early return from
idpf_send_get_rx_ptype_msg, otherwise vport->rx_ptype_lkup is not set
and I run into a later crash. Something like:

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a0aaa849df24..80d9c09ff407 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2629,7 +2629,7 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vpo=
rt)
                        /* 0xFFFF indicates end of ptypes */
                        if (le16_to_cpu(ptype->ptype_id_10) =3D=3D
                                                        IDPF_INVALID_PTYPE_=
ID)
-                               return 0;
+                               goto done;

                        if (idpf_is_queue_model_split(vport->rxq_model))
                                k =3D le16_to_cpu(ptype->ptype_id_10);
@@ -2756,6 +2756,7 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vpo=
rt)
                }
        }

+done:
        vport->rx_ptype_lkup =3D no_free_ptr(ptype_lkup);

        return 0;

--=20
Thanks,
Mina

