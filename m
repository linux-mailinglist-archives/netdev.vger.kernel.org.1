Return-Path: <netdev+bounces-65353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7083A3A1
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA7C1F23845
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F5171C2;
	Wed, 24 Jan 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC+OfZMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F8171AB
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083158; cv=none; b=HW7f3ZeRUxvBSz0nCkQkPwxjg+Xil/tHsdt69ozHJ2DTAQgYM3Q/QTtfosmlbNLwqLKNLPS4vgczPfAh9F2QGlevlOfee2sPUTCtAOx1lvHVtscGGamqoep4phYjsVP9k9SRB7JOVcg7TpEwXz6ysxTqI+/0FBLtUJiug/qT8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083158; c=relaxed/simple;
	bh=lEd0Bn9/l4rJl1Z1K+CtoAc2cKowkc02HmrmBSo3jRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LswhuScUcSWQ1igmNlomLqRG9/RbZ8Q5OrCBDTrzW0YxlFKpzEFnoIX1gqeBIKWCpaAb4axbsuLZLHzjVub8CmAOl0SyUjPn26Zk3S8MLAf8FrofCYOu7S5DBrmJpyCn1IPkQ0Fraux9bpo87bu4ZY2Cj+6MMT875MPrIwlhDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC+OfZMZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6816d221ba6so2735806d6.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 23:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706083156; x=1706687956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q92C8VzIHJcnlRFLcLBDvGNfbptSh8Rh3tDhxRNYqzE=;
        b=JC+OfZMZjbDati5bGcFqU9Wl6shrTaqgTdBM9mUtPGjbiEvrqy2aWReazHePKhVF18
         +DMK5DndLxei9Lye6brGO+e/Nh4Vxsmww47D2Tkah7AjOg94+6ouR5dlC0RYSxml/l1Y
         FvvBMjyyfHq//W+Dxd/syrsC8M9zZwtm9+APxLq+bl5evciN0W1soZ1X8w5LAdi6+5f9
         F9Vj4d/KbcwpccMsn+X+JSh1heR1cEY0K7Cx2VSDyAEgDhNyz+T1bunvQV8ByTelDrgB
         L/IDNVb3jZIRGFCg7JE9pW7WGU+MzFwWtCHEeVcWrFOqPGLNK+qKjWzOa0YG5mHP8zaM
         6FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083156; x=1706687956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q92C8VzIHJcnlRFLcLBDvGNfbptSh8Rh3tDhxRNYqzE=;
        b=ngMCXs8vjlLHrj+jiZZ1ZzVBweRSpV2r3h/BoEx1dUvxgnUrzihONS9zJ8Givt7LlQ
         IXIRMA0FAzNv7ICVvVRmMVq/gtDXZHg+LiVFegsNTSQ8VVxbN3lLcH2R7i29zbo5ATNn
         hRbmvwe/dpPbg6O1P80Hpy0CK9fwHfTZXjN9biQFqx/cpGb6juimMQkAi1LWDZ2HleL7
         kg5YBb+anh9KXJkbywY1WlEr9y0B7QEQuguJjEuXokT82DucAkZ7rxbtVSwo0uHUYuCu
         L2i9U718WAZbL7+c56L0jNwNwBT/Rujy+0sg2zUbl8NfVqebxVmey/G/ko2zGJJV48Mt
         uc2w==
X-Gm-Message-State: AOJu0YzFlrSh7JvysnM5gR71ae9zjZ3jnUlThZxDmAEF9H+v0FT23hUC
	oUNTqdmiRPiVr9YTWWfHNQ+mmJ4MiDOr5LrPoM+OqLjOO9M7RTFbhqgI3UVcDt6HzZDDdDv4Cci
	zeGWlF0kUiHotXzp1NYsuj7xztNA=
X-Google-Smtp-Source: AGHT+IEiyEKrWHLQrCMuEVeuybf2u1RXE5AMEL3PoX90w+hMbjCoqxpJM9kQTQnExbLnwxvzZqG5XAsY9MYzyqzsh2I=
X-Received: by 2002:a05:6214:d85:b0:686:9d71:842a with SMTP id
 e5-20020a0562140d8500b006869d71842amr1557448qve.2.1706083155980; Tue, 23 Jan
 2024 23:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123115846.559559-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240123115846.559559-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 08:59:04 +0100
Message-ID: <CAJ8uoz1uUj2mMPzoXkp8yUy_FsS_RR214eiJUhvj1Jvxr7=XCg@mail.gmail.com>
Subject: Re: [PATCH iwl-next 0/2] ice: use ice_vsi_cfg_single_{r,t}xq in XSK
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 12:59, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Ice driver has routines dedicated for configuring single queues. Let us
> use them from ZC control path. This move will allow us to make
> ice_vsi_cfg_{r,t}xq() static.
>
> Thanks,
> Maciej

Thanks for the clean up Maciej. For the series:

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Maciej Fijalkowski (2):
>   ice: make ice_vsi_cfg_rxq() static
>   ice: make ice_vsi_cfg_txq() static
>
>  drivers/net/ethernet/intel/ice/ice_base.c | 134 +++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_base.h |  10 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ---------------------
>  drivers/net/ethernet/intel/ice/ice_lib.h  |  10 --
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |  22 +---
>  5 files changed, 142 insertions(+), 163 deletions(-)
>
> --
> 2.34.1
>
>

