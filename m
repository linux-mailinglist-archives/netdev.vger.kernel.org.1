Return-Path: <netdev+bounces-249342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C66D16EEE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1908530312DB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F7350D62;
	Tue, 13 Jan 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuYheU6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75E25F98B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287583; cv=none; b=BuQZpyqguxJceEBYRBWyoqH/chZgbG7kiOHpukynv1my+/Ncx5ZaGyMVAcndWX9timeobrpcxz45anZclVPHTPy7UZ3GdWCCdyB+kIA0zefBUerZ+QlHqIk2iZOjg9PXr19LnQfo8UBCTXRiPrO3p3A0zPWUJeIq9W/MDPZ1N60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287583; c=relaxed/simple;
	bh=5kYm/f6y5eDZFOhknW/woguSkyF5acmAV11mLjLfnFE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rhGZuVSDuTl0t57j9nqmXPdl95Jzkr+p8zQCbkIOGVWvwyYly44VRxXzu3TYWykBmrz3MFQSSAWwF4Bjvw8TxToFRlL7gHIZTOX5bo3fkeQIgs1Mgw8cjdsf8hYv53x4M+kcRu7/0BUepMmSAgf1W8cWTFyZRx7WqaCvROSe5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuYheU6U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so52710875e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768287580; x=1768892380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGEtEJ71QhQ9scdgCDEq+WFEpq4/A8zAmzd+iyJjt4Y=;
        b=YuYheU6UvcVdiJE96wX1WT2U5neW6VxN54CsCmUbpF20qJEJFTmEAJbX0B8DCpkIOl
         aGZs3OwVb/Cs1LeGJDlDHLB8AMXsuwlAYtYRbm6zOWXwLxwBIX+qQ8R9nAFmFO1kGxv8
         2Q2OJyWas3N7J+BX2RgQOQZDwYLWWTitWHn76eSaU7Xmc4K65wv55hT0h25VyobJAE//
         jxjc1sWIGTVc+thbt/N/FGpRrom+ZpOv+nBXW5RbVVOJiJVqPKdqGI+1CLxpQs9gfSNT
         ZnA2H3q3yM+kIL99MsgcSx0WzuJBmQN5SPqZWIPVCqGdYtyU4GJGD9oQnuxTzZvqH9GC
         pe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287580; x=1768892380;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGEtEJ71QhQ9scdgCDEq+WFEpq4/A8zAmzd+iyJjt4Y=;
        b=YAYfmH01gMoUl0GzOp+dB9TeyrfgMtAZl9mCSbO6dfnkdIErjXdXzxWd2XFR/cKsuT
         ckCM4rpg7vZKMK+27tQrHVJuyD6AIfma97v104vocvKYTPCww957+OmBdfEKUNldtvTE
         r+jzUkTLxLVBHU/8Ah07/7nPt5o4e9WD6tVmX9dIF43MjB96rGx37LANNC/j0n/oKF31
         QPNKHWToUxHKXhRVBBXJMVt3doZmuE4drjQXtJ+Ay5EKb/fFGAu0ELndFJcN8geoi394
         6wBUhg3L4z3LBUBUpwq+rCCNYz4xhuP75CLJ2zWvlGPdUL0miiD8Z5TBrFEuhZly00ps
         laow==
X-Forwarded-Encrypted: i=1; AJvYcCVf7os5AxjjEBIKbhE0Ax+tpDoJk1BtrvFlzdAczHtXR/i7wdGCt4Q0sXvtoQvjjbV7RujrCdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8f0e+sHtETwdfEGaw2Og+uBTDRQZBaGn1EJUER+q7EwDex/gs
	10Yd1UHcO8CO/vFlcCIw1rGVgYEUO6CZ7jpr0868+MrdKfWIM88nd0rz
X-Gm-Gg: AY/fxX7YPw9g+5gUIaSEyIvbJ8Hh7OnWAL3H0IgpSDzDbA4cILdYrWHZjF69Zi3Y79k
	7BrbQESJ54ZbF6YU+s5BQr1+hgzVlcjMIKS+YU4Ppb5Ue0VrOhppcVn+DdGQfy5jOfHAuD2EudT
	ML1wDS6qEPDimuX2sJfrJVHWTbM5N6YUVpiz1UDgE9oUVpK2QHt+Rdrh14+Xvj6M/gyI7kR4vm0
	V4vlw5GioG9Le672T0REDIs9wvp9GpEtfnmjYKWIEvxw8M3WK9Z3WUTUi7v8/qziLRBXo021NFU
	HoeBeDfsVBN1AzeRlGI94tW993y4YgK3eCBmXAqNFbMQAiJ2QQuKQ+kPXmmxfFL9R79G/dbk+OV
	c/nb/VBFIjCG8n/6tiiZd8TxHqRzfGf9sJWX6W1t5na0Da5U2GaJzoRhHpWYwea7HRIBY6dm8Ys
	DLreE4h1ZQ+vkG1hxu360fPsyAlrLRSj6WHQ==
X-Google-Smtp-Source: AGHT+IEQjxI6fpER4WRXmfHttzhiU1CsOOFkXmnEbm2lJSnSadsG1UWd7h31FAWSaH5F7soVC2ZyQQ==
X-Received: by 2002:a05:600c:6287:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-47d84b1861bmr218312995e9.11.1768287580133;
        Mon, 12 Jan 2026 22:59:40 -0800 (PST)
Received: from ehlo.thunderbird.net ([80.244.29.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm387368335e9.1.2026.01.12.22.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:59:39 -0800 (PST)
Date: Tue, 13 Jan 2026 08:59:36 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Slark Xiao <slark_xiao@163.com>
CC: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Muhammad Nuzaihan <zaihan@unrealasia.net>, Daniele Palmas <dnlplm@gmail.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Johan Hovold <johan@kernel.org>
Subject: Re:Re:[RFC PATCH v5 0/7] net: wwan: add NMEA port type support
User-Agent: K-9 Mail for Android
In-Reply-To: <3669f7f7.1b05.19bb517df16.Coremail.slark_xiao@163.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com> <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com> <DF8AF3F7-9A3F-4DCB-963C-DCAE46309F7B@gmail.com> <3669f7f7.1b05.19bb517df16.Coremail.slark_xiao@163.com>
Message-ID: <845D539E-E546-4652-A37F-F9E655B37369@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 13, 2026 4:03:19 AM, Slark Xiao <slark_xiao@163=2Ecom> wrote:
>At 2026-01-09 15:11:58, "Sergey Ryazanov" <ryazanov=2Es=2Ea@gmail=2Ecom> =
wrote:
>>On January 9, 2026 5:21:34 AM, Slark Xiao <slark_xiao@163=2Ecom> wrote:
>>>At 2026-01-09 09:09:02, "Sergey Ryazanov" <ryazanov=2Es=2Ea@gmail=2Ecom=
> wrote:
>>>>The series introduces a long discussed NMEA port type support for the
>>>>WWAN subsystem=2E There are two goals=2E From the WWAN driver perspect=
ive,
>>>>NMEA exported as any other port type (e=2Eg=2E AT, MBIM, QMI, etc=2E)=
=2E From
>>>>user space software perspective, the exported chardev belongs to the
>>>>GNSS class what makes it easy to distinguish desired port and the WWAN
>>>>device common to both NMEA and control (AT, MBIM, etc=2E) ports makes =
it
>>>>easy to locate a control port for the GNSS receiver activation=2E
>>>>
>>>>Done by exporting the NMEA port via the GNSS subsystem with the WWAN
>>>>core acting as proxy between the WWAN modem driver and the GNSS
>>>>subsystem=2E
>>>>
>>>>The series starts from a cleanup patch=2E Then three patches prepares =
the
>>>>WWAN core for the proxy style operation=2E Followed by a patch introdi=
ng a
>>>>new WWNA port type, integration with the GNSS subsystem and demux=2E T=
he
>>>>series ends with a couple of patches that introduce emulated EMEA port
>>>>to the WWAN HW simulator=2E
>>>>
>>>>The series is the product of the discussion with Loic about the pros a=
nd
>>>>cons of possible models and implementation=2E Also Muhammad and Slark =
did
>>>>a great job defining the problem, sharing the code and pushing me to
>>>>finish the implementation=2E Daniele has caught an issue on driver
>>>>unloading and suggested an investigation direction=2E What was conclud=
ed
>>>>by Loic=2E Many thanks=2E
>>>>
>>>>Slark, if this series with the unregister fix suits you, please bundle
>>>>it with your MHI patch, and (re-)send for final inclusion=2E
>>>>
>>>>Changes RFCv1->RFCv2:
>>>>* Uniformly use put_device() to release port memory=2E This made code =
less
>>>>  weird and way more clear=2E Thank you, Loic, for noticing and the fi=
x
>>>>  discussion!
>>>>Changes RFCv2->RFCv5:
>>>>* Fix premature WWAN device unregister; new patch 2/7, thus, all
>>>>  subsequent patches have been renumbered
>>>>* Minor adjustments here and there
>>>>
>>>Shall I keep these RFC changes info in my next commit?
>>>Also these RFC changes info in these single patch=2E
>>
>>Generally, yeah, it's a good idea to keep information about changes, esp=
ecially per item patch=2E Keeping the cover latter changelog is up to you=
=2E
>>
>>>And I want to know whether  v5 or v6 shall be used for my next serial?
>>
>>Any of them will work=2E If you asking me, then I would suggest to send =
it as v6 to continue numbering=2E
>>
>>>Is there a review progress for these RFC patches ( for patch 2/7 and=20
>>>3/7 especially)=2E If yes, I will hold my commit until these review pro=
gress
>>>finished=2E If not, I will combine these changes with my MHI patch and =
send
>>>them out asap=2E
>>
>>I have collected all the feedback=2E E=2Eg=2E, minor number leak was fix=
ed=2E Fixed one long noticed mistype=2E And collected two new review tags g=
iven by Loic=2E So, my advice is to use these patches as base and put your =
MHI patch on top of them=2E
>>
>Hi Sergey,
>I didn't find the review tags for your patch 2/7 and 3/7 until now=2E Am =
I missing something?

You are right, there are no review tags have been given for these patches=
=2E If it works for your device, just send the complete series=2E You testi=
ng going to be enough=2E

--
Sergey

Hi Slark,

