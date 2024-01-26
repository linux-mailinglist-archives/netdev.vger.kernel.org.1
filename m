Return-Path: <netdev+bounces-66180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B283DBD8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 15:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16770286410
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C21C292;
	Fri, 26 Jan 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IPN3Vmgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564D1DA5F
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279216; cv=none; b=p3ezHFLFWfVJCMsua3a+ubQaHaBngjhQkUqDVmXm6dzWBGIPPqdWmFzLuA8wiOxVtaLWypJ8Jw5BYLw1cDWNvcLTEbp1tPCz5l44K5EXP4S9FP439S5SslPmdStqPMTQjSc56gem/kkFYPr4AmWG58qpO17UoqLBDo1P8G+eXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279216; c=relaxed/simple;
	bh=YCc6ONVSeSNQSZLatwUTnBnC6jIB6ACKH4ri1JOaoKw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=C+t0El5ubo1I9HvkT0H+6TIGblQeHVoRX7IAlmmmQvfgxcZRVDJ/fjDeIW5qf+ZPqMQKQfjLj1P6WUDjy5Clrh22FFHG+xYTY17vWhPaukQmzVA3e/9S+vxg+wyAyHHYNCPtzTjBQN/KS3ak6J8wsDlQrW6PbbF/Yu9Xd6hnmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IPN3Vmgg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso41089966b.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706279213; x=1706884013; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=LvS7W28TvHz2+piZFZajPw6ZIOOV30KfvoRicEtswVc=;
        b=IPN3VmggAqm+DMZr5+uc0c9aXcnh+BaBu87EeygkFvu2zpg8oT6TkxE+MeRihMWmHu
         I7dOb9iw/giI01yuoGT1kjjs4JRrn/e5e2gCHDykWi+yiY1wZZ5CpAaW1r6+w1pc/f7K
         IOjWDBc7/ltIa/S0dBOB2QZC6jRpksC+mj8U1BJaP1RbSQpCfSWZ5stqFm3OpFpLeT0y
         noXtzs7LFLA3tm/JCAw9fEbK7KsYLm0LCNS5DdwjTLrenLtMMjIundvF+fqOWRn8jyoq
         E4eiNGOe0n7YA5dxCt0CbrXVCSWIZKUcdyrJJZwL4MFzsUIBhZSTz5RUXym9s3Vc5Zmv
         vvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279213; x=1706884013;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvS7W28TvHz2+piZFZajPw6ZIOOV30KfvoRicEtswVc=;
        b=qMwSf9zTdmTC72HXrZsZ5QD61gsPc4ISsfy+ib2EGkI8Q2Sr+CypPe2zZaLlCjMVDc
         Jx4r83XP3yX7tEwYJ8mq4JFYgKb7q+sECZODN6GQXIf0St1mwU/C0r/8DDppC4Q1hmA+
         kdCuyOUCevJeQ0adjQsVeRe3eCOrvXKzgKCbyuN9IdtDmVNuDxp7xWR9ZbTmNZRNeCqd
         M9abDQKvSqBtWyl9EcGc6E00D6HR8K6M+ulKLodvrZD6lq6khcYEfnZbVDcm6EuhhzrW
         KIyyaemdfIwE+kIBqivWmBII5NQKSUo3G1JZeHblwQlxWY7tc7hr+GblvPjh91leGYtz
         xyOw==
X-Gm-Message-State: AOJu0YzVdPD/kxQcCR73XxzO69bzFLkwMEBRHOw3btAsjbNHJF5bDhQZ
	diVAwgtOSVYBmq5j+2xQuYwLhF2EsoGHgrHXaOCRL+GniMdYaBVbkYuFmCu8ZwQ=
X-Google-Smtp-Source: AGHT+IEFkwdt2yXICfh0THGT1uyxnLDrK352Z2SmVQe7FXcxsH5j1WlvyLmMhabzqEKFLKcDJsA4Sw==
X-Received: by 2002:a17:906:e2cd:b0:a30:d361:406e with SMTP id gr13-20020a170906e2cd00b00a30d361406emr880148ejb.76.1706279213139;
        Fri, 26 Jan 2024 06:26:53 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a2])
        by smtp.gmail.com with ESMTPSA id cw6-20020a170907160600b00a2d5e914392sm682812ejd.110.2024.01.26.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:26:52 -0800 (PST)
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-3-john.fastabend@gmail.com>
 <87zfwse0ln.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: sockmap, add a sendmsg test so we
 can check that path
Date: Fri, 26 Jan 2024 15:24:53 +0100
In-reply-to: <87zfwse0ln.fsf@cloudflare.com>
Message-ID: <87sf2kdvbo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 26, 2024 at 01:17 PM +01, Jakub Sitnicki wrote:
> On Wed, Jan 24, 2024 at 10:54 AM -08, John Fastabend wrote:

[...]

>> @@ -92,6 +136,15 @@ static void test_sockmap_pop(void)
>>  	/* Pop from end */
>>  	pop_simple_send(&opts, POP_END, 5);
>>  
>> +	/* Empty pop from start of sendmsg */
>> +	pop_complex_send(&opts, 0, 0);
>> +	/* Pop from start of sendmsg */
>> +	pop_complex_send(&opts, 0, 10);
>> +	/* Pop from middle of sendmsg */
>> +	pop_complex_send(&opts, 100, 10);
>> +	/* Pop from end of sendmsg */
>> +	pop_complex_send(&opts, 394, 10);
>
> Isn't the start offset here past the end? 15*26=390?

Plus terminating null bytes. Nevermind. I can't count.

