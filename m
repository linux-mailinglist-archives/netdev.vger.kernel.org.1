Return-Path: <netdev+bounces-252533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIfaIwSNcmlJmAAAu9opvQ
	(envelope-from <netdev+bounces-252533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:48:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA056D8AB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18628301BCFF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D83933F7;
	Thu, 22 Jan 2026 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn53nCet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F93A3CC8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114862; cv=none; b=OplTywcLXtRrOs2zYKqI8kR1ROOPEgwMiMz/muTLRP7Z4vKhGbWmGKzjyVmSp/j0CDkmr62pZVIep4esGl7N+ZizTXK7Hwtoue/wGE1VXGUztYshPJIGVV9GNQ6FWRYeu/eJCwmLOpXpdlDkD1s7EdVoSjrXnLaxXh5+fGwOl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114862; c=relaxed/simple;
	bh=6ydNNGaBTVLwP3JEYSbtuzK13+5qu8DIEj1lwTsVX5A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k/aq0YeCwbRswlYkkgMB89+LoNcuS5NVS4ZmLJdpzAef1o8aGAVSl/4NByvZddleNKhRQkaWpoqF5xWtbsbg/Lr6N/OVHr18F+uqVwY/6TRniS4TFyuP/gYw3jUWe/10nJ3xFCaXSptaw4knJlCGjcPM3tOAPzh+v95KmFB9hEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn53nCet; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359228b7c6so969806f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769114855; x=1769719655; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ydNNGaBTVLwP3JEYSbtuzK13+5qu8DIEj1lwTsVX5A=;
        b=dn53nCetjrLM2lY51zbeFXrK7AYBL9VTxQ1qsBMbWFuMhpZm5BrmMCAzczpdCzC5p8
         U5jC4NqG+8YLvLxTAQMwLZR9MnP2IrSfA8eimGaPZpiKqo37XZINL6cSjRQ3/OUFpRKc
         7o04NHfrIpeXCtpZf7L07gRS/2nMNZyVcqbTr2eTZEVGzaIBuRsv7LCL6Oyo1JNHHKhT
         6SzKle+/W0jcREFV8pyrOZjbncTqBRmFLWCmgDs9CzpMju9VVRGOgyak0qCFg0RNYwKS
         z0Ema2goggX8zJKRXaV0vi0H6egQSsD7A8cb7gWDnYUsf6fS4iO3VFPUI/3MO6+7uIx4
         7Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769114855; x=1769719655;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ydNNGaBTVLwP3JEYSbtuzK13+5qu8DIEj1lwTsVX5A=;
        b=MQyNXji3bTI2boD7E4d7UpunRmAGycngz/jmwwSd7CWqmKFqP9hunJqeHa5e3POw5i
         L9AfKy4IM/sCHBRJErfa2OoNSd9y2EfPSbuMKhDJVF9fufZoNXLgKGv+VhBKNhYjKAPy
         2OM2yBx4OBS61TgFJr+QptVDN3RCCq1nMnqa7CAUYqHgDr08X64xTf4UJC1QdX0k6Cxx
         tNlM8KXj7ny8W7GPSQiCJqriSnKuJqyPN+WFgFD0Ho/58H7cOTK5I2Ft6BSAmMEF10mS
         eVfIXgXHiJSatScfsm4VyUYgJizk02kDIYn+6qI/U/iBU3NkI/P5aDW4Cn1JtWxlKHtX
         o01w==
X-Forwarded-Encrypted: i=1; AJvYcCUQyhYCfUZmBy3IK468fJCT/i3ohqBIoRbipzIGO3B1Hj0gGniOqVzQHnYizBKZvKga7AbTut4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nawhtWkG9Y4XcdzSs+3qOxhOP+ccCwn1DPJFjG1NwZObm6Mo
	kGT0SPGvQEtbefcmRd1NRQPC4s26JKT/afW/+ZpB9NdP1q5Sb1QNBsHR
X-Gm-Gg: AZuq6aKWO8IvdLzPWQYo47jmIQCMTTRMMaXqU7sJdXE1Znyn83gbKURpyGVKCgUdSdO
	6loXS05IquW+vide/6z0eAKFlO1w7/fZFOF97WRWdLtf7LYwv49uKFNxEmPz4PfWrMEjN27tr7E
	pCfwo/jYiSDIw5Gsm3BHUriHtOdmIMBviPnfobQ4oewGpTlDCuk+ewlkJQvDM164JDbOV8MmwuJ
	EsE2RnpgJLWdlbDWSQezBjCKUzbvpNG1qYrOa/JKYn9Uhjc1C8RkUE1XqcdY1Ccvc9489oe4gj2
	TEuJVGAU6h/yJ2tO8wpfn8p9/7TENAK7KFKOds9rDu6KLcHy5u3vpDD/HUOPaU4n74rIxwIwTx2
	azCzQyRSWNghtervgmO+EBK269S7uTm+ugjHkrhmWGQkkLw5H9UJ9LgKl5jFSnqdXMwl+8AY1VL
	p+pROjZCznpWLa0WPV8d9a1yoV6cQF+vt+pARDQ7AYeoU=
X-Received: by 2002:a05:6000:608:b0:431:a50:6ead with SMTP id ffacd0b85a97d-435b15997a1mr1476659f8f.20.1769114855046;
        Thu, 22 Jan 2026 12:47:35 -0800 (PST)
Received: from smtpclient.apple ([2001:912:1ac0:1e00:985e:f575:8301:f2e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bf8sm1235793f8f.11.2026.01.22.12.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 12:47:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 3/4] dt-bindings: net: realtek,rtl82xx: add a property
 to set MDI polarity
From: Damien Dejean <dam.dejean@gmail.com>
In-Reply-To: <20260122165102.GA2564919-robh@kernel.org>
Date: Thu, 22 Jan 2026 21:47:23 +0100
Cc: andrew@lunn.ch,
 krzk+dt@kernel.org,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 edumazet@google.com,
 davem@davemloft.net,
 kuba@kernel.org,
 pabeni@redhat.com,
 hkallweit1@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <916AA508-4097-42DF-8087-4C82ABB87D76@gmail.com>
References: <20260121151506.813783-1-dam.dejean@gmail.com>
 <20260121151506.813783-3-dam.dejean@gmail.com>
 <20260122165102.GA2564919-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-252533-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DA056D8AB
X-Rspamd-Action: no action


> Le 22 janv. 2026 =C3=A0 17:51, Rob Herring <robh@kernel.org> a =C3=A9cri=
t :
>=20
> However, are these properties something that should be common?

If by common you mean =C2=AB not Realtek specific =C2=BB I have no idea =
if this kind of mapping is possible on other chips. Marvell Aquantia =
phys have an =C2=AB order =C2=BB (marvell,mdi-cfg-order) property like =
the one I introduced in the patch before this one (thanks Andrew), but =
that=E2=80=99s all I know.



