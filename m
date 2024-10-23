Return-Path: <netdev+bounces-138363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7959AD10F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F91C20AC2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7771C9DFD;
	Wed, 23 Oct 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNgnoDQG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01BDDAB
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701279; cv=none; b=FfxGuIuZSVbPQFTn5NdZTwCqYGWKtDB7swATE8zll0EZ3s7fX24RIhIMgm/BeOWL2dxilT/VAAm45Z5kKYVMzAZbTxV3sgCDXxu59f3gYn+6mJJh5kzgUsyxw2nVm5G2o2l/ZLyBCHE2jCUxD/9S/IB6tyWl0QyXa9GKfK18ovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701279; c=relaxed/simple;
	bh=uj+rvWe9bUE/N5ecGd6PkJO2ZBzNESTtX4hFacbehEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFNkEjgksh3xgarwpDzgDlycG3GwfnY+cuBaSAjIPvG6+KyhOCWHthHeKcBl4re8lDEi/AHpubjI62efD2ZCfD7YkWnt5voo8s4ftQ3nf91FIPzjwCa3pn4Le04Py0imTSiWDbSRqzUAnK11TCQBOZiY/Xb7GGFLfXEMro62F/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNgnoDQG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729701276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDjPu0HKkK5aBQcXZHwZc+01c/n/1MIBzXvu3KvRUj0=;
	b=JNgnoDQGZRq5+0bPLbrTHcqXptbGLtAv5uNQK3bFmwXeWoyT2+LrtE6vLSqPXJrvOxRBTK
	2oDQZ5Y2XlRkYoiNTNLEtTfk8N4Zr0pZ+UhHv+CnK1NocRgsG5U109/kC37rwkdQEASp3k
	JrDJKBASRISVNS+xfxHOC++HQpOyhZw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-P137gj2JPUOpJb9LqhUKFg-1; Wed, 23 Oct 2024 12:34:34 -0400
X-MC-Unique: P137gj2JPUOpJb9LqhUKFg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-717fac47d50so1794735a34.2
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 09:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729701274; x=1730306074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDjPu0HKkK5aBQcXZHwZc+01c/n/1MIBzXvu3KvRUj0=;
        b=sBA4AmXbfy9lRAd8e3ybgUwHlROhLnJeIMMIX+cnD9UiE3HhloVeDc/P/Uyb5E1fNa
         Bx70XmVNnO5cvZlmqp7XCiqDhQ/KLQHFkDNXGlMk5BjCrS1QjPgkEKvUvtS5gEWIBDMR
         1Vw8JWk18h1dE52JQ+Mz4BYNokO1yNInd10jxjNnNo0Py0Boy/YaWUx5RC1auNhUefFr
         /CbgyX/PLywQXZcjClz28Agjxs6TZlt9fYKWoLn+eI3XblyL63l1pylZsmE4tMpb/JhU
         +QBeLNd0g6GkFmP/kHn3VBm8M6plLuCblpCBEPk/QMTXlQblDk2MoJZFRL+XD57Dyu0z
         CeHg==
X-Forwarded-Encrypted: i=1; AJvYcCWbbxd5dgTdulgDkXekJM6u779L595IYnzEKUsBOfnjAjGOyI4iX1o1K3U+eHz3TvRnexFjXR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRaG6aa3LLfHRyoAg8XeSQXspCY2yOL3Y09MbXmdxwFPf9KjD
	RdbFsOegX17PKExaitfCVbrh97VTs1LOjsgDTWs4p9+TDVID28kEtl/yChN3BEeKojPOuDjKL3q
	kvHV9m/Un+D/Zza9Ml+Zb+HPjNdoPxeahkX9hNLRprluVLmvae8oYLmiMzWv0U2qvKFwUG3VJT2
	ZrC8yeBZjvpOVAWUGk8mNzwJyUAj30
X-Received: by 2002:a05:6870:15c4:b0:26c:641a:871c with SMTP id 586e51a60fabf-28ccb61e731mr808295fac.9.1729701273916;
        Wed, 23 Oct 2024 09:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWi8CFeAzIYmDe8SJ56G9u/jtICEOTkvzKOLeMPcGdhr2tyyipF8GsKZJbemg9coQAABzBECoZ22L8YfYLVJs=
X-Received: by 2002:a05:6870:15c4:b0:26c:641a:871c with SMTP id
 586e51a60fabf-28ccb61e731mr808290fac.9.1729701273573; Wed, 23 Oct 2024
 09:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016093011.318078-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20241016093011.318078-1-aleksandr.loktionov@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 23 Oct 2024 18:34:21 +0200
Message-ID: <CADEbmW2NRmYZvx7+yki8MR0tX+OzZovAYO-u+o6adHdYyaFn9w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix race condition by
 adding filter's intermediate sync state
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:30=E2=80=AFAM Aleksandr Loktionov
<aleksandr.loktionov@intel.com> wrote:
>
> Fix a race condition in the i40e driver that leads to MAC/VLAN filters
> becoming corrupted and leaking. Address the issue that occurs under
> heavy load when multiple threads are concurrently modifying MAC/VLAN
> filters by setting mac and port VLAN.
>
> 1. Thread T0 allocates a filter in i40e_add_filter() within
>         i40e_ndo_set_vf_port_vlan().
> 2. Thread T1 concurrently frees the filter in __i40e_del_filter() within
>         i40e_ndo_set_vf_mac().
> 3. Subsequently, i40e_service_task() calls i40e_sync_vsi_filters(), which
>         refers to the already freed filter memory, causing corruption.

I think an important detail is missing from the race description. I am
guessing it could happen like this:

1. A thread allocates a filter with i40e_add_filter().
2. i40e_service_task() calls i40e_sync_vsi_filters(), which adds an
entry to its local tmp_add_list referencing the filter. It releases
vsi->mac_filter_hash_lock before it processes tmp_add_list.
3. A thread frees the filter in __i40e_del_filter(). This is while
holding vsi->mac_filter_hash_lock.
4. The service task processes tmp_add_list and dereferences the
already freed filter.

Do I understand the race right?

Michal


> Reproduction steps:
> 1. Spawn multiple VFs.
> 2. Apply a concurrent heavy load by running parallel operations to change
>         MAC addresses on the VFs and change port VLANs on the host.
> 3. Observe errors in dmesg:
> "Error I40E_AQ_RC_ENOSPC adding RX filters on VF XX,
>         please set promiscuous on manually for VF XX".
>
> Exact code for stable reproduction Intel can't open-source now.
>
> The fix involves implementing a new intermediate filter state,
> I40E_FILTER_NEW_SYNC, for the time when a filter is on a tmp_add_list.
> These filters cannot be deleted from the hash list directly but
> must be removed using the full process.
>
> Fixes: 278e7d0b9d68 ("i40e: store MAC/VLAN filters in a hash with the MAC=
 Address as key")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1->v2 change commit title, removed RESERVED state byt request in review
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 12 ++++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/etherne=
t/intel/i40e/i40e.h
> index 2089a0e..2e205218 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -755,6 +755,8 @@ enum i40e_filter_state {
>         I40E_FILTER_ACTIVE,             /* Added to switch by FW */
>         I40E_FILTER_FAILED,             /* Rejected by FW */
>         I40E_FILTER_REMOVE,             /* To be removed */
> +       I40E_FILTER_NEW_SYNC,           /* New, not sent yet, is in
> +                                          i40e_sync_vsi_filters() */
>  /* There is no 'removed' state; the filter struct is freed */
>  };
>  struct i40e_mac_filter {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net=
/ethernet/intel/i40e/i40e_debugfs.c
> index abf624d..208c2f0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -89,6 +89,7 @@ static char *i40e_filter_state_string[] =3D {
>         "ACTIVE",
>         "FAILED",
>         "REMOVE",
> +       "NEW_SYNC",
>  };
>
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 25295ae..55fb362 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1255,6 +1255,7 @@ int i40e_count_filters(struct i40e_vsi *vsi)
>
>         hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
>                 if (f->state =3D=3D I40E_FILTER_NEW ||
> +                   f->state =3D=3D I40E_FILTER_NEW_SYNC ||
>                     f->state =3D=3D I40E_FILTER_ACTIVE)
>                         ++cnt;
>         }
> @@ -1441,6 +1442,8 @@ static int i40e_correct_mac_vlan_filters(struct i40=
e_vsi *vsi,
>
>                         new->f =3D add_head;
>                         new->state =3D add_head->state;
> +                       if (add_head->state =3D=3D I40E_FILTER_NEW)
> +                               add_head->state =3D I40E_FILTER_NEW_SYNC;
>
>                         /* Add the new filter to the tmp list */
>                         hlist_add_head(&new->hlist, tmp_add_list);
> @@ -1550,6 +1553,8 @@ static int i40e_correct_vf_mac_vlan_filters(struct =
i40e_vsi *vsi,
>                                 return -ENOMEM;
>                         new_mac->f =3D add_head;
>                         new_mac->state =3D add_head->state;
> +                       if (add_head->state =3D=3D I40E_FILTER_NEW)
> +                               add_head->state =3D I40E_FILTER_NEW_SYNC;
>
>                         /* Add the new filter to the tmp list */
>                         hlist_add_head(&new_mac->hlist, tmp_add_list);
> @@ -2437,7 +2442,8 @@ static int
>  i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
>                           struct i40e_mac_filter *f)
>  {
> -       bool enable =3D f->state =3D=3D I40E_FILTER_NEW;
> +       bool enable =3D f->state =3D=3D I40E_FILTER_NEW ||
> +                     f->state =3D=3D I40E_FILTER_NEW_SYNC;
>         struct i40e_hw *hw =3D &vsi->back->hw;
>         int aq_ret;
>
> @@ -2611,6 +2617,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>
>                                 /* Add it to the hash list */
>                                 hlist_add_head(&new->hlist, &tmp_add_list=
);
> +                               f->state =3D I40E_FILTER_NEW_SYNC;
>                         }
>
>                         /* Count the number of active (current and new) V=
LAN
> @@ -2762,7 +2769,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>                 spin_lock_bh(&vsi->mac_filter_hash_lock);
>                 hlist_for_each_entry_safe(new, h, &tmp_add_list, hlist) {
>                         /* Only update the state if we're still NEW */
> -                       if (new->f->state =3D=3D I40E_FILTER_NEW)
> +                       if (new->f->state =3D=3D I40E_FILTER_NEW ||
> +                           new->f->state =3D=3D I40E_FILTER_NEW_SYNC)
>                                 new->f->state =3D new->state;
>                         hlist_del(&new->hlist);
>                         netdev_hw_addr_refcnt(new->f, vsi->netdev, -1);
> --
> 2.25.1
>


