Return-Path: <netdev+bounces-82617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D388EBC7
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 17:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA04D1F2E404
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117D14D70E;
	Wed, 27 Mar 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcniWIq4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25014D714
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558573; cv=none; b=sINnK6See6r520QaeCsjnOxXXFRtlK/mXEfcIi6iX8TYpZJbqLEV/a/LX80C6vhfnE7WJyzIoTkGDOiGWE52GB+epY6pRxaN7DuMKFd132B0lmDd0s+NEK6Xk3naW1TOMywRB02TXZUft0geY9d0MaFb4c+4+Krd68hh4KQHL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558573; c=relaxed/simple;
	bh=2v7aLHwG3xBNYzKIzJCv7AnZ5MRpT0U1cdtqi6Tzb+U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCjFAEa7qRsJ2JP0CPDPouUgvo2fsW/yqEBXs6VQ5GOG5QJiU4d3L5NZSrBvsJkl+XOG6fL79O8y2RARXC8XzUkrRjfQJEaLt6ELeziEE54eob0qrthQoosmMntEHl3xYzPARkIm8hG0b3nzbjYHmuJg5wpbFS9IQaELDp1zUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcniWIq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711558570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0grGr2vs7g8LZk25gVO01eJHrHioop+8opYOjWTngeo=;
	b=GcniWIq4jqgyPBbfCmI7rVS8cTfYqPZfHSgXIibWHzGcu4stP865evUjf61C8WMRjhRCd0
	ZlQk7qrAbljWZ3MpY6yXzT7hLa3P9xZhgcgDwlK7N/2+SgnhgI05CQUBUDCspir3rH0/6T
	Tc81raujTlmcjpeT8XuRpMDbkT7vZQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Cq-h7g39OkqIR4SN9sSXeA-1; Wed, 27 Mar 2024 12:56:08 -0400
X-MC-Unique: Cq-h7g39OkqIR4SN9sSXeA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-341d0499bbdso674170f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 09:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558567; x=1712163367;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0grGr2vs7g8LZk25gVO01eJHrHioop+8opYOjWTngeo=;
        b=tMm4+to4eeSfbvDDg8DD/chuNMDYfpRrEgtnFAGOmQjaKaDQ3+B5+oF97hCBL5pP/w
         1fmIA5uwJ/tzudC8u1fvi27qluBgoCkkgYsUm5nyyrDx6Vxu8sU9XcPphPv0960X8QTw
         YY1Gjzl2WAIMMSnrsLNLcgu+boNXFUA+KT8Z4zOiYEMjeL0tI8N24NSoSEo1zprJVls6
         p7jr3IbhKE5FnJ42wJsS2wrs0Dm6HXoYLWkCi0VIqOZlqVteWJuzzyGXnkFSl2Lp4xSW
         0+A6SNT+RlAtJ/vxVTk6DgnBYg9JyzPpVEILYh9i09ixzXxgOeS0ncy1q7DCA54BIgsa
         Msuw==
X-Forwarded-Encrypted: i=1; AJvYcCUsgxml51RhH6152r8Gjt44qvurmrJonh56RFydUmTag6bEL6TVP2Dp/YPlJ7SAlbB1+gzp2UNw196Wm6wB1gbru0YCpZT8
X-Gm-Message-State: AOJu0Yy9pcwexy4FVjrwzVL59VTmqQfk1QFVBcu8UHY6PSkzpJ3S+lDJ
	iKzlN2fsu5ZAiMocYHm14QspxgmqaUpTw227u1DFfNiWsq3lVchFxNWovS5Khe8pw5tr5JPiYvx
	NJlXuARv7qRjHD3/HSZxppmrbp3Cq9t/8XKe4dyE236kiWxiZDRbAS32RRDLQMg==
X-Received: by 2002:a05:6000:1818:b0:341:e617:8f6d with SMTP id m24-20020a056000181800b00341e6178f6dmr343076wrh.7.1711558566938;
        Wed, 27 Mar 2024 09:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzQKN1dAufZbQQUXLp6v3dofv6/SA+gzYRqZDhHX5s8KmiBqhQCEb+F7oRcTeE3/OX0GqXLg==
X-Received: by 2002:a05:6000:1818:b0:341:e617:8f6d with SMTP id m24-20020a056000181800b00341e6178f6dmr343063wrh.7.1711558566579;
        Wed, 27 Mar 2024 09:56:06 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0aa:8c10::f71])
        by smtp.gmail.com with ESMTPSA id by9-20020a056000098900b00341e67a7a90sm802934wrb.19.2024.03.27.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:56:06 -0700 (PDT)
Message-ID: <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
Subject: Re: mptcp splat
From: Paolo Abeni <pabeni@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development
 <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Martin
 KaFai Lau <martin.lau@kernel.org>
Date: Wed, 27 Mar 2024 17:56:04 +0100
In-Reply-To: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
References: 
	<CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 09:43 -0700, Alexei Starovoitov wrote:
> I ffwded bpf tree with the recent net fixes and caught this:
>=20
> [   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
> subflow_data_ready+0x147/0x1c0
> [   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded:
> bpf_test_no_cfi(O)]
> [   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
> O       6.8.0-12873-g2c43c33bfd23 #1014
> #[   48.467143] Call Trace:
> [   48.469094]  <TASK>
> [   48.472159]  ? __warn+0x80/0x180
> [   48.475019]  ? subflow_data_ready+0x147/0x1c0
> [   48.478068]  ? report_bug+0x189/0x1c0
> [   48.480725]  ? handle_bug+0x36/0x70
> [   48.483061]  ? exc_invalid_op+0x13/0x60
> [   48.485809]  ? asm_exc_invalid_op+0x16/0x20
> [   48.488754]  ? subflow_data_ready+0x147/0x1c0
> [   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
> [   48.495026]  sk_setsockopt+0x6c0/0x1540
>=20
> It doesn't reproduce all the time though.
> Some race?
> Known issue?

It was not known to me. Looks like something related to not so recent
changes (rcvlowat support).

Definitely looks lie a race.

If you could share more info about the running context and/or a full
decoded splat it could help, thanks!

Paolo


