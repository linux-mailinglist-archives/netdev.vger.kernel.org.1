Return-Path: <netdev+bounces-99862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896008D6C80
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 00:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDCE1C26214
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADA7EEF5;
	Fri, 31 May 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uuXcwyhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAD1CAA6
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194658; cv=none; b=CUa6wHmp9jNSAfBjylkKaB7rjg0FvHbTi/vbFv8DOUe0+doSyqeV3KNHUFJUGurGHDZKUGL5qlAPKNQvRUxXsl3rYcdBncuFPJ3dgeaQtot3ys8NFmHfZcUGOjc44iVrMrbs1mRM+PZqj2Sy31xz47Q6/J5B4+Dqc+7qD94ToBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194658; c=relaxed/simple;
	bh=3qfcBjt1CAJXE0ms4ESzqfpoWXTVAMwJS5hhQO/l2q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grekM+u3W57r5lLIfm1oepP2Lct1iUMq4Mw7jcvzIm1rHE/f69clkhyO7G3gok0dXouk715mWriIXuKvOpU839XJ2ZyQAhgBXYTCEn/ED9HV9Xo+B7BTF+QlMEHAnpHFkxUW4ofRTGralAQPL42yEYEmjErnQE/VSFoONXBFH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uuXcwyhe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7022c872aa1so54782b3a.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717194656; x=1717799456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBquctFApHSLduXxKNFvAQ62YyJOYniQ90Vk+ErTq3A=;
        b=uuXcwyhe/uSdVaGbqEY+QilylwTvHV4D7Q4a7sk9bj8SgwPOgtrXOv26kUsYXNy/ul
         n6KuhbbEs+4bRqs/rinmJly2GBR7hXL0Y3b8yWkJQLzuarPgKxK4Vn2qIlMgATND4a8N
         pEzfv3aGEgPv24MvPKLCIAjbWHEituJDdqoK1NCQ4USG0vuK3X94sSV2tOJ4Lyd0heBT
         r0eWAnnvY1ouOY0R0B9yv2umOlU1Qd/y9aeWiVmBZzR/kY8BcZm6+19mmrTDrkhqIPLq
         E26r/CqjbAJnYfddlYhaHY+JVsdueOrt6wiV3Q59gxa0fxsw184V1936Ok/Vd0PHqL5w
         ReIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717194656; x=1717799456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBquctFApHSLduXxKNFvAQ62YyJOYniQ90Vk+ErTq3A=;
        b=tgrdtDUUd9sf0Pe4V7XxTKj68y2MwGYb3Hb5kDFAFPaL4cLnmaDms7+FUrG+VFTu7i
         Ic+dLrzDyvf+GvEZ6NHUki8u8gd4/K7QSMiMoqklioE+GzFke4SHVb1H3/EbUQxSMlGR
         oxsPT4Qn7QZo4KN65yId0U4ekcYOhyLasjzutk1CFhUyofkNrRDJY5+R/h8LIAvNTCRi
         Ckew/HDEVNhLsWyyqP32izqis2D1sZcQTAKFX7T1r7R1ZPAM2YqeolsOBbIXJOaSheaR
         CMEiGbWpHRS7+WWqMuthAP9VzS096VqgbiuPfyQ+wn5SdCWmhtZJt/ogNZ2qhylaTmfC
         XXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYCdf8aP8UbTck2b9ncSzNNQvZsY4eQv9ZPntlUqiADt4OW+Rf6FPjwpLo+jioQE6OD1fWo6ZSiHxzE7+dpIUMSvWVGUdO
X-Gm-Message-State: AOJu0YwiY2qHG6Htis22hEfyXHhqR/MsbqlZWCbsG6l+uQyu0zD6PlCc
	3WO6dPtwczuY88wDf2e12Hftky6NHE8hvaviCWcQSS+oC3Pk9ZYBABQmo1NPqWw=
X-Google-Smtp-Source: AGHT+IEQ1gUzY28XMmDof7hwAUEtQJp8aSnhKAfEiyQo0il7hiDMcnExiVj5f+ty6z30BlZMcSPfMA==
X-Received: by 2002:a62:e116:0:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-70247899e76mr3226431b3a.2.1717194655840;
        Fri, 31 May 2024 15:30:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702516d1fe9sm666670b3a.165.2024.05.31.15.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 15:30:55 -0700 (PDT)
Message-ID: <b7c714ae-6406-4661-a653-ef1888118d92@kernel.dk>
Date: Fri, 31 May 2024 16:30:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] io_uring: Introduce IORING_OP_BIND
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240531211211.12628-1-krisman@suse.de>
 <20240531211211.12628-5-krisman@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240531211211.12628-5-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 3:12 PM, Gabriel Krisman Bertazi wrote:
> +int io_bind_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{
> +	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
> +	struct sockaddr __user *uaddr;
> +	struct io_async_msghdr *io;
> +	int ret;
> +
> +	if (sqe->len || sqe->buf_index || sqe->rw_flags || sqe->splice_fd_in)
> +		return -EINVAL;
> +
> +	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
> +	bind->addr_len =  READ_ONCE(sqe->addr2);
> +
> +	io = io_msg_alloc_async(req);
> +	if (unlikely(!io))
> +		return -ENOMEM;
> +
> +	ret = move_addr_to_kernel(uaddr, bind->addr_len, &io->addr);
> +	if (ret)
> +		io_req_msg_cleanup(req, 0);
> +	return ret;
> +}

As mentioned in the other patch, I think this can just be:

	return move_addr_to_kernel(uaddr, bind->addr_len, &io->addr);
}

and have normal cleanup take care of it.

> +int io_bind(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
> +	struct io_async_msghdr *io = req->async_data;
> +	int ret;
> +
> +	ret = __sys_bind_socket(sock_from_file(req->file),  &io->addr, bind->addr_len);
> +	if (ret < 0)
> +		req_set_fail(req);
> +	io_req_set_res(req, ret, 0);
> +
> +	return 0;
> +}

Kill the empty line before return.

Outside of those minor nits, patch looks good!

-- 
Jens Axboe


