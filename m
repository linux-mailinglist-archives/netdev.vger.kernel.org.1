Return-Path: <netdev+bounces-242492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83CC90B0E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE893AA554
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CBC2857CD;
	Fri, 28 Nov 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+GFelik"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B34285419
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298751; cv=none; b=NagV+u/0P9SxxVlsZoHZUFJXHoJnJ3RzmlU3qC0kieROH5OOphuRNyaYB8e0WEB/w5Q6lOS8/HV60pzWoizS2L5ZpweaGrmTkTe2W0Rq1YBJt8nh3k//OGUQpbwkP0mlHpnOM45AG1HSWyHNlBEAFPCEOb/wMUdkEsOf2SDu3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298751; c=relaxed/simple;
	bh=oZBkU4oPShidOgYVO9sMfAy3F6wmjWVN1bvs8noNr9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIrR4NxwYEA/UiEx238a48cGdtm+wVgCHQbuWjOw8Npm1HU6OA5kToUi1VHRGnQXJJetmEdik3SU3rknDpfFnUEXEL44Ze9RON536rOVmHfwksfSgCYkUONtg3kAO28ivTFQODvxEHHnYUB9ynZh6ZWwj1ixyqmXQ7jo95WHrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+GFelik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B70AC4CEF8;
	Fri, 28 Nov 2025 02:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298751;
	bh=oZBkU4oPShidOgYVO9sMfAy3F6wmjWVN1bvs8noNr9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N+GFelikCckdHwbFQAv6UiYkE+d25boDLXwLhebnN1VbMLbKkUVj9oVFRJcp0sh0m
	 vx/aRVCzO753738fJA5nLt2KVAo53aLRxMzpUOeCDR9elJfVDwdmafMGm+91l898A6
	 r/z6nyc12cOAOeLpNLIY5lRhyTA5NqXTnbf9rhkSvfDkq/0X+DxnK9AzB1AjAXEMXV
	 rwMBN4Qku6K5UCNmScroEeH/uFRKnVj8q/AiJxkP9KKdrjtOXL7frIC+yUgYOMz7ZE
	 3ooHlE7bYTNzkveR7tq+yLcFUYsRO72gFdq6p62l7erGLwlwZw7N2RGG3YWZIJS3DK
	 EHfchjyAjXD4w==
Date: Thu, 27 Nov 2025 18:59:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 7/7] bnxt_en: Add PTP .getcrosststamp()
 interface to get device/host times
Message-ID: <20251127185909.3bbb5da4@kernel.org>
In-Reply-To: <20251126215648.1885936-8-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
	<20251126215648.1885936-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 13:56:48 -0800 Michael Chan wrote:
> +	ptm_local_ts = le64_to_cpu(resp->ptm_local_ts);
> +	*device = ns_to_ktime(bnxt_timecounter_cyc2time(ptp, ptm_local_ts));
> +	/* ptm_system_ts is 64-bit */
> +	system->cycles = le64_to_cpu(resp->ptm_system_ts);
> +	system->cs_id = CSID_X86_ART;
> +	system->use_nsecs = true;

Non-x86 hosts exist? Also, I'd like to give Vadim F a chance to TAL
and he's out for the rest of the week. So perhaps we can hold this
one off until after the MW?

I'll apply up to this point in the meantime.

