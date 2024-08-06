Return-Path: <netdev+bounces-115927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0745948687
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27057B22AA4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D41382;
	Tue,  6 Aug 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIP70mpk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09910F2
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902934; cv=none; b=ufmBUYRP/PLCgcNCRQmbNQ0FQpibx/Mv4AoxdKxWnxGJdjKAPoFt6eLAax3wSR5vEuslMbyMAGkq6EMXWfQA/eQppBz9g4O6eICGtS37h8a/xH9NGui4DqD0OOxF2qyMLfy7pnIzP5UFBQwmOgQU332/aQFLaY8wFrLQtwoOsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902934; c=relaxed/simple;
	bh=id93RYs/lU5oHEk+irFWG21CXN9q+Dq6PobT0MiN8Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAFSZx+8qQP4VyVnoF+I/MBr6dLNU/vxHdPaRif8QjuYVDstR9NIBVf/OrglQPgjLmOcK8pmH4bLiU3nBpE6ahwSbm0ARJqh7uqJcOpVk+m+S7wI7lvMNgTE8ZdGLUHmzVphiV99dSrwlv66KALDnq0wlt0z2xxmXLXDThu7VUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIP70mpk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42803bbf842so737705e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 17:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722902931; x=1723507731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lueg1q4xlgPhZs2h4MMpkKE7k8YaeEuFiyFdK1WNg6Q=;
        b=vIP70mpkZgEW5iF21ILOLWTbCOz2+bX+Z1ePEeMfGbDa7y5GpxpQQuLnSdFt4x7Kri
         +PjuLKlKJecXvsoRX+ZTLrex0D19AnVdJEe9zKZX0sO/RuB1tsivj3BExT2050xzRhOB
         KTzsAp+e8Qs1PH2rPg16/YXBrtZNbEW2jwiddR737VuKiP6AcNp/MfSuF5c5vru5a6Yf
         mFm//kx/U3xDk26fhTzCsj0GvSHR8R0OcvwXoDl2Z5sTAxtpAbpg0ggkVWdHiDE9F2l+
         4bK69oA59Mr2ivCvWl8GO+kc1ujIL4JzmWT+96VBeCbQ5Px3IvueeX5ADPbOPLP9iq9h
         Pkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902931; x=1723507731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lueg1q4xlgPhZs2h4MMpkKE7k8YaeEuFiyFdK1WNg6Q=;
        b=pF3bZUiQPdjtheu9UeuVQaTNi/COqJfbfxcJGCFCMqHGyr7ZhS4oItCuHAJxRQBLSS
         1RvRBwBhp0C68HtR8MU04tmEoZOtqInKbN72iy9Wm71RrnYrnfTDjeLv1NXXW1KJrlCj
         j9MD72oT4PgHIfJpSCNptWmTNB9XJKSwaj9ob+Y29k57tr/Q9OmdwwOOAXnMXd+BCrYt
         +3pg8ygPL/qLBR1rMs+m/CRBMat+Qixy+Ry3Eubhwxqs9G0AQnBkJZiICN19Tdni/DHc
         kSoK9RFO2h3lRtPoE6nP3bDxt9rN4UgsY/6Nry4tH/Hubcpa9O57lR4qtNeiA6JDEB91
         Iesg==
X-Forwarded-Encrypted: i=1; AJvYcCUW89XPxh3cY8XGEM788CTZVWed0ZjQEFLtAUYGon2+b6GcxAFe3Biuw2H83QzCf58waZeTEn5dPLAizcH52cjdmq/1zqjs
X-Gm-Message-State: AOJu0YzmmyOFeYjIQrICbrIsQ9KRLsHzwBFzLShordF8KH/tYPtBXDn5
	Mdbtmmcasums7tlCalH8fFOBcecQ3qRXSTub/HmI9BqMgoZoWWMj5EQIov9I1DPDUO3z9f1uLhe
	uUMKF2iCoH7vIsZODAHF00xPHnLVYtFpz+NO4
X-Google-Smtp-Source: AGHT+IGQxS7iLcNY74cLYwfTXuwXC826pFXBavPYiL1sqN/UjItjZWqEcN1imyVVwlCQTsqPxsxi8dUscOpU3R2+cKc=
X-Received: by 2002:a5d:5343:0:b0:368:4d4e:407c with SMTP id
 ffacd0b85a97d-36bbc118084mr11413694f8f.33.1722902930537; Mon, 05 Aug 2024
 17:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802012834.1051452-1-pkaligineedi@google.com>
 <20240802012834.1051452-2-pkaligineedi@google.com> <20240802161335.0e23e9ec@kernel.org>
In-Reply-To: <20240802161335.0e23e9ec@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Mon, 5 Aug 2024 17:08:39 -0700
Message-ID: <CAG-FcCMSDjMi-EkRRF1MNhaLxr27PJhWnDpMzjaqxp-+3kq8yw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] gve: Add RSS device option
To: Jakub Kicinski <kuba@kernel.org>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	jeroendb@google.com, shailend@google.com, hramamurthy@google.com, 
	jfraker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  1 Aug 2024 18:28:33 -0700 Praveen Kaligineedi wrote:
> > @@ -45,7 +45,8 @@ void gve_parse_device_option(struct gve_priv *priv,
> >                            struct gve_device_option_dqo_qpl **dev_op_dq=
o_qpl,
> >                            struct gve_device_option_buffer_sizes **dev_=
op_buffer_sizes,
> >                            struct gve_device_option_flow_steering **dev=
_op_flow_steering,
> > -                          struct gve_device_option_modify_ring **dev_o=
p_modify_ring)
> > +                          struct gve_device_option_modify_ring **dev_o=
p_modify_ring,
> > +                          struct gve_device_option_rss_config **dev_op=
_rss_config)
> >  {
> >       u32 req_feat_mask =3D be32_to_cpu(option->required_features_mask)=
;
> >       u16 option_length =3D be16_to_cpu(option->option_length);
>
>
> > @@ -867,6 +887,8 @@ static void gve_enable_supported_features(struct gv=
e_priv *priv,
> >                                         *dev_op_buffer_sizes,
> >                                         const struct gve_device_option_=
flow_steering
> >                                         *dev_op_flow_steering,
> > +                                       const struct gve_device_option_=
rss_config
> > +                                       *dev_op_rss_config,
> >                                         const struct gve_device_option_=
modify_ring
> >                                         *dev_op_modify_ring)
>
> Any reason these two functions order the arguments differently?
Will update it in v2 so that the arguments order will be the same for
those functions. Thanks!

