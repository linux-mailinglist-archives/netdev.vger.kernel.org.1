Return-Path: <netdev+bounces-146139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B49D217E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90FC281DF7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07201158874;
	Tue, 19 Nov 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1zI5YB4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E01A28C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004414; cv=none; b=CbcNPFuvMHRXQcWSG+fZx6DOm9dQes3txdajUY9YqvRoPk3qXWV7poOj87NI5N184Tf6n7fjmeFKp2MxJPm+drA3uZ87cDskvirp+4uHWJW3igQLidFeyGoY54eGWkBgsmn+CN+dcTct8hiPsciNQeJbsJO4rdu1sVJRwmE5mRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004414; c=relaxed/simple;
	bh=3zZ62U4qhco3CNHwgl7skCP7WNUKVcEgubRQm3RM3PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2/6e0XoDeym1xtOjzTQPGfpI3HAjvjzbY1CqXZ7jTXB4ANaXWdIY7VzFY0lGeZVl7el2awQoMpEWmQqoXdvvvtwVuTkQAF6/UPtzJKFb8cBODQibMagiUhfVfI8hSZ9Py+Ib8yzxp2EHHLxyyB0LAY1+sMkZed3PEiu7+ePxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1zI5YB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732004411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1CXWCUIN02YGV/rD9pOZpyC66KfILNm9G423syFn+E=;
	b=D1zI5YB45mrqmoKvT6TWcpZSbhphWv3RM6XdVFu2PoYJW0l945H8GY8nsf0ju+BWuMFkdD
	96v3JrBM0aXH6k0mDhkdHkWcouXriy7STtRw0ZBXb+jp/oOHIYji+0o9Iud1NHchfu6JWP
	2VU7zujKAesulZBMQPHAUoH0nvqJG8U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-PYQu1j-BNkqVUXHbcZMJbQ-1; Tue, 19 Nov 2024 03:20:09 -0500
X-MC-Unique: PYQu1j-BNkqVUXHbcZMJbQ-1
X-Mimecast-MFC-AGG-ID: PYQu1j-BNkqVUXHbcZMJbQ
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e61c30daf2so581088b6e.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 00:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732004409; x=1732609209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1CXWCUIN02YGV/rD9pOZpyC66KfILNm9G423syFn+E=;
        b=ToieFNiz2ir4TJ2qgtCroXc2jzpygKDY5Hz4BpTLJYMZjMhqB6PAbVF9ZcaFsmLWiS
         6BIXZ3eqrZzGxpzijBJo1jv3vbRd+7g9jr4666ahF2ttivmUIyWBhlmg2GIxvxc0M9Qw
         iQvxzg4bcSxhUiGg4B/BbbuUGmll/Of+9EHRlomE+aBLNKquj63+KynMMdMZngpxWdka
         JVo0VUiR23ThyWwN42Dpj6aSE57yuTPKauh9w9Ie4+0/ObmNjoMeAjBv8+9s842fbWnK
         hl86WrmHGGChRhduRwfcfBGtmdwHu5fkNV/rDeTJ/31lHTeP+AlkX5Ms/CBCtm1T9saU
         NbGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5lDjemo7Y/S/w2jCaAA7gYDz4ok0zEY7L982u0vhMYrDIWKj4Q1LEnVEF7mkMLEtctpRb1z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5f0KFC6FE/+4Jez/M2bXce1ESFJtbUMhCbVZj6XuT91hH/Zu
	zozncdQDmTuZidfsFUbtlLW2+9IYVT8eT40VR8u8LZOQfPkW/V7t/U14u+mBgbdmyd8empDir/A
	DU7/3UJhIEuHJzud4uieorwb23N6crX9qynw42Lobpn9kXPChCmKLKb+RFLuIEhCaHUzgrTYKox
	U8933XSUG15fWHseZJzDmBdw2ZMqiZ
X-Gm-Gg: ASbGncubNGd/19EDjkMllr8P0dMyhe/NDfceiW5EvQiZfQraqk+xMR5PEJ3bU+wgA9w
	upvwrujiTbbU3Z6f1jQ85QOK76H9i3+k=
X-Received: by 2002:a05:6870:7906:b0:285:82b3:6313 with SMTP id 586e51a60fabf-2962dd36d65mr3241688fac.6.1732004408802;
        Tue, 19 Nov 2024 00:20:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVej4KCimNB7KEy4PUfgoVZNkglQWU1zdKBUn/nZrc5o20NvTcXpXkLvp2atTFp53OWYaPthw/YPmVvvtETQo=
X-Received: by 2002:a05:6870:7906:b0:285:82b3:6313 with SMTP id
 586e51a60fabf-2962dd36d65mr3241676fac.6.1732004408418; Tue, 19 Nov 2024
 00:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115194216.2718660-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20241115194216.2718660-1-aleksandr.loktionov@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 19 Nov 2024 09:19:56 +0100
Message-ID: <CADEbmW0vc-M+xEHCeL+92TecJTNRB_GvzsBjAaMz8n2kCjT3mw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5] i40e: add ability to reset
 VF for Tx and Rx MDD events
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>, 
	Padraig J Connolly <padraig.j.connolly@intel.com>, maciej.fijalkowski@intel.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:42=E2=80=AFPM Aleksandr Loktionov
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
> Currently, VF queues are disabled if an MDD event occurs. This patch adds=
 the
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
>
> Co-developed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Co-developed-by: Padraig J Connolly <padraig.j.connolly@intel.com>
> Signed-off-by: Padraig J Connolly <padraig.j.connolly@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v4->v5 + documentation - 2nd clear_bit(__I40E_MDD_EVENT_PENDING) * rate l=
imit
> v3->v4 refactor two helper functions into one
> v2->v3 fix compilation issue
> v1->v2 fix compilation issue
> ---
>  .../device_drivers/ethernet/intel/i40e.rst    |  12 ++
>  drivers/net/ethernet/intel/i40e/i40e.h        |   4 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   2 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 +++++++++++++++---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   2 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  11 +-
>  7 files changed, 123 insertions(+), 17 deletions(-)
[...]
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index cbcfada..b1f7316 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11189,22 +11189,88 @@ static void i40e_handle_reset_warning(struct i4=
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

I disagree with your argument from the v3 thread about greppability.
I think using "%lld %cx [...]" and
  is_tx ? 'T' : 'R',
the string would still be easy enough to grep for.
But opinions may vary about this. So

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>




> +               is_tx ? vf->mdd_tx_events.count : vf->mdd_rx_events.count=
,
> +               pf->hw.pf_id,
> +               vf->vf_id,
> +               vf->default_lan_addr.addr,
> +               str_on_off(test_bit(I40E_FLAG_MDD_AUTO_RESET_VF, pf->flag=
s)));
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
> +       if (!__ratelimit(&pf->mdd_message_rate_limit))
> +               return;
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
>                 return;
> +       }
>
>         /* find what triggered the MDD event */
>         reg =3D rd32(hw, I40E_GL_MDET_TX);
> @@ -11248,36 +11314,48 @@ static void i40e_handle_mdd_event(struct i40e_p=
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
> +
> +                       i40e_vc_reset_vf(vf, true);
>                 }
>         }
>
> -       /* re-enable mdd interrupt cause */
> -       clear_bit(__I40E_MDD_EVENT_PENDING, pf->state);
>         reg =3D rd32(hw, I40E_PFINT_ICR0_ENA);
>         reg |=3D  I40E_PFINT_ICR0_ENA_MAL_DETECT_MASK;
>         wr32(hw, I40E_PFINT_ICR0_ENA, reg);
>         i40e_flush(hw);
> +
> +       i40e_print_vfs_mdd_events(pf);
>  }
>
>  /**
> @@ -15970,6 +16048,9 @@ static int i40e_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>                          ERR_PTR(err),
>                          i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status))=
;
>
> +       /* VF MDD event logs are rate limited to one second intervals */
> +       ratelimit_state_init(&pf->mdd_message_rate_limit, 1 * HZ, 1);
> +
>         /* Reconfigure hardware for allowing smaller MSS in the case
>          * of TSO, so that we avoid the MDD being fired and causing
>          * a reset in the case of small MSS+TSO.
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


