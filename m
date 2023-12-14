Return-Path: <netdev+bounces-57257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F21812A81
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824FC28159C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7ED1EA6F;
	Thu, 14 Dec 2023 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtDzG4GC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346DBD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702543067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXOBVzpvKvhd2chS55XvNzJeAhU9TyiGp328MmRIZKo=;
	b=QtDzG4GC0f8XqBd38sNmqibPCql7IKu6/fEuI9/bOBV8EHFn6n/FW5zgBU+MqjmNYS9QsN
	8/14jKbYXgpXflNdBgOhSjfgBK9ZELjlzWK4YdTaa+RkaFR6hjvxZBzmfHcZOo2P6QiVso
	mbD+5JnLq7sJlcg9cWaqk/8p6rw5mCk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-NNpM1p-DOaOyznl5-Zm_vA-1; Thu, 14 Dec 2023 03:37:45 -0500
X-MC-Unique: NNpM1p-DOaOyznl5-Zm_vA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-552233ea97eso764083a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543064; x=1703147864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXOBVzpvKvhd2chS55XvNzJeAhU9TyiGp328MmRIZKo=;
        b=P1qDGxrogWUKpJF04paztJpKk/TOjmvU1tq1LZduyubeXYcSZsIDtcViIqpFFXOKgs
         TZa2yALlwkAiX8SC728zFM9qYOWeOT91bT0LyA3bdJ9o6VKAscAmZZzO4Pev/VLoFcgM
         lm1nRizUEfa69RfWTWp8z+sx/eaJTQyFNmashDPWeTsEEqCyxMGkA4VzNZV1M1imJw1y
         Quuuh62oAEGIzmC+M7jNSU7oaEbXE6kHCZ/hJLYrDpaa5v7A2aY52HpHCpQ/bVb3hf47
         3J77t1AFwAZftunUrPP8dt7p/ViYekBzuMsXHam5DGhKh6d/RJ+q11Wk77duLWk12UZo
         d7UQ==
X-Gm-Message-State: AOJu0YzXecopXu+tFG2JBc5RwwpgnByMjP8n2cyZFMNSB6cnBGoBJMMp
	PrfgqMmd6gGnO55VzqN5kfEHHSJ70Zx+s00VNHPAPe5h9gIWFg0obhw22mi/DyIHFXL8tD2w9Ic
	bZ+kmEPN+JRTZ/gAlGuhraUn4nej0zBal
X-Received: by 2002:a50:9342:0:b0:552:33b9:f810 with SMTP id n2-20020a509342000000b0055233b9f810mr799405eda.62.1702543064090;
        Thu, 14 Dec 2023 00:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG+WzqaxvbKUUT6dFMVEqdFxaQHNl67nWn83NQ3R+BT7W/RHMlx6Oju7nRuw4HEPH80O5rEuXtIotqixn5TRs=
X-Received: by 2002:a50:9342:0:b0:552:33b9:f810 with SMTP id
 n2-20020a509342000000b0055233b9f810mr799399eda.62.1702543063730; Thu, 14 Dec
 2023 00:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
In-Reply-To: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 14 Dec 2023 09:37:32 +0100
Message-ID: <CADEbmW03axMX30oiEG0iNLLiGYaTi6pqx9qdrLsR7DSC-x-fyw@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2] ice: Reset VF on Tx MDD event
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	pmenzel@molgen.mpg.de, lukasz.czapnik@intel.com, 
	Liang-Min Wang <liang-min.wang@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Pawel Chmielewski
<pawel.chmielewski@intel.com> wrote:
> From: Liang-Min Wang <liang-min.wang@intel.com>
>
> In cases when VF sends malformed packets that are classified as malicious=
,
> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
> for several minutes being unusable. This behavior can be reproduced with
> DPDK application, testpmd.
>
> When Malicious Driver Detection event occurs, perform graceful VF reset
> to quickly bring VF back to operational state. Add a log message to
> notify about the cause of the reset.

Sorry for bringing this up so late, but I have just now realized this:
Wasn't freezing of the queue originally the intended behavior, as a
penalty for being malicious?
Shouldn't these resets at least be guarded by ICE_FLAG_MDD_AUTO_RESET_VF?

Michal

> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> Changelog
> v1->v2:
> Reverted unneeded formatting change, fixed commit message, fixed a log
> message with a correct event name.
> ---
>
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 3c9419b05a2a..ee9752af6397 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1839,6 +1839,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf=
)
>                         if (netif_msg_tx_err(pf))
>                                 dev_info(dev, "Malicious Driver Detection=
 event TX_TCLAN detected on VF %d\n",
>                                          vf->vf_id);
> +                       dev_info(dev,
> +                                "PF-to-VF reset on VF %d due to Tx MDD T=
X_TCLAN event\n",
> +                                vf->vf_id);
> +                       ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>                 }
>
>                 reg =3D rd32(hw, VP_MDET_TX_TDPU(vf->vf_id));
> @@ -1849,6 +1853,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf=
)
>                         if (netif_msg_tx_err(pf))
>                                 dev_info(dev, "Malicious Driver Detection=
 event TX_TDPU detected on VF %d\n",
>                                          vf->vf_id);
> +                       dev_info(dev,
> +                                "PF-to-VF reset on VF %d due to Tx MDD T=
X_TDPU event\n",
> +                                vf->vf_id);
> +                       ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>                 }
>
>                 reg =3D rd32(hw, VP_MDET_RX(vf->vf_id));
> --
> 2.37.3
>
>


