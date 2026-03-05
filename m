Return-Path: <netdev+bounces-264117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADu2IhvbqGnGxwAAu9opvQ
	(envelope-from <netdev+bounces-264117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:23:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C68209C72
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2DF43032DFD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D34237A4F;
	Thu,  5 Mar 2026 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="genOpp6H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F2224AF0
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673815; cv=none; b=PTQoyhPfsFVh2p6Lw+7TkPfSQtsZMbnwQ2GED5EXD3YoeAKoeRRaCTP6FkYU4TOOnrF1p/5OFxA7OnhCmVsvS40vZxh0DDfbVir2iJ8LLkpMFFKiJLHeTL7OlkRvRr78CIlWHin2RJHerzB9zudKAdczmoB4/tPkpOQ9IVFNe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673815; c=relaxed/simple;
	bh=eAwSSZq1S1cECE8QcOcMkGFl4cUHJ5fde3/Pck+E77w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eaR2URLPec8O5ofNbhCisMBGp9Z2IL94ykCqsnEm6mBlxOTTip7zhqJb//1TLaMyCrqI5HXX3vCf/a0GiszIWvjWxyEEHbIF0i+1qrKXM+piX9hW9BNjU9au7L5N9Br0yuKGPC6sio0nQWDc+GnlIa7/s02mk9Qr+yuv/AFE4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=genOpp6H; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb39f64348so746688985a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 17:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673813; x=1773278613; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVDQr6tFhw7bVZIKcmDc7TpYHkRddX5knAKFPdYV8I4=;
        b=genOpp6HYOixq52VJFtEvcq7oH3ctMlJB1Khu2dlyAlFhT/prXCnldB4gf7NuU2lqa
         QkfUAzSrH+JKolExfhSh9GHwcdLRpm8kCoCXnARnSnimTSEjbom5/fwY+8lhtT5daJyT
         4j/9qWz6HPIJmmeADfcJBykshz8cEjq1FG0biOZEA0Mu6VrUghi2Pao7wmwhRPKuhxNA
         oyXrSE2rMZxlD00MSELF0dl2ugscR8hvkl/lvaW5pNx/rc9Rc0R14x6BB0hKpiDwUhh8
         d93vR3jYDm73r0PBFfRAE3VsYohbR7IF75dqErXjiwD3m3/4njTSuCUtRrmC7lLGLCTH
         1wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673813; x=1773278613;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVDQr6tFhw7bVZIKcmDc7TpYHkRddX5knAKFPdYV8I4=;
        b=iApyRA2mGtjZhdHQTJb8/yrUhxUW3T1CUUF+W5Z8ejHq6cnB3wm/Zw9OEvAunKvhKm
         mPQV8ueEwbqsW+Os7X0JbqauH7U5LXFi2HiLEEqq0QcIYT7yppr31v8h+u6V2j99XxHZ
         BxZoHHj4hSGJWuuw0Cy75ZqM1SwfUjMPV7tlvL9DJtxGiWYC98lWyfEFl+Vtx5WSrKEc
         O3pj4rZF7KLcqIHIxmAUDq/Phtg2DUi2ChRHGTOk/v6c1Wz1W6f69ZDvA+bZST7qWsDX
         +baeEgzXnv2wE7YTFEBUyna8X7eixpUZCIvebNZjE7/gyTmI6t3LyOxLeclkSdhcAw44
         I9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxFrmAUSS0May2bo96evsL0n4kH7jt++21uUX8p0PPU0mT9E6KtR78xAs1LfBYAa86HxyECzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuntxwdwj6vRK5ZirvNywMBJ/QXzFkuJCSx/G4R9I/LKLXFSuo
	BAVSYVGiomxBIvPHt0pP6kTYIMPRoTl1l8/RWHohpMlaKnHm7u2Ggbj7
X-Gm-Gg: ATEYQzylSLu3Y/qkbg3Ypj93rbEgp27W5d3o3It97S2tdTofpqBkEYLEt29xjqNF1kG
	+3sk8HNpSkdEVTiySiKzK7DxHe816BJDNNhgPYmZpS7LbMPyO/Fj2EhdkzYW56kbxbTUqkKj1XR
	V+v6z1Qx0hWtIC3iSjwHoVLPcDjd9vNuuuGqUL5xjPs1olMaHUf6f9TNLJpMAQRt+UoYraXYG31
	sLJeZRACE/Dk1InBFpssLlqfI7c7Dk2YWG2QZktKajczcQu/og/pL3dEGNTDe5rsT9B2MtPcpQ1
	EQMXodGAkH9PlGvvRFDMwg9V9gjgaTTRKyuRhfanys5jb74spPn5Iu90GEPUlFVrfJJGFWy6t2a
	z487R5hx877txN4QvybyLgWAgwFpPIXIqsxca5ajrCsWYQPfFKlgQKMdqJHhPt1cfd3Xg+9xaUj
	53cXWrwu/WGsdZi6wzJnFhCvhYYqHzBm3SO+ks8pMaM5dhpSy7gtl+BHCqipKk0ut3shIQNLDC/
	A==
X-Received: by 2002:a05:620a:4096:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cd5afa5ad6mr506658385a.68.1772673813061;
        Wed, 04 Mar 2026 17:23:33 -0800 (PST)
Received: from smtpclient.apple ([2601:985:4601:5df0:a9a5:c58:6f6a:6267])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf67814bsm2026745585a.17.2026.03.04.17.23.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2026 17:23:32 -0800 (PST)
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
In-Reply-To: <20260304012612.2592839-1-kuba@kernel.org>
Date: Wed, 4 Mar 2026 20:23:20 -0500
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
Message-Id: <CC580D33-FC23-4271-ADEF-A0DEAE6BE9ED@gmail.com>
References: <20260301220525.1546355-1-shuangpeng.kernel@gmail.com>
 <20260304012612.2592839-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Queue-Id: 06C68209C72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264117-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action



> On Mar 3, 2026, at 20:26, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see =
https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> serial: caif: hold tty->link reference in ldisc_open and ser_release
>=20
> This commit addresses a KASAN slab-use-after-free in pty_write_room()
> triggered when caif_serial's TX path calls tty_write_room(). The fix
> holds an extra reference on tty->link throughout the lifetime of the
> caif_serial line discipline.
>=20
> Link: https://lore.kernel.org/all/20260228094741.1e248271@kernel.org/
> Link: =
https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f
>=20
> The Fixes tag points to commit 308e7e4d0a84 ("serial: caif: fix
> use-after-free in caif_serial ldisc_close()"), but the regression was
> actually introduced by commit e31d5a05948e ("caif: tty's are kref
> objects so take a reference"). That commit added tty_kref_get(tty) to
> hold a reference on the tty, but failed to also hold a reference on
> tty->link, which is accessed via tty_write_room() in handle_tx().
>=20
> Commit 308e7e4d0a84 merely exposed this existing regression by =
changing
> the timing.
>=20
> Should the Fixes tag be updated to:
>=20
>    Fixes: e31d5a05948e ("caif: tty's are kref objects so take a =
reference")
>=20

Thanks for confirming the correct Fixes commit. I will update the Fixes
tag in the next revision.

>> diff --git a/drivers/net/caif/caif_serial.c =
b/drivers/net/caif/caif_serial.c
>> index b90890030751..1873d8287bb9 100644
>> --- a/drivers/net/caif/caif_serial.c
>> +++ b/drivers/net/caif/caif_serial.c
>> @@ -297,6 +297,7 @@ static void ser_release(struct work_struct *work)
>> dev_close(ser->dev);
>> unregister_netdevice(ser->dev);
>> debugfs_deinit(ser);
>> + tty_kref_put(tty->link);
>                        ^^^^^^^^^^^^^^^^^^^^
>=20
> Can this dereference NULL? The tty->link field is only set for PTY
> (pseudo-terminal) pairs. For regular serial ports and other non-PTY
> devices, tty->link is NULL.
>=20
> The CAIF line discipline can be attached to any TTY device via the
> TIOCSETD ioctl. When ser_release() is called to clean up a ser_device
> that was created for a non-PTY TTY device, tty->link would be NULL.
>=20
> Should this check for NULL before calling tty_kref_put()?
>=20

tty_kref_get() / tty_kref_put() are NULL-safe, so calling them with
tty->link =3D=3D NULL is not a functional issue.

I can add explicit if (tty->link) guards to improve readability if you =
prefer.=20
Please let me know if you would like me to include those checks.=20
This also applies to the other concerns in the patch where tty->link may
be NULL.


>> tty_kref_put(tty);
>> }
>> rtnl_unlock();
>> @@ -331,6 +332,7 @@ static int ldisc_open(struct tty_struct *tty)
>>=20
>> ser =3D netdev_priv(dev);
>> ser->tty =3D tty_kref_get(tty);
>> + tty_kref_get(tty->link);
>        ^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Can this dereference NULL? When a user attaches the CAIF line =
discipline
> to a non-PTY TTY device via TIOCSETD, ldisc_open() is called with a =
tty
> where tty->link is NULL.
>=20
> While ldisc_open() performs capability checks (CAP_SYS_ADMIN), there =
is
> no code restricting this to PTY devices only.
>=20
> Should this check for NULL before calling tty_kref_get()?
>=20
>> ser->dev =3D dev;
>> debugfs_init(ser, tty);
>> tty->receive_room =3D 4096;
>> @@ -339,6 +341,7 @@ static int ldisc_open(struct tty_struct *tty)
>> rtnl_lock();
>> result =3D register_netdevice(dev);
>> if (result) {
>> + tty_kref_put(tty->link);
>                ^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Can this dereference NULL in the error path? If register_netdevice()
> fails after the CAIF line discipline was attached to a non-PTY TTY
> device, the error path would attempt to release a reference on
> tty->link when it is NULL.
>=20
> Should this check for NULL before calling tty_kref_put()?
>=20
>> tty_kref_put(tty);
>> rtnl_unlock();
>> free_netdev(dev);
>=20
> Simon Horman raised a concern in v2 about a NULL pointer dereference =
in
> update_tty_status(). The v4 patch does not use the spinlock approach
> from v2, and does not address this race condition.
>=20
> After ser_release() sets ser->tty =3D NULL, a concurrent handle_tx() =
that
> already passed the NULL check can reach update_tty_status(ser).
>=20
> Looking at update_tty_status():
>=20
> drivers/net/caif/caif_serial.c:update_tty_status() {
>    inline_decode(ser->common.flowctrl,
>        ser->tty->flow.stopped << 5 |
>        ser->tty->flow.tco_stopped << 3 |
>        ser->tty->ctrl.packet << 2);
> }
>=20
> It dereferences ser->tty directly (ser->tty->flow.stopped,
> ser->tty->flow.tco_stopped, ser->tty->ctrl.packet).
>=20
> Can this cause a NULL pointer dereference?
>=20
> Simon also raised a concern about potential deadlock with spinlock =
usage
> in v2. The v4 patch removes the spinlock approach entirely.
>=20
> handle_tx() is called from caif_xmit(), which is the ndo_start_xmit
> handler. This can run in softirq context (NET_TX softirq). =
ser_release()
> runs in process context (workqueue).
>=20
> How does the current synchronization between handle_tx() and
> ser_release() prevent races?

We keep an extra reference to tty->link for the lifetime of the CAIF
ser_device, until ser_release() unregisters the netdevice. We believe
this can cover all the usages in handle_tx(), but please feel free to =
let
us know if there are uncaught issues by us.



> --=20
> pw-bot: cr


