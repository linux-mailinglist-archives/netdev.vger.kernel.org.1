Return-Path: <netdev+bounces-264485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOkIHAu0qWkZCwEAu9opvQ
	(envelope-from <netdev+bounces-264485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:49:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D621215906
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 313BE302D70F
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D43C196B;
	Thu,  5 Mar 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODfhgG3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0551237997E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729353; cv=none; b=s83Ncma9Nln34WaKShBe1YVlQC0rXn9bRTQrJLUroVKGtngMFaYKajvIQ6JotnajoX1pHgpFxuJQEB5kBxePZzJoJ2D+ZlATdJp3WR19XcVZaXcu6tdHurUVXZ3ML88QkyHF/E7wCsz01mR6jyJeBoZRQ6a2Rt8J5Kt4Rc18Aa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729353; c=relaxed/simple;
	bh=uKwqRnu4V3jqt4YAuD6OuTwtmvaAZ72RMwlhE0a6IQs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BWzGzn01EhsEESJ9TbVTyF4xLKIBtMYzVt7D/mQBQC+5SlnJI38ARwTKAf34TYmRkj7aRC0kbItjVm75CZ9XJUS+HHYVaajrEzaIQh66Wpo8o/gxHTRk4upO76WwjzmEqHltl/l/LVvpJjbqpxkxNMRMPHTN6KCFe7efHoqVxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODfhgG3E; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a0d53f3d1so34039246d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772729351; x=1773334151; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKwqRnu4V3jqt4YAuD6OuTwtmvaAZ72RMwlhE0a6IQs=;
        b=ODfhgG3EgIop6+ULGajpDd4/zaPAovsFLcU5naSbKeBZhbDDkEmWa7o5fI8hLTQoXp
         EV0gYBI6pALB3q/O0L7dgkn3rDnZjH441CbWFVuPyLeeamoe3miomkAZVGtjL8rK26LU
         Uhj+M5lQMfGtxCrLiygl+be6b73lKqmGn8aj0Lkga1O8BswDqrHL/wDbqRowucI3NwbR
         fOmzH6K7CcGGM1DYSaA6l8b18vq66zcrRLB9qaNeRCjFJqaJ+pKgcwIjQREz0QwPvdft
         FKWQ+EHVIGcAeKutjxkkqO0pHbG6MiTj4bGTh1J7OXbMDDR01qC8vX76DOqTYZL9t3RE
         M0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729351; x=1773334151;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKwqRnu4V3jqt4YAuD6OuTwtmvaAZ72RMwlhE0a6IQs=;
        b=C6Vn7L0nmy6qSmGyd1EhuTBeS7LZfnJU2WDXuceailEDP3nCnGnmK6RjvaZ7ua0IZB
         vo3510wOx600CcR35uM+Rq3x1CGQZXfpmtMG3Ga5h5XzpEN+KOlH13jvJx72zckrW+dt
         uuBiuFwavvnRO38qL8qkMjTtOcO7fn3kultZMnMVub0FaPlKNF4b++Tnncj4Mb62xnad
         yKSWas+N6xzQ7tJsEyWUqOdYvPknI8o/nwAThmtNKyIl/M0VCYR88ifnFcwEB8Hz/cOr
         psxJSTprTH0s4dLZzjyWlqMVBx06VhM7E95GcWVVKnPlQDf/EfdLJm58tcL0hjiZ7EdK
         9Hhw==
X-Forwarded-Encrypted: i=1; AJvYcCVys0E2CChImPoqCVKjF2nkHJPcHcwuZdQDjPn93qg/ul+Ci81YWb9+nIs0WiVJz9w4DgjsmOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPiAsoTOqhd1a3VGBadUg31q/HC8elSoRsbGJij5nbjfj21sE
	HMSKTUkyJyAdM8UCVvfYyBh6/meKuwCIRulDzo5uP28O390WIeRPMxlo
X-Gm-Gg: ATEYQzzvZ/hBO4aenSK/Pm8nHwdgXgKbQ4Ck4y7jqIIZtucvZzdDMhafowB8THaqdns
	v9lXcUEqTUFHsf+kVGApo7hus3HcYjEmYsv4hNI3PxWya8pVPqvtyS4l7OtMv3wNVrh3Qc75WMg
	rEjrp/cG6kg+9wMxIKyXzgJbijxNrF35PXo4sEX8mabjcY/VuObM88bPBkcBFy9HMEb9bylCOow
	LyH4ILOWmgbP8bgjBdXIt+t5MnAjEL1XasyZnuVMXWEQPGEO+ZWFawbI0O4LjF782nsdxDT5/Kr
	bBLnUCv6nxXFJjqUC4XV2gdilm3TafHs2BpaRgezmUxpF1+mkRShPL5FHGvkpsq/yezOdoTMOy0
	4v4Puz/n0Pz3P6tn+5jUcflcOLAaSE/yGFxyuOJPSqNvGCpfEdHpgzPfqy7mWrVOCJ4LwSYCrX+
	FQDjWa2LjTfOsmPrhPq/g8E6LRz6aULOqN3XSA1TQib/xYHw39o2WhuQ==
X-Received: by 2002:a05:6214:4017:b0:896:f767:9676 with SMTP id 6a1803df08f44-89a19aee636mr85192056d6.43.1772729350797;
        Thu, 05 Mar 2026 08:49:10 -0800 (PST)
Received: from smtpclient.apple ([104.39.198.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm183287696d6.15.2026.03.05.08.49.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 08:49:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [net,v4] serial: caif: hold tty->link reference in ldisc_open and
 ser_release
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <20260304173956.0081d8ea@kernel.org>
Date: Thu, 5 Mar 2026 11:48:59 -0500
Cc: davem@davemloft.net,
 edumazet@google.com,
 linux-kernel@vger.kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 horms@kernel.org,
 jiayuan.chen@shopee.com,
 jirislaby@kernel.org,
 andrew+netdev@lunn.ch,
 gregkh@linuxfoundation.org,
 shaojijie@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <951CE2C2-6B03-4EA2-B4AE-D78A47EFC75E@gmail.com>
References: <20260301220525.1546355-1-shuangpeng.kernel@gmail.com>
 <20260304012612.2592839-1-kuba@kernel.org>
 <CC580D33-FC23-4271-ADEF-A0DEAE6BE9ED@gmail.com>
 <20260304173956.0081d8ea@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Queue-Id: 0D621215906
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



> On Mar 4, 2026, at 20:39, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Wed, 4 Mar 2026 20:23:20 -0500 Shuangpeng wrote:
>>> Can this dereference NULL? The tty->link field is only set for PTY
>>> (pseudo-terminal) pairs. For regular serial ports and other non-PTY
>>> devices, tty->link is NULL.
>>>=20
>>> The CAIF line discipline can be attached to any TTY device via the
>>> TIOCSETD ioctl. When ser_release() is called to clean up a =
ser_device
>>> that was created for a non-PTY TTY device, tty->link would be NULL.
>>>=20
>>> Should this check for NULL before calling tty_kref_put()?
>>>=20
>>=20
>> tty_kref_get() / tty_kref_put() are NULL-safe, so calling them with
>> tty->link =3D=3D NULL is not a functional issue.
>>=20
>> I can add explicit if (tty->link) guards to improve readability if =
you prefer.
>=20
> Sorry, I should have checked, I'm surprised the AI agent got something
> this basic wrong. Just the Fixes tag, then..

Thanks for confirming. If there are no other concerns, I'll update the =
Fixes=20
tag and send the final version.=

