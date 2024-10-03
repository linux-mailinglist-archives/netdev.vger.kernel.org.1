Return-Path: <netdev+bounces-131437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D198E82C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 03:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E6E1F24C9B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A211CA0;
	Thu,  3 Oct 2024 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9qyZzAY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85A171AA;
	Thu,  3 Oct 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919615; cv=none; b=jWFPVrpIuZePy676h76N+B+7spxg/uoiA75uowVWWfLLtItJRq0NU+AziIPyr12+jO3+9cwFKAintUNA8XJGrqLBgF/YUYnRdjDGDW+URY++XPvW53AGBT5pRXIu/R52uSiSBut0c2BJyjvMGql4CT0Kw7Auqtn+J+NsZKUMU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919615; c=relaxed/simple;
	bh=n+CKIEUX3SMMrxBnvaXiWZy26IpN1/21W539O99608c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwYFJka3lbS9ktYETwSgFpBWNm9qYOM6A4qqFRVSqQyJEvHSFFonRPSn1AmLFJwFcffcBE3SNqHFS6Q512FvZPnQZG5lcIbd0VhFzq7FiyusywL+Tx1IyYys7LjDdcUFJyb+Gbi4X4l22JT7YChBXTjhjqne4jfvDCUtCt9tKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9qyZzAY; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e25cb91f3b3so444067276.1;
        Wed, 02 Oct 2024 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727919611; x=1728524411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NscMFM+0Lb1ZP0zKNfmryFcUfJtZ1xn4kxlJrm5+MUI=;
        b=P9qyZzAYsogmbw5TwrOd3qcanT/zi4oYFDthXSjmEGdu8INYqD9l9zUd33irtmyfBh
         mGBtJO0TRZOCyWrFJcpdv4q7MvOAgqOGEo7yiC8NGoPwjvgZ9EBUJJkz4hZ5h2hj+lmr
         E2HAhTwO+7fVavpHl1zHxnhXGeQi3Yz0aMeL0DOfl3xn8KXClJj1wCPNLxz8s4afBWYc
         YAOgDUHDLOfP7yVKPZ7xZ8y76szTT2ug/X/e3O9T1WkiuznyPmWCI5PyVEdewmuhURw8
         c1u3WsxIo4kOYTEgGp3hJWdML5FMoynW+YmpiY+uAaWqk+/FxNGamjGe8XeL3qYUkyiR
         mGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727919611; x=1728524411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NscMFM+0Lb1ZP0zKNfmryFcUfJtZ1xn4kxlJrm5+MUI=;
        b=WdT9oWfec+/dCihfYEkEtRFji/DJSeoWKWqrkeDlOyTJEjPqz6o7NTPCT7WXGOG4EF
         BJxv0RL/zJoEPG95hXjESX8DkMm3hw6KWXWY8ob+H1ZoW2xxn0tvASzjASR2roQ+a5US
         rYAMecNPidjAYUhhK36toV6xPjad8inRQmR781DnvmP7kdfVDMwLI1OzG4/Wx/KdYIvw
         FtMbO5CJheUrhwzzyR1UctJAoh/iboGNjPhbGsUV/knwTg1IFr1jepwP0fgBoWEYARXw
         5bbQBeJ31U5Usl08mTWiULRA7yf4w1DnBDW9JVW2NoQ2dh/Cihf59d4X5nDczayqih0G
         zUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmZXzEi+b7X63UxrxBFVoNf8VK7WnL91GSEF6591YrhcODNVrXlh/xN8bLaUdu1Hl1xnTLbW91QF2IIHU=@vger.kernel.org, AJvYcCWuifV/Mnb38aX1rv8/hJ0AtQksYAvRsDRrH+1JQawIgVbOwN6+GGvU9nMFFgt+Go3WxO2KnZzx@vger.kernel.org
X-Gm-Message-State: AOJu0YxAv3g6pZ8rLefHLF0k8FMHOeMz5PRpt+mnukoCo6oXiMXwI4dt
	gYAk51tCFc0EEdf4bwgnifiRcdTWi9aejnBiGkLZA6IaCjWr9fb6J59XfQiCb3xxNQrXz4ca3+S
	+ghlfsG0/+vbyt8PfoFeNPQPH768=
X-Google-Smtp-Source: AGHT+IHEu/r4f2E2w2HsEbNo25tzzdhyuTlNgU4ksgbgStfWD67qE/UXs9jBLoZuGYAnG5///6pjB5osNobzcs4psNM=
X-Received: by 2002:a05:6902:1b0f:b0:e25:d60f:2fd9 with SMTP id
 3f1490d57ef6-e2638418fb5mr4146936276.42.1727919610814; Wed, 02 Oct 2024
 18:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-7-dongml2@chinatelecom.cn> <20241002133543.GW1310185@kernel.org>
In-Reply-To: <20241002133543.GW1310185@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 3 Oct 2024 09:40:43 +0800
Message-ID: <CADxym3Yc25zvs16DyXtKBLOg-5bH6wf20L1T9YQ+Nm3CC7QVSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
To: Simon Horman <horms@kernel.org>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 9:35=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Oct 01, 2024 at 03:32:19PM +0800, Menglong Dong wrote:
> > Change the return type of vxlan_snoop() from bool to enum
> > skb_drop_reason. In this commit, two drop reasons are introduced:
> >
> >   SKB_DROP_REASON_VXLAN_INVALID_SMAC
> >   SKB_DROP_REASON_VXLAN_ENTRY_EXISTS
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v4:
> > - rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
> >   SKB_DROP_REASON_MAC_INVALID_SOURCE
>
> super-nit: SKB_DROP_REASON_VXLAN_INVALID_SMAC was renamed in the code bel=
ow
>            but not the patch description above
>

Oops, my mistake! What should I do with it? Is it worth
to send a new version?

Thanks!
Menglong Dong

> In any case, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

