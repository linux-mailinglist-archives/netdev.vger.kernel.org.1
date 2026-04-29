Return-Path: <netdev+bounces-282230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDM/L89/8WlYhQEAu9opvQ
	(envelope-from <netdev+bounces-282230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:49:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684E48EC9E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1463044B84
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB93112BC;
	Wed, 29 Apr 2026 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="BBI1JU8O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A129BDAA
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434573; cv=pass; b=nu1P0In2F+fUf5KQxjH3r0RNosl1byLBWoAq1u+ZcDQl58UB3jXqawTUGPZKuO+QO/2/q1G1zh7kUWM3BZ78wj6+MXBRy7N9QwXxJDgQ2cS8GYpxdWc3gtTjUHphVw3/zU+3B6Ac1ZdjRmC7239xQJE1fiZ439mmPEIBqKp8k80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434573; c=relaxed/simple;
	bh=EqBNC2MSK4VwxObvb6iFCvTEIai6wWSpY/G3xu8ebB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odtqSfQCWTo9g0E5bNrzbdU4IPn9colovO0BWG00Oy+dw2azA0oEgvouNrTmSEvBy9hQxQ3vKudYFh3FcXudhpXOlTEIlqg7rzw42BgoLJTJ9nVmT3UpsdpwlnSnInr6mbvJ65YPXtq9Iz4Jisf1dNATDv74hInsoz+R/AoSoTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=BBI1JU8O; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E91743F7DD
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1777434569;
	bh=OieD6dy4kgRnLfBJqkyKmCw15BeoKWXt1QJY2qpfM9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BBI1JU8ORGYZts91Ul630iEY3cPWX2I3uLWKGX2ohmkz/eSJx2h8AKXfbTqcvTOaQ
	 Ie2t+2ULmTQBxnfaOkwRPwXBSXNNPvpRCctR8I/IhxwMYMWsD2Dbkf1SSy5jSqT1AF
	 ZHzDVmWgP3nxzd3A3qSDLQ8VEqS+GeFoos1VrOVqaOUtmsx16Imr9TvvFXqt8d2H9d
	 wEvrjGhTxfvyRt9t1wvOZpQpPX2BTT4ftjCpF26++vaKgS5+isZGApfmmUqAQ6Vt6n
	 XwHx9sNtoCgfUGzlYCcSJTBp3j/bVmEQWmjzUSJgLlmv2px0oUnv+KXyPj5ysFDeek
	 sRE8NhcEgV0qKhykQ57iFv/h1uUQ/HgM6ubQ2+Sgd4rQxxqttfdc5LFOCEPsrwYygd
	 JoeUnF6Hi/rhDVrCein8JU25oRfAeU6/oodjGBmZ0cqRzPlzmgflkcFQJhrYPHy4L9
	 bK9UQJHJIQglltdy1OyxrRvwbkcbEAWHCvczwCq/Obhu/P+AfX8hHV8s7opW008pPd
	 SXAP7PEiaCdmiL2cQPXTUJVac3beWmFfLBANLc21cVDOxJBHd2eeeyr3L+yA4AjsxW
	 FOTLAXmLgpIKSGZzNHb4xv5b63zfNNU6PCZMHpsBOQVMyWxSlmZcEZGFIb+27wiJhA
	 zg7iIbhBruGsTkKmBtbHNNIo=
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bda35eab74so536822eec.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777434568; cv=none;
        d=google.com; s=arc-20240605;
        b=Pde0DNf5MZJpdHy1BFjWZIJMWJlaQ4n8sB6Bj3f2mpB2mjkQeS57u8ACPrQ80eUq7f
         ywtZasi34+G5/D4438dKhDD9++OQNWGSqFv7+JYNc9spt9xcCZLgXgbc73H07k/RZtkt
         pIcbCkjV7bedsZEp69kJ+sKBvjgqjytaMiAdg7cNUK+tnXzeobiPmqg18V3P4U1zjQ+r
         7lz/vsSjB7zz5r8kqnF6IjB6DbKZJYD7fTrTc0IXeD/iKdx6QayzWSHCrc7PpUdDPE6s
         ecDPcs+lvARoQl2ktYlb5fy7RqzJ42jULvQKJPG0ob6+url0WVPXFnsquSH6UNhZ0B3e
         8Law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=OieD6dy4kgRnLfBJqkyKmCw15BeoKWXt1QJY2qpfM9o=;
        fh=NQuuU9lwP0K2LMXazWSb+3U/PVFZtBWpgZLcm3Z7Oz0=;
        b=Ey9M+0l72wg7vGaDWummB0+mRNtS88FL3DG6xOcdPmtKr0c2gwhCzBpN8BcHnPxdN5
         CvYcCbiniyUZ1Z1Le7Et+aSa3DEou0Ar+wqkFIGp3IPng9Yus//4qWBU4HxGmMsjRX23
         49Uay1HruIrMLKG3k3gIelLYgTvaelorhSt4Joa3MVYvix5vRbJ+Udzs10hkGQCykCrL
         TBjRk5nc3LB+V06wmtuIDE+aFwP3+oQtR5fw+hdmQ2FtE9w+xqjF065RXKzSIQ8lSj4d
         ForadMlAleJtLp2eAZR+Gdvu+1bMSI1P5zK1LKJZbFne+ygmxAkr3G1jHfN91s6Il/WA
         kRrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777434568; x=1778039368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OieD6dy4kgRnLfBJqkyKmCw15BeoKWXt1QJY2qpfM9o=;
        b=jo5fhnfd3fUphec3OJSbmXVXzDHoTWQpujZmzkhopsnMKdp2VYICn81mh72jQDdZ+n
         Vn6nVXsoLNZH64J3aJXWceKaW+O2r5taXjn+AwfNZJNYeSTJZyV+B9QnMjlqfwcDoMR7
         CmOzrX132RcF8twwreePRR76LUQ+uqLBxdsnUPYViCFWlyUIV4HAYJiiNyRqMvt1Zhj3
         b9YZFWMwW33Yb+rzhXUYt4qFZnPoXI3pQOBjB5IJq9uzYzOw4Ijs2IPeM+SjZqNMCAQP
         xmXHPxCFg3nVz28M59rXJDEFnsoMmyVDbwPDyFVLpRwhIM/6wTx4EUqHXX8L2cUkT4uv
         QMzA==
X-Forwarded-Encrypted: i=1; AFNElJ/27r2wvNtBOK0Xr2xZbkzIUxICV/hisYVw8Wr2934MNncHWk10aC/7Q0euFm0maJeSvC/KPSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwZry+jKk5PQhtCWZB989kyIA/C+2UznN36aceS6gfs2EnEKu
	23RoS2b2U3Drs5oIpKYfT46fYp8y5vlbdb6xXd8WyUR2w/rPVSlOW5rAkIPbmQbiE7t+/vL2Rax
	8go1C/brKjJJIwWqfYe0wpToFVBW4Mvise6D2rEemp19Ink+Hz2Gzen5+thUBby5rKtLIOsxDNw
	wm8rxNMua+Jsbl9Ir3Jq2ZcGls5VhJ/NeiVD5+Q+j3i1GFrCPq
X-Gm-Gg: AeBDiesTj16gxkK7oeoGO+6FlpXmzlcyNYH4/NTC024bZnuv+nOW0ksvsbVk+ng/RF+
	X/XqI9s1zn/HNxKVddz7jXaHdBY6stxC8v6tSPVpSmVL/Ir1i4AA5QWbNFWlprSJ/sok0D+oL4+
	zSEaf6rE07k5ujXAral/iSsCpXF4Y41hQpXv0rQhKq7oc3ERU4hSVPzb+so1pmXKHwT17RXVGX1
	Ddj5gOF3qghMnWCJ78rsd7uTSg7a01vxtYPJiSr8hGl3WohI5RnlGua+n1PrO/1K3FQkMb/
X-Received: by 2002:a05:7022:eca:b0:12d:b1a6:7387 with SMTP id a92af1059eb24-12de2c5cf51mr566293c88.0.1777434568482;
        Tue, 28 Apr 2026 20:49:28 -0700 (PDT)
X-Received: by 2002:a05:7022:eca:b0:12d:b1a6:7387 with SMTP id
 a92af1059eb24-12de2c5cf51mr566272c88.0.1777434568099; Tue, 28 Apr 2026
 20:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
 <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de> <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
 <091fa6fa-0f1d-40b3-9c32-8401306f0e66@molgen.mpg.de> <9fd9877a-99d5-4710-a063-ca9a62d425c5@intel.com>
In-Reply-To: <9fd9877a-99d5-4710-a063-ca9a62d425c5@intel.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Wed, 29 Apr 2026 11:49:13 +0800
X-Gm-Features: AVHnY4InM7OkWN2CPJ-1cMrO41cVOXWpX9YAPstQlqDm7rE2TqD4F005hpwpvK8
Message-ID: <CAJ6xRxVc=q-7cJOVFt4GV=NJ8h2tZ7+EYFG86oM3i_H8PjH89g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in ice_resume()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Akeem G Abodunrin <akeem.g.abodunrin@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Kohei Enju <kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2684E48EC9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 9:08=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
>
> >>>> +     ret =3D ice_wait_for_reset(pf, 10 * HZ);
> >>>
> >>> Why not pass a delay in micro/milliseconds?
> >>
> >> ice_wait_for_reset() takes jiffies =E2=80=94 that's the existing API.
> >
> > It=E2=80=99s recommended to use `msecs_to_jiffies()` to make it HZ inva=
riant.
>
> there is also secs_to_jiffies()

Thank you very much.

V4 is sent.

Aaron

>
> >
> >>>> +     if (ret)
> >>>> +             dev_err(dev, "Wait for reset failed during resume:
> >>>> %d\n", ret);
> >>>
> >>> Mention the delay?
> >>
> >> Good point. I'll include the timeout in the error message in v3.
> >
> > Awesome.
> >
> > [=E2=80=A6]
> >
> >
> > Thanks,
> >
> > Paul
>

