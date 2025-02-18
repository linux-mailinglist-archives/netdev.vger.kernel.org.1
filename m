Return-Path: <netdev+bounces-167535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C45A3AB63
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59271724A0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D711CEAC3;
	Tue, 18 Feb 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VZ+rj7yc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7A1BBBD3
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915713; cv=none; b=s9visLpN6rP1A0pUl3kFpzt+W3+GQjQIcU25uH9f1+JiGhu5xitQhGVIkFXhvvRPVAae6HBi7HSds4k7MNF+ZruePOyY8XkPukdqTHSdJ/QnRx6iTKQ0/EDmgpEc0k/lq4FUBLmZpHL4b7nYr/ZstOV2BEta4lMi20M1HaF8aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915713; c=relaxed/simple;
	bh=tW+DCc+g1sN2aFymYnXo4g17/7KVMurE1lHm9auinMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0j/tClCSjXRMBQ8qZL8j/CMoNiCo9Klp9DgR2V9nzuwQ/15pLddwohSIERAihVzDcXcatOtSXnPKDcQFHV9GgyaDCCx69gwfZ8bQpdxb6BjJZaXjM2Wt+JwxOVbQYZUvUVuw+iYxmcY349yTgWKj1VAqQ/DKV+s3ROs4v+rv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VZ+rj7yc; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471c8bcb4a9so47908611cf.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739915710; x=1740520510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnXszEah+Ty7cauHES4zXQeu8+LthL72aw0tPcjzlo8=;
        b=VZ+rj7yc5KHEu68wmfH0G7Oo6y7nRQb9Vv7JFlH1byDAWfP/bt3JPIauMQdE8q5BK7
         kDqwOUDun783Iat9Xj7xjRZwN+nQX8VSZbCskvhpYmmU6FD0rL6In1FukvAyqh5DLPow
         CrEvwtg3WbBWmZ36wOzSq5e1kgH2SUBXVJK/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915710; x=1740520510;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnXszEah+Ty7cauHES4zXQeu8+LthL72aw0tPcjzlo8=;
        b=mGJkVgtrUb/5dqhZgbU/zzCKK3wLVKPAGJx3n0u6/4fFccSo+kC8y0mYvX1Qvm64jx
         RD28iZ9ZgYjvmVkJnEjoFPM3p1r+0+Bdy5m3bMDtHd1xXviFYt6AW0OH2SObjpGOIZkG
         jCFNCC8kAvaecp/Oc5yPCZM6196GFwB0VUTLs2tYA//d9l+PnHGdjm3PulcO0v7C2kbz
         DQRzFeF+TC3w0uS79DQkv5693JfijyvlMkpcHJQE9V07ptyLwVN9FCDjnJunS/rTEOpF
         Xmo5AhozXfanB109MSUewuKE72mlzopzEY8IR99UHEU773XhYF8j7B//p4VSjI7HJmJX
         Uw9w==
X-Forwarded-Encrypted: i=1; AJvYcCUTpk2Qtb6slUBSWYzvWCtG4mVaSv7IHEZWm2qNS7CQFE/tujEwhqqfLH3xGVQN0B+p8oSm6wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQC9h74Zoq5OkE8g4KQs9Tr3wFlhCu0JzhNm1q/sYFAgVFQnT2
	6tC0F73zobxDniGw3dxedUNkt5mRAs+KaP5WUTq6e2Eegr5HSajy06Mg36y62AQ=
X-Gm-Gg: ASbGncv7TBgIwnFY7Jtvkh/vV9zvvOpJDWGiohg6HPX89HGJtU7Kh4WR4f1pgsTj9jm
	VxQP67WKLSpRaSDvTwCIoUN6KUve0ybpSkMiy6G8ZlBY+g7a6C/ioeoa/QE2iJvIau9Af2SDhp3
	R7uLn0lGEqPnw8VE/lzjXc1vF24rtUfH4ZFjR69Dvb/k8Cn8wNPj2N8VG386O0wHx49JHaAqz3D
	dHoSHBKsHTX285ilrWaKiVjlt/BGQkSikDvL/ON1KN89I64lE9kwzXfPiTOelwMF8abPifFdyz5
	TnrQpEmuQFty/l0l+aNANd4EybPUO1LwBQzN3/QqNbQlUaTsgbr8hg==
X-Google-Smtp-Source: AGHT+IGB1ilbwK3Zc2JucUxnCriOphPNIMfv6AQv1pHgFeDt3yYzPkMUYeB2tvZP9tPS/K6XLEw1Rw==
X-Received: by 2002:ac8:7d48:0:b0:471:b956:e21d with SMTP id d75a77b69052e-471dbe7c1f3mr168184011cf.42.1739915710415;
        Tue, 18 Feb 2025 13:55:10 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fcbef8d6sm16160981cf.56.2025.02.18.13.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:55:10 -0800 (PST)
Date: Tue, 18 Feb 2025 16:55:07 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 0/4] selftests: drv-net: improve the queue test
 for XSK
Message-ID: <Z7UBu8dgOZhYohvw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-1-kuba@kernel.org>

On Tue, Feb 18, 2025 at 11:50:44AM -0800, Jakub Kicinski wrote:
> We see some flakes in the the XSK test:
> 
>    Exception| Traceback (most recent call last):
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
>    Exception|     case(*args)
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./queues.py", line 53, in check_xdp
>    Exception|     ksft_eq(q['xsk'], {})
>    Exception| KeyError: 'xsk'
> 
> I think it's because the method or running the helper in the background
> is racy. Add more solid infra for waiting for a background helper to be
> initialized.

Sorry for the raciness I introduced. I think overall the direction
this is going is good - thanks for cleaning this up.

Please see my comments on patch 2 and the hang introduced with this
change.

