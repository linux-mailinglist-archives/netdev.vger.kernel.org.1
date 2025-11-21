Return-Path: <netdev+bounces-240763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F219C791ED
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB76135911A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66C345CA2;
	Fri, 21 Nov 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/QMZl9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FF2459C6
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730173; cv=none; b=n0JPvz7iQ249mhPtE6Ccrgxlw4WYi2k1Fpt5LEW5RHOjPEl+YkuqMRjO1AtsQiVHC0VtUpTcAArj4DwbuBRN/1pAJw0jsIN3YpWa7Ofx1yFEPEFqFv5p0oXPXoXkG8yYF7CF/Bf4zq+XEw9PsJvo42yvMUWV/Srg4q34K1EIayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730173; c=relaxed/simple;
	bh=J1sxZerVx4LRZu0MxMnZWpDHNosS86+OSOr1kLRBwM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxSSOpztGzRAGcLtSRGUnECaNJjUAMcdop1sk2i85abSkKddllMpolh4MGgUURQUJxBVph3czBz9YahDFaUrf7CwmYWhcSDOi6ItvDrqbsPOJnBaCa7oFse7q8+CtO7lzjMCX6P4Lltg9/XgFQRX5aoEh0/XWWatGJvOv37Z6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/QMZl9S; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso9519245e9.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763730167; x=1764334967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+karDUIwaluMCQfDCqIqXlR93Ss9N56UP9ZbbJblk6I=;
        b=b/QMZl9SE326qcHee6Oe+yDe/0hEzLuxg0NHt0ZwFIL4lvgD0Zc5GhMXn23hJJfekL
         QcLkv6y7hdAolxzBBSUGaY42RtW8W5sqRdIrnxqLiN46/xrjT38Ji68d3RcnxfsCdEX6
         cM1txrMc7jybwEWQgYu2IgR+DdGamkg6xXpyqyijOHcIP5Q1FzjHHiizvDmKuxNKaYqe
         drcE0AERfMpOHUlpRqywY5W0McD2KkL/LtZ+2JNtI7Pd9cPmVaIwHMkL5N2OHycWGNRw
         jtgVmxZkDyYmIEESB5b1tvkZTczWYq6x8wUukyqvRkHf9BuqsX+6L/X10vFrqVrmmY73
         uTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730167; x=1764334967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+karDUIwaluMCQfDCqIqXlR93Ss9N56UP9ZbbJblk6I=;
        b=ZpC906EZ1UPX+1uZwxil85fb+y7FAeO5BwzaXC0SS+4xwH531/xHaYqrzlTeye/dcS
         oXOJYjIlZDs/cbUnEC7NEcRUBJDTY3JKb53cmE2z3UTukYcR2Ju7eDjKhIkv3T0OP+5t
         EVCcmtkbQTiFnfDIXrQbkPXTgtascJYpjaL9OvJ/nwbsVzsv6ZGcuwoU34yK7ggSbxFu
         soc1iNH4ZBqzuPb/Xb4jAkeQ9Fra7ZuDR9pqWFW/iVZuGFSXQM6pd++SNa0karQImkF0
         zHvvC0VJllgJKmmDlzThNpLBAyRM3UXV08IN6QGU2vxWs7ZW5Re6rgZVOhIKLwCmWXuB
         /2wg==
X-Forwarded-Encrypted: i=1; AJvYcCVapIj73tpecW3gsyNRqBgolgn2G2/biJhxlR6UJTEr5eLhjvNvh3QgHUHWZpttsrOSMbl2xUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrokxRSfJ2a67vQH322+4z/+Og873/RC3IDRyU1BKG3wduR9qn
	9CG3LIjmbGSFqUfM+mwZZAFaI93aNUnYnsZDWPPEi3Bl82fw7BA5P1t1
X-Gm-Gg: ASbGncv78XNjXP5nj2zAx+Xjkauzmg/p4ZPLSeMvvlcZobgY+wafCPb4VgGQzIXXGgA
	ltVGzGbMkM3u82a7jMXa5n36BN63rMJhcY9cfF4TmqmZ8LKGyyKpaXVizBFTawZ7VrruHKun1xa
	hHebAdm4LiWCuJTcgt35vYtvhX13qAqLCUC83r0iJrvpWeT9Z1gif9lUJVm2rVrDRWaPOBIXVuJ
	bd5BfH4uejaQXgMa9SXpYIwWblTek21qommkFiWd11RGkSE1yf5a5ddaspijmbEjUPo+QI3XdSO
	ZR6+sgFGHngNFWOCTM46IzDIm5hlGf7jwy/uHxd+SgToNU+I3QmKN98HukVyC3oIRwHYqS6L3IZ
	H9BqctyBW6+FO0HUwCENojuCsBBtlINkdluvGdfVJ04r+eGSY+CG1GcmK32vpVKo6w3qgmc3b50
	84E52luSvKeMHcethE4niGFcXtjaSrXYm1lXTJgHrseCs=
X-Google-Smtp-Source: AGHT+IG0dHMzWmFJj/rAQgcaWfg4AOgSKobtzdJcmRQ7G8ZljQW4t5jDW4Xt3mXuEOEmi28tMC7DZA==
X-Received: by 2002:a05:600c:a07:b0:477:a3d1:aafb with SMTP id 5b1f17b1804b1-477c115c657mr22920655e9.29.1763730166896;
        Fri, 21 Nov 2025 05:02:46 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:813d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf36d1fasm41153185e9.7.2025.11.21.05.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 05:02:46 -0800 (PST)
Message-ID: <72e3ecdf-343e-4d1b-9886-67d48372a06e@gmail.com>
Date: Fri, 21 Nov 2025 13:02:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netmem, io_uring/zcrx: access pp fields
 through @desc in net_iov
To: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, hawk@kernel.org,
 andrew+netdev@lunn.ch, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ziy@nvidia.com,
 willy@infradead.org, toke@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 axboe@kernel.dk, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, almasrymina@google.com, sdf@fomichev.me, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com, shivajikant@google.com,
 io-uring@vger.kernel.org
References: <20251121040047.71921-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251121040047.71921-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 04:00, Byungchul Park wrote:
> Convert all the legacy code directly accessing the pp fields in net_iov
> to access them through @desc in net_iov.

Byungchul, that was already converted in the appropriate tree.

-- 
Pavel Begunkov


