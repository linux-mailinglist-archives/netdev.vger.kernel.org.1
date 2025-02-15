Return-Path: <netdev+bounces-166703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE137A36FF8
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647AA188F0D3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D51C84A6;
	Sat, 15 Feb 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYfzPJPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E914A088;
	Sat, 15 Feb 2025 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641600; cv=none; b=R1zrOJ635KKjvF/WHPdS/aiO8dE50H73TXF1oTx9LujZVhIRbySblDyy6uyJmkqtCq603zuvDzFcW93u56zkqqK2AFl6cE1afNHhvrK4aJZllkXsgPFdtjbLWeY1+gxMNJkz864rD7BiJ7WAXrTJzorEbThZXjXF6LKh84xyidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641600; c=relaxed/simple;
	bh=WjadOVTzSUypm8vNDZN3BI44/qP4aaYEig0yxCVO9Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX6JfJgZ5ysOVPVcJXJl3YxGKvakdrXT1DOwXS7RxNtb18MyjdlbVqkzc5cavyqvDBG2RjVwqyE4RFRkqxj08MmQY2V+VSGnH0bk0vANZQ65wUNkt0LJj0BO9nfDM0I3ZLvgzhLa0lp3M5Ig6NUz2YvJ7MrLNKWO6RSVv6WCtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYfzPJPS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so32662255e9.0;
        Sat, 15 Feb 2025 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739641597; x=1740246397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x3CIi8IFxn62XpCTyGbHRWv/jED83r0QF7lQwgFJf8=;
        b=mYfzPJPSfZNJKQuKTam9sovmRw4ceJjF1ITodpKZvbjbnQRUHjiAoUnPh0ausSkQeZ
         kwVfwuaz0QRYp+YieDki7JodMAWuFh8MwQVK1UaoC6CxBYWXftGTzOr/ctE/HGG2rIIB
         tuE7TdTOjP2Zj3bxxK80kfHLM9YsRAE8nQMOOHUbeYsyLLr1PUjUAnW2kvDcXhvO3oBw
         poFD0Bf97rGyvviWBhF2rzHNdkByIHd0Jtzwah29FeZWrnKC5vCNadAvkRJPY+xBxJGI
         DT9yWGsNqAWkrayMslm5gZhDVAH7puLkXStr9bKJyYll6lN3aN8VMn0u5tFnUH4uPIU4
         ocAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739641597; x=1740246397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x3CIi8IFxn62XpCTyGbHRWv/jED83r0QF7lQwgFJf8=;
        b=wjJiQkimJ+MNGzUYBIGq7vfazXZZjrH+v/GzdRMu3qz0eCsiGBGaVO62CylhG7pXCT
         2Dtm5xynfyAEX6kk8JMXKNo2H88iHbrgc+/b2n/PX/P0WVj8s7Pcnk5lt3Q03dzhQX3m
         LGHBae1H/5liZfeyEMw4HDYUMVKvDK0oXOdAVMc+8BzmBXF21xdzl59qEcbkSzX3xGql
         rGV2rt0PPVy1RrNkabrC4RQkdIgOBm5vLhZSYfNI24q4kFxeSQYj5Aen0t+ZW//UIopI
         Bl7OBwqtScZuWpC7LvMfjUjA4tSxrkTLseiGInhfwMkN4yvoLWpfvliP++22vutiOC4X
         O6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFXUvbgXUp8Va+r5Y9cn/RW951DR1+PiJeUvbtpN3t8oksWccuMsfgZa7oNaHi9dml2R09eL08@vger.kernel.org, AJvYcCWpVb+4E6L9Fwc9XX4x3rwhmrDpYJBA9v4NHEf0YbUACzpP2yFp7fzWGpI9aJk6GyQdvewR9uvli8+gIT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3bYXG2rVHmfpJ/mBTtNwn3a/H7R1urFqTzgaYyFuFtOwSza7
	ZXdA4opCjNEeOdhfmAIBetzM5c79KPApIc90Q9t45Isw0z2xl/XY
X-Gm-Gg: ASbGncu4fvvUJ25IS0oEtr7kaYaCL3D7oiRpPm+Pp6kLj3NCrLZ7MQV9XnafiCLDG08
	W+NqiK3xLLxbpZScNCNbQy14As2nDApzFNzF+8gzKsxmGOzylv/GUMhTsZ2WQBy4vqG5q7D+5Ol
	ejfT8JqouYWCMFrazGg5vqt0+26jGlePvdtulttTkqdkce3qPdQEph7U0Bq1ehaH7hzxZ+SVa8m
	jkBxJ+arepi5F9PFAyWFEYmcgD6w8na0CPy3e3kQf+8eWIAuf1V3lQysItv6RmQZP23OLwStWdn
	LIcNjVJR33LsMisOzrjoq4HaYTAYx8bvosTHSe4nFXfIU2JRII1OiQ==
X-Google-Smtp-Source: AGHT+IEcA/C1oomCV1lkEYj7YNjBHIqdeXnaw68zT19Z+G3RUI8njcMQypDKqfQoRAF9GL8fA8/S/A==
X-Received: by 2002:a05:600c:5254:b0:439:38a1:e49 with SMTP id 5b1f17b1804b1-4396e6d7c38mr45477115e9.6.1739641596922;
        Sat, 15 Feb 2025 09:46:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm7563164f8f.89.2025.02.15.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 09:46:36 -0800 (PST)
Date: Sat, 15 Feb 2025 17:46:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 nick.child@ibm.com, jacob.e.keller@intel.com
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large
 buffers
Message-ID: <20250215174635.3640fb28@pumpkin>
In-Reply-To: <20250215174039.20fbbc42@pumpkin>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
	<20250214162436.241359-2-nnac123@linux.ibm.com>
	<20250215163612.GR1615191@kernel.org>
	<20250215174039.20fbbc42@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 17:40:39 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Sat, 15 Feb 2025 16:36:12 +0000
> Simon Horman <horms@kernel.org> wrote:
> 
> > + David Laight
> > 
> > On Fri, Feb 14, 2025 at 10:24:34AM -0600, Nick Child wrote:  
> > > Define for_each_line_in_hex_dump which loops over a buffer and calls
> > > hex_dump_to_buffer for each segment in the buffer. This allows the
> > > caller to decide what to do with the resulting string and is not
> > > limited by a specific printing format like print_hex_dump.
> > > 
> > > Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> > > ---
> > >  include/linux/printk.h | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index 4217a9f412b2..559d4bfe0645 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -755,6 +755,27 @@ enum {
> > >  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > >  			      int groupsize, char *linebuf, size_t linebuflen,
> > >  			      bool ascii);
> > > +/**
> > > + * for_each_line_in_hex_dump - iterate over buffer, converting into hex ASCII
> > > + * @i: offset in @buff
> > > + * @rowsize: number of bytes to print per line; must be 16 or 32
> > > + * @linebuf: where to put the converted data
> > > + * @linebuflen: total size of @linebuf, including space for terminating NUL
> > > + *		IOW >= (@rowsize * 2) + ((@rowsize - 1 / @groupsize)) + 1
> > > + * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
> > > + * @buf: data blob to dump
> > > + * @len: number of bytes in the @buf
> > > + */
> > > + #define for_each_line_in_hex_dump(i, rowsize, linebuf, linebuflen, groupsize, \
> > > +				   buf, len) \
> > > +	for ((i) = 0;							\
> > > +	     (i) < (len) &&						\
> > > +	     hex_dump_to_buffer((unsigned char *)(buf) + (i),		\
> > > +				min((len) - (i), rowsize),		\
> > > +				(rowsize), (groupsize), (linebuf),	\
> > > +				(linebuflen), false);			\
> > > +	     (i) += (rowsize) == 16 || (rowsize) == 32 ? (rowsize) : 16	\  
> > > +	    )
> > >  #ifdef CONFIG_PRINTK
> > >  extern void print_hex_dump(const char *level, const char *prefix_str,
> > >  			   int prefix_type, int rowsize, int groupsize,    
> > 
> > Hi Nick,
> > 
> > When compiling with gcc 7.5.0 (old, but still supported AFAIK) on x86_64
> > with patch 2/3 (and 1/3) applied I see this:
> > 
> >   CC      lib/hexdump.o
> > In file included from <command-line>:0:0:
> > lib/hexdump.c: In function 'print_hex_dump':
> > ././include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_11' declared with attribute error: min((len) - (i), rowsize) signedness error  
> ...
> > Highlighting the min line in the macro for context, it looks like this:
> > 
> > 	min((len) - (i), rowsize)
> > 
> > And in this case the types involved are:
> > 
> > 	size_t len
> > 	int i
> > 	int rowsize  
> 
> Yep, that should fail for all versions of gcc.
> Both 'i' and 'rowsize' should be unsigned types.
> In fact all three can be 'unsigned int'.

Thinking a bit more.
If the compiler can determine that 'rowsize >= 0' then the test will pass.
More modern compilers do better value tracking so that might be enough
to stop the compiler 'bleating'.

	David

> 
> 	David
> 
> > 
> > This is not a proposal, but I made a quick hack changing they type of rowsize
> > to size_t and the problem goes away. So I guess it is the type missmatch
> > between the two arguments to min that needs to be resolved somehow.
> > 
> > 
> > FWIIW, you should be able to reproduce this problem fairly easily using
> > the toolchain here:
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/7.5.0/  
> 


