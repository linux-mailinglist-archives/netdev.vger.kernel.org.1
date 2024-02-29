Return-Path: <netdev+bounces-76081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172C86C379
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2815E2856F2
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206E4F5F2;
	Thu, 29 Feb 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K9JnNayi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD024EB5F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195350; cv=none; b=O3E3jclEF1N0dV3In1d9DNZoXOZ1A9X4LtG0jVsAha5rgIgjjkl0P9YxZ5iRX4TqNddA7drXzDC3oyy33y6zTK22BNdm8anHAc/zF2RUoqfAjYMeVJ9nds1hZR97ZKjSvldQpqVU8xKfdxkgoLGj4IYts5zv+NaAgU+6ZC157oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195350; c=relaxed/simple;
	bh=ZaWFVUtbXWHU3kBKA8aCQ5Xqw2yXOUmHdmNjz8jKPKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvWYcYWzJCPdyxx7PYTFVqrCQay3zorjOpsEmhq0vprighr42lhEBPAT5E1c/iHJ+kJd1QliShnRqYefatAME+zNEqK88ZIzGwzl5Yanfx1PxRwh+4o6X49iyREXhn8XLZXo8IHRJej127AjvCfrVV6d4TKd7641ZzkMT1/7m7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=K9JnNayi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d484a58f6so97180866b.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709195347; x=1709800147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOVIjRZwUi3OP0ICTb94t+OLC23i5YOcL9eCekTbZPs=;
        b=K9JnNayi9xRtEG4c5eqXLUWxLYcPqx0ygObP7tSRcffPxj62cVrqz1z1y4p92v/sjx
         fII8I65ixMXvDoLaCd4WBmV7BZtjSR0ufdUrAJKI1vZE0Zdes+rnAqEL6wqMO1459hJ7
         z9kusWpKTqe8inb2haMBHnW4bAveIPXiTxAz7nJN7XLi574N2ScrWqUKEp+c0Kvo4Wu3
         3D6tUXdxTcLf8JnyIxP+ieWfZe4WRoqHxHThotg3APPGTK6B3f1DhZWur9UhZ3kYnp6I
         0A6WaNJN9lZHSI5hFxQLJPWdfVMpTB5I09KJ8TCTmIEpKWF7KmEKRsSniij3ozqSkp+E
         WSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195347; x=1709800147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOVIjRZwUi3OP0ICTb94t+OLC23i5YOcL9eCekTbZPs=;
        b=IoVXpImobLGsLrULlUII1LoIHWnHHp1/HtT7W50WJ5tMD3rQoBMz3UJCxAs/2sVa+K
         jr2Q/QuqtRQh04JgQ/Fzc2zSu21e9Iy1Kh9fVk5/AG9FghdLPfY9T2hW7U/+BWc7YPj6
         YUEnixHegDDyHbJFalyMWvCGh+5Efbnfquo5j3l+JKePhsbd028SmB53mG0f3cfEP8uN
         szqsx40wONijO/KEdUjb7vqtF8TBXVSGw0fRrtTNUSY7eKLgpn2SdvwCmCU+ysS5tkdA
         wFEbZ7VARCX9vRYuztXQ84khah6Bzh3HeDBR4qfxhcEkQFDLhw/h4fDOyllqFPF5hSzr
         z0lg==
X-Forwarded-Encrypted: i=1; AJvYcCU0euYMO2c83UG/kjX1m6bC960UsCUyGSR3HSQHtKI7dR5BPsN5IT/SjJHIfYZ8Q8dXmsLb9Vw2xD6iFkb4vYD4zVKDvrDc
X-Gm-Message-State: AOJu0YxJoH0d/9ZHGZNJZDPqMrPhKC1H/nnlFepBTqx1AyyMPduVspLQ
	BBpTb7QCG3TSdrSbGt6GCvFpQiVqnxNw14nkrQMdTosFmsFCOjnS542w7rG6PZg=
X-Google-Smtp-Source: AGHT+IHOsykAlHp6FlMsC+tMKVUNs0F+mCLMXs6tZudAp22W3qQ8gDmpnaBgmGlInFIpQz4wgYzCEw==
X-Received: by 2002:a17:906:f28d:b0:a43:21fb:d0db with SMTP id gu13-20020a170906f28d00b00a4321fbd0dbmr836411ejb.10.1709195347028;
        Thu, 29 Feb 2024 00:29:07 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm430831ejb.130.2024.02.29.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:29:06 -0800 (PST)
Date: Thu, 29 Feb 2024 09:29:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"nathan.sullivan@ni.com" <nathan.sullivan@ni.com>,
	"Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
Message-ID: <ZeBAUeuoOv3UgILE@nanopsycho>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
 <Zd7-9BJM_6B44nTI@nanopsycho>
 <Zd8m6wpondUopnFm@pengutronix.de>
 <PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>

Wed, Feb 28, 2024 at 06:43:03PM CET, jacob.e.keller@intel.com wrote:
>
>
>> -----Original Message-----
>> From: Oleksij Rempel <o.rempel@pengutronix.de>
>> Sent: Wednesday, February 28, 2024 4:28 AM
>> To: Jiri Pirko <jiri@resnulli.us>
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
>> kuba@kernel.org; pabeni@redhat.com; edumazet@google.com;
>> netdev@vger.kernel.org; richardcochran@gmail.com; nathan.sullivan@ni.com;
>> Keller, Jacob E <jacob.e.keller@intel.com>; Pucha, HimasekharX Reddy
>> <himasekharx.reddy.pucha@intel.com>
>> Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
>> 
>> On Wed, Feb 28, 2024 at 10:37:56AM +0100, Jiri Pirko wrote:
>> > Tue, Feb 27, 2024 at 07:49:41PM CET, anthony.l.nguyen@intel.com wrote:
>> > >From: Oleksij Rempel <o.rempel@pengutronix.de>
>> > >
>> > >The i211 requires the same PTP timestamp adjustments as the i210,
>> > >according to its datasheet. To ensure consistent timestamping across
>> > >different platforms, this change extends the existing adjustments to
>> > >include the i211.
>> > >
>> > >The adjustment result are tested and comparable for i210 and i211 based
>> > >systems.
>> > >
>> > >Fixes: 3f544d2a4d5c ("igb: adjust PTP timestamps for Tx/Rx latency")
>> >
>> > IIUC, you are just extending the timestamp adjusting to another HW, not
>> > actually fixing any error, don't you? In that case, I don't see why not
>> > to rather target net-next and avoid "Fixes" tag. Or do I misunderstand
>> > this?
>> 
>> From my perspective, it was an error, since two nearly identical systems
>> with only one difference (one used i210 other i211) showed different PTP
>> measurements. So, it would be nice if distributions would include this
>> fix. On other hand, I'm ok with what ever maintainer would decide how
>> to handle this patch.
>> 
>> Regards,
>> Oleksij
>
>Without this, the i211 doesn't apply the Tx/Rx latency adjustments, so the timestamps would be less accurate than if the corrections are applied. On the one hand I guess this is a "feature" and the lack of a feature isn't a bug, so maybe its not viewed as a bug fix then.

The behaviour of i211 is the same as it always was. I mean, 3f544d2a4d5c
didn't cause any regression. From that perspective, it is clearly a
feature.

I know that in netdev we are taking the meaning of "Fixes" quite on the
edge often, but I think this is off the cliff :)


>
>Another interpretation is that lacking those corrections is a bug which this patch fixes.
>
>Thanks,
>Jake
>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

