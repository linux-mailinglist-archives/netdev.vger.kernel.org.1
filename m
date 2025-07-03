Return-Path: <netdev+bounces-203714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641DAF6D95
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273CB1895F6E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7528D8F4;
	Thu,  3 Jul 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eu54ptmv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326A2D3727
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532528; cv=none; b=DRIcS6mmHVGgZCIA4SnflZJCBa4INI5vpMpB9X0pCDINpW0wJKKvVh69JxZqeGrwHHtzr1UkB4ibSmT6bwVbfbuZ7XC2mo/pHLcgRHGIKW8Y4RJnT9UdOZh9IleoTxwl7d9nMSnQ2RfaqahL9n2K3odrKGEG48eoUdi0ITp72aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532528; c=relaxed/simple;
	bh=/RTepCs0dztAoAhV3cYzw3AFqbONWKbO7CPOvH6DzM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCQKsfnFJj9YdUGDs1C5nFfkPs1n9QALD3Ar+jen3eyslX5Ddk4eMPH5WCH1WJtET2vOlJM8yeLsWFwl5sacfUupl2kepfsrOO0DpXHmVuwdXyyFafJcgTu4ZIOdZC8I6h5TjXMVVL/yH/mvkQ+mxOMrhgMWSOJdkAmpP+HP5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eu54ptmv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751532525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5A+/MxsYcbYH1goxrESZ9WwNmbDxLlkxrFPCFIvbec=;
	b=eu54ptmv0VqWxIsGYKI9bryHz0HC7RYSsVssPF4LxfgIitkUvjmvMfAHWi1jzWO5U2Ny29
	GTvPSs3yE3C+GfprR+6nlUjerUBsVTYkzyR4sTMQ1x0uFRhHQ0iGL0+eC75vI03aqOOFMQ
	qMgVqRY3oGxnuBSC3vYL0XR8kk0KGUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-jRBswKCyN8KDzoe-KDHVSQ-1; Thu, 03 Jul 2025 04:48:44 -0400
X-MC-Unique: jRBswKCyN8KDzoe-KDHVSQ-1
X-Mimecast-MFC-AGG-ID: jRBswKCyN8KDzoe-KDHVSQ_1751532523
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so3835092f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751532523; x=1752137323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5A+/MxsYcbYH1goxrESZ9WwNmbDxLlkxrFPCFIvbec=;
        b=r0k04yPzNz/7O45BiJrJImqgB8B9jx4ZvsSzUc9t7OGxdS2KwbWJMaqU/s15c8+46N
         RZlIGAKBa+qhN1rTQcwE8CmpJYx735JtascT5xstYBtPPgPZ/r96gKXHxX5axMi/CfBc
         KIRnVoJbC8dB88ZPPITx9rGY9O7TQ3VPFMNUMB06j3teCCC4pSyVWjtp6MS8v0rBbhYc
         clB7UXv36Rvmxs3sECLEl2EKUButXbf1ujYhxplmmkQQxMDBxAiyVJufGkHjtbPxBOp5
         3ekRfGxG06wNq8bTSWhYVtKy9luR6B5wVBHsyngFdxREPLccTiGKDtJRQQnqhEs5YiLy
         Xwxg==
X-Forwarded-Encrypted: i=1; AJvYcCVIXbYU+Z3c9WaXq7a9yX5H9I3cNQxx/9b1D0Czh/tupjIsyTLdjhRijLU1MHEJNjuaRnaOqG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tnASFwHAzgcSMRvY+o94TnlXNo17nhO2tgZXbPSEAm4Mk9u0
	bK/VpPzJIBHE7SLC1G4V15x1qaW6nw4p1uo5MSzoxx0PxxlVJbtE3ZpJlA7wYkPy8qYYmYDQazc
	A/vTYWbcaq3OPG2oNG3+zRsPHgzk2uiEYS3l16ikEzPKvTsc8iEqY6rdqKw==
X-Gm-Gg: ASbGncvToD910+hXB/4EFAJ0HDOKxnk0IbfXU8Msf6EOGlhx3aAn/FvknU3nQQnDtGd
	TBt5oMkBSaAP/jjKONDgvLyWjfaWf36uQ+iO/2YWIRXDwoWWFr1Rtq4oD1XjUQcZK0sONlom7q0
	ROEWwMyIc0L+puIswK8ePMyyU1ab+sYNN7TfcbE6SvEhpEl5u0yS4jGRBE1uzMDkyIDQ9kDaA0q
	9t97Oj7X321krYwFldaCbDizfRRJASqTIS8YyCXpAHjWHfm0qWQ4bkIJkjjmZXYjy5obEYrsj1v
	UTH9B4ZO4Uf2xIXjMU9dt5R1/7NEI7d4sVJoLjZDOltlbf/vSFiD5bB6ViCP+iLDeZA=
X-Received: by 2002:a05:6000:1ac9:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3b1fe1e69b5mr5343063f8f.23.1751532523287;
        Thu, 03 Jul 2025 01:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwJWsJ9Bcq221tnNZUrZgPxYaGKS2ioIMyKtLjbCKUp7n/zy8XxkU4Y6rahZ2XUyogggC6pg==
X-Received: by 2002:a05:6000:1ac9:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3b1fe1e69b5mr5343032f8f.23.1751532522882;
        Thu, 03 Jul 2025 01:48:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a999c632sm20422205e9.23.2025.07.03.01.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:48:42 -0700 (PDT)
Message-ID: <e7275f92-5107-48d2-9a47-435b73c62ef4@redhat.com>
Date: Thu, 3 Jul 2025 10:48:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet
 transmission
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, willemb@google.com,
 almasrymina@google.com, kerneljasonxing@gmail.com, ebiggers@google.com,
 asml.silence@gmail.com, aleksander.lobakin@intel.com, stfomichev@gmail.com,
 david.laight.linux@gmail.com
Cc: yangfeng@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630071029.76482-1-yangfeng59949@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250630071029.76482-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 9:10 AM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> The "MSG_MORE" flag is added to improve the transmission performance of large packets.
> The improvement is more significant for TCP, while there is a slight enhancement for UDP.

I'm sorry for the conflicting input, but i fear we can't do this for
UDP: unconditionally changing the wire packet layout may break the
application, and or at very least incur in unexpected fragmentation issues.

/P


