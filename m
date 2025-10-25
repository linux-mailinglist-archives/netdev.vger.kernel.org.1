Return-Path: <netdev+bounces-232815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E46C090CC
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019703A8A39
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066042DE1E5;
	Sat, 25 Oct 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jm2erwky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D32C235B
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761398827; cv=none; b=PLgcevSD5uxRpkEey9oREXO8Bu1Vu8DZZkLCyDvwxn/g28ZlJtAbYOdLFod8alH/7hVxvbaacf2iwvwDKMIOHSeVeMrke6u08lKJS3g9bICdE9QTvMbuEaRnktsAKcH2kdHh9s7EnzrNUWN/sFZkFfZbBv80RkYWquKf7JgF2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761398827; c=relaxed/simple;
	bh=k8cXpNCmR28LWIgyErSMJlosiGhqYYVc3+Boi9DrAIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zlz4QSd6RCaK2nrbVTxIiiV/ePPJhxQVEE/pjp+ZcCQ33fHXbxLFYcoUSmhsKbDHVrKucDeVk+bI7qe9pSIHjtcmT1BoMrEGX+Oa6tl7P+78FRqxCDeNaGE/op5dNwCeqgTntVm9QLtVdTfdEBk+2lkeRBit6GeJ/mDQuN7C1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jm2erwky; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-943b8b69734so58400839f.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761398824; x=1762003624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0o8C4vMoT/wqtVhCd1qilOO7b4cOo0+Z3kwre8J7x8=;
        b=jm2erwkyMmeoq2eZ8lFjQYOfUoNvzIBmpq9P3slJRf+HGVL2jbGvrmM3OrnCHPIGQ4
         +wDY61hK1/Hq26T53pJ/I9b5S0BIXonX+x2w2adRV50oQoKp4EWxA8D0mqUvwJ+F5vSm
         YV0pGNEC4MPP59Vp2jBOR1881zNHVmKB5+c08kKNGGblljk2pPsdOUh13++2nGtNb+gh
         sQLCGiNSAZtX7PpicU4/Gu/CCt3eyTcNuvOuRgnffBW8oToTrlobvPfkQGoH43XB/XXP
         V4437r+FyPUv2aepTPQms3KxdbGUh0ORFCIQksZKnMMeBkMFb92jzi/EHAWAjtvohupk
         KW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761398824; x=1762003624;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0o8C4vMoT/wqtVhCd1qilOO7b4cOo0+Z3kwre8J7x8=;
        b=CN+d/tl8udY1lkDlKiuVwxkAdRSPEaU57PkMA39zyzbBD0j3zL9SK64ugBnJ88fgBI
         9fkq4UkPQPUtpM4rwBPvuEgk8DpqkDGxvbxy5ErLhZGxcfNkNjPG44Oq4AA0LAQN7rIA
         bJsNcrBpE+WVErGVevz5MAIEr89sDszM9GPv9ru7cZgZgfUc2GUWvrW93OUjQYJvZ+uW
         S3b5z32TmVvmH5XAekszHx7LZBtATFNCtkd/8q0DX1BHQti6zS6gPIhhbd0H+FfXn2rz
         STg0AmwG5EQtZfUfrx+d8xFVDiozQX8XlbgIBd+W89a/uWgBqhtDIc+yDbbZ0DxKfg6m
         XTRw==
X-Gm-Message-State: AOJu0YxUr/LoM5cYu+mvhc30433lxExmsMX6n66PYUi6lh0FDcYKihI2
	wdNe25LAVawbiRE5faumLA7nx6aUiRZO6UevRyq4IOpuMgClCt0yx79vNgBMPp8QRc9AYe05L5A
	QMJPvSj4=
X-Gm-Gg: ASbGncsWIhjZzpG58z2N8THBchDFqsxFRGHbGOO0ig9HW70X1ETuk31kOMmQNwIRRCo
	JwPtl2e0CVpQAFxnmubz8pFSw7eRshJYxe0FWQ6AuP8Y7xDjBfRMwOjdRRATa8EKNFTTz0fWnLN
	GPOKZKJBQ5TZjaEa/tX+MJkX3o4yWxiA6gHszF23p46CqRQETfXfc0B/Upo1NecmeeA9ygmCWSI
	z0DMtMg3s8yA++1nussE/16h/VT4W7DVMtvjQgjrv2ppJLCJSwy/RUUzoNSdRVrf2zyrAt8j6SG
	pUj4qgPjoUKruqOg2w4iFad0OeoAbVTy+xKbj+o1E06r56MJONZAC7xFrNd2/BxYbHiSwl+gMfi
	fhRNybSih1Fv7LAtctVksRSWzsZPXCAemIsqoIzFSim+UGrjqoNviFGb4zLTlBQi4Bb6AodAVyQ
	==
X-Google-Smtp-Source: AGHT+IEcl+ouTWzQondoTJD6nHB5VGbeQjWrfedXKmB7gFnl4vZIVF56W7+RyOoq7o8xM20OVp6aJQ==
X-Received: by 2002:a05:6e02:300a:b0:431:d864:364c with SMTP id e9e14a558f8ab-431d86438femr149277995ab.17.1761398824146;
        Sat, 25 Oct 2025 06:27:04 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f68747b2sm8084375ab.17.2025.10.25.06.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 06:27:02 -0700 (PDT)
Message-ID: <f61afa55-f610-478b-9079-d37ad9c2f232@kernel.dk>
Date: Sat, 25 Oct 2025 07:27:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] io_uring: Introduce getsockname io_uring cmd
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20251024154901.797262-1-krisman@suse.de>
 <20251024154901.797262-4-krisman@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251024154901.797262-4-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 9:49 AM, Gabriel Krisman Bertazi wrote:
> Introduce a socket-specific io_uring_cmd to support
> getsockname/getpeername via io_uring.  I made this an io_uring_cmd
> instead of a new operation to avoid polluting the command namespace with
> what is exclusively a socket operation.  In addition, since we don't
> need to conform to existing interfaces, this merges the
> getsockname/getpeername in a single operation, since the implementation
> is pretty much the same.
> 
> This has been frequently requested, for instance at [1] and more
> recently in the project Discord channel. The main use-case is to support
> fixed socket file descriptors.

Just two nits below, otherwise looks good!

> diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
> index 27a09aa4c9d0..092844358729 100644
> --- a/io_uring/cmd_net.c
> +++ b/io_uring/cmd_net.c
> @@ -132,6 +132,28 @@ static int io_uring_cmd_timestamp(struct socket *sock,
>  	return -EAGAIN;
>  }
>  
> +static int io_uring_cmd_getsockname(struct socket *sock,
> +				    struct io_uring_cmd *cmd,
> +				    unsigned int issue_flags)
> +{
> +	const struct io_uring_sqe *sqe = cmd->sqe;
> +

Random newline.

> +	struct sockaddr_storage address;
> +	struct sockaddr __user *uaddr;
> +	int __user *ulen;
> +	unsigned int peer;
> +
> +	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +	ulen = u64_to_user_ptr(sqe->addr3);
> +	peer = READ_ONCE(sqe->optlen);
> +
> +	if (sqe->ioprio || sqe->__pad1 || sqe->len || sqe->rw_flags)
> +		return -EINVAL;

Most/all prep handlers tend to check these first, then proceed with
setting up if not set. Would probably make sense to mirror that here
too.

-- 
Jens Axboe

