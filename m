Return-Path: <netdev+bounces-54116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25C806078
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2824228207A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177386E58D;
	Tue,  5 Dec 2023 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="NRV/mgjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEC18B
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:13:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so37092161fa.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 13:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701810795; x=1702415595; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=istTDf0KHGtUzZEzp1vwhnOeiv2No26sNUCnsg/mZw0=;
        b=NRV/mgjFsz/ObKbX26mbnYofTFtfbOCl9CQ3eTpgcGpujWP1TszxwQCb3hEFHVnUYQ
         XEeJE/xpGZYzx9Wm+QJSXssXsrTs4nGe2GnwUKAV63n6OQ1F6s9HY49yLHF2D0aP/cSJ
         5VF0Ejr/X69nBA6ZxCZpdLSq40PYRgNE9hgAzx07wvq2ysadAuDWrihYNuYXsJbSgLC5
         5obmztGGe0WGdV0RUlVYhaTemMSjREgI1MkAMacy/yU5Pk2YJ+HN4GtlyLh0Rdet1LOs
         vpPw2K0rEaDygoDgqXrlSsJmlXt+fhNBgQzB13BOCYWdHD72Jg7NJeJCALnImuSsK3J3
         wVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810795; x=1702415595;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=istTDf0KHGtUzZEzp1vwhnOeiv2No26sNUCnsg/mZw0=;
        b=MCHIwgTelSwM7bbZxtdoOPOSzZYGmW8wX+IIv2m89Ia6R0y3pqdjMhd0mGctdKvzoE
         BtwL/tAUEx0XBCvqqWkMxuGKRSyEjS2KTBnDp2xxxfOkqHqq0G+aBhBhn8PAtJVoJj3w
         ebvioNkT9qDQ5OrpNyHZTKecjrgTSu0YAobZcWY79cYvIjQxw4764BHpdsLtL8h8a9d4
         7oDGpKC6lL/HrKeelezCPc5qc2FdBXXrQntuw9N7RpAWQlrAkF38s2rza396pFtSLv0o
         Mua6rQO7BP0blzCeTlhjt/FCzL3MaxDfMdL3fRyZ9uuQT4Mec84mqzR/7yTfi82xW8L2
         hYSA==
X-Gm-Message-State: AOJu0YzjkjAf2lTjnl0j+BUuqHaKHg2DL0Jw2TR9Cys3cqRh5ztxQdle
	G8W4O7aYAPIrlM6N4yeNIXUoXbuzzn1pdDSMJQo=
X-Google-Smtp-Source: AGHT+IHL40KrnqTaUn7AGxhIo959OPompFqeurkQKUwy4VoyTf6haN4TwZyiKI5UUqbFYsXWRO66bA==
X-Received: by 2002:a2e:b166:0:b0:2c9:fab4:65a7 with SMTP id a6-20020a2eb166000000b002c9fab465a7mr2384976ljm.92.1701810794920;
        Tue, 05 Dec 2023 13:13:14 -0800 (PST)
Received: from wkz-x13 (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id s9-20020a05651c048900b002c9f975619asm1016546ljc.57.2023.12.05.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:13:14 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/6] net: dsa: mv88e6xxx: Fix
 mv88e6352_serdes_get_stats error path
In-Reply-To: <20231205175040.mbpepmbtxjkrb4dq@skbuf>
References: <20231205175040.mbpepmbtxjkrb4dq@skbuf>
Date: Tue, 05 Dec 2023 22:13:12 +0100
Message-ID: <871qc09wuv.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tis, dec 05, 2023 at 19:50, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Tue, Dec 05, 2023 at 05:04:15PM +0100, Tobias Waldekranz wrote:
>> mv88e6xxx_get_stats, which collects stats from various sources,
>> expects all callees to return the number of stats read. If an error
>> occurs, 0 should be returned.
>> 
>> Prevent future mishaps of this kind by updating the return type to
>> reflect this contract.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>> diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
>> index 3b4b42651fa3..01ea53940786 100644
>> --- a/drivers/net/dsa/mv88e6xxx/serdes.c
>> +++ b/drivers/net/dsa/mv88e6xxx/serdes.c
>> @@ -187,7 +187,7 @@ int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
>>  
>>  	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
>>  	if (err <= 0)
>> -		return err;
>> +		return 0;
>
> Ok, you're saying we don't care enough about handling the catastrophic
> event where an MDIO access error takes place in mv88e6xxx_g2_scratch_read()
> to submit this to "stable".

It just felt like one of those theoretical bugs that, if you were to hit
it, you most likely have way bigger issues than not getting at your
SERDES counters; and since, as you say...

> I guess the impact in such a case is that the error (interpreted as negative
> count) makes us go back by -EIO (5) entries or whatever into the "data"
> array provided to user space, overwriting some previous stats and making
> everything after the failed counter minus the error code be reported in
> the wrong place relative to its string. I don't think that the error
> codes are high enough to overcome the ~60 port stats and cause memory
> accesses behind the "data" array.

...the potential for data corruption seems low. But I could send a v3
and split this into one change that only fixes the return value (which
could go into -net), and another one that changes the type. Do you think
it's worth it?

