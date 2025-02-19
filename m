Return-Path: <netdev+bounces-167592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE65A3AFB2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A86416F531
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090ED1917ED;
	Wed, 19 Feb 2025 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZU2jeZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8B176ADE;
	Wed, 19 Feb 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932664; cv=none; b=ZlVC4HjHyYkgr6KQ9cPFswxCopKVVKgM8I+x+RuSKHoGEej84hX2u3FJhcmV0c64LfvxQkW7i4R6IMRCWS944jw04sXNwGu+ZoAimDZnfxUctg0G9WL1269v2sBslRsPQVsjXpB9waJ61Nc6OC4zKa3v0zpjC21GyoJelNq2CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932664; c=relaxed/simple;
	bh=DcGHeqsUy2uHROhHFtKOp+S7SY8ENUt0wjrAVjyYHuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6yq+pOXH7lSvXpSjlD6FuaL/xKtmKq+bj58DI/IVefYbsGvuQ4FcCM7W916tsDFLFkeSuU+1mYteaaCuoodVANJUIsRKdSv7ODcWFmAwWUl+IitqcwyfQpcCm/ODp7JxoKQrjqmEFy7JqPVM7LQ5EUcymcOcVIX24u6aHX06r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZU2jeZX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so9016755a12.3;
        Tue, 18 Feb 2025 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932661; x=1740537461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEY6MtjbNLxMMcfKUmiNohVhypOga6QMxouzG/gHgd8=;
        b=BZU2jeZXj9APLIkEhL0N2GuuUe+bqEfYJcTa0JPucuwvweUB+xKfQdtKfXGUj/o8fi
         1uTjtKlayBe8Xr9sRwEnGxrUzMH/Jp40bUVLzosZKZeD+lG6mQ92WNu7X1dh5hm3GHzH
         h9pr4LGWzNDSPrASKDVUsqD4P8WI+3CIfvrQyIeW10BDL4OJyXa1+8p6baf8y8QYRPds
         GsaiBqE3nfsp0HWkBl3UXaXgTg/PmH6mNsUIFOWbUm3E4QxPlIPDaeldbpoJ4Id85XLt
         CMmOXFfcJGDeYlHNE/X1Ai4aGcxkDBwO1c0mgf4/C/Q5WfHA+rAegHAGtZup39bmukJm
         1rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932661; x=1740537461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEY6MtjbNLxMMcfKUmiNohVhypOga6QMxouzG/gHgd8=;
        b=fmtdQUJrRTcoR2ki872q750AMjfyqJiQ3Kwme5wi7TctJLpuSmI/nSCfSDdiuI1Uvc
         Tcdx/aZLN52tCmOWhex3DU0bl0DPVMhgXW9OzzbXTQtsisbXYXIR0K/v9jq8lqTuIsdw
         DpMr0H2FsRUCvf1yc68sVVoxVhEmYy8pTMVE9pcUsAo/arvoJMyFS5kJ3IlT+vLZg72l
         5CNd8+QJLts3VevOg4KPEadWFbIz9N1E1jp3U7shPWho0vPfRiOQ+5PQ8hiDjw3MuSAP
         SdTW+xIloAYvU3A5gy6IUBbJri+3pm27O1eZfYO2DFtBAnsY2F1thao1hzcJjkYqOs1n
         t7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUAnPQ6AFUIOjNrUN+d3U6gTnTBeAtp6o50RwTRPKilKslCTosVf9dGUF7otw95RuZY/3Nh1tYo@vger.kernel.org, AJvYcCWbKxFkkXSXhbYY3J9sBx36qHAT1c4utQfjZQ0psrsWACdbi8QzDyoWHFI6LxF3UjA7Ibkaq+Pfj+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfZZkpfqeeUWsl1CsO4d0MDbhtpfcpwUgloP9nSyfb487Jnfr
	AbCdT5ybqybAfJsLRIogbYrquHRvHgaIcPZIkrLZbYNWcQz9SWFcYNSNparGQQVdNDnG801LX4K
	jOgSOd4Ab8Cz8BsYBtIUpCe4Okdg=
X-Gm-Gg: ASbGncvXlxL6OglDBp2YYcqsTFaF3tauFNoNeW54aHKoFtrDAmElDJ0w22GTO9XOvC6
	opPpgpHNOY6ENmd/3Mmdroku2K01e3k9Pufo1YLyzGNsruLbCzna6MnnK0x1LKa9/iWrzuN8SRw
	==
X-Google-Smtp-Source: AGHT+IHO4fidRunSi+Khs3S6uT928y8mNQm+EryaFoQu3jjOI1mP+zRfPxGFlLVyGwFhryC6j1r/tW7H0aUHSLg4ZUw=
X-Received: by 2002:a05:6402:26ca:b0:5de:3c29:e834 with SMTP id
 4fb4d7f45d1cf-5e0361f5a47mr16559936a12.27.1739932661103; Tue, 18 Feb 2025
 18:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-9-ap420073@gmail.com>
 <CAHS8izN-PXYC0GspMFPqeACqDTTRK_B8guuXc6+KAXRFaSPG6Q@mail.gmail.com>
 <CAMArcTVY+8rVtnYronP4Ud6T0S1eSgQX3N0TK_BFYjiBxDaSyA@mail.gmail.com> <5e6974f1-3a8f-42c0-8925-22c7e9c44cf0@davidwei.uk>
In-Reply-To: <5e6974f1-3a8f-42c0-8925-22c7e9c44cf0@davidwei.uk>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 19 Feb 2025 11:37:29 +0900
X-Gm-Features: AWEUYZk2jNxBjLgZje1btitH0sPVQJVjjnpsLwhoEKwCdc8be6r48mcKlzcelxU
Message-ID: <CAMArcTXa+15aQ77HAMx5y4HenV6a4kCHVZkERf=DcfCdC-on1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 8/8] bnxt_en: add support for device memory tcp
To: David Wei <dw@davidwei.uk>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 9:16=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-11-01 11:24, Taehee Yoo wrote:
> > On Fri, Nov 1, 2024 at 11:53=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> >>
> >> On Tue, Oct 22, 2024 at 9:25=E2=80=AFAM Taehee Yoo <ap420073@gmail.com=
> wrote:
> >>>
> >>> Currently, bnxt_en driver satisfies the requirements of Device memory
> >>> TCP, which is tcp-data-split.
> >>> So, it implements Device memory TCP for bnxt_en driver.
> >>>
> >>> From now on, the aggregation ring handles netmem_ref instead of page
> >>> regardless of the on/off of netmem.
> >>> So, for the aggregation ring, memory will be handled with the netmem
> >>> page_pool API instead of generic page_pool API.
> >>>
> >>> If Devmem is enabled, netmem_ref is used as-is and if Devmem is not
> >>> enabled, netmem_ref will be converted to page and that is used.
> >>>
> >>> Driver recognizes whether the devmem is set or unset based on the
> >>> mp_params.mp_priv is not NULL.
> >>> Only if devmem is set, it passes PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> >>
> >> Looks like in the latest version, you pass
> >> PP_FLAG_ALLOW_UNREADABLE_NETMEM unconditionally, so this line is
> >> obsolete.
> >
> > Okay, I will remove this line.
> >
> >>
> >> However, I think you should only pass PP_FLAG_ALLOW_UNREADABLE_NETMEM
> >> if hds_thresh=3D=3D0 and tcp-data-split=3D=3D1, because otherwise the =
driver
> >> is not configured well enough to handle unreadable netmem, right? I
> >> know that we added checks in the devmem binding to detect hds_thresh
> >> and tcp-data-split, but we should keep another layer of protection in
> >> the driver. The driver should not set PP_FLAG_ALLOW_UNREADABLE_NETMEM
> >> unless it's configured to be able to handle unreadable netmem.
> >
> > Okay, I agree, I will pass PP_FLAG_ALLOW_UNREADABLE_NETMEM
> > only when hds_thresh=3D=3D0 and tcp-data-split=3D=3D1.
> >
> >>
> >>>
> >>> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> >>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> >>> ---
> >>>
> >>> v4:
> >>>  - Do not select NET_DEVMEM in Kconfig.
> >>>  - Pass PP_FLAG_ALLOW_UNREADABLE_NETMEM flag unconditionally.
> >>>  - Add __bnxt_rx_agg_pages_xdp().
> >>>  - Use gfp flag in __bnxt_alloc_rx_netmem().
> >>>  - Do not add *offset in the __bnxt_alloc_rx_netmem().
> >>>  - Do not pass queue_idx to bnxt_alloc_rx_page_pool().
> >>>  - Add Test tag from Stanislav.
> >>>  - Add page_pool_recycle_direct_netmem() helper.
> >>>
> >>> v3:
> >>>  - Patch added.
> >>>
> >>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 182 ++++++++++++++++----=
--
> >>>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   2 +-
> >>>  include/net/page_pool/helpers.h           |   6 +
> >>>  3 files changed, 142 insertions(+), 48 deletions(-)
>
> Hi Taehee, what is your plan with this patch? Are you still working on
> it? I noticed that you dropped it in later versions of this series. With
> io_uring zero copy Rx now merged I also need bnxt support, but I don't
> want to duplicate efforts. Please let me know, thanks!

Hi David,
Sorry for the late! I'm still working on it.
I implemented a working patch, but there are several bugs.
So I'm thinking about how to deal with it.
And then, I would like to send this patch after fixing bugs.

Thanks a lot!
Taehee Yoo

