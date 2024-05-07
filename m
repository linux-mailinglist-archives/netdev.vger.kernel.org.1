Return-Path: <netdev+bounces-94029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE578BDFEA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6991F251DA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DA14EC62;
	Tue,  7 May 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCgx7jU1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EB14E2DA
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078409; cv=none; b=jxbIQprla6v/g6ErZfHzjDUefFPifpJL88HxRZqB3UTL+o/E8MZ9rA0c/pug/0WMgISJ201yyhvssjy/J+D7LKl1QF1hME1/Dt6LAxWm9s9PbYZVH/kOfwzul2teOSXPQSwQ1PIUOjaruV95f4V7MuFQDbTXazMhXXWbxW6kXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078409; c=relaxed/simple;
	bh=RVraaqpU90T9jNynBtCQENH1uJ2RcPjIHtQUyCKdwiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVtwFUPYHbkxv1st4LUV/+eHYvnPZbEP3Pddw69v9jPTgjLKNxGqQsmFsJHHg11+e54x77H10UixsGBtV7WuAWfqQZoP7A1m5pnGEDhArFpRreRiuC8//p+WMVAD29BVMdYlTbrmHWoJqHU5tc/fx8UGy2Nj/Ol0dbSSfZsA1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCgx7jU1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso13644a12.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715078406; x=1715683206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVraaqpU90T9jNynBtCQENH1uJ2RcPjIHtQUyCKdwiE=;
        b=fCgx7jU1Vi89ZQGCFu2/QnRfHtiWPfbRHcU+kdtVk9XO6SV4Red2KNBljrXdtwhgKh
         qpQ/MRspQYGbeJ8Q5Ih1xuDE4zLG6JmQ3bxyZ4c6TWVVbkcYXIPLG8ICPTlt64SA1E4S
         JpEpvjDRhQUJcSTo95i+Zz8azUjPJaslE+3+JJ7Svfeu3BTOw0Ntx1//FxLtcaoCW+t2
         9x2qfAwDp15Vbf/V/UEeiC3rzVEc6zFavWSJOCwRMq6IuEBWkKITZO96EyTKpF6QY+Di
         So82IvE7sWU5tZHahsmJKd0lQZinXSihE3HDAktbIRM18CXVPpgsVXTk8R+Ez5Row8s/
         BUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078406; x=1715683206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVraaqpU90T9jNynBtCQENH1uJ2RcPjIHtQUyCKdwiE=;
        b=P/EDV8UoIi6AvsSvn2hHm0frv2pNLtup8RRyA/UTXRU8VMW2W5vsyiagbjr4bsYZnu
         Izp98NwPzNKeIjQ5mJkSIm0fFNVsAvzxZuSvZDiZciFwk0R7JbpzbK1oEUv5ApwApEz1
         Iw1109yh1o+LkriS5w7EN5yrmQ6+lrxFkSWx+yt/XKTVV278decLYSAFLA6pQPEfR6Q7
         ZNLerarBiWubPcCOnirLeDddqjIUMydvIJQ6xgynF59j6BYSERIlWHpK/o8j7ijpluEP
         KzlEfOU0SzHxGaXRaDdqrHBdAol3Q6xult5sv6A1/mk+5OkoHtRlFi5dOJEQOCHb39ZY
         o3EA==
X-Forwarded-Encrypted: i=1; AJvYcCWOQLDokJiwvhJ6r+U9BOhQO0eyFFb6yneZLzgdMQ+UcdHoLioFwncmImKGLkcoroUSbkOk7pVxr7WR88ohZQNNH9XVVjRE
X-Gm-Message-State: AOJu0YzITvJZjTIHrMTTFv5wYNeDSopvsZIvsQL7rKd+8jHEZF4LebxD
	Moul/qi1EjEw/y5YVno9df9KY8lUpTZjBMmoEax/0nkzhmyrGS/Wqo/7iNTQ0EJm65tcvbVdjSN
	jhucV4BvvYP0YmlTR7d7irrz2VwM9W0sg44ZB
X-Google-Smtp-Source: AGHT+IGURH+TAKjYVx7HNPEQu9fLSg4tmEpjWWFcBoWqrK3Jf56PPoCH0wcN5v4H9exUF8MPoXuFORZW4WZOvliX6zM=
X-Received: by 2002:a05:6402:35d1:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-5731310fe6fmr162918a12.3.1715078405878; Tue, 07 May 2024
 03:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507090520.284821-1-wei.fang@nxp.com>
In-Reply-To: <20240507090520.284821-1-wei.fang@nxp.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 12:39:54 +0200
Message-ID: <CANn89iJuEubWMu4Jg3rAac=HM95U3yS9PSq1eSx+-JC6rhOdbA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fec: Convert fec driver to use lock guards
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, richardcochran@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:16=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
>
> Use guard() and scoped_guard() defined in linux/cleanup.h to automate
> lock lifetime control in fec driver.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>

To me, this looks like a nice recipe for future disasters when doing backpo=
rts,
because I am pretty sure the "goto ..." that assumes the lock is
magically released
will fail horribly.

I would use scoped_guard() only for new code.

