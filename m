Return-Path: <netdev+bounces-271460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNtWCH+fw2nGsAQAu9opvQ
	(envelope-from <netdev+bounces-271460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:40:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED4321811
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEBD8300F143
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3330F540;
	Wed, 25 Mar 2026 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Q+2yKFiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805B22B8AB
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427763; cv=pass; b=MVmtYySgFjtyXUwd7NpjFFQCdOOpMDHyaC+CfYmQSVG/xre/vE6DMt8SwcMBV2DsGKko/mQ2zRL9sdX9eF+aRPtOi46HurFvyBokTHSU4yCGpastBeUeSDMBVeb7iwgAHdd1Bl0N8P+861DTAaALb1l27rnceaa+DPjTMQZdduo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427763; c=relaxed/simple;
	bh=tBBlSJ+7ZaC/mLD3mxaxo/saZfCy8QMlmv3sWrqd6Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml6HQvJU9LkUZBhbM43Mijf5tLxgR79qd//cq58lCtruj7hZlj94rpqEYICuSES9sA61mslGmF5CwQeW9iCPK1EHwWuC+SzsUTupXgL+qFlFb18g3ZveXr/PSrFpsPU3XOQon5Zl0IuDpczcvbxW68103vAn4IFt+SlzAW7qU/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Q+2yKFiN; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66a87eb232bso499741a12.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 01:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774427760; cv=none;
        d=google.com; s=arc-20240605;
        b=V2+ZWrX7JHBWZk/qq/ZBH90ZhUCBpCORNqT8pCWX1riX9sBc9RarExPZBU/Fy2CHvo
         +XS0JvEuYyV/JC/uE0fX4KoATuAyUynKmB70/iWdMg3MbNMwfSYz03IhT4aqkOqdtRc7
         lDkXsA0JDLV7Z5tD8jANKF/EfaPMEQAYKoEbqCILaYZJ1G2BcuTiECMd9hPyH1Fh78zw
         FztS1YIyj2IfN3sua6Sr1ZxN3q6nak1iww7D4MKyX4TheIuoNSauj35ym6wm13q+jX2h
         r6O4my6OycO5u7olJO4VyFfeAymZ7IPj6AW2QLfb6bTOwlQXz1zb4pSntvPaAl0WcdSV
         OZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBBlSJ+7ZaC/mLD3mxaxo/saZfCy8QMlmv3sWrqd6Dc=;
        fh=aclOqNsRuIydOpQ+I8eu2c9ArqTfSvdHmFrrZ0zMako=;
        b=PW4uC5RSSud4mbReluBymKF0h0hAL4IalyhVu6hE7b3d1cSM49MquvZ9ck/h3F8h/c
         kx6v93F1IVNgdlfnwkgjBfGciB/AWMU1iTnSNsCwia2AcaDtyJRCaJVCPoqjVgfmI5s7
         sNQZ3jdT3cWG7ViuDqOMytsKn80twoFc6/DW8ndoGeW7sYa1gKUtN929vdZyRr8qjQ6Q
         IakGunt6aDKmxGx9ASLVQnohqF8AmWTi1f/Zt3PZvULd0cAT5gSCGuOcPqEkRjiMbc2v
         osbJK/iFzalxlwIbyQfXbx9UL9YDAdSevS/7GCl1DDF2ecaDDu6jdjjIj+9eMpwTLKbI
         CuBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774427760; x=1775032560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBBlSJ+7ZaC/mLD3mxaxo/saZfCy8QMlmv3sWrqd6Dc=;
        b=Q+2yKFiNcCQzx2urLFsaIGyvZLJbhMgo0zpiZGlfuNbv/C9Hu5Y70iZWn6LYRbe2SJ
         9Z7Wi8gOQz2kII5+46W2bCXQb+MVbEwTmN+xVTdyjRxAmibvp8ddNIEsEDmezGkhnZvh
         QFc2dyuadPEW5fHjjXlNyz4qMP6DqUMAelGp37zynBE+kKZl8Rp/8OtNGWO+g/8t6ocg
         3Q14oL2TVA/UATfsnWdyWzhyzzukTMjMPgcXrCfEeQmeRsRQaNNUcSO3s8SwEVOpidvI
         JkEJGhv+3HFRMIpkqUSEyaByEH/nXWcAnBXSotbAZ0Ls2WQ/sITIt3eh4yL+zcs3ZDpQ
         qmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427760; x=1775032560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBBlSJ+7ZaC/mLD3mxaxo/saZfCy8QMlmv3sWrqd6Dc=;
        b=HgnP0ko1TFbk0s79X/7BC6f1xESl5SFMYs7UVOcalcCnDVIiHFkeOEZVRHVkYy1Cnm
         THhXrRaQjvrkTbn4xu9zYbcg+WPDbXYKUPaKYbDQAq+tz/rIMF2a5M1V0jWGYm+T4a5m
         +6DRF5AcvfqBdTPgNrGkMU6Nzr42nF8teP0P9uheMt+zlknRIZzBTQfb1c9UItTQ2NB6
         UuU6uYl8o39JUI8rhAfY7tW6JHE7mkG90pEB0DQPP31+zExr3IGxbwlPcg2tkbtcHEw5
         FiOHZ5X0G72Y2Fvrd/t6XVrycUiEM9j7/TAdUGXbKPQDvGbGVJhXSNu6J+/By61QXJeH
         yZPw==
X-Forwarded-Encrypted: i=1; AJvYcCX82NwLKrAgde1CSM0xoF+GGErv4H87US/6IJQNFg37BngPlKyNa6nrqK6CdkLo3EdwM0abhR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzakXZihgAAJOipRS0gvhDutHKce1FHOoZahdyVhz/fmIVvgn3O
	7AuwvmfitJKpsXgLhY8FJs9OBcFbSHEQUOhdDoieWKbsrYWgSntYy2XexYNCDvdv6fsc/hfL6Ld
	Iw5gpYCD2mjvuxD3oO6IwYjJy1dAFmdnS+SNd+2saxQ==
X-Gm-Gg: ATEYQzwqehHIP5xQjUEggd3XH0qLTlXlxOcwl7OGEejmB6sLMTBgn5cB8lZyqTZQfku
	AENGk+Me/vTxtWCdhp8jrblP6HtPI5UxAwhKs5jZ2tBvDvU3qO80s+XA/on3ABUEIpdHI7cfJJC
	cWNTqrvwXvNUqB5fKbAf4eNGKS2SeV/zLeQTL37JjOv6MRcZDQNNlkPY/xz1qxa5fmD7fpEXZ1L
	oQfvKyl3sD1/9rvDfLP2wqUqLD56LnNXGeOA/btOOwc8wu1tmBq6w/Bk8RPvdYSyM3fhMMxPp6E
	laWEhp6IwGxzlfQqNT2WVHZOpsGWvoM1Y1thdv7XZg==
X-Received: by 2002:a17:907:d1c:b0:b98:6c41:a77f with SMTP id
 a640c23a62f3a-b9a3f1a815dmr151746866b.20.1774427760179; Wed, 25 Mar 2026
 01:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com> <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
In-Reply-To: <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Wed, 25 Mar 2026 08:35:49 +0000
X-Gm-Features: AQROBzB52SuPECPABdoG7TepGvm_n8WRHfLxbBgb0AwQpqK98Xbwr2AQ3y953YM
Message-ID: <CAOY2BqxoohQ4qvEnxtvXpkuW46_+3gqiSWBh1zHpB4b56j8LnQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2 device
To: Stefano Salsano <stefano.salsano@uniroma2.it>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, 
	Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271460-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim]
X-Rspamd-Queue-Id: 94ED4321811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 7:10=E2=80=AFAM Stefano Salsano
<stefano.salsano@uniroma2.it> wrote:
>
> Il 24/03/2026 17:00, Justin Iurman ha scritto:
> > On Sun, Mar 22, 2026 at 12:06=E2=80=AFAM Andrea Mayer <andrea.mayer@uni=
roma2.it> wrote:
> >>
> >> Hi all,
> >>
> >> this RFC series adds support for the SRv6 End.DT2U behavior and
> >> introduces the srl2 Ethernet pseudowire device, together with
> >> corresponding selftests.
> >
> > Hi Andrea,
> >
> > Thanks for the work you (and Stefano) put into this series! As
> > discussed offline, there is interest in such a solution.
>
> Hi Justin,
>
> thx for your interest!
>
> > A general comment: I'm not sure about the name "srl2", as we're
> > talking about SRv6 specifically here.
>
> fair point
>
> > I would personally love to have
> > "l2srv6", although I suspect we may end up with "l2seg6" to remain
> > consistent.
>
> I'd like to keep it as short as possible, our initial idea was seg6l2,
> very close to your last suggestion, then we opted for srl2 losing the
> "6" concept
>
> now it comes to my mind that l2 is somehow redudant in an interface type
> name, as an interface is an l2 concept per se, so my preferred option
> becomes:
>
> sr6
>
> (short and memorable...)
>
> as an alternative seg6 can work but I strongly prefer sr6

Hi Stefano,

Makes sense, both would work for me FWIW. Let's see if others have opinions=
.

Thanks,
Justin

