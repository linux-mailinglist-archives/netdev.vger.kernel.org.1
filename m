Return-Path: <netdev+bounces-225396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA898B936F6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE6C1907B6F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C5311594;
	Mon, 22 Sep 2025 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xInuqUXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729F23C516
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578968; cv=none; b=KVDDFgdFB7J5ucG6Nsi84iS5jWEU6MI/OBAEA130VjE4rQAJEQDglTKOr2oPS4xlCF/BxxIsVoEDmnFqfXNd2hzwy3cdRqEOLzHSKcKSNXNaKy/eQumvDz0RfFDjbo4JMmSm/MtqOoYHdniYAsKyUfJJTJX4Kczb8oBNBJG/MWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578968; c=relaxed/simple;
	bh=IbFE1oms2PmcouUl/usEZlCEVpv+9x2ciXv88pSf95Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQX08+qcWsFYcteXYRvdRLUe0g70mrrFk6jyQccqVSU4a9Os6KoCZMIqWnUEXiRkQhngsW34Hxh6JRkRrO771LhHjOlLndTkVageMfbKiLMDkm1sNTJaEhHGXkMyKhOkwlFnr2xk/x3r+uzsvSMOTe0NDL8ak/aHJe6O0RFBn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xInuqUXf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so42986666d6.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758578964; x=1759183764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYnuc6j9qhLWOo/rZQKKbBmIkoY02H/yL7nkkmtQpxU=;
        b=xInuqUXf3Pqp+x74N9wFfgvpzAhwa+5bALmt6ibQQ7XeuKxNbaCeumKda3DexrwpVg
         Kzcyr0kPY71WfAVfJAm+/nPnv1tVSyV+EYBuUi5NNcI4NuuhIsudQELz9OXTaiBbE6CO
         tn1mpbFEZMu05y4iedP9eRzselTi5ZUeJRyhSmPaxCZGyhe08/ym9om63nr0mdiRPQOy
         0O3ck2rZOApODsezNG2ThkttLMa9fv1z801Ov75m/FvJ6bSNaM7VFq2oxJdKBBfz7xw+
         9GKv9HT2nMQSj3n89ZxolFFcJwRFGp0ACh7TrjipAGeZGBxmTRxuQlNUNJWRRKWobfmN
         AIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578964; x=1759183764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYnuc6j9qhLWOo/rZQKKbBmIkoY02H/yL7nkkmtQpxU=;
        b=lWIUYslGE72L294IXUp62WzV9u3ON+nDGUH8sfWpjtPtIryV6GyFMyOk3jR0MVFuRU
         Hs2ZIDe7aHTGZPbYQY2roGoqug8cCQeAIeseZP+IyXeb7mV5xzGxuli4rqprAWwfaJVF
         Feit/Aw5F+JhoXg7nTpyzfBAHrb0tuqTd5ljRXpClumh1xIWdpemTE6UbHp8z9N+lc9P
         rliY4tX1YTVUkv9dmpvudUGcMJG4spzWfdAdA3n4Eizp8rPCuOkMFxni6ObAUrry7doM
         B+snnZQR1iZyx8Jn0Pbi2ZjSIQ+vFVThUxNWsSWUWIRkmEDHaR04J5d1LLt0LQfW19bA
         qPkg==
X-Gm-Message-State: AOJu0Yyh/SHD+Yui+k2nk0G/zoG0FQuKIMG4Q8vgLKQFx83t1DXDyxFt
	l3ZS49ncntPc82BSmGH6fYxT3h0/187VWQLeOqMa4L48+Z38ZCSm1lT4/nTA+5lhLwE=
X-Gm-Gg: ASbGncsqbC1BQLbhfHN1rq2VIux6aiYETkR6Hv4enZODVVFXpkXQ3WbuiM0MpyTrJRt
	gcrjwudNV/lpXp5k42kX2zwGCIDtUfZmH9QKHPJTcvc5yNZc2kvgaSaWuDC0klEIHZ2ibg2jNFz
	lYWKNW1OGIx2x4kfP+itjHZ1BwGbJtuUUaBaeR6YNng4PmZGaek1GW1j9Xql62Kb5ZLnw2FHoSU
	WzT9PutpuhNQAXjlDII1cTFHVZEwAwIzh3bjHu94bi4wMMyI6c+R+M2nNUzSIM5N945SqkROmlz
	BpM7A8uXUiCDch/nDl8CVpqoSCx1fBWXkyc+dmvf7ZCT8J/ztzIVrnnC6c/iXhRPBxdv1up9k/Y
	HjZ8+w8fDnsyaUcF+qNKVVjtIcomVtYC25BMMvXmApC84cFgYmirGyVZNnS3OIwVisnh34XLd/V
	03B0Me+9gBRg==
X-Google-Smtp-Source: AGHT+IH/Wx6XCxh+/R42m/n4pGW4Li0DeICaefpsliWbAkhEalUfjSoqc1W0yev1gXFbG0yEVMaLoA==
X-Received: by 2002:a05:6214:1c8d:b0:790:551a:a689 with SMTP id 6a1803df08f44-7e70381f88amr5363076d6.26.1758578964227;
        Mon, 22 Sep 2025 15:09:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793446acfa6sm79182216d6.14.2025.09.22.15.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:09:24 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:09:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 3/3] iplink_can: factorise the calls to
 usage()
Message-ID: <20250922150920.78b95c44@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-3-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:32 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> usage() is called either if the user passes the "help" argument or passes
> an invalid argument.
> 
> Factorise those two cases together.
> 
> This silences below checkpatch.pl warning:
> 
>   WARNING: else is not generally useful after a break or return
>   #274: FILE: ip/iplink_can.c:274:
>   +			return -1;
>   +		} else {
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---

Not accepting most checkpatch stuff in iproute2.
Better to not have code churn

