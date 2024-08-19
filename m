Return-Path: <netdev+bounces-119567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25713956424
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C501C216B6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8D15699E;
	Mon, 19 Aug 2024 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dNoeHLWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DD156230
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051474; cv=none; b=eyJTmOuvw25BgdgkDPUPP9SqQszDDi9tPvSiToqIsHxLtBzh4RHAydwhPceISwHPyeGRAAd925I4Gu3FZkFclA4Dv/HiIXNbqZlShEGIn/zdnZqDf4+0hSV4hPOcZdoxg+UxDCfuiyIjxQQ/qwRiihRG2jtjy9pRNZFA1QlBGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051474; c=relaxed/simple;
	bh=WKbuxYC01id4+Ff3hENlLipWycDHQlk5MFcE7NofbCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4lyqzKN7zqIDTA+BJCpsWBBVHLTI3MR/M/VFDvSDwznsQCmRQ6F8gk6jQV45+/DmpgTN6XCynu6PdE+LheAKbbkP6f7iL8wWGssf4We5whLuvjnOzbN3VhZVx31sIJo4oBxXRU53hhze4FIwB5LxON5kPYvlLjxn+a9Vm1OuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=dNoeHLWy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b3afc6cd01so14998277b3.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724051471; x=1724656271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9nfGkovW8vcqRFWINyztR24SI6/jP26YCMtTeJhmS4=;
        b=dNoeHLWylfIKnuFR/h9tUSqRNqVUE+J32GU0sgPKkOaLykCHml7SxClI1xA2gK7C23
         5tH/U1p+o9N4msSP+qs8WYhB9jzXQCfd4m/AcWys/rP2DgBoRpMndQaziD5DOtdi5ibM
         D/1foLm5jmKvYln6TPPQwkhBE2YzfQLrYwZPfvtaGewhWaZGpRTMyc2MUbCmXoCj2oYo
         O349Ut/iiFKKnkYCEUp+lN4B9wGNTYoCMjxsfRc6j+bn5crYO/xFVqjTn8DwTrxYJ3Yl
         x7lh2gZvb/pWLBUAAX4GlqMLaUHFjwXreg5rt7WNfYr2n4RNBS4TC3R4CY0lPYs/fBMi
         c6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724051471; x=1724656271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9nfGkovW8vcqRFWINyztR24SI6/jP26YCMtTeJhmS4=;
        b=r0Ufk/HXmomWZYDQpfd09WVRan2y9/VUcQuQA4fp25hPYHKeVUfwU1SVgWrFrztnPU
         vKWRiwhAkMind75Taju/c8LmzWLQNLOgXrinJNQWjdtb9FHY8UV/Ie57IApMMJppTBNx
         bo3B6Tl4qxQ5M7gBe0eKBSg6wp0qhznMSMJq+rRVs/oRUdFX8s1JsNLURWZ60BsfqARP
         EZWn6g0ih9Z5CWmKKTTR5M9rb9LwxntGghyWiAEF9j/CF5woZoEMJ+6gGx/6pYCeKJce
         K4dWTV5QXhPYv7cinwq8WXIpv5Mv6MZLjgGEUuBbj348diNeLToaXR/TtoDlBknbFg2D
         R5Xg==
X-Gm-Message-State: AOJu0YwLtJgz5mob2gulYTFoCH3H9zGKbK9mOkovdI2QaR6d621682JH
	LDL9WuGJbmthmlXFiJeRkC+vmW43Gc+2+5Plg63kV8WBkcgR+FcHphgbH3hd4MUAZJR1Zx6Kc6o
	GVFSSOq7+ENsvVsK702SvmeDTcoI09IDqohhxtg==
X-Google-Smtp-Source: AGHT+IG52YRlkwO/sYk9tM3S6bbGgs2DWnHbNNkAXWZpRI9/MJdElTyRawH1W5AXAOmY259nCFiM1hCCpj/ccvV5BNo=
X-Received: by 2002:a05:690c:7007:b0:627:7f2a:3b0d with SMTP id
 00721157ae682-6af1cf61e4amr101407107b3.14.1724051471094; Mon, 19 Aug 2024
 00:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819005345.84255-1-fujita.tomonori@gmail.com> <20240819005345.84255-3-fujita.tomonori@gmail.com>
In-Reply-To: <20240819005345.84255-3-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 19 Aug 2024 02:10:59 -0500
Message-ID: <CALNs47tnxcV9-azZPjwQkFoHSnTC8TMYmHt3kPqWWG5q87+JSg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/6] rust: net::phy support probe callback
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:00=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Support phy_driver probe callback, used to set up device-specific
> structures.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Trevor Gross <tmgross@umich.edu>

