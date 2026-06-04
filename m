Return-Path: <netdev+bounces-295199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8FGiE7ZkIWq4FgEAu9opvQ
	(envelope-from <netdev+bounces-295199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:42:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6AB63F840
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:42:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ofMYgHGV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295199-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DF22300CB34
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CF37DAA3;
	Thu,  4 Jun 2026 11:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC53B19B4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:42:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573363; cv=pass; b=o8sqae1io5tDcvO9f4hD4WHokrvbQp+NYdBxIrRBUx7inkkJ4yQjtzrUZXmm4UIJU+P+fZsNOcfjfTN1RV8ipd9pBLO24uE5HxfkPcu0EMnona1CUHVe1AgOg830H9aO4MYRpZ3+q2zmCCiC+XL7E4HTQ/toi4rOZZIOjmjHXjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573363; c=relaxed/simple;
	bh=FbnpYPfxAJKxvfP3P1fg4ad4+ClGu+rvv5pRjqFwkq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIymcc3ad8UFEPStMUdv4gteawYnqP+1tVFWQNsN8iccwaL7Ufip6JsD3UfbMOwBMAkuHWLm/95Wa8rG5pxx7v1P3l4lTA7CCkhohpI1o4RRr7FB/pvue/hBZjVAjzKfdpXkRew0oGrgQrrTK1s+FhKxG8+w2rH4dGmHa92fhRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofMYgHGV; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51765531803so612681cf.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 04:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780573346; cv=none;
        d=google.com; s=arc-20240605;
        b=Qvenpe+PHqou7UptzL0cwq9wQpEOf4ls+t7MX5r6OwMirQEnedisMiK+L3OTTlO5JU
         vjlK5eTsPlAebqz3Ri8gRhzybEHGLqr27wSlaxbDWvkKQjEF6vws+VRtE3CB4mGQICmp
         dD2mHbtEiAAROZ8ivwE7JduCaLoucT5XU1Iz1F8pxZ8OY/JiyD5H/Lse1HheuMwyldBC
         QGVyKameN6KSzX/iMCvu9HcoCJhQXYxDZ7cTZvoz9l4IBaj2KilCc+V4fcv+juzi8yc7
         DeGs5Leprga/m5var6MPA4biZoauEVSHUHgeWrMATwsQBUWMnsaQxJxylUjXIJSo0Kpr
         elJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FbnpYPfxAJKxvfP3P1fg4ad4+ClGu+rvv5pRjqFwkq0=;
        fh=WZWd8HHWCMsMxIIjJX303rpbMgsRe7SL7zrE5ALPLYM=;
        b=KMw8M2n+0O0w3Ijj3Lx+DP9nvPH1iMqTVJIrjItyoP8JYXuhgExJ1TZRIHAM+Mcwc9
         /2/eFife2FhfnXw1y1inTpjQB5B11QFZFeEQgciESFnC4Emr9tJpoql4Ql61UmZHvMdW
         VqxdArlwhlDSuk7fHFaZLF5Uu4Gh+m7gOQwa4KFbJ27B5P3rdkne6p3+24yqE77QGwex
         ubi1ggWn4RksBUrgO/vDgehQbJf795CtLc+VNgMUEX+Iz+Fz31lRyoYD/p6lLAwjUwVf
         2riNb52Yem9Bjs0CuJJqco+MQyJNV8VTNYVAOGsymPWiFowuwGKCEJlImg4Ni+k76U0+
         BCkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780573346; x=1781178146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbnpYPfxAJKxvfP3P1fg4ad4+ClGu+rvv5pRjqFwkq0=;
        b=ofMYgHGVzLiBRNe1dpirhpUOqXYXumHHwLbQh86+vI7gYZ+6NYw2mtb/lf3Jcv9hoH
         /A+MCi0mNr50ZKWcK6GFd4kcuZqLxmTANHWWwlUBVaxrndAD8oM998ze2C5Qroi1OiBT
         MXK1L8iJRIHx1tv36PIixO/3fQ0NOQPrilpQXahjkR8/mZ17T6oLsGeXwkx46iH9qQ0w
         jyWH3YwgjMOuJl8pzGG2GHaHEX65z/eeLMjOi11YUDEfbOgcZnSPxaFhZ22fvnfw2vDZ
         qoWQQ5ucQttQ/0K5irEqG4XiWdLTdn8uN6HmF1nAeqaN7z83K0GRFLdTV+gOenNwj+L9
         ytMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780573346; x=1781178146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbnpYPfxAJKxvfP3P1fg4ad4+ClGu+rvv5pRjqFwkq0=;
        b=B9od3x6GcCc45fZWeNZai8GYZ5yNDm4NT1EDPUOuDhySTzFibnbgu2bQZIQTro+aL9
         gT+CfzDIRmFQNtnaTV6WIb+y+sx8dnPG6cXZfIz3gP1m9+i4BwVYxjkwCU5IUlDyXsLo
         CmU7ZA5JwOZdJT/TkASRcQodE+IhAMZzbxSlnT2uycKIw2hvBABAoqURQ5XWSgH2vLNK
         xXI7d45/9m+pVEkLknKUaPmoFmroizoTMKwdtNAQoqAAA5sBLc0vT8p+g4MhvOhijbKb
         6OXb39+/6pyQrGzit1acC12aHCTEg0KACYOR8uuGYVfeZ5RGOpHfqgwg2YPN2ltNty3D
         ++wQ==
X-Forwarded-Encrypted: i=1; AFNElJ84ZO30BH9WXrcs1zp4p8h0AogiUrptqVgJXIIm/6BY5hvxpRouRwb647Si4EKO8L+D8tiUCDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoY4KewSAP5VSRaTq3C2lhiTdSP/zIeiwnYFcLRHVY6USGd3kr
	gMHWtNegNGLpG6BKsh0akDVlBQVnMEpp1BIE59wEDUFExdrhkPtKb12UcnTaPfigYzXQEwiXAjr
	8fD2Z6i/1pR3e4hlhmqeEhyg31Bd0fERRwZVgcDcC
X-Gm-Gg: Acq92OEq/AtmlqW/Y4z5oPAzXK+X7LolAp3/cSnG1ct8tVabZfkmVEtNAXN9G0lIUIT
	EEvyiVHlAMnCqfWT04YHPUdZWT/seozX9effM9hgMLZCm43TEx4A9itQHHHzy0oJGTG9ilJCavC
	teG3qvv7VC6kg3mZBUu/rzOorZ1BXWUOI8TB28H/Q+59WPu0jbWOb32KyzpWeJpFnEZdLmbOUfk
	03cLQje7th30FIKQ743FI9N/nCSGYPUXCJmvQglXh0ZBwm18x69V/OBvgZ8uoE3+Z7nCzpHl6c1
	XQM8U8cA4HuW0dPtdBCR3nfP1sdK9Gr+vhFbCei38bKIF2MgOw==
X-Received: by 2002:ac8:73c4:0:b0:50e:595d:164 with SMTP id
 d75a77b69052e-51787800020mr9916841cf.8.1780573341312; Thu, 04 Jun 2026
 04:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-2-yuyanghuang@google.com> <20260604101917.GB771160@shredder>
In-Reply-To: <20260604101917.GB771160@shredder>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 4 Jun 2026 20:41:44 +0900
X-Gm-Features: AVHnY4JZT1yAeeXoY02SJpeJczwb2yww4ccta8ULWU6WONEqms2x0vqy29Kmqho
Message-ID: <CADXeF1F5-NdbtfmVxbpq+8WVSgdEZj60tO9yqudrCL4+v5x=+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ipv4: igmp: annotate data-races around in_dev->mc_count
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC6AB63F840

>The patch LGTM, but note that sashiko has identified a pre-existing
issue which could deserve a follow-up:

>https://sashiko.dev/#/patchset/20260531030705.3754389-1-yuyanghuang%40google.com

Acked, will create a follow up change to fix this.

> > But it does not apply cleanly to net. Please rebase and report, adding
> > the target tree (`net`) and a revision number (`v2`) in the subj prefix.
>
> Paolo, I think it's better to target such patches at net-next and
> dropping the fixes tag.
>
> See for example this recent patch that went into net-next:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/net/ipv4/igmp.c?id=061c0aa740d5d3847cd600a74c66a165bee1fbe0
>
> And this message from Linus:
>
> https://lwn.net/Articles/1074171/
>
> Pending Paolo's approval, please drop the Fixes tag given the patch is
> targeted at net-next.
>

Acked, will drop the fixed tag in patch series v2.

