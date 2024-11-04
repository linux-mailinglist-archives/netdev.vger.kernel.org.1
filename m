Return-Path: <netdev+bounces-141584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE739BB929
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420DB1C21FB6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1141C0DED;
	Mon,  4 Nov 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bycxtnoX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9481C07CF
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734867; cv=none; b=iwC+pUcWdYR3s7oKXaPsRKdYfJtZG5JfGfA8Xa3tW0gfB5/WYqSG23sqkzw5hBZali2BNlud6EkuI7AgET4iwKHq0JjHJOW8G+aoABWHTkDvW6G0SxNN2XU1z2GFxI0PqmKrsEVHV81VTyDpkIBc3wXPIPefNDJ77HdCZEg2J0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734867; c=relaxed/simple;
	bh=xQOEdsF3yrWAXcQa6siuBPniWMoj9JznLuwfH15TRtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDPlTnxSAJx2SHHlRsE/ELqmF2LfjVdXaxx2/S52tTzW3GXNHGbG9Ffy/h4NAHxq2Xo+fWB8lSCO/R+YLgtHzUlwC77xBvjxE8ARsM3UToNCTx6LCv0Uxv/z4w4G6y0rFHHsq6uOqV7sfXaRpkv+bN5fl51ZsQ6g4GRYPG0uePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bycxtnoX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730734862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lS1nNVVujw4czQIQmdBkpFCJWF8p7dDW3pFP3fBwFhk=;
	b=bycxtnoXqvc0P37ErEYBopUZFNhNsGExCt6fwComLFFfnMr7lctVUCT3OFGWqV2b2cOftB
	yMJ17AGqHuTcZDrbsfBT5MiMfviBsXv1Kv7AmBZhLCtu6T5v6EqxQYpd2vBwOA6Va+SN77
	Hsb09pFvjHw050PlhEHmPgUngQfCO6E=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-xzxvwxyvNFqHDmUXm0jBew-1; Mon, 04 Nov 2024 10:41:01 -0500
X-MC-Unique: xzxvwxyvNFqHDmUXm0jBew-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5eb5ee84601so219455eaf.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 07:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734859; x=1731339659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS1nNVVujw4czQIQmdBkpFCJWF8p7dDW3pFP3fBwFhk=;
        b=nWRWRRIkXsPXa3YaUXKLmpPJPxKblBfmF1YH3+5vq3hKFuUWWjAOxZvktC7zrLWdVt
         iU0qhCWP88WBr5miDObzt614Vh1jrOt2E3M3/afaw78DZOLTAitQ1LNwwiPSTeNrc4KH
         qAnOFAAm3IzS59KDwsaXRefH/pholUuzDDQX/ND6hd1UnAp2hcOXk/84lzCgJwDvh8xw
         WtaVXp+KxJ/R27sD5msTMSKTFQzw7CaADT4Bp3u3U8Hr1bxiUzQ0af0FxF28cmh2AXyM
         RrC3zq/HaPAM1h21c5OlrWwFbQ4mrFoK54sxKkKt8EJT3E24Ftic10ScpuGuwXjZFkFg
         uAug==
X-Forwarded-Encrypted: i=1; AJvYcCVm6m5zmNqcJn238ILZrIz6pGxdH6s6CGcxEhiQoetjmk3iGxpY8e201UHhWYszdxA9BexXI2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhow5m+sP2GIe1siV6vXnBLmJ5543d7VQuwa5JJ9q7VfvWWIB4
	jf9lrc+qSA/EckIw4VhBLbHobNeuVh20/xNGQxZfp38EG7GWzJ+7vh79mbvyXBOfaDavLbb8pcw
	zleuA0gQaQp/PhWVHilOP1d8qzK4GEL5fcD/M0VB7V3djsPsKCTBuOzfUHQbIKusAAMoZCHVgs4
	wvUaIn8X4GIBmUa4bqvWTlX7aMHi11syl+u8qLES0=
X-Received: by 2002:a05:6871:5821:b0:277:db1c:7c6a with SMTP id 586e51a60fabf-29051bfbe99mr7491039fac.7.1730734859269;
        Mon, 04 Nov 2024 07:40:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTHLgRF7sGR/rUzhL1v/h/ffLFUH/U2Lp7nPDCAr0VVi+CE0aKcH1ds8xUsJODdXa6+Bi8CubOdtJMMguHlqg=
X-Received: by 2002:a05:6871:5821:b0:277:db1c:7c6a with SMTP id
 586e51a60fabf-29051bfbe99mr7491025fac.7.1730734858819; Mon, 04 Nov 2024
 07:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029123637.1974604-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20241029123637.1974604-1-aleksandr.loktionov@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 4 Nov 2024 16:40:47 +0100
Message-ID: <CADEbmW1rJdFZ0ccpo-YLv0W8zQsr9-2eMnncDgR-tE+On0TX5g@mail.gmail.com>
Subject: Re: [PATCH iwl-next v4444] i40e: add ability to reset VF for Tx and
 Rx MDD events
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>, 
	Padraig J Connolly <padraig.j.connolly@intel.com>, maciej.fijalkowski@intel.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:36=E2=80=AFPM Aleksandr Loktionov
<aleksandr.loktionov@intel.com> wrote:
> Implement "mdd-auto-reset-vf" priv-flag to handle Tx and Rx MDD events fo=
r VFs.
> This flag is also used in other network adapters like ICE.
>
> Usage:
> - "on"  - The problematic VF will be automatically reset
>           if a malformed descriptor is detected.
> - "off" - The problematic VF will be disabled.
>
> In cases where a VF sends malformed packets classified as malicious, it c=
an
> cause the Tx queue to freeze, rendering it unusable for several minutes. =
When
> an MDD event occurs, this new implementation allows for a graceful VF res=
et to
> quickly restore operational state.
>
> Currently, VF iqueues are disabled if an MDD event occurs. This patch add=
s the

s/iqueues/queues/

> ability to reset the VF if a Tx or Rx MDD event occurs. It also includes =
MDD
> event logging throttling to avoid dmesg pollution and unifies the format =
of
> Tx and Rx MDD messages.
>
> Note: Standard message rate limiting functions like dev_info_ratelimited(=
)
> do not meet our requirements. Custom rate limiting is implemented,
> please see the code for details.

I am not opposed to the custom rate-limiting, but have you also
considered struct ratelimit_state, ratelimit_state_{init,exit}(),
__ratelimit()?

> Co-developed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Co-developed-by: Padraig J Connolly <padraig.j.connolly@intel.com>
> Signed-off-by:  Padraig J Connolly <padraig.j.connolly@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   4 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   2 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 105 ++++++++++++++++--
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   2 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  11 +-
>  6 files changed, 111 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/etherne=
t/intel/i40e/i40e.h
> index d546567..6d6683c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -87,6 +87,7 @@ enum i40e_state {
>         __I40E_SERVICE_SCHED,
>         __I40E_ADMINQ_EVENT_PENDING,
>         __I40E_MDD_EVENT_PENDING,
> +       __I40E_MDD_VF_PRINT_PENDING,
>         __I40E_VFLR_EVENT_PENDING,
>         __I40E_RESET_RECOVERY_PENDING,
>         __I40E_TIMEOUT_RECOVERY_PENDING,
> @@ -190,6 +191,7 @@ enum i40e_pf_flags {
>          */
>         I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENA,
>         I40E_FLAG_VF_VLAN_PRUNING_ENA,
> +       I40E_FLAG_MDD_AUTO_RESET_VF,
>         I40E_PF_FLAGS_NBITS,            /* must be last */
>  };
>
> @@ -571,7 +573,7 @@ struct i40e_pf {
>         int num_alloc_vfs;      /* actual number of VFs allocated */
>         u32 vf_aq_requests;
>         u32 arq_overflows;      /* Not fatal, possibly indicative of prob=
lems */
> -
> +       unsigned long last_printed_mdd_jiffies; /* MDD message rate limit=
 */
>         /* DCBx/DCBNL capability for PF that indicates
>          * whether DCBx is managed by firmware or host
>          * based agent (LLDPAD). Also, indicates what
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net=
/ethernet/intel/i40e/i40e_debugfs.c
> index abf624d..6a697bf 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -721,7 +721,7 @@ static void i40e_dbg_dump_vf(struct i40e_pf *pf, int =
vf_id)
>                 dev_info(&pf->pdev->dev, "vf %2d: VSI id=3D%d, seid=3D%d,=
 qps=3D%d\n",
>                          vf_id, vf->lan_vsi_id, vsi->seid, vf->num_queue_=
pairs);
>                 dev_info(&pf->pdev->dev, "       num MDD=3D%lld\n",
> -                        vf->num_mdd_events);
> +                        vf->mdd_tx_events.count + vf->mdd_rx_events.coun=
t);
>         } else {
>                 dev_info(&pf->pdev->dev, "invalid VF id %d\n", vf_id);
>         }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net=
/ethernet/intel/i40e/i40e_ethtool.c
> index 1d0d2e5..d146575 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -459,6 +459,8 @@ static const struct i40e_priv_flags i40e_gstrings_pri=
v_flags[] =3D {
>         I40E_PRIV_FLAG("base-r-fec", I40E_FLAG_BASE_R_FEC, 0),
>         I40E_PRIV_FLAG("vf-vlan-pruning",
>                        I40E_FLAG_VF_VLAN_PRUNING_ENA, 0),
> +       I40E_PRIV_FLAG("mdd-auto-reset-vf",
> +                      I40E_FLAG_MDD_AUTO_RESET_VF, 0),
>  };
>
>  #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gstrings_priv_flags)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index cbcfada..07f0a91 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11189,22 +11189,91 @@ static void i40e_handle_reset_warning(struct i4=
0e_pf *pf, bool lock_acquired)
>         i40e_reset_and_rebuild(pf, false, lock_acquired);
>  }
>
> +/**
> + * i40e_print_vf_mdd_event - print VF Tx/Rx malicious driver detect even=
t
> + * @pf: board private structure
> + * @vf: pointer to the VF structure
> + * @is_tx: true - for Tx event, false - for  Rx
> + */
> +static void i40e_print_vf_mdd_event(struct i40e_pf *pf, struct i40e_vf *=
vf,
> +                                      bool is_tx)
> +{
> +       dev_err(&pf->pdev->dev, is_tx ?
> +               "%lld Tx Malicious Driver Detection events detected on PF=
 %d VF %d MAC %pm. mdd-auto-reset-vfs=3D%s\n" :
> +               "%lld Rx Malicious Driver Detection events detected on PF=
 %d VF %d MAC %pm. mdd-auto-reset-vfs=3D%s\n",
> +               vf->mdd_rx_events.count,
> +               pf->hw.pf_id,
> +               vf->vf_id,
> +               vf->default_lan_addr.addr,
> +               test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, pf->flags) ? "on" :=
 "off");
> +}
> +
> +/**
> + * i40e_print_vfs_mdd_events - print VFs malicious driver detect event
> + * @pf: pointer to the PF structure
> + *
> + * Called from i40e_handle_mdd_event to rate limit and print VFs MDD eve=
nts.
> + */
> +static void i40e_print_vfs_mdd_events(struct i40e_pf *pf)
> +{
> +       unsigned int i;
> +
> +       /* check that there are pending MDD events to print */
> +       if (!test_and_clear_bit(__I40E_MDD_VF_PRINT_PENDING, pf->state))
> +               return;
> +
> +       /* VF MDD event logs are rate limited to one second intervals */
> +       if (time_is_after_jiffies(pf->last_printed_mdd_jiffies + HZ * 1))
> +               return;
> +
> +       pf->last_printed_mdd_jiffies =3D jiffies;
> +
> +       for (i =3D 0; i < pf->num_alloc_vfs; i++) {
> +               struct i40e_vf *vf =3D &pf->vf[i];
> +               bool is_printed =3D false;
> +
> +               /* only print Rx MDD event message if there are new event=
s */
> +               if (vf->mdd_rx_events.count !=3D vf->mdd_rx_events.last_p=
rinted) {
> +                       vf->mdd_rx_events.last_printed =3D vf->mdd_rx_eve=
nts.count;
> +                       i40e_print_vf_mdd_event(pf, vf, false);
> +                       is_printed =3D true;
> +               }
> +
> +               /* only print Tx MDD event message if there are new event=
s */
> +               if (vf->mdd_tx_events.count !=3D vf->mdd_tx_events.last_p=
rinted) {
> +                       vf->mdd_tx_events.last_printed =3D vf->mdd_tx_eve=
nts.count;
> +                       i40e_print_vf_mdd_event(pf, vf, true);
> +                       is_printed =3D true;
> +               }
> +
> +               if (is_printed && !test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, =
pf->flags))
> +                       dev_info(&pf->pdev->dev,
> +                                "Use PF Control I/F to re-enable the VF =
#%d\n",
> +                                i);
> +       }
> +}
> +
>  /**
>   * i40e_handle_mdd_event
>   * @pf: pointer to the PF structure
>   *
>   * Called from the MDD irq handler to identify possibly malicious vfs
>   **/
>  static void i40e_handle_mdd_event(struct i40e_pf *pf)
>  {
>         struct i40e_hw *hw =3D &pf->hw;
>         bool mdd_detected =3D false;
>         struct i40e_vf *vf;
>         u32 reg;
>         int i;
>
> -       if (!test_bit(__I40E_MDD_EVENT_PENDING, pf->state))
> +       if (!test_and_clear_bit(__I40E_MDD_EVENT_PENDING, pf->state)) {
> +               /* Since the VF MDD event logging is rate limited, check =
if
> +                * there are pending MDD events.
> +                */
> +               i40e_print_vfs_mdd_events(pf);

Can there ever be anything to print here? i40e_print_vfs_mdd_events()
is also called at the end of i40e_handle_mdd_event(). It always clears
the __I40E_MDD_VF_PRINT_PENDING bit. So how can the bit ever remain
set between invocations? In fact, shouldn't the bit be a local
variable of this function instead of a pf->state bit?

>                 return;
> +       }
>
>         /* find what triggered the MDD event */
>         reg =3D rd32(hw, I40E_GL_MDET_TX);
> @@ -11248,36 +11317,50 @@ static void i40e_handle_mdd_event(struct i40e_p=
f *pf)
>
>         /* see if one of the VFs needs its hand slapped */
>         for (i =3D 0; i < pf->num_alloc_vfs && mdd_detected; i++) {
> +               bool is_mdd_on_tx =3D false;
> +               bool is_mdd_on_rx =3D false;
> +
>                 vf =3D &(pf->vf[i]);
>                 reg =3D rd32(hw, I40E_VP_MDET_TX(i));
>                 if (reg & I40E_VP_MDET_TX_VALID_MASK) {
> +                       set_bit(__I40E_MDD_VF_PRINT_PENDING, pf->state);
>                         wr32(hw, I40E_VP_MDET_TX(i), 0xFFFF);
> -                       vf->num_mdd_events++;
> -                       dev_info(&pf->pdev->dev, "TX driver issue detecte=
d on VF %d\n",
> -                                i);
> -                       dev_info(&pf->pdev->dev,
> -                                "Use PF Control I/F to re-enable the VF\=
n");
> +                       vf->mdd_tx_events.count++;
>                         set_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
> +                       is_mdd_on_tx =3D true;
>                 }
>
>                 reg =3D rd32(hw, I40E_VP_MDET_RX(i));
>                 if (reg & I40E_VP_MDET_RX_VALID_MASK) {
> +                       set_bit(__I40E_MDD_VF_PRINT_PENDING, pf->state);
>                         wr32(hw, I40E_VP_MDET_RX(i), 0xFFFF);
> -                       vf->num_mdd_events++;
> -                       dev_info(&pf->pdev->dev, "RX driver issue detecte=
d on VF %d\n",
> -                                i);
> -                       dev_info(&pf->pdev->dev,
> -                                "Use PF Control I/F to re-enable the VF\=
n");
> +                       vf->mdd_rx_events.count++;
>                         set_bit(I40E_VF_STATE_DISABLED, &vf->vf_states);
> +                       is_mdd_on_rx =3D true;
> +               }
> +
> +               if ((is_mdd_on_tx || is_mdd_on_rx) &&
> +                   test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, pf->flags)) {
> +                       /* VF MDD event counters will be cleared by
> +                        * reset, so print the event prior to reset.
> +                        */
> +                       if (is_mdd_on_rx)
> +                               i40e_print_vf_mdd_event(pf, vf, false);
> +                       if (is_mdd_on_tx)
> +                               i40e_print_vf_mdd_event(pf, vf, true);

I see there's no rate-limiting applied here. Is this intentional?

> +
> +                       i40e_vc_reset_vf(vf, true);
>                 }
>         }
>
>         /* re-enable mdd interrupt cause */
>         clear_bit(__I40E_MDD_EVENT_PENDING, pf->state);

Can you remove this 2nd clearing of the __I40E_MDD_EVENT_PENDING bit?
If the interrupt handler detects a MDD event while we're still
printing the message about the previous one, we don't want to forget
it by clearing it here.

Michal

>         reg =3D rd32(hw, I40E_PFINT_ICR0_ENA);
>         reg |=3D  I40E_PFINT_ICR0_ENA_MAL_DETECT_MASK;
>         wr32(hw, I40E_PFINT_ICR0_ENA, reg);
>         i40e_flush(hw);
> +
> +       i40e_print_vfs_mdd_events(pf);
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers=
/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 662622f..5b4618e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -216,7 +216,7 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
>   * @notify_vf: notify vf about reset or not
>   * Reset VF handler.
>   **/
> -static void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf)
> +void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf)
>  {
>         struct i40e_pf *pf =3D vf->pf;
>         int i;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers=
/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> index 66f95e2..5cf74f1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> @@ -64,6 +64,12 @@ struct i40evf_channel {
>         u64 max_tx_rate; /* bandwidth rate allocation for VSIs */
>  };
>
> +struct i40e_mdd_vf_events {
> +       u64 count;      /* total count of Rx|Tx events */
> +       /* count number of the last printed event */
> +       u64 last_printed;
> +};
> +
>  /* VF information structure */
>  struct i40e_vf {
>         struct i40e_pf *pf;
> @@ -92,7 +98,9 @@ struct i40e_vf {
>
>         u8 num_queue_pairs;     /* num of qps assigned to VF vsis */
>         u8 num_req_queues;      /* num of requested qps */
> -       u64 num_mdd_events;     /* num of mdd events detected */
> +       /* num of mdd tx and rx events detected */
> +       struct i40e_mdd_vf_events mdd_rx_events;
> +       struct i40e_mdd_vf_events mdd_tx_events;
>
>         unsigned long vf_caps;  /* vf's adv. capabilities */
>         unsigned long vf_states;        /* vf's runtime states */
> @@ -120,6 +128,7 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_=
vfs);
>  int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
>                            u32 v_retval, u8 *msg, u16 msglen);
>  int i40e_vc_process_vflr_event(struct i40e_pf *pf);
> +void i40e_vc_reset_vf(struct i40e_vf *vf, bool notify_vf);
>  bool i40e_reset_vf(struct i40e_vf *vf, bool flr);
>  bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr);
>  void i40e_vc_notify_vf_reset(struct i40e_vf *vf);
> --
> 2.25.1
>
>


