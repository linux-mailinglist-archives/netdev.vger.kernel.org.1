Return-Path: <netdev+bounces-131704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E698F4F1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849EF1F22D4D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DEF15573B;
	Thu,  3 Oct 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSb5Jy0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AB433C1;
	Thu,  3 Oct 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975768; cv=none; b=FxjBbjyWlYZvgOXHaB4QeTGh0LwIbeYVrLQWH5Pa8BisLSiJmNwLTsAVPsaSjXvoSrbp9K2TGaAB7GU+AnX6HesrEUD+AmUcTMgr9GHwF8oEPyb9GiR7jciveOfloRQC8D8WLVo0u774w9S9iQXPyRpyTMlxoEBMIEfhU9f2k+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975768; c=relaxed/simple;
	bh=CL7Wg3gj21GB9l7D+2NEX51041pZBv1itNXrHcCFX6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOUHlQddogQLH4HI17gbtp1rHr+aEyXZNdElGEElYDtOmc3KVFh9Slm5mgnshWUhUIUJe5XOxm2DIMwhwqcfHFUfei18UmYGO/Z4h8e3wtTlhUvnHkG/YOZIUIZMSkgghOKDnHL2YsBIStQQDMQcTN2lETSEUmsIW+J2Tc9dNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSb5Jy0h; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c8952f7f95so1322433a12.0;
        Thu, 03 Oct 2024 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727975765; x=1728580565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL7Wg3gj21GB9l7D+2NEX51041pZBv1itNXrHcCFX6I=;
        b=OSb5Jy0hswnltHewFLOeNa2qaY0GaEjubpGKDMYpSPw1JGV0uDqI529TneXMX3++Y1
         ARFfSvjCN2O+SAWMpYiYQUfIWmRVAl3Rnl3S90NQUrwaeea6pVKdtEBPOIkT66S/M3wA
         dft4ZGvLbqmdJYxCFxqhY/aLfD99LYCMilC6riqz43+gMyvl6hMwOdGcZ5V19+okhDXr
         V2lay3VCf2unx9qQASbCbkj1U84q4NjMz4BfebXrfyU96ojM1OKu6HItxYUkNsdnvOjl
         +eW2fiXlYep5zbM+usMO3DkOGBXi4nBeinWQa6rr+tBWM5lGBJn+AwZl39d9T0jTCIu/
         cKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975765; x=1728580565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL7Wg3gj21GB9l7D+2NEX51041pZBv1itNXrHcCFX6I=;
        b=iU/CmXbWpmT41genEdKyCC2tdlhQWrRvnMZc3iMzL9/5OxgtQc9xJ8YSZuivrVMkuH
         KFgqgfqaHFCgAEXfhwrvFQBiqZKFIaj8eCqyQfBvxlHptsIKfcavWApYc4OnoDwD+bUK
         Q00ceDyKK4pAAVREtzMkixJhS6s0+s7snL7NRMg55bRyCiXZhTGaFnCaroldOVp3q2RZ
         UC+O0NX7mLbmMMeKNDaNOT2lHG8EQ3VXMXMvt07SoX10zBeUQvCXG3aspbTqDAqBd0a7
         R+PZKYZkXX47JVSjKyjZRJ5FfGY933c5Ly7Djo1SHbj53AInQuc3NpU3vGfwAySaTZD5
         cj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN1UObaRoV0JZlPpGx4dM/kRXQcvENL5VeBX4deVfKts5unJR1uGmpAtO5IN8auvyaz3ChYMot@vger.kernel.org, AJvYcCXciC1XI1syMOvXDv/COZtQqI331aeYwsEWUxacCUwZ83hroRLO5k7q88kmbNowB1S2bOR0duDI/Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyFDJYVAnXofWRlBZQ52zXaZQYXAPpdOphfv+rySUJzA4ltbi
	qRT7roiltfdC/yK2An5uDAxtViw3Oyq8qgalnakpKvbKhR3M63I4MvY5qLzQCrEh2ctrDeSAA8e
	mynpEWdWufYX+jQZlftGqnvfWL9M=
X-Google-Smtp-Source: AGHT+IHS6kA66HOXbU4wDhLGJelNJW+j2RMuxl07mUHoNTRrHb71zM06yp0hJac2xL2XpOhFx81xyvmo/GtoWpTyfjA=
X-Received: by 2002:a05:6402:5114:b0:5c7:229a:b49d with SMTP id
 4fb4d7f45d1cf-5c8b1b828b5mr5712934a12.30.1727975764501; Thu, 03 Oct 2024
 10:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-2-ap420073@gmail.com>
 <bf51b344-bc52-4383-9218-aab9f5f89c82@amd.com>
In-Reply-To: <bf51b344-bc52-4383-9218-aab9f5f89c82@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 02:15:52 +0900
Message-ID: <CAMArcTXV3pR6KH2eP1WWbaeK3f8d7m=6Pi4ze6YtTz-TcrjNow@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
To: Brett Creeley <bcreeley@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, dw@davidwei.uk, 
	sridhar.samudrala@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:57=E2=80=AFAM Brett Creeley <bcreeley@amd.com> wro=
te:
>

Hi Brett,
Thanks a lot for the review!

> On 10/3/2024 9:06 AM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> > userspace. Only the default value(256) has worked.
> > This patch makes the bnxt_en driver support following command.
> > `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> > `ethtool --get-tunable <devname> rx-copybreak`.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> > - Update copybreak value before closing nic.
>
> Nit, but maybe this should say:
>
> Update copybreak value after closing nic and before opening nic when the
> device is running.
>
> Definitely not worth a respin, but if you end up having to do a v4.
>

Thank you so much for catching this.
I will fix it if I send a v4 patch.

> >
> > v2:
> > - Define max/vim rx_copybreak value.
> >
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 +++++----
> > drivers/net/ethernet/broadcom/bnxt/bnxt.h | 6 ++-
> > .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++++-
> > 3 files changed, 68 insertions(+), 11 deletions(-)
>
> Other than the tiny nit, LGTM.
>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>
> <snip>

Thanks a lot!
Taehee Yoo

