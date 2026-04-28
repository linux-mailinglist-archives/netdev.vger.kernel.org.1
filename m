Return-Path: <netdev+bounces-281574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG1HBDgJ8GkINgEAu9opvQ
	(envelope-from <netdev+bounces-281574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:11:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F8A47C522
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490FE303743B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53522A4E9;
	Tue, 28 Apr 2026 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qze7hzzu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1E22173D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338578; cv=pass; b=oa3KMNpwC1dzSowVWqKOxfFMA8uVtXEaqetKTYdXcJyYv4oKLqPdmG9ivD4OAIKlzsPNBBvuW4NsFSE+uXNPHkDRAss/VxFFKBIP6+PC6Z8PS+73/4VhaKs7GbGD1FeYcSWUJ2DOx0gE4EYnwpvmAv8qjr918ABtx1EnS6gTy1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338578; c=relaxed/simple;
	bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIwMEqZg5Uv6QdI7SiR4uidciGTLBxyaPoZFgiTjT8s0d/emhOuusdH+z22tKXwlSjMl1kUR69SVJCtGo7Q9mjrtEs27F+T3UXTJ8D55xEd+7U9FHwoQcPM8tJ6GsSTcG6/tX1UhqHVVy0tNqkFjvyDTEm6HNoykigt/BOEHL2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qze7hzzu; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89fc349b5ceso157327186d6.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777338576; cv=none;
        d=google.com; s=arc-20240605;
        b=VSGh+dQ+PSNhV3MlJ0EjHwIJLnOpNB9D63yXd19KlUKxOJSsYjKLt+1PW0udMlI9l/
         UxS9PpaBAOjS3+370RQca+zfYayApK+GmmQOSuAXG3VsOUWfdETY5k4zJg1/xEZOupDC
         JlVdnbuzSB6OfwZyLHhhcQsXLIGHlR458nPdHp2qevUGHTl5I88AjD/sbHC1Tve36B4W
         ZtHzUh9y4FqWc6QlscPRReMekC+WHEeXxDdJc2u+rO4ZtfQ2gDQYXMRD7m/Osd5Opi5o
         kdKLrUt+UgfyRm4kH2p4iSodU4SSD+thW9bvuBjSAvC7gAHvGrfO8CuTGZIIMw3TOV+h
         U8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        fh=SXtT6v7HMP9h12o7iW3DPQ9VWYm94OzdOeOZ4EywUFw=;
        b=K4VB3DNj4aEKibTXWe9W07H/sBGYP/ddmCBUd1YOqRhNdUQQU5RUiNt2ytjVr6h2E3
         XsyLyviEvee4cAOwdANBrM9AbAqs1nefTs6tUZNkn6Ujlv25jTxPLuHpI1lxbaHk4AF6
         mTDkeII1mV29yKqxJ9txmbb52Idv3NNWXU0UfucvGTMyzgMqgrNsBhnItLTC7vQNMhYb
         F/C5mcQ+pn6BXynMS8qYw9bbZH0Hf3xjRq6nISw0fouQnQUg7LzSxhHQjO+eYz94eWXY
         lNOxWy6FVZnDDUGlJsAJjDGujLTp21f6yLONKyyJsZmTmg0GLHpU0AJpfbejhNGPDNO5
         ehpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338576; x=1777943376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        b=Qze7hzzu3b3wV4C2iBMNQn3N1zJh818nFnk2Mx2e/vip3YQTT9jhSDpHR9CSF/1kbV
         6OJlTcaFn/z438DStQ7/p1It24IOZRjJ3V3R5moZctczwWsxb/QQvyF6+zuP2ZuYQRzr
         Sunx5v0kC363iMwkUMs3RQu9IjE2mZ65wpzavYzzyBWAG7xjp/dAY3xlNpmuaPd42vUe
         e2ewEG9aUpCOw7w1zkxmvRe+kiFvwXVd7+G7ZGJfVRae0hOK/P86Fr35/qTxNrnFAY4B
         NtiNzpkPkIyuT8fzOvXBXVrfecgoA8DksrSX53ILHKKxzbRzoAqo1EsZZiZqG8F3hdoo
         UBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338576; x=1777943376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        b=FSikc0Gr4aX1510WrVyAScFNSNljeQAQM5aLxcL2fc6eXjsYTOLMWIZ+Ja9kDJZE8b
         E5Co7qGKQa/G30Kzd3avSzNqJ+5fngVrcpaxGrfojYMY9v0RD/RykSx4gnBSxAS7rrU3
         0IUNCCFWtgX10JHACp4jvjzj/KYx9CKFkYXuKWwSs4sdbROFLEmK/ID75DE7xWmyNIBD
         +4TmiZqgb0u/TErYIuz0UkIAkdYBaD/pV15RnZR8J+bXau2QLM59h7sTVlYeJfYFoRc8
         YL7xsX8gZG4uTg1g3xmOCr0Tz6q5D00dBgO4r2rKrRoXXURRTBC+1j4GbR96NpH9AZC6
         hRXA==
X-Gm-Message-State: AOJu0YwCphd+zg5YJfoEEvqQyTtgxl4mHB+qGYUOneSx134nPo67XSdf
	26BjpnWHk+tmS6hEgDAkZ/G6ndc4C6sIM1xIwKIIl+FsfEKIW0rNXE16tgrwNyo+jzznMc0w+dH
	EwJr3MXd60e0kb2GoDFl/4Jlg60Qayds=
X-Gm-Gg: AeBDiesTdgRNmvrsYAhvuBfmxXtoNYwqwf3Y/5K/0mkz5uYc00cZQ/e+/302OOxoMsZ
	th9qziuGhcmiq/jJHyoiXGCmfcy1POudLZx1ZhXj3lrcjpsc6L7fK8Yx5j6isRqX8kRpx+tEbkt
	fh6Id3FFn5Mlf3xOlDcQqfvkbiyywgBgLPwrkJI9CeQVEq8D6+fXqk5mlOYFEfRsPVzGvvPr+kb
	TatnF9iAAdkpyvUDuCgkci/aiamyXRKn2AucE/pqPi1dpNwEcJ0YHT2HzD2j4iX4TBi7WBTZNsY
	yd7Z5T+RIGm65XEc0CZRO8U8Gc8RzpVVlw79JMIaqTfDBw5XpvlE4ihVEdv0ZO+bfAPIloMxPy/
	ENe0=
X-Received: by 2002:a05:6214:5b86:b0:8b0:2b9e:9639 with SMTP id
 6a1803df08f44-8b3e305cf7dmr19913666d6.19.1777338576269; Mon, 27 Apr 2026
 18:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425041816.19070-1-enelsonmoore@gmail.com> <20260427165959.3a294f1a@kernel.org>
In-Reply-To: <20260427165959.3a294f1a@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 27 Apr 2026 18:09:24 -0700
X-Gm-Features: AVHnY4IOutGXbWP85VlfW8A-jXZcwYkaD-ufKnvdMGHabQzeiYY6WGgL79Y-ak0
Message-ID: <CADkSEUjrFBLFQEHBaKaGe3SxdT95GFQ8hCbgNaF7ZgVVB6txLg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	MD Danish Anwar <danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 71F8A47C522
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi, Jakub,

On Mon, Apr 27, 2026 at 5:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> We can keep the vendor as is, this doesn't enable any code compilation

I disabled it because otherwise an option for Mucse devices which
cannot be opened appears in menuconfig, which is confusing.

Ethan

