Return-Path: <netdev+bounces-207283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B67B06927
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4175673EB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E452C1780;
	Tue, 15 Jul 2025 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eZlQpDrU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AB286D40
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617802; cv=none; b=RlPIGEkvVFBhljVE5E6V0U2wCpyb0mJf/6Bd9q447jPTOIDT+n3BqmWg0nbYxDKbNUc9BgDuuVv5enS/dIi3zVzlQ9tR/f5ogTVSvMqAtjTE7CmXBX9REnRVPB6fhHQDSWzqit1CRNz50BCVlDyPS+6MUTMhGFB/uvGi3cAohic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617802; c=relaxed/simple;
	bh=c4BXes3Jf6eycJG7bCi7K2M9YKvsVnZQh5feEpkD/S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSZp7k5Lvxqqs2qzF8KEFahNdf7WGrmhq1iwp5DITpLWvSn4gDDfq5+LD9UQIW3caFhI9APNjPZYJItFC3ZNAHU0OxqyuVpPy3J6IqaNTAA/EuDMD5lURsdLk2rpprcL6FXnuHFGiRBZFOJ35GTSxgeUnupvL//D8vufEZdA3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eZlQpDrU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7481600130eso6761971b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752617800; x=1753222600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhR4+ZqabNgqiaZkKQ8Or8VJENj0BFvWXjFEOEQ+9os=;
        b=eZlQpDrUjklEjTCfMegB119frg03KuwAF6IWOXGaG6/dFM6gqmJv1XbTlBqqup1dzb
         i8kmAWLUZE6BADCRLlH3gKQmPphsLh2dzuoGhs7Tz2FcCOVXzfha612YEaeuwBJrUohh
         oM+soKGz4rFoiA2WHHSfOmGwCOCocHEaPVRgGrU6pooh77Q6R5w2LDObtN0VcqLAcjYG
         h6GBniV6bHn9LLhDA2NsYKg/x2W2efuTvgV6NakupTUjsq/SLaLjf196gaeVe8TNdtix
         8EaBgbsAYYxcWpO0bGmKbJ2DYBizCx3E3Wf3pdQEGx95XSTGWN55+ByP9s+KRrCKZ/30
         f36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617800; x=1753222600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhR4+ZqabNgqiaZkKQ8Or8VJENj0BFvWXjFEOEQ+9os=;
        b=HX8BgLln9wr2uYvIaj6E87QqbBWKkM6cY5Me7+moggsCHGU2gsBv+5dIBCECi/3GJb
         SQ3MICCm6SCsIZAzUrc63UEqDGbhE1Rr3IofGP0sYpHJp2VXdlbDrvC0rRx0nLNHIHAY
         4bCTHbW5bOoIMjk6irs9Nf0hRdltBwyhFsLUQTJbfFkESMVCaFIUDKqXPDt2lX6qo9Rg
         AzkGUtaVgthGWmXGGot+FKov0r+L+3jqkyAqGgPhXPw3veHk+rll84A6mpbl6BGw7AQH
         5EFG2ieAQ1m5HGobYeZbzvSoL/s47Z4CE31wPwgP/MiudWq//yCNjSs2US1Xzaq57VoJ
         r5lA==
X-Forwarded-Encrypted: i=1; AJvYcCVePqPz+kNKWh9zzvhpwndQai08jxs+r/Fu0fTRLO05pdy/x/tqsDMGkvBWCo/3NYiyWVjVl/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvoLj0IFjXUFD1PDTWY2kj6ml3Az6ueaM8QocnRvQaiyj9kj1
	JJ6OdlXSDTxo4PNTlbEGaLvaXm56Kb3DCPnQ2QQuv/mylmiGOHCeGYjqXGDn/Z/Fnw==
X-Gm-Gg: ASbGnctKomppzku3+KWGXGVFxwXJpOz3+NdSo5a52XxswwTB8/Jil5AATW6L1AMgrxP
	NokLqA20wReQ82PuiSPdht1UbWUQaFmpAB3p3FEKaQRIm819Usl1JiY5L88df8LcgDkWwu2R2iW
	8rnWBdzcLHcI7hhH9fZV84mxrDGYF5A2c/mE0POLl19eh2xZmpDkW69NzcLxL6TTsOb2dLye6qm
	XnaPB6IG05nsdFWweUP4/QK1x01gByJYBRNwPz4hNXvfY4R6qhCJnScEmB9tBQmyKKIQubuQYnf
	ad8sa9I7RBIEJAsySbPspSRQyxhzbndQDXL3R3e8dswVsYMb5lioKTf+U1CNMmwd2wYnYeold+Y
	UrLEIfVKbkNkNs7o67POUIjFEG8E13q5U
X-Google-Smtp-Source: AGHT+IHpNsIc3IHJ6HojNv0rjfwozWHefVGqkYHVuBl5LpQbG7+f5Zf5s4eyB4xI3zG8l6Q08ScbiQ==
X-Received: by 2002:a05:6a00:399e:b0:748:e38d:fed4 with SMTP id d2e1a72fcca58-75722d62254mr318835b3a.6.1752617799816;
        Tue, 15 Jul 2025 15:16:39 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d34dsm13344462b3a.104.2025.07.15.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:16:31 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:16:29 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHbTPUYbroQ6W_1j@xps>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
 <aHBA6kAmizjIL1B5@xps>
 <aHQltvH5c6+z7DpF@pop-os.localdomain>
 <aHRJiGLQkLKfaEc8@xps>
 <20250714153223.5137cafe@kernel.org>
 <aHWcRp7mB-AXcFKd@xps>
 <aHaaQ1aSVt6vSQlT@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHaaQ1aSVt6vSQlT@pop-os.localdomain>

On Tue, Jul 15, 2025 at 11:13:23AM -0700, Cong Wang wrote:
> On Mon, Jul 14, 2025 at 05:09:42PM -0700, Xiang Mei wrote:
> > 
> > Here is more information no how I tested:
> > 
> > 1) I ran `python3 ./tdc.py -f ./tc-tests/infra/qdiscs.json -e 5e6d` 100
> > times
> > 2) The KASAN is enabled, and my patch is on it
> > 3) All 100 results show `ok 1 5e6d - Test QFQ's enqueue reentrant behaviour
> > with netem` without any crashing in dmesg
> > 
> > I may need more information to trace this crash.
> 
> Now I figured out why... It is all because of I used a wrong vmlinux to
> test this. Although I switched to vanilla -net branch, I forgot to
> rebuild the vmlinux which was still the one with my netem patches. And I
> just saw "netem duplicate 100%" in test case 5e6d, now it explains
> everything.
> 
> Appologize for my stupid mistake here. I think it is clearly caused by
> my netem duplication patch (although the fix is not necessarily there).
> 
> I will take care of this in my netem patchset.
> 
> Sorry for the noise.

No worries, thanks for the explanations.

