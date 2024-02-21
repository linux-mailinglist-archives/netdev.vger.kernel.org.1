Return-Path: <netdev+bounces-73571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D585D2C4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069631C224BC
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715E3C684;
	Wed, 21 Feb 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NtQq/3C6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF623A28E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505141; cv=none; b=Ri0jDURdZDk/jnNEeDS9erMrndJfJmGJZHQp09RxIzq5gNr7pzXqMd9XQe6NhyPhGr7fsyK/BziFQkk0G2LKCkVwDuuDN4NUZCTYyKIkO+fWSMTA+V8qqHy/EsXg2fGpeIpxgsr7tO6msSBEK9Kz68AjxMxga7LHS0mLQKLofQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505141; c=relaxed/simple;
	bh=MV7cCDhFf7qoSlKGh26KdQdQQeeDgNXi5QmZqdulyTo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=KQ1Ay2EU9UWGE8sPmazT71SRozIc9KfPR7fTypTYyBwrgNRD9cZJqyfN57oE8eznqdxpX5Vtm0E5zrSvnCaJ2Ur3+NJ5MVd/VnNIka/TLX2AC+fim5vXgWxg4b9R80KzVukbirYC+8JWslac/0TykDPWyxw1/Ya1Skh1lLuPllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NtQq/3C6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e4765c86eso458300866b.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1708505138; x=1709109938; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kZQ4OFhsxkDYgnz61RE7tAY18/3VcWGx+gq9WX1pJrw=;
        b=NtQq/3C6wLMRimvVMUBFuVsnz3LCYR0G3iNxhh/PW7OaevP+NarximxmQfN471VuHa
         HVMZKJ6CYvMmhmKQ22gsjbYj9mx2tJUuCkJcaCHiqLK0zD8M7WmgLYqH/ehzllq90juv
         i/lQ3/0tDQMDhSWd1T7b0LLBOr9LS15lrBLzJ+ZKI7lQ56ZeI2Br+e6hoKMyrtHCUcUr
         U+dv+UCxWxzJsK5vo8tW146Qaky01vcpVATM8Y0S/TKvPR3CWx6z29ANfGvnwBOuBJg5
         hxPa9Fqp1EPMIwhPJ7pIkTZ7Ar6TK2viNH30jdSbfTNcX/cxlO0snu5qi/WsrLhOPgAN
         LnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505138; x=1709109938;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZQ4OFhsxkDYgnz61RE7tAY18/3VcWGx+gq9WX1pJrw=;
        b=RUmubHBU0viRxKj6ilyrq2fzi6RmFowCpbKkM3QTzZalHgLKmRsHW3EBqyK4cMauK/
         uNm5HDERL7Fxgsvh1bJN6ATXe5VAEd17eMLR7hk6psJbXD9aHQnBVPcgImyAvC660UDT
         oW+NJqVjYV/PEY3ops+DsIz/x3Gc7SAZDOr1+tjj42f9bTs27myafBPBbZFT8MQR+elF
         /Zelf2OadrYPT5oFeCBGruMVbOqDquMr2DSgG7CcGtTvndGdp6j8+bVbcPbJIxzoAm9c
         0CL6L5mgHrCh7N5pIZuzu+2+qSsw51W2gq2if3Du98Yt40goImVmK0nUA8xWtK41ofJC
         f1lg==
X-Forwarded-Encrypted: i=1; AJvYcCWIpOfaAiZt/e7UuyEds4gcA2BI/T70Fa9DxqS4SwqMI4frhMwNoDFr5fKWizCE8EMrO5KrBe+tKqUNE0V5ZdNL/3D5Viz4
X-Gm-Message-State: AOJu0Yy7C5li5eZmqVt6BWfpreXNbJfRyluhbrXMrJfqLQ2GSORkefXh
	t6jqNpfqKERiwm93kKvMGrmlBe2sOpqyit9+rp67reTM3VK2U7iff1WBJp2NQ4s=
X-Google-Smtp-Source: AGHT+IEDaGKj6QcO81XW7tgCoQbWz+vDwzVQKdeoeHwxTbJSHX/2OJ8SZ7AO4OOsy2cb+xQgBAVwUQ==
X-Received: by 2002:a17:906:81d3:b0:a3e:c9f5:fbaa with SMTP id e19-20020a17090681d300b00a3ec9f5fbaamr5107340ejx.68.1708505138617;
        Wed, 21 Feb 2024 00:45:38 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:d4])
        by smtp.gmail.com with ESMTPSA id bh5-20020a170906a0c500b00a3ea6b5e4eesm2660862ejb.19.2024.02.21.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:45:38 -0800 (PST)
References: <20240115220803.1973440-1-vadfed@meta.com>
 <20240115220803.1973440-3-vadfed@meta.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 Victor Stewart <v@nametag.social>
Subject: Re: [PATCH bpf-next v8 3/3] selftests: bpf: crypto skcipher algo
 selftests
Date: Wed, 21 Feb 2024 09:43:46 +0100
In-reply-to: <20240115220803.1973440-3-vadfed@meta.com>
Message-ID: <87frxmmci7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 15, 2024 at 02:08 PM -08, Vadim Fedorenko wrote:
> Add simple tc hook selftests to show the way to work with new crypto
> BPF API. Some tricky dynptr initialization is used to provide empty iv
> dynptr. Simple AES-ECB algo is used to demonstrate encryption and
> decryption of fixed size buffers.
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> new file mode 100644
> index 000000000000..70bde9640651
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> @@ -0,0 +1,217 @@

[...]

> +static void deinit_afalg(void)
> +{
> +	if (tfmfd)
> +		close(tfmfd);
> +	if (opfd)
> +		close(opfd);
> +}

Did you mean tfmfd/opfd != -1?

[...]

