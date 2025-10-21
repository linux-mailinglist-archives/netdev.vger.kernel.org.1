Return-Path: <netdev+bounces-231363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D99BF7EDB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43ED94F5E98
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E034C126;
	Tue, 21 Oct 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RqF93lxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CA23BCE4
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068271; cv=none; b=KJ9NZt2IsWv8vJxnJi44KyEjA1t9/KiTHONsQY9kETCxWyj033YYtVZ3ooof1jGCrjE1DchOC+yl1/vApE9Pli2cjDniA6TckVm/Myrf9Bej6fKPZu10JiDhRio7wRlpS8LQI4I7RBEyl0eBerLu3ZK89oHrxKsIX68gI6l3HpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068271; c=relaxed/simple;
	bh=w9lLASQAb3MzFOmkR8MUQwtJkigXHJHfhdRGIS8U5uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imv+d8YgjOo5+GvR7c+85DvSXmXVl7muZhZ9VDczrqpWEphM/RVlu99yTidXFhqRGn0uYZvvXy4AOP0ONLytAna++gXT18DNB55MEkPynuxUlfQHpjEihxMklqrWHi1UwNBoMljdG8OixiOaHjarSYB4V2NSHO//FDvBwGw7jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RqF93lxt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4aed12cea3so987869366b.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761068266; x=1761673066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzP3NHmpVePzzX4Nk37cJRY8V/e1399mO4lbkZpYbsI=;
        b=RqF93lxtG6PghOL5VRLMk65VX6Pbpe4A3qwYxBD4FsmdNSxD2MG3438XNC7q7Prd4x
         PfMTiT6KkUnOfwlbhJZxwO7kgd3RmYC7VmjvtGjinffal4VIVv0um+cJA63V2pUugK19
         5epYaT7woeB3Mia1jq6ykvsWa3eof7AVCbQXlxs9Cza93/oKgQAPpRwwXaTRAyulGp7B
         YQU3PveRq6NXd3FYNIFGuRHGP+D8CfIHxpWgk4EnD5eavXD1VG+xrRB4bIQfzKhFeEz2
         4aiuJPzd1NElG3Sbs6e8ihGXkBpDG7nbOIpJMQe8er+Tssxkv5eT/ySZKU4CexXLrJuV
         iSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068266; x=1761673066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzP3NHmpVePzzX4Nk37cJRY8V/e1399mO4lbkZpYbsI=;
        b=vXiXOvBz3K/ij0YT7J1u7cCfRY5ZYoPDRtaTgKsBXafC6kvzduwIB7hXuvEbU2UObc
         ZEBskOTK39KMEkLfOCOSZNcJnZS6TkiU6yFvmBPBIHpwhnFWXGBf0wgwvT/AGEN1xyHI
         fNLKt9+UOYcVyXWhH9yb9g5gGw239COwip8l6UK/TECiEhq4u6b9cK/kQgGLJunn363a
         sUxBdo1XeFqPhOoo1bx5a3Rv3J7jDxlqHyFC8X6dBO10VJ7uWFutWsSuvSG6HkwUUrOM
         alokEgUbz4x0AX/rVUjsyZAeEglS65cJlJ6Ads0ZQBTsoN5ttmq0OHrTX+KiKTgToe7/
         UJaw==
X-Forwarded-Encrypted: i=1; AJvYcCXZBc/ZjrTN0OqvPMisSVpZvmjNvzQfz9o0sT3oWtiIIAw6DIhMXw4SzV8N4FMHgzjMd8OgeRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQr+9PKLYUeaJRYOlJG8cXePJqrN78Q8kJBd7rKt7cB7B9Zy1K
	aHqCJH9MwvesIxe2mbhyk047Mii3G1weSNLTsaBRhqIFFbjIwgW/KWdW
X-Gm-Gg: ASbGncsi4iSrrJlxqyiCxtQL7BPGTqWfzxKquzkXT2C44bU0HquUwz1/Danz8H/lD2B
	2tBjcCa/vtDeRejaIknG8c3NvcfiTErD6CJm0pFLlrGZdQlAVir3pb0wlSh+x2pm3wxBfpPgoPL
	GiSKM+kXREm8uyCz8pGLbVYJ8orevGKbyybGPoKbxSaPV50O7BRrszMvlr5+uAMbMyz7Y0inHks
	WTbSmB39ni8mCQv7LDrAjOWJmPS7hTayaaeMNQRKP+1x8lzMrbH84Aim1NhYo0NG7M8kYr5YHEC
	3SANgk80/v0uyWIg4OJRHm/39qGKL2i0BpXXiZpwOzl4CZ2Yu4lhWKLP8agwG1A5M+PGVB1+C77
	qFusF57nt7uilDC1W/QWUUAGiJgbnP6tvpwD3/MWXv/XmJUhP5eQJdLUoDaLw5jngW0lh430A+h
	IWPBgzVxw=
X-Google-Smtp-Source: AGHT+IE3bWO5VTrkecU9jvIu327KrROeLdwSscMAWS5uaEu1sOxAkVe3ftuURMlxB+jwqRZpHVyG5A==
X-Received: by 2002:a17:906:7316:b0:b54:981c:4072 with SMTP id a640c23a62f3a-b6472d5e88cmr1997955166b.11.1761068266270;
        Tue, 21 Oct 2025 10:37:46 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8971897sm1122485866b.37.2025.10.21.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:37:45 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 21 Oct 2025 20:36:38 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Message-ID: <7mgcwqzafkqheqmbvkdx6bfeugfkuqrgik6ipdoxy3rtvinkqq@uxwnz7243zec>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-3-zahari.doychev@linux.com>
 <20251020161639.7b1734c6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020161639.7b1734c6@kernel.org>

On Mon, Oct 20, 2025 at 04:16:39PM -0700, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 17:17:35 +0200 Zahari Doychev wrote:
> > The memory belonging to tx_buf and rx_buf in ynl_sock is not
> > initialized after allocation. This commit ensures the entire
> > allocated memory is set to zero.
> > 
> > When asan is enabled, uninitialized bytes may contain poison values.
> > This can cause failures e.g. when doing ynl_attr_put_str then poisoned
> > bytes appear after the null terminator. As a result, tc filter addition
> > may fail.
> 
> We add strings with the null-terminating char, AFAICT.
> Do you mean that the poison value appears in the padding?
> 

Yes, correct. The function nla_strcmp(...) does not match in this case as
the poison value appears in the padding after the null byte.

> > Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> > ---
> >  tools/net/ynl/lib/ynl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> > index 2bcd781111d7..16a4815d6a49 100644
> > --- a/tools/net/ynl/lib/ynl.c
> > +++ b/tools/net/ynl/lib/ynl.c
> > @@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
> >  	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
> >  	if (!ys)
> >  		return NULL;
> > -	memset(ys, 0, sizeof(*ys));
> > +	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
> 
> This is just clearing the buffer initially, it can be used for multiple
> requests. This change is no good as is.

I see. Should then the ynl_attr_put_str be changed to zero the padding
bytes or it is better to make sure the buffers are cleared for each
request?

Thanks

