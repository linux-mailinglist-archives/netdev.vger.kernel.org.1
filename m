Return-Path: <netdev+bounces-103465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D499083BA
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37729285D30
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203F01474C0;
	Fri, 14 Jun 2024 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJQ2NeLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66522145A05
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347143; cv=none; b=igOO0lVqLisK4ePcWhejIHUSZcV/0d+PZ2XHuLoZGorZB9vajMYnmgRrBMCORhNOtz+5GZqbMC51laEH38DF/+0MQgGKIZ+bRHxr07/WkUkL9wmXJUdD9Y6Uw3EUsmSPdql/wke9wO0NuzUXibLJPNW7wuhMxRY6i+2wmswCB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347143; c=relaxed/simple;
	bh=g+yWGkH4UDz6k28TGb/mwg3RMLUuaAS9cKmBCSlwYhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey3V2h9ddw3lZxsl8AqxIhhloigUj7C163m8FfRri2sIZez16eFWSxIX8Wrr+qxsZZYn7Qn7dwhC77XUXJqCrH2Ye9JvxZqjxhFScVkw2XdeVeUC3HMuqdkaxpa0pl0JtOvAqllj3yIbIFil40U2KdSd3vlmDwHpevv00Nvf7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJQ2NeLA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so6693a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718347139; x=1718951939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S0qL4wLnvorEENi7YeeUcLyrAwZjeIKV7yGUCjneOA=;
        b=CJQ2NeLAIGngzBNF1rTs5AO2Y+w0KRPH7NTsxKs1aEEZYpa0+q/VYqItKHmPy7Ceah
         xW+JvWGJBbAWIiuEBar54lcSEXiFUGS8P8sGDlvEMnYxzucF0woUa4EGFJSsKtMOQls+
         zDLXL92D2HmROhuwZ0J3AlF0A3Ohk9bCafNhAtCKKtFrJIUMoEsycyUhiNxjX+0BTz6E
         0/WGvQl+J4plU2uxnrIoLizrTceuITGdUWgZJ/Z+rNw+1e+RMea2l9SdgF5pzTw5YIxS
         /pM57lReWXTgoByMakI9VvwJj5BPtxB6AuuuOHHvkUjHqyGY4fXmOLeTSydC2uM9vGiW
         QkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718347139; x=1718951939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S0qL4wLnvorEENi7YeeUcLyrAwZjeIKV7yGUCjneOA=;
        b=H3Y3EXcFy4Nndmizat9jYq9/tr/Iw63wDGo1ehiTk8VWjP5455X7a8CqpiG5X1x1Ij
         c9GWknGvrTOBCjtmmZLmk4YKamE9gccyACYpU4OBQf9g7ll5Tgl9d3XrS6hl5EZwKJKn
         b1EzzbMwumMCs49JwVxDuqUz+U8g7pd/hLNo10PE6UwHO4W1UbFzFmMbmTt2zNbGN3qZ
         MQjvylRGzKpZGzWwdUJfdVk5yhhcXqJ8R+cCJHWJCYBP3f8R44+DBiltxgXgxaORyP7K
         LfOtpYClyXxSeQrrwna6trl49r/70CBzcz95gUwt7TFBisYz7abtRl4t8YAaK+7hmORT
         3QxA==
X-Forwarded-Encrypted: i=1; AJvYcCVBaBd2kTLbJkW6Db7RC302CiCsu+c2jlcVdBGIiH3j82reUZH3LmiZmSeJGhLUwR2+q52ZyhqkVLUx6xJO+mtaIrBBFzeH
X-Gm-Message-State: AOJu0YysZq6HYY5dKEsN0ULyjkgP+bMjMwjoFSZPnIW4C6yUYxuY376P
	r/bLtO3KkMIdHxjS63+05FALtF6YNzrQXersGERse1nLLAefIW2DSP3njlemyiYARISZUqxTA37
	cR5Sujwq8AYudjk4oXh7ykoAEnTcqMa+Odz5D
X-Google-Smtp-Source: AGHT+IE1jOtrdGBQUhGeeYb0rz+/9oAd8wR9gSqk1FZ69xua+yiyEPu9CDs0W/RO2CCXmoLA9CvNFkNLBcv9PtjXVHU=
X-Received: by 2002:a05:6402:26cf:b0:57c:b3c3:32bb with SMTP id
 4fb4d7f45d1cf-57cc0a5b1afmr87115a12.1.1718347139234; Thu, 13 Jun 2024
 23:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613213044.3675745-1-kuba@kernel.org> <c3a580a5-cc6d-4bfc-b233-94a3d3377c95@intel.com>
In-Reply-To: <c3a580a5-cc6d-4bfc-b233-94a3d3377c95@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 08:38:48 +0200
Message-ID: <CANn89iLZFhzRVTf22dFMR5wChsUhGURy1AevfpwgzqF0LznyNQ@mail.gmail.com>
Subject: Re: [PATCH net] netdev-genl: fix error codes when outputting XDP features
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, sridhar.samudrala@intel.com, 
	alardam@gmail.com, lorenzo@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 12:13=E2=80=AFAM Nambiar, Amritha
<amritha.nambiar@intel.com> wrote:
>
> On 6/13/2024 2:30 PM, Jakub Kicinski wrote:
> > -EINVAL will interrupt the dump. The correct error to return
> > if we have more data to dump is -EMSGSIZE.
> >
> > Discovered by doing:
> >
> >    for i in `seq 80`; do ip link add type veth; done
> >    ./cli.py --dbg-small-recv 5300 --spec netdev.yaml --dump dev-get >> =
/dev/null
> >    [...]
> >       nl_len =3D 64 (48) nl_flags =3D 0x0 nl_type =3D 19
> >       nl_len =3D 20 (4) nl_flags =3D 0x2 nl_type =3D 3
> >       error: -22
> >
> > Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev st=
uff")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> LGTM.
> Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

