Return-Path: <netdev+bounces-218240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5323B3B9B8
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95ADC5824E9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F93112AB;
	Fri, 29 Aug 2025 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnJP03/O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C231159A
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465765; cv=none; b=bwfQlIWUtQb9wRsKkWNBk3jvUopMcT0w1Zb2MziUgpqo2nRFkVEIzZbEw6wygunKfzrf2Dz8/62mB9ACeqSgmIBSnFHrDQpFjWE/b+jBHRwn6L0T/pPWrkNqc/QDdGyKzjscV1N7LrronbUUPJoFrkEblA3HOREOLNDKuNsc1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465765; c=relaxed/simple;
	bh=OR8Qhc8SZ/LKIj5ZnfeBNDhRTk1TutKiORrUsjZb/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXTNuxArFNDW7nSW46nzBM0+mk0hner5J5KsgbIygyOFWZMwYA/dOijhl0sGEVjYREg8DPqy5XnFACbXgOFuYBi2j5VnI28WiNI2mox07HGtbxklVScBjahkU2WCR8eBElLSYquUUz5dUEnp76rbBL6VVPTtXNX2JUf9ITAfSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnJP03/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756465762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0iez2UuarMUyMFxIkAAF75NVnWvWftdOBoncIxQTaE=;
	b=OnJP03/OoQxrRgO4FQO6yqLaFZdHDnulIzV8eW+zdEEFlXsPObktRiefB7FD8+9/RCgJle
	nmyXih9F3zFj2/eBufJBWwQSBC1AlcfXPga3QfZA6yN6oPAylNe6VLDeZnoG+g1vV4je5d
	e7R8upsO2T2izg7IXrmxAg7bLkLUJkE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-TWngT1_nPL2yP9RPCaLT1w-1; Fri, 29 Aug 2025 07:09:20 -0400
X-MC-Unique: TWngT1_nPL2yP9RPCaLT1w-1
X-Mimecast-MFC-AGG-ID: TWngT1_nPL2yP9RPCaLT1w_1756465760
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so12387105e9.3
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 04:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465759; x=1757070559;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0iez2UuarMUyMFxIkAAF75NVnWvWftdOBoncIxQTaE=;
        b=sPW1yAfGBDT3pXCgs9hW4alb0gSQNqg0JTMsBimhPNnLbO3l5wR5OcE6gdqIEi3sBq
         YzRgC8E6JYPTUjem3c7bDCkyP+6bLGDmXkWS4zEnBFYSjjjdkeTyXWonhCju9o8Jo9+/
         QbCWd3vTTpTVT/gaB9144RYatRP1yVwdXoIB7SN2zZ96U+TXXpwjZ8IbpXkC43DQkxKU
         WINIrkZsKC8TU/GoZ7tYhYMwCh9632sBXcqwHpyGzgIjMUp3w4jxprSyhnx2HXxGyt2/
         98wGPJoEIRg/u6pv++aOmEtYnVDQCwbYFA+kd4bTWX3Wpc1JVsrNZiPA3TU5Mkz6kvge
         0N5A==
X-Forwarded-Encrypted: i=1; AJvYcCWXgAbrfdses4kSqkurSD/lF5k1QKX49G7TvhVdXSvBIQ37e4GC+Ug9312RcP0TbXPUbFo0iH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxaar/3m/xpk+IrHp1QuWfQRGH5uIu1ySjNxP+rQ+OhxnaCpSF
	9XzsHLcBWA1OBqG4oIAqZzATzXBmBWdrheWkC49yFsPRRy+qv+huphg37FgpUv3mSRDV/v207AQ
	xCVcT7ZfR7hCwnph0TDiFmb+opMth3EL6D3dD6/cECseFLVBoNY4YTcWcZQBrL26GLQ==
X-Gm-Gg: ASbGnctQiMUISqOpzOdqYNlY+vBVy4lGdjQVv41slz8vwtegTSeRnJGgUfw22KzJSKs
	bd2PIj7oKOH68HRg2BuGKzSchBqscRiT+ewSQoOEAI5jr3Q70gIN5ddyuZQprK80gFm6rZ5N7d+
	sNgNns05mLnkJiqZlUqNe+LukjIrWa1No6hD0duA7slhDb1/jlU0eaGjpF0rLD1LWy6YPy/Yb94
	+g0OEtJMKWKnjEwwdLWowxXA/7gxV9/Nwd7yCQtFHcAkG5wK9UhkmsbUoHFGo5QoHQDCoaIpH6+
	16xcQYz1YmiNx0Z4+CE1ufK/+AvUa7KBrsP+r3SvF14bS3DcF6Q=
X-Received: by 2002:a5d:5f81:0:b0:3ce:f0a5:d586 with SMTP id ffacd0b85a97d-3cef0a5dc84mr2510224f8f.1.1756465758953;
        Fri, 29 Aug 2025 04:09:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHytPkJd7dGA3AF4A0okHAkQXYmvVvD67fKqlfFx6F2Inc+rjqrE7+sJMgfAsplAI9z+QTgGg==
X-Received: by 2002:a5d:5f81:0:b0:3ce:f0a5:d586 with SMTP id ffacd0b85a97d-3cef0a5dc84mr2510198f8f.1.1756465758388;
        Fri, 29 Aug 2025 04:09:18 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33bd7cebsm2965412f8f.40.2025.08.29.04.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:09:17 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:09:15 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Paul Wayper <pwayper@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 paulway@redhat.com, jbainbri@redhat.com
Subject: Re: [PATCH iproute2] ss: Don't pad the last (enabled) column
Message-ID: <20250829130915.52a1cc5a@elisabeth>
In-Reply-To: <20250826002237.19995-1-paulway@redhat.com>
References: <20250826002237.19995-1-paulway@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Here comes a detailed, but partial review.

It's partial because, as I mentioned on the v1 thread, I don't quite
grasp the issue you're facing yet, and I couldn't reproduce it.

On Tue, 26 Aug 2025 10:22:37 +1000
Paul Wayper <pwayper@redhat.com> wrote:

> ss will emit spaces on the right hand side of a left-justified, enabled
> column even if it's the last column.  In situations where one or more
> lines are very long - e.g. because of a large PROCESS field value - this
> causes a lot of excess output.
> 
> Firstly, calculate the last enabled column.  Then use this in the check
> for whether to emit trailing spaces on the last column.
> 
> Also name the 'EXT' column as 'Details' and mark it as disabled by
> default, enabled when the -e or --extended options are supplied.
> 
> Fixes: 59f46b7b5be86 ("ss: Introduce columns lightweight abstraction")
> Signed-off-by: Paul Wayper <paulway@redhat.com>
> ---
>  misc/ss.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/misc/ss.c b/misc/ss.c
> index 989e168ae35026249ccec0e2d4a3df07b0438c7b..1c576c1e5997ccbca448b6ed5af3d41d7867ba76 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -127,6 +127,8 @@ enum col_id {
>  	COL_MAX
>  };
>  
> +int LAST_COL = COL_MAX;

Uppercase identifiers are typically used for build-time constants
(#define directives). It would be good to have this one together with
all the other global variables (just after 'int oneline').

> +
>  enum col_align {
>  	ALIGN_LEFT,
>  	ALIGN_CENTER,
> @@ -151,8 +153,8 @@ static struct column columns[] = {
>  	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
>  	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
>  	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
> -	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
> -	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
> +	{ ALIGN_LEFT,	"Process",		" ",	0, 0, 0 },

This should be a separate patch with its own tag:

Fixes: 5883c6eba517 ("ss: show header for --processes/-p")

> +	{ ALIGN_LEFT,	"Details",		" ",	1, 0, 0 },

What does "Details" add? It's very different types of details, and
that's the reason why this column has no header.

>  };
>  
>  static struct column *current_field = columns;
> @@ -1079,6 +1081,22 @@ static void out(const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +static void check_last_column(void)

That's not what this function does. It looks for the last column and
sets a variable, so it could be called find_last_column() or
set_last_column_index(), for instance.

> +{
> +	/* Find the last non-disabled column and set LAST_COL. */

...and once the name is clear, this comment can go away.

> +	for (int i = COL_MAX - 1; i > 0; i--) {

While it's allowed in C99, in this file, variables are never declared in
loop headers.

You don't actually need 'i', you could directly use the variable of the
index you're calculating.

It's not entirely obvious why you would start from the right / last
column, it looks more intuitive to me to start from the left.

> +		if (!columns[i].disabled) {
> +			LAST_COL = i;
> +			return;

This assumes that, if a column is disabled, the previous one is always
the last column, which isn't correct. You could have COL_PROC disabled,
but COL_EXT enabled.

> +		}
> +	}
> +}
> +
> +static int field_is_last(struct column *f)
> +{
> +	return f - columns == LAST_COL;
> +}
> +
>  static int print_left_spacing(struct column *f, int stored, int printed)
>  {
>  	int s;
> @@ -1104,6 +1122,10 @@ static void print_right_spacing(struct column *f, int printed)
>  	if (!f->width || f->align == ALIGN_RIGHT)
>  		return;
>  
> +	/* Don't print trailing space if this is the last column. */
> +	if (field_is_last(f))
> +		return;

The caller, render(), already deals with this kind of considerations,
such as printing newlines if field_is_last(). It would be more natural
to *not* call print_right_spacing() right away.

> +
>  	s = f->width - printed;
>  	if (f->align == ALIGN_CENTER)
>  		s /= 2;
> @@ -1143,11 +1165,6 @@ static void field_flush(struct column *f)
>  	buffer.tail->end = buffer.cur->data;
>  }
>  
> -static int field_is_last(struct column *f)
> -{
> -	return f - columns == COL_MAX - 1;
> -}
> -
>  /* Get the next available token in the buffer starting from the current token */
>  static struct buf_token *buf_token_next(struct buf_token *cur)
>  {
> @@ -1316,6 +1333,9 @@ static void render(void)
>  	if (!buffer.head)
>  		return;
>  
> +	/* Find last non-disabled column */
> +	check_last_column();

You're calling this in render(), but other functions rely on
field_is_last(), and they might be called before render(), or without
render() being called at all.

Ideally, this should be set once the command line is processed, in
main(). See 'oneline', 'show_header', etc. Alternatively,
field_is_last() could just calculate the index of the last column
itself, it shouldn't be significantly more expensive than a subtraction.

That is, unless you want to have it for render() only, I'm not quite
sure about the intention at this point. But then there's no need for a
global variable.

> +
>  	token = (struct buf_token *)buffer.head->data;
>  
>  	/* Ensure end alignment of last token, it wasn't necessarily flushed */
> @@ -2452,12 +2472,12 @@ static void proc_ctx_print(struct sockstat *s)
>  		if (find_entry(s->ino, &buf,
>  				(show_proc_ctx & show_sock_ctx) ?
>  				PROC_SOCK_CTX : PROC_CTX) > 0) {
> -			out(" users:(%s)", buf);
> +			out("users:(%s)", buf);

Unrelated change.

>  			free(buf);
>  		}
>  	} else if (show_processes || show_threads) {
>  		if (find_entry(s->ino, &buf, USERS) > 0) {
> -			out(" users:(%s)", buf);
> +			out("users:(%s)", buf);

Unrelated change.

>  			free(buf);
>  		}
>  	}
> @@ -6241,6 +6261,10 @@ int main(int argc, char *argv[])
>  	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
>  		usage();
>  
> +	/* Details column normally disabled, enable if asked */

That should be obvious from variable names (it is for me), if it's not
names should be changed instead of adding a comment.

> +	if (show_details)
> +		columns[COL_EXT].disabled = 0;
> +
>  	if (!show_processes)
>  		columns[COL_PROC].disabled = 1;
>  

-- 
Stefano


