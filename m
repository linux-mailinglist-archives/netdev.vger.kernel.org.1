Return-Path: <netdev+bounces-167342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A230A39DAD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37286188B476
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CC269883;
	Tue, 18 Feb 2025 13:33:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060623BF9A;
	Tue, 18 Feb 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885593; cv=none; b=lO42VZCBjSgNmrPGOCk+OhuVfx23vXppJiYFB0G8spXRv9mdjoTEq6JoQRHfCoqITXAd78HabHl1RQz4KMn3NVQywKIpWcu+3FSkaehoHMb5AL81Rix6c7UFDG48TELz9haE3lipctBOFbO4caMR4LNVc9CStJxH9AWBit4sVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885593; c=relaxed/simple;
	bh=zw9wPD0cZ2Lg1Lu+CaJQbG9ZVlJ4oAHyJaPkVTDGwck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP6p8moEBvOuc0ijC0w/jSsRq78mx/t8CG9QjgMrssxEwcUDjumwHbBTrLf8xMU5ggWulb9+4uLAP9rIoLgUBu6xygGKRj8ZFAH6hoSz9LGwI8JDRrWwKKAjlAmFO6Z3va9ekwAW/pKLGpt+DIvvLY7lwA4BBTwjdqveLh6+bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb90f68f8cso448455166b.3;
        Tue, 18 Feb 2025 05:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885590; x=1740490390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWiUlVTiHOeTkc4pIfg7w83qDgdyows487uF1rjzqiU=;
        b=qM5/T9GE6GodZ21wedeB25hK6aP/rIXEUhXYYDgXNc31CfhtgPGyO9+3lTPW0RSDhz
         CjEsOuINR9xv2jY9OySISRHtcJ9cBXJK3fiduKtJkusC/tcLIQY/RJYKEi4pu6Pqev1D
         +TDFlwZzpCJe8Ip+knnPKOm6ux9NShK9fE8GeeONUcTd6FBo28lFpwBfP+/OixcZZfLk
         Spcz1N1Ep0Wv1pnNyMfa5jjCC6KyYhhdq4vqzwkNDVIs6cHOGhezYUkaqVB2DlE9Ussr
         2XH+fHaGL8doGlkhu8UPknoNj5VEGYx+2rmlnKuMPbTYftjWJhcLkOUm2XPcOXjO4guV
         MY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZFAXYQEIu6h1s5gINrT/JT0+0Kxey0w1lojDmY779gTZHsx1L5ufA7QSoRn0/9B5wMlaF+FtQrZTCL9I=@vger.kernel.org, AJvYcCWfymFj6Bc3ojHYWoJxcl7ICvC5kas6ORxSSydJFBvBg4ySlQ/QMov571GdIAPXiwspQozCG7KdECvkLFssJ/7i4kp+@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmgwrNHCf9pcsnToL0DqpGJ4GwjPYknfL9z45dWRVMNb3wob2
	kABz5aV0ZlKXppyr3G4VoWn9igdkgJB9RVqzEoAcs+CASiIz4lq2
X-Gm-Gg: ASbGncvAfywzWzFOHH4cEMkkipyUkPwYHgXh/7IUmdAOkA+m4eAJEsbmGcxOG+OTkb8
	uPcTssa8m8Jh20Z2I31INa7+EZsgUj81XyFG3TDio2S9WT60j/ETrx40ymk5d2pst1QVBddamUV
	veW7DV7PplEZwr0jtCVWbsRfPfUU3BACt/dIXeikkn4rWRXnZhGkZm5242vz6u/k21PylEOtNpw
	vv7FbZdd2iIITejBXifvDvfE2SxDMP6p5KIeOz/RvOGDG/upff+bJJRZ+BrB5l96n01eZ85QdpJ
	XB2N4Q==
X-Google-Smtp-Source: AGHT+IFda2Nj++VmsOMVFkxsPwtVMktXaY7BoajbEeCSOP7w+ytjkjbjYtnmMKjhRF5VvfmGgiymLQ==
X-Received: by 2002:a17:906:6a03:b0:ab7:4632:e3df with SMTP id a640c23a62f3a-abb70c266e1mr1481278566b.31.1739885589578;
        Tue, 18 Feb 2025 05:33:09 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa99f283sm254406166b.32.2025.02.18.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:33:09 -0800 (PST)
Date: Tue, 18 Feb 2025 05:33:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250218-honored-pronghorn-of-focus-ffabb2@leitao>
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
 <cc84f98f-d3d6-499e-9d2f-47eaeb56aad3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc84f98f-d3d6-499e-9d2f-47eaeb56aad3@redhat.com>

Hello Paolo,

On Tue, Feb 18, 2025 at 01:53:15PM +0100, Paolo Abeni wrote:
> On 2/14/25 6:07 PM, Breno Leitao wrote:
> > Add a lightweight tracepoint to monitor TCP congestion window
> > adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> > of:
> > - TCP window size fluctuations
> > - Active socket behavior
> > - Congestion window reduction events
> > 
> > Meta has been using BPF programs to monitor this function for years.
> > Adding a proper tracepoint provides a stable API for all users who need
> > to monitor TCP congestion window behavior.
> > 
> > Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> > infrastructure and exporting to tracefs, keeping the implementation
> > minimal. (Thanks Steven Rostedt)
> > 
> > Given that this patch creates a rawtracepoint, you could hook into it
> > using regular tooling, like bpftrace, using regular rawtracepoint
> > infrastructure, such as:
> > 
> > 	rawtracepoint:tcp_cwnd_reduction_tp {
> > 		....
> > 	}
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > ---
> > Changes in v2:
> > - Close the parenthesis in a new line to honor the tcp.h format (Jakub).
> > - Add the bpftrace example in the commit message (Jakub)
> > - Link to v1: https://lore.kernel.org/r/20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org
> 
> For future similar situations, note that it's expected to carry-on the
> tag already collected in the previous versions, since the delta is only
> cosmetic.

That is fair. I simply forgot about it. Sorry about it.


