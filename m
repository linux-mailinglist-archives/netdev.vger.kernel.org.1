Return-Path: <netdev+bounces-125836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69C96EE48
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299A51F21422
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295015530C;
	Fri,  6 Sep 2024 08:37:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B514B945;
	Fri,  6 Sep 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611832; cv=none; b=f3AeMNdL+oqC7xiFq3QfDYMXTZnDHZR0On7gUChZbDBdXu679ihB79pqquOANTCWAKhClcn8Myqje0Ix006TMD6N9gk4eRQnHwE1pZlmLP7CCUAOWmvuwMkTdwtl1lzMphTc55A3y9TvQwGyVLBjZgEAoGpRpGhyYMHi9Ebapkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611832; c=relaxed/simple;
	bh=8jWFPdLFDN+8Ep6iSkcVUtdmybE//sELBKXGEdHVpXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4w24VZJLiE85eH+C/kqag/HUcZsdvfLFvksSk6NImWog4GGBFY4Z2/FfI7cMcRoJFmDvfQCehvWaJeY6wW/rGnamCJIDIQuM3pVteALEmx2AHLMPOMa5Qm3CnIi3Vzu001bNOdzEpNBjOu/UtAKmQ2MkYrfNqHr0vB+w2nQWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so1992675a12.0;
        Fri, 06 Sep 2024 01:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725611828; x=1726216628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU3p+kGDxT8pD2/VuCxTs6mx2rQ91JWp00lS3cMXX7o=;
        b=cKwJQzJe6lbh3yO6RPiFYYbf/L8Ptch5oZ9rX+bsmKeLS717UAiMd61bbXFKyRBYbU
         lVM0o0oDxdQ3Hd9t97jWFJBSDMpi14ifoG6PQIv6wyVw7B9O/i0CTUkfB7zPqdFPd69P
         VVZdtLv93KWH37F91wiIMaYCa+Tv6lw/HFnGYpbXuBm/g3DyI9rJYwWLm2A5BlrScEFJ
         8UgcsABnQ6YWdhVBkySFRVkbiHccArCBC9zoi0mpM4ohqtBJlDOmPKruq2WxkNZ43wHu
         nP4jBCoXGpwXvvuGxME6Grq/nCHwvdO5Qk5xVD0dKP+qvD6lIiExXBIQ+qU6nX1E+8GH
         4FWw==
X-Forwarded-Encrypted: i=1; AJvYcCUSPR184iK2yZBSRQG3bED6GIumwrGX/dq2hfDoO3rgsm+CA8TbwvjA4Q+d/W2cUN4YISDMtwfB@vger.kernel.org, AJvYcCWGxQFxe8Fl3vHC8IpPzPrBrTF1Cu99FBIT9H5Q0Ldt9fxei0zK6ZfsR12uPoyF4o+94ilvnnX/EqCq10M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qGgg56F2ks0TZoJCb2emdJZDdDcfn3czdZHYa0k/57WdPFMM
	ReJ0AahNdKt0AiujjPeLOrXW9TbeqchJ5V3gCgsx+plE+87bD6+R
X-Google-Smtp-Source: AGHT+IHltrD5UjRcY/7U8bmhp8k6K2DQDnNReHj5qX0RdQfqnl75pXXDmehMizUX10WWN5u1FoGShA==
X-Received: by 2002:a05:6402:40c5:b0:5c3:cc7d:c2b1 with SMTP id 4fb4d7f45d1cf-5c3cc7dc558mr3780813a12.7.1725611827669;
        Fri, 06 Sep 2024 01:37:07 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc52a227sm2181357a12.8.2024.09.06.01.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:37:07 -0700 (PDT)
Date: Fri, 6 Sep 2024 01:37:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 6/9] net: netconsole: track explicitly if
 msgbody was written to buffer
Message-ID: <20240906-tremendous-intelligent-slug-fdd3cb@devvm32600>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-7-leitao@debian.org>
 <20240904110726.GT4792@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110726.GT4792@kernel.org>

On Wed, Sep 04, 2024 at 12:07:26PM +0100, Simon Horman wrote:
> On Tue, Sep 03, 2024 at 07:07:49AM -0700, Breno Leitao wrote:
> > The current check to determine if the message body was fully sent is
> > difficult to follow. To improve clarity, introduce a variable that
> > explicitly tracks whether the message body (msgbody) has been completely
> > sent, indicating when it's time to begin sending userdata.
> > 
> > Additionally, add comments to make the code more understandable for
> > others who may work with it.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Thanks,
> 
> The nit below notwithstanding this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> >  drivers/net/netconsole.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 22ccd9aa016a..c8a23a7684e5 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1102,6 +1102,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
> >  	 */
> >  	while (offset < body_len) {
> >  		int this_header = header_len;
> > +		bool msgbody_written = false;
> >  		int this_offset = 0;
> >  		int this_chunk = 0;
> >  
> > @@ -1119,12 +1120,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
> >  			memcpy(buf + this_header, msgbody + offset, this_chunk);
> >  			this_offset += this_chunk;
> >  		}
> > +
> > +		if (offset + this_offset >= msgbody_len)
> > +			/* msgbody was finally written, either in the previous messages
> > +			 * and/or in the current buf. Time to write the userdata.
> > +			 */
> 
> Please consider keeping comments <= 80 columns wide.
> Likewise in other patches of this series.
> 
> checkpatch can be run with an option to check for this.

Thanks for the heads-up. I've just added `--max-line-length=80` to my
checkpatch by default

Thanks

