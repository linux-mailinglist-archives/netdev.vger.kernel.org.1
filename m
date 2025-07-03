Return-Path: <netdev+bounces-203571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9ABAF6715
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E3E4A0907
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908D4414;
	Thu,  3 Jul 2025 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp8OEYOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41715C0
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751505363; cv=none; b=VelRmDvoSzb1ASi8Ubyn+CQslEbo4sA8tFPZPrjrK2647r+CbBSFEMsJfT09GZj1X/gRibzlBr/N8Nna+iKgJW22/cxEf7nQeYQW5z7RZNKGarl78MDafTlEu+oooW/B7j0FBZHlI6FYlHC+98hhhs840HMGrYcu9xfZpUeBfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751505363; c=relaxed/simple;
	bh=VuQUjz/cGviES32kMdzC/Jy2KFJ3fEM5cdUhhdRfutk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb1W8bG8Ctzv+x4JN1e/hciSpMlL+807g9ZeCu7HOAn6SalzjIext/9qZWBybyf/svBmOaNJDrfSmpGn5IO9pUbGIcR5ZleMLFjunl7WEDlk3HFqARcRuy5ZZfcovCfi8IR1flsavyUl7or3bLtBeWvMbM8w1it4KW1tDAnqLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp8OEYOY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237e6963f63so33124565ad.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751505362; x=1752110162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e2rKVkepBlRpmG6kqLBNvSNUuv0Xmr+/D1oBfdtHKj0=;
        b=Xp8OEYOYXo7nP5pOMBOcI3HmqXmQd38ls/srppMoZayZsW+fGpFJgokHako3OJz2bw
         2KnNdvNV88zM6eNjOOSkjh/sMvX0sg4z4J6m6NWVg27KIRo6Y5U7qjZXyTgY2UgDYphe
         93ucm9/VWAZ5sXCex+WGZMSHtYwMsArZNvNelDQ5YuclsjxdAw9gl7VWO72nEYn3KoKl
         UtCzEPfGwQuUMWKICSucPtQwjb1Meq2gZ2KgAg2E0mntxQpEHhuuuAPrH9W6HMmLpDbF
         Ymv6IBqOJxAj5+GHn6XDvTZtvX7iRWgMDaGl/yHzHR++EE7Y65vu0VD+aNn6rJnblPjh
         Zw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751505362; x=1752110162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2rKVkepBlRpmG6kqLBNvSNUuv0Xmr+/D1oBfdtHKj0=;
        b=GGOh3RdqpJdJoCs1N6xAzU6ozNyVLWjk6rIi5TgqJc+9QFeRMQuVV6LLBa3EsfFYgZ
         SgCp8xpanJgrQUMdnByzgHer5r+21TFAUIpaWr/zb4PWf1xtuQV8UFQ4RbN9P+vnnRBv
         dR1T3SVYfehtX//qdS7xOvkD5aaikKTmxtSCgKgpjnn2v65wSz33yTN9OhlbSinvHR0O
         chvNKP+VMnZLN/3U7IokwPVw8+qFWMh0UbmROzHKbR4ckSGXjUkojc0Uy3thFiRjX8Yt
         mUBPl8YRtyu812XGp5PenGzdTrsUsPk2kc+nx5rwjaZI9Ip4vmTKiNyivV/yxBcMYBpI
         jINw==
X-Forwarded-Encrypted: i=1; AJvYcCW72iIoxwD6c6nyX68spT5INsKfbS5TqS2elxy+O7p4gTfwkM0fW/tVLYitsvX22PSNWVfyhK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsamZIbGR3fAwrsp4Azcs5QrF9Tp1+y7lr+TZkyQinoVf1DFAd
	BQ5fuQCdoxNJj0h1E74T5zLSq2x6LyLY+troZCdljNO33jTylxSQyA8r2eRxi+UJFOQ=
X-Gm-Gg: ASbGncuvqVDPoh4xe0GobtNLF6HbBhwTQUZrdRMJPBL0Z952sKlZoP8VSlVRS6V2nF1
	RvCmeOV9ows8a3VDayz366+rYrlk1oAWXERgaImZlK3HLPrnqCqmpGIQXPwRKKgwLZLlx7XR79s
	FSOfZy8/2qKX+J/64bkKdOK6pockVIFNosEWhPoPzyuwmnx1v8qqngMdFB9pkYmXLd2XU9NQM/8
	UC51Ei4M6Zwsn+qws5pbYU6UWZ9OEqknZUDyG8UCUHxIM8lbMOB8whCRBrCSn/3ZVlQTdg6pMOm
	vKaNmAYxb8akwq2IDf7uRcZG7QXmW8lIMbKv25Wy/GQX8nO1roedHXqVx6w6l7nXRnA=
X-Google-Smtp-Source: AGHT+IElpn3LtHKgd/pQGODxGX39ip8rsNsfbKE8qL6xAZZw41rxJZhqoC95nSKb0ABBl7JSHCppNw==
X-Received: by 2002:a17:902:e891:b0:235:779:edfa with SMTP id d9443c01a7336-23c6e5505camr59486385ad.32.1751505361603;
        Wed, 02 Jul 2025 18:16:01 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm148185245ad.80.2025.07.02.18.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 18:16:01 -0700 (PDT)
Date: Thu, 3 Jul 2025 01:15:54 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Erwan Dufour <erwan.dufour@withings.com>
Cc: Erwan Dufour <mrarmonius@gmail.com>, netdev@vger.kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, jv@jvosburgh.net, saeedm@nvidia.com,
	tariqt@nvidia.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Message-ID: <aGXZyuyiAQP2EVHi@fedora>
References: <20250629210623.43497-1-mramonius@gmail.com>
 <aGJiZrvRKXm74wd2@fedora>
 <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>
 <aGN_q_aYSlHf_QRD@fedora>
 <CAJ1gy2ghhzU0+_QizeFq1JTm12YPtV+24MyJC_Apw11Z4Gnb4g@mail.gmail.com>
 <aGTlcAOa6_ItYemu@fedora>
 <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>

On Thu, Jul 03, 2025 at 01:58:36AM +0200, Erwan Dufour wrote:
> Hi Liu,
> 
> Thanks for your explanation. Unfortunately，the alignment still not works.
> 
> With pleasure. Thank you very much for providing an example with an
> explanation.
> Hopefully, there were no mistakes and I managed to correct all the errors
> in the new patch.

Yes, the patch looks good to me now.

Hangbin

