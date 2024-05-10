Return-Path: <netdev+bounces-95246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FEB8C1BA4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A821C21873
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36001FA4;
	Fri, 10 May 2024 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pj74wjJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199116FC6
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300281; cv=none; b=WLNlJiC5RyGdUDKgulVRkQX5WTAmHtldrFpGETGZAD9yG1C04yno68KsBAGowTSnuffzLyVZmMVaur3WK0CeiyOP3vm1k3yJKZZHaHizmCGZoPNvhuGJpsMB09fH+meaVYJcWlWY1L2zmbu3T25RKXacCRIMhYJv73X/m77dnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300281; c=relaxed/simple;
	bh=32zunW/937A+VI7TVLODQJmupnG7J5u7L6VNkYS8N0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bqyiyqh8spB5aXwAXBuUA/JWWLv/g1BbcVVTMMMyQbwoVEYSqyxvYAoH8MLZ39R2hR7nZ8KhxcnydZIcg52Hi6ICiycVoGDXCdHStmuVlQR/WW7nfhd8vW3+cWmdCc946/2Ll0kzO80C9BhHGn4CGJe3m1EC1uvX9egH9aK0P04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pj74wjJV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c7ac6f635so9341825e9.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300278; x=1715905078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAKOkwp1JwGuxJyPuHfQGI6AWg0YhiVqZy4MwUSsneI=;
        b=Pj74wjJVcaOX8X2/hslmwnqJ09RdaVWp/hQA+EBrwlOM0a+FpNg2/uQKhwrrbJwxwF
         UflcfACHGuRP9xFO2tWzQo0OwzCyJx4AWeYxP909/xEMtmXHyHa/k0ZjDYErlByViLgn
         uufLANXu9K3FINFTEBj1mPNsn0Y1j+JQ34AepaDdiemdQWhro+sMegewTvHa20A8cowh
         oQrsovo7vdTMtaM6NjIPc9rSABDPToPu5/ZDIqltA79a2AYvj88+umaOZudCQlFqfUdy
         ickYDmSg6r6TJRkEwDYgjC1guxyn/upK4aWms2uyqzLXo2SeO56xpp1rPvLhLQemfKVd
         by/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300278; x=1715905078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAKOkwp1JwGuxJyPuHfQGI6AWg0YhiVqZy4MwUSsneI=;
        b=AXPRPuS+VmL740aQuhr9G2gQ84pA5qQgKlYO3vFjaJvL8u/mysn1U0Qg6u0j0i33gn
         sQZ2mmrS3gHW1/6s0G7WxSvg0SggLxbr2qgUaGXGMykn0UA356sgIblhJ9saw+AOdqtS
         xtLt7rUZIGjBU3dmPN3QhiU4zABItALccbrsm2rrybq7BvGigLNUd09O12F17zA736a4
         iqZtQvNE47LQQNX2mwpIn5SMsPbk90impfTG2RhD4zS3WaXqTk9dHn+GqWtwDw302lBZ
         p+Yq62OoTisBpGMxDngt2glgkgYLtHRftBDj40LX0kcFImvp3ga8+2UOIbt+5kqTCnXz
         qUyw==
X-Gm-Message-State: AOJu0YxUHEVs+kTtIxlRd/we4/6ODi5RhsPuhvQ+ECugUEbmHPe+7won
	HIK05ixhyGpE0hcSSVykJDmfvEiU4yyVOz5Tr1WQs7AYtmtBgGtFH8Mlv7wtYvZqDpe6VZbMSjl
	/YnXN8ZbXEMnjx6QKJ0/nve8k2KMSeByeQ8IL
X-Google-Smtp-Source: AGHT+IGsTBm3kyqRWwyxe6aen4twfHmKaMlCO8UBWYeZRet/IFXhY3zvqOMxnBrLHbg5/lRkKBbynn/nm7/LVaHKXmM=
X-Received: by 2002:a5d:4fd0:0:b0:34f:e19f:6186 with SMTP id
 ffacd0b85a97d-3504a737144mr858323f8f.31.1715300278279; Thu, 09 May 2024
 17:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-4-ziweixiao@google.com> <64a7690e-50a1-4b3b-9b9b-5c2efa552806@davidwei.uk>
In-Reply-To: <64a7690e-50a1-4b3b-9b9b-5c2efa552806@davidwei.uk>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 9 May 2024 17:17:46 -0700
Message-ID: <CAG-FcCO=Ck9-eWXO4W87SFWr3uEQfMh=0x_HWkY0S+Yioa7FuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] gve: Add adminq extended command
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	hramamurthy@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:34=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-07 15:59, Ziwei Xiao wrote:
> > From: Jeroen de Borst <jeroendb@google.com>
> >
> > Add a new device option to signal to the driver that the device support=
s
> > flow steering. This device option also carries the maximum number of
> > flow steering rules that the device can store.
>
> Other than superficial style choices, looks good.
>
> >
> > Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> > Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h        |  2 +
> >  drivers/net/ethernet/google/gve/gve_adminq.c | 42 ++++++++++++++++++--
> >  drivers/net/ethernet/google/gve/gve_adminq.h | 11 +++++
> >  3 files changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index ca7fce17f2c0..58213c15e084 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -786,6 +786,8 @@ struct gve_priv {
> >
> >       u16 header_buf_size; /* device configured, header-split supported=
 if non-zero */
> >       bool header_split_enabled; /* True if the header split is enabled=
 by the user */
> > +
> > +     u32 max_flow_rules;
>
> nit: this struct is lovingly documented, could we continue by adding a
> one liner here maybe about how it's device configured?
>
Will add.

> >  };
> >
> >  enum gve_service_task_flags_bit {
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 514641b3ccc7..85d0d742ad21 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -44,6 +44,7 @@ void gve_parse_device_option(struct gve_priv *priv,
> >                            struct gve_device_option_jumbo_frames **dev_=
op_jumbo_frames,
> >                            struct gve_device_option_dqo_qpl **dev_op_dq=
o_qpl,
> >                            struct gve_device_option_buffer_sizes **dev_=
op_buffer_sizes,
> > +                          struct gve_device_option_flow_steering **dev=
_op_flow_steering,
>
> nit: getting unwieldy here, is it time to pack into a struct?
Thank you for pointing this out! We have plans to improve this device
option part, but may not be able to be included in this patch.

