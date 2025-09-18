Return-Path: <netdev+bounces-224237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7B4B82BF7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5CD173D0D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AF022756A;
	Thu, 18 Sep 2025 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IM7RdEta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B842582
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166001; cv=none; b=hFxbX29yQjPnksQ4wQmo0OSJSANRzub2Ew4qY8lPp+qzrGWJ/Ok/nFvt7Sp+lZJBWci+Q0UYJ8TUGqS27CS3EfJuILQwNHyECwk60kTpmldaOSqsEas/ERffELNOwNdt5DZJEheROpgPg4TEZkeGZzKOshI1ECQNZfyUg/VD+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166001; c=relaxed/simple;
	bh=Pmt1aYLfi/OSES6dc7p4aW5PTLjPxl+/tbS4nE2iIkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDhzVjGb+VBdrbQeOd1crrWTH9tXhhqIRzS2UBRetUA0P8eDCDJEHdLvnRTA9BCJhKT6bAkkvHmkyAgpIyrEhYEPm9Gdk2SHdjLvUmLBZXDANNQHwKQak+FzHIrZkFTQKsF5Dmaa4KIpB1vhIdAfkTqxnPUN47BKeC8ptbxzLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IM7RdEta; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8287fedae95so70265685a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758165998; x=1758770798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6We32+dqJ5hUptpTPuBfjJhgS04xVDaxSc7/QMKPbGg=;
        b=IM7RdEtaHRfWSPvmlgl/4QB21qVU10YkTo3a0f4QJao6hsouO/CcP/wd2nlu1vuSpY
         gWL3iJ4zolgAFDYfIn2YNBK8rQAlVHsUoclt3pZIlC9V7tMjDsCr2i9/3CuB47XtQkU0
         NKjPk11XgArtmeHGYfbdInaUEoNED9EeWwpv0NaB1X9usZ5aBLeSkSGEBBx2MtX53SuD
         UWep27TMRAkrjknNDYoAoBFl5iurvPJmKOvJ23LPzux/Fx9jAOxqK99YBeMdl7Apm84+
         I3CiO3sfAXvhstYIw174WzrjAdVaDaBBPwvCr++tlEi+hfeYy81IB7NOZ+sbMA3bm9Cm
         XSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758165999; x=1758770799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6We32+dqJ5hUptpTPuBfjJhgS04xVDaxSc7/QMKPbGg=;
        b=AImBI4gYVAowdzaKkpjkK25SD0p/2OjorNGenYUmfTg9W6amJgr9Sz7kY4kuVgK7vt
         mKw8XGnUSLO8bJ17WLhWpSgZvF/YgYW2ANdeFieOiDEhE3Sf1C5ENfT2d4PVDb+Sksjc
         CWBulvknZhyKx9949NIxz2CYI31aKCRpCnFgmiLFUtG9Ul5f1E930jvPhsW2F5V5VXmS
         3hYYVw3SvJbVqLuX83+M5BMYDtD6kOa95JWayBIvjIbogXRfgnomwQBJajaYI5EYzNvy
         oU0cdjrzIEvw6nNFEStFh4DPBlFOqU5/2Tct94ZHjOEtqUPKg0KptivmY9LDV36u8/It
         8Q/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhhk9sDxj2rYbiTgyn2P046gsF+AKeK+Is6xptvG9asueJ9Zn1oumTYd1vCXZJibNVclvMwKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypDAlqzDjcAM4fr1iY9brrMNj/ADwD3V5jdXJNgtnuSRNsfrp0
	5bKh7nn6WFHVfy50xsJo/jZyumUKuEIAKD20jRpEp3BKujMkSBMtLY0HvRPsclr/ZpZSYQJ+Aai
	6QlFmB7aH9iSsqMgA37drX7cjZosyQI3yC5hqAVh3
X-Gm-Gg: ASbGncs/3PvDrrIQIvWy1T9L5wTwNWU3xyKiXDhXBQpyv/gxrBbI0s40wfAxMi9GluV
	9EgqWoVCt1+TriboaIBFKC5yoM3K+881nin3oiG8IhMNYIq8cfhFPp1aTbyzaLArakiKIbetIsk
	awWIrPc7Ql/AQrWJ4qlkUbG2bjNUIDOJRRJTsoOSghBAQmcITxYhii228GtO/mH2q8jMNBFjmF0
	ctvAce7nYikAOCNOHYz+APBz6DZGCKC
X-Google-Smtp-Source: AGHT+IFYH7+PsUOPNt92CziPHhSVune1yNyU9F8dB6ZrvSBkt9EQnXyPXJSXQ0V6LnAIlLztV5aHWXHBoG+dArqoFfY=
X-Received: by 2002:a05:620a:4727:b0:80a:cd77:be3f with SMTP id
 af79cd13be357-8310e4aa2eamr510659285a.48.1758165998170; Wed, 17 Sep 2025
 20:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-2-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-2-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:26:27 -0700
X-Gm-Features: AS18NWBe32ItUFqqHAlD7WKnej7DeQeOdwSaGy6sU9r1Bg6LsIvw9AvQFKIcVFs
Message-ID: <CANn89i+FeSDiRkE7ZXZGJ2bTwYX0=745sPkkvr67x0rqW=fM5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v13 01/19] psp: add documentation
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:09=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Add documentation of things which belong in the docs rather
> than commit messages.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---


Reviewed-by: Eric Dumazet <edumazet@google.com>

> +Key rotation
> +------------
> +
> +The device key known only to the receiver is fundamental to the design.
> +Per specification this state cannot be directly accessible (it must be
> +impossible to read it out of the hardware of the receiver NIC).
> +Moreover, it has to be "rotated" periodically (usually daily). Rotation
> +means that new device key gets generated (by a random number generator
> +of the device), and used for all new connections. To avoid disrupting
> +old connections the old device key remains in the NIC. A phase bit
> +carried in the packet headers indicates which generation of device key
> +the packet has been encrypted with.

'phase big carried in the packet headers' here refers to a bit
provided by the receiver NIC,
part of the RX descriptor I suppose ?

'packet headers'  is usually applied to Ethernet + network + TCP headers.

