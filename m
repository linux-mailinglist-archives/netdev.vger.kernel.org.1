Return-Path: <netdev+bounces-186707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2BAA073A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1100162747
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10322C178A;
	Tue, 29 Apr 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWge+nkg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8602C10B8
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918856; cv=none; b=fW7MGqHGsSdOywaWWsi9pn1ZGdBLf5k/lhnWr/8owQRCKRhfT9KP2N7C0JY4JLrZwMHwSvsNQCEykdWP2DyRJKnVjrpK3Ngt0mpaNj0pYUzZBpLxUXpPzILAkdNhs+bRvfPbA7v9hHb7qAlJiffqgyqTjYmJNFxwmuvqy79qmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918856; c=relaxed/simple;
	bh=zhcUwB/H1Zn82PRA/kFf5APz8tWoAKyo3JSDuFxUvAg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MolH1mztSYezfJjpyn1euxw0jCa+RDw82qdNCdhzPe3hC8Od/CJ/yg65KJyxLT8Sm8xy7R7qPws3oq7v8l3u/eEcUNVMjugyjY9IFgyKcMQgyotPTCAah1AVeLMEaY3LTRCBHOof1xSg3TeGLMNJhHAYvF1OKTeG++f3r7xGrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWge+nkg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso56036805e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918853; x=1746523653; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmHIxCsT4bl1krFbpSUOp8sN3dLy2svTzTckaHaC//Y=;
        b=QWge+nkgQEfZuE0z8SGc/S6ceryGY75iA+WNZWtEUWPYJFBnp1IsviMs29q2y89Qls
         QKFgTD+eVMIktLGIN2pUVCoiWqH9du9rlW0iL7ZgtZpDiscjI3JQLexwzoQclEaSpJNB
         p3Vrn4OgQIxr9SW2jQTn4s5aD8etGix7iY63Y/nfwxp+Z0ZlGpyLAiaPhbCFEd7w5iU6
         Z6hJxZtq7lijSp8BNsQYfIr41yYI4hMSMFqGGBEpU2YAE2lm3/IpAkGkuXwZpdPthaqr
         /0b0Poic1OA19vPGGKRyYE/tOThVOW4l9tJXjYOvUNedhSDKYib4rJHFY47nURWgHII0
         ND3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918853; x=1746523653;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmHIxCsT4bl1krFbpSUOp8sN3dLy2svTzTckaHaC//Y=;
        b=kP6MMEBuovQpjhENauQ4K0cvuLBd3TvUGhNbwFDjHvVsMYmqJc5VPDzmoZ7WkT9BA9
         zf6RZ4blvkJcD/J6WqKPRhEP/GLakU9hOBSkL9tZ9jpIciblDSsfbHlUHWx6B3jxhRW5
         tBKrbxsX6ZKiT1z2NHuz5thRumf2ae9f1axZYJOy0EeTGLUzre/21lzbQGjikZNvsULP
         SVsmFBIY8PK4pSpbZkJ98VIuyk94kVkIaznnbijNlZzr4nPEtEdAvIND36Ba3A7qArYY
         CRYrM8M3rK6BMZBZm+KmEx7WCQYxvPUUPXxZ+b4MG/8EBUewUOn81Wdlkaylc8lZ8PMm
         kSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlhmSZ0umwL3G7ii0E6HRkcoZ/qiMUl2TNYdX5lfl5KVFmCi7MvVfGPC5yRZp5J+JoMtXTy6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWTd1DLqCb+AT1B2fRqQknuj9ORCMIFkodku5ccXj2zgFxx5z
	DSCBtlfpJbl5ZDUUuNa1VBLXWiSSw55c+JfVuq0WbDVePA9Vbku+
X-Gm-Gg: ASbGncu9Ehn2wyP0A9wVUpymEyFWqLyCkiQah5fdNcIoEuDaUWc3ysq6PmOdzxQ/31R
	+LAwsov6q+pbJxqFuFYiRPDBW0GkZUyNR6pq/owdLGXjVanTQBrDj7altUxMesaM0bmKpgrTXq3
	Ib381kw6MUFnUGJKDCqVZE1ySAL+YGksdK+ICynAtl9PblLJSoUcVi0Hiu9XJshquGmvFs6qnfH
	kkQsOF3jn6zGMttIcqvPdGxVp5NK3J1ubAoZ0zSprfk+KWR5NTaYdfQd2g02cfWrB70MAln3Fq5
	DlMRhRWVLxW/VT+crwHP9Pjz4VcsM/FG3O0SxA6ldhtp3Qa8JLsNfg==
X-Google-Smtp-Source: AGHT+IFQV7HbwZUzbld68TkoLFiK2CzcN4Z0hiVeqsZ8jBpViHyysPyfXqGwpZSHdSzgE3p5nIX1JQ==
X-Received: by 2002:a05:6000:1a88:b0:39c:1257:cc25 with SMTP id ffacd0b85a97d-3a07ab8a568mr10092739f8f.56.1745918853082;
        Tue, 29 Apr 2025 02:27:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e460b2sm13579764f8f.70.2025.04.29.02.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:32 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 11/12] tools: ynl-gen: don't init enum
 checks for classic netlink
In-Reply-To: <20250425024311.1589323-12-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:10 -0700")
Date: Fri, 25 Apr 2025 11:04:47 +0100
Message-ID: <m24iycr1z4.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-12-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> rt-link has a vlan-protocols enum with:
>
>    name: 8021q     value: 33024
>    name: 8021ad    value: 34984
>
> It's nice to have, since it converts the values to strings in Python.
> For C, however, the codegen is trying to use enums to generate strict
> policy checks. Parsing such sparse enums is not possible via policies.
>
> Since for classic netlink we don't support kernel codegen and policy
> generation - skip the auto-generation of checks from enums.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - move the comment about the skip before the if
> v1: https://lore.kernel.org/4b8339b7-9dc6-4231-a60f-0c9f6296358a@intel.com
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 46 ++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
>
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 2d185c7ea16c..eda9109243e2 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -357,26 +357,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          if 'byte-order' in attr:
>              self.byte_order_comment = f" /* {attr['byte-order']} */"
>  
> -        if 'enum' in self.attr:
> -            enum = self.family.consts[self.attr['enum']]
> -            low, high = enum.value_range()
> -            if 'min' not in self.checks:
> -                if low != 0 or self.type[0] == 's':
> -                    self.checks['min'] = low
> -            if 'max' not in self.checks:
> -                self.checks['max'] = high
> -
> -        if 'min' in self.checks and 'max' in self.checks:
> -            if self.get_limit('min') > self.get_limit('max'):
> -                raise Exception(f'Invalid limit for "{self.name}" min: {self.get_limit("min")} max: {self.get_limit("max")}')
> -            self.checks['range'] = True
> -
> -        low = min(self.get_limit('min', 0), self.get_limit('max', 0))
> -        high = max(self.get_limit('min', 0), self.get_limit('max', 0))
> -        if low < 0 and self.type[0] == 'u':
> -            raise Exception(f'Invalid limit for "{self.name}" negative limit for unsigned type')
> -        if low < -32768 or high > 32767:
> -            self.checks['full-range'] = True
> +        # Classic families have some funny enums, don't bother
> +        # computing checks we only need them for policy

grammar nit: computing checks, since we only need ...

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

