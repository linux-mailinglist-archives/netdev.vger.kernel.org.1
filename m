Return-Path: <netdev+bounces-56145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA4080DF8D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4DF1C2148B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F656763;
	Mon, 11 Dec 2023 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="29HkDM6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99358CB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:35:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50be3611794so5996045e87.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702337710; x=1702942510; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXY7e500hmNXrMNW5LxQF/EcbdWReg4kST5Ve6+Epyw=;
        b=29HkDM6+PiF8+v813njHYibMewvgVDE2FMMG7F2dpVDEYGQl+YYSB3t6NGtn0difQa
         ma4OSt4bhHmiK7BEJQNfTC3UO7K/tuCx6lrPpm3AHRh9k3YcA4FWi7UD4FTT1DNJCMg4
         MDLPfMFPM65yNKEN0rqqxaQLq7xs0OFsA3aMhND/YZXi9cmn2/e2VM908vkA9EmD8Vub
         U6wY6cNFxWZdmO2T+KtFML/gXeP5kEXiF9Jw0s5Em6YPrMNbN42CxRcZx007XMecqwBo
         FCVXt4T9jBL+iAzGOUUwFypoo8Uh84hyaMj9Bls/Zmqe4PcsZ27A889WQ5W8g7T3z8f7
         kerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337710; x=1702942510;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXY7e500hmNXrMNW5LxQF/EcbdWReg4kST5Ve6+Epyw=;
        b=nusDTeIJRfqPt9KGJJOlOjyk/Cuf9DncKcswcuw0f64EvLr3w3YNPRwNtmt7YBkfdt
         KauZsjecVIGsrtEQY4hmMt4VQdSQ+TjaciYs402UrQeDYM5wbv6mbBLkT116jBc7AgXa
         8UUzTki5tSceU8n/0kyBSjCgnVY6Zjh7E0je4S6fqWrOwvzVpDnycYHgoxc7YefMFK6j
         ymTAkPCx5V0ao77CyBJy/hWXRGwu9b7+x0wnRgNQTCvOBfj3mY+LZ+2U7wKMaFjmpMNT
         cGpeUhrDCKfIhPYLapsbW8350Z0NsYZXltX9fHP95yl8OpfksvTGTqUJcdyRMaUzdwii
         ZHsQ==
X-Gm-Message-State: AOJu0YyMgcW1DPolQLjIyfSI2WuoY5+IuXx6ne39US6ILKAsQnQXT5Kk
	bq9jNP0zCckqAxJymCGZlRh359i2IQRmo8hBQJ8=
X-Google-Smtp-Source: AGHT+IEhY6H6pd0TMXYRyGvD7yegT6NUWM7vVe5igfYXm8ubepGJA+BuHDwGTzdiYwlkhJ3GnYbdVQ==
X-Received: by 2002:a05:6512:619:b0:50c:21c0:d6c0 with SMTP id b25-20020a056512061900b0050c21c0d6c0mr2396947lfe.4.1702337710246;
        Mon, 11 Dec 2023 15:35:10 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id l6-20020ac25546000000b0050bedf3bf8dsm1204078lfk.161.2023.12.11.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:35:09 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram
 counters to ingress traffic
In-Reply-To: <aeac0d23-26e3-4415-9a77-f649d3d48536@gmail.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-7-tobias@waldekranz.com>
 <aeac0d23-26e3-4415-9a77-f649d3d48536@gmail.com>
Date: Tue, 12 Dec 2023 00:35:08 +0100
Message-ID: <87plzc8g9f.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On mon, dec 11, 2023 at 15:03, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 12/11/23 14:33, Tobias Waldekranz wrote:
>> Chips in this family only has one set of histogram counters, which can
>> be used to count ingressing and/or egressing traffic. mv88e6xxx has,
>> up until this point, kept the hardware default of counting both
>> directions.
>
> s/has/have/
>
>> 
>> In the mean time, standard counter group support has been added to
>> ethtool. Via that interface, drivers may report ingress-only and
>> egress-only histograms separately - but not combined.
>> 
>> In order for mv88e6xxx to maximalize amount of diagnostic information
>> that can be exported via standard interfaces, we opt to limit the
>> histogram counters to ingress traffic only. Which will allow us to
>> export them via the standard "rmon" group in an upcoming commit.
>
> s/maximalize/maximize/
>
>> 
>> The reason for choosing ingress-only over egress-only, is to be
>> compatible with RFC2819 (RMON MIB).
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> Out of curiosity: does this commit and the next one need to be swapped 
> in order to surprises if someone happened to be bisecting across this 
> patch series?

I'm not sure I follow. This commit only changes the behavior of the
existing counters (ethtool -S). If it was swapped with the next one,
then there would be one commit in the history in which the "rmon"
histogram counters would report the wrong values (the bug pointed out by
Vladimir on v2)

> Unless there is something else that needs to be addressed, please 
> address the two typos above, regardless:

s/Unless/If/?

> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for the review!

