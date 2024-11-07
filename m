Return-Path: <netdev+bounces-143084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A99C1169
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA081C21E24
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F721893F;
	Thu,  7 Nov 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6WDAP5x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817BC2170C2
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016697; cv=none; b=NINEKtogKkjRON+3+szxmL4IhT3oBBUxQdivSP57nxEW3WApW+fTIonc2cTXRLETqmBKcNE/kfiSXVPXQf6JXBR5/BQbKHTdKxtBJhU4tDE/di4yF+RM9gvTZIYYAn2a2+tr9Xuz9VAi+e7ehpcTsWbZhDGqJY6v9t2Bh9/HRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016697; c=relaxed/simple;
	bh=w7LuCUKhAlSmrS1esu0OQs9cG4s0Zn927CxWM/1sREg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QEnYGXPU702cAtl05w7t7vxVFrbH+rHcmWTsveXf5TPOptCsPZV5qpggCa24PLKDqRFF7oW0IfQjomke+eXow1f+KKyqsaErXZdN64nKb6DnKB9+M0WjLeuHJi9WfZv3cWUeQDL84kPZvZ7IjfnNchTEMxJrOpmjCfx5aco5/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6WDAP5x; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec86a67feso244343766b.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731016694; x=1731621494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igeLCosjgtVuGegz404yihoGIh526FmKMS784SHNGyQ=;
        b=G6WDAP5xMJ0MJmW7AwYb47K8MyR4SJ68oMAeAj8utFu//DOBDN00vqmI4cMfDydpkZ
         2WJ1ZL0eWSyr2qNfvDPT0Q7t8WeG+3Kpfx0r3x+mnyS1OYH5S3MJjfEQqwrr7RSocJ+6
         t9XHii2erDRDahv4CGfD4bMeYzfIXLOOLbvwB+Qw/6i1pAF4pRJNkLHjm5wbUaku1WVT
         ugx402b0Zo8CK+XcrTmVPpxz8RlL7s57viDyMg/D/y2ZbA28GJJNN7TZqhQptd2kJ8dc
         8SlQoJ+vz/IFWjBShGKD3lsjNfRvgKG+itB70lR3nFyeqz+72nPHzJYtw0Y+zbvwidWF
         TaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731016694; x=1731621494;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igeLCosjgtVuGegz404yihoGIh526FmKMS784SHNGyQ=;
        b=qMLZf7B8/m5i0kXZjFDtYudfG2yL9Bl7CwcWRokDsygf1ljkzuQvn6AtH7uzmnDdPv
         /WV53I1nLxnIqVT+qTxqULnBmhPMTOUNGjKZsKszfT++g4+8RMo8/3O09TnPj76u6Tbm
         H3Q6RDTj+yKzlKbaAKwsafVJttxIDLoKWm2oKL7SF9ublxKP25CTkDMlcgREc0vCNPWs
         VPLgZ9Qz6cp7g4tbBmmGz+SIiojnUzWTXTUGl2n6tQO4qisJ1ku/M7tdNpel6NSzchwO
         tbui3fOQWCHM97P91soZD8FByVrpxT80mS/jBzOKlNpaYZxYvlk+281vhcBTeWfvts7P
         0b+g==
X-Forwarded-Encrypted: i=1; AJvYcCWwc+/jio4pfF8aK3pX09k/oEDs2r3Yic0a4oRNjzWRL2rp5RAQ4FMgAU2rMNqiThZ+KFYDcFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2mT+vSEtab58zRTxJznh0f4CVyZfFEHC1jo3hBLKwTxM8awN
	kjnSXwf3TqbbFPg4uyIQRCmYQnHkeV9wq7zI4B6CS141HDjuMS/9Go6Zqg==
X-Google-Smtp-Source: AGHT+IHNDJxtGlgK/48XOhosAT0vx1xxapOqB5fhaJs+q0CKIrcBCS3t89NvUmrpgU7XS1BSFaaDQw==
X-Received: by 2002:a17:907:2d11:b0:a9a:161:8da4 with SMTP id a640c23a62f3a-a9ef004b241mr34569666b.55.1731016693505;
        Thu, 07 Nov 2024 13:58:13 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c55sm147063466b.130.2024.11.07.13.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 13:58:12 -0800 (PST)
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for
 Homa
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-2-ouster@cs.stanford.edu>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <174d72f1-6636-538a-72d2-fd20f9c4cbd0@gmail.com>
Date: Thu, 7 Nov 2024 21:58:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241028213541.1529-2-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 28/10/2024 21:35, John Ousterhout wrote:
> Note: for man pages, see the Homa Wiki at:
> https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
...
> +/**
> + * Holds either an IPv4 or IPv6 address (smaller and easier to use than
> + * sockaddr_storage).
> + */
> +union sockaddr_in_union {
> +	struct sockaddr sa;
> +	struct sockaddr_in in4;
> +	struct sockaddr_in6 in6;
> +};

Are there fundamental reasons why Homa can only run over IP and not
 other L3 networks?  Or performance measurements showing that the
 cost of using sockaddr_storage is excessive?
Otherwise, baking this into the uAPI seems unwise.

> +	/**
> +	 * @error_addr: the address of the peer is stored here when available.
> +	 * This field is different from the msg_name field in struct msghdr
> +	 * in that the msg_name field isn't set after errors. This field will
> +	 * always be set when peer information is available, which includes
> +	 * some error cases.
> +	 */
> +	union sockaddr_in_union peer_addr;

Member name (peer_addr) doesn't match the kerneldoc (@error_addr).

> +int     homa_send(int sockfd, const void *message_buf,
> +		  size_t length, const union sockaddr_in_union *dest_addr,
> +		  uint64_t *id, uint64_t completion_cookie);
> +int     homa_sendv(int sockfd, const struct iovec *iov,
> +		   int iovcnt, const union sockaddr_in_union *dest_addr,
> +		   uint64_t *id, uint64_t completion_cookie);
> +ssize_t homa_reply(int sockfd, const void *message_buf,
> +		   size_t length, const union sockaddr_in_union *dest_addr,
> +		   uint64_t id);
> +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> +		    int iovcnt, const union sockaddr_in_union *dest_addr,
> +		    uint64_t id);

I don't think these belong in here.  They seem to be userland
 library functions which wrap the sendmsg syscall, and as far as
 I can tell the definitions corresponding to these prototypes do
 not appear in the patch series.

