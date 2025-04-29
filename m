Return-Path: <netdev+bounces-186769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BADBAA1017
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98CE1B62396
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3821D3ED;
	Tue, 29 Apr 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJKU3NkR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B178F44;
	Tue, 29 Apr 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939645; cv=none; b=UtQAxHzXQYLrNrkESrAJN2xSRbVPiNz9glUkWEwMOnCC2VDaeZJDuoB8oeuBEJXm+/hVubMeon3BJbUkiXMd6Jq29j5UYwEIB5i5ORpGORVhVIjATdccb3mQH5yynUK8WbBAXXU7NrZLvQGLVhcFQlJFDe3QAMttwArz/oUQ1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939645; c=relaxed/simple;
	bh=J+cqf2s2ZsVOlPPPz+/nuFcDjfaayMiIycIXe8NZ3jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQwDWcQThZjLrLNGjhUVcBZDkE485/O1FMFLgNEWssfshgXMPVsaQ+FewSZq6vJHuFwwoTksKDSDcRlab+BPRbcHoNq0/KRnJglCcXSIkpvNvkpkTu89CG5Uvh/NTzBqS4XocvuellKAtTwisQ3IMe7siIJAzJk/Cq88tlE9YKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJKU3NkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4ECC4CEEE;
	Tue, 29 Apr 2025 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745939645;
	bh=J+cqf2s2ZsVOlPPPz+/nuFcDjfaayMiIycIXe8NZ3jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aJKU3NkRD5t/kJNbO77GIacdoaPwfKk7V+9ISs7XWk0csI6WULh7ykNIADn1FIG61
	 5xlLqD1D6EOwmKyEJ1RjfHU94q2zfkIOcFj7LSn/RpvRxw/PLygAGD1S6yLUp4bntw
	 4S16JrKrka/Xp7+WE98qTUWAlEJTqid5qwkBOwjj9hfIzappXI7WtHXCur1E/yeD7Z
	 6KfXyq6ZR6RQtTxBsrQfD0Fizqhn5Tdh1dpjIkN80/sRyn3dNPiBmNhIpg1KcoqQjp
	 1DUx3u7ChvZuxZOw6jJcYiKiICxIBit5m0QzSzECK3SLX4bhKw9w4sIir+EIhonaWW
	 SCOcCzt3/6xcg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so10302335a12.2;
        Tue, 29 Apr 2025 08:14:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC4YKW7G/NuuuPpbg0u6GQSibj6HC37rWI5JDyqZ//Js5uVxaKCY1swq8BE7UjOVuMeGtXS1ud/TQL@vger.kernel.org, AJvYcCWUt7uL3SmAi74nYz3PBk+ljfSt0AxoPgInzbvURk1ywTuAktoJmkvuCGvFD0rfpdvnYnhrSdmx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XXJ7gZBnRsTS76WZckFVXgmNU9OXVrmMFv5L1dZAcjcPwAbH
	v9dGZOdP0Rl3cyd17vmAlx9LagTtFjfzG+K3xtj+kx9LtVmtkTxvcHYFgwUR6uCcs/M2dwKRNfB
	MIxX6hPTa09VzVYhutZFF2+wFTQ==
X-Google-Smtp-Source: AGHT+IHGk3svgwgIr+T/+w4Qwka1z9IpXIwGtv6Rj3x2jTq1l4XPrYQMuDCnPoKOAj5jFEj0LbkSsMdcXgIGTQoIfnQ=
X-Received: by 2002:a05:6402:3783:b0:5f4:d57e:4ab6 with SMTP id
 4fb4d7f45d1cf-5f73983519amr9972583a12.24.1745939643488; Tue, 29 Apr 2025
 08:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
 <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com> <20250428-alluring-duck-of-security-0affaa@kuoka>
 <656734d5-cf55-4ccb-8704-2f87a06fd042@gmail.com>
In-Reply-To: <656734d5-cf55-4ccb-8704-2f87a06fd042@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Apr 2025 10:13:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJYmnk+ApfC1mxjMxCWFoedn1-XCKHS7Tq_gsgOTnx2Fg@mail.gmail.com>
X-Gm-Features: ATxdqUEcJ0-psBajiUHJV-OJQsB-f_InmqZfaR6IrhEWOgyp7c4A99dwRJCsJSc
Message-ID: <CAL_JsqJYmnk+ApfC1mxjMxCWFoedn1-XCKHS7Tq_gsgOTnx2Fg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-phy: remove
 eee-broken flags which have never had a user
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:28=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 28.04.2025 09:42, Krzysztof Kozlowski wrote:
> > On Tue, Apr 15, 2025 at 09:55:55PM GMT, Heiner Kallweit wrote:
> >> These flags have never had a user, so remove support for them.
> >
> > They have no in-kernel user, but what about all out of tree users in
> > kernel and other projects using bindings?
> >
> I doubt there's any user outside the kernel. But it's hard to prove
> that something does not exist. For my understanding:
> What would be the needed proof to consider removal of these
> flag bindings safe?

Like you say, you can't prove it. So your justification in the commit
msg isn't fact. I think if there was some pain to keep them, then
removing them and seeing if anyone complains would be fine.

It's not clear to me here why "eee-broken-1000t" is still valid/useful
when the others are not.

Rob

