Return-Path: <netdev+bounces-133743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C984996DF1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1B7B225CF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0B19DF9E;
	Wed,  9 Oct 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avk6S32U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3DE18EAD;
	Wed,  9 Oct 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484315; cv=none; b=jp495fhmkg2jnNuflOVnywzyd6jEIO5AKpcAVxRO1VSjfG/IwZr+7OBDOiea8yJuBEuDXL0TeJJ4CMmg76AonWIAkv/xh+5g08zGUnWUrt8ihnWS+lpPBUtU6vr1We4iQot5PxYXtWA/DbBNse/n22680R+yobxv8jCdP4CIII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484315; c=relaxed/simple;
	bh=iMzRXSdkwWFziA/rp1mxrwUI676zhrMiukMc7fUObAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2zPdpoY2cQ8lavLOjAWPndmjSaE60Kpt5bLCQoV83OY/1D7MdczfcXPEVHdXucW+9D6XgAa8ti92wCfmD/WvPPdhFlA1ZD/Yjl4t36klQC+9RmHWLYSxUkm5XILsd7vixrvHf+nVnS0x78aNtIIeEKnddyI/811sicGAGx5/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avk6S32U; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e29555a1b2so1060061a91.3;
        Wed, 09 Oct 2024 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484313; x=1729089113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucnG7AGyb9qxKd5nqWkFKwfhBljiCMIoSbX043WdVr4=;
        b=avk6S32Uci3FTWywsSUuK6prmVJGwvs9/Q5ajiPH9m0u7tR9c9sKYhea0teM9UZn7I
         uHH9g7fiLroXGnPO3T4LBPuW3qG5AKWFM2NNSmRs8yYZQJ4v7NWlA6kxCnw5DJB8l4pa
         VlN91tMW+j9v2w9yUbxnd/u/SUeVisGrOXJA4KQNALu8Qoq6K9TExrfCYJuswZA794lR
         TigjewGN8XCbVbc7TKfUZwnsW8fOmRa9Yy0vojIWNMi5DcQimc5bF5cYE3PYh/qxnaFp
         FdUb/TRWFTozIn3cy9cWP+WMjHteahqYvcU+TlBZDTMOhFEJfAxqazNql70v/x7GGi5p
         PHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484313; x=1729089113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucnG7AGyb9qxKd5nqWkFKwfhBljiCMIoSbX043WdVr4=;
        b=n425yUaQfm7uaUkF4xatm36I6TFoDmSbNMXjJS+++j/VXbi8gedZ0WYBmaKhzsRSP6
         TAYRoMh9Vo1taiaItg+pjSe0hO3g7rVWuPujKliUJ5XkEVFLWWeKqyCmZT9uPadASPWe
         PjHQo99+K8Hf5gPBt/at/SzRuN9P4mNb1UqosVdeq+5xeXI5OLFJhjy8/bU0YTAx+pHn
         rVkIZfawQYmAJOT7dtvXCZlAISk3hOEj8N57vtR0eZeZxRM0G/t0krzH0/ICsx1z+Pvp
         jnx6z04+XR7J8TcQ+a2jfIl4v0faEnzZPiarlHU7BSqotbrwH3Po4Hb0I4tIe+BpvWdZ
         x4UA==
X-Forwarded-Encrypted: i=1; AJvYcCVE0iUTgfDick5cIBuXybu2/A1HseoIOVDje5PrtpSWfAZpuJp9nYr4McDlrbGz5AlO+dq+/RchAzs=@vger.kernel.org, AJvYcCVQtJyTXPrQC+PLDw52/mU1K4TEMN5NGEU5PNxj0IJa0bHNtPh5nnxNHxoJBEvo+59AVTlCVtGF@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKUKKRQdBtxmsJLSx34MjY07omtAFrKZ23HHk66p1HhWUgCwm
	8dH8LANKBBTEPQ2GbXeBJ1dHh9zcU73a7lXzkfPCoOquC2aiz/OlZclp8o/2JC4zZa+EX/Pn8Gw
	deKxwdUCBUGGm/x01793AO9fZof0=
X-Google-Smtp-Source: AGHT+IEy2Eg1pYizkcJwGz6JWnr/Dcd04pur1rI+tGUnMJ8tUsB5lDp7M/fQsD4AqksRhwYh7Am0KgKw3LMtmrtbB1o=
X-Received: by 2002:a17:90a:4741:b0:2d6:1981:bbf7 with SMTP id
 98e67ed59e1d1-2e2a25246famr3145375a91.32.1728484283317; Wed, 09 Oct 2024
 07:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-5-ap420073@gmail.com>
 <20241008113538.5e920b12@kernel.org>
In-Reply-To: <20241008113538.5e920b12@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 9 Oct 2024 23:31:10 +0900
Message-ID: <CAMArcTWxPASRynkB=JA7XJXcJ448-FiCc_H-DCN=3tm8k5DN4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
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

On Wed, Oct 9, 2024 at 3:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  3 Oct 2024 16:06:17 +0000 Taehee Yoo wrote:
> > +#define BNXT_HDS_THRESHOLD_MAX       256
> > +     u16                     hds_threshold;
>
> From the cover letter it sounded like the max is 1023.
> Did I misread that ?

Based on my test, the maximum value seems to be 1023.
But I'm not sure that all NICs, that use bnxt_en driver support 1023 value.
(At least all NICs I have support 1023).
I decided 256 as the maximum value, that was default value so all
NICs can use it safely. If Broadcom Engineer confirms 1023 is right
 for all NICs, I would like to change it.

