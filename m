Return-Path: <netdev+bounces-274199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGjhKMhSzWmnbwYAu9opvQ
	(envelope-from <netdev+bounces-274199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF237E7F9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CBB3187F9C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263783D9024;
	Wed,  1 Apr 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvQBlLs+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7647B420
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062865; cv=pass; b=hxrb3qRNbGcfzR5OmP1eLggwt1TcIG7Av8hxOqD4T+bsgD7+iHYK/SIfaS+5Qz5IvnWIXjrY5FLkocqyoL0CrgC4DsvRQsw5rRSbL1KwO7unLrg7z+caUMdBHkkgciTFmDFSEZlCM4sdue609VUsnEoYpYIQmwMjXs339Bt2jzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062865; c=relaxed/simple;
	bh=HMh3BmfgmzdgimyYYoM6Rn1fwSBCsNHDQSYfQwRc9+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSLPY/4i420mjYtG5ubgXwajQe+54vSkBGdj7vNjIJdJx3vUZKgcbF1LtfwTEoqJB9vezaNj9C7EbOsDhLoyFnvHAwhhzagpj4oVYwCztVkvc7Ay2eMEDDQv6SU3Mhq8onfZPK7qOQ8j4hgaYOx6DnAE51So1UgJtANuBlinIes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvQBlLs+; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so347a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 10:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775062862; cv=none;
        d=google.com; s=arc-20240605;
        b=bwgxavqvlfiLAPHRVBtBx6HS1nzcezsLt8GAZsvsfwruqrLW0f5UBWvh8ZBqPHn3hs
         X7W7ZL05mu0WXUSq25rhdJVEGuIe9yNxk7SRvhYbabrOr9b1z2xpIiemFSU2W0/gtB2e
         gdpNKjk1o0nEIx9O5WCbUGhA0zwrHK0PDdfvA7X/ClOFRbVLCQPQJZqpvZtNbqk8KfWb
         +wCAVVb5U44KeGxDKRXymlC48YS/uZtJl8a3owqifwSCUjS6X6I9Ik/cInKU6o09BKn0
         LoNsSBkWuB0xFLOEpwDBbgFZ/yTxfzDa5umQx9yIQF5/hvxCgFDXdgiRa2PXfdIPB6oh
         GRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HMh3BmfgmzdgimyYYoM6Rn1fwSBCsNHDQSYfQwRc9+E=;
        fh=Ujlt6GZ6TVhsa2w976z2IgVE96ShhsXsvDnMfhbUvqU=;
        b=LgL7+VzV2lI4wbIF6vNNEGlAw4y5zdHZxTPptTZxzo9ZBZLhkg9hCaBRbnGg6d1fya
         4GsnH5ce0/Thc0mTqEiye9/W1SHTOrdz0XxhmLnAZ6hlDaTg741wKKyZERA/F39NJeqE
         lPBo6icKDN3asBK6jb3THJZrmroVS2khz3q2Aem7QMwlh7Al7uaLaHlDjPwhmgapYIaM
         imEzFeGO7NYE2rW03+1SmDtBCwhcz7lVMBOUWMtAROMOIjrCHbCW7yoUSds+I0sbfaZ4
         X077edcWggZP0EpKHScwNj45dqQMytT+l/LUqh1YQbjjIGKQ1snG0mr77IWvDfIu/5o0
         EyEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775062862; x=1775667662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMh3BmfgmzdgimyYYoM6Rn1fwSBCsNHDQSYfQwRc9+E=;
        b=dvQBlLs+a1mlA59kQDDucXKd+evLi5uR8v4xBe8WJq5qqx4RWVaooOo8k8aXcsdAG3
         AO+2DMisWBw3GMYfVttTj+g/8McDxDEPxRuF/Jn+CQzHi4BxW5/YgVWKKBEIKhVx+Ays
         4L7HDUptNlUzZKOQG82sLxYB5Q7Nqk9APNG69mhUqmWONdphMBSkJwSadgq1wS3SVkbo
         UDamTJvFLnYBZxCE4/nm3tLTPhNypdVgtECr39Kz8y0Wy8pTWEP+3uMJMLcUJJnfH3F/
         GJ/USZAiY1Mg7oRme75r6nkSrqdMxgbz983QnSVPIRsXtNYYnRe622je61whaDF5qe4M
         /XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775062862; x=1775667662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMh3BmfgmzdgimyYYoM6Rn1fwSBCsNHDQSYfQwRc9+E=;
        b=Qs68XgMoFLM8kAhUsdRfBtGHjlOfaOoVJStsmRicEt/R8v6Yuo8NlVpyIu5jOhNjBA
         8tbEuEszFCh8fjjkW0UrbPt2LptdLKdXO9LqJCNOhU1rK+QIDbc1l1OGZT9HytwNGqv7
         NaDzrTRydGSes8XgCTZ0To/u7fG0z9rbQ9sWBnuVq/BCbMyhaKNRmnUC4QWuaZPcF3Fu
         2KO9FUVU0GelYfrt3ZGBtcBPlik2Q/SWPyxZ4UC6Qh6N41+MixgFdO8xsJIC/QeemTBt
         lJP5GVaJkOp3CuP2OgLjX6eI8AFmmttr6qSeNG5y62pjfLkPnpH7EqJ9hd4sYgjCfPGO
         Yi6w==
X-Forwarded-Encrypted: i=1; AJvYcCXigY4ZyAz4OoelSbDgma0y2g2UhIaM32xC2GeLqZb+fNQbxJFWcKD0MXqT+KodumwFlqFrK8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBjgnV04kqgPi3KXz0C4SLFQKzNwvo7BARS8tGsYR0VCc2AUL
	Y816UXfTuWdyjszElHfNFnbV6q8SdTol/YJVIivv34ofUc2kMpUsOEe0A/F1qMU1fS843blgFAO
	8Mym83eFl7AaLQZyyYZPDpvszhqV6yN25h1D1+WWx
X-Gm-Gg: ATEYQzy+nSKURjhJnGScyjpKsh7ImtJmUOaiuZOJfjCO4ll1WZWf27WOvgIf/HbfUbJ
	2hII4rKCFrct7GD+IWENKx4Ne23WMpHZMNsjd3qBQD5ZD/yzbj9n8xtFYBjvIId5hNIwisPH736
	d3w/0EFrC8B3xSk5daHdad/S+s73gKoEFkE9uvE+0kCfrHgSW1Fu09CZXu68HBr7ac9CvLR1VQd
	p4cU+TMW+S0LBRLg4wj8Vlm61KPpT2HKxta1RZmzknXMy8L7MnlNI9vNd+Y0I1Dw7uv2VZ7+M0g
	Mt87Bo5XgjIqJu/gufHIf58fe09n5TyPTRp1vaEjJ/JmNfgPcTuhfYxCOtmucXqpaahjlA==
X-Received: by 2002:aa7:c58b:0:b0:66b:eb42:be7 with SMTP id
 4fb4d7f45d1cf-66e033bcbe5mr2565a12.13.1775062861460; Wed, 01 Apr 2026
 10:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com> <20260401075720.7976a1da@kernel.org>
In-Reply-To: <20260401075720.7976a1da@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 1 Apr 2026 10:00:50 -0700
X-Gm-Features: AQROBzBsblDbpWXSnvlD0rrlndtlTFYB_FDROw_4NMEeJP_41nBpXwToL4b7S54
Message-ID: <CANkEMg=sCEMGdyL5qOU-nSGCk2Tartiqvk1yQkg+3PMm46VdaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] Decouple receive and transmit enablement
 in team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274199-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00AF237E7F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 7:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 01 Apr 2026 06:05:24 +0000 Marc Harvey wrote:
> > Allow independent control over receive and transmit enablement states
> > for aggregated ports in the team driver.
> >
> > The motivation is that IEE 802.3ad LACP "independent control" can't
> > be implemented for the team driver currently. This was added to the
> > bonding driver in commit 240fd405528b ("bonding: Add independent
> > control state machine").
> >
> > This series also has a few patches that add tests to show that the old
> > coupled enablement still works and that the new decoupled enablement
> > works as intended (4, 5, and 7).
> >
> > There are three patches with small fixes as well, with the goal of
> > making the final decouplement patch clearer (1, 2, and 3).
>
> Closer but the activebackup test times out (45sec is the default ksft
> timeout, I think). How long does it take when you run it?

Very strange, for me the script finishes in seconds (even with the
netdev CI recreation steps). It seems like the teardown, specifically
the graceful killing the teamd daemon, is timing out in your
environment. I don't think we need a graceful teardown, so I can just
replace this with pkill in v3.

