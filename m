Return-Path: <netdev+bounces-246377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89725CEA50F
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132D73018D4E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991E26E719;
	Tue, 30 Dec 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hf96sy+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B421D00A
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115465; cv=none; b=WUrQkLkeJo7qxC0yMK90jQ1lXXOUQdcsmpm/HK2Kn3coXPUyKfpBWKC9eOSb5ExhGtuRRUBxIjipN5EUFo+8/nhKIqzv9qh6F1nF+HONt+aaPL1wTs6D6PK4AyRxs+af+ccI3O8KK1Qe7QlDzURc/DMVBeOENFPplV8oE/Z6//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115465; c=relaxed/simple;
	bh=zLue3EiUKcJVwzTkVjlEZrXVqsu/1g+PFMS1YLEp/HU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG/crnQnNf0KFuqwLfQ0fIquhAw2t+Nmw9BsalZvym7op+DKSFSH8mK3vDR0LvcdoefG8Lcbv8yWl8cIlwq2uPCFM8UAub5YFq7zl7df9SeNgUBlSItxSGYU2QeTVuuFKArbwSgbaVjfkaww+eG0/n4N2CEWwiHbpYtd1Yv4/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hf96sy+V; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so10757340a12.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767115461; x=1767720261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7Z9gNKrdZF5i+woEGImIAk4xSzzcy9RyFaHQwUnTdg=;
        b=hf96sy+VL4kR9iPohYh6LMnjfiwMRXsySlE/6vXuqTIPAQEKpaOEXrgW1VHjG1Pq/+
         Pfh6UzsXVrPGWB4/wwzlEN0RTxBHql+vglMMyWHx0c7LJjjuzA44i0lJJ93jkDSdOfYF
         fg0/yqmVkkYYZLyBQTLKZqdAC+tMd59ir21x7A1pC5xH1NZuIUDSb0l+V92KCfAQKaep
         NZJPWPRezOFBp+qhgZt++sOWr3M6Ps2iV2LjYJoR26/VIXI1UizmmgM8xbPvAZwxWKTa
         eewrQa/wX2Oetyu/PrbokQMofgbTpJOQeTGOKY0yZMaKLoFZkQHLiUKZ9wVe51k/3qLg
         S6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767115461; x=1767720261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7Z9gNKrdZF5i+woEGImIAk4xSzzcy9RyFaHQwUnTdg=;
        b=mEyBhW5w+6Hso0nPmsIKu77jATEduL/k29H+Zxl42wE/9dENJUwD3Fgcer6upBTXfs
         6uxhVWXgsgJsR7ypebQbrH1hxpbsLICUQ7H5AdHnJrDirVSr00oEp7FCREBUypfB+bXa
         bs2HnBEh+XB8cZLvQaqnLRrOurZ4s0VuWVmO9VptpcxxscLw/h29j34F9x4qLBPmyIrd
         0UTsYQn8O5Iq8tvCj87B/x9h19OcvmwA5c+p6hadGDfhFcTVppGR4+lEI97pwxBRuBXe
         WoJZIKTm500u27jQDgYijc4v1jv03y+D0VNI6RTCv5zK3DGqhfMiNYr5j+GTSb9kYIHJ
         mneA==
X-Gm-Message-State: AOJu0Yyc/RWMyVKYcQ9xGZcNAIeh3rX8VrS7CkGBD0duM34yeb/Mxj3A
	BFlVfkpAfOTjI3ZM/KuuhHUL82+MwQb/LBRhnqvuhC4o+Fwm2SsQiAszCVso0RAkkpI=
X-Gm-Gg: AY/fxX46Ucyb3K/JsAttvyylK64i0WXFpMbQKHrZ6CttxTzX4VIcnmFik/6kBY4WSNf
	2j8x8D1e9e4FFv1W4mLlyFCjZa38mOfyOJBhZk36MaVWbsXmLrlZNHLYzjRY/4QyYfCojmAWT6r
	nl8N97ZKqRJbBwcaPPOoPpkFrxdiUE38/6WpXEoejxsn/jJvJHh7AwgT5tM79BbBAcnWjD9qTWv
	Ri8LmHVgij75OuAF3NnMErTwnhz/QHSRSIC55KxzKkxUs0aq6XHgIOsMffnbRJiUIrEy8yUcipH
	ySZ2nY+OKYCDtTLspxax9DaeItXdL3HT26xvZMRWbIICOB1Y7ChNpLs4Rw0SYoFIvj6rKi/OnG0
	sYaXr+tpsjbUVR1uDDj9u70r+B8GZsdjFV5Zrfd5KfEWxORNrR8/cJuhVBF6oTpHjChZuGli+Qv
	3CR7UF1IkDPqpMRgujNERhIFgUwIE2n9VSMr9fReZLotlagClGBA5s
X-Google-Smtp-Source: AGHT+IEnBTAiE7XbK474MVil8JmolmJE2tEyNQcyAA8ydmDdHDGDcAD+Q/bs6GvqeZxNAYqcwu9ZzQ==
X-Received: by 2002:a05:6402:238c:b0:64b:7231:da3d with SMTP id 4fb4d7f45d1cf-64b8e94994fmr19781451a12.9.1767115461283;
        Tue, 30 Dec 2025 09:24:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53b21sm35340380a12.5.2025.12.30.09.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 09:24:21 -0800 (PST)
Date: Tue, 30 Dec 2025 09:24:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [Patch net v6 1/8] net_sched: Check the return value of
 qfq_choose_next_agg()
Message-ID: <20251230092415.077d176c@phoenix.local>
In-Reply-To: <20251227194135.1111972-2-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
	<20251227194135.1111972-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 11:41:28 -0800
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> qfq_choose_next_agg() could return NULL so its return value should be
> properly checked unless NULL is acceptable.
> 
> There are two cases we need to deal with:
> 
> 1) q->in_serv_agg, which is okay with NULL since it is either checked or
>    just compared with other pointer without dereferencing. In fact, it
>    is even intentionally set to NULL in one of the cases.
> 
> 2) in_serv_agg, which is a temporary local variable, which is not okay
>    with NULL, since it is dereferenced immediately, hence must be checked.
> 
> This fix corrects one of the 2nd cases, and leaving the 1st case as they are.
> 
> Although this bug is triggered with the netem duplicate change, the root
> cause is still within qfq qdisc.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Reviewed-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Looks correct, if you make a new version might want to add a comment.
If you really want to get picky the rest of the code in QFQ compares
with NULL. i.e (in_serv_agg != NULL)

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

