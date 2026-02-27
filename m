Return-Path: <netdev+bounces-261953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNzVJ0LwoWnYxQQAu9opvQ
	(envelope-from <netdev+bounces-261953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:28:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D951BCC70
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F233170610
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1D3A1D1A;
	Fri, 27 Feb 2026 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZPUUQQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AF3D3CF5
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220218; cv=none; b=KL5dxy6D2f6uO+fQKY86qQUcK04jMihabkl7jVq+Tu2bWDZ1S8mSfMkpfVhm+82ZxK5WgS6sLZx8dpe+OaJd7E+WMUauVRgP6pXGx5/vd46PUk3fnkMlYUhmYw2LlrglH1tW8C5amZc26muyIXj7gb23PmTblQTaGKAD4dOdjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220218; c=relaxed/simple;
	bh=Zditj/NKbpDW7loNEhrU3UvwmWRbTfwGW7sPkf+pGIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IORcVkXAMu0xXjsqLID5dNVVvZx130pNm+RKOf14XI7ODF2GYNEtTMlt1GH+kKnx7HOjdux5hCk7i6NKF+Kr4KwU07c5dcOE6bR7R60VwlXd2aJ5dY3wllHd3ISYINkUC9FACTReONv2fi3tFjHx4cEwHrdojnZPCksaN9kWPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZPUUQQO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4837907f535so21191445e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220215; x=1772825015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5JwpZF9m73sgumtyMO1FvtEY+3qgUA9OtLlw1eJ9H8=;
        b=MZPUUQQOYNFmpgTrO+2JjOqDncRMgT4hMZslkK9hjP6XeHOL6hX5OHw+Tm1vOhiZGX
         q9dY2WeAU1Y8Oitfsz+5EyFvJW3zyMJi5+UzdlLUb5OJEjvbwBfvqnFkJX/awDJMu0jI
         rHbdT3fqjH+/SVy6ExHqMJZ62PBPV2UKvE4CBbyNWY3EjR48OC2Eb6puPIcWyeJounx5
         oxdWxa40/bFzYOOV7epmQJFhIM9TGQRdqaLqDU1DXIGW+/XQyioI80r+45vFHHR5GSdS
         QW2wiYLRgwVDsR7Co6nGG730hkmSol2Gv7twNv5CYeqjd0AYDpgWgFk+pgOPGuygDmVJ
         /PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220215; x=1772825015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5JwpZF9m73sgumtyMO1FvtEY+3qgUA9OtLlw1eJ9H8=;
        b=nmBqXPt/fG2Uxli366UafIiOz33QU5FNWrM2Q+sA0CCvDTATAA+cHQ99FJXGfo5op2
         0WbCF90jcKdKFPgvXNHYY+HLfah9qjcQF8KRKCHkP31sOKo9r3aIov0DICQUcPDfmdVI
         fr7T7ZxrMePyhle1vT9XpPVuooyhNq8OY6yAw4q9dkkBeZZl57Df8IzK3Y4JczDEBREU
         QH9e4aGRjy70KSnrA813pFrUedQOi3VeLMc+8KfRGP5rElLemp4IZyhQu072ZUmBFC9b
         GrR0N3C84q3ihruGa1dhCmlYomQH21c00/Sp/QqCyqutndUiAg4JdkKENvScN+vz7MfV
         E4tA==
X-Forwarded-Encrypted: i=1; AJvYcCVxMq2qoLXzvnJN6SQQY55JeGWOJ8CLIGJgNjndGMSomMfP8vwCD8Z3Nemmi/7oxJIlvbS2ZUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KZv6QSXjWk3DHQSeqCLi9A2nFjz4Qjn8qfOgh6vRee0hJITp
	3yknt+bOyU4hOaivr8FjvF0j1pY36Kqf/Xo5UC/w0jG/X8q6HiQCIG68UCp8yw==
X-Gm-Gg: ATEYQzyb1RUtdVPCcnXjgEUGJAqQ9cSBJI9EuKnKRRvX2IellIRJ9FRUGjHhsaCrE43
	qudhTmskKMQMHlAav5/zeQqrt8ZDXZde1mMeRFuMgmWts1knvd8bBXPG4efgST7mxFFaGtsRJTe
	eng0Ms9IfX4IXH1yqITCc2lkU5l9eqNwg9Cra9qJ4OPl1HqhsTGdxqFt8gG2if7cdY7WHjwai+Z
	/Zd4CMFlsavsTc7I486sELBY6prMUVWK1kfgnrKUbP/h7K5ZObR5QU+tNB18kcWPLXE+7merEoQ
	kZV01+qjnNx70+u0bzguDfNQXEWNtLnvma2lpNoHTJIvnUlanMFpemqfeCwwEGcA3tVwpeCQsjF
	jtKakRYhbYqcVPikgbD84OjUDtKxGOHIJrQOZUdMgD2QgErX2W2Xi3zf9H77yHhQDSQ0kKLWQ5v
	1P+dW5BqmYYwp6Gqhxk7BzdAnCMFVaVphFNEkQZMX5hTDy25us4SFPJA1GRjXlW28ukC1vZPhF0
	+1Z6St/iqJXw6W9fdgAGYP0w1FkKSt+VQtLCbkSJ1fDiTOvWlOQ2Pv7HjakECGU/0hnP0D5K/Va
	Zw==
X-Received: by 2002:a05:600c:1d1d:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-483c9bbbe50mr61606195e9.21.1772220214636;
        Fri, 27 Feb 2026 11:23:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfec1a5bsm81259685e9.29.2026.02.27.11.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 11:23:33 -0800 (PST)
Message-ID: <148610cd-e0df-4110-a752-b24610c83226@gmail.com>
Date: Fri, 27 Feb 2026 19:23:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iouring] io_uring/zcrx: don't set rx_page_size when not
 requested
To: Jakub Kicinski <kuba@kernel.org>, axboe@kernel.dk
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20260227170745.2845550-1-kuba@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260227170745.2845550-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41D951BCC70
X-Rspamd-Action: no action

On 2/27/26 17:07, Jakub Kicinski wrote:
> The rx_buf_len parameter was recently added to the Rx zero-copy
> implementation. The expectation is that when not set system will
> maintain previous behavior and use the default buffer size (PAGE_SIZE).
> 
> This works correctly at the iouring level, but we don't preserve
> the same "zero means default" semantics when registering the memory
> provider on the netdev. mp_param.rx_page_size is unconditionally
> set to PAGE_SIZE. This causes __net_mp_open_rxq() to check for
> QCFG_RX_PAGE_SIZE support in the driver, and return -EOPNOTSUPP
> for drivers that don't advertise it -- even though the user never
> asked for large buffers.
> 
> Only set mp_param.rx_page_size when rx_buf_len was explicitly provided,
> so that the default page size path works on all zcrx-capable drivers.
> mlx5 and fbnic only support 4kB pages in the current release.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Jens, can you take it into io_uring-7.0?

-- 
Pavel Begunkov


