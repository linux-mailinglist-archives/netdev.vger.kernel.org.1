Return-Path: <netdev+bounces-99863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133328D6C83
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D231C26DB9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB37EEF5;
	Fri, 31 May 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cRjikN4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973950280
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194705; cv=none; b=EaoTrftRqygatyHEm+Z7F0FMMixMG6DAL9gzrEYJvm4CGI1m7lLkjaF/cx/VoJvh6KZFwEY9vW6YzZbaf5/JpJoYVO3MToqyBTzqzomy+ysw88KZWHX2aM9RFwZUasErBNvyWV+FFuaETexyVVp8VmguE1yteixfpRjNdPCQ+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194705; c=relaxed/simple;
	bh=9VxDiX8Wng6SJGTVFXWnlvqPT2mPScEBj6Bnmt32R9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lESC+oCq0w6vesW9Z9VuFje5SsO4DeLOp5c/rQLEmAKbSZvZpVARW62hHFdhFzrEqQPKr54KS1NOfkUZBXCr51X4cxWk0dWKgM7oKVKIAE9LO8ABfA/HvxX+JwM8CbZqypl4CxPX7PeIzCOBg2I97jSg99NQ1KsbyiZs8GLtXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cRjikN4q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bc1fc93a99so265484a12.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717194703; x=1717799503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+L0188MAK3foFP/PshDAEmin51CEA5/tCFV6EEd1hks=;
        b=cRjikN4qPFwwn9bCGzWPWH96gwMynAe9dFLeaeBXNuw1AHquBZkCQ3EBipC3RsPU/n
         NhWmbu4YKxmYky+NVGWQiwQk/R/QU6AVPSdtKPP/Vj5Lf2PG3dZmCdMN02E0ChCdq5hf
         gD4E9jboxi9BjO//bM2LMy3UjYRXwacqb4DLIdaMPl/19zCxhBbvhaPpGZh7ImSEQQCP
         zmlQAy0r0BOrfSpzIJn7m1u4mHQzIT42Sg/eIo1mWxK7JEcg/nTw+9Q9J+O8ZWNgmhSB
         YKL0NDrPD+OF6/U6uAgehKgR1pibPPOTdq8M3e5bxBVCwcpKKdOTG24Lmqlw6/7/lIU0
         GEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717194703; x=1717799503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+L0188MAK3foFP/PshDAEmin51CEA5/tCFV6EEd1hks=;
        b=l/rYBBuuUDDuI1pOvI8g1rZjBruaAeaAq5TBWqfT/US3t967YmUVdO+6aX17gQj0uc
         Mjlbk0q9RzeDROBDuCBIPJwtxTtlhdRPTd724moMFHEDZ6yEPxWqsWgMjNq+IqiD+u6/
         LxaRq3ViMhhxzwUmy8VAkPqKceNiQuyagLxr4sQjeM+tvInzfT8RIsSJvsbvaxi/g88H
         gSuNiNjr9yYaVdpUo9XOcdbXj71f0c0CHUTxEwjyTCanVZTDqyfR032BLX/wM/kLwpY3
         3piF/pnIWLP4qgQ6+Y4C6dqEtJzTNeIAGMyWT1hiIWWsRutWMlSBNnkbKWftYfWPPmRM
         BlLw==
X-Forwarded-Encrypted: i=1; AJvYcCXuvo43nPXKkdhW2wwdqLdWsdWIBZ5fYPxa9c0ILr71JSIQYiy2N/pfZGx0Ou0hMI1A8X0kAzjKTolVMZMUvMtI0GQtWx5/
X-Gm-Message-State: AOJu0YxAJcwiATG+LzYm/rh+CrONJa63F/N1IXZpMf5DnTAC2/W+9Qnr
	Lhc3WHOIlH0+h4Zn10pCrew+8Ejq9GFm9VGkDHr+4spdw9t/eucBPaZnb3KxJdc=
X-Google-Smtp-Source: AGHT+IFxuoH1u3s+z8926LZm/YZ5RdgFSqCp25qH5qnBFZdBYp5LX59i7Pz5oSTIpVl0xx9c1teMJg==
X-Received: by 2002:a17:902:ea0e:b0:1f2:fbc8:643c with SMTP id d9443c01a7336-1f6370f2847mr34412345ad.3.1717194702588;
        Fri, 31 May 2024 15:31:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235b41csm21517315ad.86.2024.05.31.15.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 15:31:42 -0700 (PDT)
Message-ID: <4a8783a2-3b93-448d-968f-861676299e51@kernel.dk>
Date: Fri, 31 May 2024 16:31:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] io_uring: Introduce IORING_OP_LISTEN
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240531211211.12628-1-krisman@suse.de>
 <20240531211211.12628-6-krisman@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240531211211.12628-6-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 3:12 PM, Gabriel Krisman Bertazi wrote:
> @@ -1761,6 +1766,31 @@ int io_bind(struct io_kiocb *req, unsigned int issue_flags)
>  	return 0;
>  }
>  
> +int io_listen_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_listen *listen = io_kiocb_to_cmd(req, struct io_listen);
> +
> +	if (sqe->addr || sqe->buf_index || sqe->rw_flags || sqe->splice_fd_in || sqe->addr2)
> +		return -EINVAL;
> +
> +	listen->backlog = READ_ONCE(sqe->len);
> +
> +	return 0;
> +}

Extra empty line.

> +
> +int io_listen(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_listen *listen = io_kiocb_to_cmd(req, struct io_listen);
> +	int ret;
> +
> +	ret = __sys_listen_socket(sock_from_file(req->file), listen->backlog);
> +	if (ret < 0)
> +		req_set_fail(req);
> +	io_req_set_res(req, ret, 0);
> +
> +	return 0;
> +}

Extra empty line.

Outside of that, looks good!

-- 
Jens Axboe


