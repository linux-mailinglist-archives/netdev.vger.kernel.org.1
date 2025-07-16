Return-Path: <netdev+bounces-207461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DBB07640
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7181C24CA8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6F26E6EC;
	Wed, 16 Jul 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs4XFyE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB1846F;
	Wed, 16 Jul 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670392; cv=none; b=j6BIRBBKuMhr0cyaU27ru0In1bphyi+2C8HrueVPe8caUccoKD4A7kjP1I/vcAs3SKoK4WLmnYt3wer3xvmd4jrno6lZys7hDoe28VoqzE79Skr+8ZA1dlTFVclnHy9RaKDCu1Kt53rwclHaIz90htBSNlz2kUjkXeass7XK4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670392; c=relaxed/simple;
	bh=uoEsauAVMPq4TH9wQPbSFLfb7iwluzbXJkbvJwU3CgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIpddjyPx6RfE8RtvqXOhikp1TyyRcXwq1rThP1fMLAVGY5lR712x1YWd4h+VkNfLMi6uf424XhU3O/ZVfDcvay/Jt8OjX07A9uJGXAr8JP1R1EtorjsJ+c3tN8rbUDy9sO5cmxrppOqoNhF6COUgRJdp0Td8liQIPM4X4XTWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs4XFyE0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e1f3b95449so95524885a.1;
        Wed, 16 Jul 2025 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752670389; x=1753275189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX1faiI+i8OURiPK+ljiykpWuc4XOaqYSOwyCJ/lxdg=;
        b=cs4XFyE0nj4Q9EO4TlZ8e73XkYghftXdNdj8GRYqDm1naxZ+i7/hb8Cni4E/8Q+9lw
         xylebAdC/3x9dK+LIjEIqxvXv4xVgehxKwtK+gk/FhIckrPx4mzFObU3g7mYSRBB5WGX
         WcqFr6QmVviGGB+hHJCsQKLLLVBr9hQ0r5ZzFDCFuM3CRHFA6LWa2jDZy5G4TbDZU45m
         h5cydLxSw3kqhORztE7ucjK248wloEHM7TZhfe7hrAI6pXOz1V/+Dw7OtUu/TkJW0B+G
         HEhLoz7AhnpW7iJZphOlT7fUzV9iBbh1Ir/Adsm+hI1FW+Wb6OhjweCBual9G+zrbklW
         6lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752670389; x=1753275189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX1faiI+i8OURiPK+ljiykpWuc4XOaqYSOwyCJ/lxdg=;
        b=IHZvqJJArf3XLSCU7uawjsYpafVWwPpooUBhGpYDLzsT4v1c8fqlb/8TyQez32H2CO
         KEfcTrManZnEHa5IwcVsgL4vhLzRgXcOCBPDN1KFqDgZojzpvpwA1UX0chJ/sLJP18Xo
         U/Ma3sKxZbCEf4k7xKYzwgzhJEc9AxuCp2cZNER/x8Pp/TiGDOzXHGvc84m4G8hFyp4v
         noBZf85AtDK4dU8aQycceNoHoDLfH9W7MxRJaeNZyQ1kXTNqwH3OmgHhg1dpfECGMwCp
         OtE05cm1KApDbMXsCCRtNpo1JM7Fb3Y2uWy+AOSO1VrPwzlfzSrKU837dmFbqrzay+h3
         nhFA==
X-Forwarded-Encrypted: i=1; AJvYcCVUEiXu/+wh19G8RcKgdFdcYs2Zc1IPaKK49kMi9+WORzpavQps9xPZz+ZLb71Y1H+aKsmNBaEx@vger.kernel.org, AJvYcCWniWetwjZ1yj0h1rjgmr660dls8UPKjlCvWuSn02/tCL7S1l9ajlSeLqI2vaesVWD8SShsxUjNcO6Q178=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtANb0V+tKSYR9mD1ioQTvMcVe7y08ZKaRsqK6J+P0PddltPW
	fGQdgCLpBfsWQ3fVIHDnsfsoY+eitiMSKISk9rLKz4JduDKH/xYKdBz3E61PPCb6sTrdbaIDmfa
	yPG/MeYIdccdc9MJi1DtsqEDXt/rMDoM=
X-Gm-Gg: ASbGncsG0k28X6igpxh4u528PcJr7GN1ZGLnu0ItR8BVyC8E5t/l+UE5/Uu+5s4iVlF
	Iy4wtQnEzRFxzAGCBjY0iainbbv+gd90qxzVayQrClRSRo3YZFQETkAKYUGj9a82Ng1ebaPMAKL
	LM28pwpTwymCgZpA5TwKrx96NlCjnw+/Sn8HSisK3tVVB8bUd5c2/h9AzTdEnw29BxaWO6gyRUX
	54tbZ2nsxPe8tYJX2QesCmwEmAvwKtHMcM8lBl+ABdgSTkt49Qw
X-Google-Smtp-Source: AGHT+IEGvTRbwNwmUtHoJflO3qdAPSjfdGRUFAFajFyxo8TDC4VY9CMmTHxTTeXuWymwqdIx3SKPBISSDyVxSMrtTdc=
X-Received: by 2002:a05:620a:1913:b0:7ce:ea9d:5967 with SMTP id
 af79cd13be357-7e337a4c9ffmr1023019985a.15.1752670389041; Wed, 16 Jul 2025
 05:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org> <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>
 <20250716083731.GI721198@horms.kernel.org>
In-Reply-To: <20250716083731.GI721198@horms.kernel.org>
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Wed, 16 Jul 2025 20:52:57 +0800
X-Gm-Features: Ac12FXxEvuscnPgDL-cFUWDQ_ZsHTjZIFXXpKL-UAfG1Wc84wxb5I-RyOB-dbpc
Message-ID: <CANZ3JQRwO=4u24Y17cP3byP8mS9VOP5g=sy_Ch_g0xKSDJLhKA@mail.gmail.com>
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
To: Simon Horman <horms@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the clarification regarding i40e_dbg_command_buf.

Please let me know if you'd like me to submit a patch to
remove this interface, or to replace snprintf() with scnprintf().





Simon Horman <horms@kernel.org> =E4=BA=8E2025=E5=B9=B47=E6=9C=8816=E6=97=A5=
=E5=91=A8=E4=B8=89 16:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 15, 2025 at 10:12:43AM -0700, Jacob Keller wrote:
> >
> >
> > On 7/14/2025 11:10 AM, Simon Horman wrote:
> > > On Thu, Jul 10, 2025 at 10:14:18AM +0800, Wang Haoran wrote:
> > >> Hi, my name is Wang Haoran. We found a bug in the
> > >> i40e_dbg_command_read function located in
> > >> drivers/net/ethernet/intel/i40e/i40e_debugfs.c in the latest Linux
> > >> kernel (version 6.15.5).
> > >> The buffer "i40e_dbg_command_buf" has a size of 256. When formatted
> > >> together with the network device name (name), a newline character, a=
nd
> > >> a null terminator, the total formatted string length may exceed the
> > >> buffer size of 256 bytes.
> > >> Since "snprintf" returns the total number of bytes that would have
> > >> been written (the length of  "%s: %s\n" ), this value may exceed the
> > >> buffer length passed to copy_to_user(), this will ultimatly cause
> > >> function "copy_to_user" report a buffer overflow error.
> > >> Replacing snprintf with scnprintf ensures the return value never
> > >> exceeds the specified buffer size, preventing such issues.
> > >
> > > Thanks Wang Haoran.
> > >
> > > I agree that using scnprintf() is a better choice here than snprintf(=
).
> > >
> > > But it is not clear to me that this is a bug.
> > >
> > > I see that i40e_dbg_command_buf is initialised to be the
> > > empty string. And I don't see it's contents being updated.
> > >
> > > While ->name should be no longer than IFNAMSIZ - 1 (=3D15) bytes long=
,
> > > excluding the trailing '\0'.
> > >
> > > If so, the string formatted by the line below should always
> > > comfortably fit within buf_size (256 bytes).
> > >
> >
> > the string used to be "hello world" back in the day, but that got
> > removed. I think it was supposed to be some sort of canary to indicate
> > the driver interface was working. I really don't understand the logic o=
f
> > these buffers as they're *never* used. (I even checked some of our
> > out-of-tree releases to see if there was a use there for some reason..
> > nope.)
>
> Thanks for looking into this.  FWIIW, I was also confused about the
> intention of the code.
>
> > We can probably just drop the i40e_dbg_command_buf (and similarly the
> > i40e_netdev_command_buf) and save ~512K wasted space from the driver
> > binary. I suppose we could use scnprintf here as well in the off chance
> > that netdev->name is >256B somehow.
>
> I think that using scnprintf() over snprintf() is a good practice.
> Even if there is no bug.
>
> I also think saving ~512K is a good idea.
>
> > Or possibly we just drop the ability to read from these command files,
> > since their entire purpose is to enable the debug interface and reading
> > does nothing except return "<netdev name>: " right now. It doesn't ever
> > return data, and there are other ways to get the netdev name than
> > reading from this command file...
>
> This seems best to me.  Because we can see that this code, which appears =
to
> have minimal utility, does have some maintenance overhead (i.e. this
> thread).
>
> Less is more :)
>
> ...
>
>

