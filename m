Return-Path: <netdev+bounces-58165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F5815640
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88694286331
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C215AF;
	Sat, 16 Dec 2023 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsrQqsRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D127480
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C06C433CA;
	Sat, 16 Dec 2023 02:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692364;
	bh=X5C3Iuw2k00/9aCV1KxgIfb/FX2ycvKgSf1Kj1FSpAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsrQqsRcxgTCfV/EhvmTKeAsQcKlMwBxkAuaYtb+TDGRbEgP9Fkqa6hweo4vWpvZe
	 pa/Mcq8Ocx6ioW8gc7n5D4sS8wH/4T+MRFzi8wQpFttd3WZOb7xkt6phaYTStkLmHT
	 DsjacuGNSh4JpKp8z2WzBOr5Bms/pJ/fuvx+T3Dp+3SI4itUbGiILmordGq1Kqj0MQ
	 Uq883cSPc+TFjVri5KPjdFLrau9LvWxfzjenP5MxUt3Jd2qDeyNPA+AtPp0fAbcmQ5
	 pACzuGi5cIw33556jaCMSFf8+8dHtWQIJetRm6HRwFLLZkZegUG0F0nL8X8TjOCOhO
	 JqL8LDWClRCBA==
Date: Fri, 15 Dec 2023 18:06:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: use correct len for string
 and binary
Message-ID: <20231215180603.576748b1@kernel.org>
In-Reply-To: <20231215035009.498049-2-liuhangbin@gmail.com>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
	<20231215035009.498049-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:50:07 +0800 Hangbin Liu wrote:
> As the description of 'struct nla_policy', the len means the maximum length
> of string, binary. Or minimum length of attribute payload for others.
> But most time we only use it for string and binary.

The meaning of 'len' in nla_policy is confusing to people writing new
families. IIRC I used max-len / min-len / extact-len and not len on
purpose in the YAML, so that there's no confusion what means what for
which type...

Obviously it is slightly confusing for people like you who convert
the existing families to YAML specs, but the risk of bugs seems lower
there. So I'd prefer to stick to the existing set of options.

Is the existing code gen incorrect or just hard to wrap one's head
around?


