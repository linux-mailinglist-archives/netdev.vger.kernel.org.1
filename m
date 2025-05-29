Return-Path: <netdev+bounces-194272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DDAC83BA
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 23:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A83A40D16
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8899929292A;
	Thu, 29 May 2025 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GIQJfm6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A05249E5
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555740; cv=none; b=HqMSkdY+z2+MDQAy5BqRwKKpJWh8o+69t0WgaaGqIuevObSoMgF8T6azmpBhqwnAWmGD+/dV0l8DPhs81g8FyXIqok6bTolMFfEyiwWdMfS7x3fbaBq4QSZzA2p1+PuWA/7dygj7GU4AYZXh4XouSVu4G+F03M+LlqsqoeU6mRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555740; c=relaxed/simple;
	bh=RUCzxjR7IekM1a4kSEH5opLE+rPn0u2uzMkTxuXIyYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8p+ggsYiU0SGoLUc1H6JjzTBLRXa0+2mFOHy26ckVepBJCXRNKwJsTp5sZD3S3RcdKJyvx8kmqrlA4K+7Ip4HeOVG99G7f8jTo+zzby4x8eTjks3RYJnXXBSnKfc7k8rgIk9Z52NewNxAXEt9XlTiCS7evFGpFDtu6zAWu2sz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GIQJfm6W; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32925727810so12445061fa.0
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748555737; x=1749160537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUCzxjR7IekM1a4kSEH5opLE+rPn0u2uzMkTxuXIyYA=;
        b=GIQJfm6WwrkyfO/erRCYXQ96yfAclVHDDTkd+tX/bA29ZBAlEVXNbZUhOhFnPM/BG/
         IUCN3EVdf/dfyiJurkV10V2shmHqgpC/4a1BPahJKuG4Fus9QabgQCLGkyYICjaXFvSX
         tKDhCds2ZLxe/sEYYmoAaOHN4PDGndxL04ddw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555737; x=1749160537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUCzxjR7IekM1a4kSEH5opLE+rPn0u2uzMkTxuXIyYA=;
        b=uwWvAwDLH2UPcDvRzfOsra8dQLzTTwkP89TkLC7wyF3xX88SiZ9V52NxnkdsBPBVqo
         LnTWa889SoMRRvPFRewbKve3+C2KZO9fpIwUq9O3zIoGA1RGp4Zdj+nFYZG5/PCnvBVZ
         ci+v1gU26gpN/figIsY7QwbkaXVRvq5XwvgItcoxRPjukBaIIZTtwmwnUwh8SMQ/7Pqr
         Dsqp4NH2SKEM/qZy34+hoZALUbzxou9S226jlVfcCSOgNvcdLNJYgpGHHuydTF3xPTAe
         /rAHEi8xtWa90oyy7/ul3PRAplkDbYkgL0bxeUOS+dZQW+QOHDa7MFpsT+RCCKXsH3bL
         nrKw==
X-Forwarded-Encrypted: i=1; AJvYcCWolbBW2H/AHVd9NBXGhRRl16OjSnwzYFCS6knO0gz2uu/ch3TF3z4pjHXR6ud64w0F6uDQzy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDo1JE00SbQ2zwhVV5O6xqTQJOfTino/f0eRhVxJliY6VQqdx
	sVvW6WSGOiaY9tcpuf4X3LJPQYppb5OimXnVsN9L/UGBOcwyo6KYVeJNoYCxbvmIccMeBWv6QyU
	7jCSxjHx+PfIHygE2zEXSRqOKyKnw3qJrqd2+VyKt
X-Gm-Gg: ASbGnct6tk9ZghwhINTYLgpoEM2oJBOldrKNZq+wXww4Os1Fs9Rx+L35LMGB4HG+eJw
	2M1fitifxifWVXo0krHHCTyv30SjUSB+fO/emXwrIO+4C9ZrN0JGh9YzIc1fe/gcXSTgCkuQakW
	q3r/YyBX5j4QYeoagz8lBpRXmi+79TXS2Ujw==
X-Google-Smtp-Source: AGHT+IGdOld+7YXP9ssfHUcfkf/2iroyB+O4/3ZxI3cYVzni7X95zPArmZWsOfPC6H6XG+f5Er3SSTs3EBzTon84iWA=
X-Received: by 2002:a2e:ae15:0:b0:32a:648d:5c0f with SMTP id
 38308e7fff4ca-32a8cd5808bmr4820971fa.16.1748555736843; Thu, 29 May 2025
 14:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
 <20250515070250.7c277988@kernel.org> <71d0fbf8-00f7-4e0b-819d-d0b6efb01f03@redhat.com>
 <CAP1Q3XTLbk0XgAJOUSGv03dXfPxcUR=VFt=mXiqP9rjc9yhVrw@mail.gmail.com>
In-Reply-To: <CAP1Q3XTLbk0XgAJOUSGv03dXfPxcUR=VFt=mXiqP9rjc9yhVrw@mail.gmail.com>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Thu, 29 May 2025 14:55:20 -0700
X-Gm-Features: AX0GCFtcB-kjJF8l6tUeq4rt-EmMLhhNqzs4zV-Cf05W3_895cC3fyPVPqBPyxs
Message-ID: <CAP1Q3XQcYD3nGdojPWS7K4fczNYsNzv0S0O4P8DJvQtRM9Ef1g@mail.gmail.com>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Guolin Yang <guolin.yang@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 9:10=E2=80=AFAM Ronak Doshi <ronak.doshi@broadcom.c=
om> wrote:
>
> On Mon, May 19, 2025 at 12:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > If otherwise the traffic goes into the UDP tunnel rx path, such
> > processing will set the needed field correctly and no issue could/shoul=
d
> > be observed AFAICS.
> >
> > @Ronak: I think the problem pre-exists this specific patch, but since
> > you are fixing the relevant offload, I think it should be better to
> > address the problem now.
> >
> Can we apply this fix which unblocks one of our customer case and address=
 this
> concern as a separate patch as it has been there for a while and it
> has a workaround
> of enabling tnl segmentation on the redirected interface? I think it
> might require quite
> some change in vmxnet3 to address this concern and can be done as a
> different patch.
> Meanwhile, I will raise an internal (broadcom) PR for recreating this
> specific issue.
>
Hello Jakub,
Any update on this? Can you help apply this patch?

Thanks,
Ronak

