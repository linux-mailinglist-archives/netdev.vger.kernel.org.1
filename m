Return-Path: <netdev+bounces-86432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C789EC81
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38461C20D92
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A013D2A0;
	Wed, 10 Apr 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CaCJ8AJc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204713C9CE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734939; cv=none; b=YVW2BcEcM3AQxk5mLxcRUZHNjlwubBI0Zrjg9xVDZo7tl+8rQm/4ujaqIHf4NWZi/xrv42is4OOxViGc6z9pnwV0wXz3DuMFznVBqZzMX75rJFCNQ3WlpEmSG0oyfKnSbl1ROjyDbIpEMaSd4kNgQIf/rPKmZ7Djc6CgtFu625k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734939; c=relaxed/simple;
	bh=kztqXTJAoSz+e/mj1kuKESJlzUgr1+yO6Mcuo2khv80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTRH9T0O2lhi1q6cDzzgPzERnFG1KwrCLEEgeLdlU1qZBVWJRmMidRwhDfyXxrZ526SNdH5+m61aYqfiL4AnXjvka2nykj8ooZPRgChIVFnUFelsS/hoGkHRtOP7/g+eumuDt8nBWO3xaOxlGnE8kkW5vYRLDARKTj5t3hMZKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CaCJ8AJc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51b5633c9cso511616966b.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712734936; x=1713339736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y//drBcHk8K2aIKsW3skZ7g4m243pzURRAAm6EHv+Vo=;
        b=CaCJ8AJcInWzOxvJwxd5KYv0dkEtACSAMPcTnk07OUkHfQIPsr8G5zcbroZWQ08bFD
         TGj3F7zGEBkzZ07w8IXejXfGNp1duJdFSpfzCUVcsTvJp1xBai+in52Yi0tnWFP3SQcT
         2A5qXb0zxCwha9kjBQH5J+Alky7VeC4cELgHIW92XM4+Mn3a4tr6ZS+RmtU6zCFsziay
         3jGlxy/hIK/98ltMNsR4FwSC+ULIrBpLkLlRQfrhM4zJSz7ejk6BRXb8gC/mhAbIACN4
         6thdLOnmKjNCNk2sQKpmeM08WZir5F1vYJIl3YVRkWhPs3P/WdyiGCQoWyUEiivMaDk0
         m0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734936; x=1713339736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y//drBcHk8K2aIKsW3skZ7g4m243pzURRAAm6EHv+Vo=;
        b=iV79iQpkLWsx6qWS7rwr8LCS+lbxYkEncWDUpK2OAnfSt7YALcjXUkJNJs7UC7iqtB
         YZEfQw2y5WJpBxDJ4KtdERqttD4kno2Av7TYbtW8Q/4WjmwVS7kdbjgmDxp0cjUbP+uV
         5E2jyLyzO2G2QPuFH5+JO/GpP5lAwb1aN9ofWJO6rTMK8xP2z5TmIXib3k+a2nEDaYvg
         FkAgVRGOkYqlkbXAEN7j0sdWvy9qyDsd6qKgQ3awdi/TCWDeCOHUBz7+WRr44xlHM4tN
         z9Kp4AZXyGv//CHQCrKc8wxM/JSNoP0pIWVaiU6YDK/xDrw3F4gY4HoxjTH1S+Pzwhvy
         jpnA==
X-Forwarded-Encrypted: i=1; AJvYcCUXDpav16x/R5cpl6k+78zRFjURvJ7q2Xe/GN2ySf38+kr+y1f+ka4PNJzwvOi20DT41mQpUDxyt98GKMuJIHDA8DTWWkqg
X-Gm-Message-State: AOJu0YxUgpsc+KdaPmjnz2mFFn4cEH/uBWuPbIwSai78XrbfyzEnnAeJ
	m4akvykUuxoXDQr0JzRTIqzW9XFCpBYEA3yNvWAujAKAbr8Oa1+bS28/heWhjDo=
X-Google-Smtp-Source: AGHT+IGfZsCjrYN8kp3I8JH38RfST/SpsvUGrNp8ERPfOLl+fqXHnm7ZKPgfclYor4Uat0DIcfMB1g==
X-Received: by 2002:a17:906:6d51:b0:a51:a10c:cc3 with SMTP id a17-20020a1709066d5100b00a51a10c0cc3mr1087478ejt.17.1712734936215;
        Wed, 10 Apr 2024 00:42:16 -0700 (PDT)
Received: from localhost (78-80-106-99.customers.tmcz.cz. [78.80.106.99])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090646cc00b00a4e3fda23f5sm6588972ejs.165.2024.04.10.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:42:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:42:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhZC1kKMCKRvgIhd@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409135142.692ed5d9@kernel.org>

Tue, Apr 09, 2024 at 10:51:42PM CEST, kuba@kernel.org wrote:
>On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:
>> This patch set includes the necessary patches to enable basic Tx and Rx
>> over the Meta Platforms Host Network Interface. To do this we introduce a
>> new driver and driver and directories in the form of
>> "drivers/net/ethernet/meta/fbnic".
>
>Let me try to restate some takeaways and ask for further clarification
>on the main question...
>
>First, I think there's broad support for merging the driver itself.
>
>IIUC there is also broad support to raise the expectations from
>maintainers of drivers for private devices, specifically that they will:
> - receive weaker "no regression" guarantees
> - help with refactoring / adapting their drivers more actively

:)


> - not get upset when we delete those drivers if they stop participating

Sorry for being pain, but I would still like to see some sumarization of
what is actually the gain for the community to merge this unused driver.
So far, I don't recall to read anything solid.

btw:
Kconfig description should contain:
 Say N here, you can't ever see this device in real world.


>
>If you think that the drivers should be merged *without* setting these
>expectations, please speak up.
>
>Nobody picked me up on the suggestion to use the CI as a proactive
>check whether the maintainer / owner is still paying attention, 
>but okay :(
>
>
>What is less clear to me is what do we do about uAPI / core changes.
>Of those who touched on the subject - few people seem to be curious /
>welcoming to any reasonable features coming out for private devices
>(John, Olek, Florian)? Others are more cautious focusing on blast
>radius and referring to the "two driver rule" (Daniel, Paolo)?
>Whether that means outright ban on touching common code or uAPI
>in ways which aren't exercised by commercial NICs, is unclear. 

For these kind of unused drivers, I think it would be legit to
disallow any internal/external api changes. Just do that for some
normal driver, then benefit from the changes in the unused driver.

Now the question is, how to distinguish these 2 driver kinds? Maybe to
put them under some directory so it is clear?
drivers/net/unused/ethernet/meta/fbnic/


>Andrew and Ed did not address the question directly AFAICT.
>
>Is my reading correct? Does anyone have an opinion on whether we should
>try to dig more into this question prior to merging the driver, and
>set some ground rules? Or proceed and learn by doing?
>

