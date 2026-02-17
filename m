Return-Path: <netdev+bounces-259103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HVaMeablGmrFwIAu9opvQ
	(envelope-from <netdev+bounces-259103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:48:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD8414E678
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C815300E391
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3736D51B;
	Tue, 17 Feb 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="QzQzXVYF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2321D5B0
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346906; cv=pass; b=aC6EpTKSrJWb8nfbePxzT8sr8/4MDYkEosCN4QqFE98eptSOoxTyd09dg4Vxr4p3cN0gnFCbQDKq71oRkoan3Fq0fkofgNvY45iSM6n1miM0AYSsLtggqaLMxIYr3xEftQ/q/QzI+vqbbFF+RqpsraTL7Lnw5Jb4nzb2C82A3nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346906; c=relaxed/simple;
	bh=x8lmkK8Z+Mhh81BsN5M5VArNcC6K8Rk9DEJnryMwc28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQk2/oZ4WFT8TQUxRiikXnlf8tx6QjemnVgxS16zEaMHuiVizECiSk6CHHn9cifmMW9FqJPfqsmeXVgogUYdPIFWBAvVWG8abkpX1lpI+ZondG6ZJF7lDQ6dYiMclSzjD5nvQ36A54UNTgDS4L3MetQh5N1nCbE/6wfIBmeZeiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=QzQzXVYF; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46390d4ac7bso2645594b6e.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346904; cv=none;
        d=google.com; s=arc-20240605;
        b=fTdZJiF5GxVT6injCqdHNzqxpTGq92aENqpF9J+rc9Zhn70p/xkxCscerIQ2wgZr1b
         Cb4rnam2ugm2svY9cVDYi1J0ofqGobF+ctmfxNRiYrXLQ03FVqtIGlXNKizOTcRSMc3q
         FW5BVUlpl+mPZtaGGT090DFfOVugBcCVW18BSD+QekT0lp1XBfX/5sabKgO2m/n6F5ok
         2P7Un/e9bUHefNaqN+ui0EkosLZYh+1PKId67BCVV6Wy+g0ylhCvzZI2mMNip9k6Dl+o
         +HsM8wwt6e8WzQKJQX5rQON7DPFJl6dVTM+one13cq+6MjykiCJ5gbfI7Oivu0Xf8sr7
         sn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x8lmkK8Z+Mhh81BsN5M5VArNcC6K8Rk9DEJnryMwc28=;
        fh=b1OY5y36x/ZQKiJIuFLeBQcT8wq5PAYf2s3XDJcnPGE=;
        b=Z+tORdBuk/hNobPNJj7MhN7uTJFxNsjw+7a+RJsK3awSZ7sBw52QGBJvSL/pMCmm7G
         ZECXTs9YNWeU6NI6nw5WkbgQ9nvizsHcAPJwbwv69SAdGlLf23KxaHd5E9A69NGCSNFE
         pFwZhFBqnts+jE1IuFgQE07d0Zer62pyZpzgpCDIVd8FZr5790RVsYd6Pz5I7XD44Pwe
         wIO6w3R+qwoCsPWbuBzEEsEoWMYCB8G6c3hoYB12knZnH2OLkwxaChz1qMfFq2vnb6NF
         B+Nzru6dDYPgGrUD/w90B1mv8EL0H89nkn9CTgpHZcqKkY/NEHCK+v6D1YBFDWFyh58q
         PMcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1771346904; x=1771951704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8lmkK8Z+Mhh81BsN5M5VArNcC6K8Rk9DEJnryMwc28=;
        b=QzQzXVYF/1OEsitoUdgFjGBzz02recZS7BzmNMBX8E7ngMQfrW6LzWry5t115DoE3M
         MMbnzJ7s5//dq4HmYBULCjaFbCAvQRrdACYf1qfgcW4rrn5VgNIs8psRJ22emce1ZCh3
         wyPiStn57rsqrzmqyrdfXVVjd03HO6+Hlf8wOmnIL06zT6Zia1U21VY7RUNRHpnZfM9e
         yLkhnHHZL8qdri/BZTVD9KsthDfVdUntOSn+jEcKqQkJtvM7azQyLRyOW+1rIAea7odC
         Ng4xWk9aHKA7MYZKMZW7tORLxLTP4yUa839owJ9JSPomqatiwYCeXsQ+ur2KP8rNH64u
         GXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346904; x=1771951704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8lmkK8Z+Mhh81BsN5M5VArNcC6K8Rk9DEJnryMwc28=;
        b=jlWR3IfbsX+FYybljQhgG3khN2c/cIBsTsNWjymwGaZ9Jn7/OwfPbPTMsJ3CbHr/rK
         KFNCcDhZKcvA14Bcm+IIo9CJy5kDkU73iZHLeBN9Jrp0BBdmgW1/mP18dlmOTs2LVbec
         ulti7c7VS673xwE81vO+EZCJVIOHwK680W/nSwhJ31TDBdRh3Pewg6mmZOEd8bOltQ9/
         aFd4bESbMi4G/geuevqzK5U5wSpn+Y7PhOO2p+fuIqLz1Y7+nlWXBzZ7Qmwb5CZpzVb2
         8iO9bhaKAc8KQCFjHQj85WM1xgicvauSz6wP+B4JtJjtS+PSiykOefohuiV2wg12ZTIt
         adIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9FI+wEFyJBAAEEbsKTc/envuFms2bBxlt2dEe4MXszYEYGpauxs+gx79ZqnY33cgdNOEtRno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYoCYiw9ePKfDJwQNMwXyvD58LMwW+hXctnBB4o74/Ai6ffcsT
	Dd9BCPLEyThAxsBkNJBkCuNIJpy/mV+GImercennidLH5Jq4ahgcJd2XIog9UaRi0eL3mnU6iDU
	wZWRbQHXiebog3nC7fcKHR795T7m2dJywE6XbFljzXA==
X-Gm-Gg: AZuq6aKzbKyChqSSfVDGHmrHyWSwQw2JaLhsMQxuOlrXl8I6HAZQU7FGrKNjc274UCz
	VRMTlb9rezpjWZ0sM0AXRpXX6txKd6W0sBsYOSDzxDzwbRmyUHjgm3/XKdWnfA6hnvUnb28GCF2
	eTFkusBmFprCS9Vc84mfTq+rF5D7lOdwwSaa8s1iF0EuAVFZgRPz/+zDRRxttsUkmv8Cx5dfcmO
	GYkQYXdD+trewFbIg8xeVb1/u1379BskngaIQd1Isug38ZfWhx2RA5AXIG7munRfDyzSeOS6I3p
	whTymm8NliGyRrMqVUQFcKlxSa4MJplCLjPI4iHAUHKfXl0787HQ1fURKNGgaj63I97waBmDSw=
	=
X-Received: by 2002:a05:6808:1208:b0:451:4cc3:912f with SMTP id
 5614622812f47-4639eebef6emr7303805b6e.7.1771346904143; Tue, 17 Feb 2026
 08:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu>
 <d697a88f-dd8c-4ec1-ae4d-c97578a98498@lunn.ch> <CAMFT1=bFkHFsh-3U+Ca7Dey1mzPdz0rpQweCLmXFrattwZ_uMw@mail.gmail.com>
 <119e20b9-4ecd-480d-b629-1c57b2088a41@redhat.com> <65665dd2-90ee-4f52-9238-55ef79832967@redhat.com>
In-Reply-To: <65665dd2-90ee-4f52-9238-55ef79832967@redhat.com>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Tue, 17 Feb 2026 11:48:13 -0500
X-Gm-Features: AaiRm500f0v5aRhtJGmxgFt3WT-gB1Yh-Z-L_IP4NgW6HPMHGVpCSq9goY6JB_o
Message-ID: <CAMFT1=ZfO6QkDKbwM6GPL-DS1CcJ0pQEwz2XsCUUt8fJQS6yaw@mail.gmail.com>
Subject: Re: [PATCH] net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259103-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CD8414E678
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 3:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/17/26 9:50 AM, Paolo Abeni wrote:
> > It looks like kaweth_set_rx_mode() is already functionally broken: the
> > real set_rx_mode action is performed by kaweth_async_set_rx_mode, which
> > in turn is not a no-op only at ndo_open() time.
> >
> > So this looks safe to me.
>
> @Ziyi Guo: I'm sorry I'm low on coffee and I did not notice a couple of
> relevant things. This needs a fixes tag. Also please specify the target
> tree ('net' in this case) on re-submit.
>

Hi Paolo and other folks, thank you so much for your time and review,
and sure, I'll revise and send a v2 version patch, with the fixes tag
and target tree.

