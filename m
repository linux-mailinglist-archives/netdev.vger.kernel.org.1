Return-Path: <netdev+bounces-125841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A229F96EE84
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A6128128B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608A13A3F4;
	Fri,  6 Sep 2024 08:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD11FAA;
	Fri,  6 Sep 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612503; cv=none; b=oTjZqF7AzoYyBC4EEf1t2WJtOH8QxUe+pQlWC5OblMPSwn8hAHA7vY+GdU0nYLtfs6Sr6Ha9cx1wR1YH2DJTvvJE6XoBm6cMkQ/aJpg1NvV+Ezpi5ZSYbKZLzB9olu+Vn3FFwSAtdp8lH0/tstPnSZ21EzDL7BhW/4jSXW/00R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612503; c=relaxed/simple;
	bh=wa+B/VX5ZH3+Qs1eU0YBOaeqkw6Kt+1kMu1rCCscQpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2OI4MhmjMkbmxaiUIXIRN95LqFEkTNY7zPnexjeY8MSQ2g+C3FampgSgcAZxyIk3qyZMOGxGXSq2ndslIkU0kXvqqV9smwgVSrIWMz5EgdxR177DoE0jmUV2ysjQCMKY8QCOuaxCbPs7jbDdQ0N9EoV7dHE1U6cddpy/6BMlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so1934270a12.1;
        Fri, 06 Sep 2024 01:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612500; x=1726217300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87rBKScRz3ev/bfm5D1NGFd+7Kine22vuIY6M5kV5Lw=;
        b=IrPa8Pnm+ng206k9RwY7LjjHaGdpmhjlKuAl2LehHZ8iAsn6psf1i5JbzLzE9tCoQw
         7GIrS+QiMaQTUuA74dzb6C6Zgt67cC+6WX783sb2PqmOxsuJgbe7h3+P0TJJup1LxTsQ
         kHpHLOhURXz9jaewsZ3KinPL+tbvSiyvrJVnIuOguaA3sMmPssHWqKC7cXbg6iUPJhv+
         fEvOMuvMlvCr6DBI3lrtGIyrSHqeO1REG02NAgYEQqJWePi18zIxaySV31PHlSBNH28h
         cKQa+1hPSTXawu3Mf2h+zIAj0ntAlkl3TPiWe6lOrHxzzH+HgiwyINLIeHwT4Ju6rmeR
         fOFg==
X-Forwarded-Encrypted: i=1; AJvYcCVz1fggcQH3evXyWL+JnikfXX48SjZVsa2JkA25KXJbwN/d8+jseM+Pul1p3eSD1ZgQUaISlhYP180yBZQ=@vger.kernel.org, AJvYcCWPjMkCoSpyW5IzYV/JGLsRk7UjzlsPIfRrnm/k+PrWfcSOo4A/hqUJ0YImppCTvaUUNOnjFFov@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCtUEFpkafseLCwOFROdA/AMFrMu+kLB4xyZOiG6JdGeRi7NW
	EIuvf7xpjTE4KCMp3HGVAo2j2c8+FxDoXLagmzRVq8Kg9Fa0vBuW
X-Google-Smtp-Source: AGHT+IGXKJGkXdghz404iaNV/EhyPOiJVH1hczaqYgw8PxZ1NSaq8x5JLDVIWhaaOX+IlCbNsIT31w==
X-Received: by 2002:a05:6402:35cf:b0:5c2:7699:fb6f with SMTP id 4fb4d7f45d1cf-5c3dc79783amr1163066a12.15.1725612498771;
        Fri, 06 Sep 2024 01:48:18 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc5425f6sm2173146a12.22.2024.09.06.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:48:18 -0700 (PDT)
Date: Fri, 6 Sep 2024 01:48:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 8/9] net: netconsole: split send_msg_fragmented
Message-ID: <20240906-spirited-versatile-cougar-2babed@devvm32600>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-9-leitao@debian.org>
 <20240904111636.GV4792@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111636.GV4792@kernel.org>

On Wed, Sep 04, 2024 at 12:16:36PM +0100, Simon Horman wrote:
> On Tue, Sep 03, 2024 at 07:07:51AM -0700, Breno Leitao wrote:
> > Refactor the send_msg_fragmented() function by extracting the logic for
> > sending the message body into a new function called
> > send_fragmented_body().
> > 
> > Now, send_msg_fragmented() handles appending the release and header, and
> > then delegates the task of sending the body to send_fragmented_body().
> 
> I think it would be good to expand a bit on why here.
> 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 85 +++++++++++++++++++++++-----------------
> >  1 file changed, 48 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index be23def330e9..81d7d2b09988 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1066,45 +1066,21 @@ static void append_release(char *buf)
> >  	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
> >  }
> >  
> > -static void send_msg_fragmented(struct netconsole_target *nt,
> > -				const char *msg,
> > -				const char *userdata,
> > -				int msg_len,
> > -				int release_len)
> > +static void send_fragmented_body(struct netconsole_target *nt, char *buf,
> > +				 const char *msgbody, int header_len,
> > +				 int msgbody_len)
> >  {
> > -	int header_len, msgbody_len, body_len;
> > -	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
> > -	int offset = 0, userdata_len = 0;
> > -	const char *header, *msgbody;
> > -
> > -	if (userdata)
> > -		userdata_len = nt->userdata_length;
> > -
> > -	/* need to insert extra header fields, detect header and msgbody */
> > -	header = msg;
> > -	msgbody = memchr(msg, ';', msg_len);
> > -	if (WARN_ON_ONCE(!msgbody))
> > -		return;
> > -
> > -	header_len = msgbody - header;
> > -	msgbody_len = msg_len - header_len - 1;
> > -	msgbody++;
> > -
> > -	/*
> > -	 * Transfer multiple chunks with the following extra header.
> > -	 * "ncfrag=<byte-offset>/<total-bytes>"
> > -	 */
> > -	if (release_len)
> > -		append_release(buf);
> > +	int body_len, offset = 0;
> > +	const char *userdata = NULL;
> > +	int userdata_len = 0;
> >  
> > -	/* Copy the header into the buffer */
> > -	memcpy(buf + release_len, header, header_len);
> > -	header_len += release_len;
> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +	userdata = nt->userdata_complete;
> > +	userdata_len = nt->userdata_length;
> > +#endif
> 
> I think that dropping the userdata parameter of send_msg_fragmented() ought
> to part of an earlier patch or separate patch. It doesn't seem strictly
> related to this patch.

I agree with you. Let me separate it in a different patch, then.

Thanks for the review,
--breno

