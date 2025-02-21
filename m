Return-Path: <netdev+bounces-168682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E020A40289
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD467864684
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1B204595;
	Fri, 21 Feb 2025 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2U+dnPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF882040A4;
	Fri, 21 Feb 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176301; cv=none; b=KaHcJCgsEd726GrjAqnXqB70e31GZNkw82oMnXJ6+OGag2E1OhtwtDKA8OQKOz/7qornYgnhKd+FCr8qFdNPJ5K5Z6uI4wz9I3aQ+wF9geR94ixxi+lu9/r9hOu1YVdx5Cs4cS9haG9VjtENWwpRblXlvOijvcqvmlMSokAx/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176301; c=relaxed/simple;
	bh=p9H7eWFtI6uqcSrVYZwPwU1BZADxWA8u2LXEpyQb6Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glNX/KIswLhNMttuRI2u/wCwzM9uw4rosFwwbfoKMzaN8n5liKWpFOeq70USCGpjqQw2TRurgoU0nVnaOW1cYIatmw94HgZQC/hU07dj4DtdO3c8GHOiXOjN+MGCrW2zxMe4hF2Te9/dqrynm6aS+7cBg9kOhXe02mLKtG36GbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2U+dnPK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43989226283so18165245e9.1;
        Fri, 21 Feb 2025 14:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740176297; x=1740781097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipxGsEkSd2zt5hVzi7gIQRAM/kjjmR0+rET13GoS3gg=;
        b=b2U+dnPKg3OjAlN1MyhiIBVQ+m1aKOIJbm9ByGTZKGM8tgl4425roPQKYXygLWkMZq
         Gy8QtYdJXJcdbosBUKZ7Yj4fFZLhes5poJJh08Nkx4hgjJyE82lVlykl3lDh45oL+4tO
         ul0fi2XWWebZsCeRRJFuJOABuHlMfSUk888dBaLihGTGJUssn/dhH1DMOJGFb/i+EYyn
         l066WYG9ypwQDmPCKl5940gU7khSqPjgy7fEw51LnbnRgK7Rd4kWzMHrSx84VTpwKtRd
         Fabuiu1GV1hho4wbi0vsRnJyAq3WQsqj6zEVgQBXo08k25VnwQroBuU2YytKeSXvEEvX
         Ey2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176297; x=1740781097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipxGsEkSd2zt5hVzi7gIQRAM/kjjmR0+rET13GoS3gg=;
        b=IjlMF9JLduimKKGJP9SeMwk8ljpafXeQR+G/08PqxHIZ6oFVQikIFyvc5RcP/kK9U1
         g4gfMznllLERkGGpDb4vne0ih8TzHOTcrLwGBHCgtgkcfC40JUwMT+znCV5FnUsBQyaj
         mjA+6lhFlyZusZvN7Nbqiv8ji9xouyXKwmAcvAz6ghSmKmQwEGZT7ku6LKX8Kgq0UEyy
         JnSSp3moeolYfL6SGqnw0LKxzUA79u2f+bfcsIdeVgKG3rN54FE69E79dbvkTcrVjKXP
         XXx7PFBEnnwiG+WUIjb8/s/rKChKjSUeu4T1HtZr62bqcN3u/8lD2zcX7pvniRcSL6Qf
         ahFA==
X-Forwarded-Encrypted: i=1; AJvYcCVuardKGLMNxEba/g1OzKbfPVBIhoymm3ECiWQ5DOr1RkZVWSQQm7/Fcuga0sicY6jlGx6Ss+j3hAMq4G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfK9e9VmFMKNIXlfrkeM1/4BoD5eztiqtZBHkh5gx/AwrhD/E
	8vaoXfZuiqZjaGAATBzdHjW6EG+9CcikxlvbXO3DzjYNWC39UBoi
X-Gm-Gg: ASbGncslOhr/jAwUSxvTaihSDe2lPVjUvlv/A5kWht5G0exlRWFIH9rbBZXqf3sM/ni
	6szwv61zvfkz467UFrhwXz8aNEtHnYkwvyoQAG+8zBhVqjLQk42XcU1hc1WXWlFMgtxwvOfXGm0
	fDL1Q7tXHPcimC/AQuYDYSCTdIL39v517Ln1aOWc7wCyccbg4L7NoNcBRh+SYMsxobQBfIAFNC8
	s0eyLKH1qrGF6jdTKc2DRnRuvYjK9tgaH9hYtsLzzEpw/8zKRoWNXUyCnOxX6W9Adf3mRktieh/
	Ta2FCRXqDtgLhN1LwuskLzPQP0eCJvly4vkm3mg6tIjBleHiJc98DWQDmglET5LQ
X-Google-Smtp-Source: AGHT+IHfSNAxS9poe8hCk4HjjTTlxpVzxb3L3wSfcoQW9kHs/5esAuFuB29zyHNCAXBmcj+Hc+dXZw==
X-Received: by 2002:a05:600c:4e86:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-439b6afbbe3mr21474455e9.23.1740176297168;
        Fri, 21 Feb 2025 14:18:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e6cf4sm29222245e9.19.2025.02.21.14.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:18:16 -0800 (PST)
Date: Fri, 21 Feb 2025 22:18:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 nick.child@ibm.com, pmladek@suse.com, rostedt@goodmis.org,
 john.ogness@linutronix.de, senozhatsky@chromium.org
Subject: Re: [PATCH net-next v3 1/3] hexdump: Implement macro for converting
 large buffers
Message-ID: <20250221221815.53455e22@pumpkin>
In-Reply-To: <Z7jLE-GKWPPn-cBT@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250219211102.225324-1-nnac123@linux.ibm.com>
	<20250219211102.225324-2-nnac123@linux.ibm.com>
	<20250220220050.61aa504d@pumpkin>
	<Z7i56s7jwc_y0cIz@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
	<20250221180435.4bbf8c8f@pumpkin>
	<Z7jLE-GKWPPn-cBT@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 12:50:59 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> On Fri, Feb 21, 2025 at 06:04:35PM +0000, David Laight wrote:
> > On Fri, 21 Feb 2025 11:37:46 -0600
> > Nick Child <nnac123@linux.ibm.com> wrote:  
> > > On Thu, Feb 20, 2025 at 10:00:50PM +0000, David Laight wrote:  
> > > > You could do:
> > > > #define for_each_line_in_hex_dump(buf_offset, rowsize, linebuf, linebuflen, groupsize, buf, len, ascii) \
> > > > for (unsigned int _offset = 0, _rowsize = (rowsize), _len = (len); \
> > > > 	((offset) = _offset) < _len && (hex_dump_to_buffer((const char *)(buf) + _offset, _len - _offset, \  
> >           ^ needs to be buf_offset.
> >   
> > > > 		_rowsize, (groupsize), (linebuf), (linebuflen), (ascii)), 1); \
> > > > 	_offset += _rowsize )
> > > > 
> > > > (Assuming I've not mistyped it.)
> > > >     
> > >
> > > Trying to understand the reasoning for declaring new tmp variables;
> > > Is this to prevent the values from changing in the body of the loop?  
> >
> > No, it is to prevent side-effects happening more than once.
> > Think about what would happen if someone passed 'foo -= 4' for len.
> >  
> 
> If we are protecting against those cases then linebuf, linebuflen,
> groupsize and ascii should also be stored into tmp variables since they
> are referenced in the loop conditional every iteration.
> At which point the loop becomes too messy IMO.
> Are any other for_each implementations taking these precautions?

No, it only matters if they appear in the text expansion of the #define
more than once.
It may be unlikely here, but for things like min(a,b) where:
#define min(a, b) ((a) < (b) ? (a) : (b))
causes:
	a = 3;
	b = min(a += 3, 7);
to set b to 9 it has to be avoided.

> 
> Not trying to come off dismissive, I genuinely appreciate all the
> insight, trying to learn more for next time.
> 
> > > I tried to avoid declaring new vars in this design because I thought it
> > > would recive pushback due to possible name collision and variable
> > > declaration inside for loop initializer.  
> >
> > The c std level got upped recently to allow declarations inside loops.
> > Usually for a 'loop iterator' - but I think you needed that to be
> > exposed outsize the loop.
> > (Otherwise you don't need _offset and buf_offset.
> >  
> 
> As in decrementing _len and increasing a _buf var rather than tracking
> offset?
> I don't really care for exposing the offset, during design I figured
> some caller may make use of it but I think it is worth removing to reduce
> the number of arguments.

Except the loop body needs it - so it needs to be a caller-defined name,
even if they don't declare the variable.

	David

> 
> Thanks again,
> Nick


