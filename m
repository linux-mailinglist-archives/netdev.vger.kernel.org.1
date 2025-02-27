Return-Path: <netdev+bounces-170159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7B9A4785A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42BF16D37B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFB225412;
	Thu, 27 Feb 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRvhHcsC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEA225A47;
	Thu, 27 Feb 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646555; cv=none; b=SYzQrQXayVbaNNoXX6e9x39sqO1k4uu1yapaaP8qdOrQj1LqYoUwMTxW6x24TEOOX+VHQln5Bg9PnPXDK2zKpgFt2Q4lwxtf176usboHVNaEbai/WKRUN1Sbx+JacDiHok/G84M63/3V4eMlln83ns0SMLu4ZyioFune49eEFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646555; c=relaxed/simple;
	bh=zzW1pPg/jcx5KFyUAplxx9uvQbfAeJxBeYcRxfiZxaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPXhCeUCpN69bd3VO48q6dB8wEoGbOHCjoqeMifDXx0ZBaaeHaWhj/06TKhjn0AvEzRcOGQ0SLBl1Izv699nkXG5HFFAM2Ix3bZhcG1m5iHvjwRV2Zx7ysO2oBUtily3NK7GVGP6y9nVtGZC7BB2uYqbPprSiSsFzBheTcU4Ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRvhHcsC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307325f2436so8364721fa.0;
        Thu, 27 Feb 2025 00:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740646552; x=1741251352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKG/nZrBPYz/+j7Qo4AkWnNVzwZqSX+lyGnOuFjG/cM=;
        b=GRvhHcsCvk3Bfvw7vRuXZiz/VicXN6FT6qaFoI3SeU0YSrUoiMr5LGFncOYNACPjjE
         Nh2+JSKyFikivwLzhqkBfwL0qaoXRYcqysvoDoiHnifVmq5qedo7x73zQ+cuv8XHNrX6
         W1jC71ZXT1HsWtwVkatKn3uxQ49pKep9h6goKt+NYjVQ6a/9QQEgUMQygUI7I6+XGzA8
         tZu0VZ98JP3RYsiQLqu2Jvk22ohSPcv52ece9ormtI+W5xp0/5Pojgbh75nnuQ7xomfY
         SpnGAy3kH3ZIN1Vzzk2XtOLhKb+t6tXBx7lTUwlsFmTU9d1BAYj8FsLP7LEn6d+Sr0G/
         G41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646552; x=1741251352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKG/nZrBPYz/+j7Qo4AkWnNVzwZqSX+lyGnOuFjG/cM=;
        b=eaAX0jcNl12Ho/GEpDOMNYR/CynJ8v795VoRH1dlTUXWetN4JofM8aPCyhDX/A+FW+
         WrDPTIHJlQLxCAj6pEjiHuxd0hCgPFGz6siTkW51oN7li2TtqaZQMv0e5ZSZwjjI/ofR
         7pxP1guQ0AiXu5Wh1gdMcceOdvf61U1FeVitT9eRj72+IwM24tX47OgvLMk/1/nmJtfG
         XFg6jnJwpFuLWCL8OAp6Op1jEHuqcgXDvvKexCIIkI7Fa9avjQtDUecBK03fpp9jt3O4
         IjwEXWYZwcpcpFY9RSKV9R2EE2easBhQgfXpgjpJdmBlDDC0/H8e520hpoeFbOYFS3sh
         hkGw==
X-Forwarded-Encrypted: i=1; AJvYcCV6/Vm2CA1rz+r30gXZ5WZc/MUl5GlD5GkcPgqsTNthY7uqDrWP1bIEY7Fq7AaeXcyEQXMdHqdw@vger.kernel.org, AJvYcCXrBkDh3nkNOjUX1ysjoaGFfGl5ABnXFEH5NckW6n3q6FACKyIOYcmvtL7CWiNw7K4XkyNBc4rJAJzCH5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmBmIWvbK5oNo9PFTkcLo+SWheZy+WYaX2nCx+lgelrlBdgJ8B
	Irt5ZaNjnk47xrfCWhRxZFQeMT56jKjdxPX/gPj5VXdjWyB+6ZLr
X-Gm-Gg: ASbGncvjT2yyBxma3JCWsjNzhBudP1yMDjhO6j8DjvGlTdo8oFFKkdc4nX0ocCZhfyL
	mmNsO9GuLdudLuFwIuATGVKotIOSZ36E6V6XHlg94KFmndD8tUjwRcfU3WLuG6cjon+CjbHs9Bk
	vNeYciKarRoMttUfL5TS+9GGDCP2e3Mo8qsT9Ef9rNKb9tpwLtcmAYo2KweQuI+e8730j8iRP1G
	O2ZtgIkeOB5FqK+a2cXSdpSYUAJ8eJTF0a6125fdMPf+IvdCoI5PW/QyICnGAudGZmiTL8hTxaC
	I6sPxKaOfDLdrr3dIc4AT1lH1kci3h9QbiCBH727
X-Google-Smtp-Source: AGHT+IHYTXJDuoo/FbzX8USEE3Xrh298/okH4Oe8k1Yf0MVc6VYlfNCIq+USzEdXy8tkvE0d5iEaKw==
X-Received: by 2002:a05:6512:3f07:b0:545:a1a:556b with SMTP id 2adb3069b0e04-5493c373156mr4341151e87.0.1740646551652;
        Thu, 27 Feb 2025 00:55:51 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867a7553sm1143851fa.16.2025.02.27.00.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:55:50 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 51R8tlTe009570;
	Thu, 27 Feb 2025 11:55:48 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 51R8tjld009568;
	Thu, 27 Feb 2025 11:55:45 +0300
Date: Thu, 27 Feb 2025 11:55:45 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
Cc: patrick@stwcx.xyz, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Message-ID: <Z8AokYA+ZNsxnHaG@home.paul.comp>
References: <20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com>

Hello Jerry,

Thank you for the patch.

You should be able to follow progress on the Patchwork[0]. What
upstream tree did you intend it for and why? It doesn't apply cleanly
to net-next, that's for sure.

More inline.

On Thu, Feb 27, 2025 at 01:50:44PM +0800, Jerry C Chen wrote:
> In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
> need to be null terminated while its size occupies the full size
> of the field.

Right, the specification guarantees null-termination if there's enough
space for it but also allows the firmware name to occupy all the 12
bytes and then it's not null-terminated.

Have you seen such cards in the wild? It wouldn't harm mentioning
specific examples in the commit message to probably help people
searching for problems specific to them later. You can also consider
adding Fixes: and Cc: stable tags if this bugfix solves a real issue
and should be backported to stable kernels.

> Fix the buffer overflow issue by adding one
> additional byte for null terminator.

This buffer is only written to by

ncsi-rsp.c:     memcpy(ncv->fw_name, rsp->fw_name, 12);

hence there's no possibility of overflow. The real problem is the
potential lack of the terminating NULL when it's later used by

nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, nc->version.fw_name);

which indeed expects a "NUL terminated string". But how exactly does
your patch guarantee that the 13th byte of fw_name is going to be NUL
is unclear. I suggest it's done explicitly in the code after memcpy.

> WIWYNN PROPRIETARY
> This email (and any attachments) contains proprietary or confidential information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited. If you are not the intended recipient, please notify the sender and delete this email immediately.

There should be nothing "proprietary or confidential" about your
patches for upstream. It's not unlikely the maintainers will be
ignoring patches from you containing this notice because they have no
way to determine who is the intended recipient and what exactly is
authorised.

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com/

