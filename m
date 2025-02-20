Return-Path: <netdev+bounces-168306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C74A3E72C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8F019C155F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484A1EDA37;
	Thu, 20 Feb 2025 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QinSe5pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136A13AF2;
	Thu, 20 Feb 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088855; cv=none; b=naKhLBKMNVCr4WuvcVUdozl+v6EW+yzOyuIKxwqU0VVgWq6l7RKV9uw91eNe1sgRJMeZY1esOOLc/1jrEYU9CEZq2TGol1mJXJZljQIFms04WxlKx8nNJZed13ubAQtzswsCKKuIyp14QSt33OSd1pJfZR8IVn3Noq8JCSpWoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088855; c=relaxed/simple;
	bh=yjRPWIPSH0/ZfiBFEujssM3wT30uWem9dhrhF/w5bqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saJNgABIq/8dJLw7VHitMnvHrRaOjeGQUPbUo0YWx1kz+f6g4+yyEq+aYHL4ReBdeMK2h05NdBPIok+juQQZdYZK2UhRv6kNPp6pzWnMvGgAKx7eIsSuFb2WVvL7ykHDVzA6Ru07RagbvJHLuWmcRBUTe7XF8bYIe2LU+f2bXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QinSe5pB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso5554555e9.1;
        Thu, 20 Feb 2025 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740088852; x=1740693652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqjniC3cZcD9D5Ju1Y6mTlESb4i26WJZx+pPESiCTj4=;
        b=QinSe5pBY2mCrfINiP8/bdmYsJMUIpzDjIX1PDVBluc58FiCtfurwRcuVOAWGGR0V2
         Mway9NwrZiJ7QChh+CRZIbQyKw6uxNDamWVGRqcJnXpQVyY0PD27WWU6OnkHgEJ7WngT
         H6sD49wMNqvpyOKqFC4hGwc/YuafQjmlx51LgOmPdZaoDt2htI4PVHcXeVacUvhyU2t5
         uGLpc6e9gMA9jF+MXt1yemy7GUQEapqz9im/inh/kZeq80WLahJqN1LVdxSEdpJd/T86
         uJ6AWGoZeW5nU6baXTSqmgb7SJSUm3GftqvDv3SgVX1S5wG5N/zqD3yWTa2yoYco8HzK
         UijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088852; x=1740693652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqjniC3cZcD9D5Ju1Y6mTlESb4i26WJZx+pPESiCTj4=;
        b=QT3dBrAKRSTIuVTrsoip/RSesMlUh5osreQrgljhnbYn+AWmmSzc/j6K5mxMSTKFeR
         hWda6AzTGEPBR16j7TVuQV/+7JeXM0BKJQzwEFAvQZXujUcPoBm/dcOYsWzHgJG4Qqwq
         vIAzjWCKZ1MnqWPKJle2j8XVzlNu//XP45Ms9kKyFbnXeve30Tb8kUJrzpI3US9KIPmN
         gnHx6mh7ukHl8mbO0xTM43bIVOniqWe8Des4TTsZEkg70xzZHJLdLafQVO4EMLWewFNv
         ed5MFx1+WJRcKkEy44o4ZqFzcZDfp8rxDrWgManTTvdKFrEBn9zC3wgsWPFDpknXEEMw
         5GGw==
X-Forwarded-Encrypted: i=1; AJvYcCX6+cWrqmM8rZGZyfp3mrZgo6vHll2XdObIXS6dEV4gsljfwSSjoxDtFZSzC652/p6VTsl7D+CJQjuJ2yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdirK1/A2nFnB9oKEIMrpmOMvkt3tMnlEzqgxcImEbQqesx664
	+C+DeGRFbYqASd5x+0H7UD4CUOrOODsm2573gI4kypGKqsQAg/PE
X-Gm-Gg: ASbGnctvdChM9Q+1DoI/Ei0ApGHiyR1TIqub1H14N2ZpxAiqaG0h0xUOD3RH7fp9176
	f7HH7tK9hRkFMi5zSHzJ3hLSVNI8gTDlQ17WFhTU6uIdV5aEi3N6gO+7V74b0FutL/thDb3tFOE
	BDC1dJMow2Zra1N43xAlliSb3zxtfIVmeDZHpK2P4HoMndTVrmH8TENBNgBdSF2MFwFk4CSjtzP
	BkPwurEuEXjzXk+BBh0+gIY0HKDPuG7QUwO5EKzGRa3OwNAdfIgfBT1PtFJBnEEhSnOjLwDT2jx
	c/in1P7qI6RfPpyddfXpbX7GyQfnjQy7wTILQjtCW+s92ZwYytpYDw==
X-Google-Smtp-Source: AGHT+IE97314XrxMTH3aB6HCqVizpN0USbtb3cT5ECVSvNs5+u3D5LtnA+yNgy5p/vLjjXkyM51v6g==
X-Received: by 2002:a05:6000:1f8f:b0:38d:d603:ff46 with SMTP id ffacd0b85a97d-38f7078990amr375199f8f.14.1740088852071;
        Thu, 20 Feb 2025 14:00:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa38sm22049996f8f.98.2025.02.20.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:00:51 -0800 (PST)
Date: Thu, 20 Feb 2025 22:00:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <20250220220050.61aa504d@pumpkin>
In-Reply-To: <20250219211102.225324-2-nnac123@linux.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
	<20250219211102.225324-2-nnac123@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:11:00 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> Define for_each_line_in_hex_dump which loops over a buffer and calls
> hex_dump_to_buffer for each segment in the buffer. This allows the
> caller to decide what to do with the resulting string and is not
> limited by a specific printing format like print_hex_dump.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  include/linux/printk.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 4217a9f412b2..12e51b1cdca5 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -755,6 +755,26 @@ enum {
>  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
>  			      int groupsize, char *linebuf, size_t linebuflen,
>  			      bool ascii);
> +/**
> + * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
> + * @i: offset in @buff
> + * @rowsize: number of bytes to print per line; must be 16 or 32
> + * @linebuf: where to put the converted data
> + * @linebuflen: total size of @linebuf, including space for terminating NUL
> + *		IOW >= (@rowsize * 2) + ((@rowsize - 1 / @groupsize)) + 1
> + * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
> + * @buf: data blob to dump
> + * @len: number of bytes in the @buf
> + */
> + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> +				   buf, len) \
> +	for ((i) = 0;							\
> +	     (i) < (len) &&						\
> +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> +				(len) - (i), (rowsize), (groupsize),	\
> +				(linebuf), (linebuflen), false);	\

You can avoid the compiler actually checking the function result
it you try a bit harder - see below.

> +	     (i) += (rowsize) == 32 ? 32 : 16				\
> +	    )

If you are doing this as a #define you really shouldn't evaluate the
arguments more than once.
I'd also not add more code that relies on the perverse and pointless
code that enforces rowsize of 16 or 32.
Maybe document it, but there is no point changing the stride without
doing the equivalent change to the rowsize passed to hex_dump_to_buffer.

You could do:
#define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \
		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
	_offset += _rowsize )

(Assuming I've not mistyped it.)

As soon as 'ascii' gets replaced by 'flags' you'll need to pass it through.

	David


