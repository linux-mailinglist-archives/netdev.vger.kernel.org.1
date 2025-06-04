Return-Path: <netdev+bounces-195079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE1ACDD6C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06D31883061
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB422A1FA;
	Wed,  4 Jun 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E38cAYjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6921C177
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038655; cv=none; b=YeE97SAEdU2quK8HjsTsFP3l8aIRYMHBz1bmoIYiqRzQ6M1XWMlSh1y5Zji+zQ9L3kK/4VOX8MpVQOYy++BA/+XKjFyqtVscYolRdjMisZFr7QLx/DNRwW2jCUoH+Oj5eHrA5b3tCDGfjRziuR2uEJstc76qJQ++PI+yyXjDI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038655; c=relaxed/simple;
	bh=czeOyPmVvXVBfs4Ud9cQHqu0dn4U3EiDxE8jG0ZiucU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/LV7c513eoKcwFkKlsO2dmb+1R4MrSylrT9QKsjEYlZN0uAPK6phkOQxHui4EQfL3ez9A715O8JVY6ucJh2qbq8Xp4L0dLv3JrX5uTEFAVw/CypClVqGP9Bi14gYSDoVbp9w/SeLniTfvQBH34HBO/hn6q5rcAqK0DGK/8/+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E38cAYjv; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86cf3a3d4ccso546004139f.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 05:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749038651; x=1749643451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLDsbTBKm1Yh60AiAo9guAzErGn09ZhCvWynD43OnYM=;
        b=E38cAYjvdxbEZp9Gqm78P+HgolWAwVWdtZLIJxcEuvbB1W4EPG08u+mW8MMdv6pumC
         gLpkq5jT3wmPYc3ZLGHs/PEMJmEVLSRLCaAtB/UDvtZXHn0FXVTRREifWRjnrEWXA9xq
         +DbS0ZzXV+e64FwKkLDB/nVnVUHUwVGhKgnkNzOoJFEI96FI3DTYdqBhhMImzy6JrB3y
         kYV+0K3OM/UpA/17JB1w/R+FdUMfjBQC8dQno2dtVm76ROaZQfyi360q7Ld7XYGD3dzg
         fOLQGG2l74WNWbp6pVHtaO9Gl3IpzETN3eB7wg06H129dE324T5A28Wi3nHlp48KIt4l
         uReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749038651; x=1749643451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLDsbTBKm1Yh60AiAo9guAzErGn09ZhCvWynD43OnYM=;
        b=ABNnOmUtS2HjLHU6PfBcY7GLmiuSEzM4TNsQpLzLsxBrPt5SRjwj4y/Y/QmijH549J
         k9QAAHaULwmhkglb2eIqIE44FnzSEb4L94R22lEtgxRDu5YvJ8aEsAOgXyxkUXr1X132
         TmvxeuQ8YU55fXwBCVjRUatJetLnDGIVj9o5t3EV/O0RIc6NUYbps1bNrLqqWbIUr8la
         GXYEWqaRcK8yad7DEk/63PdMNzVV8r15hyglPXMZumO1W+UtydIIlnAPs4PIgZJEFZtE
         oEPB9jjlTFNBGJfnlCtWMwnYqEnen9J4ohdljD7KwOBMMWhsiMyfurBToDbheZmuBOVO
         Es9g==
X-Gm-Message-State: AOJu0YyYSSxs9NYIAsrSVRgsDk+QkyC+wVNa4JXAd8ME60lTbMBg2EPK
	i7BBkNw/jTWta2dR9GwJebugIugt5uGwwAehAw0Ibi30TRCVtmtik7G3ymoD+LmfazY=
X-Gm-Gg: ASbGncvDPK06LmOJZ/b1ND/ZNLmEJu16jUaKSiuIP0BRnKWjs8I2oIdBzLjrv6gss/a
	ktvaCHcvnU8b8vMLi3PuhTeg5leKQnA8fbliDojD2fPPdmU/V0/4qzyob0Db2gfXbUcmD2mSWmn
	ZDtMb1y9VMj7eyzk+wsA/JGl67+QTfMWB+F/c+4/uBinHCBT1ENJvxx7u+HBvp8p3ROiA8OWxit
	uCBzZToGO47G6GXo55kDf7Lj4W/JZHySK+hZkSDKpedz1RbHuXPNfy0zN6V7wF72tbxZ3UMrdo6
	pP/cJHTmZtSHnBho2FOjIpGBvHn7Q6HoZzg5d1imGFiPeRec
X-Google-Smtp-Source: AGHT+IH3GhaWWKePY6/Kv2phWfjAT6ufTH1YuVpBPEe6P+CopUwJDvG9SiYJka9K3jKYaK7hg7Rilw==
X-Received: by 2002:a05:6e02:3e06:b0:3dc:87c7:a5b5 with SMTP id e9e14a558f8ab-3ddbfc344efmr24062385ab.3.1749038651437;
        Wed, 04 Jun 2025 05:04:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e2801esm2729404173.33.2025.06.04.05.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 05:04:10 -0700 (PDT)
Message-ID: <b82bd278-1562-4901-971a-aa111c749747@kernel.dk>
Date: Wed, 4 Jun 2025 06:04:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] io_uring/netcmd: add tx timestamping cmd support
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
References: <cover.1749026421.git.asml.silence@gmail.com>
 <7b81bb73e639ecfadc1300264eb75e12c925ad76.1749026421.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7b81bb73e639ecfadc1300264eb75e12c925ad76.1749026421.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 2:42 AM, Pavel Begunkov wrote:
> Add a new socket command which returns tx time stamps to the user. It
> provide an alternative to the existing error queue recvmsg interface.
> The command works in a polled multishot mode, which means io_uring will
> poll the socket and keep posting timestamps until the request is
> cancelled or fails in any other way (e.g. with no space in the CQ). It
> reuses the net infra and grabs timestamps from the socket's error queue.
> 
> The command requires IORING_SETUP_CQE32. All non-final CQEs (marked with
> IORING_CQE_F_MORE) have cqe->res set to the tskey, and the upper 16 bits
> of cqe->flags keep tstype (i.e. offset by IORING_CQE_BUFFER_SHIFT). The
> timevalue is store in the upper part of the extended CQE. The final
> completion won't have IORING_CQR_F_MORE and will have cqe->res storing
                         ^^

CQE_F_MORE

Minor nit below.

> +static bool io_process_timestamp_skb(struct io_uring_cmd *cmd, struct sock *sk,
> +				     struct sk_buff *skb, unsigned issue_flags)
> +{
> +	struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
> +	struct io_uring_cqe cqe[2];
> +	struct io_timespec *iots;
> +	struct timespec64 ts;
> +	u32 tskey;
> +
> +	BUILD_BUG_ON(sizeof(struct io_uring_cqe) != sizeof(struct io_timespec));
> +
> +	if (!skb_get_tx_timestamp(skb, sk, &ts))
> +		return false;
> +
> +	tskey = serr->ee.ee_data;
> +
> +	cqe->user_data = 0;
> +	cqe->res = tskey;
> +	cqe->flags = IORING_CQE_F_MORE;
> +	cqe->flags |= (u32)serr->ee.ee_info << IORING_CQE_BUFFER_SHIFT;

Get rid of the tskey variable? And I think this would be more easily
readable if it used:

	cqe[0].user_data = 0;

etc.

> +	iots = (struct io_timespec *)&cqe[1];
> +	iots->tv_sec = ts.tv_sec;
> +	iots->tv_nsec = ts.tv_nsec;
> +	return io_uring_cmd_post_mshot_cqe32(cmd, issue_flags, cqe);
> +}

A bit of a shame we can't just get the double CQE and fill it in, rather
than fill it on stack and copy it. But probably doesn't matter much.

-- 
Jens Axboe

