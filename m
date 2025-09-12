Return-Path: <netdev+bounces-222729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D57B5580B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D17B0C60
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A820FA9C;
	Fri, 12 Sep 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gdbk9Rzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C325B30E
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711183; cv=none; b=dVioVaW/88gWMNNCzuijbE0AqtA4C8UXHnDuMB9EcJRxj1n7K/IwyaBP9/HXjOADw2f+cf/qdZdHMJD2bFEjmDMGWYn4regj3QXAQCrJ41ec6QKev0it9rKYbHG4TZM+4zH4xqfhK3GKXJnVOrE0+ByZyKLw59ycVHSdNc1DobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711183; c=relaxed/simple;
	bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGdycgVWf22g+XPSOkZOLbg+FbR61Nukp1toxTglTyO9S/O5ffC8j66HupJAa6MybFCQ18P+Jbo2C/5fzewEo4MyVS1ii15pPSqpZYtM2y9B5gXT8VrLyRbaFQ2QeHqC5tbjGNrChMGF13zefW9gQ/HM8qtfsAaI+l9HcDAidR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gdbk9Rzm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso773e87.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757711178; x=1758315978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
        b=Gdbk9Rzmm43q3XC1SuwbKR27h6gTtC9UTih2MIM6UPO5RdNR0+oYmS0tXFpoJa4Iuh
         olz5CvZp9LuSdXZJPD95gxUvPFx0Ipjn6CaNTF7eHVdeKTeR8pFVCi63G+Ghklr2mSH2
         YbpJI2i3PhRv/r/z+V73avfQDsj6tpYr3iKOoO0SNi5Ruum0wOIqwPoIRiRbVZ3kfuzi
         fGgsu6pcSWrd4PJ0YVHHUlZ/zDt+njq1TT9pVtMssbMoqk0DNuoGXYPU9Glaa4Bacj8i
         Oa2J06pWBtDV7eTSD4YGaIovPLWLFAsFR21FEAnPdfgyF/EmKT2H/Glg3tvZnezV4bjc
         Is6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711178; x=1758315978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0uLC7O54zZEqMTW/1kC7lXHzi7kn0Wiz3wS9V4s0nk=;
        b=CKTXTgkGXrf4VkA7Sr45c4OptgtOgmpZkfPQUGhAPLQERG3ae4rwMMd85WXis2Iz/4
         qR6gi22vYsjOeUCQyn0uyyxeK6doFsnCDCX+pqdCIms2hGfGInIrNRRwsrsJcUmUJszv
         uPubtrtompEEek5de23swfHqjaSZDcHAJe3jWkzrhvUs4MMwntDk9OVOiyxjCq1lbD1u
         RwMwt46hZCCmFg4xHsIzC9FbnxHJoQfkWxOMOloiD/x64i6hxHYk3hHwPQyYS42MnP3o
         7BXqBbwj8qPvKqe5FfxyL73jN11TXHZ+2LPbwxjDNGvNYALVRyC5WuFOU4iOCAlA35rF
         55eQ==
X-Gm-Message-State: AOJu0YwcK/JygGOayxWEVSHV+yHAeLtPDvwbSBv8BZJ3RSsbeLmsCOHP
	u9CDRnL10Fsb/xvpHwxe0oGqRy75KFvJAlo7DB+Unduf3vfLVTNTmM/jYT+plPXm+0Xwc1x7NR/
	Hro99q1Au/ouKAUvJUB4MRW9J99vW/klneDXe0j9p
X-Gm-Gg: ASbGnctdm6o7AAtwk+RuUvVXI4JCQdfazwMYJLgxariiQo+85Jrp7QQmT3qls7v7AMo
	OfR3utlx1LViJFpTxHHZQHQLN+V48XugBFNtBfHvPdZyiWqj/9HO3Gy21EoyCQCZTYDo8BSyltw
	GIgwUlTL3CqSpiX8/XI6uQFdDzPbJSCfFD2lJ9xfcGWNEWV+u//zuXVD1HrRcv26Idwwzc9xyeC
	fDcTkEdGCn/KRM5oY5LZer2z9HklRemTrmgk5u8FJXdgOwcRdu8UqE=
X-Google-Smtp-Source: AGHT+IFo4cD/BxVNOTywCONMB0xxSgIfWIheC5wDA9CVLI7iF4J1whY/WrIulwEDO784Yw6phn3QOH0lmYu8KuRZe0o=
X-Received: by 2002:a05:6512:4284:b0:55f:6aa7:c20 with SMTP id
 2adb3069b0e04-571ec0f1920mr31259e87.2.1757711178303; Fri, 12 Sep 2025
 14:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912170611.676110-1-sdf@fomichev.me>
In-Reply-To: <20250912170611.676110-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 12 Sep 2025 14:06:06 -0700
X-Gm-Features: Ac12FXyWyx4o42PDWjsODv1chbAaWgFV6VBuUC2qYTuwYWTDLJD2IV5Da0to1WE
Message-ID: <CAHS8izNSeLSzkTsmhcVwJ1fF25Y_LY7vo_LTWtVL+Erc8dD6SQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	joe@dama.to, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:06=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> RX devmem sometimes fails on NIPA:
>
> https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-de=
vmem-py/
>
> Both RSS and flow steering are properly installed, but the wait_port_list=
en
> fails. Try to remove sleep(1) to see if the cause of the failure is
> spending too much time during RX setup.

OK, I can see that happening indeed.

> I don't see a good reason to
> have sleep in the first place. If there needs to be a delay between
> installing the rules and receiving the traffic, let's add it to the
> callers (devmem.py) instead.
>

Yeah, I was worried there would be something asynchronous about
installing flow steering rules (such as by the time when ethtool
returns, the rule is not yet fully active), that may cause some
flaky-iness, but that's unlikely the case.

> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

