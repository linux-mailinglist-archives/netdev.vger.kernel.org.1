Return-Path: <netdev+bounces-76464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A486DD35
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5862831BA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964806A00F;
	Fri,  1 Mar 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dibQtQzC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDF69DE8
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282250; cv=none; b=PgLylmv0Dw5RcCmFiJkllMRtPbzNvbVZMjUl6dqnJr+zH66C6o1ScFIZMoYZ/Ihf2LKqMumquArCR3XSRGyv/a4lyP0Xv3njPzkQQvQhWmm3Kgm4ejflRaOSRFMyADcwQWGRQWDzY/BxNCh7C4MTpMUhMc2jfu+kIS1hhcd+sJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282250; c=relaxed/simple;
	bh=tVXAdVS+yxprIPCyL6SBLuEZeyVr+WmhpBunl15Xtbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STzTUdq3mLBqdFfI6eEFEKXaTISSnYh5NbxxDAFhKQakvmo64NgAEjQIvsdDDm0RnthXFOlxNMNooNY/oktaJ9BC2tlsJnIoXXSeDVGVcme1R/fVMnzCrVVf8Ud2j8P7+3A0xlVBIt41RgN8qGbd5KjbQhwgYb6Sm1Anm5PJR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dibQtQzC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so4093a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 00:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709282247; x=1709887047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSQT9fygJBSAolwSI9QZv+GotuwQwfvMmONXpUGngqA=;
        b=dibQtQzC+AZmkZUfA5QjM0GcZMFD175TxsOIM1GVn3pogKg/vVIgYPEmYmzJC+N5uz
         y3DS5E54lLDfYpKyW9u5NaqyZYGmCfkZKVvMSz5I/3avgfGDHuA8ipXzhMr5f4FJzXF7
         6uRjYsoFXPtEuMflqeEpWsY6ru1dlAS1+sYv2diiyjRq3aLA8LB33Gh2lR+gGLqY2Bg7
         XGWRUr2zCnDuGesntHlPMOKtDWZ66ny2dkEy7hORQLJpATehALv30xrfS7sp9yk4k/eF
         L3dS9l4R/XuDfyp2C4UIrUwHbFTmtGY2yRemKqbQm4jf7myEeHR2wKjL0RzrQqUkSigC
         3IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282247; x=1709887047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSQT9fygJBSAolwSI9QZv+GotuwQwfvMmONXpUGngqA=;
        b=tHk4pSdJVSeWgN58RS/Y4h1wOAnrbLX0vEod+6n5hauDynpzUxgWevggfeH4sws5MD
         SGEhrHXD7UrVRonqUEubvEXQ6DysB8ADk3rSwez7xC9fHLKCYIgileYbaovBnOKCpTI/
         lfRKKHPD3WYmFEa8cy59Yz+flPQrrt5rGmiP0Xa/ZXT3CBSgG3LR1+DK2rNOabMOiLpE
         sC3I0FIXX2g/GbUlmBlgIgbOfzuxGkjdPVE2dYhOMOrIlH3WFBFjQs+LNtVbMnylDJFg
         wJzMiczNpZgCQcMBNoGE2ujcE0yWjThbeEmPSjhjMxxU0EvN8Moe7HbooPUDW0u7iLFF
         aN0A==
X-Forwarded-Encrypted: i=1; AJvYcCXMt0lvAh//cGWZTlAEFFd57k4O3MnEOeqAHE/nKy4pfDIaX02ErsSDQYNCGz0IvinOClZtJsATiq26teFL4aNvdibvVMGm
X-Gm-Message-State: AOJu0YxuyNSueA7nKL4mUzWu4dex5wBi+Xv/+1Ev0lrYJ+/tXD8loZtB
	Hg+7QekFF3o6VqKHCa6XVTnMJQVU/OHMYC5hOmUVIZFBhTtGNNQ1hpvhqvIyKTKkL+sirfB/Hrm
	ouLB2PGK1nkmo/uok4qyF3Jot9QKLmmF5BlLy
X-Google-Smtp-Source: AGHT+IFzV+/uRCuPbnbFm/lDq7Mi93+oIfgpK67ptSMy4+vjkhPj0FN7O+GWnm7ckHi6VrdB0rQfdcAd/TfhuAF53iU=
X-Received: by 2002:aa7:cfce:0:b0:566:6e9f:e9d8 with SMTP id
 r14-20020aa7cfce000000b005666e9fe9d8mr54158edy.1.1709282247114; Fri, 01 Mar
 2024 00:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301012845.2951053-1-kuba@kernel.org> <20240301012845.2951053-3-kuba@kernel.org>
In-Reply-To: <20240301012845.2951053-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:37:16 +0100
Message-ID: <CANn89iJ7eU_f+uFMfGEtHMS0XvT2z1-RDPgkeBs-VTCSNxGwPg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] netdev: let netlink core handle -EMSGSIZE errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org, 
	idosch@nvidia.com, jiri@resnulli.us, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Previous change added -EMSGSIZE handling to af_netlink, we don't
> have to hide these errors any longer.
>
> Theoretically the error handling changes from:
>  if (err =3D=3D -EMSGSIZE)
> to
>  if (err =3D=3D -EMSGSIZE && skb->len)
>
> everywhere, but in practice it doesn't matter.
> All messages fit into NLMSG_GOODSIZE, so overflow of an empty
> skb cannot happen.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

