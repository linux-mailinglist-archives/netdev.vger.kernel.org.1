Return-Path: <netdev+bounces-166700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C1A36FE3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F791884B44
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5D18BC26;
	Sat, 15 Feb 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgCqzs9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45638194C61;
	Sat, 15 Feb 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641246; cv=none; b=GGt7Cunu5hhtBCnyAMc2mvqCZcW2vMGIX7GO0tkmd2otRocRK2J14nFcRKzdxv7QzB2oc3Y7pizskrGqoMTddjoa+kqp5h281VwGAMsAenKfveDlUou+SE0GrCshcR357VoX53urb70C6E8k9m8vdJc5xzPYZB49JjKyl23v84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641246; c=relaxed/simple;
	bh=+lMjellQGsbIcsXbTiBgckBJ0FyvOKecMYK9OM7YrXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAaXdlAP5jGBmCxNX4Bx7An8gy2qJxUu1AEuOZFdUiqhcixpvdX0K123fYJFIGPN6J+qeME1Zkai4FSnWfa7V83Bqu+FZ0yIZvyZN6w/v7R1amb9AgNbc4X2xwr8nbP3BxKt1mvb+7McG2ZAOuxo73FbLG1dHRwY+n2ENcjEoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgCqzs9s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f378498b0so365871f8f.0;
        Sat, 15 Feb 2025 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739641242; x=1740246042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbb2sdvqLOtMLeS2goruY5LH07tm6exBOweNHZ6JKLk=;
        b=JgCqzs9sUZuTEYub3Gxpp9RqWUaYJDGCTdcf0GoYOuO+YK0VtotI1OQRSSipzJynt+
         8gwHxwKPPJpJasrDIOaEe2RCH7uevlHihEA5DIGsd2y1h6/XjWiX4Ez8fXy2j9gD+cTH
         1+hyV2txkN9maunxPuClhm7TIEobMn/P57KyKYI/dneSmK6e1g/La/2PkirPKfGc2P+0
         i13lQjebrGq1hJtwGOY6wQPvWhYVc6k4i9wlPuntEsWKPfzxoKEz+5bDLwo7Ifd0XWkf
         4QjnZfHTMpbERrIRrY4XqgNTA1hUjDg6eYuB26/ngmi+g49EcYlaZBX8OiMgdU/43zpf
         xMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739641242; x=1740246042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbb2sdvqLOtMLeS2goruY5LH07tm6exBOweNHZ6JKLk=;
        b=Wq/IRx0rKAhTmBOFxwbRFC8//ZfYsQDFVxhlSpjb3h74hhWqLo48PlYTUXq26SskpT
         CFhaJnCBkoABtucGcXLmzCmnThCD6JWYIAWG074rv4SDJ5Tw8VQUWvIw7Z7uNsc1BGzn
         3RsIoGacmBIhpzjcu5HIIhbaK0UTs28ab4a0YaV45lBYWK8ireSYJ8/ysNLbvATPPbE0
         LDeBbom+t0zhypfSlE9eU7OfNb7SX1l0zUBFcgKWxP6RMbDVnvg16ZSUuwOsYMUQNER8
         fODM2mnG99JUFhmZ07BaOqxCefpALmO2/sGtliTjEZr3+cOp/iCwQL29jPcCEVNSghLe
         OJeg==
X-Forwarded-Encrypted: i=1; AJvYcCX4Mqg/7IK1TbLBV+5lLBL0HGiUXnQu85y+nobX7i5kc1Tfsuhb5UnOM5KTWx/0M1H/tXo092Ub@vger.kernel.org, AJvYcCXQHqNA/Zg5kwcLY866gcmVjGsl/6KUl0uPsNSHyU7VLV89R23UvnBzIA1wesP/PIyMYaVZ/EKx2w5QLzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRyAKKUmFwfGo2y7h6IR8ib/ClPRbDLxgNZGLlG0lZ+cjwoki
	muvBM8qB6eGYxyAXvgVgFQcCSXGp04gn8qH/Tdad+Z31TJajjZaW
X-Gm-Gg: ASbGncudchoNDFoMtkPf6OXIeIOnFwmMspYD+QkyAAJ9yiOZoX1LtXQVRIo2zxi6BeT
	FJVjNXpBLz4i6iOOSMrq+98K9I9VDgYyGfxSxCUdEqjtIJDa0Q8yd0tEYuXV6AiNgTkTAEOQsid
	Vaj804626WUt/RYFvBefSuE/0WvAi7gLvlda4FV8UHECXfHF41D5xUSM6VtjD+at7c04C8/B/0X
	jep+l5p9izDypK6m6iipVIs7JPptrl+zABNpJPFh0hEtReHOMKPLVcVY04Fh2YrHk1ZyGnF/CHB
	tzc6RpwgEqKMaiKZOhovefyYVV75b/PR+4Y2GAKCEerbxvlzuI656A==
X-Google-Smtp-Source: AGHT+IFRd32qYtzPmRq89XAZYOuaCa4urAkpcpUkaxr6U4cgz1K0JLTT1gnN3Ql6e4Dw2hXNISt7qQ==
X-Received: by 2002:a5d:610e:0:b0:38d:e481:c680 with SMTP id ffacd0b85a97d-38f33f29144mr3638585f8f.18.1739641242056;
        Sat, 15 Feb 2025 09:40:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm25456105e9.0.2025.02.15.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 09:40:41 -0800 (PST)
Date: Sat, 15 Feb 2025 17:40:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 nick.child@ibm.com, jacob.e.keller@intel.com
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large
 buffers
Message-ID: <20250215174039.20fbbc42@pumpkin>
In-Reply-To: <20250215163612.GR1615191@kernel.org>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
	<20250214162436.241359-2-nnac123@linux.ibm.com>
	<20250215163612.GR1615191@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 16:36:12 +0000
Simon Horman <horms@kernel.org> wrote:

> + David Laight
> 
> On Fri, Feb 14, 2025 at 10:24:34AM -0600, Nick Child wrote:
> > Define for_each_line_in_hex_dump which loops over a buffer and calls
> > hex_dump_to_buffer for each segment in the buffer. This allows the
> > caller to decide what to do with the resulting string and is not
> > limited by a specific printing format like print_hex_dump.
> > 
> > Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> > ---
> >  include/linux/printk.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 4217a9f412b2..559d4bfe0645 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -755,6 +755,27 @@ enum {
> >  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> >  			      int groupsize, char *linebuf, size_t linebuflen,
> >  			      bool ascii);
> > +/**
> > + * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
> > + * @i: offset in @buff
> > + * @rowsize: number of bytes to print per line; must be 16 or 32
> > + * @linebuf: where to put the converted data
> > + * @linebuflen: total size of @linebuf, including space for terminating NUL
> > + *		IOW >= (@rowsize * 2) + ((@rowsize - 1 / @groupsize)) + 1
> > + * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
> > + * @buf: data blob to dump
> > + * @len: number of bytes in the @buf
> > + */
> > + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> > +				   buf, len) \
> > +	for ((i) = 0;							\
> > +	     (i) < (len) &&						\
> > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > +				min((len) - (i), rowsize),		\
> > +				(rowsize), (groupsize), (linebuf),	\
> > +				(linebuflen), false);			\
> > +	     (i) += (rowsize) == 16 || (rowsize) == 32 ? (rowsize) : 16	\

WTF?
I'm not sure why there is a restriction on 'rowsize' by that increment
makes no sense at all.

> > +	    )
> >  #ifdef CONFIG_PRINTK
> >  extern void print_hex_dump(const char *level, const char *prefix_str,
> >  			   int prefix_type, int rowsize, int groupsize,  
> 
> Hi Nick,
> 
> When compiling with gcc 7.5.0 (old, but still supported AFAIK) on x86_64
> with patch 2/3 (and 1/3) applied I see this:
> 
>   CC      lib/hexdump.o
> In file included from <command-line>:0:0:
> lib/hexdump.c: In function 'print_hex_dump':
> ././include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_11' declared with attribute error: min((len) - (i), rowsize) signedness error
...
> Highlighting the min line in the macro for context, it looks like this:
> 
> 	min((len) - (i), rowsize)
> 
> And in this case the types involved are:
> 
> 	size_t len
> 	int i
> 	int rowsize

Yep, that should fail for all versions of gcc.
Both 'i' and 'rowsize' should be unsigned types.
In fact all three can be 'unsigned int'.

	David

> 
> This is not a proposal, but I made a quick hack changing they type of rowsize
> to size_t and the problem goes away. So I guess it is the type missmatch
> between the two arguments to min that needs to be resolved somehow.
> 
> 
> FWIIW, you should be able to reproduce this problem fairly easily using
> the toolchain here:
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/7.5.0/


