Return-Path: <netdev+bounces-128877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B784997C435
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F138B21183
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35518B47C;
	Thu, 19 Sep 2024 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaYFrih8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FD1F5E6
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726726681; cv=none; b=PMd0z/RuEx5uWVa1901LOLs3JhhhAC1y75piNMtllKCj83TneRulpVKlGuJBwIKlHsA/8TVinmVYhOwyn3m66fMunDwC7KXYhOY27fULVQXl3PkGl6fSIj/u2oh9UFFAJqQy0u+TV/gfjrY1qsD3QQeL5hWIkYytYueQZmlydrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726726681; c=relaxed/simple;
	bh=drHiTrZGIbdD9m9cxZ5KaLt5PLoDqs6yDSgFCLJgi5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG0672yDFEIGIVhuKwm5d4Cs1b+OxuoZabh4szkVLTXDfGnpvTz3YTWZ8c/0cDOKScGzLKoZMT/dUtUjsMfaTOU1d/q7LwcvGSQMjPQCRt4fWf3gi1Z7hjV3RW2+fg+8Qcv4IavtSs54HKLDRbE+hRX2KCBIKr8c/HzVXE4x0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaYFrih8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1120a32so287428f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726726678; x=1727331478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZL7k5kl10Cd4+ycwob7PCF2YJq0BzwUlfnL19Gx80U=;
        b=FaYFrih8ewQRTXIUa332EpLfFXXWvz5TIkCMPO/bUIMvabTHlxUeixG7cW2muU+Tmh
         4PzWdA8inxr+9XdANC0cjsp8u1UyTe++ZbinHug8Cc2htVvyYEi2+me2qoqaNnHia3XF
         OEPHE/XRex2/Z9odH+6S/neop7g/gLFPj5CsOS6kGD4Zx0bsI240Ti3Frvc6RYnaOH84
         02fyhGgSsyoDzfg+PJWjrE9ejNR7tPZmQ6ADJrmvEQv+rl++kBTKpF2RlXuNBXVzkkxQ
         FQae0f0rQaJiaJWFiVe7yLXIk+aBOtFG4aIa/blAVdYSOPtaUfjfP2dhTUI/L9zuGklR
         oXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726726678; x=1727331478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZL7k5kl10Cd4+ycwob7PCF2YJq0BzwUlfnL19Gx80U=;
        b=l54M7DJs4uErrfjIUS+MVELkrmo6Gj4lkRRRvtAfvvYqvc4U1K6+GJ7NZplf7Pdyw0
         sTem3ilpqDzPbyDk0YWMtdVFccgX7pvkMdGGi78vCFxtoV2n4J7tJ329MaDQ+I2QkiLf
         H1Ntop0b6YSRqaNn5YHCfrTOy6QfbJ0qRdnojnOPbdsKR6YjpMNfe6I7WQDL0VEEMSAY
         Lo/3sn9RODcxAe9yHuj0yYkoClqX8sFNBkofta3NNB0Ez9nEpwjzpSzVzS/NcO3Jweu5
         h97HucdRuYlLUqD+VlaBjcJa6wZuerzHX+FX4X6rEOPdJziEbh4ttAPYDlKGbuONho0q
         NARA==
X-Gm-Message-State: AOJu0YwCAU/Dyckvm47PWCmFaoIhfAGcrVMDRFxHbzMyOeS6zYjqOXsv
	QvayKKlElg9m2HIYUJBZXYrMXN8wsQ6Uzr6EvM2S3Yn53YQnp7fk/UCH9WH7e9x5fP6ar4XrEh6
	D/n1vRUQ9s6+SQ/DpqERVnGmy3jchRoTxUsqcgGG2G7z7C8xh9RZ4vOM=
X-Google-Smtp-Source: AGHT+IEv0Hb/pxkbcM7u49CU9rhXxPCHskB33M65/kNvWzendN9J/iLoewCRd3ZirTm/ihKlJl9xLQ5NeaXoC0pBL4w=
X-Received: by 2002:adf:f0cd:0:b0:371:7c71:9ab2 with SMTP id
 ffacd0b85a97d-378c2d55524mr13476034f8f.52.1726726678067; Wed, 18 Sep 2024
 23:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919043707.206400-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240919043707.206400-1-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Sep 2024 08:17:42 +0200
Message-ID: <CAH5fLgiJyvSztvCDz8KZ4kF0--a0mqi7M4WowB==CCs2FmVk8A@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import DeviceId
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 6:39=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Fix the following warning when the driver is compiled as built-in:
>
> >> warning: unused import: `DeviceId`
>    --> drivers/net/phy/qt2025.rs:18:5
>    |
>    18 |     DeviceId, Driver,
>    |     ^^^^^^^^
>    |
>    =3D note: `#[warn(unused_imports)]` on by default
>
> device_table in module_phy_driver macro is defined only when the
> driver is built as module. Use an absolute module path in the macro
> instead of importing `DeviceId`.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409190717.i135rfVo-lkp@i=
ntel.com/
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

It may be nice to change the macro to always use the expression so
that this warning doesn't happen again.

Anyway, that is a separate issue.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

