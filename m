Return-Path: <netdev+bounces-179229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B1A7B53C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 02:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931D91895924
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405232E62B5;
	Fri,  4 Apr 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2UqpGTBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C22E62B4
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743726874; cv=none; b=PuscR6Ea3R1D2bkl9vz74ZG+xA50yFY2w/TozZ1F7dOdFxe9SsE8jdLk2bB4rgAz1sm2uKINwHcFBgHcWdiQBkRHUIClqIyp/TEGKZSaH+6B+9+MJPtGyjNYb1glflnOH6VhHRb77tRzPjjIcPvz/aqDCDe5OQOSGTvxxsPZZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743726874; c=relaxed/simple;
	bh=DFO4bXZ014ZpwTsn4LpgKb99Si5e4nA/SkmpxB9PP9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pklpYcQHr3+0ZSoINhgUYEERHz06wDem11HKNP2ip4iYo6132m6XbAK0a08Neb4Ox//D297Q8pXWQ9aipP+cXq3Cf2jzgtsqUQdblq62zF3Q68j+zpmFf41qfz8zEEgZFPhge3V2ay9acVRo5sBttoYQnlKEcX3KkzOOVlgMwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2UqpGTBW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30362ee1312so1488730a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743726871; x=1744331671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yC6DpW3qnDUJCZSptcxapNYOX2WskJFPGbN96g3bSE=;
        b=2UqpGTBWYuueS2qTC8J22idQmru7Ilw1qZYZYs3FFOiimQ5Vyqk90mq1DLP1rJ6K1p
         eXl/SCeSMErX3g2aTzkwQdW1meND6XQb815gt/fMR3wG/zvJ3LZKVi80YA+Ya/dpg7Ux
         VnlsJfi9ENnvC+lbALzbsUGF5RIPloyuweN7D1I4B3iMwoSmJUEhsgHqExnAJYjQps7r
         xFWLBM3Tv8IwOtTH7dS1nq5PhKLO8GcSR2GtHW1jPSjaI4nwYDHrOU3EKDGgU70PJqIb
         35dplKUaJbdWOcGLlRBGkCFAsm+keuk0H/yUnBabWGBJ7/m6qDeNgGOBLS31IU/VADug
         H8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743726871; x=1744331671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yC6DpW3qnDUJCZSptcxapNYOX2WskJFPGbN96g3bSE=;
        b=DTxSbmI14STBbzTwKOnLRH6/2p+opWgQNSEL4qzVurmLgj3j1tQ7peck0CuD6xOBXD
         G6tGRg+v6rcZlWPuXrmFfCHpWvYOjck7vZYod8b+gj2OGzAvXU+ZojkDzfFA+jLLi+ZH
         CuDPAJplDf979lwszq4YVD4DfzAQHlllz/yatb26GwpJw8MB2Er3nr8ujd/LY65EmW67
         8kONHap4fRxZWiTEpOsBQWT9ztvufwclMuqUK3JmKLEnxDonByxSDgAHqL3KGxlG75ou
         dXA5QIhpcYYxQFV+bbeMYM1X6401AdjB0sUVJwKY+dt9KW+CencqqVq827o4IVaGQeqs
         U5OQ==
X-Gm-Message-State: AOJu0Yxpm6/FkId4ChE/luVxFxt8/KfIrX+8nyXma8VcMVtOO5LXHkQh
	qmsATvnDJFx1rHkdGW48T6hsE66ERH5ZBv2WYjtP1gvBm5lR4q/E9RkPgj163No=
X-Gm-Gg: ASbGncsXeN1HBA7QThDRJt/M0weomIq+MImuuWXBp4Hf5hRmR4QBUlcIyn95MLOnGou
	GdtLWVUB/POQ3LIm/Q11YOS641C6+0JnzrBE96KYQdZuGJI10mUk6/KKxWwap2gAB9p4h3GNH+Q
	aAoD6HyT2zTlhKWMZrXCaJ4LpiSAJnyuhHTa3ckC9R0528ma+CB2gnUroLGXNuBN7peWnPFZ4gS
	BqGEzCrq2vuAxSShww1XFOzkupy13i4e5khwWlHpsFpYYxZpTeOmwm/sz49MF3ubcP7U2EKCtKi
	FhvOmiGhAcpjE9e/+FB401esXWGBRb1gvkRazx6YITOpyJG6O+ALX4WQCKNKp+/kj1suwyEQNzk
	5OrmEcrnNyFkOGis8P/pTS7S7mAWFBXE=
X-Google-Smtp-Source: AGHT+IGYz6GbapVk+SeuKyiphj7tXyiC3nO64dmF/fFeDjjtQ6/XviRzMQ7ZKuzo0rJzllmfMUVBFA==
X-Received: by 2002:a17:90b:2f03:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-306a48aa124mr1865818a91.19.1743726871115;
        Thu, 03 Apr 2025 17:34:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca8768fsm2378040a91.27.2025.04.03.17.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 17:34:30 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:34:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ziao Li <leeziao0331@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] nstat: Fix NULL Pointer Dereference
Message-ID: <20250403173429.4c19fca1@hermes.local>
In-Reply-To: <CA+uiC5ax7p3sn+F6cFYUvLnUHH2_4LauOCNtyGCZZZr7NNY2Kw@mail.gmail.com>
References: <CA+uiC5ax7p3sn+F6cFYUvLnUHH2_4LauOCNtyGCZZZr7NNY2Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 16:26:48 +0800
Ziao Li <leeziao0331@gmail.com> wrote:

> The vulnerability happens in load_ugly_table(), misc/nstat.c, in the
> latest version of iproute2.
> The vulnerability can be triggered by:
> 1. db is set to NULL at struct nstat_ent *db =3D NULL;
> 2. n is set to NULL at n =3D db;
> 3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val)=
 !=3D 1
>=20
> Subject: [PATCH] Fix Null Dereference when no entries are specified
> Signed-off-by: Ziao Li <leeziao0331@gmail.com>
> ---
>  misc/nstat.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/misc/nstat.c b/misc/nstat.c
> index fce3e9c1..b2e19bde 100644
> --- a/misc/nstat.c
> +++ b/misc/nstat.c
> @@ -218,6 +218,10 @@ static void load_ugly_table(FILE *fp)
>             p =3D next;
>         }
>         n =3D db;
> +       if (n =3D=3D NULL) {
> +           fprintf(stderr, "Error: Invalid input =E2=80=93 line has ':' =
but
> no entries. Add values after ':'.\n");
> +           exit(-2);
> +       }
>         nread =3D getline(&buf, &buflen, fp);
>         if (nread =3D=3D -1) {
>             fprintf(stderr, "%s:%d: error parsing history file\n",

Your mailer is corrupting patches by adding line breaks:
 $ git am --sign /tmp/nstat.patch
Applying: nstat: Fix NULL Pointer Dereference
error: corrupt patch at line 15
Patch failed at 0001 nstat: Fix NULL Pointer Dereference

