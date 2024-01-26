Return-Path: <netdev+bounces-66181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BF83DBE7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC40B285E7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C710A35;
	Fri, 26 Jan 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="V4w+d/H/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859110A24
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279550; cv=none; b=Y4brN4OuJdM0eU+tSK0fDFnk/Anwy2A5iKJCCCs6JiJnFuirdIgx//oANN2NtDhPBSA9d74jtCMZ6PWIQONp1RlBTocjWY0pr8ydj/n371M8N2p3jblwNCyhv/GdUVyVpbTDHo42eO0sSxUvHI0sNNXonu8p3ANsitScAnJoZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279550; c=relaxed/simple;
	bh=nrlXB23+f88ayFuafbvhALOvRnM4K+bKlAaSyBLUMVU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=tltLdAFfphObncUgfjhwuBdORdQiJRAqJJutXtvVN5RDvgB+wfqNuYhY2Ha0zNbDUOK3cVroViIdTVQepLXFCo5/qN9NRI9uCOAlbtXr8jZt5cSaV1X5V0pkGvZ/nQSMJdQavoCJkPcwVXeA+g3CWa0SurJgfJnlopqfWqmoeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=V4w+d/H/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso290758a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706279546; x=1706884346; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=xZjB8lew+4ofCbLCRGPhr5DpMzczn/0ZLLdTiqAxe+k=;
        b=V4w+d/H/EK8c/NhcOU11hiK6gUW6iMFjwpbkAnqXAQNOlXIDx48nZxf4865F39BRXb
         XHamRe00WddWYQjipdPD304elQn5k2uRFyMOTqkWaUVShOkCAcEt/S3S8RKoWUaRXlXM
         ik6h+wsM9y167dZbC+61mjbGaHr7pXtcsuwPiyL9CG3aoMzQ4v7dhtOJJNdBta7wjEIv
         qfNkjvRa5WgeMEFVXqnJamQDM5aAncwdCgdR84ZtpDld4WzFMctOxlpyMxyrjS2BGVfu
         wDrLL2O2gKm1XJgqYyK7zeZDAR0Wd9sR0N79TC5unrjaIYklycXF/yyKHCviED6U2Xyd
         YR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279546; x=1706884346;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZjB8lew+4ofCbLCRGPhr5DpMzczn/0ZLLdTiqAxe+k=;
        b=l0e57l6vdBnUZZA8DhQiaHCTOU8btJeUQENv4g/QeKqgjXBz9k9LcqkILBV3A7MnS+
         +kyQb1zKDnQ8AYH+JwJYgh6xbVDK1lz8Q7wt0ajEli7VjQPp23b0sJYMQUSkZCdwhrib
         LpUXXl1aalL1wpqVjJUB4lcs0cbWVjrgffvzXbtBbzgWPHhLjEOsFoe9G3xb2jAtrBWC
         LteEg0T5GdnyrJJf0JOcoKLkHyzseItvZd+eVcnuNwozcxPA7OJTvnj5fZR6eF74YsdE
         IL/jx+NNFg2lQcWPE5Gtj9Ck5UTl2uGkb4g7xptccpNYCoeI6isY1F67FLMI+w3UiE6l
         oS/w==
X-Gm-Message-State: AOJu0Yxa2qTt44uHKin45tiCprbD7oOdknM8MpjbhNoAHO+5doVkoNKm
	Q06rT0Ul+XPecXAnKtf8Fm0u7ts3BdMmG8yj/Jpd1QK/Uf9gQfpTAog1NQQlbBc=
X-Google-Smtp-Source: AGHT+IHWyDYVg6LTjtU+B1aTlf/RUUV6rA1nOGQihdpF637ohF4ZIOhLb/RbZlHbEnx6T9i9bOk5pQ==
X-Received: by 2002:a50:871c:0:b0:55c:d5e3:9177 with SMTP id i28-20020a50871c000000b0055cd5e39177mr963479edb.30.1706279546632;
        Fri, 26 Jan 2024 06:32:26 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a2])
        by smtp.gmail.com with ESMTPSA id h1-20020a50ed81000000b005593b14af3csm657783edr.84.2024.01.26.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:32:25 -0800 (PST)
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-4-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] bpf: sockmap, add a cork to force
 buffering of the scatterlist
Date: Fri, 26 Jan 2024 15:19:41 +0100
In-reply-to: <20240124185403.1104141-4-john.fastabend@gmail.com>
Message-ID: <87o7d8dv2f.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24, 2024 at 10:54 AM -08, John Fastabend wrote:
> By using cork we can force multiple sends into a single scatterlist
> and test that first the cork gives us the correct number of bytes,
> but then also test the pop over the corked data.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .../bpf/prog_tests/sockmap_msg_helpers.c      | 81 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_msg_helpers.c      |  3 +
>  2 files changed, 84 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> index e5e618e84950..8ced54fe1a0b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> @@ -21,6 +21,85 @@ struct msg_test_opts {
>  
>  #define POP_END -1
>  
> +static void cork_send(struct msg_test_opts *opts, int cork)
> +{
> +	struct test_sockmap_msg_helpers *skel = opts->skel;
> +	char buf[] = "abcdefghijklmnopqrstuvwxyz";
> +	size_t sent, total = 0, recv;
> +	char *recvbuf;
> +	int i;
> +
> +	skel->bss->pop = false;

Why reset it? Every subtest loads new program & creates new maps.

> +	skel->bss->cork = cork;
> +
> +	/* Send N bytes in 27B chunks */
> +	for (i = 0; i < cork / sizeof(buf); i++) {
> +		sent = xsend(opts->client, buf, sizeof(buf), 0);
> +		if (sent < sizeof(buf))
> +			FAIL("xsend failed");
> +		total += sent;
> +	}
> +
> +	recvbuf = malloc(total);
> +	if (!recvbuf)
> +		FAIL("cork send malloc failure\n");
> +
> +	ASSERT_OK(skel->bss->err, "cork error");
> +	ASSERT_EQ(skel->bss->size, cork, "cork did not receive all bytes");
> +
> +	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
> +	if (recv != total)
> +		FAIL("Received incorrect number of bytes");
> +
> +	free(recvbuf);
> +}

[...]

