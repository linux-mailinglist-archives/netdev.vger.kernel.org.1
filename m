Return-Path: <netdev+bounces-145927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E984E9D1503
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9504C1F2168A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077AE1BDA95;
	Mon, 18 Nov 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLli5seL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988F1BD9C3;
	Mon, 18 Nov 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945948; cv=none; b=Nh92x8hKhYmwoCXn0WHDg8lDMg9Y1hjYaWsb36jh0QRxnt8iPvIiWex8ztdwsa6wONLXqHwR7aS58CglCWHa0DfmwSEpl4Q0Enra2UkTYsPVoZm+Ql0watZUJ1LjGY3vTRQzI7cVi27MttRLFosWZfkwXNssKO9p1HZOR7ajjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945948; c=relaxed/simple;
	bh=k44zIQ0S4MFwyQTY6IZW4xAiVOSmjLBV0+3wLzd1ukU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpIdsD4EHmM5FRiQ+x+6km6ODUozJVQ5AlW4bn6l7LfxYtKJQSqyMPB6NJvo/rD3V6rLJhIGjoKIDuY2EfZkS8yedYVJCSAZrMZ+JiCWZK8D7ZfUdEkxjiTMmee8y5YRDmlKPuKsix1mYGbyUZV32yFVRxjIlTQIdnMy4fW/bJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLli5seL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee36621734so774346a12.3;
        Mon, 18 Nov 2024 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945947; x=1732550747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k44zIQ0S4MFwyQTY6IZW4xAiVOSmjLBV0+3wLzd1ukU=;
        b=LLli5seLjiuXCAh3/gmLAEF9+avTX6hxMq2XXYz/5ftLyfQyuJC15pp4aTtufZxVaN
         MJJvdHpX6rw+bLXhj0DfpG8mjZxi+3/nVlAaxfBX6314dtl7S6XQKUxQ7SFMxF35xb4z
         5h6c8ZArcxC4YHMhPd0jAeq6kfQZ82Uj0xVct0GRX14nA7sQH1Npvb56V/1PT5zgMgBG
         2rUXl9LIb4F8NA9acwA/sj8UO8xyT4FqWa2A0uApxJVpDU5oeP9cR9zFkshQ+9Di8waO
         WGRc5zAEIGIpuFkSB4+xi//EDUNZnvziPelWu28jPhH0pZPd1b2Gg32roNDOD9R/v4FD
         uPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945947; x=1732550747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k44zIQ0S4MFwyQTY6IZW4xAiVOSmjLBV0+3wLzd1ukU=;
        b=pOLdzd6KuOlkjdutLH4DG3oBTeW3qAYwhAxqaqMJdsfL4pGJ4EhCteDStj5x5wNuz0
         04GM/kLrenoL7MtKU/m1NKtJgXyS11YY5hOF2jrf3ZhxM3D8yn+6krz/AmZc44KdZtO9
         Mnp9oQToqN3+yGPDUTqH7Z8SjbWQbHn0LUxAsE8OFRQf7KG0LcZEUAaZEh61na2/z0Y8
         4pMtoItdl82qcGWobnaB8+ld4XqPGUMYNtmhXabnaXfiYgu41YtXgeIly6Eb48oJsGx5
         igSMB+Rgtc1dzP3jsozTDYtJrknU2qaYRBQ+/TvVvx1PnFTuk1M497dtAoCGWvFycM7a
         uH7w==
X-Forwarded-Encrypted: i=1; AJvYcCUxXzwiNKZrWejy6k00Oea/VlOfkEd+xtdNcrpYQK69fc1HeZu0FFdldy3x6oT4+0iGftaw3Ib0aT+HzQQ=@vger.kernel.org, AJvYcCXXN3Srm13ria3oCKrq55pWU6ENyJ0M4tfyG7vuS51hi/lAAzQFn/2TAVqNB2cwiV41s3y3eYsFlGwX1DJo+Rw=@vger.kernel.org, AJvYcCXxD/bTSOQk7tUn0eFk83rpHTNZmmt2/Add6pPJqoFtMgsb43iWyCkre3kEoPHfDxYnd3VWdzgL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrf9UADxAVMCFGHDYbvq4AliK5KT+2gKTIhVXQbeJdNRuef4dI
	0MH91n0P6Do/tWXFw7ycSk0LDvD3wpmgYhwEIRlIDkEPGsxOmHR3AqtXQSot5Og19urfLYYe3gT
	fuAGypvFoEgsoU5k982FWKMzaoPs=
X-Google-Smtp-Source: AGHT+IG6S0sFFkoTAiVrefbp6oMfjC8RUwZjjcfme6xYZ4N6NBZUd2AdnNdpwM3Ebrm1W/5HvpkaOSQrxgVW4ICIC8E=
X-Received: by 2002:a17:90a:e7c2:b0:2ea:509b:c871 with SMTP id
 98e67ed59e1d1-2ea509bcad4mr3444540a91.6.1731945946604; Mon, 18 Nov 2024
 08:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-simplify-result-qt2025-v2-1-af1bcff5d101@iiitd.ac.in>
In-Reply-To: <20241118-simplify-result-qt2025-v2-1-af1bcff5d101@iiitd.ac.in>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 17:05:34 +0100
Message-ID: <CANiq72n_ERNd4=n1r6MOhOzii-EG6ie84tk4M8rg9zYXus-J7w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: qt2025: simplify Result<()> in
 probe return
To: manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:30=E2=80=AFPM Manas via B4 Relay
<devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
>
> From: Manas <manas18244@iiitd.ac.in>
>
> probe returns a `Result<()>` type, which can be simplified as `Result`,
> due to default type parameters being unit `()` and `Error` types. This
> maintains a consistent usage of `Result` throughout codebase.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1128
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

