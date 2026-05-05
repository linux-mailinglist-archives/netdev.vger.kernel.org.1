Return-Path: <netdev+bounces-284499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OXXRCUcW+mkMJQMAu9opvQ
	(envelope-from <netdev+bounces-284499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6F4D0EC1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1720430CD9BF
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D832481FB7;
	Tue,  5 May 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdamdiJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB937A4AF
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997032; cv=pass; b=CAjIAcvDOTLBTG6juj2/dVoIBRCghI7/naF40zXnsD5l7gSGofAzIV8SpE12LchoizsSNqwZMCvUptBiDZQku4qXgOt7b0dHhf9dPHIhVoiPTYGy6A+xmWl3WpDTgYHUpxln071S5u+cNUdVu0H7FSiAY7v66OaaMnvOlmkcJB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997032; c=relaxed/simple;
	bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAzRGbzHgBy6HDcaFcHNGH0dWdNq1OjmgYk+bypeyCd9YNX0GwbNBAo1LGErYedCVq6kE73jINPVUib5zd9dHh+yKv+gTyztnVprc+MsSVFh3v+2PL5xowlmCTzprI+gdpN9IB9SSWAHExERAJr2IUlO/vUINs8Evwg3ZxPU1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdamdiJZ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so7115350c88.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997028; cv=none;
        d=google.com; s=arc-20240605;
        b=j2M6EjrgcI1Rfj9JCwqNWTQ6qGXa5tHxi69I7j4bVqQVo7EyR+6Wc0qdlG7ob6VTgF
         wOCqZKHm7fXd3DFOv0CPGxhASEzUruEccYadHUVFk+6xq5Mz6JPN7sefNtPZNR8tblEd
         fTpvUbJEI8oLonbFpObH4jyobCeCRFJlUd/CLScalK1THBW0W5TaDRbHykBlFzwOIEv5
         HZ8C3OgDFXWdMNuXKLFhNUjgOaB3UcH9e5A9CeOeT5pJzCEaVHgvfWaEQ8dbL75FIOr+
         IkexY3BMx+stmxmNRNsJmwyWKT7hLJI3RtrhfSMbHkuVka/eKe2S4Jyth/ZGSkWgZnvu
         spDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        fh=nGv7pecBDMa3q9flZxpNDSx/HbdN+9oMaQI9LqgRZns=;
        b=WDfGTX3080+Fox9a/CRhzaE9CVEaorYcI8lsFXeaUxn4P2P0LhgRfQkzBrq4sBTmqn
         DiCecto614t8q3l1PXxd6HYwnphc0OLE5KCUbkHdRHhd3sjnsddCxqz4jq0ZI5+Swk9x
         Q33+rvMazIxuX3QDqqgeTHkU+MLprgX4LDp+Pgr6isypggiLCtP9pm227YhDklR3oZR2
         nd5rORLcTKPsuVPjA7I27TCPMWbAehGLX2Dbr9BFNf3bRkiSa9fDNzyu3cyCBk+ralX5
         odwMKQXVbOGAaJsGIIbOb+xFuVQJWJhJr9sSM0Xk2fRqJbdTBvB/hEZC0iX6TQuEhWhk
         BUag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777997028; x=1778601828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        b=tdamdiJZ8AIZ26E9sOTTyk5jU1BM7rY1atHf7juQtp4GtWQo2X7xFMAFFaXqis+usC
         3rOop43vEFOgGCM2lvtCWwGpCZd6r8vAhaPGXwFp3uQUG6mMe/g9x6YqrMXZg5OlxsHA
         tDFr5xlKD89TC/QqpPzhkoloRoC5il7rqtZqjrl2y1cI77mU2u/DViFwzy7cuCXvJHoM
         xeHOlDIGsgSvEdI7UJiVxJvEYA2LvyWAhv9xoRmwBi7Kqq2Jl5FVOzD/TDXFPOsAHrTU
         ZIz2AMStuM2F+GMwYJdzBqwmibTYK1T5ShB1lfsvPz8HFg4B9nOYk3PB+gvyJZED4p/U
         AsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997028; x=1778601828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        b=gUEByVgGNWdtinc8nt9JnFn/yZy/RBCytxIQaK/oNYJZsX76e/TwaCfpfSjyskEgNN
         DSZySElSVWmjfgsu1P1vpUSuhPEehLWaZ0LUobrMQEqBXfDxDFyM93U4lG8NSkZP3fkG
         vo6A26wf+gx0BZ4+f6niCuZDbYmLWZt5IRzyhO7rJLNskVrHu/xi+/3EXVY9tlhf6oTK
         JueS8ITMkjmtsZEA1bfGZT4Mn7p1lx5w3uvF736ZxicJr7FAI2MfyPp1YvIewIwaizic
         q9waIn152UUdwkbRWaJuJb/IlUUkFwjtMBkXlT8Pg7GjXxrQmMM2r3FlN3zuDH1z2rIF
         7uHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8m+c4W5QCWcA0vcpJy7D3q6m4rBtwsi1n1KABZHKH7u6ZBb00FMIqiGImtafaD6hbghF5OV0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7x71sS/hPJaVrIp/eqa+mo5YThqlx1srgWZ6bmIhL6Il/6iA
	eF1CYo2a2QhlDkBbnWKPtdIqOhh6KSfdIJTZttON0XWhumnUBpwnvYgh2b7EGZZBGIERg6LczIg
	ycoTjdCUa7uhgAHmq5D3NtxN8/7TbiF2/A4akFE46
X-Gm-Gg: AeBDieuZfRDX6MULbGKuyVhGxsdjle3bwVVfkx9DbII+ohSBaJqIcH4hQVUVztmYOzp
	31BkMMyCjFKd0OJP3kP1p5PwuRX5AdqO9UtZCS6LxdVi3AjNS1EQiT1Dln89s66NWgEFaUyM/hH
	DAgANtO9JqzAvo69+kAT/xx7wQdEjf42VJjyN5xmXGTaOeW+Yfa+H2qEycnJuIaDblazlwgd+Yh
	A3cl9dwQgc1SFVJ5LAHImh0Gv/h9btgCd7By437CapbmKr37vLMBe4715wuSZs=
X-Received: by 2002:a05:7022:78f:b0:12d:ca32:59f with SMTP id
 a92af1059eb24-12dfd7e5bdbmr7028039c88.11.1777997026608; Tue, 05 May 2026
 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkfP-8UHaoyLd5Y@google.com> <afoQtL6gEN2wUba7@nvidia.com>
In-Reply-To: <afoQtL6gEN2wUba7@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 09:03:19 -0700
X-Gm-Features: AVHnY4LsNmTptv6RYHm1ivIrJui-vL8wanpj85inMj7g24wxtEjU8rbJcAF7qfg
Message-ID: <CALzav=eQcRUNR8FtqDwXsjm+MbMSN-u7GyCj96-NmbDhB17GRQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 91C6F4D0EC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284499-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,mail.gmail.com:mid]

On Tue, May 5, 2026 at 8:46=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 10:35:43PM +0000, David Matlack wrote:
> > On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> >
> > > +/*
> > > + * Driver state =E2=80=94 overlaid on device->driver.region.vaddr.
> > > + *
> > > + * Contains both software-only state and HW-visible DMA buffers. HW =
buffers need
> > > + * strict IOVA alignment.
> > > + */
> > > +struct mlx5st_device {
> >
> > Can we do s/mlx5st/mlx5/ on the series?
>
> No, I don't want to do this. Since it is in tree I want to reserve the
> mlx5_ prefix only for the main driver. The driver is huge, I do not
> want to harm or confuse grep - that team will get mad.

git-grep can be scoped to directories, but ok let's keep mlx5st to
avoid disrupting anyone's workflow.

