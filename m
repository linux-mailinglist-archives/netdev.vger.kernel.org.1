Return-Path: <netdev+bounces-172539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1337A554C8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177453A56E1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0069D26B0A9;
	Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejn89qlN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EA25D914
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285104; cv=none; b=nmaldXdpmBWAxTJbiYy7QVh/jFJvH7mW3f+dws17KeZ3gLdAfgUhVGST7Yg7W9Ljy/cz/FNCh5Ad8qK9sa8UTnmeWKB+3qE5y6jXfWpLYB0Po8j2Zk+PUGd1efNqwFHdURYjJw0iueqKpdkZJXR/8ekv7wMkvtYvd4xq+G2gSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285104; c=relaxed/simple;
	bh=NI2nMMuG5HF1v6r5TEd6Xe1TzAZ11OMN6z0zMPV936U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHzkmXMj73HC9nxbbGqfPsxnErmyMbOHOtUook1l4AnsS5ay3ESlQfmdFt6+/OMe36kdLmYJb9JwKjKt/W/iEFrbLBZvMZM0V++qo145LzJHGooOyqUzPy0MUymsIgMDm2ABaGLBJgHaW++Xbufl2zatFCz7hiJa/gxI7NvqBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejn89qlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E76DC4CEEB;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741285104;
	bh=NI2nMMuG5HF1v6r5TEd6Xe1TzAZ11OMN6z0zMPV936U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejn89qlNMXjoP2ViUiLfSaOn78jE+HVyhOyzvUqpHY3QBRTmueIpbyx95SOzckKsk
	 ffydeNGT4PjB+Wyr1U7i2+ZkoopC5fdHeiCy78b0+mpaSpyKuxORhW7uzSZ2tpnbYC
	 gSt6sz+l4urI8NIvpSw3NLZmGpDcNUx8OhqSNB/3kaGaP4ZaM1+HcEwbdYiDrEw6o2
	 H4J4P4BYGx1JNKk4Txxakk9GPuMkUBJ5wOOzSzKy5BbnlCySdUxXhBwi2HLB6dhoCy
	 +Fv+xfLYC3FzuiZ4O/WB6QqUB9etPi0lVU4euO2msA13MdBzdzLVA4M7AS0xD84JL1
	 41NWhok2A3ngw==
Date: Thu, 6 Mar 2025 10:18:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Message-ID: <20250306101823.416efa9d@kernel.org>
In-Reply-To: <ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-2-allison.henderson@oracle.com>
	<20250228161908.3d7c997c@kernel.org>
	<b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	<20250304164412.24f4f23a@kernel.org>
	<ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 16:41:35 +0000 Allison Henderson wrote:
> I think it's to make sure the clearing of the bit is the last
> operation done for the calling function, in this case
> rds_queue_reconnect.  The purpose of the barrier in test_and_set is
> to make sure the bit is checked before proceeding to any further
> operations (in our case queuing reconnect items).

Let's be precise, can you give an example of 2 execution threads
and memory accesses which have to be ordered.

