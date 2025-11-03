Return-Path: <netdev+bounces-235176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE0C2CFB5
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0B1188A191
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF50314A8E;
	Mon,  3 Nov 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YfcrzaHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40B3148D3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185638; cv=none; b=YIdU2mwCzPKL60zI9dKzpddn7dACm/oDy76Al+C4hZ58IuZdeMTymokCnm1F2wBSU8Jj1OsQDh1HUpxErUe3c0BLiEsw98C+mVU6tJAyw+jI5rHbuCFF8/xRzmgAsX8JHq/DXDt2n7G8psZlQXJxkvZ56MfXSAYiMjx1Yspk5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185638; c=relaxed/simple;
	bh=u/v9zwBXeTYOSyNNJOnBJwzFiY3TMAa7bh+1x3RgIQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR3sv7lZud6N7b/gKXL2fOqFzwVL2chXnQIi+17ghu01CS+AYakRHYSB/Kcjjxx879GfLriIlo3hPGQ9LhjE6FpTGdRV/IDCq4MiM1GEoZMbvKtfqBB9TAag/d0KWY93xAS1y36nXbzfbyLRqpofOItJ0xqYmUGIg2q2tU+zfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YfcrzaHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DED0C4CEFD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YfcrzaHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762185634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFXbuJfVhtnEO+e3LrlsO9hKymbN1+iXd17V2FlJpIQ=;
	b=YfcrzaHbZeayhT8s5Ww0BIHDsbeAFEmcd1cGBHSnYbxZUaRaxhpVfQyijHXLXDNn48WbSy
	XbW7HHba84aAY16ebiDin7KJgZt3ZBrWhtKNV85ZFYQ0ZKbWmns11UK8z31thaoEe4qI2w
	A+88CeJ1D6WEYRZR5/2XmIC23WvDhOM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c877c5fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Mon, 3 Nov 2025 16:00:33 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3d47192e99bso3388385fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:00:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxKcPM05D6KUjM8Rii8AgNvWrZyvXVNgzYzoWMMnjNLI5TRf1QG
	XsSxHOATbPj51GPQf1PRHa4C3TeR326/j9reZmJZzey26RO7t9qesMr9FOQsihyIwL8sGpFtDgU
	jmBhkWOjPZd6MHJ2R5MIUkWQ+fmGtx2M=
X-Google-Smtp-Source: AGHT+IFJU5W/D3jhpHqv2bOBkQEwLtxlfRs0ZwDZC6VBXRxYEMkNme5Pt7EoXcMe3KtGwKkmM5p1o0GgKghmelV7j8s=
X-Received: by 2002:a05:6870:392b:b0:3d4:e07:8667 with SMTP id
 586e51a60fabf-3dabc0f2600mr6653900fac.25.1762185631754; Mon, 03 Nov 2025
 08:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103103442.180270-1-mlichvar@redhat.com>
In-Reply-To: <20251103103442.180270-1-mlichvar@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 3 Nov 2025 17:00:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9qcj=zHHm0-gTeSLxqwufEBFO721ciYQODTws6wTb7+Rg@mail.gmail.com>
X-Gm-Features: AWmQ_bmK4pf5h4aab1n6Ipd-apVl4BGhRfJ-rJ0YI9K007pjAuXxIqzL8ZEV6zA
Message-ID: <CAHmME9qcj=zHHm0-gTeSLxqwufEBFO721ciYQODTws6wTb7+Rg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] wireguard: queuing: preserve napi_id on decapsulation
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 11:34=E2=80=AFAM Miroslav Lichvar <mlichvar@redhat.c=
om> wrote:
> +       } else {
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +               skb->napi_id =3D napi_id;
> +#endif

It looks like io_uring has timestamping on tx, not just rx:
SOCKET_URING_OP_TX_TIMESTAMP -> io_uring_cmd_timestamp ->
io_process_timestamp_skb -> skb_get_tx_timestamp -> skb_napi_id

So are you sure this should be in an `else {` block?

