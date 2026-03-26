Return-Path: <netdev+bounces-272279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO5kC6m7xWkeBAUAu9opvQ
	(envelope-from <netdev+bounces-272279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D6233CE32
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BB88303F404
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E334AB1D;
	Thu, 26 Mar 2026 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaNJOzGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389C3491CD
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566306; cv=pass; b=QlnOMin9gYJV3CrCOpzA6IVnU73OHgxTA6o2529XW2jVc//SaXRBpqD4duLLNw+Q5hYyYO4gXjRVKGbEzuKwsMAe4+BPhRuu6WEYQ5mb2vt1ccFQTpiUcCbFgktiWxLY7/YVetcPVtjhRBUX7CJSFrLBFZ6H5Nt7TbqXv7P2/70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566306; c=relaxed/simple;
	bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN63rm6K8l3Djx7JpQA5iImuQSol9Xk2rd0XmPW8Eus2Am3Yj/WcD0f1DvMTPiWYRnaImV3vpdtuXa79AxNztL53mrTTRAiZUHvW6B8who+xXPHd7Xtx8A3RlLrpYmILRKeSQOdy62VhsSvequHsaJfZmHvTpwSNQ5pYJnZDtpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaNJOzGu; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a43f1f978so12942171fa.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774566303; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0pzl0qhRDW+sNh4Jrm68An0VuaVYgyiAXVahAD6MZxt3PmGwedicQqmjB3EipVIa7
         HvVc8KhaTHtmnYXeaGe/9DwlB8ITDTN0xMadvDxZMKgbf/Xmm7d3TeO1mNiJuXm1pdZG
         HQtzgB8ZWd/18Z/mS1tDidg3t+fxWirZL9k0n9UE+3iLuMG/o5X/5kDwqHXBbt7a0CGN
         rpQUkfMQCJuhQK2I2gT2DdMd+PyN8UfkW3sHezLGoHkpJyaOTTjbjLHeyIdNLvSKxrSF
         p5nQ+bevDRNPe4AYassSE4cJbQkhqd547Q5mpnDgtn+ZnAA+f5n7NI+jKMfp+KuVAS/0
         fLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
        fh=IB0THJzNBhSzkXVfEjSDOjCL58QenNpHouoIS4m1XJY=;
        b=bG0l8sMX4DhBy7M5G005szDfSpiNKh09Kn8acLQDgtoiJEMbvAcTStpc7QWR1PZlnl
         3qeAw185Ff+80ToHJEzhW77iB8jxAfWidj48d1/bFfpwuDQ78htgTfF7tcmIjgC7xBUy
         L1EtmafSQjnNyiMPdu2LrNsyhCtlk37Itj/xe7EfQJ6vTmBkj0Xf4LQc6KSKHP+DOxNq
         zqRcnqkhGg/UbIsFL0J2bhMP3KFCCIai4rVwFHiHNUnVgqFxTmEPaseHREkmDI+J3K1F
         km4xFOFjDs8lO7pbdpXe3aE8PZqZKaQB0zDtDMO2ELd5HZ2uDAz+LuEy9dYs8AVnZZvO
         NKXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774566303; x=1775171103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
        b=IaNJOzGuKk66x9bGRVdihzQItjJrDW+wwhMeJADFsqe2B2pR+j25805au+Mp9U+1on
         gTfvAD8GLhEInnUYIlsm2W3S8X4bWdkpJfeFzzjz9E1OfLi5vE1FdiA4FWptabNDaGym
         VEfCCdO016d7UmyQFlb7a09uYoCIfl9AsRmCBTBFu0lLxMZ/gm97t7DxfMDv9giinMKt
         30PSGfH8UmrszhwHBwrkWLMFHPW13czqDjjrWRRRKHFl473qVXXUFz5rrKRABk/7ZIoX
         x551SOAgWbDkUO9NpTgYNvE13b87HOZkmcg/gDjiee3S1BusCQ25G7krfyU44YdTrkZG
         cSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774566303; x=1775171103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLvt8ALPWVdvZI4uxDrR8DdfOnNc7X8dwjsIDh2c50k=;
        b=qUUcDx//XFg4JkMDsRMGSrDI5Vy/uVWtCIfve284MawItkfSF4VJzM2IN91UfiwjpA
         FFC6OGWxHhcry13VQjxUmuucVyMjMzjbTtgMBxyeAL3CC8YNB6IZKby//FvkB8jV70Me
         ChLbZ7bXk7lFg71UZBrrY6gvgxPqsoObTWp69K20N9FLHT6oBKuZLoCYaP6t8KrbQ8ay
         uP0i3ON7JTRpPg4V4OQq0wWIj07dr0GXC7LzAOiOyU7sdCFGA+XRTIczT4Fz3dVoFGNk
         uAm81+L4P06HVuQLuPqGD/WW95mBPqmz5rKOMdxDd+P8wpCsFStE4yTYfbrOoJkq1Z6F
         VCXg==
X-Gm-Message-State: AOJu0Yykbmj8XCx9CmRkoh7K/UAn1K5d0XkI175Vkqw/cPsunJbnJ3Nu
	WpakUSkWXH+eX+lGDrvx6YqJlfFSAEu+UPe4s3txiIJ2w2NfGzMalr53eBmkClAGLHxpyZESxUD
	H6zBB0JbN8tEMd7gFDGzd8VEi8ITObOaRhkWjiTDS
X-Gm-Gg: ATEYQzx7BxMFKqbXg7gG1khXcJw3AEf4u6XptxmmZpcpz92WrmLArnIw/aHR4hSsWOo
	C4tLSZJ3uIyF2H/F4MYe0pyc9b+Y7BjSFdEWUdDuP+cftVpvG60/jWoSR+G939dUDZCqVuZbryV
	KsklCt7k37o+1VK1k4AmlKAZjiAbjD5d8EliN43VREbwQuMyU6fG+ffXcrB9dD8tC3QhyOIExea
	9x63y6cActBKnpn16S/iW5k25GpfXSr7MftreuBSa3Ry7PUbN9m6lGH393R07EWoFXuO2qu7hU3
	m3yD0AdDykA3kHL3Ve3f86dcsJ5iIT4w1/H3+hKQHyoUBr8N
X-Received: by 2002:a05:651c:41cc:b0:383:31cb:e3ae with SMTP id
 38308e7fff4ca-38c730b9edcmr1215331fa.9.1774566303147; Thu, 26 Mar 2026
 16:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com> <20260326114919.519456-12-maciej.fijalkowski@intel.com>
In-Reply-To: <20260326114919.519456-12-maciej.fijalkowski@intel.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 26 Mar 2026 16:04:50 -0700
X-Gm-Features: AQROBzA8YYbhp_WNDVEgrQlqIcAqd1g3tgIQ2HlIhS8omAzHiv5MEEX3d9L4hKs
Message-ID: <CALuQH+U0NJYxFZOeZ=iwJAygQvC5LHg0xAKWTUdHWqXoFunNLw@mail.gmail.com>
Subject: Re: [PATCH v4 net 11/11] gve: remove home-grown xsk's frame size validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-272279-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00D6233CE32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 5:02=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Since this check is now present in core in xp_assign_dev(), remove
> redundant statement from gve_xsk_pool_enable().
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Joshua Washington <joshwash@google.com>

