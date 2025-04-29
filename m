Return-Path: <netdev+bounces-186868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A71AA3A32
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468091BC3A04
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A971F22173C;
	Tue, 29 Apr 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwuOSV+3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C7214234
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963552; cv=none; b=XTYnNMRePb4Xmvy79hsrgr+fbjqPi1YtjmSpudfL9raorQEJL3C7ruJMXdMcvyCjLnSQ9yi9xA1P6JLxfIUsFcZqzt/xvSdmcrhXSfy3AV2c4/a2RLUf9Banp0cNg3NK9/RimMbViCDJyVecHpQjqUL5WoGPJIu99y20vt+MyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963552; c=relaxed/simple;
	bh=oE/4O2rTKrnUGitKHVq/MUr5Mpzdlv7N3Fql62gAXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKfGRTcbDj9dZ49u+uR76buMjsTO0VSXQ+3hz2VtV7Qt/KrFPXwqUoNZsGyBuA9S+uCY+JzxRHvkoLEYc2zPJQZPtJO5+iATKXV4xaYsIdMUF3Mo5Cj9EsAxAUIiugkJcJeP+cCHvclQgRcQ1kH+RKI5yi7NWnza1w6ypg7fsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwuOSV+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48974C4CEE3;
	Tue, 29 Apr 2025 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745963550;
	bh=oE/4O2rTKrnUGitKHVq/MUr5Mpzdlv7N3Fql62gAXsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwuOSV+3ec9JjSGRVs9fnv2N0SVFuwdZ6ve0FHvrToA7oGyKlLgrVtFtVlWnj4Dz4
	 B+nDSTBlTnq1Os4vrJiQw/DBhEIJvqz9l+KnUjja86VHo8k3D1c3n4mhIlYpJbXXqD
	 3JmDnNT4zPMKXXCGKLQUdlYBR3bGOHmrYAydf6t+BBKQ0WMYMZWV6tQv6d5CYv9Jm3
	 XcncbfHiSMqqOCZ8nGfHZavaI1tJEthLRQkKBd7JSwbLawwRtSxlXuw+YSXdlO9y8O
	 ySN/T5uexLgInP0TQZaGns5WT6olPbNU3Em3s0J0HV2ZscfWmod14pYsofoSxzxmil
	 wZSqs8x3RJcIQ==
Date: Tue, 29 Apr 2025 14:52:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
 <milena.olech@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jacob.e.keller@intel.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Message-ID: <20250429145229.67ee90ea@kernel.org>
In-Reply-To: <17fe4f5a-d9ad-41bc-b43a-71cbdab53eea@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250428173906.37441022@kernel.org>
	<17fe4f5a-d9ad-41bc-b43a-71cbdab53eea@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 14:41:30 -0700 Tony Nguyen wrote:
> On 4/28/2025 5:39 PM, Jakub Kicinski wrote:
> > On Fri, 25 Apr 2025 14:52:14 -0700 Tony Nguyen wrote:  
> >>   18 files changed, 2933 insertions(+), 103 deletions(-)  
> > 
> > This is still huge. I'd appreciate if you could leave some stuff out
> > and make the series smaller.  
> 
> The obvious stuff that jumps out to me that can be moved out 
> easily/logically doesn't save that many lines but, perhaps, Milena has 
> some other ideas.

Right, nothing too obvious, maybe cross timestmaping. But it takes 
me 30min to just read the code, before I start finding bugs I have 
to switch to doing something else:(

It's not a deal breaker, but I keep trickling in review comments 2 
at a time, please don't blame me, I'm doing my best :)

