Return-Path: <netdev+bounces-137120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0359A46AD
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC981C22DEC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8633F17E015;
	Fri, 18 Oct 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs6e+geo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166116EB4C;
	Fri, 18 Oct 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278956; cv=none; b=VPR6YXPywZQeRL4osRW8rqp+bYXbuV1kjw07FEue/Q9R4QNqsQxGmSFm2T6CLydycRe+q5WhVhrSbhZFfEhX/lcfodBHEkHsyIFWtM6NrEzy1MgpW+fQ/aHaMvH0Ul+8keIzioHZrcFeJ7VdyF4hSCCHcFwq41XeAUBiIQZuknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278956; c=relaxed/simple;
	bh=I18z61QeColdAmOMx5C6/B9N5qxv+2MNp0MbEEqjjtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzH6FYcVauvzRffY0Ohk1kMA7B9Gdlm7Ox7PWLgs+gFu7Srdpwgu6TI26coMIszk9Z6oI6X8/n61aGU+stA5A0RmuFm1V9O3S11iDuHOinu5Y6G6gaTl7Wb1pwtUGBUGOSg4onDH+jQTRY7y7UEQerXsxRGP89jIi0coFWQqAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs6e+geo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so1784002a91.0;
        Fri, 18 Oct 2024 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729278954; x=1729883754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJcCOkX7npavhD9TICmdCKs/bOiKnBn5bb2igulRwqA=;
        b=Bs6e+geoZn6CGStjYK9mPuVrCn13e/IUV/lFvSC72FQO9cKtBYDZ2mD+/215slwsPj
         qr4ktEEjnjFkm5qiQoNO8AXYPJKVIMODHBXJPOc72NLUVCw4BJXDFQVdApKxDWVDnXjz
         uHwe5eWrpYJH4oJIS3XFBdHdvL2xu40kAKZ1iDr8+p10OPd1hwrZHgCwwKYACXIsIw/5
         5JSIQYAHB/whf7ElWZijOPXbz1Ece9aalV7yx80zMnN1sRFso8yN67gY98B+6mGqiRfs
         cgjbY2LS4Jc73NinfJfYsltpGpvg1MKoRd7RjqcZ0ZsPs5zy+9eOsXtZwyrbU9689NgR
         c8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729278954; x=1729883754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJcCOkX7npavhD9TICmdCKs/bOiKnBn5bb2igulRwqA=;
        b=pAJr14SQGMlaVcmxri5W2d7iEhR82HJ7FOEPVGj6k30cPbiceI7IVpT1za0I/n/XIb
         xFsWepyPWfgcVwBOTc7PVl7gj48bbtBU9yXsBVxwR9Li0b0SqVaQPqgxcc601chCDIZc
         4muL4k/b6N6qP7CskYHKc/wTC4klnMMkyYv+ZBxfc707Lchcj6H2zj9QZo3szcRlB9dd
         SvtmJhGGQtNxi2aj9i175lxFrko1cD+yf6dwsMQ4jA+c4bORDW1B4bqznXDpgQdPmQQF
         YvZYHpnEwAEXXN/Qi50Zloa5YNQ0rcTqcZKUNc1uPEqToJBEPbOm4uQxs30IpTi+x++L
         QBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoiu8WWfYEJnaeHVUInyud9Q/9nRrlpILZrbP63yv3jD8o2wqlT486+AQN+o2l1xz08263YKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdW65W0Eq8gfkHAUmNcNco0T+43pO54ZL/0Ucq7+JkzbZYBhzw
	u0NWQG64F0oM/YkUpCN7+1DCHFx85NHCX1QCJO/JS1k/O4hl6pVn
X-Google-Smtp-Source: AGHT+IErQdqNkVwCwUL/Ixn4/BAQmd/HwP5uXwBRI7+LGd+x2liZdulD8V2brX8IhG91ZBbOQkrUwg==
X-Received: by 2002:a17:90a:2c06:b0:2e3:109:5147 with SMTP id 98e67ed59e1d1-2e3dc5d69e5mr11403408a91.17.1729278953968;
        Fri, 18 Oct 2024 12:15:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:351c:e27f:10e5:484c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e561202a68sm2359233a91.31.2024.10.18.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:15:53 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:15:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] cleanup: adjust scoped_guard() macros to avoid
 potential warning
Message-ID: <ZxKz5jGCNZSAbNo-@google.com>
References: <20241018113823.171256-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018113823.171256-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

On Fri, Oct18, 2024 at 01:38:14PM +0200, Przemek Kitszel wrote:
> Change scoped_guard() and scoped_cond_guard() macros to make reasoning
> about them easier for static analysis tools (smatch, compiler
> diagnostics), especially to enable them to tell if the given usage of
> scoped_guard() is with a conditional lock class (interruptible-locks,
> try-locks) or not (like simple mutex_lock()).

Thank you for making all these improvements!

>  
> +#define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
> +static __maybe_unused const bool class_##_name##_is_conditional = _is_cond

Question - does this have to be a constant or can it be a macro?

Thanks.

-- 
Dmitry

