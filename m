Return-Path: <netdev+bounces-186709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF2AA073B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9742E3B54E5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EA2C1786;
	Tue, 29 Apr 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caRYV4q4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1772C1794;
	Tue, 29 Apr 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918859; cv=none; b=qPPAmbctQdrn67pboX2MOvHTyCUwaUs9cgQrTyh4yhuxK6M4jS+P+OIubL47X4TUMbunAOjFKvjCKQivWafJDrEv4t29YdMy8Kr0pGaiod1023kxNw6ci1UNqS02GKBz+I4txxl8bKvlvaRUaRmLv0KxmNg48ROOgEo0sLy+4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918859; c=relaxed/simple;
	bh=pKdrAsC78yKJBlRfTV47EWhjNqUPsyLtnbdr254TIak=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qUDQO5B2qZHnERkX3nzzo/xLtwYl3+8v84DYBzRoJQVswOcHVIW1LPEw/Lddn9RZC+tz8WByJRwVkxtw4/2k9F+wMi4cRY2yVjdfK76NKZ2NQSHduMQd+I2RyHwfmlZEurcB1OuiSQ2PQW61fiGhEAYUvQp82RVkSlsdkv9IVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caRYV4q4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso50965425e9.2;
        Tue, 29 Apr 2025 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918856; x=1746523656; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKdrAsC78yKJBlRfTV47EWhjNqUPsyLtnbdr254TIak=;
        b=caRYV4q4JnXKLHRzvs49gXoDqFG3DZtgRWuPpGitqJXaQkx9Cf/cgaTTbpbWrMwAG6
         j+cfP/tvjMPz3Ca/S3KIRKiU8betiqkavlp3XGEvPsQRmqj1yZwOimoHVLzywmlr0ucW
         0po5k2VyVJtcDSVS8MXwABFOM49nGxUmICL2uWBdgDSrlV803rfevkdKxzpv9FJ7kO9M
         CXIisRyHMjUzTo9M4SiEaA7De6xvMGxo7UQMxSkH27oTIpZZZtO4JTXRCe9gwKdHXNsc
         OYwJbvsHVlJIU0k5jX8vgsHAbHtV9L4j5tuDH8mDAzg98sYNsNE3nMWDgVhdQHE/bqf4
         RD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918856; x=1746523656;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKdrAsC78yKJBlRfTV47EWhjNqUPsyLtnbdr254TIak=;
        b=UFnJwegMbDrXndUfSty25cRwyYXvJz5bXp5jzAtT6Qt9bwtr3zwkYZWLoVrgZ46Bte
         az/cIxbsYs6zJa82XS2ZGpAfyt+iEZ4+S4hPNCMZkAmMO/6BDyOWKcHb/7JzKuf4/f3T
         Yxd14VFwc7dOfHU7nHITxaqk3lO1WzDqwWztxNOaqGkYMATCqnWditIJ7Uoc7xlK6KZh
         HMosz+LTKRALQaiJ99K6hSoeeExMUUOm/9lUmA4lm4O3qsQrw/N7w2vdz4eQb+I2n3pi
         WuXrw4tff9+Q9Bhs6c346AsUIa6/S2lUvlBP1pXung3b4g0rIucDU34gTNV9I1ItpkOK
         03cg==
X-Forwarded-Encrypted: i=1; AJvYcCVR7iL3pbzz15BvMih4ruU6ggAFbwLv9UxSrc/1UA9ZMn3LVl68liEyC9BHzwhhjikbupcoLRiEASF9S5U=@vger.kernel.org, AJvYcCVTejEWfnuuGCrpKf32HcQk1sTrEd9J13on/8JlSlo3y9JMvMK9QkWlzh2ApHvV4IMymDtjhxkB@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY2EJ+X25BikskyGRk8PBtDcHEBzhiE3E6ruGx9D3SdG3cJo1
	7i0D4EWJRU5QJkiFFu7D0IAUov7lXkpDF8SCzR4GviO0YbV2bSXxNgbvfQ==
X-Gm-Gg: ASbGnct6oJLRx0lFJPZTapLYkkgFg9uoWcgMaKKWQzFo+p06h9e2tN4t2m6LqAlsZ/Z
	Ys2FutdfN9RMRdgaUAnE9Pmycvz+62LzIXLwjCjz+NAF3jlRhNX1oRyoxyNv94RzBDtGsCrZC5B
	PTC2Gmry6a+TAMtdw1xBpgdA1Qke39N/EsKrSiSVxCqysnoEzkFiD2XlzOhTDvUp6GjyPD7vjuH
	E1+bdRLi8eYluVChu0mk6YIexKMMvDcapvtkl+pXIGYWeE1fnolhqhAs0MUT5vwE7uL7x3tEDSh
	rlQdpF7fLNucgblEVEqwJgxrt+da9hDBr1aE915BooIic61DKaSASAYe6yR83cws
X-Google-Smtp-Source: AGHT+IE8JSijoGNvW4HYfi5pARde+mkn5gH6F7xQrm36fW+QYoBBa/pBtyJZpJfc5TEgBKoY19TQcA==
X-Received: by 2002:a05:6000:3112:b0:3a0:8ac6:d5b8 with SMTP id ffacd0b85a97d-3a08ac6d5d6mr1645390f8f.53.1745918855945;
        Tue, 29 Apr 2025 02:27:35 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8c973sm13445245f8f.5.2025.04.29.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:35 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: fix typo in info string
In-Reply-To: <20250428215541.6029-1-rubenru09@aol.com> (Ruben Wauters's
	message of "Mon, 28 Apr 2025 22:51:09 +0100")
Date: Tue, 29 Apr 2025 10:24:52 +0100
Message-ID: <m2v7qnpbff.fsf@gmail.com>
References: <20250428215541.6029-1-rubenru09.ref@aol.com>
	<20250428215541.6029-1-rubenru09@aol.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ruben Wauters <rubenru09@aol.com> writes:

> replaces formmated with formatted
> also corrects grammar by replacing a with an, and capitalises RST
>
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

