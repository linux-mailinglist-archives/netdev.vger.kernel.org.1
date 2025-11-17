Return-Path: <netdev+bounces-239175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB65C65082
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E2D6C242C1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3E2C08A8;
	Mon, 17 Nov 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxpOdySd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D682C031B
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395545; cv=none; b=H4QzvRpGbAaWGWSCIdLSYlqR26/m7m77Ock6jBVPG7r4NugeUebpAsQXHQAW9LyusZnGXd2SqwUYrmPdw9NEFeG2yR9gwGvapzqJa+8v5IZl+2aQf58ddO13ekamnWkIG2V4r6rqF8JczfQR3SsrSKUAnvbNdXUU6jj1c4SqylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395545; c=relaxed/simple;
	bh=Z1ZPUXC+BkXA/YfZeoafbz3VsFJMZuvbaSF3BGth7T0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HA75o6dxUMu0LwUCjdLDNJOglpQcw/x2eJ+rZ9EIN8738Zj+Jxs5/hCI4jQhEvLGz2Vdp5GW6fTX8aNVWqcTpzgYf/NRJkag2uLGdClMRafrOI6J4G4X3Q/z0LFC2MRCuT1ceH2+6JvJnDt8hfuI4bmyq7T2EnfNqcTZozI3BBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxpOdySd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219db05so8240275e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395542; x=1764000342; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWe6QK+Mzst1Wuln0ZwDVR3ENtjJrt89Oz1HghbK66s=;
        b=fxpOdySdBE32/RKC5azySsYTrmAYPN/Mp1Sl/muoyERMq21vbrzB+G4VXTuTXSuhko
         d0cmo/zeEwHw7YxqSCMnFbGeWkPiLMAQr/ivW/tsXDbjL7cIvOAReNC6sk0ar38zOPpL
         EOk4oe2y2+sQELVC/Oiav92F1iE7o325A2ucfszAIz2KuaG4fA2VlJGqU5NFYzDIo+Ed
         LyQ2w9IyH+V038PmfDezuCpKVIod+KaAQ2LF2bfQY6VSvhGyq43ocXhOlCgdZ/A4pSI2
         suTeuynsk+tumZngvHlULl877MNSaVmoitfIPtCd/Vv52trWmze8Eb/x3oa2Fh+mq2WG
         s/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395542; x=1764000342;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWe6QK+Mzst1Wuln0ZwDVR3ENtjJrt89Oz1HghbK66s=;
        b=wF5YW2fUU6xFkEmVH4ag3iKKb5jEcNchvMTkhOx4lJ4d+0ctuKHTTzHqOaP0ogQqjq
         civSI7oR7VQna5TNGQ4NP90aodlCUGX0prhy1TTxo1iVGhpZcQ2mlt3iNqaHx0xN/BVU
         c+BRXy46KNsded/11K7+Z6UQ3y+U1JL4Y2SZSdrU/AfOhhR+vDuyMLCZXWSA3z6EfYZa
         VbUQMvXKIwxUa/AZWFtKsmTkppBKFj+Skm05AbSHy21nBJ4HsaJE237Ua5OtNxfTbHgc
         MhRx6DzVrlXL0mcPlJ9ml+zQ9F3NTOMw8S17iDsjr2qmprGW/WxJfIOi3Vq/MHUYODWO
         gHpQ==
X-Gm-Message-State: AOJu0YxskR9xzYCOvhflHrOtpOpij5sOXbvfW/HBWAVRrTEvbUy/D1BA
	qm6LAmhy6a/iUaUxuRcXP8PPB6MCXRLNV8YJNJ70Y9aGRCVH/Aq4HCUh
X-Gm-Gg: ASbGncuVL+t5+6JXdq/cMBjt2PqaBJ9vVzGSC3YYEnk4LlFCMPGPdjbmedmnw9I0MBe
	Q6IsNBCfR15MnXyp4ZR6QSR7ticCPcQE2oKASFUV4LKT2CBzL4V7pMXhGdmA1cJr4ZID9j3D3Mk
	ZiPJ0ZEN2TClo/shCjEfje/LnaQUAsv0bY6Cp1zxqa87e+YkN6UOfbPEjS69w/p4ww/Omn4dOQV
	Sl7u8Hj5dG9VWrh1RgHlSPGRky53g4TEleJszOv4H/EjOiXnjDOrdoZ5dyQ5peZJ/3Wnm+HTSk1
	ModIzwCT0mUu+tYjZi0e8QLURXHxKIYIKh2yhVUiS2R4IZkmyDAMw0GsZcsEKkWkftiGgIoJVxS
	67gb2zaMRcpvz5X9dLAei31l03MeNWfATe4BlS5izPvPs0TvBPprooG2MCzD/Z82+2Tf8zG9gUu
	TElIKQvjwo/cp09Pa8p2uecyQAlPIWO4exEA==
X-Google-Smtp-Source: AGHT+IEPNm4TyrRudIsdq8laTTfzzuE7bAfzczRklpAT3OAuqUhST8rkna506+iKoxROjx7TmF3sEw==
X-Received: by 2002:a05:600c:3b25:b0:477:7925:f7f3 with SMTP id 5b1f17b1804b1-4778fe62d4emr108695555e9.14.1763395541468;
        Mon, 17 Nov 2025 08:05:41 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6acsm325718085e9.9.2025.11.17.08.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:40 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jan Stancek
 <jstancek@redhat.com>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
  =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Ido Schimmel <idosch@nvidia.com>,  Guillaume Nault
 <gnault@redhat.com>,  Sabrina Dubroca <sd@queasysnail.net>,  Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCHv5 net-next 3/3] tools: ynl: add YNL test framework
In-Reply-To: <20251117024457.3034-4-liuhangbin@gmail.com>
Date: Mon, 17 Nov 2025 14:45:06 +0000
Message-ID: <m2wm3on2fh.fsf@gmail.com>
References: <20251117024457.3034-1-liuhangbin@gmail.com>
	<20251117024457.3034-4-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> ethtool functionality. The framework includes:
>
> 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
>    operations
> 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
>    feature gettings
>
> The current YNL syntax is a bit obscure, and end users may not always know
> how to use it. This test framework provides usage examples and also serves
> as a regression test to catch potential breakages caused by future changes.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

