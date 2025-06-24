Return-Path: <netdev+bounces-200623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D28AE653B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE28F4A76D5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA03291C0A;
	Tue, 24 Jun 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="L4wtRu9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546827C16A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768823; cv=none; b=nElO5LwJGxaZ7qsfIj4pESBVpzuNWunlUlbaY5MWK+TBirh9h/ZKMhBfJfWFgMISQCDVmLeh/C908jeV4+HUB9zLBybvyElFTEBicj54g+RVdppCSDbUcA+aBT7W6bnFvetqvCsjlRkkNt05gU5YObyLBanwww9CP0wD8i77Xyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768823; c=relaxed/simple;
	bh=cHHzTIXhwtARmju9cK4L23TwilG152pnyyrZSkCEM8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXKzEGuOW/iHP2yvIaM3UL0eslPyM16EPyyI9PjfZCKA5ZX53T6e5HLADxMFdiEeBArPWwnpRP6ROM/vF+RlGERbmWmwW9C8bvTeaZCDMpWN6RgKXoVJUcc+RC5VDHCNTBrtJDIxcbyOQjjBhbVZL2dOO0AwGufiQ7M2yk1FGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=L4wtRu9G; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade33027bcfso60820766b.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750768820; x=1751373620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F80+FeXYZ4PIUD3SGso4Ms5tu5YoNmQsHY1ak8AKKkY=;
        b=L4wtRu9G/v6ulXJS6ABb4SfgVIdEd4HbO1n52iyEMMCVbchlzJdh3lbzNi8qjpNkq9
         TXT9jnum/a+0mXa5GXPW3OgnRjtnKD6ihJ7B9O+C58PYq22HXXDU+HBXTqTvTwOKebhJ
         sRY+phuWpweQypNQsp/H21FNctAkk83vBzneIn0Jk0UM02puesadSO5kGPYlmESNGVcY
         ZGf/e4FOQvzvWYMBpsUp8/OVafHup0HwMfvuSpi/pEvt8KlOXd6WIjI/3ogR/TH0JGH1
         QNTC1o1GzchJgxfwx1bFH4nuDpP5XP9i2ozNT/WNp38DYcVea/G81AzEUz4wLJtAaXt7
         tYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768820; x=1751373620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F80+FeXYZ4PIUD3SGso4Ms5tu5YoNmQsHY1ak8AKKkY=;
        b=UhZ+DpGisFhbCVD7Zh73nVd+ViVpEvpQm3q95MtpmMufdODU2OS9WhMuD6roVrv7hz
         aVMDwSoOdnG8MhP3bVCWPrCWQHjzMUyAPFNe1S5TT7de5/woteCDbQYqrW7CIRgb+a5T
         bVgeKWAUQpW6e0bdtsRQ4I19pN1NLEHX6ALAjejdqbwPt8W7gOvT4sviBQqjhgET1kDw
         yZwtNmRSrjUi6feA2TKlSGjl0km6uVDfiL9wWcMV5Ue2BBCa3wvC1od7kTK97ybXSR17
         qFWAjEu9uidHircwMr55zo1zsPLOIAHW6ycS3Qo3p20/FYQOGnqO1XiDF0rUNN4SFjnw
         j25g==
X-Forwarded-Encrypted: i=1; AJvYcCV4gwI4JP1s45bHc8OPaKi0FF/I+Rbfs9JYIn5/1WBEQx78F348w1OBxr5J2+YJN3Ijc1CnURE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDYwpO6EzJI5OVU3rk4W9THKuWgwgeUNcMImsZtBHs5Z0GisOT
	WhT58nnuaYsAlJMqwG8MUpzfcRA4VzBxjNXwSPnzoMpn7sj5cG5RtxHJNDIgeLU29Ug=
X-Gm-Gg: ASbGnctCsMb7XcQbEkQ6w3ooKi1jJoPe3f2V4gRB7SqDiOe2IRF7MJ+TsYEB1cGiWXu
	e8bTld+RZSUTL52XBv+l3cFW0ZAIILjlYSaxH2DaxPnQgAr6BeTL2Xpy77Go69emOntLZW8AqzP
	i3KzBp/LeT3cTVrOZaTPxfk0JwU0X4MWma2Hyy+dy6iUW+nb8xpcX507XztCcYWPeUdUD7po46m
	SerXtH60fmJjRze7AZd+6T2kFy3GrHfSZ62Fd+YtIEgN3j2pR+RMREZMsSQ2E4Ajv2oUIYPi0ST
	zGE1HkrjjEwMvjYrH93zFraf4QQcBBPcTLxt+i6sGUD3+qGZwwcoLMkBmoNH3PtLp9ARpAkv3UO
	fKQ2NPOcF26cPIH3B2Q==
X-Google-Smtp-Source: AGHT+IFwA+WLgLYFy2O6tezSdaj6yB20MbU6CjR5LnHVa2z1IrkO2ka6zQXD/IvsDUtxSuEP3ohnhQ==
X-Received: by 2002:a17:907:788:b0:ae0:a61f:2957 with SMTP id a640c23a62f3a-ae0a61f2a29mr380167966b.48.1750768819290;
        Tue, 24 Jun 2025 05:40:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054082d0esm875142466b.79.2025.06.24.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:40:18 -0700 (PDT)
Message-ID: <7dd1f60b-2efe-4e85-8449-f2b5dff79b90@blackwall.org>
Date: Tue, 24 Jun 2025 15:40:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v5 1/3] bridge: move mcast querier dumping
 code into a shared function
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 12:33, Fabian Pfitzner wrote:
> Put mcast querier dumping code into a shared function. This function
> will be called from the bridge utility in a later patch.
> 
> Adapt the code such that the vtb parameter is used
> instead of tb[IFLA_BR_MCAST_QUERIER_STATE].
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> I decided to not only move the code into a separate function, but also
> to adapt it to fit into the function. If I split it into a pure refactoring
> and an adapting commit, the former will not compile preventing git bisects.
> 
> ---
>  include/bridge.h   |  3 +++
>  ip/iplink_bridge.c | 59 +++-----------------------------------------
>  lib/bridge.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 56 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



