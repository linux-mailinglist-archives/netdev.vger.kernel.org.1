Return-Path: <netdev+bounces-241775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60439C880E1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1AA4E132C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B672634;
	Wed, 26 Nov 2025 04:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlPqs/ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6A168BD
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131468; cv=none; b=pD8SXaSRV7sJYwOPHhNu9VEzfkiRYTskYoPPB9YGYNLGmWBQ6q7q3psrn8FGZGQjufgaa28OqmNAHJv0IGBBoAIWupibHAXE6zC/05/u615f+clDmq37YLzOutJDZyEitfFk+JHW5os77siNmNuKX+7ql33BRXzI8CJyJmDT0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131468; c=relaxed/simple;
	bh=v+E3eJNKSSEAfN8XqzQs8Ow/ujM5L9J/a9y9ZXyPdM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNEZaJrUWSf+kBaHWXhXgUH4E84aeqwFugMy73qLFFpy0pNgTBv/8+cIWvLCoosYQobB1JPCjm2Zi8RFYL9QJTIfchOLRuS9gCQ+RtibiO1wccsO5fSCv084HCFLzUQigVxZ1IYMN0zB8FcrDo2vrxubFD+8bMgNh4sW0JqqQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlPqs/ih; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso6958445b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764131466; x=1764736266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+0j5ZCXovitLFtrZUw5JaximmZcnfm7BzzfoeHP48I=;
        b=TlPqs/ihS8FvSPHW7G4tYZuFGmoDS4r43C/KqPZEzsu0PbAzCm4uXvk6J0SEblZa9N
         UDNageARJIAw64yPx8ftfp1qF8ppBI0NyDa3lMLmot9Kxb/A+hQytC0AGd41XwkT9qbr
         B+HZxTkAMaAOe5Q3HrPH84Nn9y6V29GGE419NQNTHuhFruOSO6mUG4QumZqFDWOSuH1A
         Lfj40LfkZ7Ae8/wTurb7iM7BLBEDw+oaxpVRBVE7zVGBXbwdXjvsph1/N0CsnNex7dQs
         qhhaywVL9XcOOTNorGl6lU9QTjUFYFaKpfo2R76q4xmYLFpyLw6B1WaDNpfp/1dwV1dn
         W4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764131466; x=1764736266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+0j5ZCXovitLFtrZUw5JaximmZcnfm7BzzfoeHP48I=;
        b=LXyuSGD5C3iTWXuN7n5ZlL8AWtte7ST4Graf43xylRuJ8rrahLEgOCsoGZohO0V/J1
         sYuRtfDfyqkyH2pzMtTUZ3l1IaAWCGAl4DG+groHp6KE1PFJxPCEfjSxEWKfmw01wXWe
         1uwL1x4m33QtZ9w533YrZ/UlGiE/WZ6ZD2Uc9WB0Hi7xa6salR+yk3HisEy6y3YHEfcI
         HiGogUiCUzo136nj4GWBO7jtZeUS133ozCIPdMKOrPy8Ay2K5uBzpuojDtycmKQJxoo8
         ipV4EiF3b4du8CNeq/i1Tkj+NRc38F2aN4petXVGzr5lOuiocNg8Q0xmo7JlHNphftXW
         OgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOyOazDujJNw9UzqbAz+zRzoEBrO4MlAOSLT7RzQyZ0MInjKQwsphio1Q86dcHPAsNCseZzwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawAD48XTDRn8nsZvczkhsjHU1V/aXHpib4tmUlOvmYHq11RyP
	E+yIOSd2tNzJI4B0i16KCwZ4fgcEa7t4H1k3nN6ZUcdGlujZL4qmOnLf
X-Gm-Gg: ASbGncsdKlHEfxbQ8yP+AGt9LCPZsiVxF6x4DhjU47+dHdRrKbyWu8mfqibFljIqETv
	E9QjILYkk4DnIsezc+ClWBcE0BsaFRusMIwlDRtMTtyA7/E0iImAKONtzpB+tlvyBV5PB/REg5P
	U6VAubVv2Um1Xw+GZy3DHv3krm1AtLq3oR4+bWdpIPkHzZb7EE0yQ7P9Ar0oe8r/DlMYrzUvbVF
	YZMPDj7b+tUpa1RClYhov2L4qjD6PEZroobo1Dw7SLZjcOXobjYFbPgEQi3EEndnvkev41cDD9S
	1Cl6fCy2/spPiXJBEcLsi5SNou5U+ypzv0zlYUvznhIWV0ZBzZE4Mw2EjM45cBoeG6tvXcIiU7Y
	WFIRkxpZLBa7gaDW+fkDD/57lvxZ7aUXlYs9by5yp0o+4nygYeZIsf5F7uNyv2sbovOWY9x0Hfj
	MR43Ic3mKSKaLFNgtI
X-Google-Smtp-Source: AGHT+IEgFSocOGRxdsFFHqcX/YYQDzfJhKqycM/hi1zu+7nlJPv9Vwh3GUd1FyO8F3MlsgtDdk85iQ==
X-Received: by 2002:a05:701b:2803:b0:11b:2138:476a with SMTP id a92af1059eb24-11c9d8539eamr9419041c88.27.1764131465883;
        Tue, 25 Nov 2025 20:31:05 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:a2cf:2e69:756:191b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6da4dsm83069512c88.9.2025.11.25.20.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 20:31:05 -0800 (PST)
Date: Tue, 25 Nov 2025 20:31:04 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk,
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v6 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
Message-ID: <aSaCiO/+zrzk9eF1@pop-os.localdomain>
References: <20251125220213.3155360-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125220213.3155360-1-xmei5@asu.edu>

On Tue, Nov 25, 2025 at 03:02:12PM -0700, Xiang Mei wrote:
> @@ -1927,24 +1928,30 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	if (q->buffer_used > q->buffer_max_used)
>  		q->buffer_max_used = q->buffer_used;
>  
> -	if (q->buffer_used > q->buffer_limit) {
> -		bool same_flow = false;
> -		u32 dropped = 0;
> -		u32 drop_id;
> +	if (q->buffer_used <= q->buffer_limit)
> +		return NET_XMIT_SUCCESS;
>  
> -		while (q->buffer_used > q->buffer_limit) {
> -			dropped++;
> -			drop_id = cake_drop(sch, to_free);
> +	prev_qlen = sch->q.qlen;
> +	prev_backlog = sch->qstats.backlog;
>  
> -			if ((drop_id >> 16) == tin &&
> -			    (drop_id & 0xFFFF) == idx)
> -				same_flow = true;
> -		}
> -		b->drop_overlimit += dropped;
> +	while (q->buffer_used > q->buffer_limit) {
> +		drop_id = cake_drop(sch, to_free);
> +		if ((drop_id >> 16) == tin &&
> +		    (drop_id & 0xFFFF) == idx)
> +			same_flow = true;
> +	}
> +
> +	/* Compute the droppped qlen and pkt length */

Just a nit: this comment is not needed, because the code below is
readable enough to explain itself. :)


Regards,
Cong Wang

