Return-Path: <netdev+bounces-241770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A0C8809D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE5A1355648
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0C301027;
	Wed, 26 Nov 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SRdFDKxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF92F6593
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130636; cv=none; b=a4tsCfTFmHa/yxDoX9+VYxQiPUeDPoZE5nBffbIAAzWWEfte9gC8SzXVwIAp2cyMzn4lP5AybR2tjHMtvyOsix3mCnRkG4efUYpioaD0UJsiT5Bcnj25GJX63tQBSa777wU+D7kRrmKqzQlB7jHpIyf5W+PtXuChMWFAthXmgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130636; c=relaxed/simple;
	bh=NsE51gMT5deMlkPm3uJpAYkgedbfvPk+xSbN4NIGBGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2DyLUKG/zURvOv8nNmSlJsAbX7kXeMBeHCejSvA3iIvje/2B3f4lmHqLGaYCmUqgxJWlbv2v/oQwZVCrZt4eBbS/8+9njlNzEtI8erHP2T1MmJsZIFKEW7qHaoRaFwwvvYQOzhf2QLorxElORU3On6LXCSEwBDO8jyLJHpCbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SRdFDKxf; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-789314f0920so55462707b3.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764130633; x=1764735433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsE51gMT5deMlkPm3uJpAYkgedbfvPk+xSbN4NIGBGQ=;
        b=wF6BWX7faRCFUl5deSjSbsJdiTY8xTJ3/zD/5sEc5sQssnZG+n4a2WGdYGnENUnjz9
         qvuGpVsMkGqV3hNSPf1CMSWKi73SJx360x6Lr63Io6fY1r4IZ+yg9NE/fCfKn5uU050u
         4tN9FH3cdjOgGpg6fP5T72mrEQJJFRrH3/YvX6gIkDldGcRRGvMSc4nSTsyHrjjC2zBk
         vtQnEnVrbQPO5GmdarTnySWyDrmHKfJEo1TEfttul6i1V6Co+TslmqD6NzzJ94SZWwhL
         Ce4Fh5LoU9dT8LdlPUi0SQ1vqjYO98nMvpQEr8ahJ+2wLvRmsfDdsEchjBF3YzQYNXNX
         ylvw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsV4r/Jq/KcHBpJeGtR+1tVvpNQ7H7hXARrvO17/6oDkYzgEGKehcvH01L9YhIExciXOS1YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jG5uw7Una6gBK07zy7Fu4ZIoEaWX1Ot1EkX71GX/DM4uvtX6
	dZLnZSPooMlhza6tSzYJvFXP3o9g6Pai7NNMsR8vD99asx1ikppGZZwiCIOdG430GPiQe1L05Ij
	fPtDEw1nF7ps5b2oOlvxVB0L3ILxJmCkdPmKH1/5H1xBQ/jDLEBW0NtVWmyLY9TWmln5A5uqt2k
	dBGl+IbNnIb2sk6xI681fcRduhzrmqukxIbSUj7Wg9cuIWb4zRdKF6LpFwY8KyNs88qg6bIY8ds
	e7B8njn0I4=
X-Gm-Gg: ASbGncujXqcLZ+hCvcKe0rrmnqr37aymKjcTEok9r/g2rUvJz0IwNtV8n32VaeE3iPd
	dPSdEBevBMMGYFEQa7CXqBRU4HpPftiuPJi263vNHUyWYYCah47CVVP3rhtevQ6HURnRd/SwGIm
	fHlNIM8o6Kin+FWdlQaiPtiRNnpJElxVe9ScS9CXzh5qTTNm8PfIkGDnnvqgbGqRlM4odC29tys
	EIrh6e1BUHs44zTiBOFKtb5lovdU+NmlI6OtXV7Xm4I306Q0DsMecHIkDIYIY6xPnVnIwQLrQ4Y
	dsoEoW1qQRlM9CtR2D2NHgR0ZvdyyMR/M6pQBGEGB8z8NbKFmgvY/q32FKkK6WJNNO5Rm+xaGxL
	2m8lO8jPXmDP83OhCtRHOIseDoNh8egQI9pQTZS1xKQGh4cVKRHwyGxtR1Nxg2hIoGbK8s3N+aJ
	LkncGMa80m+lGe0fIqvJMQip4HDPxJryMTdroAkYWxj6pC
X-Google-Smtp-Source: AGHT+IHnAZ/TsGjLiUkcfyFK6SopKm6sZ9Jai+s/GpH7JkEVYtrJ/POmM6E1b5QUNKYnVH+MDWIA+FbDI5qk
X-Received: by 2002:a05:690c:f92:b0:787:e9bc:fad4 with SMTP id 00721157ae682-78ab6f7dc81mr44890537b3.46.1764130633531;
        Tue, 25 Nov 2025 20:17:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78a79920bb1sm12925497b3.17.2025.11.25.20.17.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2025 20:17:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6409849320cso474520a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764130632; x=1764735432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsE51gMT5deMlkPm3uJpAYkgedbfvPk+xSbN4NIGBGQ=;
        b=SRdFDKxfAxwrhLc2iXfNc10GofYfKe38rHJTKb6TvLbdjgiobLrWTPtp7B35haYzRv
         OXUHuRmxoQ23xN4X8Fv7VLcPiOTRznZ3BSlPaFRi9SI9kpB9/8qPDv5eHfnhHN+zIRMK
         LqqQZH8nk0zoXb1REqeqn5jzJjJLI/nlEYiXk=
X-Forwarded-Encrypted: i=1; AJvYcCXQ1CTTMhr0HqXyy4B37oTJUWbBUZEmcIxtWQRJGmbhgG6AM9Ub7M4qYYjtgLed+B/K2lruJ3U=@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:63b:ee76:3f63 with SMTP id 4fb4d7f45d1cf-6455508801fmr17723475a12.7.1764130631980;
        Tue, 25 Nov 2025 20:17:11 -0800 (PST)
X-Received: by 2002:a05:6402:350b:b0:63b:ee76:3f63 with SMTP id
 4fb4d7f45d1cf-6455508801fmr17723457a12.7.1764130631674; Tue, 25 Nov 2025
 20:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126034819.1705444-1-kuba@kernel.org>
In-Reply-To: <20251126034819.1705444-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 25 Nov 2025 20:17:00 -0800
X-Gm-Features: AWmQ_blkTlrBb4wfKvo0kVNlCD9t4GlovEgdHNwOhIeyzajyMFZWPBaZgwIO2Jc
Message-ID: <CACKFLikXhRKfq33VaK4Y8Hjo5NEsg6drfjqpQ0YSA7GGd2f_5w@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: make use of napi_consume_skb()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Nov 25, 2025 at 7:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> As those following recent changes from Eric know very well
> using NAPI skb cache is crucial to achieve good perf, at
> least on recent AMD platforms. Make sure bnxt feeds the skb
> cache with Tx skbs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

