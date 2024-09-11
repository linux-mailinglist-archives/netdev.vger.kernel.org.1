Return-Path: <netdev+bounces-127522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB35975A8B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16581C22CD1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6E1B9B2A;
	Wed, 11 Sep 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS9AgB9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EA1B86D0
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080494; cv=none; b=QNkiI8Hhm2inQXoohjT7lGC/vGU+qZa80XaRgxvBx0vCPgedHvrPYewifofkToTrfiCPmKjGJ1m3TFVPnQhUqyvBiqWs5su7y2uKRLQ0saZkJtK/o7j8ZHpmFo0n+6Yc8i5IaJAeqX+Ae9Bsowy3BhCaa0YKm+q15RL3PLpL5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080494; c=relaxed/simple;
	bh=datdQcGnXU8CAjhYAqQ1jWYr8xDEAHix4QtylGZtI8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sX3isooug+C3EL9un6VGa2XgfRCHk/FEpuHsGrlOdKcg0OyEQA+8OeSYf5pTkzxMUefjn5w+CEg0QSyHQO8MwQA7OGRMHqvQ7ET4oqOr50h3zzmcnaW2XnmSEV3OwhQVVW7VxaLSpBcV7XcXEMke/ViXRCG9Wp/AlzLPnTBp55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS9AgB9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAC0C4CEC7;
	Wed, 11 Sep 2024 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726080494;
	bh=datdQcGnXU8CAjhYAqQ1jWYr8xDEAHix4QtylGZtI8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VS9AgB9hQKkVvwmaubelmdJ0ZT7Mj5zuosgPG0DxUEwnNvn7nul31Gu0YttDaaptz
	 x+6dyHHbD75L3POHvT2K4HH8UaZ1GIVd+q0m66wZG7AahIVK/GcG/Fw9TKe92H9mM2
	 o4RRX2fOvs4u2d5K2dU3XHf5h9iWmsk5mKHJ6/1oWTF4NFpSrKfKhhdd0QzMSL2H/a
	 6Hm1p/EROLadPj3m8IgD33F1O83t0aR8MQPnGg6DOxDJMmTY5Y/I7m1PqDPo70Iegw
	 6eIvd13Mf7LznTyMYG6EiFPgUmuR+t0H/wpxQwX8cWJeqs0FoAkkOnpebTSBYnrnpl
	 ZK1grekKk+b5w==
Date: Wed, 11 Sep 2024 11:48:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, David Ahern
 <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] eth: fbnic: add software TX timestamping
 support
Message-ID: <20240911114812.48a29fc2@kernel.org>
In-Reply-To: <20240911124513.2691688-2-vadfed@meta.com>
References: <20240911124513.2691688-1-vadfed@meta.com>
	<20240911124513.2691688-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 05:45:09 -0700 Vadim Fedorenko wrote:
> +	tsinfo->so_timstamping =

typo in the name here

