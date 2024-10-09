Return-Path: <netdev+bounces-133850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F09973BC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594C81C24CEE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879491A0BE0;
	Wed,  9 Oct 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9GiCFyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE41A265B;
	Wed,  9 Oct 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496164; cv=none; b=MYmLMhKOLqiFbF6dhECjClRck8K2rfGVN/varVmls8E6yKQh/9++0Vt3JVzGcKqbf9ST+VFwu3Bc8tOoARrjFl/rSQAhFiAV82G95BfOsY+otl5q+7rkvG9kE7CE9ZKjbt5rvxjtNiQ11Dy8IPc9P3f8ANu5OlxYolqe5wTv+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496164; c=relaxed/simple;
	bh=pdjVqqUnaLghuXYFVMSwWplc9dkgFpPRYQTZya+YVR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQIL/URQwrLCaYjvW761OzTOrXbRPD3xvRyGQdEdVEx6RUDDFeeTHXjyevQqRMg9XeKZjRnICkrewshj21mRT6/aoLRkQ/Q+jd/hiDXf30W0AgD7l4e1/x0bHNNCQyz7xb/c8Z9cdA4+bgKjxSoed1lQX9LM4OD6b+onXLr3nkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9GiCFyW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so119233a91.0;
        Wed, 09 Oct 2024 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496162; x=1729100962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+R3+SxnJoYLKGhktNZNZF4+pLBRtL3Ebish0Z+I3Qs=;
        b=H9GiCFyWFXwuOncC923aF9050s5D3sDIcrkTQEXjfAO6bXmuvjw1q/5J7ijCPteWI9
         EdTMROx8yBjQsuel6ed8qK2VWquKAsnbV3h2Kf1Gpnhxd9eaUT05WCz3BCNPplAsRd9h
         8udKXZFzSNkEEObjq160uD7x0nH0eMdc9KlaYMn8ODJ3b1t5XcwHkysieoyB8LfhcsFg
         Um8AQlaA4lgIAl7BiTA03ZF/hM+NdtBbrEuuSp4fvSIQFQRB61TmcTbEvpIzh/BdXl81
         qfUubtWxp8pcA59bClfgN7X41O9OWjA39ndlEXgjeb1Mzbx3yLUg+ZnnPXp61E+gsL5c
         k63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496162; x=1729100962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+R3+SxnJoYLKGhktNZNZF4+pLBRtL3Ebish0Z+I3Qs=;
        b=wj/+6o3K1jR0FIAHok4W79swytU4eiP4r0oS/HZmrgck+zYJ5We0hx6vIINc+uRLHm
         sj3zoHKQK26ysXYxv74fFeLNfC6imc9g4CtZEk6uSpjErzsHIEFnXmVy5SlhvpH0grKE
         cXfBOffrhllD1/qN4E7GGB6o78iTMR/Y/6jlu1Af54ChvAKBx9rdnwhQpI3qURtxhDSl
         SEmxIQYfWekf9+8GWkWqvEjpNsgZVg+j2joQCLIDku1k7lt/Nu36aR03AAG4IoSg+onF
         JendeWsAblr3xUSUt+JSxKdXGB2BU65oY9L+6tSNLCndHVfB25XcZxj+N88TCFi/yg6Q
         cbsA==
X-Forwarded-Encrypted: i=1; AJvYcCVJNv76nxU/g5fYskZkfQkE+4SO+pNvkAgl4DGOmyR3fV3zLnLWNJQjb1ZzNfBvfZzk5cQvwgub@vger.kernel.org, AJvYcCVohzGAZuXbIKgvOt1p+7IrHoctOUCGAECAX8Wf242Flk34AwdBeL//t4NRXnB6UgE5nF+9VG9jYps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9XUjB4Gp2+3Prubyj+QU0WxG0VUeTkd7T/yWdguRmJ/s+5vv
	r3w0ceMXFqdlPhzX3OINoE5cMKq2PIRfwGNnyGigtqepO7USRRTPc8mkRBWinPuTkTKI6Gygxp1
	svTHGvbcaUuwScdW3lwJpsrEYqaY=
X-Google-Smtp-Source: AGHT+IGl87qhYMGxphgUQ3oCQa2e95d77K/cLzv7RW+4IIGd9hyFbKM8IbaD5QcmOi9B6sSl6kbBcCCbogv+IAkVzvc=
X-Received: by 2002:a17:90b:14b:b0:2e0:9b50:ae28 with SMTP id
 98e67ed59e1d1-2e2a255445fmr3896200a91.31.1728496162210; Wed, 09 Oct 2024
 10:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-4-ap420073@gmail.com>
 <20241008113314.243f7c36@kernel.org> <CAMArcTXvMi_QWsYFgt8TJcQQz6=edoGs3-5th=4mKaHO_X+hhQ@mail.gmail.com>
 <20241009084626.0e0d6780@kernel.org>
In-Reply-To: <20241009084626.0e0d6780@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 10 Oct 2024 02:49:09 +0900
Message-ID: <CAMArcTX5=K3+g5Ga6DJNJ360f-mYn6hDcJJvah=_azMc3PGZMw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for configuring tcp-data-split-thresh
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 9 Oct 2024 23:25:55 +0900 Taehee Yoo wrote:
> > > > The tcp-data-split is not enabled, the tcp-data-split-thresh will
> > > > not be used and can't be configured.
> > > >
> > > >    # ethtool -G enp14s0f0np0 tcp-data-split off
> > > >    # ethtool -g enp14s0f0np0
> > > >    Ring parameters for enp14s0f0np0:
> > > >    Pre-set maximums:
> > > >    ...
> > > >    TCP data split thresh:  256
> > > >    Current hardware settings:
> > > >    ...
> > > >    TCP data split:         off
> > > >    TCP data split thresh:  n/a
> > >
> > > My reply to Sridhar was probably quite unclear on this point, but FWI=
W
> > > I do also have a weak preference to drop the "TCP" from the new knob.
> > > Rephrasing what I said here:
> > > https://lore.kernel.org/all/20240911173150.571bf93b@kernel.org/
> > > the old knob is defined as being about TCP but for the new one we can
> > > pick how widely applicable it is (and make it cover UDP as well).
> >
> > I'm not sure that I understand about "knob".
> > The knob means the command "tcp-data-split-thresh"?
> > If so, I would like to change from "tcp-data-split-thresh" to
> > "header-data-split-thresh".
>
> Sounds good!
>
> > > > +     if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
> > > > +         !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_=
SPLIT)) {
> > >
> > > here you use the existing flag, yet gve and idpf set that flag and wi=
ll
> > > ignore the setting silently. They need to be changed or we need a new
> > > flag.
> >
> > Okay, I would like to add the ETHTOOL_RING_USE_TCP_DATA_SPLIT_THRESH fl=
ag.
> > Or ETHTOOL_RING_USE_HDS_THRESH, which indicates header-data-split thres=
h.
> > If you agree with adding a new flag, how do you think about naming it?
>
> How about ETHTOOL_RING_USE_HDS_THRS ?

Thanks! I will use that name.

