Return-Path: <netdev+bounces-284582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICrECtBa+mknNQMAu9opvQ
	(envelope-from <netdev+bounces-284582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:02:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E64D3CCF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E70D3026C1A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70420364059;
	Tue,  5 May 2026 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi7lkCxC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017B32ED4E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014925; cv=pass; b=ZkcQgT7xmPkjVz5Mkxm0yCBRMPU6zPCxDM9+L2NBrJO0qzx9VnWrDjcUkYWTUjpzGwFarDgxb6qUCJ31GH4r0GtAZD/rfQTGcm68t6EHyWAGLwfXOYqUm4tYgWua5Vb009FPUQRX0yXnkDHTiO6AXrtaGfZ0Jrnjocbw1r9bqK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014925; c=relaxed/simple;
	bh=wCTB6SSJF/R6uIIoKqHA2+zCe8X29I2eUJfBo14HW6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rliVRCgtTj6V7jPitM/vaGrAcuecUiX72UqqE3G/MtArA9wbu4wAIaxiDv5+u17EuLjLqLExoNRAAMk5qI2dhaKl4hqSg0F2yjBwBDS3oGAnhNITuVmuisobCuVZY7juI5f6uyTW69Bj3cgNlwFb5jijLfJJR+Kn/heXZfV1o9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi7lkCxC; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so8927518a12.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 14:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778014922; cv=none;
        d=google.com; s=arc-20240605;
        b=fhtXm6Eq0iarRAqIvwo7xasxmmFJ52SPuiIk/YhQeNoWWGiGIuq/hJap+6yoaLRa1f
         6aL8/Q/wI1LhNGhomVREhcmfW9xT/jh366x4CJZpwolfVqR5dgeiOuQArNyAVKucbU3W
         zxAfwxpvTcX09fpVxHffnWyyZ2jelMtu916U1KxNhhClAkCw80PsQ/yRRQXyzQk+nPpf
         1h62PFgMSfu3RqetuGUnX+TEvyMa7MMB3iZj8kVbwOueGEVkTT4jfOE09Dg2t49sHR2y
         LcE56Afrp/+wlA3OHOrmYSTYjEhpRtq5bHPvoR9VF6h660pyvx55O8m93wgj25Mfhg+9
         Gl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wCTB6SSJF/R6uIIoKqHA2+zCe8X29I2eUJfBo14HW6A=;
        fh=et/wTfYMfaLDA3rkBJ/S6BiYxCgAusGT8TLCNbEj/1E=;
        b=H5Sm1aTyLX6cjVd4Np+10XdwVV0OBMaNF3mib6YTkMw/DxJvHC1XnYnrkBe8r2vS8F
         tif81o6KlD4md5JfDhn4m3QNUmaxiFRNeArgtaA5DPj8BpPjmgpXob0wu8DozewSJdJf
         6wKArnr4eeq2r1zeaf94Up8k9HDSXWPbDEvUx4wod3BY/ljYsZpsvWTDX4oJZsHzjH8O
         F5fEbMt5YaF6IJIT1GRYTgO6w+TA7lC1WCblwfVAj2so1jIwR5scGGn66ddrmM1iLy6S
         0ghhoEqMWYqmMxLbcLkPSzUHHw2bzXxtKYITjg0g+R/rw+M6ClGBG+WjMmjEet0L0uPf
         YlnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778014922; x=1778619722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCTB6SSJF/R6uIIoKqHA2+zCe8X29I2eUJfBo14HW6A=;
        b=fi7lkCxCRlCal3q7U2+Iwjt3OjAK3QK44AI3v719kxhyK3nedNXSIjkWKyGdH+GRp6
         wxQG/JOdxzIJfLSYwXHnIrGL+3CKs7XYlYoG08XbI9GHt9BpCqCt0PzJ5Q62lRknrVhm
         fHr+vNLupR6sBGgqjtmV/IeYsWREI7/3sH7P9Y8aqyottfGjdRW9UjUj7rFPZOt/pW/y
         ntd4RuuSGivu8pT/XGs3KFB7zjHjyu/7qqbQtDWtUqKDR7YZkLGwTcghD6lzVTRWBxtK
         UiS8pq5fePBrEHlq5KuBkSGVHdy6tLA96+olJbOPNVrM/KgMAbWHFibUOiVTygKzm5gg
         n0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014922; x=1778619722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCTB6SSJF/R6uIIoKqHA2+zCe8X29I2eUJfBo14HW6A=;
        b=cAo+N4ue4N9X3PoRa6O92NiUt7mXJDcZHaEICalpk926/QhFah+EgASnNOQBXtcHao
         NzYc3TVmD8VLgbgGALX4OhtgJQx3b+kkQCe6bEqZm2PvdMOuEfLFwPRigrjRGwpPJQF3
         /mOf6ce+ItlME9heB18LhFcG3lO7f7aB0Oad5ZvWbJtkSCyomBYYuFvU6A+LgyLXtbVa
         9XGJi1ALTxStuie+GtzB7vAcIQqMo+m8pS1HISES4BGxUFadcxLlBxlUmZQXbeE9YuAU
         IY+2nvbrfkJZlhZkW2BmvZoFFEfVmOXz+ckypfwQDQmem4DyVzi7EtE1PZS2XpQcdfME
         XYTg==
X-Forwarded-Encrypted: i=1; AFNElJ+Mn8mgINbbCrDRpO8TVFVe/FD0fKXuK+OGYmV5IdBkDN2rSqHBOsUtBSx1xbyxbsgmSu/LJt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RVn56nM1AjSepORVJoSZSjd1jzbq8/db+ZzyEI7gtmRNkxci
	K996q76ohD8iYaILvG3t3wfEUJUR1bPZrlfskhwgP6vkdbY+8qUgZpOfH7RgmU9u57OqrdzsjR8
	3Wk/vLOax6kWjyP0TaEYmKxZtxaVHgU8=
X-Gm-Gg: AeBDievvZSqq31ZKnd5s/qwSdXNxVe9nSyaYsd3u0l0tPVbombcok63X/QlZNPnDdZT
	awhnU9jSks7bAY2AKWlq46s65NxfM5zhKcBYkRAGEmr2nBSQonYFtyHSzKG5+Mghk85vEM98al9
	o/sM+eMvS8EN+QZ/b9O68EejqQsTZF0ABW/55Tfikk4eK6PVTl7tOelL+KZCv2+LXniFFnSnOMp
	z20gDyrcTOYXQ4yW0YGHGUKRwFSFiunvCbpVrwis5+9SRnKWm5QCRDllh6xZ4GMOHV1XcXYkhcB
	bhNrZJaitMsR8zeBsP9gityDrpQafQ==
X-Received: by 2002:a05:6402:518c:b0:66f:93cb:a277 with SMTP id
 4fb4d7f45d1cf-67d642b9559mr102539a12.14.1778014922013; Tue, 05 May 2026
 14:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
 <20260503-realtek_forward-v2-8-d064e220b391@gmail.com> <CAD++jLn3WSuQ0oGfPAX3P-P9qvKfDBO24McrLouhu9sKXM-62w@mail.gmail.com>
In-Reply-To: <CAD++jLn3WSuQ0oGfPAX3P-P9qvKfDBO24McrLouhu9sKXM-62w@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 5 May 2026 18:01:50 -0300
X-Gm-Features: AVHnY4I6NYiBAAa13fX7pwsdEAEncIjq-CeSWJwH78UIVpVxQtq2cCAMUgO_d4A
Message-ID: <CAJq09z7yAozH3ZBVS0+N+BB3pn4MxE3M3aV-U725VJnUM1uV4A@mail.gmail.com>
Subject: Re: [net-next PATCH v2 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 842E64D3CCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,2600:3c0a:e001:db::12fc:5321:server fail,209.85.208.43:server fail];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> Excellent again, thanks.

Thank you, Linus. The code does look nicer. I hope it will ease our
task of making these Realtek switches feature-complete.

Regards,

Luiz

