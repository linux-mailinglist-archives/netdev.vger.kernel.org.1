Return-Path: <netdev+bounces-168798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F264CA40BB8
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 22:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A4C16CB29
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27520125B;
	Sat, 22 Feb 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6g+hzxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18378F4E;
	Sat, 22 Feb 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259648; cv=none; b=bmU2IjClrs3m/zDw6K/eh0HDK0fy5iY4bh2U6rzk4Xm5b4R/MDl2iHFA/Us/1+kXip6pn7mEGY9FiUG0DOV1y/9BqLO9juR7IP+wYfxLHdakCpUsY5qDNSS/aBISNDQQ8dW2/M4A7maO5D4aG3UCUYnw/L1oKGha2xWaggFeK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259648; c=relaxed/simple;
	bh=HnWBOw/QY2fTfYTDn9OY1S4zp2jsVEiYSMCUMn+aT+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZ95kpMe01kAEOhugtaUDCMzjZw/KVi0aPH2SUFnaEoU3cXLHA4BdNKT4iLpmn2JTEvdwvrs3De60w0NclDKH25k2CG1sp1oE0Yh+c01zhZrz08y6RvMbm9H+DEgRrFmDkpVaUu+f321nwsW7vYPTpm5JvIjQbS5A+56AjMnLoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6g+hzxv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f3486062eso2776081f8f.0;
        Sat, 22 Feb 2025 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740259645; x=1740864445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIyZqct4dbR7282FQbD+mjFPTLurG9NzJyoBOEIO9Hs=;
        b=S6g+hzxvVjTY+rqX01ZkDy3dUinr+15Ky2Koz3bVrP5wL9fVDVWkp0SuqLC55+/mDF
         EX35X/xvk0GXfWO5/qfLeUBi1ei/j7kzx8wiAaivMDB1gl7S9MMWxZ+UIBnVse6HFFub
         ARxVCeSxPkXPFuqF1/rOrpkvT4SrHJTG33k4WVHKoq5aVbSi0VXT8HjbxAoe8P1xxeuF
         QQ7xsB8c6wBcizj/iciBuz4/Bs4CrqLPsqeLQiN2JG3ZNTXhj+Zn/ruv9112iwc4crnb
         RXJb5XX1LPrFxjdWaR914S70qeVb1vRmcXh7gvRuftSjUztfBhz/F6YLNlFdzjncu+j0
         Zf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740259645; x=1740864445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIyZqct4dbR7282FQbD+mjFPTLurG9NzJyoBOEIO9Hs=;
        b=nmbsXmGZZ6Cx4A48HPSPuf9n6c3rpct0Owa13BZKns8zj9pmNBpftvtVzUX8KFguok
         3mJTnDJF+LJztVC7cUWBmcUmuB+lZyDx9g8SHlJ+H4gwRsYPyBwuiULEM/IPnltJdhf0
         fiCOuP3FNfpti8nlOe0MCSDtCYWusIdd5j7wJQux1ikHYOqFCLVghgbQn43wz0e9PSpj
         LfN4Mkl3+E0q4ZBtAX0+1UWz+aFy3v80KZrUw3eKGpglkzmpj3yX43ixcwEIbes0dj1L
         46lAgDLpMdfJAAnaN6eIgXdzIAsOq29ezQi5Lg37LV8unkSNkj84IJhqSmKelR5JVmo5
         Fz7w==
X-Forwarded-Encrypted: i=1; AJvYcCXbEs7ZcP62w+AY6v2y3XOaJBt1S5VOJcDqDjSVXMoFyYBgBggnDRE+QDWtM3bpYKJ12KtwFomnPItkNf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwUf+XNZaITiCyYhr4CzIbk3tBQJHDNuUVYIhyUhF7zKQSQ2c
	+nWVzFiMhkoMBPk21Kb96un32n7WMemeBxITU9+K0WS6fbYMrdtwM5PdAw==
X-Gm-Gg: ASbGnct3+D0iyc54580lXvrmqgqOfapVZi8H28c9BUtBZEZaMXyp51zo8oxMtVVILEy
	BJzMO8kymRO05U1Uy15hlJdj047vEQWBvuqPV8WbZfXN/4Rkw+SFg9BEklg31N2zus3TFtLKMc7
	Z6/wkwDJEzPHOm1T1LbZx3jxvPZBffecyaeAw/5o5+kYxyjSQ+4XRWfP/CJbIksk2AYLmTi8V/9
	XuBAUV/Um4R4fctpS+Y+B64St42vyrljC9kasSTS7PCTZFqLyOdky0LvnzqdfQU+gGi5CvN6lcX
	jBGSm5fHW92+aC3qSm/rLv3bas7F6P1aDZgo3J6/2CVnD1r+D829ZU2x9m2fVc05
X-Google-Smtp-Source: AGHT+IFSxpKxu8CO66ihEeidKT1wivDUlJpVub6/WwFcVib8ByHwq+d5wiakyUZoodnjNdR5YejPNg==
X-Received: by 2002:a5d:59a7:0:b0:38f:3d10:6ab7 with SMTP id ffacd0b85a97d-38f6e97880cmr7792054f8f.23.1740259644580;
        Sat, 22 Feb 2025 13:27:24 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbb2sm26744591f8f.40.2025.02.22.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 13:27:24 -0800 (PST)
Date: Sat, 22 Feb 2025 21:27:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <20250222212723.4db1e0c7@pumpkin>
In-Reply-To: <Z7oeaHxXnwrlA_d9@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
	<20250219211102.225324-2-nnac123@linux.ibm.com>
	<20250220220050.61aa504d@pumpkin>
	<Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
	<20250221180435.4bbf8c8f@pumpkin>
	<Z7jLE-GKWPPn-cBT@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
	<20250221221815.53455e22@pumpkin>
	<Z7oeaHxXnwrlA_d9@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 12:58:48 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> On Fri, Feb 21, 2025 at 10:18:15PM +0000, David Laight wrote:
> > On Fri, 21 Feb 2025 12:50:59 -0600
> > Nick Child <nnac123@linux.ibm.com> wrote:
> >   
> > > On Fri, Feb 21, 2025 at 06:04:35PM +0000, David Laight wrote:  
> > > > On Fri, 21 Feb 2025 11:37:46 -0600
> > > > Nick Child <nnac123@linux.ibm.com> wrote:    
> > > > > On Thu, Feb 20, 2025 at 10:00:50PM +0000, David Laight wrote:    
> > > > > > You could do:
> > > > > > #define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
> > > > > > for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
> > > > > > 	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \    
> > > >           ^ needs to be buf_offset.
> > > >     
> > > > > > 		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
> > > > > > 	_offset += _rowsize )
> > > > > > 
> > > > > > (Assuming I've not mistyped it.)
> > > > > >       
> > > > >
> > > > > Trying to understand the reasoning for declaring new tmp variables;
> > > > > Is this to prevent the values from changing in the body of the loop?    
> > > >
> > > > No, it is to prevent side-effects happening more than once.
> > > > Think about what would happen if someone passed 'foo -= 4' for len.
> > > >    
> > > 
> > > If we are protecting against those cases then linebuf, linebuflen,
> > > groupsize and ascii should also be stored into tmp variables since they
> > > are referenced in the loop conditional every iteration.
> > > At which point the loop becomes too messy IMO.
> > > Are any other for_each implementations taking these precautions?  
> > 
> > No, it only matters if they appear in the text expansion of the #define
> > more than once.  
> 
> But the operation is still executed more than once when the variable
> appears in the loop conditional. This still sounds like the same type
> of unexpected behaviour. For example, when I set groupsize = 1 then
> invoke for_each_line_in_hex_dump with groupsize *= 2 I get:
> [    4.688870][  T145] HD: 0100 0302 0504 0706 0908 0b0a 0d0c 0f0e
> [    4.688949][  T145] HD: 13121110 17161514 1b1a1918 1f1e1d1c
> [    4.688969][  T145] HD: 2726252423222120 2f2e2d2c2b2a2928
> [    4.688983][  T145] HD: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> Similarly if I run with buf: buf += 8:
> [    5.019031][  T149] HD: 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17
> [    5.019057][  T149] HD: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> [    5.019069][  T149] HD: 38 39 3a 3b 3c 3d 3e 3f 98 1a 6a 95 de e6 9a 71
> [    5.019081][  T149] HD: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> The operations are getting executed more than once. Should this be
> classified as expected behaviour just because those vars are technically
> only expanded once in the macro?

Brain fade on my side :-(

While you can copy all the integers, all the variables defined in a for(;;)
statement have to have the same type - so you can't take a copy of the
pointers.

So maybe this is actually unwritable without having odd side effects and
probably doesn't really save much text in any place it is used.

I did a scan of the kernel sources earlier.
Everything sets rowsize to 16 or 32, so it doesn't matter if hexdump_to_buffer()
just uses the supplied value.
I didn't look at the history.

	David

