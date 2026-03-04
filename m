Return-Path: <netdev+bounces-263864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LWsNKBRqGnUtAAAu9opvQ
	(envelope-from <netdev+bounces-263864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:37:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA0202E77
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89672306A510
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C933CEB5;
	Wed,  4 Mar 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuHkQCV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676533986F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638136; cv=pass; b=amE7xeTb1haAyQ0Q7tvjb1euhbcvwIh3fPVZkzYpo0hpK5cql0JVYDp+Vxd9eYoZI8s/s31cf/9fZIozaZoVQMNcVOVouQIy0LA/d+BEYcqAYorev+55pUu1Ytqxha2ZYIJj+8nRbj4a/roZyfUO3oNM5RSjf4BznAUDJN4v8IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638136; c=relaxed/simple;
	bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiLlSaAfwokZ+ZxPavnqaWzaOGGamg+z05fNNcGAwfBU7RBIFrc31pTW4xe54JTTezio5cGq3vU4A++H174N/35K1X3e59B0+ON5OiUbbUatPpnrYUD3bJ4WHOaPaEZhwI35DOe3gHm8kJ3+pHwhm5Efb4++io7umHwa7AhqXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuHkQCV/; arc=pass smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1198762066b.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638134; cv=none;
        d=google.com; s=arc-20240605;
        b=Ypwktw7+W0+Jz5tHU2CcagAlfI7rSN8F3dWpqMOOxrSWwoRJwOe238hQXKHRuHgIjf
         iWG87P+IyvJaFB6YP9yIkHdrtfHMQO+0m0nuvVMM4+A4wIKLv93Q8UWSoqjxJ3Q12Adt
         vHmoHJ08qEtV+hjiti3SW+WGiHYw/mQBnvQcElOSc4ZRr+QBMoeKg80nztDKTl03xrNG
         +7UFA0HLiJJ+Ec/g4kG0EWKPbPs/26iDlBzAwki1IHT3N9cosq3nFAxyn07LoRW8V1kK
         U19hUPTnL2Xzu/83B0OtMhBONU/E1UUhle7SfRlSlCwF7GXNjgquB59YHtxGeyygGu4u
         E7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        fh=z8OwCSZ3VaboSLmYHKHeseFyNuY7IrDiCaK7n2jXzts=;
        b=eFloGC21ZCwnnl12ZBjkLFN2ApQBczGx06bcXouQtGOooEgmDj3e2TJio8s2oea13U
         Q9cGbKGZMRbxU4HGpHY+K+on3hqAi4iLLUyX9qwMZcHe4iNrD1Pzpkl7diNqrcPhgs4j
         NyNAefbUoMmRDz6Jws16lw5A6JLjhGraBgnQj0F1akY2CJz17liP4FSLkQ9eN716YEuX
         QPvThkQlih5aw39Pcfbnr+Iweix7g1dzLrml9cZ+ZfEJRnUokVbTtdmvN80e5D7ek51X
         ooEAS0QHVsLDVg2reCFcfoqKR4t38fcU+tmYwfe+ltqRL0+p1LcS624Iz6yvy6lSn0yN
         EClw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638134; x=1773242934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=UuHkQCV/N9gktZmi72dOdADRFYWr8FJD6dEYo9ZxSWD254FAbWMxTMZNFUiRrxNdYC
         hDoP/8pbzZrGvbFdjzWAhfx3yXP47oZsgdQAqZSOS9nQvqERHJNx00yniKqrq9pE4er+
         QXeWKfH0hNwXcgU24K8rhoOaGLBGEz+ckUpjVEEbEyejr/Z7TAg2pRxAOsSVRxU/pzhS
         baHFDyZ51f7kGX9hsQHBwhY0inGmO3CXJIkFCvlcGYLGHUzw54RxpxXwFeRxe1/7phE5
         yvChzMrvtgLeEdjrRP4gR6lPsfc2rHn/Ep+d/58SPB1TeZ4DF4PSeTBLr8u2ZVilicyx
         S89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638134; x=1773242934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=hAaiN2lWDDWvEEzt50GjzkQq+chBFQe4TJOf8Lfnw5jn9Pw0fWrA4i3DCGFzZOF/rK
         kL0Ghn2KB0E9ocx+Afx6nSTeREOjENRbBlZJQ74ZSi2ONyWrTsWoJJ+Wiyne4NmN1JeO
         MwmXW5UeuC7UHm8sm0IKU3XknIZyVx507KwNBcTr7ZJmDRKsvmBKmzf6YTlLYu1q1cqt
         UTcHS6rWKi59cyAuixfZa8saOtOCcfUmYc+QaIDjxcQp8tjLUIVRUeSGXo/x2SIz089W
         MMoB0TljDCrnVREmo4ouqwcoBSGtIDGI4s7s3wxeMOAZCQZZLZC5h0KxbD4VOlLK6yi/
         G9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41mXKEXPfouOHGpvhxgzlJ146CjCIpXq1Lrg/TjPeIjU8Gz0pgMJatKlsH2tQiXVmrNxDoYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyp0HPy1RuEkN2IVciRXDwY1uehGiVNpGWYR4Cceco2EkHzVh/
	CWUBj6i2NKLt/fhVpRKuO3a+DUghAyOayJoeXXnGWoZ//mavEuTQwJpNEdlPH8meAKvdW61RQNb
	JQcK09PuVLRC2y2J7f/Pp/vXDEy80Myg=
X-Gm-Gg: ATEYQzzzmD4Z2o7BJCpICM36ADaazsV6d3HmXcpa8T9xFqmipCI4dwb/PyJ9qLjJ9TZ
	RGaIk+ZDiva+/NRAQQ6vH6tN0Po5lr6caVRAPUiP/KayWe9mT/w/UkSl8p1kfKO351gv4Vxc7qL
	zru+ewj5/HgiUBKhzN8ESrMZRwJDdtni2riZ82C5rm+RAtqTKPiKAqGykB7hMw1K0rI/huOIVux
	jYGHvhxp0zJ2mTWp5l0XzhGQGbXy81ARW6+192C1Dx6aH6Bf20ncYnCEVY8r8hudX3Acu8Wyk6V
	iktXetksZH6WcudkL+774PF+8GAoFhahRiHms8qZ
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id
 a640c23a62f3a-b93f159439fmr173698266b.48.1772638133729; Wed, 04 Mar 2026
 07:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
In-Reply-To: <aaRbWCeu-wNdWGzB@horms.kernel.org>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Wed, 4 Mar 2026 23:28:42 +0800
X-Gm-Features: AaiRm53HxF5F9P5qVnAjApnPFfDhasNN9x-M6tagR-mOrAogX8sxQv-oIasNUdM
Message-ID: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3CFA0202E77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263864-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Hi,
>
> Thanks for your patches.
>
> I would like to understand what testing has been performed on these patch=
es.
>
> With the possible exception of patch 3/4, I feel that unless they
> are motivated as bug fixes, these changes are too complex to accept
> without testing. Although the opinions of the relevant maintainers
> may differ.
>
> And as for 3/4, I lean towards falling into the policy regarding
> clean-ups not being generally accepted unless it is part of other work.

Hi,

Thanks for the feedback. I've verified the series using virtme-ng and
a userspace mock harness (for the 9p tokenizing logic).

Regarding Patch 1: This is primarily a stability fix. I've tested the
error paths by forcing init failures on a non-Xen system; dmesg
confirms the new sentinel-based cleanup (NULL-ing intf/data and
checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
during teardown.

Regarding the "complexity" in Patch 2: The strsep + kstrtouint
approach was chosen for strictness. I've verified it handles cases
like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
latter is now rejected with -EINVAL, whereas simple_strto* would have
silently accepted partial values.

The same applies to Patches 3 and 4. The migration to kstrto* ensures
that sysfs/procfs interfaces now properly validate the entire input
string.

P.S. I used a translation tool for the message above, so please excuse
any awkward wording.

Thanks,

