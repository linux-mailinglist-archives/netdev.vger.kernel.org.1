Return-Path: <netdev+bounces-241979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE83C8B4AA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1621F34B632
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D130DED3;
	Wed, 26 Nov 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2+SQ6Dc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B4281376
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178756; cv=none; b=MMyI/IshhkyP6YMQB+gz4fEPmAWPDGWq8fXLVkyTMv1Got/MVOZzq/fTY7umgFB1hlgF1li9y+vh31snuf6ToYw9cOEAhlF9yaS3YQ/9HACU7fVLPtfxOh47uat6rXCa532inyYD7htyesQhnUoJ+yyuQyvZNNPY/VcPXormTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178756; c=relaxed/simple;
	bh=R1I+uJ/sne3ODi0I5rhgl1VBy+mSK7EuH1XFyAWlLB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJReAk/ZxqxESupBuCTITksf/L/bIlD1PJ10d0EfNA1ndXdYYnl4wtbi8euTOGo+uVPhWoc/cFi7wDXSO8ug3STF3qzkLYZfbHGgFQncCkU8sYs87t83Ru48k6/JD5sik9crf3J2Z9yJCRlBz/rLqEwN2xhs0u99QD68a4UYBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2+SQ6Dc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-643165976dcso13465a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764178753; x=1764783553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1I+uJ/sne3ODi0I5rhgl1VBy+mSK7EuH1XFyAWlLB4=;
        b=k2+SQ6Dc8hGrR0q6RPFdvI4iy4AHoJTDHaBldo9JmaMw+QiQDBf4C2uGnbHK3HBCgj
         BgEfTW9DDykZag9YW+CjzUaK5RMW0H5pYaECG2s3oNxXwAeZojvOLv1ruqh+P4Als6ee
         AGLqIPBFkf5k604QE2c+VLekI/c81Hbn9MMkwTl9X7OyALb3H8S5dTZVYwkZumCmjBZj
         cyRbGuVdYrUNXUubW9nQhYE9WIPeMaiABDtCDreOK2GtJMSe32vHirqu/BVXAvwaQ2lh
         nnHYDyyjwTdzkQZQlXS1x8MUw85lCGqi+v3iek4D1+ujGHq5t46vRPkBn0GJ5eU89F3r
         0ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764178753; x=1764783553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1I+uJ/sne3ODi0I5rhgl1VBy+mSK7EuH1XFyAWlLB4=;
        b=Idv5P7Rro9w1r2JKQ9Lxeop9Sn9OaRX2EUg7NHKg2NNc0R9yHUhjt+Dc84fPP/YpbS
         atOzDO88KfsEMLoP1VX8W4kDPm0RzT13Jr4yJxRCoVBca2GVk9/pP5dirUF0DxFg4ZtL
         vu4csUj0Xb5fst3BpoH81MxzpWUpd077gl5uO3JEKDlPxvCnTj2WZmKb2lQSU8nSSKVE
         WBjguhG0eABzIlsSG8CQeudteKacb+zsq9z6ILPCd4F3aJGZgldm+SGXRf0bVgyNkN9g
         BMyFGidNlnqoAxoszWdwngn8xzaPY/Y7cL2/aiM8CbrL873guh6DyER7NWvsuj4UwQtQ
         eukQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcyH2rFneOhL1j6kz6cv0aC5gqVLCTxH86KMH+0RQt3Wo11JcrDSSfPZB2SpvzuZJbCEOSw48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSBcqS7g/hxYfLqwJ6xkc0005c9ICIaQhzJox6Vq7US6Oz2kj
	85iESEM+/SCB2TaW7ytgEaUYovepSkusTu4HLk+UgmMKObwIv9kV5ekoCpL+cyHJYaXpqiB2a0D
	bNYtIKCIOyRfmnyjNFq2zZEMbwS9m9ix7u7BLO5wd
X-Gm-Gg: ASbGncteri8USyANLmAK84UclLyBt6+Icj0MXJMuZosC/2HBktJJC5fnMlZp0od4sGU
	g/A80D2fQuYBm4r0hQiu+oWCc3Biqt+5lHccyfGiRifg+mVKr4XO4+OE9TYtvg7XCDO1W9w10iY
	bpb31nRwT1BTFzxMQ4b5/iTv3UiUqVzQ3YQft0ztMVepnt4FHTWL/g4SdxDMaNfgyRzr8t6IRYN
	EmFIw7vn6b9lBdpUpAeSMBWXvWKQ6c7+6JEoKiY/5hGAJXfWe3fRlPR4vJpIlXtG5tGsKi+ulrm
	fKMTkm0=
X-Google-Smtp-Source: AGHT+IEkGK/VHxp1lm1rvuHJf0EzAfe7zdVnaY0ne4s+608bQz6lFzGkrtc5jOoeA5Aed/P/aq8jpGwwN4k9ODR79Fk=
X-Received: by 2002:aa7:c458:0:b0:643:bfa:62d0 with SMTP id
 4fb4d7f45d1cf-646014fd34dmr33248a12.10.1764178752509; Wed, 26 Nov 2025
 09:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126094850.2842557-1-mschmidt@redhat.com>
In-Reply-To: <20251126094850.2842557-1-mschmidt@redhat.com>
From: Tim Hostetler <thostet@google.com>
Date: Wed, 26 Nov 2025 09:39:01 -0800
X-Gm-Features: AWmQ_bnwtAMUJOIKVfMGtvWBZahdFkBhWMQmC9LHTDnDUnFiDtU2cq_7mHmDfEc
Message-ID: <CAByH8Uu3ZBa1Zux=TLAGR2+VAHT+AoS0oHvqaMmgCHWVfmZhUA@mail.gmail.com>
Subject: Re: [PATCH net] iavf: Implement settime64 with -EOPNOTSUPP
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, Sai Krishna <saikrishnag@marvell.com>, 
	Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:49=E2=80=AFAM Michal Schmidt <mschmidt@redhat.com=
> wrote:
>
> ptp_clock_settime() assumes every ptp_clock has implemented settime64().
> Stub it with -EOPNOTSUPP to prevent a NULL dereference.
>
> The fix is similar to commit 329d050bbe63 ("gve: Implement settime64
> with -EOPNOTSUPP").
>
> Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clo=
ck")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Tim Hostetler <thostet@google.com>

