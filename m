Return-Path: <netdev+bounces-171107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D3A4B86F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD153AFC46
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6B1EB1B0;
	Mon,  3 Mar 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZMpYrYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969F5CDF1
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740987629; cv=none; b=P7gCtLDXLQqu8+D87khFVM8i26r89ecbcnLznU7K4s3oCyYFX/2Y760jEfuAVlEzULB1kc+fqoILk12qD7Gp7eDvYcksAawHZIHLIS4fwKbDgaDxlKS3z8wmORNfUAJfdg+D2s1s+bcqIz9R5O5wmZ6Nw6wbFm0phnPwOwxNb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740987629; c=relaxed/simple;
	bh=IzeGHhNg9guS+bb6Xf/SXPSItFc/WQddL0VKXCsN+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/qPClxHVnm3CqYqZSW8VvVu6rDzryysna0X/JGsnYSiPS/vbbEgYpFYH+8DZcnVtmSiiZ8Yg7Z/HblzBY4YHkJwx/nSZsVRzhJThmuY2ZU3SRAZAQPr9H8SjNW0Bf/vNKp4PqBvhD0O5jq11ZCGkH/EOzoE2jJbY57+Uut91XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZMpYrYq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e549af4927so1302652a12.2
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740987626; x=1741592426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
        b=bZMpYrYq8SmU+1WmTx/80imEvMa0yB74Vr6xlejw6sFZAlnT1Bl/W4GCPt63wwLOO1
         +5UJD9ENZawuRtTCHXsNJi6TL3GHu4uy71jMDTqN2S8BIc1TEfX5KVQ7+qKEiij44G3b
         osYyOTUC5h18vArHUU1ehxOIX6RYAw/hUIbFUCVzLi+c7L5tHmmq1Cyls2nczEyBcbqm
         sBrLx88Yf0w8hVri1pLA+duitT81weW+fAQBmgXGL+i7/m8fRHYEp56nY0CZZub39JXc
         r/Bbi4PfiV4YpxN4jFHBTKx/UrWqF8gMeLo2P0FwwW4Y5f6OfbsnLr1rn+/FurtpbDQj
         d5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740987626; x=1741592426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
        b=mGOJZxWmP96dwlxFN/yHB28EiXEXU+CNbKpnROeOE7xRjRXVeGUNLNBgsM3DzT4Dwk
         klAUjqYI0abVqYekCEkopBYMQpDHoiT7s3IKNZ/RTqXV9KDSrJfhh2aU6qvPnZDw35pB
         chY5bmA8LHhhY6lpQ/mHNS9ZIytAe6Is/Y2rhJdVNA988Z44yCk7OczqR9f8i0SCsiA4
         IYOq3vzfTZHqj+u2hHjHqvLHw3x4+wyPP6qxbsxXDqDR6/m5CMmUK81TqyDZo4xEntxn
         ITnUzYTcFNgLbpug9uisJQOWAu6+C9379IW86WRm3PQM9dlRx3sx5C+5W3mXmh32TueG
         Upkw==
X-Forwarded-Encrypted: i=1; AJvYcCWdf6ytzmrt32SmR24RV/wdVIFy5F1ZTvOAdeV2+vj6MQ/1GgVYS5xh0Rs5CTBZz+AG2itwuW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+PV5+B5iLIW+sxSiD/TcOyUwzEidQy/uZODfvk2sMRYz/c+F
	CdDkzFrZzk8IvgAL4TcB3WJWOIym65v2fvr/7DjIOlFJtr2MX8ySH3JQcsqxQzI=
X-Gm-Gg: ASbGnctrtC9exZ1Q5x+9X0BgX/ZIJ8bp2KPseGR9cPEtkTLEI/E2ubSovnG15RR1P/g
	cQ3UWFn1Z8vsW1b5lgfwZbHg0peOa6C2Uus+IjeSUphkV9zor7BIC5UhgzaiBJApAPF+AjwMT/Q
	IDbxnSnjFpL+/pgsu8vun4Y2sqg8ZWC3KrPEoSc2/vjPqiZdrlWLu4Z1dNnNMpArkmrxIE/YiQw
	vLUbfjJnaFIPaZP+2R3eGmXmRft+NJQaLUK6yf433DY0sJCa8oo4DYcgyQ2Eu1eGNTFkXWXYh/I
	xgVWbFruv7mi1/j0hCdKttpwEZXFE8vbKv/Ex6GShZmJiYcczw==
X-Google-Smtp-Source: AGHT+IENHB++EW6cxUTVldIAQkOiV9MmVqFnw5XQy2hy0OzVOdph9rtPPbQGZ/IPOrVxn3HuLojH1Q==
X-Received: by 2002:a17:907:7f27:b0:abf:7406:d375 with SMTP id a640c23a62f3a-abf7406d6aamr378845466b.0.1740987626156;
        Sun, 02 Mar 2025 23:40:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c75bfe2sm758421366b.151.2025.03.02.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:40:25 -0800 (PST)
Date: Mon, 3 Mar 2025 10:40:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] qed: Move a variable assignment behind a null
 pointer check in two functions
Message-ID: <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>

On Mon, Mar 03, 2025 at 07:21:28AM +0100, Michal Swiatkowski wrote:
> > @@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
> >  static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
> >  {
> >  	struct qed_ll2_info *p_ll2_conn = (struct qed_ll2_info *)cookie;
> > -	struct qed_ll2_rx_queue *p_rx = &p_ll2_conn->rx_queue;
> > +	struct qed_ll2_rx_queue *p_rx;
> >  	union core_rx_cqe_union *cqe = NULL;
> >  	u16 cq_new_idx = 0, cq_old_idx = 0;
> >  	unsigned long flags = 0;
> > @@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
> >  	if (!p_ll2_conn)
> >  		return rc;
> > 
> > +	p_rx = &p_ll2_conn->rx_queue;
> >  	spin_lock_irqsave(&p_rx->lock, flags);
> > 
> >  	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {
> 
> For future submission plase specify the target kernel
> [PATCH net] for fixes, [PATCH net-next] for other.
> 
> Looking at the code callback is always set together with cookie (which
> is pointing to p_ll2_conn. I am not sure if this is fixing real issue,
> but maybe there are a cases when callback is still connected and cookie
> is NULL.

The assignment:

	p_rx = &p_ll2_conn->rx_queue;

does not dereference "p_ll2_conn".  It just does pointer math.  So the
original code works fine.

The question is, did the original author write it that way intentionally?
I've had this conversation with people before and they eventually are
convinced that "Okay, the code works, but only by sheer chance."  In my
experiences, most of the time, the authors of this type of code are so
used to weirdnesses of C that they write code like this without even
thinking about it.  It never even occurs to them how it could be
confusing.

This commit message is misleading and there should not be a Fixes tag.

regards,
dan carpenter



