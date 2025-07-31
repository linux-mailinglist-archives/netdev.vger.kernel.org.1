Return-Path: <netdev+bounces-211181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A4B170DC
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262E51893A1D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD91990D8;
	Thu, 31 Jul 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTqovntg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE4535973;
	Thu, 31 Jul 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963529; cv=none; b=VqGwXJWeMMV411uqfZwKRZsWoAbxZXgugstYV2MNDvfmRlr9uyNZmTdc6jhzMTjuPfeyAH5LANhrIQqazkKBneUjYbXTigatD3ZrZoxNP1jV2YMsXtwocuNTTdfEdkaFrwhcy9EJiI24vZeLMhftmonLxvKeieLsC2beaAYxRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963529; c=relaxed/simple;
	bh=Tlcxky9hZoM6omPxcRMh25qPf7uWgJgh4PW3vNxecHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsh+Vqq93dFd7ZxHzujqmxAqnUKj6s+/JRdYoan/bIAfYfTHZhfmXKdkxdiJGHEOmMv9FxqK6SeqVS9tvDKKW93LTmCJULvLodndaPv1Q1pYfA8W7vGl7GpiFpWVNjlwZCBW1r+SC7A94fhsIxKtoXw1spdJ9OPypi1bxw0Gt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTqovntg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so7899325e9.3;
        Thu, 31 Jul 2025 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753963526; x=1754568326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8gbmgjIvdyGIa3L+Xsuq4w/naaz7U+XZEKF0r+vZX0=;
        b=MTqovntgYsm0gnD8GlPR82xEMez7blEis3ulX5akhnRLygl77kFa1z225Te7DH6faj
         Dx+nJTPomKjRUFj2wI7ewSR55CnVEN0kH7ISgxot+04ohM11D4SR4PPWQLS+X/fFgetV
         Ij7fpjTbEtgB0NcvizGeHUccd+yY5oVbexCY1dTpHmSRCjvVuMzOWEZZ0BxBD2xYyNi5
         b0NmJ0nega+HeYY1LEjXCr7C1CRLV3UDx5IZ782r1oFGEot8EnkJO/SwgXWxcMFvtLHo
         fgyMCG06pBdnx2dyvV0Omo8ckbwO9NNNSRaeKfG3hsgji0pZx5IS/do/Y11qqI6HUhwd
         7ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753963526; x=1754568326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T8gbmgjIvdyGIa3L+Xsuq4w/naaz7U+XZEKF0r+vZX0=;
        b=ZR0sXzSxqYJV6nXH7R3tPJgwV4FMMXsr588JJ0V0HBaK+Un+PaFISmYhoyZKor1B9m
         oWIbKE5vqLpM7hIvmX9IJijoHBvjkMCybv13FSbJBb+q7PpEnblNzSbU+AvYW9Lup/ML
         k2W2uP/oXS8G20M69EEVpKFYl5gT4mo/DqRZgip1Ip8BDp0ZSZBF/lQLiSRZRlQ/wzXd
         rDknVEbqfQDywSpL578RDlzsVsBhjZgZw3DyjNvECZSTB7nF2DBeDyiy8KHyMxePA0vR
         EtlEqmYfoziFmW2f0KjSIxXJ470ucCWaEieqM74Jg2gDsCwE7/5J3eBTOGXXFPD3aDP/
         I2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUtpLwMZFRiw8/MzRT3BEvEqaqNlR4ruPUQKvcShqxwo05qASYjXFdWbmXAFPtOrd2yRlw9wOUpSm3MR1U=@vger.kernel.org, AJvYcCXPGh0S3s7rtSoIy4sRTTU3rgGrCoS4Ny4cBi+aYRubwU6xzafft5xuhQfambn1Jm+wEsRGvZZ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZKywDJM+iTuyaflZG+uDgj2ni0ZqtHm2onuiQbSk3EHaw/Fp
	z4TDWFLbuxkDH9xK3Vu/i/iZ5cNMw1uQnmb70nAa9aoZVFBSyWxouTwv
X-Gm-Gg: ASbGnctbXeppsXK9D/Ds/LH1gqVE9hbqarnBAiYU1MVVSuIV7H68wlMm/wOWoFAP25U
	KdsjBfq8m2+bK/hQr10wySsBQOzO6Th+5+XhpkuxzIv1bq7FMK8iSZiXYLUCcEVpVZGNK1OLo5b
	mRBzQhrhttYHSe+HIpF8dFNZphNfUQRcqOFgmKESlTIzjMzeRs4xPcp4oc4AOIxlqD8VcR6JeGk
	SlT3x1HKhu3VdGl2js2PVuPxXPPKmDOoiHxQpMTvH9yWZDPw9nk0j241HJXoXtmLm4/ZD0lYWDt
	3EfwkD1I+D3Rht9KByUX0gvY4jml4dBeSuiAN49GgjK1T+zFJ9CxbWijgwqgnuxq7K6GKSo=
X-Google-Smtp-Source: AGHT+IFhMpnHRH9eV5Pi6xTcQsRyN4runwq7GNioMgmn5bIBUHRY+j7a2wTlL02WN7A7Ai6+KUjZmg==
X-Received: by 2002:a05:600c:638f:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-4589eeb25e2mr23577565e9.1.1753963526241;
        Thu, 31 Jul 2025 05:05:26 -0700 (PDT)
Received: from debian ([45.84.137.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f0easm24892585e9.16.2025.07.31.05.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 05:05:25 -0700 (PDT)
Message-ID: <d1f9e74d-0a69-095d-f5e8-f28f13d44e1b@gmail.com>
Date: Thu, 31 Jul 2025 14:05:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 0/4] net: add local address bind support to
 vxlan and geneve
To: Ido Schimmel <idosch@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
 daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <aHz2Y6Be3G4_P7ZM@shredder>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <aHz2Y6Be3G4_P7ZM@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Thu, Jul 17, 2025 at 01:54:08PM +0200, Richard Gobert wrote:
>> This series adds local address bind support to both vxlan
>> and geneve sockets.
> 
> A few comments:
> 
> 1. Binding the VXLAN socket to the local address does break
> functionality. Run the VXLAN selftests in tools/testing/selftests/net/
> and you will see failures. IOW, you cannot change the default behavior.
Missed the failing tests. Will be fixed in the next revision.

> You might not need the first patch if the new behavior is opt-in rather
> than opt-out.
This patch allows the localbind option to be set while the outgoing
interface is down. IMO, it is desirable.

> 
> 2. Please add a selftest for the new functionality. See the existing
> VXLAN selftests for reference. There is no need to wait for the iproute2
> patch to be accepted. You can have a check to skip the test if iproute2
> does not have the required functionality.
Do you think adding a new test that verifies that the localbind option
works would be sufficient?

> 
> 3. The cover letter should explain the motivation for these patches.
> Currently it only explains what the patches do.
Noted. Will write a better cover letter once all other issues are resolved.

