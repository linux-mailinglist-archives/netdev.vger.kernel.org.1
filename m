Return-Path: <netdev+bounces-246462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02657CEC801
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 20:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67C243013956
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD530BB8A;
	Wed, 31 Dec 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RnzancJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690A30BB88
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209657; cv=none; b=ZCZchAEQLFokfBwfty+wYn7oPb5lzDGpAaktOTzWMN7PduJ8IEC+3dKKao3l5ER+4L69MBE/B3njZH3kowpJbCqHU8lYL7+2KF1AAfIRTPT5FNjyM4FKRBySNMYPEF0tjHcBHHFj/7aBfeFyVeMaM24iC5pFm/8uXKwjiOreXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209657; c=relaxed/simple;
	bh=+aUnaI04WkQ04WWtPcFlL7L792ZN75uJ3OMCMSYvr1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm5x6l5CNo9ZHT9bauTxRV6S0tvnVviWYVNe0VcbQfP6EXyR02s/UywOVEz1Qk2Iw64Ug4FS6+7KizWq1kWfXoYH6jgvEmjA7kt5GkzyPVQUYRYKkSQ2y5yJBJn+4Hn0JHwrHooS/W7rGy2hAzeiLIiUF6pArAex5PgBQZ8nNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RnzancJu; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso6408782241.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 11:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767209655; x=1767814455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aUnaI04WkQ04WWtPcFlL7L792ZN75uJ3OMCMSYvr1g=;
        b=RnzancJuZGklQ9rdQsCA/eneyaC12Y3WIWosjpY1Kj0AhtG6h2ykEvSADo2QeXhEKf
         oXbWSm/h3qQqvMdLauRH+LjRS6sq4nUoOSY77Gl5+JVFul2FZ6ueOwHq0qiQNTyG/AoL
         UFM05+L6+Tie0dxO2tfSaiJvO/etFrPZWXVa98LAfqLel2C9MAw2EvUOyoDPLUwiYO+F
         J77SzU4G2VHeh6YiU/xHX416RyAyxHVQfGlxZDaY1Z1HjHC1EG9UJhn593n9jpV5GczI
         Yi3iZjgJGR3C2ZdRI8ghhBqHs9i9+1EsaDi+jBHys5ju4av+DK6GgEAoeUxuY+UtLZbs
         8zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767209655; x=1767814455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+aUnaI04WkQ04WWtPcFlL7L792ZN75uJ3OMCMSYvr1g=;
        b=RnlgDKbSCr311mauIXKEiwArxstf5pXnzvChHLTnp1n7MQnWfeX3Oez1DQSYXgW5Yw
         D3kVJaN3r7IlZhB/m27WFvj1CcO/ttm4Z4ETC9Dr6WPenMSAysNeTNj5TbrqkDwzTBMt
         AlrRMrLw3PwKg8ySTvmlhlwZ015VLzTqV5TSpwNnQdiIZgQKTN13ChesB4P7SrgZ1ulM
         2/SdXbPq2xSY4ZoGcqtfXnftHWzWO5vJzfYgBOBraADsxafxTQcTun8yU6xuRdlCOiok
         lV7B3JJsbMsTqBKb/cPyVRgsAX2ukR2d50iJeWJrxRvI0OueW6AfwWXk8KDUYJWGrWVI
         nK3w==
X-Gm-Message-State: AOJu0Yz2GzSiNZ5JCuswEpplhX+WRQ7oNAZjS7uRJnGHt3zivgRl/eKJ
	HnXDgz+XwD+uOBSi5iesLbDkYBGHn4fV6D3UnKA1ou0TD+Ty1oAI461fiiGdB0mf5y9SNNnu/Gx
	3WPJqqT/2ALRDb8uI2sZbu87KlngwXIUp60FUHr3xKg==
X-Gm-Gg: AY/fxX6a9ZTJTPKrN791edFnptCZ+fBtRhqbE9epacc/pMNkmLzZaNuubmWODIb2OJ5
	Z7lxuo5zddZkjqc9WtINYekTHT3WO5ZtXXdywwRyveHp96NrlF+9Xhe64fRndBS7RxmGHmRR110
	FVOjZmShPGgk3XkezUzmu+8hRS+d+G0SceNYlRLEJ7CgINnIrsHLK9KYLuIXzoyvn/ii6f/eRrA
	sNMAxZ0riACIVcxk3sSMek3YsvAyFARs5puUne9eeQhvWWXAOj8t90YBn37W7GUqMECsVdTlI2y
	NdNGag==
X-Google-Smtp-Source: AGHT+IEW1rnpfCIzaUd5TcKz4esJalVslgnhygZY6lm5nH+LqWoLwCbWID4xYaWRjUliIiIdiimUBqnYZumcN2ZJcgA=
X-Received: by 2002:a05:6102:f14:b0:5d5:f6ae:38fa with SMTP id
 ada2fe7eead31-5eb1a8514b0mr11286544137.39.1767209654672; Wed, 31 Dec 2025
 11:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230224137.3600355-1-rjethwani@purestorage.com> <58a92263-47cb-4920-82eb-2400005b0335@lunn.ch>
In-Reply-To: <58a92263-47cb-4920-82eb-2400005b0335@lunn.ch>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Wed, 31 Dec 2025 11:34:04 -0800
X-Gm-Features: AQt7F2othUZ746lUhnQf8D9Oqr7n2pqALIZ5GmXD3PcjeG-4kEAQLR3IgmVx2Wo
Message-ID: <CAKaoeS3rRk8FGv+zb_vYuYoMAPe7gAsgxq_TKG4OcT5QkKOwjA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tls: Add TLS 1.3 hardware offload support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 1:17=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Tested on the following hardware:
> > - Broadcom BCM957608 (Thor 2)
> > - Mellanox ConnectX-6 Dx (Crypto Enabled)
> >
> > Both TX and RX hardware offload verified working with:
> > - TLS 1.3 AES-GCM-128
> > - TLS 1.3 AES-GCM-256
>
> You don't patch any broadcom driver. Does that mean it just works? The
> changes to the core are all that are needed for BCM957608?

The upstream Broadcom bnxt_en driver does not yet support kTLS offload.
Testing was performed using the out-of-tree driver version
bnxt_en-1.10.3-235.1.154.0,
which works without modifications.

