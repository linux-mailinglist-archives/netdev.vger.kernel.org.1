Return-Path: <netdev+bounces-247482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BECFB2A4
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E09301EF9D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3DC28CF5F;
	Tue,  6 Jan 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ole8IbsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252722A1D5
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736386; cv=none; b=k26ogtNt8jE5lgErcg05AzeCRd36WaRpGxuJNpA9a//35AiYRHLtQubWZ3dAtmnb9u8I0bWlsK/O89hc6bQIZ5sPDRDmxEGP8n6EU1OqwTHbmuod50e4AoB9u8xWTNnJPR6a37uFE+rT8lA3gFiFBYC13A9SvMctIXRG3CeO5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736386; c=relaxed/simple;
	bh=J1e3PzBvsbGDQJV4JRdyaBTOtBEIBeMiT97IdIPzaTA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uF5QbpBriMFm6BpgfNMTGuMn6t7tzIxf7gGt6k3hQBVmipysyyZ5ftpYMAgL47qxnWOayc4FqdYbmhb3ZfkbhKpACKWCG6vwxfDaCp7Q5uuzyDpzkBxjaA1zEsuqM7PIqRxZCEjgE45ob7z8lLwG9H78gzIrRXY4sa3aRLeAnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ole8IbsN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78c6a53187dso13766507b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767736384; x=1768341184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1e3PzBvsbGDQJV4JRdyaBTOtBEIBeMiT97IdIPzaTA=;
        b=Ole8IbsNy+jQI36KUk+ihbzqAsba2MBSaXeTbj5jHRLxZi5WezQJlq37o6Ziin1CPX
         a4ZKpKDKxyqWc+qprLH9HA8lMk+vvQahI//QwxHUqgSATbAV6LG8i804hBlQm7Ea+VF0
         xzPEdzKIKXuH3p9a62zoVWrnX3GPXBujEXX030EK8A51aGuMxz/nWmwvbbQTY7HiSUd1
         hA2ELYZnXFheMGva2uQq9OYFndpgjGAIFa1lXexVZfzFRC07wAaFN9vEUu3tb04T078p
         nlZgml+hpy0ZOJyJVYIW3Ee8sfbsz9h1OvVerA2ygPymu9QjEwsmVI1wqBb6mTALu7wn
         nNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736384; x=1768341184;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1e3PzBvsbGDQJV4JRdyaBTOtBEIBeMiT97IdIPzaTA=;
        b=SvEK8qam5Jjr/N6IKKyw0kITJXiLlm2ogRalSfIiI8iHzIn93eTF9zR4jejAarv/SJ
         ec48wbr2To7T5gzy1AZ+Gjk05OVGf0N8gUW/mRhc8A46wcwh7GqLK74XbiJQTU8dagWz
         /GdWfhXGO+alo7rNm0qXmslysY3Uau92Z0KyBUTPkE21HPg6YUrHjiyYzH5bjXRwBKK+
         rmn8z8DwuCLuTXbL9R6GHmfCrvKMV6/Nli8C2/eAezWZHN04LZOSUKShvBQMAISKYl6P
         dKy3EwMc38/ww7cpE7O1V6QYejBc+S52IVs4P2a2XTFrigzNw3iiTy+IGWlEbb1DtvQq
         YlEg==
X-Forwarded-Encrypted: i=1; AJvYcCUsHbSFe6ahiqcUiuDxA0q2t/wz5UdmOfGUlLzvDiMENOGGGXYxvtEC2PqKC3M47eYUInWS7BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qO/bable9flLB5APMCptF70v0ueg1ocb41VGi9qhFEohuRBH
	RNxI6KyhnM2D4VK9Sn/AU5Qrh+iAiNSR31rBgep4+7xaUbBuVpn9Qr1q
X-Gm-Gg: AY/fxX7QnRwyRBAiGC094lFIW0kSWdltznJ+tbLxfA2aENdGMGoJEn+O58P7F7/h5A/
	kZglpGW7i+4N5F25nU8RdRQQIl82TKr5afxBy2TL/xC3PQmLaFENfZOvQCMBD6pxE1XO2wyVC5d
	kh81PoPWGG0c4Fv0J/PDFNcf/S0p2H5IoKjDbDuEjtE9S+Wbjlv++dSRx0KZoHTPrIT134CIN+c
	H6/b0NekXtrVd0cBtve0B3fHIX0YxBKoTcgGwn+Fw/ckQovgFG/3RROUuf/Hj2isQNCEWnNzxzy
	HDPeZE0N1mLI7PSbrpDezMf4UI+Bd7TbsIBa26eRQ8Ap8waVvmmiwJoLP1ePDHldHdMulKqgjSW
	q74zGaWPK9Nd6Ghf7IdMuCl3D8cfZG4Az6OykRqdGiaFwmrWKLPtKBwcQ7zY6tb295P7A6MBOkf
	9Y97rhMkXtW1/0U7qzUDFXffIOEdwOCBSvIc0xoy2b3GlZY6tkdIYCwJEDtR0=
X-Google-Smtp-Source: AGHT+IGjgixfb81YQQySOcMberpQeNF5HhTh7Bj7zc03I1Tkox1NLJa6RxmmanZFBr0SlzFD88cmMw==
X-Received: by 2002:a05:690c:4b81:b0:787:d46e:c567 with SMTP id 00721157ae682-790b56d5dc3mr6061037b3.59.1767736384052;
        Tue, 06 Jan 2026 13:53:04 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa553160sm11924677b3.2.2026.01.06.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 13:53:03 -0800 (PST)
Date: Tue, 06 Jan 2026 16:53:03 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <willemdebruijn.kernel.7b24a60a0a3@gmail.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-1-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
 <20260106-mq-cake-sub-qdisc-v6-1-ee2e06b1eb1a@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> To enable the cake_mq qdisc to reuse code from the mq qdisc, export a
> bunch of functions from sch_mq. Split common functionality out from som=
e
> functions so it can be composed with other code, and export other
> functions wholesale. To discourage wanton reuse, put the symbols into a=

> new NET_SCHED_INTERNAL namespace, and a sch_priv.h header file.
> =

> No functional change intended.
> =

> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for revising to reuse the existing mq code, and adding the
symbol namespace.=

