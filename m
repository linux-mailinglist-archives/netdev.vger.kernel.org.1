Return-Path: <netdev+bounces-115379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8389461AA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B941F21238
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2A1A83A8;
	Fri,  2 Aug 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0gYikyhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24431A83A1
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615338; cv=none; b=IXcFPHooRdhyOcC974d+BH8D7DCrYvk8VL68fbSoSIwWifts9SzncvG0eZkR69f7mmun5NZnU8hbLn/mQhBdmteiaAUrHOQ5ODnzpd0y4xCFdac8isnmGN+44kMpxREkFzFAvqAdwik12lbwYV//4xLQ40e2J7HEff62ANVJrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615338; c=relaxed/simple;
	bh=oAkLdxkWv0l+7HbjNR2Ld9gF2rjeT+QORflet7E6mXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akc2tcouWHPUK5ghqWrAb04VgfQr1h3T0TZNp5Fdhnes7zWE7evjUrBQGrjxYD7LiEU4dgRhXsIE0u/nILauaSLzwpsmTPitwUsKgBzt1e2VCA8Q/dhNCj08iedOyFNdmPtgHR1pZMoURHVpHCm7YIu1EcWm4SHoGMhC3nhTpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0gYikyhT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e1915e18so14161825e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722615335; x=1723220135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIfLAoztfCJg5cZ2DunBMhevoQLG5ZbDJkvX8mLD1uc=;
        b=0gYikyhTF3mFGdknb1AWo2goBgxVE0OkSiw5oMh6p12o4fWC6UkgqZnU932RulUU2p
         Rg2nALjeWBaq148Ub+N3auKtA0cAsr3w+K/RGBilvYRFXWoSbrfCioJu/PUAk/eEGp+K
         lcKrbC3jh7iBZbKLJ/SK0yN9wyVQaQ8hdTM+SGuTg76G99a+6NxsTy/KsfuV/Qnvpdbm
         WKFoYHkHbJ28jZ9o3kdEhfF7wuicfVpq3rz/e9c6odv47x5nD3mn58N4tlnS9WRbqN69
         IyysthOSniENSmKo4zq5HmVLxF3HUkNPhOFa2BgeXxkFjCp0YFZ2v0Kd5c4dYQJqwslM
         1jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722615335; x=1723220135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIfLAoztfCJg5cZ2DunBMhevoQLG5ZbDJkvX8mLD1uc=;
        b=dY3bZyrpGYl5h3hhuIPYs2Orh2r/3FRGiqeOkawaEaUVEK1nmfzWc9Qy1QFMAp+PEM
         qFWldQ+ECnqBbKnIAbopGo+/48lwhxWWlrQOoD0jTu78E+ODJTmzzWADtaqvxKNxEypk
         ZffjLb/S0tMdDzaNQ8l8752bMdc6USCZWAt57H/O1eLiG05/nDeoF31J+8jRQPCZQtQE
         rwu65dMOyXWNm6EYaXaiLJxgUp863dLhG0Z3j2pEbR3MpS9u/r/qYUbpDHAfrU8D2J6F
         1qP0CnRM54bRDaEsYFCjS4PF8z23sqPWTNUyDF6qe7fIR30KESNjNKrDI4l8vkLL1L9O
         uHwA==
X-Forwarded-Encrypted: i=1; AJvYcCUwuNLt2IhteX53euoYrEfXl8i1Ola3Jht3a9/tT3OB5bDbFySj61/X4Pcz7J2CMWMI6HP/g8YNHtLh6J4lgzkCb/YzgSwT
X-Gm-Message-State: AOJu0Yxjy8o8xaprLsHAIgEAzP5meIaqAWwWoTQzY4SMYezLLoGUdOVq
	VOWg66P14L8CQSYMSbMVJesAMekvCYbFYjNVIRQQOGrkS7RClVf2on+wNRWAQY0=
X-Google-Smtp-Source: AGHT+IH++rSlsuaM/tJv9OsBgmnpn6rJ3JUneTXnni5b0p4mV9rTxZLMshNx+eOyCIFqX5/GJeOZMg==
X-Received: by 2002:a05:600c:4ed4:b0:428:1d27:f3db with SMTP id 5b1f17b1804b1-428e6b96374mr21708265e9.35.1722615334832;
        Fri, 02 Aug 2024 09:15:34 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa9esm99226685e9.2.2024.08.02.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:15:33 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:15:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 04/12] net-shapers: implement NL set and delete
 operations
Message-ID: <Zq0GJDGsfOt5MiAj@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
 <20240801080012.3bf4a71c@kernel.org>
 <144865d1-d1ea-48b7-b4d6-18c4d30603a8@redhat.com>
 <20240801083924.708c00be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801083924.708c00be@kernel.org>

Thu, Aug 01, 2024 at 05:39:24PM CEST, kuba@kernel.org wrote:
>On Thu, 1 Aug 2024 17:25:50 +0200 Paolo Abeni wrote:
>> When deleting a queue-level shaper, the orchestrator is "returning" the 
>> ownership of the queue from the container to the host. If the container 

What do you meam by "orchestrator" and "container" here? I'm missing
these from the picture.


>> wants to move the queue around e.g. from:
>> 
>> q1 ----- \
>> q2 - \SP1/ RR1

What "sp" and "rr" stand for. What are the "scopes" of these?


>> q3 - /        \
>>      q4 - \ RR2 -> RR(root)
>>      q5 - /    /
>>      q6 - \ RR3
>>      q7 - /
>> 
>> to:
>> 
>> q1 ----- \
>> q2 ----- RR1
>> q3 ---- /   \
>>      q4 - \ RR2 -> RR(root)
>>      q5 - /    /
>>      q6 - \ RR3
>>      q7 - /
>> 
>> It can do it with a group() operation:
>> 
>> group(inputs:[q2,q3],output:[RR1])
>
>Isn't that a bit odd? The container was not supposed to know / care
>about RR1's existence. We achieve this with group() by implicitly
>inheriting the egress node if all grouped entities shared one.
>
>Delete IMO should act here like a "ungroup" operation, meaning that:
> 1) we're deleting SP1, not q1, q2

Does current code support removing SP1? I mean, if the scope is
detached, I don't think so.


> 2) inputs go "downstream" instead getting ejected into global level
>
>Also, in the first example from the cover letter we "set" a shaper on
>the queue, it feels a little ambiguous whether "delete queue" is
>purely clearing such per-queue shaping, or also has implications 
>for the hierarchy.
>
>Coincidentally, others may disagree, but I'd point to tests in patch 
>8 for examples of how the thing works, instead the cover letter samples.

Examples in cover letter are generally beneficial. Don't remove them :)


>
>> That will implicitly also delete SP1.

