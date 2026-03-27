Return-Path: <netdev+bounces-272323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AABfBRXixWkeCwUAu9opvQ
	(envelope-from <netdev+bounces-272323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:49:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B828633DF21
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CEF4303CAF6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3515257448;
	Fri, 27 Mar 2026 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMG2Is5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A335966
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576146; cv=pass; b=XjIqDPbsfKYf4yHiY7dMwmg6xNONN3LZwwvMmpMpRfFamt179y5x62Q6KxlJdQLUzw7Qy4WDTbWwz49rap8Ra5GOesAFFY37IvTeCWEdQ514tsyNzkiw0RONLxxRkSNDFUh87QBU7cbgLTDUmWwHeHblj641KOm0ykUjFGCvhiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576146; c=relaxed/simple;
	bh=5yR2LiYw2cW2pMfYnUY2YLw2WetpDSJfe3rA8gRX4B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClVRnOFiGAUvZVPyWF8xRhq0eGVIE2ob091Wr7nEfHnT6DyFLD1dLz4owcvmAT9OL8Da9q9wJQA3S++F17MTWUddZTcoK/N/U2rih/eoO9XiZ71Ne+mjhNlnT39CBSV2W+2BdQ48Bd6tqNcYarRdRAQhqVGgG0YWExD/r8IHsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMG2Is5W; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79bdd50d6eeso2237157b3.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774576144; cv=none;
        d=google.com; s=arc-20240605;
        b=CalY9xbmPYpeXWL9ECEhgJbIS3j688YqlO0IHWEcQrZGpaSLdFYU//dGzsWW8bB8tu
         KkAeumNRYv/vOiJOmkXUVI5t26mI/7tAqrkI7XQ6GHfW3JsK/Io7DR0qYIMMt5a2MMbr
         7t6NE/r4AZ/+qHalR6X/tU+gmVn4d8brdPJhd+j6zuTOJrNkgVqUOwz30TjMNLPavo5a
         q1OvKd4eWEAQVhK78OdBWHmk9PbiExd0dIFfku/JwfeubEUrnDgSQ7om7hraPMNmrjsa
         zOGOf6J71MAof8Tecw3OVow81Ae2lkbR3rqwiXdQKUOlQBVh9D7AaIPrsrllVaCDU64C
         IJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5yR2LiYw2cW2pMfYnUY2YLw2WetpDSJfe3rA8gRX4B8=;
        fh=a3MtZMnVR17KFPfYidJss9r0wmQE2ruV6FdkyKEsIg4=;
        b=fgbESIfvALKgh09SXglur5BKLIhqW45t2C5p+VRFV4IonCs+v9rkf8mmZmDCjCMYji
         IlZj/U8cap+gmCLxWb6uU0BrggQ0I5BzE8Z+X6jAM5Lvw5RU4bSdmNNJjsB6x+XVk95K
         thI09dcEJz/r4azI/VpAKitVcUAfWaSb0K2zkZQfsPk7MUQw1SnDmETb8ZRkvFXOJeLq
         gEIcNbDRSpD7RzB9YV0/lRZsa2Nx0I9HF4D72tLX+SLmo9Q7Rbnk1bPt6fP9s6efBFKU
         GmnqJRZ3QMJHlnfdmU/lrNUcor8iU6DUMXXX7yhNr4IYup9EU4NRkeH2Up8b0a/6iWcp
         jygw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774576144; x=1775180944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yR2LiYw2cW2pMfYnUY2YLw2WetpDSJfe3rA8gRX4B8=;
        b=hMG2Is5WcFZxtEbjifeRdSM1q6Fvn26oHTG61qTvcjRNsTyR+WYmvnUBfszvULXVLD
         BT2vOMHcDfZeQju0tfK++wS5USATmuWDaWG49HpElXQWVBRCUqC9IGjWaruqm3JfaUmz
         /iIX5oeKzw2qw9AZciRvJaej521g9DYT9H16rlgmEhHEgUbxBp2bD20yKtobSlrNVYZM
         t5mMiOTbY6DABvliVbn6qE+AmRj2nSH8yHkqaxjZNWRgtBfE570yjfI636+cTcnvkSsw
         T3NVjcvQtZKJM1A0XbRMdFiJIXsNo3Ya7xO+pHQFOmoYCLsK6Db3ZBWMghJILc34A/Ca
         X7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774576144; x=1775180944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5yR2LiYw2cW2pMfYnUY2YLw2WetpDSJfe3rA8gRX4B8=;
        b=LB3K92xp06ApkkAKaWrpk4bJj1VrH3IdzKM0kzWgNT+kaPG3O9qKDfBllowufCrHEL
         ZvRc3jj8pr5xdjRBLyu+k2mNhuWaU9a9FHFBfNbfrA02vqzvanIbYm6DPznzqJSYhSdm
         PrAg37X4NARkI4nZemdJIhvXFGNH9tARqMh+WI6EykM8iu4mrammAuESaSgAubGW7W3l
         UstOYCW8+e5nxp0eVGxC1GX04v1xh/TRjQL/yS52Mik57UA9gLrn1rNPZBBBscty1x6N
         ALGZRny+HNN1AKKHnj/AEaz0/XrH01wamJCqSiPKF5BN1wR8v1CrCL2r4hzbfcFNJqK8
         sBaw==
X-Forwarded-Encrypted: i=1; AJvYcCXNVwjzuK0VZbBs4gsz4PTG+9o4nNA4GRjygwYrbDrDDQMQs+uhty1/DNbH4m4WqgfrhS1dmRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vUS4zA4/5C53xWHEj7LfjDsNlGROfHvbR/5G9RISt8jyKErO
	lLeaANua2SbWGdVUe/FyMDnXHcPdBjb+3eDZ4ZhZaZ1Lsr8FZhf0aWzN/RzYXfvqlW/yel3E9f0
	Fq8ZnbedQ3eJxkxSeva2K9os8jaHujDs=
X-Gm-Gg: ATEYQzyq0xD7WQH+5pcV57X9a6dM/gf8OxD4yxa/loa0MhXeTqAHw4FVCS8hxm/CSLn
	jtOqaxFYEYMwthtEAUd2KTwYT22x9Q5LutPKJwbiZZjIxbKy7MWsx1pfVZBAOK4YmrB0KDjF15p
	XIchThR6QOsuZcKoOfH6e2NPcZkdaWcxQwiXS+kfN5Jhya4sw8lDX7DCcUaPoI87rsbyIkKRNzf
	lZJhHklgeo8Tj1dCGx5XuqTdJm9j4OTAupYzC0YawhzpvtbOnA9ho5iw9yjIO7MwDvOMh04/VTT
	umFDSJGlveiB093YRRV+Hn5UPTE=
X-Received: by 2002:a05:690c:600f:b0:79b:deb2:f5ed with SMTP id
 00721157ae682-79bdeb2ffdcmr4128527b3.23.1774576144482; Thu, 26 Mar 2026
 18:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
 <CADvbK_fj_26MLP=+U+rzOMfqdPpdvFQJgN_fozd2uAjRsfHweQ@mail.gmail.com> <CADvbK_f3LwEt+-BG-1Pcr4jMn6Jxry+0p-Fu_s0C6Px+F_NHCA@mail.gmail.com>
In-Reply-To: <CADvbK_f3LwEt+-BG-1Pcr4jMn6Jxry+0p-Fu_s0C6Px+F_NHCA@mail.gmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 27 Mar 2026 09:48:53 +0800
X-Gm-Features: AQROBzCQfDHh_EmbwR6jDFT6sXXahubBUzk-qQWsQ0Bkg-lt35ZOjSZ4Ou0pZxo
Message-ID: <CALW65javKc9H1zQ4m5cb0qPfXix+bWM9LcVZ+uQN5BdgdTQ=gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Xin Long <lucien.xin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Richard Gobert <richardbgobert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272323-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B828633DF21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 26, 2026 at 10:44=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 10:43=E2=80=AFAM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > On Wed, Mar 25, 2026 at 10:43=E2=80=AFPM Qingfang Deng <dqfext@gmail.co=
m> wrote:
> > >
> > > Hi all,
> > >
> > > In some cases (such as BIG TCP) a GRO skb length can overflow a u16,
> > > then what should I do with the u16 length field here?
> >
> > I think you can either add a check in pppoe_gro_complete() to ensure
> sorry, I meant add a check in pppoe_gro_receive().
> > the aggregated size does not exceed U16_MAX, avoiding BIG TCP
> > behavior; Or, set phdr->length to 0 and rely on skb->len to determine
> > the actual length, as done in BIG TCP itself.

In my v6 patch, I set phdr->length to 0xFFFF. Is that okay?

https://lore.kernel.org/netdev/20260326081127.61229-1-dqfext@gmail.com/

